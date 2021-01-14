BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot,'..','constants.ps1'))

    $PSDefaultParameterValues.Remove("*:TssSession")
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'ReportName', 'CategoryId', 'ReportSql', 'Description', 'ChartType', 'Is3DReport', 'PageSize', 'Paging', 'Raw'
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
        It "$commandName should set OutputType to TssReport" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssReport'
        }
    }
}
Describe "$commandName works" {
    BeforeDiscovery {
        $reportName = ("TssTestReport$(Get-Random)")
        $session = New-TssSession -SecretServer $ss -Credential $ssCred
        $PSDefaultParameterValues.Add("*:TssSession",$session)

        $categoryId = (Get-TssReportCategory -All).Where({$_.Name -eq 'tssModuleTest'}).CategoryId
        if ($null -eq $categoryId) {
            $bodData = @{
                data = @{
                    reportCategoryDescription = 'tss Module test category'
                    reportCategoryName = 'tssModuleTest'
                }
            } | ConvertTo-Json
            # bug in endpoint where it won't return the Category ID properly
            Invoke-TssRestApi -Uri "$($session.ApiUrl)/reports/categories" -Method 'POST' -Body $bodData -PersonalAccessToken $session.AccessToken > $null
            $categoryId = (Get-TssReportCategory -All).Where({$_.Name -eq 'tssModuleTest'}).CategoryId
        }

        $newReport = @{
            ReportName = $reportName
            CategoryId = $categoryId
            Description = "Tss Module Test report"
            ReportSql = "SELECT 1"
        }
        $object  = New-TssReport @newReport
        $props = 'ReportId', 'Id', 'CategoryId', 'Name', 'ReportSql'

        # delete report created
        Invoke-TssRestApi -Uri "$($session.ApiUrl)/reports/$($object.Id)" -Method DELETE -PersonalAccessToken $session.AccessToken > $null
        Remove-TssReportCategory -ReportCategoryId $categoryId -Confirm:$false > $null
        $session.SessionExpire()
        $PSDefaultParameterValues.Remove("*:TssSession")
    }
    Context "Checking" -Foreach @{object = $object} {
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should output <_> property" -TestCases $props {
            $object.PSObject.Properties.Name | Should -Contain $_
        }
    }
}