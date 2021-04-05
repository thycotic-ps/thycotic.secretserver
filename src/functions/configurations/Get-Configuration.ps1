function Get-Configuration {
    <#
    .SYNOPSIS
    Get Secret Server configuration section(s)

    .DESCRIPTION
    Get Secret Server configuration section(s) found under Admin > Configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssConfiguration -TssSession $session -All

    Return all configuration objects

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-Configuration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssConfigurationGeneral')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Configuration type (Application, Email, Folders, Launcher, LocalUserPasswords, PermissionOptions, UserExperience, UserInterface)
        [ValidateSet('All','Application', 'Email', 'Folders', 'Launcher', 'LocalUserPasswords', 'PermissionOptions', 'UserExperience', 'UserInterface')]
        [string]
        $Type = 'All'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'configuration', 'general' -join '/'

            $uriParams = @()
            if ($Type -eq 'All') {
                $params = "loadAll=true"
            } else {
                switch ($Type) {
                    'Application' { $uriParams += "loadApplicationSettings=true" }
                    'Email' { $uriParams += "loadEmail=true" }
                    'Folders' { $uriParams += "loadFolders=true" }
                    'Launcher' { $uriParams += "loadLauncherSettings=true" }
                    'LocalUserPasswords' { $uriParams += "loadLocalUserPasswords=true" }
                    'PermissionOptions' { $uriParams += "loadPermissionOptions=true" }
                    'UserExperience' { $uriParams += "loadUserExperience=true" }
                    'UserInterface' { $uriParams += "loadUserInterface=true" }
                }
                $params = $uriParams -join '&'
            }
            $invokeParams.Uri = $uri, $params -join '?'
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue getting configuration for [$($TssSession.SecretServer)]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssConfigurationGeneral]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}