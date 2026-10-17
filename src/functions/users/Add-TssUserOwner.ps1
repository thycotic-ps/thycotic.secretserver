function Add-TssUserOwner {
    <#
    .SYNOPSIS
    Add an owner to a user

    .DESCRIPTION
    Adds one user or one group as an owner of a user. Supply -OwnerUserId or -OwnerGroupId.
    Returns the new owner record. Set-TssUserOwner adds and removes several group owners in one call.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User ID

    .PARAMETER OwnerUserId
    ID of the user to add as owner

    .PARAMETER OwnerGroupId
    ID of the group to add as owner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssUserOwner -TssSession $session -Id 42 -OwnerGroupId 8

    Makes group 8 an owner of user 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssUserOwner -TssSession $session -Id 42 -OwnerUserId 5

    Makes user 5 an owner of user 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Add-TssUserOwner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Add-TssUserOwner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.OwnerSummary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int]
        $Id,

        [int]
        $OwnerUserId,

        [int]
        $OwnerGroupId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', $Id, 'owners' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'OwnerUserId' {
                    $body.Add('userId', $OwnerUserId)
                }
                'OwnerGroupId' {
                    $body.Add('groupId', $OwnerGroupId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssUserOwner request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.model) {
                    [Thycotic.PowerShell.Users.OwnerSummary](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.Users.OwnerSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
