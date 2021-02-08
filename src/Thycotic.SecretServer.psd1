@{
    ModuleVersion = '0.28.0'
    CompatiblePSEditions = 'Desktop', 'Core'
    FormatsToProcess = 'Thycotic.SecretServer.Format.ps1xml'
    TypesToProcess = 'Thycotic.SecretServer.Types.ps1xml'
    RootModule = 'Thycotic.SecretServer.psm1'
    Description = 'PowerShell Tools for Thycotic Secret Server'
    Guid = 'e6b56c5f-41ac-4ba4-8b88-2c063f683176'
    Author = 'Shawn Melton'
    CompanyName = 'Thycotic'
    Copyright = '(c) Thycotic Professional Services. All rights reserved.'
    PowerShellVersion ='5.1'
    PrivateData = @{
        PSData = @{
            PreRelease = 'beta'
            Tags = 'SecretServer', 'Thycotic', 'DevOps', 'Security'
            IconUri = 'https://updates.thycotic.net/proservices/powershell/tss_module/thycotic.secretserver_logo.png'
            ProjectURI = 'https://github.com/thycotic-ps/thycotic.secretserver'
            LicenseURI = 'https://github.com/thycotic-ps/thycotic.secretserver/blob/master/LICENSE'
            ReleaseNotes = 'https://github.com/thycotic-ps/thycotic.secretserver/blob/master/CHANGELOG.md'
        }
    }
    DefaultCommandPrefix = 'Tss'
}