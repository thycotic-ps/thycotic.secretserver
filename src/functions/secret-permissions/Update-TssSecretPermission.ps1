function Update-TssSecretPermission {
    <#
    .SYNOPSIS
    Update a Secret Permission

    .DESCRIPTION
    Update a Secret Permission

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretPermission -TssSession $session -Id 242

    Update Secret Permission 242, setting access role to View

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Set-TssSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permission/Set-TssSecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretPermissions.Permission')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Permission ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretPermissionId')]
        [int[]]
        $Id,

        # Secret Permission ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretId,

        # Granted Role name
        [Parameter(Mandatory)]
        [ValidateSet('List', 'View', 'Edit', 'Owner')]
        [string]
        $AccessRole
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secretP in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-permissions', $secretP -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $updateBody = @{
                    id = $secretP
                    secretId = $SecretId
                    secretAccessRoleName = $AccessRole
                }

                $invokeParams.Body = $updateBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("Secret Permission ID: $secretP", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue updating secret permission [$secretP]'
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretPermissions.Permission]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}