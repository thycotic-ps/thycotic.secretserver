function Disable-TssUserSshKey {
    <#
    .SYNOPSIS
    Deactivate a user public SSH key

    .DESCRIPTION
    Deactivates a user public SSH key by its ID. Returns the ID of the deactivated key.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the SSH key to deactivate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssUserSshKey -TssSession $session -Id 7

    Deactivates SSH key 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUserSshKey -TssSession $session -IncludeExpired | Where-Object Expired | Disable-TssUserSshKey -TssSession $session

    Deactivates every expired SSH key

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Disable-TssUserSshKey

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Disable-TssUserSshKey.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Int32')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', 'public-ssh-keys', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'
                if ($PSCmdlet.ShouldProcess("SSH key: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Disable-TssUserSshKey request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [int]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
