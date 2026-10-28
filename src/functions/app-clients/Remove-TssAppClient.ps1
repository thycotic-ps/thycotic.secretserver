function Remove-TssAppClient {
    <#
    .SYNOPSIS
    Delete an OAuth app client

    .DESCRIPTION
    Delete one or more OAuth app clients by ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    App client ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssAppClient -TssSession $session -Id 2

    Deletes app client 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Remove-TssAppClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Remove-TssAppClient.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'app-clients', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("App client: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssAppClient request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Common.Delete]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
