BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id', 'AllowedTemplate', 'AllowRemoveOwner', 'EnableInheritPermission', 'EnableInheritSecretPolicy', 'FolderName', 'SecretPolicy'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
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

        $invokeParams.Uri = $($session.ApiUrl), "folders?take=$($session.take)" -join '/'
        $invokeParams.ExpandProperty      = 'records'

        $getFolders = Invoke-TssRestApi @invokeParams

        <# Allowed Template testing #>
        $setAllowedTemplates = $getFolders.Where( { $_.folderPath -eq '\tss_module_testing\SetFolder\AllowedTemplates' })
        $getAllowedTemplatesF = Get-TssFolder -TssSession $session -Id $setAllowedTemplates.id -IncludeTemplates

        $invokeParams.Uri = $($session.ApiUrl), "secret-templates" -join '/'
        $templateIds = (Invoke-TssRestApi @invokeParams).id
        $randomNum = Get-Random -Maximum 6
        $testTemplate = $templateIds[$randomNum]

        if (-not $tssTestUsingWindowsAuth) {
            $session.SessionExpire()
        }
    }
    BeforeAll {
        . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
        if ($tssTestUsingWindowsAuth) {
            $session = New-TssSession -SecretServer $ss -UseWindowsAuth
        } else {
            $session = New-TssSession -SecretServer $ss -Credential $ssCred
        }
    }
    AfterAll {
        if (-not $tssTestUsingWindowsAuth) {
            $session.SessionExpire()
        }
    }
    Context "Checking AllowedTemplates" -Foreach @{setAllowedTemplates = $setAllowedTemplates } {
        It "Should have found AllowedTemplates folder for testing" {
            $setAllowedTemplates | Should -Not -BeNullOrEmpty
        }
        It "Should set Allowed Templates to <_>" -TestCases $testTemplate {
            Set-TssFolder -TssSession $session -Id $setAllowedTemplates.id -AllowedTemplate $_ | Should -BeNullOrEmpty
        }
    }
}