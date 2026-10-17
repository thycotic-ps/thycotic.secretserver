BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'FolderId', 'ExportChildFolders', 'ExportFolderPath', 'ExportTemplateName', 'ExportTotp', 'FileType', 'Notes', 'Password', 'DoubleLockPassword', 'Job'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'Default'; Mandatory = @('TssSession', 'FolderId', 'Password'); Optional = @('ExportChildFolders', 'ExportFolderPath', 'ExportTemplateName', 'ExportTotp', 'FileType', 'Notes', 'DoubleLockPassword'); Absent = @('Job') }
            @{ CommandName = $commandName; SetName = 'Job'; Mandatory = @('TssSession', 'FolderId', 'Password', 'Job'); Optional = @('ExportChildFolders', 'ExportFolderPath', 'ExportTemplateName', 'ExportTotp', 'FileType', 'Notes', 'DoubleLockPassword'); Absent = @() }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Secrets.BulkExport" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Secrets.BulkExport'
        }
        It "$commandName should default to the Default parameter set" -TestCases $commandDetails {
            $_.DefaultParameterSet | Should -Be 'Default'
        }
        It "$commandName should take Password as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['Password'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should take DoubleLockPassword as System.Security.SecureString" -TestCases $commandDetails {
            $_.Parameters['DoubleLockPassword'].ParameterType.FullName | Should -Be 'System.Security.SecureString'
        }
        It "$commandName should limit FileType to Csv,Xml" -TestCases $commandDetails {
            (($_.Parameters['FileType'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }).ValidValues | Sort-Object) -join ',' | Should -BeExactly ((('Csv,Xml' -split ',') | Sort-Object) -join ',')
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
