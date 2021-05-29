function Get-UserAudit {
    <#
    .SYNOPSIS
    Get audit for a user

    .DESCRIPTION
    Get audit for a Secret Server User

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserAudit -TssSession $session -UserId 2

    Get all of the audits for UserId 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUserAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-UserAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssUserAuditSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $UserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $UserId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user, 'audit' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                $uri = $uri, "take=$($TssSession.Take)"

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting audit data on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [TssUserAuditSummary[]]$restResponse.records
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}