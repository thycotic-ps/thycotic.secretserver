function Get-TssPlatformVault {
    <#
    .SYNOPSIS
    Get the Secret Server vaults the Delinea Platform vault broker returns

    .DESCRIPTION
    Returns the vaults the Delinea Platform vault broker lists for the session token (GET vaultbroker/api/vaults on the Platform), with the vault id, name, type, default flags, active flag and connection URL.
    New-TssSession -PlatformUrl uses the same list to pick the vault: the active vault with -VaultId, else the global default, else the default, else the first active vault.
    Requires a session created with New-TssSession -PlatformUrl.

    .PARAMETER TssSession
    TssSession object created by New-TssSession -PlatformUrl for authentication

    .EXAMPLE
    $session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser
    Get-TssPlatformVault -TssSession $session

    Lists every vault the Platform vault broker returns for the service user

    .EXAMPLE
    $session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser
    Get-TssPlatformVault -TssSession $session | Where-Object IsActive | Select-Object VaultId, Name, Url

    Shows the id, name and URL of each active vault, for use with New-TssSession -VaultId

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformVault

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformVault.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession -PlatformUrl
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.Vault')]
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
            if (-not $TssSession.PlatformUrl) {
                Write-Warning 'The session was not created with New-TssSession -PlatformUrl'
                return
            }
            $uri = $TssSession.PlatformUrl, 'vaultbroker', 'api', 'vaults' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformVault request'
                $err = $_
                . $ErrorHandling $err
            }
            foreach ($vault in @($restResponse.vaults | Where-Object { $_ })) {
                [Thycotic.PowerShell.Platform.Vault]@{
                    VaultId         = $vault.vaultId
                    Name            = $vault.name
                    Type            = $vault.type
                    IsDefault       = [boolean]$vault.isDefault
                    IsGlobalDefault = [boolean]$vault.isGlobalDefault
                    IsActive        = [boolean]$vault.isActive
                    Url             = ([string]$vault.connection.url).TrimEnd('/')
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
