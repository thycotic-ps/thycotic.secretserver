@{
    ModuleVersion = '0.3.0'
    RootModule = 'SecretServer.psm1'
    Description = 'PowerShell Tools for Thycotic Secret Server'
    Guid = 'e6b56c5f-41ac-4ba4-8b88-2c063f683176'
    PrivateData = @{
        PSData = @{
            Tags = 'SecretServer', 'Thycotic', 'DevOps'
            ProjectURI = 'https://thycotic.com/products/professional-services-training/'
            LicenseURI = ''
            ReleaseNotes = @"
0.4 :
---
* Added Find-TssSecret
0.3 :
---
* Enhancement to New-TssSession (parameter and session validating)
0.2 :
---
* Added Invoke-TssRestApi
* Added New-TssSession
0.1 :
---
Initial Commit
"@
        }
    }
    Author = 'Shawn Melton'
    Copyright = '2020 Thycotic Professional Services'
    PowerShellVersion ='5.1'
}