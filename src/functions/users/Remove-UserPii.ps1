function Remove-UserPii {
    <#
    .SYNOPSIS
    Delete a user's personally identifiable info

    .DESCRIPTION
    Delete a user's personally identifiable info

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssUserPii -TssSession $session -Id 56

    Secret Server will go through and delete identified PII data for user 56

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Remove-TssUserPii

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Remove-UserPii.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssDelete')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # User ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("UserId")]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'users', 'delete-pii', $user -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                if (-not $PSCmdlet.ShouldProcess($user,"$($invokeParams.Method) $uri")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue deleting PII for user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssDelete]@{
                        Id = $user
                        ObjectType = 'PII'
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}