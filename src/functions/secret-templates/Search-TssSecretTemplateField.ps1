function Search-TssSecretTemplateField {
    <#
    .SYNOPSIS
    Search secret template fields

    .DESCRIPTION
    Returns secret template fields, filtered by template or secret.
    Use -Basic for the reduced field list (ID, name, slug name, sort order, active) that basic users can read.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeInactive
    Include inactive fields

    .PARAMETER SecretId
    Return only fields of the template used by this secret ID

    .PARAMETER SecretTemplateId
    Return only fields of this secret template ID

    .PARAMETER Basic
    Use the basic field search, which returns ID, name, slug name, sort order and active only

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplateField -TssSession $session -SecretTemplateId 6001

    Get the active fields of template 6001

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplateField -TssSession $session -SecretTemplateId 6001 -IncludeInactive -Basic

    Get the basic details of every field of template 6001, inactive fields included

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.SecretTemplates.FieldSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'Basic')]
        [switch]
        $IncludeInactive,

        [Parameter(ParameterSetName = 'Default')]
        [int]
        $SecretId,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'Basic')]
        [Alias('TemplateId')]
        [int]
        $SecretTemplateId,

        [Parameter(Mandatory, ParameterSetName = 'Basic')]
        [switch]
        $Basic
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'Basic' {
                    $uri = $TssSession.ApiUrl, 'secret-templates', 'fields', 'search-basic' -join '/'
                    $queryParams = @()
                    $queryParams += "take=$($TssSession.Take)"
                    switch ($tssParams.Keys) {
                        'IncludeInactive' {
                            $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                        }
                        'SecretTemplateId' {
                            $queryParams += "filter.secretTemplateId=$($SecretTemplateId)"
                        }
                    }
                    if ($queryParams) {
                        $uri = $uri, ($queryParams -join '&') -join '?'
                    }
                }
                default {
                    $uri = $TssSession.ApiUrl, 'secret-templates', 'fields', 'search' -join '/'
                    $queryParams = @()
                    $queryParams += "take=$($TssSession.Take)"
                    switch ($tssParams.Keys) {
                        'IncludeInactive' {
                            $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                        }
                        'SecretId' {
                            $queryParams += "filter.secretId=$($SecretId)"
                        }
                        'SecretTemplateId' {
                            $queryParams += "filter.secretTemplateId=$($SecretTemplateId)"
                        }
                    }
                    if ($queryParams) {
                        $uri = $uri, ($queryParams -join '&') -join '?'
                    }
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretTemplateField request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretTemplates.FieldSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecretTemplates.FieldSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
