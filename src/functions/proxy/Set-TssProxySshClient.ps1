function Set-TssProxySshClient {
    <#
    .SYNOPSIS
    Set the allow or block list type of an SSH terminal client

    .DESCRIPTION
    Moves an SSH terminal client to the allow list or block list, or back to Unknown.
    Returns True when the change is saved.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH terminal client ID (ClientId in Search-TssProxySshClient output)

    .PARAMETER TerminalClientType
    Allow list, block list, or Unknown to remove the client from both

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssProxySshClient -TssSession $session -Id 12 -TerminalClientType BlockList

    Blocks SSH terminal client 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Set-TssProxySshClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Set-TssProxySshClient.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ClientId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [ValidateSet('Unknown', 'AllowList', 'BlockList')]
        [string]
        $TerminalClientType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'clients', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            $body.Add('clientId', $Id)
            switch ($tssParams.Keys) {
                'TerminalClientType' {
                    $body.Add('terminalClientType', $TerminalClientType)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Proxy ssh client: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssProxySshClient request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
