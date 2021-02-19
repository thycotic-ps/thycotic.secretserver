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
    Context "Verify parameters" -ForEach @{currentParams = $currentParams } {
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
        $invokeParams = @{}
        if ($tssTestUsingWindowsAuth) {
            $session = New-TssSession -SecretServer $ss -UseWindowsAuth
            $invokeParams.UseDefaultCredentials = $true
        } else {
            $session = New-TssSession -SecretServer $ss -Credential $ssCred
            $invokeParams.PersonalAccessToken = $session.AccessToken
        }

        $reportCatName = "tssModuleTest$(Get-Random)"
        $bodData = @{
            data = @{
                reportCategoryDescription = 'tss Module test category'
                reportCategoryName        = $reportCatName
                sortOrder                 = $null
            }
        } | ConvertTo-Json

        # bug in endpoint where it won't return the Category ID properly
        $invokeParams.Uri = $session.ApiUrl, "reports/categories" -join '/'
        Invoke-TssRestApi @invokeParams -Method 'POST' -Body $bodData > $null
        $categoryId = (Get-TssReportCategory -TssSession $session -All).Where( { $_.Name -eq $reportCatName }).CategoryId
    }
    Context "Checking" -ForEach @{categoryId = $categoryId; session = $session } {
        It "Should delete the category" {
            Remove-TssReportCategory -TssSession $session -ReportCategoryId $categoryId -Confirm:$false
            (Get-TssReportCategory -TssSession $session -All).CategoryId | Should -Not -Contain $categoryId
            if (-not $tssTestUsingWindowsAuth) {
                $session.SessionExpire()
            }
        }
    }
}