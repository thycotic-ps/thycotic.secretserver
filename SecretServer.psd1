@{
    ModuleVersion = '0.2.0'
    RootModule = 'SecretServer.psm1'
    Description = 'PowerShell Tools for Thycotic Secret Server'
    Guid = 'e6b56c5f-41ac-4ba4-8b88-2c063f683176'
    PrivateData = @{
        PSData = @{
            Tags = 'SecretServer', 'Thycotic', 'DevOps'
            ProjectURI = 'https://thycotic.com/products/secret-server/'
            LicenseURI = ''
            ReleaseNotes = @'
0.2 :
---
* Added Invoke-TssRestApi
* Added New-TssSession
0.1 :
---
Initial Commit
'@
        }
    }
    Author = 'Shawn Melton'
    Copyright = '2020 Thycotic Secret Server'
    PowerShellVersion ='5.1'
}