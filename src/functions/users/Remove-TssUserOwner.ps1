function Remove-TssUserOwner {
    <#
    .SYNOPSIS
    Remove an owner from a user

    .DESCRIPTION
    Removes one owner record from a user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User ID

    .PARAMETER OwnerId
    ID of the owner record to remove (the Id property of Get-TssUserOwner output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssUserOwner -TssSession $session -Id 42 -OwnerId 3

    Removes owner record 3 from user 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Remove-TssUserOwner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Remove-TssUserOwner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $OwnerId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', $Id, 'owners', $OwnerId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'
            if ($PSCmdlet.ShouldProcess("User: $Id", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssUserOwner request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.model) {
                    [Thycotic.PowerShell.Common.Delete](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.Common.Delete]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
