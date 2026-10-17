function Invoke-TssPlatformProvision {
    <#
    .SYNOPSIS
    Provision a Delinea Platform tenant for this Secret Server

    .DESCRIPTION
    One-time opt-in call that starts provisioning a Delinea Platform tenant and connects it to this Secret Server Cloud instance. The Delinea UI is the recommended path; this cmdlet sends the same request.
    The server rejects the request unless -OptIn is passed, every required value is set and the region is one of Search-TssPlatformRegion; it also refuses a second request within an hour.
    Returns the provisioning status, which can include a one-time Platform login URL: treat it as a credential.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AdminEmail
    Email address of the initial Platform administrator

    .PARAMETER AdminUsername
    User name of the initial Platform administrator

    .PARAMETER IsPlatformRegionEditable
    Mark the region as chosen by the user; without it the server uses the default region of the instance

    .PARAMETER OptIn
    Acknowledge that provisioning is a one-time opt-in; the server refuses the request without it

    .PARAMETER PlatformRegion
    Id (GUID) of the Platform region, from Search-TssPlatformRegion

    .PARAMETER TenantName
    Host name for the new Platform tenant

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $region = Search-TssPlatformRegion -TssSession $session | Where-Object IsDefault
    Invoke-TssPlatformProvision -TssSession $session -OptIn -TenantName contoso -AdminUsername platformadmin -AdminEmail platformadmin@contoso.com -PlatformRegion $region.Id

    Provision a Platform tenant in the default region of the instance

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Invoke-TssPlatformProvision

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Invoke-TssPlatformProvision.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Platform.ProvisionStatus')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $AdminEmail,

        [Parameter(Mandatory)]
        [string]
        $AdminUsername,

        [switch]
        $IsPlatformRegionEditable,

        [Alias('OptinToPlatformAcknowledgement')]
        [switch]
        $OptIn,

        [Parameter(Mandatory)]
        [string]
        $PlatformRegion,

        [Parameter(Mandatory)]
        [string]
        $TenantName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform', 'provision' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'AdminEmail' {
                    $body.Add('adminEmail', $AdminEmail)
                }
                'AdminUsername' {
                    $body.Add('adminUsername', $AdminUsername)
                }
                'IsPlatformRegionEditable' {
                    $body.Add('isPlatformRegionEditable', [boolean]$IsPlatformRegionEditable)
                }
                'OptIn' {
                    $body.Add('optinToPlatformAcknowledgement', [boolean]$OptIn)
                }
                'PlatformRegion' {
                    $body.Add('platformRegion', $PlatformRegion)
                }
                'TenantName' {
                    $body.Add('tenantName', $TenantName)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Platform tenant $TenantName", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssPlatformProvision request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Platform.ProvisionStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.ProvisionStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
