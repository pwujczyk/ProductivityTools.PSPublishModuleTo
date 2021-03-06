#
# Module manifest for module 'module'
#
# Generated by: pwujczyk
#
# Generated on: 1/2/2019 1:16:38 PM
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'ProductivityTools.PublishModuleTo.psm1'

# Version number of this module.
ModuleVersion = '0.0.11'

# ID used to uniquely identify this module
GUID = '0b1d43ab-1916-4bea-9956-0096d3b91215'

# Author of this module
Author = 'Paweł Wujczyk'

# Description of the functionality provided by this module
Description = 'It automates pubishing module to chosen module gallery by providing automatically nuget API key from Master Configuration'

# Functions to export from this module
FunctionsToExport = 'Publish-ModuleTo'

# HelpInfo URI of this module
HelpInfoURI = 'http://www.productivitytools.tech/publish-moduleto/'

PrivateData = @{
    
    PSData = @{
        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('Publish','Module')
    
        # A URL to the main website for this project.
        ProjectUri = 'http://productivitytools.tech/publish-moduleto/'

        # A URL to an icon representing this module.
        IconUri = 'http://cdn.productivitytools.tech/images/PT/ProductivityTools_blue_85px_3.png'
        } # End of PSData hashtable
    } # End of PrivateData hashtable   
}
