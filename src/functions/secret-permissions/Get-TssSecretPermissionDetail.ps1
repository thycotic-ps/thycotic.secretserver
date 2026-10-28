function Get-TssSecretPermissionDetail {
    <#
    .SYNOPSIS
    Get a secret permission by ID

    .DESCRIPTION
    Get a single secret permission by its secret permission ID.
    Search-TssSecretPermission lists the permissions on a secret; this returns one of them.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret permission ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPermissionDetail -TssSession $session -Id 1043

    Returns secret permission 1043

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretPermission -TssSession $session -SecretId 76 | Get-TssSecretPermissionDetail -TssSession $session

    Returns each permission on secret 76 by its ID

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionDetail

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionDetail.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPermissions.Permission')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretPermissionId')]
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
                $uri = $TssSession.ApiUrl, 'secret-permissions', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretPermissionDetail request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretPermissions.Permission](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretPermissions.Permission]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
