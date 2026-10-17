function Get-TssSecretTemplateExtendedMapping {
    <#
    .SYNOPSIS
    Get an extended mapping of a secret template

    .DESCRIPTION
    Returns how the fields of an extended type, such as an SSH key or certificate type, map onto the fields of a secret template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ExtendedTypeId
    Extended type ID (Search-TssSecretTemplateExtendedType lists them)

    .PARAMETER SecretTemplateId
    Secret template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplateExtendedMapping -TssSession $session -SecretTemplateId 6 -ExtendedTypeId 1

    Returns the mapping of extended type 1 on secret template 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateExtendedMapping

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateExtendedMapping.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.ExtendedMapping')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $ExtendedTypeId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTypeId')]
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
            $uri = $TssSession.ApiUrl, 'secret-templates', $SecretTemplateId, 'extended-mappings', $ExtendedTypeId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretTemplateExtendedMapping request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretTemplates.ExtendedMapping](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.ExtendedMapping]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
