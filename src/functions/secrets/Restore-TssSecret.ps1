function Restore-TssSecret {
    <#
    .SYNOPSIS
    Undelete a Secret(s)

    .DESCRIPTION
    Undelete a Secret(s)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Restore-TssSecret -TssSession $session -Id 34, 56

    Un-delete Secrets 34 and 56

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Restore-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Restore-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'undelete' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                if ($PSCmdlet.ShouldProcess("Secret Id: $secret", "$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue with Secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse.id -eq $secret) {
                    Write-Host "Secret [$secret] undeleted"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}