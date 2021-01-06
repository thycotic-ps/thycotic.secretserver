BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName Unit Tests" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'Uri', 'PersonalAccessToken', 'Method', 'Body', 'OutFile', 'ContentType', 'Headers', 'UseDefaultCredentials', 'Proxy', 'ProxyCredential', 'ProxyUseDefaultCredentials', 'PSTypeName', 'Property', 'RemoveProperty', 'ExpandProperty'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName, 'Function')).Parameters.Keys
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
}
Describe "$commandName works" {
    BeforeDiscovery {
        $session = New-TssSession -SecretServer $ss -Credential $ssCred

        $invokeParams = @{
            Uri = $session.ApiUrl, "version" -join '/'
            Method = 'GET'
            PersonalAccessToken = $session.AccessToken
        }
        $restResponse = Invoke-TssRestApi @invokeParams
        $session.SessionExpire()
    }
    Context "Checking" -Foreach @{restResponse = $restResponse} {
        It "Should not be empty" {
            $restResponse | Should -Not -BeNullOrEmpty
        }
        It "Should be successful" {
            $restResponse.success | Should -BeTrue
        }
    }
}