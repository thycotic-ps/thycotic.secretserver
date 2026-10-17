BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'SecretSessionId', 'SecretSessionKey', 'LauncherSessionGuid', 'ImageId', 'Output'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'id'; Mandatory = @('TssSession', 'SecretSessionId', 'Output'); Optional = @('ImageId'); Absent = @('SecretSessionKey', 'LauncherSessionGuid') }
            @{ CommandName = $commandName; SetName = 'key'; Mandatory = @('TssSession', 'SecretSessionKey', 'Output'); Optional = @('ImageId'); Absent = @('SecretSessionId', 'LauncherSessionGuid') }
            @{ CommandName = $commandName; SetName = 'guid'; Mandatory = @('TssSession', 'LauncherSessionGuid', 'Output'); Optional = @('ImageId'); Absent = @('SecretSessionId', 'SecretSessionKey') }
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
        It "$commandName should set OutputType to System.IO.FileInfo" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'System.IO.FileInfo'
        }
        It "$commandName should default to the id parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'id'
        }
        It "$commandName should take TssSession as Thycotic.PowerShell.Authentication.Session" -TestCases $commandDetails {
            $_.Parameters['TssSession'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Authentication.Session'
        }
        It "$commandName should take SecretSessionId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SecretSessionId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take SecretSessionKey as System.String" -TestCases $commandDetails {
            $_.Parameters['SecretSessionKey'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take LauncherSessionGuid as System.Guid" -TestCases $commandDetails {
            $_.Parameters['LauncherSessionGuid'].ParameterType.FullName | Should -Be 'System.Guid'
        }
        It "$commandName should take ImageId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['ImageId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take Output as System.String" -TestCases $commandDetails {
            $_.Parameters['Output'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take TssSession from the pipeline (ValueFromPipeline)" -TestCases $commandDetails {
            @($_.Parameters['TssSession'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipeline }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take SecretSessionId from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['SecretSessionId'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take LauncherSessionGuid from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['LauncherSessionGuid'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
        }
        It "$commandName should take ImageId from the pipeline (ValueFromPipelineByPropertyName)" -TestCases $commandDetails {
            @($_.Parameters['ImageId'].Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] -and $_.ValueFromPipelineByPropertyName }).Count | Should -BeGreaterThan 0
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
