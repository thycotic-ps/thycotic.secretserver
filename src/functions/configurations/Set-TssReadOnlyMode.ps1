function Set-TssReadOnlyMode {
    <#
    .SYNOPSIS
    Enable or disable Read-Only Mode

    .DESCRIPTION
    Turns Read-Only Mode on (-Enabled) or off (-Enabled:$false) and returns the setting.
    While Read-Only Mode is on, Secret Server rejects some changes for every user, such as creating a secret or saving a whole secret (Update-TssSecret). Not every change is blocked: creating a folder still works, and a single field update (Set-TssSecretField) can still save its value, even when it returns a read-only error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Enabled
    Turn Read-Only Mode on. Use -Enabled:$false to turn it off

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReadOnlyMode -TssSession $session -Enabled

    Puts Secret Server in Read-Only Mode

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssReadOnlyMode -TssSession $session -Enabled:$false

    Takes Secret Server out of Read-Only Mode

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssReadOnlyMode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssReadOnlyMode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.ReadOnlyMode')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Enabled
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'read-only-mode' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Read only mode", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssReadOnlyMode request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.ReadOnlyMode](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ReadOnlyMode]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
