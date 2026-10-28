function Remove-TssSecretTemplateExtendedMapping {
    <#
    .SYNOPSIS
    Remove an extended mapping from a secret template

    .DESCRIPTION
    Deletes the mapping between a secret template and an extended type. The template and its fields are not changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ExtendedTypeId
    Extended type ID (Search-TssSecretTemplateExtendedType lists them)

    .PARAMETER SecretTemplateId
    Secret template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssSecretTemplateExtendedMapping -TssSession $session -SecretTemplateId 6 -ExtendedTypeId 1

    Removes the mapping of extended type 1 from secret template 6

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplateExtendedMapping -TssSession $session -SecretTemplateId 6 | Remove-TssSecretTemplateExtendedMapping -TssSession $session

    Removes every extended mapping from secret template 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssSecretTemplateExtendedMapping

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssSecretTemplateExtendedMapping.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.ExtendedMappingDelete')]
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
            $invokeParams.Method = 'DELETE'
            if ($PSCmdlet.ShouldProcess("Secret template extended mapping: $ExtendedTypeId", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssSecretTemplateExtendedMapping request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.ExtendedMappingDelete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.ExtendedMappingDelete]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
