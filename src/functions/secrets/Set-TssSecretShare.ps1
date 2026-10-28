function Set-TssSecretShare {
    <#
    .SYNOPSIS
    Turn permission inheritance on or off for a secret

    .DESCRIPTION
    Sets whether the secret inherits permissions from its folder.
    Turn inheritance off before adding explicit permissions with New-TssSecretPermission. Secret Server rejects turning it on for a secret in the root folder.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER InheritPermissions
    Inherit permissions from the folder. Use -InheritPermissions:$false to break inheritance

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretShare -TssSession $session -Id 42 -InheritPermissions:$false

    Breaks permission inheritance on secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretShare -TssSession $session -Id 42 -InheritPermissions

    Makes secret 42 inherit permissions from its folder again

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretShare

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretShare.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.Share')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id,

        [switch]
        $InheritPermissions
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', $Id, 'share' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'InheritPermissions' {
                    $body.data.Add('inheritPermissions', @{ dirty = $true; value = [boolean]$InheritPermissions })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret share: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretShare request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.Share](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.Share]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
