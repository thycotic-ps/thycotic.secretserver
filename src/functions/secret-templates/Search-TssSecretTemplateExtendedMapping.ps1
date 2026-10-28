function Search-TssSecretTemplateExtendedMapping {
    <#
    .SYNOPSIS
    Search the extended mappings of a secret template

    .DESCRIPTION
    Returns every extended mapping of a secret template with its field assignments.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretTemplateId
    Secret template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplateExtendedMapping -TssSession $session -SecretTemplateId 6

    Returns the extended mappings of secret template 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateExtendedMapping

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateExtendedMapping.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.ExtendedMappingSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $SecretTemplateId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates', 'extended-mappings' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SecretTemplateId' {
                    $queryParams += "filter.secretTemplateId=$($SecretTemplateId)"
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
                Write-Warning 'Issue with Search-TssSecretTemplateExtendedMapping request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretTemplates.ExtendedMappingSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecretTemplates.ExtendedMappingSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
