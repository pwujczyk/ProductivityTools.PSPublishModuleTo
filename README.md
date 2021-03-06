<!--Category:Powershell--> 
 <p align="right">
    <a href="https://www.powershellgallery.com/packages/ProductivityTools.PSPublishModuleTo/"><img src="Images/Header/Powershell_border_40px.png" /></a>
    <a href="http://productivitytools.tech/publish-moduleto/"><img src="Images/Header/ProductivityTools_green_40px_2.png" /><a> 
    <a href="https://github.com/pwujczyk/ProductivityTools.PSPublishModuleTo"><img src="Images/Header/Github_border_40px.png" /></a>
</p>
<p align="center">
    <a href="http://productivitytools.tech/">
        <img src="Images/Header/LogoTitle_green_500px.png" />
    </a>
</p>

# Publish module to

Module helps to publish module to PowerShell gallery for binary and script modules.
<!--more-->

Publishing module to PowerShell gallery is very straight-forward task. To do it we just need to invoke command

```powershell
Publish-Module -NuGetApiKey $nuGetApiKey -Name $fullPath
```

If we are pushing to different repository than default, we also can provide **PSRepostiory** parameter

```powershell
Publish-Module -PSRepository $psRepository -NuGetApiKey $nuGetApiKey -Name $fullPath
```
As I am publishing a lot I automated this repeatable task. Described module allows to be invoked in the directory of the module without pointing out exact psd1 file. Cmdlet will find it and process.

If a target module is binary one it will rebuild application and publish the newest version.

Also the **Publish-ModuleTo** allows to use **UpdateModuleVersion** switch, which will increase patch number (z in  X.Y.Z).

This module is base for other, more specific one. Please check out [Publish-ModuleToPowershellGallery](http://productivitytools.tech/publish-moduletopowershellgallery/)

## Examples 

Go to the directory of the module and invoke
```powershell
Publish-ModuleTo -PSRepository PSGallery -NuGetApiKey $nuGetApiKey 

Publish-ModuleTo -PSRepository PSGallery -NuGetApiKey $nuGetApiKey  -Verbose -IncreaseModuleVersion
```

## Switches
- IncreaseModuleVersion - it will increase patch number in the target module
- PSRepository - name of the repository where to put module. You could get all your repositories with **Get-PSRepository** cmdlet. By default here is inserted PSGallery so you can omit it if you have default configuration
- NuGetApiKey - your key which should be taken from profile on www.powershellgallery.com site

## Diagram
<!--og-image-->
![Diagram](Images/Diagram.png)
