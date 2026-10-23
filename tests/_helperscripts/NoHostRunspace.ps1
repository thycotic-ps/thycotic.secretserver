function New-TssNoHostShell {
    $manifest = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, '..', '..', 'src', 'Thycotic.SecretServer.psd1'))
    $shell = [powershell]::Create()
    $null = $shell.AddScript({
            param($ManifestPath)
            Import-Module $ManifestPath -Force
            & (Get-Module Thycotic.SecretServer) {
                $script:tssApiCalls = [System.Collections.Generic.List[object]]::new()
                $script:tssApiResponseContent = '{}'
                function script:Invoke-TssApi {
                    param(
                        $Uri,
                        $AccessToken,
                        $Method,
                        $Body,
                        $OutFile,
                        $ContentType,
                        [switch]$UseDefaultCredential,
                        $Proxy,
                        $ProxyCredential,
                        [switch]$ProxyUseDefaultCredentials,
                        $Timeout,
                        [switch]$SkipCertificateCheck
                    )
                    $script:tssApiCalls.Add([pscustomobject]@{ Uri = $Uri; Method = "$Method"; Body = $Body })
                    $response = [RestSharp.RestResponse]::new([RestSharp.RestRequest]::new())
                    $response.StatusCode = [System.Net.HttpStatusCode]::OK
                    $response.IsSuccessStatusCode = $true
                    $response.ResponseStatus = [RestSharp.ResponseStatus]::Completed
                    $response.Content = $script:tssApiResponseContent
                    $response
                }
            }
            function global:New-TssTestSession {
                [Thycotic.PowerShell.Authentication.Session]@{
                    SecretServer = 'https://tss.example.test/SecretServer'
                    ApiUrl       = 'https://tss.example.test/SecretServer/api/v1'
                    AccessToken  = 'pester'
                    TokenType    = 'bearer'
                    StartTime    = [datetime]::Now
                    TimeOfDeath  = [datetime]::Now.AddHours(1)
                }
            }
        }).AddArgument($manifest)
    $null = $shell.Invoke()
    if ($shell.Streams.Error.Count -gt 0) {
        throw "Module import in the no-host runspace failed: $($shell.Streams.Error[0])"
    }
    $shell
}

function Invoke-TssNoHostCase {
    param(
        [Parameter(Mandatory)]
        [powershell]
        $Shell,

        [Parameter(Mandatory)]
        [string]
        $Script,

        [string]
        $ResponseContent = '{}'
    )
    $Shell.Commands.Clear()
    $Shell.Streams.ClearStreams()
    $null = $Shell.AddScript({
            param($Content)
            & (Get-Module Thycotic.SecretServer) {
                param($c)
                $script:tssApiCalls.Clear()
                $script:tssApiResponseContent = $c
            } $Content
        }).AddArgument($ResponseContent)
    $null = $Shell.Invoke()

    $Shell.Commands.Clear()
    $Shell.Streams.ClearStreams()
    $null = $Shell.AddScript("& { $Script }")
    $output = $Shell.Invoke()
    $result = [pscustomobject]@{
        Output   = @($output)
        Errors   = @($Shell.Streams.Error)
        Warnings = @($Shell.Streams.Warning | ForEach-Object Message)
        Verbose  = @($Shell.Streams.Verbose | ForEach-Object Message)
        Calls    = @()
    }

    $Shell.Commands.Clear()
    $Shell.Streams.ClearStreams()
    $null = $Shell.AddScript({ & (Get-Module Thycotic.SecretServer) { $script:tssApiCalls.ToArray() } })
    $result.Calls = @($Shell.Invoke())
    $result
}
