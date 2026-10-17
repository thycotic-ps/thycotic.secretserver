BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'FromEmailAddress', 'FromEmailName', 'SendEmailAppRegistrationSecretId', 'SendEmailMethod', 'SmtpCheckCertificateRevocation', 'SmtpDomain', 'SmtpPassword', 'SmtpPort', 'SmtpServer', 'SmtpUseCredentials', 'SmtpUseImplicitSSL', 'SmtpUserName', 'SmtpUseSSL'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('FromEmailAddress', 'FromEmailName', 'SendEmailAppRegistrationSecretId', 'SendEmailMethod', 'SmtpCheckCertificateRevocation', 'SmtpDomain', 'SmtpPassword', 'SmtpPort', 'SmtpServer', 'SmtpUseCredentials', 'SmtpUseImplicitSSL', 'SmtpUserName', 'SmtpUseSSL'); Absent = @() }
        )
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.EmailConfiguration" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.EmailConfiguration'
        }
        It "$commandName should support ShouldProcess" -TestCases $commandDetails {
            $_.Parameters.ContainsKey('WhatIf') | Should -Be $true
        }
        It "$commandName should set ConfirmImpact to Medium" -TestCases $commandDetails {
            ($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }).ConfirmImpact | Should -Be 'Medium'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take FromEmailAddress as System.String" -TestCases $commandDetails {
            $_.Parameters['FromEmailAddress'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take FromEmailName as System.String" -TestCases $commandDetails {
            $_.Parameters['FromEmailName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SendEmailAppRegistrationSecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SendEmailAppRegistrationSecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SendEmailMethod as System.String" -TestCases $commandDetails {
            $_.Parameters['SendEmailMethod'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SmtpCheckCertificateRevocation as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SmtpCheckCertificateRevocation'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SmtpDomain as System.String" -TestCases $commandDetails {
            $_.Parameters['SmtpDomain'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SmtpPassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['SmtpPassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take SmtpPort as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SmtpPort'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SmtpServer as System.String" -TestCases $commandDetails {
            $_.Parameters['SmtpServer'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SmtpUseCredentials as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SmtpUseCredentials'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SmtpUseImplicitSSL as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SmtpUseImplicitSSL'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SmtpUserName as System.String" -TestCases $commandDetails {
            $_.Parameters['SmtpUserName'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SmtpUseSSL as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SmtpUseSSL'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should limit SendEmailMethod to Smtp,O365" -TestCases $commandDetails {
            (($_.Parameters['SendEmailMethod'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Smtp,O365' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
    }
    Context "Parameter set <SetName>" -Foreach $setCases {
        BeforeAll {
            $set = (Get-Command $CommandName).ParameterSets.Where({ $_.Name -eq $SetName })[0]
        }
        It "should exist" {
            $set | Should -Not -BeNullOrEmpty
        }
        It "should require exactly <Mandatory>" {
            $actual = $set.Parameters.Where({ $_.IsMandatory }).Name | Sort-Object
            ($actual -join ',') | Should -BeExactly (($Mandatory | Sort-Object) -join ',')
        }
        It "should have exactly <Optional> as optional" {
            $common = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
            $actual = $set.Parameters.Where({ -not $_.IsMandatory -and $_.Name -notin $common }).Name | Sort-Object
            ($actual -join ',') | Should -BeExactly (($Optional | Sort-Object) -join ',')
        }
        It "should not offer <Absent>" {
            foreach ($name in $Absent) {
                $set.Parameters.Name | Should -Not -Contain $name
            }
        }
    }
}
