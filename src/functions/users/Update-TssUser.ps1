function Update-TssUser {
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
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('Thycotic.PowerShell.Users.User')]
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # User ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int]
        $Id,

        # User object from Get-TssUser
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Users.User]
        $User
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $invokeParams.Body = $User | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("User ID: $Id", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue updating user [$Id]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Users.User]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}