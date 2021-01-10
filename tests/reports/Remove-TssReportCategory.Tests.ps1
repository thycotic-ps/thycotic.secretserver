BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','ReportCategoryId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parmaeters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to Boolean" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Boolean'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $body = @{
            reportCategoryDescription = 'tss test category to be deleted'
            reportCategoryName = 'tss module testing to remove'
            sortOrder = $null
        }
        $invokeParams = @{
            Uri = "$ss/api/v1/reports/categories"
            Body = $body
            Method = 'POST'
            PersonalAccessToken = $session.AccessToken
        }
        $createdCategory = Invoke-TssRestApi @invokeParams
    }
    Context "Checking" -Foreach @{createdCategory = $createdCategory} {
        It "Should delete the category" {
            Remove-TssReportCategory -TssSession $session -ReportCategoryId $createdCategory.reportCategoryId -Confirm:$false
            $cat = Get-TssReportCategory -TssSession $session -ReportCategoryId $createdCategory.reportCategoryId -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $cat | Should -Not -BeNullOrEmpty
        }
    }
}