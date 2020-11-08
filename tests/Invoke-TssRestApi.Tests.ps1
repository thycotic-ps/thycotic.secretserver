BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
}

Describe "$commandName Unit Tests" {
    Context "Verify parameters" {
        BeforeDiscovery {
            [object[]]$params = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($CommandName, 'Function')).Parameters.Keys
            [object[]]$knownParameters = 'Uri', 'PersonalAccessToken', 'Method', 'Body', 'ContentType', 'Headers', 'UseDefaultCredentials', 'Proxy', 'ProxyCredential', 'ProxyUseDefaultCredentials', 'PSTypeName', 'Property', 'RemoveProperty', 'ExpandProperty'
            $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $params -PassThru
        }
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $params | Should -Be $true
        }
        It "$commandName should not contain parameter: <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
}