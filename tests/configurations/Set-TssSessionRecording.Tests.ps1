BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ArchiveLocationBySite', 'ArchivePath', 'ArchivePathMappings', 'DaysUntilArchive', 'DaysUntilDelete', 'EnableArchive', 'EnableDelete', 'EnableHardwareAcceleration', 'EnableInactivityTimeout', 'EnableOnDemandVideoProcessing', 'EnableSessionRecording', 'EncryptArchive', 'HideRecordingIndicator', 'InactivityTimeoutMinutes', 'MaxSessionLength', 'RdpProxyRecordKeyStrokes', 'RdpProxyRecordVideo', 'SshProxyRecordKeyStrokes', 'SshProxyRecordVideo', 'StoreInDatabase', 'UseTemporaryArchives', 'VideoCodecId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = '__AllParameterSets'; Mandatory = @('TssSession'); Optional = @('ArchiveLocationBySite', 'ArchivePath', 'ArchivePathMappings', 'DaysUntilArchive', 'DaysUntilDelete', 'EnableArchive', 'EnableDelete', 'EnableHardwareAcceleration', 'EnableInactivityTimeout', 'EnableOnDemandVideoProcessing', 'EnableSessionRecording', 'EncryptArchive', 'HideRecordingIndicator', 'InactivityTimeoutMinutes', 'MaxSessionLength', 'RdpProxyRecordKeyStrokes', 'RdpProxyRecordVideo', 'SshProxyRecordKeyStrokes', 'SshProxyRecordVideo', 'StoreInDatabase', 'UseTemporaryArchives', 'VideoCodecId'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Configuration.SessionRecording" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Configuration.SessionRecording'
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
        It "$commandName should take ArchiveLocationBySite as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['ArchiveLocationBySite'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take ArchivePath as System.String" -TestCases $commandDetails {
            $_.Parameters['ArchivePath'].ParameterType.FullName | Should -Be 'System.String'
        }
        It "$commandName should take ArchivePathMappings as System.Object[]" -TestCases $commandDetails {
            $_.Parameters['ArchivePathMappings'].ParameterType.FullName | Should -Be 'System.Object[]'
        }
        It "$commandName should take DaysUntilArchive as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DaysUntilArchive'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take DaysUntilDelete as System.Int32" -TestCases $commandDetails {
            $_.Parameters['DaysUntilDelete'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take EnableArchive as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableArchive'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableDelete as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableDelete'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableHardwareAcceleration as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableHardwareAcceleration'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableInactivityTimeout as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableInactivityTimeout'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableOnDemandVideoProcessing as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableOnDemandVideoProcessing'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EnableSessionRecording as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EnableSessionRecording'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take EncryptArchive as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['EncryptArchive'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take HideRecordingIndicator as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['HideRecordingIndicator'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take InactivityTimeoutMinutes as System.Int32" -TestCases $commandDetails {
            $_.Parameters['InactivityTimeoutMinutes'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take MaxSessionLength as System.Int32" -TestCases $commandDetails {
            $_.Parameters['MaxSessionLength'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take RdpProxyRecordKeyStrokes as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['RdpProxyRecordKeyStrokes'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take RdpProxyRecordVideo as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['RdpProxyRecordVideo'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SshProxyRecordKeyStrokes as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SshProxyRecordKeyStrokes'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take SshProxyRecordVideo as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['SshProxyRecordVideo'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take StoreInDatabase as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['StoreInDatabase'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take UseTemporaryArchives as System.Management.Automation.SwitchParameter" -TestCases $commandDetails {
            $_.Parameters['UseTemporaryArchives'].ParameterType.FullName | Should -Be 'System.Management.Automation.SwitchParameter'
        }
        It "$commandName should take VideoCodecId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['VideoCodecId'].ParameterType.FullName | Should -Be 'System.Int32'
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
