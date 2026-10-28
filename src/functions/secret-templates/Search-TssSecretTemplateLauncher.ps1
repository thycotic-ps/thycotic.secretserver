function Search-TssSecretTemplateLauncher {
    <#
    .SYNOPSIS
    Search the launchers of a secret template, or the available launcher types

    .DESCRIPTION
    Returns the launchers configured on a secret template, with their field mappings, input restrictions and connect-as settings. -SecretTemplateId is required for this search.
    With -LauncherType, returns the launcher types available on the Secret Server instead, such as PuTTY or Remote Desktop, with their IDs.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretTemplateId
    Secret template ID whose launchers to return

    .PARAMETER LauncherType
    Return the available launcher types instead of the launchers of a template

    .PARAMETER ApplicationName
    Return only launcher types for this application name

    .PARAMETER IncludeInactive
    Include inactive launcher types

    .PARAMETER IncludeSystemLaunchers
    Include system launcher types

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007

    Get the launchers configured on template 6007

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplateLauncher -TssSession $session -LauncherType -IncludeInactive

    List every launcher type, inactive ones included

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateLauncher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateLauncher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.SecretTemplates.LauncherSummary[]', ParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.SecretTemplates.LauncherType[]', ParameterSetName = 'LauncherType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Alias('TemplateId')]
        [int]
        $SecretTemplateId,

        [Parameter(Mandatory, ParameterSetName = 'LauncherType')]
        [switch]
        $LauncherType,

        [Parameter(ParameterSetName = 'LauncherType')]
        [string]
        $ApplicationName,

        [Parameter(ParameterSetName = 'LauncherType')]
        [switch]
        $IncludeInactive,

        [Parameter(ParameterSetName = 'LauncherType')]
        [switch]
        $IncludeSystemLaunchers
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($PSCmdlet.ParameterSetName) {
                'LauncherType' {
                    $uri = $TssSession.ApiUrl, 'secret-templates', 'launcher-types' -join '/'
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                    $queryParams += "filter.includeSystemLaunchers=$([boolean]$IncludeSystemLaunchers)"
                    switch ($tssParams.Keys) {
                        'ApplicationName' {
                            $queryParams += "filter.applicationName=$([uri]::EscapeDataString($ApplicationName))"
                        }
                    }
                }
                default {
                    $uri = $TssSession.ApiUrl, 'secret-templates', 'launchers' -join '/'
                    $queryParams += "filter.secretTemplateId=$SecretTemplateId"
                }
            }
            $uri = $uri, ($queryParams -join '&') -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretTemplateLauncher request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                if ($PSCmdlet.ParameterSetName -eq 'LauncherType') {
                    [Thycotic.PowerShell.SecretTemplates.LauncherType[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecretTemplates.LauncherType]))
                } else {
                    [Thycotic.PowerShell.SecretTemplates.LauncherSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecretTemplates.LauncherSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
