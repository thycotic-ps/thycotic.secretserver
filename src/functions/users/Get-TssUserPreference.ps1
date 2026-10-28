function Get-TssUserPreference {
    <#
    .SYNOPSIS
    Get a stored preference of the current user

    .DESCRIPTION
    Gets one stored UI preference of the current user by setting code, narrowed by setting name for named preferences.
    Without -SettingName only the unnamed preference of the setting code is returned.
    A preference the user has not set returns an empty record (UserSettingId 0).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IsLegacy
    Read the preference from the legacy setting store

    .PARAMETER SettingCode
    Setting code of the preference, for example favoriteFolders

    .PARAMETER SettingName
    Setting name of a named preference, sent with its setting code

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserPreference -TssSession $session -SettingCode favoriteFolders

    Returns the favorite folders preference of the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserPreference -TssSession $session -SettingCode LastSearchString -SettingName serverSearch

    Returns the preference stored under setting code LastSearchString with setting name serverSearch

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserPreference

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserPreference.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.Preference')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IsLegacy,

        [Parameter(Mandatory)]
        [string]
        $SettingCode,

        [string]
        $SettingName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'preference' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'IsLegacy' {
                    $queryParams += "isLegacy=$([boolean]$IsLegacy)"
                }
                'SettingCode' {
                    $queryParams += "settingCode=$([uri]::EscapeDataString($SettingCode))"
                }
                'SettingName' {
                    $queryParams += "settingName=$([uri]::EscapeDataString($SettingName))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssUserPreference request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Users.Preference](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.Preference]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
