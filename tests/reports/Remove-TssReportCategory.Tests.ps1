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
    Context "Verify parameters" -Foreach @{currentParams = $currentParams} {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to TssDelete" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssDelete'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred

        $reportCatName = "tssModuleTest$(Get-Random)"
        $bodData = @{
            data = @{
                reportCategoryDescription = 'tss Module test category'
                reportCategoryName = $reportCatName
            }
        } | ConvertTo-Json
        # bug in endpoint where it won't return the Category ID properly
        Invoke-TssRestApi -Uri "$($session.ApiUrl)/reports/categories" -Method 'POST' -Body $bodData -PersonalAccessToken $session.AccessToken > $null
        $categoryId = (Get-TssReportCategory -TssSession $session -All).Where({$_.Name -eq $reportCatName}).CategoryId
    }
    Context "Checking" -Foreach @{categoryId = $categoryId; session = $session} {
        AfterAll {
            $session.SessionExpire()
        }
        It "Should delete the category" {
            Remove-TssReportCategory -TssSession $session -ReportCategoryId $categoryId -Confirm:$false
            (Get-TssReportCategory -TssSession $session -All).CategoryId | Should -Not -Contain $categoryId
        }
    }
}