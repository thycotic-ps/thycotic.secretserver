function Reset-TssPlatformUserMapping {
    <#
    .SYNOPSIS
    Remove every Platform user mapping

    .DESCRIPTION
    Delete every mapping between Delinea Platform users and Secret Server users. This is instance-wide and cannot be undone; it is usually only needed before Platform integration is set up again. Returns True.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Reset-TssPlatformUserMapping -TssSession $session -Confirm:$false

    Remove every Platform user mapping without a confirmation prompt

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Reset-TssPlatformUserMapping

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Reset-TssPlatformUserMapping.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Platform Integration permission.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'platform', 'reset-user-mappings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("All Platform user mappings", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Reset-TssPlatformUserMapping request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
