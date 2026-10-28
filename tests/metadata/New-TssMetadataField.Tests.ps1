BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ItemId', 'ItemType', 'SectionId', 'SectionName', 'SectionDescription', 'FieldName', 'FieldDataType', 'FieldValue', 'RequireAdminister', 'RequireItemEdit'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
        $setCases = @(
            @{ CommandName = $commandName; SetName = 'currentsection'; Mandatory = @('TssSession', 'ItemId', 'ItemType', 'FieldName', 'FieldDataType', 'FieldValue'); Optional = @('SectionId', 'RequireAdminister', 'RequireItemEdit'); Absent = @('SectionName', 'SectionDescription') }
            @{ CommandName = $commandName; SetName = 'newsection'; Mandatory = @('TssSession', 'ItemId', 'ItemType', 'FieldName', 'FieldDataType', 'FieldValue'); Optional = @('SectionName', 'SectionDescription', 'RequireAdminister', 'RequireItemEdit'); Absent = @('SectionId') }
            @{ CommandName = $commandName; SetName = 'field'; Mandatory = @('TssSession', 'SectionId', 'FieldName', 'FieldDataType'); Optional = @(); Absent = @('ItemId', 'ItemType', 'FieldValue', 'SectionName', 'SectionDescription', 'RequireAdminister', 'RequireItemEdit') }
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Metadata.Field and Thycotic.PowerShell.Metadata.FieldSummary" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Metadata.Field', 'Thycotic.PowerShell.Metadata.FieldSummary'
        }
        It "$commandName should declare OutputType Thycotic.PowerShell.Metadata.FieldSummary for the field parameter set only" -TestCases $commandDetails {
            $ot = @($_.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.OutputTypeAttribute] -and $_.Type.Name -contains 'Thycotic.PowerShell.Metadata.FieldSummary' })
            ($ot.ParameterSetName | Sort-Object) -join ',' | Should -BeExactly 'field'
        }
        It "$commandName should take SectionId as System.Int32" -TestCases $commandDetails {
            $_.Parameters['SectionId'].ParameterType.FullName | Should -Be 'System.Int32'
        }
        It "$commandName should take FieldDataType as Thycotic.PowerShell.Enums.MetadataFieldDataType" -TestCases $commandDetails {
            $_.Parameters['FieldDataType'].ParameterType.FullName | Should -Be 'Thycotic.PowerShell.Enums.MetadataFieldDataType'
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