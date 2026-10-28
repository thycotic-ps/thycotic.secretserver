BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Id'
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
        It "$commandName should set OutputType to Thycotic.PowerShell.Secrets.PasswordStatus" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'Thycotic.PowerShell.Secrets.PasswordStatus'
        }
    }
}

Describe "$commandName request" {
    BeforeAll {
        . ([System.IO.Path]::Combine($PSScriptRoot, '..', '_helperscripts', 'NoHostRunspace.ps1'))
        $shell = New-TssNoHostShell
        $case = Invoke-TssNoHostCase -Shell $shell -Script 'Get-TssSecretPasswordStatus -TssSession (New-TssTestSession) -Id 26 -Verbose' -ResponseContent '{"status":"Pending"}'
    }
    AfterAll {
        $shell.Dispose()
    }
    It "$commandName should read the published route secrets/secret-detail/{id}/password-status" {
        $case.Calls.Count | Should -Be 1
        $case.Calls[0].Uri | Should -BeExactly 'https://tss.example.test/SecretServer/api/v1/secrets/secret-detail/26/password-status'
        $case.Calls[0].Method | Should -Be 'GET'
    }
    It "$commandName should not call an internal endpoint" {
        $case.Calls.Uri | Should -Not -Match '/internals/'
        $case.Verbose | Should -Not -Match 'calling an internal endpoint'
    }
    It "$commandName should output the status as Thycotic.PowerShell.Secrets.PasswordStatus" {
        $case.Errors | Should -BeNullOrEmpty
        $case.Output.Count | Should -Be 1
        $case.Output[0].GetType().FullName | Should -Be 'Thycotic.PowerShell.Secrets.PasswordStatus'
    }
}