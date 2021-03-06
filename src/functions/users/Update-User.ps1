function Update-User {
    <#
    .SYNOPSIS
    Update all members of a group

    .DESCRIPTION
    Update all members of a group

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    $user = Get-TssUser -TssSession $session -Id 42
    $user.DisplayName = 'New Display Name'
    Update-TssUser -TssSession $session -Id 42 -User $user

    Get the TssUser object via Get-TssUser, updating the display name on User 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-User.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('TssUser')]
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # User ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int]
        $Id,

        # User object from Get-TssUser
        [Parameter(Mandatory)]
        [TssUser]
        $User
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $invokeParams.Body = $User | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("User ID: $Id", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning 'Issue updating user [$Id]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssUser]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}