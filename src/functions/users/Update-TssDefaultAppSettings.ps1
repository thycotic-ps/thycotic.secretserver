function Update-TssDefaultAppSettings {
    <#
    .SYNOPSIS
    Set the default application of the current user

    .DESCRIPTION
    When Secret Server and Privilege Manager are both installed, sets which application loads after the current user logs in.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DefaultApp
    Application to load after login: None, SecretServer or PrivilegeManager

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDefaultAppSettings -TssSession $session -DefaultApp SecretServer

    Makes Secret Server the application that loads after the current user logs in

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssDefaultAppSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssDefaultAppSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('None', 'SecretServer', 'PrivilegeManager')]
        [string]
        $DefaultApp
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'set-default-app-settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DefaultApp' {
                    $body.data.Add('defaultApp', $DefaultApp)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Default application", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDefaultAppSettings request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Users.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.ActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
