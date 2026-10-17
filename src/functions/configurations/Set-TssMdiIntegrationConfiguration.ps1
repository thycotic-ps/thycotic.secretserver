function Set-TssMdiIntegrationConfiguration {
    <#
    .SYNOPSIS
    Set the MDI integration configuration

    .DESCRIPTION
    Turn the Microsoft Defender for Identity (MDI) integration on or off, or change its Azure tenant or synchronization interval.
    The first enable needs the admin consent grant from the authorize URL in the web UI; this cmdlet cannot grant it.
    Only the parameters you pass are sent. Returns the MDI integration configuration after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Enabled
    Turn the MDI integration on; pass -Enabled:$false to turn it off

    .PARAMETER SynchronizationIntervalHours
    Hours between MDI synchronizations

    .PARAMETER TenantId
    Azure tenant Id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssMdiIntegrationConfiguration -TssSession $session -SynchronizationIntervalHours 8

    Synchronize MDI every eight hours

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssMdiIntegrationConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssMdiIntegrationConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.MdiIntegrationConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Enabled,

        [int]
        $SynchronizationIntervalHours,

        [string]
        $TenantId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'mdi-integration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'SynchronizationIntervalHours' {
                    $body.data.Add('synchronizationIntervalHours', @{ dirty = $true; value = $SynchronizationIntervalHours })
                }
                'TenantId' {
                    $body.data.Add('tenantId', @{ dirty = $true; value = $TenantId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("MDI integration configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssMdiIntegrationConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.MdiIntegrationConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.MdiIntegrationConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
