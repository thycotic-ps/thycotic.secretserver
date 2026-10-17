function Get-TssServerSettingsCapability {
    <#
    .SYNOPSIS
    Get which Secret Server settings sections can be exported or imported

    .DESCRIPTION
    Without a settings file, returns the settings sections the current user can export.
    With a settings file from Export-TssServerSettings (-Path or -FileText), returns the sections in that file and whether each can be imported.
    Each section is a field descriptor: value holds the section content from the file, readOnly and readOnlyReason say why a section is unavailable.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Path
    Path of a settings file saved from the ExportedSecretSettingsFileText of Export-TssServerSettings

    .PARAMETER FileText
    Settings file text, the ExportedSecretSettingsFileText of Export-TssServerSettings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssServerSettingsCapability -TssSession $session

    Returns the settings sections the current user can export

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssServerSettingsCapability -TssSession $session -Path ./ss-settings.json

    Returns the sections in ss-settings.json and whether each can be imported

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $export = Export-TssServerSettings -TssSession $session -Section TicketSystem -Password (Read-Host -AsSecureString)
    Get-TssServerSettingsCapability -TssSession $session -FileText $export.ExportedSecretSettingsFileText

    Checks which sections of a fresh export can be imported

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Get-TssServerSettingsCapability

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Get-TssServerSettingsCapability.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'export')]
    [OutputType('Thycotic.PowerShell.SecretServerSettings.Capability')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'path')]
        [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
        [string]
        $Path,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'text')]
        [Alias('ExportedSecretSettingsFileText')]
        [ValidateNotNullOrEmpty()]
        [string]
        $FileText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'secretserversettings', 'capabilities' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = switch ($PSCmdlet.ParameterSetName) {
                'path' { @{ isImport = $true; file = (Get-Content -LiteralPath $Path -Raw) } }
                'text' { @{ isImport = $true; file = $FileText } }
                default { @{ isImport = $false; file = '' } }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: the settings file can carry sensitive values)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssServerSettingsCapability request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretServerSettings.Capability](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretServerSettings.Capability]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
