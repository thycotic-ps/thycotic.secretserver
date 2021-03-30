function Get-User {
    <#
    .SYNOPSIS
    Get a Secret Server User

    .DESCRIPTION
    Get a Secret Server User

    .EXAMPLE
    PS> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS> Get-TssUser -TssSession $session -Id 2

    Get the User ID 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-User.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssUser')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # User ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("UserId")]
        [int[]]
        $Id,

        # Include inactive users in results
        [switch]
        $IncludeInactive
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if (-not $restResponse.verifyEmailSentDate) {
                    $restResponse.verifyEmailSentDate = [datetime]::MinValue
                }
                if (-not $restResponse.passwordLastChanged) {
                    $restResponse.passwordLastChanged = [datetime]::MinValue
                }
                if (-not $restResponse.adAccountExpires) {
                    $restResponse.adAccountExpires = [datetime]::MinValue
                }
                if (-not $restResponse.resetSessionStarted) {
                    $restResponse.resetSessionStarted = [datetime]::MinValue
                }
                if (-not $restResponse.LastSessionActivity) {
                    $restResponse.LastSessionActivity = [datetime]::MinValue
                }
                if (-not $restResponse.lastLogin) {
                    $restResponse.LastLogin = [datetime]::MinValue
                }
                if ($restResponse) {
                    [TssUser]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}