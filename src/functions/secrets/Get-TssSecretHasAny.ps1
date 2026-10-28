function Get-TssSecretHasAny {
    <#
    .SYNOPSIS
    Test whether the current user can see any secret

    .DESCRIPTION
    Returns True when the current user has access to at least one secret, False otherwise.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretHasAny -TssSession $session

    Returns True when the signed-in user can see at least one secret

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretHasAny

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretHasAny.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secrets', 'has-any' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretHasAny request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($null -ne $restResponse) {
                [System.Convert]::ToBoolean($restResponse)
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
