function Test-TssDistributedEngineSiteConnector {
    <#
    .SYNOPSIS
    Validate a Site Connector

    .DESCRIPTION
    Validate a Site Connector

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssDistributedEngineSiteConnector -TssSession $session -Id 2

    Validate Site Connector ID 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Test-TssDistributedEngineSiteConnector

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Test-TssDistributedEngineSiteConnector.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngines.Validation')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site Connector ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [Alias('SiteConnectorId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($connector in $Id) {
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'site-connector', $connector, 'validate' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue validating Site Connector [$connector]'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.DistributedEngines.Validation]@{
                            Message = $restResponse.validationMessage
                            IsSuccessful = $restResponse.validationSuccess
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}