function Reset-TssPlatformUserMapping {
    <#
    .SYNOPSIS
    Remove every Platform user mapping

    .DESCRIPTION
    Delete every mapping between Delinea Platform users and Secret Server users. This is instance-wide and cannot be undone; it is usually only needed before Platform integration is set up again. Returns True.
    Changing the Platform configuration, unified mode or Platform user mappings can cause loss of access to the Delinea Platform.
    The command writes that warning and asks OK to proceed? before it sends the request. -Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Force
    Skip the OK to proceed? question, and the confirmation prompt unless -Confirm is passed. The warning is still written.

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
        $TssSession,

        [switch]
        $Force
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
            if (Confirm-TssDangerousOperation $PSCmdlet PlatformAccess "All Platform user mappings" "$($invokeParams.Method) $uri" -Force:$Force) {
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
