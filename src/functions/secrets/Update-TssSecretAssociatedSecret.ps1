function Update-TssSecretAssociatedSecret {
    <#
    .SYNOPSIS
    Set the secrets associated with a custom launcher on a secret

    .DESCRIPTION
    Sets the ordered list of secrets a custom launcher on the secret pulls credentials from. The list replaces the current one; pass an empty array to clear it.
    The custom launcher must already be associated with the secret (normally through its secret template), otherwise Secret Server returns an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER LauncherId
    Custom launcher ID

    .PARAMETER AssociatedSecretId
    Secret IDs to associate, in order. An empty array clears the list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretAssociatedSecret -TssSession $session -Id 42 -LauncherId 4 -AssociatedSecretId 100, 101

    Associates secrets 100 and 101, in that order, with custom launcher 4 on secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretAssociatedSecret -TssSession $session -Id 42 -LauncherId 4 -AssociatedSecretId @()

    Clears the associated secrets of custom launcher 4 on secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretAssociatedSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretAssociatedSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.CustomLauncherSettings[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $LauncherId,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [int[]]
        $AssociatedSecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', $Id, 'launchers', $LauncherId, 'associated-secrets' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $associations = @(for ($index = 0; $index -lt $AssociatedSecretId.Count; $index++) {
                    @{
                        associatedSecretId = $AssociatedSecretId[$index]
                        order              = $index + 1
                    }
                })
            $body = @{ data = $associations }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret associated secret: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretAssociatedSecret request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.CustomLauncherSettings[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.CustomLauncherSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
