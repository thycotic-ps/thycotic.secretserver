function Get-TssPasswordTypeUsage {
    <#
    .SYNOPSIS
    Get active-secret usage counts per password type

    .DESCRIPTION
    Get the number of active secrets that use each password type.
    Only password types used by at least one active secret are returned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPasswordTypeUsage -TssSession $session | Sort-Object ActiveSecretCount -Descending

    List the password types in use, most used first

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssPasswordTypeUsage

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssPasswordTypeUsage.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.PasswordTypeUsage[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'password-type-usage' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPasswordTypeUsage request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Rpc.PasswordTypeUsage[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Rpc.PasswordTypeUsage]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
