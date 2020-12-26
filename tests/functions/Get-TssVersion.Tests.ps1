BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession', 'Raw'
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
        $version = Get-TssVersion $session
        $session.SessionExpire()
    }
    Context "Checking" -Foreach @{version = $version} {
        It "Should not be empty" {
            $version | Should -Not -BeNullOrEmpty
        }
        It "$commandName should have output type of TssVersion" {
            <# This is because the command does a Select-Object the type is represented as Selected.<TypeName> #>
            $version.PSTypeNames | Should -Contain 'Selected.TssVersion'
        }
        It "$commandName should get property <_> at minimum" -TestCases 'Version' {
            $version.PSObject.Properties.Name | Should -Contain $_
        }

    }
}