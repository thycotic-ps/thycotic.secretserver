function Enable-TssUnlimitedAdmin {
    <#
    .SYNOPSIS
    Enable Unlimited Admin Mode

    .DESCRIPTION
    Enable Unlimited Admin Mode

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssUnlimitedAdmin -TssSession $session -Note "Troubleshooting issue checkout hooks failing"

    Enables Unlimited Admin Mode providing the required note

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Enable-TssUnlimitedAdmin

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Enable-TssUnlimitedAdmin.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Notes for the change. Only updated if state has changed
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [Alias('Comment')]
        [string]
        $Note
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'unlimited-admin' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $ulBody = @{
                data = @{
                    enabled = $true
                    notes   = $Note
                }
            }
            $invokeParams.Body = $ulBody | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("SecretId: $user", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    . $ProcessResponse $apiResponse
                    Write-Verbose 'Unlimited Admin mode enabled'
                } catch {
                    Write-Warning 'Issue enabling Unlimited Admin Mode'
                    $err = $_
                    . $ErrorHandling $err
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}