function Get-TssUserAudit {
    <#
    .SYNOPSIS
    Get audit for a user

    .DESCRIPTION
    Get audit for a Secret Server User

    With -Action the audit records of those actions are returned across all users.

    .PARAMETER Action
    Audit actions to return across all users, as they appear in the Action property (for example CREATEUSER, EDIT or 'LOGIN SUCCESS')

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserAudit -TssSession $session -UserId 2

    Get all of the audits for UserId 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserAudit -TssSession $session -Action CREATEUSER, EDIT

    Get the user creation and user edit audits of all users

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'user')]
    [OutputType('Thycotic.PowerShell.Users.AuditSummary[]')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'user')]
        [Alias('Id')]
        [int[]]
        $UserId,

        [Parameter(Mandatory, ParameterSetName = 'action')]
        [string[]]
        $Action
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($PSCmdlet.ParameterSetName -eq 'action') {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', 'action', 'audit' -join '/'
                $queryParams = @("take=$($TssSession.Take)")
                foreach ($actionName in $Action) {
                    $queryParams += "actions=$([uri]::EscapeDataString($actionName))"
                }
                $uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue getting user audit data by action'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [Thycotic.PowerShell.Users.AuditSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Users.AuditSummary]))
                }
                return
            }
            foreach ($user in $UserId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user, 'audit' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                $uri = $uri, "take=$($TssSession.Take)"

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting audit data on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [Thycotic.PowerShell.Users.AuditSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Users.AuditSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
