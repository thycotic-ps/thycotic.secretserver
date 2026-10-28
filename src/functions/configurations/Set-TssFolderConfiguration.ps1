function Set-TssFolderConfiguration {
    <#
    .SYNOPSIS
    Set the folder configuration

    .DESCRIPTION
    Set the personal folder and folder permission options of the Folders configuration.
    Only the parameters you pass are sent. Returns the folder configuration after the update; Get-TssConfiguration -Type Folders reads it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EnablePersonalFolders
    Create a personal folder for every user; pass -EnablePersonalFolders:$false to turn it off

    .PARAMETER PersonalFolderName
    Name of the root folder that holds the personal folders

    .PARAMETER PersonalFolderNameOption
    How each personal folder is named: DisplayName or UsernameAndDomain

    .PARAMETER PersonalFolderWarning
    Warning text shown when ShowPersonalFolderWarning is on

    .PARAMETER RequireViewFolderPermission
    Users only see folders they have View permission on

    .PARAMETER ShowPersonalFolderWarning
    Show the personal folder warning text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderConfiguration -TssSession $session -PersonalFolderNameOption UsernameAndDomain

    Name personal folders by user name and domain

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssFolderConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssFolderConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.Folders')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $EnablePersonalFolders,

        [string]
        $PersonalFolderName,

        [ValidateSet('DisplayName', 'UsernameAndDomain')]
        [string]
        $PersonalFolderNameOption,

        [string]
        $PersonalFolderWarning,

        [switch]
        $RequireViewFolderPermission,

        [switch]
        $ShowPersonalFolderWarning
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'folder' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EnablePersonalFolders' {
                    $body.data.Add('enablePersonalFolders', @{ dirty = $true; value = [boolean]$EnablePersonalFolders })
                }
                'PersonalFolderName' {
                    $body.data.Add('personalFolderName', @{ dirty = $true; value = $PersonalFolderName })
                }
                'PersonalFolderNameOption' {
                    $body.data.Add('personalFolderNameOption', @{ dirty = $true; value = $PersonalFolderNameOption })
                }
                'PersonalFolderWarning' {
                    $body.data.Add('personalFolderWarning', @{ dirty = $true; value = $PersonalFolderWarning })
                }
                'RequireViewFolderPermission' {
                    $body.data.Add('requireViewFolderPermission', @{ dirty = $true; value = [boolean]$RequireViewFolderPermission })
                }
                'ShowPersonalFolderWarning' {
                    $body.data.Add('showPersonalFolderWarning', @{ dirty = $true; value = [boolean]$ShowPersonalFolderWarning })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Folder configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssFolderConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.Folders](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.Folders]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
