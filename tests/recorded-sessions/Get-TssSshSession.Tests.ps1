BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'AuditSecretId', 'ByteLimit', 'FilterType', 'SearchTerm', 'SecretSessionId', 'SecretSessionKey', 'SessionGuid'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('AuditSecretId', 'ByteLimit', 'FilterType', 'SearchTerm', 'SecretSessionId', 'SecretSessionKey', 'SessionGuid'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.RecordedSessions.SshSession" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.RecordedSessions.SshSession'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take AuditSecretId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['AuditSecretId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take ByteLimit as System.Int64" -TestCases $commandDetails {
            $_.Parameters['ByteLimit'].ParameterType.FullName | Should -Be 'System.Int64'
        }
        It "$commandName should take FilterType as System.String" -TestCases $commandDetails {
            $_.Parameters['FilterType'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SearchTerm as System.String" -TestCases $commandDetails {
            $_.Parameters['SearchTerm'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SecretSessionId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretSessionId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretSessionKey as System.String" -TestCases $commandDetails {
            $_.Parameters['SecretSessionKey'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take SessionGuid as System.String" -TestCases $commandDetails {
            $_.Parameters['SessionGuid'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should limit FilterType to Both,Client,Server" -TestCases $commandDetails {
            (($_.Parameters['FilterType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Both,Client,Server' -split ',') | Sort-Object) -join ',')
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take SecretSessionId from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['SecretSessionId'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should bind TssSession at position 0" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }).Position | Should -Contain 0
        }
        It "$commandName pipeline/output type Thycotic.PowerShell.RecordedSessions.SshSession should expose SecretSessionId as System.Int32" {
            ([type]'Thycotic.PowerShell.RecordedSessions.SshSession').GetProperty('SecretSessionId').PropertyType.FullName | Should -Be 'System.Int32'
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
