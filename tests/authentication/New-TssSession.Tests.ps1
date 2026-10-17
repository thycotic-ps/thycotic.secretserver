BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'SecretServer', 'Credential', 'OtpCode', 'AccessToken', 'UseWindowsAuth', 'UseSdkClient', 'ConfigPath', 'SkipCertificateCheck', 'PlatformUrl', 'VaultId', 'AllowedVaultHost', 'AutoRefresh'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -ForEach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
    }
    Context "Verify parameter sets" {
        BeforeDiscovery {
            [object[]]$parameterSets = @(
                @{ CommandName = $commandName; Name = 'new'; Expected = 'Credential:1:True OtpCode:2:False SecretServer:0:True SkipCertificateCheck:named:False' }
                @{ CommandName = $commandName; Name = 'sdk'; Expected = 'AccessToken:named:True SecretServer:0:True SkipCertificateCheck:named:False' }
                @{ CommandName = $commandName; Name = 'winauth'; Expected = 'SecretServer:0:True SkipCertificateCheck:named:False UseWindowsAuth:named:True' }
                @{ CommandName = $commandName; Name = 'clientSdk'; Expected = 'ConfigPath:named:True SecretServer:named:True SkipCertificateCheck:named:False UseSdkClient:named:True' }
                @{ CommandName = $commandName; Name = 'platform'; Expected = 'AllowedVaultHost:named:False AutoRefresh:named:False Credential:named:True PlatformUrl:named:True SecretServer:named:False SkipCertificateCheck:named:False VaultId:named:False' }
                @{ CommandName = $commandName; Name = 'platformToken'; Expected = 'AccessToken:named:True AllowedVaultHost:named:False PlatformUrl:named:True SecretServer:named:False SkipCertificateCheck:named:False VaultId:named:False' }
            )
        }
        It "$commandName should have exactly the parameter sets new, sdk, winauth, clientSdk, platform, platformToken" -TestCases @{ CommandName = $commandName } {
            $names = (Get-Command $CommandName).ParameterSets.Name | Sort-Object
            $names -join ' ' | Should -BeExactly 'clientSdk new platform platformToken sdk winauth'
        }
        It "$commandName parameter set <Name> should have parameters <Expected>" -TestCases $parameterSets {
            $common = [Management.Automation.PSCmdlet]::CommonParameters + [Management.Automation.PSCmdlet]::OptionalCommonParameters
            $set = (Get-Command $CommandName).ParameterSets | Where-Object Name -CEQ $Name
            $actual = $set.Parameters | Where-Object Name -NotIn $common | Sort-Object Name | ForEach-Object {
                $position = if ($_.Position -eq [int]::MinValue) { 'named' } else { $_.Position }
                '{0}:{1}:{2}' -f $_.Name, $position, $_.IsMandatory
            }
            $actual -join ' ' | Should -BeExactly $Expected
        }
    }
}