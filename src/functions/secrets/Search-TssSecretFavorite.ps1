function Search-TssSecretFavorite {
    <#
    .SYNOPSIS
    Get the favorite secrets of the current user

    .DESCRIPTION
    Returns the ID, name, folder ID and folder path of each secret the current user marked as a favorite.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretFavorite -TssSession $session

    Returns your favorite secrets

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretFavorite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretFavorite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.Favorite[]')]
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
            $uri = $TssSession.ApiUrl, 'secrets', 'favorite' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretFavorite request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Secrets.Favorite[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.Favorite]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
