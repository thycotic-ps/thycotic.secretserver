function New-SecretPermission {
    <#
    .SYNOPSIS
    Create a new Secret Permission

    .DESCRIPTION
    Create a new Secret Permission

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSecretPermission -TssSession $session -SecretId 76 -AccessRole View -UserId 98

    Adding permission for User ID 98 to Secret 76, granting View rights to the Secret.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/New-TssSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/New-SecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssSecretPermission')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $SecretId,

        # Secret Access Role Name
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateSet('List', 'View', 'Edit', 'Owner')]
        [string]
        $AccessRole,

        #  Group ID
        [Parameter(ValueFromPipeline)]
        [int]
        $GroupId,

        # User ID
        [Parameter(ValueFromPipeline)]
        [int]
        $UserId
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-permissions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = [ordered]@{
                SecretAccessRoleName = $AccessRole
                SecretId   = $SecretId
            }
            switch ($tssNewParams.Keys) {
                'UserId' { $newBody.Add('UserId', $UserId) }
                'GroupId' { $newBody.Add('GroupId', $GroupId) }
            }

            $invokeParams.Body = ($newBody | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Secret ID: $SecretId", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue creating Secret Permission on secret [$SecretId]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssSecretPermission]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}