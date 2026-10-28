function Set-TssSecretFavorite {
    <#
    .SYNOPSIS
    Add or remove a secret from your favorites

    .DESCRIPTION
    Sets the favorite flag of a secret for the current user and returns the new state.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER Favorite
    $true adds the secret to your favorites, $false removes it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretFavorite -TssSession $session -Id 42 -Favorite $true

    Adds secret 42 to your favorites

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretFavorite -TssSession $session | Set-TssSecretFavorite -TssSession $session -Favorite $false

    Removes all of your favorites

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretFavorite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretFavorite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [Alias('IsFavorite')]
        [bool]
        $Favorite
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
                $uri = $TssSession.ApiUrl, 'secrets', $currentId, 'favorite' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $body = @{ }
                switch ($tssParams.Keys) {
                    'Favorite' {
                        $body.Add('isFavorite', $Favorite)
                    }
                }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Secret favorite: $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Set-TssSecretFavorite request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [boolean]::Parse("$restResponse")
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
