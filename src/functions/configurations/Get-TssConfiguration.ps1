function Get-TssConfiguration {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.General')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Configuration type (Application, Email, Folders, Launcher, LocalUserPasswords, PermissionOptions, UserExperience, UserInterface)
        [ValidateSet('All', 'Application', 'Email', 'Folders', 'Launcher', 'LocalUserPasswords', 'PermissionOptions', 'UserExperience', 'UserInterface')]
        [string]
        $Type = 'All'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'general' -join '/'

            $uriParams = @()
            if ($Type -eq 'All') {
                $params = 'loadAll=true'
            } else {
                switch ($Type) {
                    'Application' { $uriParams += 'loadApplicationSettings=true' }
                    'Email' { $uriParams += 'loadEmail=true' }
                    'Folders' { $uriParams += 'loadFolders=true' }
                    'Launcher' { $uriParams += 'loadLauncherSettings=true' }
                    'LocalUserPasswords' { $uriParams += 'loadLocalUserPasswords=true' }
                    'PermissionOptions' { $uriParams += 'loadPermissionOptions=true' }
                    'UserExperience' { $uriParams += 'loadUserExperience=true' }
                    'UserInterface' { $uriParams += 'loadUserInterface=true' }
                }
                $params = $uriParams -join '&'
            }
            $invokeParams.Uri = $uri, $params -join '?'
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting configuration for [$($TssSession.SecretServer)]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                switch ($Type) {
                    'All' {
                        [Thycotic.PowerShell.Configuration.General](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.General]))
                    }
                    'Application' {
                        [Thycotic.PowerShell.Configuration.ApplicationSettings](. $FilterTssResponse $restResponse.applicationSettings ([Thycotic.PowerShell.Configuration.ApplicationSettings]))
                    }
                    'Email' {
                        [Thycotic.PowerShell.Configuration.EmailSettings](. $FilterTssResponse $restResponse.emailSettings ([Thycotic.PowerShell.Configuration.EmailSettings]))
                    }
                    'Folders' {
                        [Thycotic.PowerShell.Configuration.Folders](. $FilterTssResponse $restResponse.folders ([Thycotic.PowerShell.Configuration.Folders]))
                    }
                    'Launcher' {
                        [Thycotic.PowerShell.Configuration.LauncherSettings](. $FilterTssResponse $restResponse.launcherSettings ([Thycotic.PowerShell.Configuration.LauncherSettings]))
                    }
                    'LocalUserPasswords' {
                        [Thycotic.PowerShell.Configuration.LocalUserPasswords](. $FilterTssResponse $restResponse.localUserPasswords ([Thycotic.PowerShell.Configuration.LocalUserPasswords]))
                    }
                    'PermissionOptions' {
                        [Thycotic.PowerShell.Configuration.PermissionOptions](. $FilterTssResponse $restResponse.permissionOptions ([Thycotic.PowerShell.Configuration.PermissionOptions]))
                    }
                    'UserExperience' {
                        [Thycotic.PowerShell.Configuration.UserExperience](. $FilterTssResponse $restResponse.userExperience ([Thycotic.PowerShell.Configuration.UserExperience]))
                    }
                    'UserInterface' {
                        [Thycotic.PowerShell.Configuration.UserInterface](. $FilterTssResponse $restResponse.userInterface ([Thycotic.PowerShell.Configuration.UserInterface]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}