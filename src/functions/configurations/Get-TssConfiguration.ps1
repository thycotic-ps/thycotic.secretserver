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
                        $typeProps = [Thycotic.PowerShell.Configuration.General].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.General]($restResponse | Select-Object -Property $typeProps)
                    }
                    'Application' {
                        $typeProps = [Thycotic.PowerShell.Configuration.ApplicationSettings].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.ApplicationSettings]($restResponse.applicationSettings | Select-Object -Property $typeProps)
                    }
                    'Email' {
                        $typeProps = [Thycotic.PowerShell.Configuration.EmailSettings].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.EmailSettings]($restResponse.emailSettings | Select-Object -Property $typeProps)
                    }
                    'Folders' {
                        $typeProps = [Thycotic.PowerShell.Configuration.Folders].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.Folders]($restResponse.folders | Select-Object -Property $typeProps)
                    }
                    'Launcher' {
                        $typeProps = [Thycotic.PowerShell.Configuration.LauncherSettings].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.LauncherSettings]($restResponse.launcherSettings | Select-Object -Property $typeProps)
                    }
                    'LocalUserPasswords' {
                        $typeProps = [Thycotic.PowerShell.Configuration.LocalUserPasswords].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.LocalUserPasswords]($restResponse.localUserPasswords | Select-Object -Property $typeProps)
                    }
                    'PermissionOptions' {
                        $typeProps = [Thycotic.PowerShell.Configuration.PermissionOptions].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.PermissionOptions]($restResponse.permissionOptions | Select-Object -Property $typeProps)
                    }
                    'UserExperience' {
                        $typeProps = [Thycotic.PowerShell.Configuration.UserExperience].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.UserExperience]($restResponse.userExperience | Select-Object -Property $typeProps)
                    }
                    'UserInterface' {
                        $typeProps = [Thycotic.PowerShell.Configuration.UserInterface].GetProperties().Name
                        [Thycotic.PowerShell.Configuration.UserInterface]($restResponse.userInterface | Select-Object -Property $typeProps)
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}