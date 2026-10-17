function Set-TssSecretTemplateExtendedMapping {
    <#
    .SYNOPSIS
    Set the field assignments of an extended mapping

    .DESCRIPTION
    Replaces the field assignments of an existing extended mapping on a secret template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ExtendedTypeId
    Extended type ID (Search-TssSecretTemplateExtendedType lists them)

    .PARAMETER SecretTemplateId
    Secret template ID

    .PARAMETER Fields
    Field assignments: objects or hashtables with ExtendedFieldId (a field of the extended type) and SecretFieldId (a field of the secret template). The Fields of Get-TssSecretTemplateExtendedMappingStub output can be passed after SecretFieldId is filled in

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretTemplateExtendedMapping -TssSession $session -SecretTemplateId 6 -ExtendedTypeId 1 -Fields @{ ExtendedFieldId = 1; SecretFieldId = 110 }, @{ ExtendedFieldId = 2; SecretFieldId = 109 }

    Maps extended field 1 of extended type 1 onto field 110 of secret template 6 and keeps field 2 on field 109

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateExtendedMapping

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateExtendedMapping.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
        $SecretTemplateId,

        [Parameter(Mandatory)]
        [object[]]
        $Fields
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
            $invokeParams.Method = 'PATCH'
            $unassigned = @($Fields | Where-Object { $null -eq $_.SecretFieldId })
            if ($unassigned) {
                Write-Error "Every entry in Fields needs a SecretFieldId; missing for ExtendedFieldId $($unassigned.ExtendedFieldId -join ', ')"
                return
            }
            $fieldMap = foreach ($field in $Fields) {
                @{
                    extendedFieldId = $field.ExtendedFieldId
                    secretFieldId   = $field.SecretFieldId
                }
            }
            $body = @{ data = @{ fields = @{ dirty = $true; value = @($fieldMap) } } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template extended mapping: $ExtendedTypeId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretTemplateExtendedMapping request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.ExtendedMapping](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.ExtendedMapping]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
