function Stop-TssUserSession {
    <#
    .SYNOPSIS
    End login sessions of the current user

    .DESCRIPTION
    Ends one or more web login sessions of the user who owns the session. Session IDs come from Search-TssUserSession.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER UserSessionId
    IDs of the sessions to end

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Stop-TssUserSession -TssSession $session -UserSessionId 1012

    Ends login session 1012 of the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUserSession -TssSession $session | Where-Object { -not $_.Current } | Stop-TssUserSession -TssSession $session

    Ends every login session of the current user except the one making the request

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Stop-TssUserSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Stop-TssUserSession.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $UserSessionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'sessions', 'terminate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'UserSessionId' {
                    $body.data.Add('userSessionIds', $UserSessionId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User session", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Stop-TssUserSession request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Users.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.ActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
