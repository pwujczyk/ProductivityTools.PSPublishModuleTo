function UpdateModuleVersion{
	[Cmdletbinding()]
	param(
		[string]$psd1Path
	)
	
	$psd1=Get-Content $psd1Path
	[version]$Version = [regex]::matches($psd1, "\s*ModuleVersion\s=\s'(\d*.\d*.\d*)'\s*").groups[1].value
	Write-Verbose "Old Version - $Version"
	[version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1)
	Write-Verbose "New Version - $NewVersion"
	$psd1 -replace $version, $NewVersion | Out-File $psd1Path -Force
}

function GetTypeOfModule{
     [Cmdletbinding()]
	param(
		[string]$psd1FullName
	)
	$psd1= Get-Content $psd1FullName -Raw
	$rootModule = [regex]::matches($psd1, "\s*RootModule\s=\s'(.*)'\s*")
	$rootModuleName=$rootModule.groups[1].value
	if($rootModuleName.EndsWith('.dll'))
	{
		return "binary"
	}
	
	if($rootModuleName.EndsWith('.psm1'))
	{
		return "text"
	}
	
	throw "In the Root module no dll nor psm1 type is defined"	
}

function Buildapplication{
	[Cmdletbinding()]
	param()
	dotnet pack
}

function Publish-ModuleTo{
	[Cmdletbinding()]
	param(
		[string]$PSRepositoryName="PSGallery", #PSGallery, PawelGallery
		[string]$NuGetApiKey,
		[switch]$IncreaseModuleVersion 
	)	

	$psd1s=@(Get-ChildItem -Recurse "*.psd1") 

	Write-Verbose "Found $($psd1s.Length) module manifests"

	foreach($psd1 in $psd1s)
	{
		$psd1FullName=$psd1.FullName
		Write-Verbose "File analyzed $($psd1FullName)"
		if ($psd1FullName.Contains("bin")) {
			Write-Verbose "File in the bin directory, we are interested in the publish, so ommiting this";
			continue
		}

		$moduleType=GetTypeOfModule $psd1FullName
		if($IncreaseModuleVersion.IsPresent)
		{
			Write-Verbose "Update Module Version"
			UpdateModuleVersion $psd1FullName
		}
		
		
		if ($moduleType -eq "binary")
		{
			Write-Verbose "Binary module, so building the app"
			Buildapplication
			$psd1sForBin=@(Get-ChildItem -Recurse "*.psd1") 
			$binPsd1=$psd1sForBin |where {$_.DirectoryName -like "*bin*" -and $_.Name -eq $psd1.Name}
			$psd1ToBePublished=$binPsd1
			Write-Verbose "Binary module to be published (psd1ToBePublished) $($psd1ToBePublished)"
		}
		
		if ($moduleType -eq "text")
		{
			$psd1ToBePublished=$psd1FullName
			Write-Verbose "psm1 module to be published $($psd1ToBePublished)"
		}

		Write-Verbose "Checkint the type of the psd1ToBePublished"
		$psd1ToBePublished.GetType();

		Write-Verbose "Publish $psd1ToBePublished"
		Write-Verbose "PSRepository: $PSRepositoryName"
		Write-Verbose "NuGetApiKey: $NuGetApiKey"
		Publish-Module -Repository $PSRepositoryName -NuGetApiKey $NuGetApiKey -Name $psd1ToBePublished  -Verbose:$VerbosePreference
	}
}

Export-ModuleMember Publish-ModuleTo