function Convert-TssSecretTemplate {
    <#
    .SYNOPSIS
    Convert secrets to a different secret template

    .DESCRIPTION
    Converts one or more secrets to another secret template, mapping fields of the current template to fields of the new one.
    Secret Server runs the conversion as a background task and returns a secret ID and the task ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FieldMapping
    Field mapping, one hashtable per field: @{ sourceFieldId = <id>; destinationFieldId = <id> }. Field IDs come from Get-TssSecretTemplate

    .PARAMETER FolderId
    ID of the folder for the converted secret

    .PARAMETER Bulk
    Convert several secrets in one job. Use it when SecretId holds more than one ID

    .PARAMETER NewSecretName
    New name for the converted secret, single secret conversions only

    .PARAMETER SecretId
    ID of each secret to convert

    .PARAMETER SecretTemplateId
    ID of the secret template to convert to

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $map = @(@{ sourceFieldId = 87; destinationFieldId = 108 }, @{ sourceFieldId = 88; destinationFieldId = 109 })
    Convert-TssSecretTemplate -TssSession $session -SecretId 42 -SecretTemplateId 6003 -FieldMapping $map

    Converts secret 42 to template 6003, copying two fields

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Convert-TssSecretTemplate -TssSession $session -SecretId 42, 43, 44 -SecretTemplateId 6003 -FieldMapping $map -Bulk

    Converts three secrets to template 6003 in one job

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Convert-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Convert-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.TemplateConversion')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [object[]]
        $FieldMapping,

        [int]
        $FolderId,

        [switch]
        $Bulk,

        [string]
        $NewSecretName,

        [Parameter(Mandatory)]
        [int[]]
        $SecretId,

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
            $uri = $TssSession.ApiUrl, 'secrets', 'convert-template' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'FieldMapping' {
                    $body.data.Add('fieldMapping', $FieldMapping)
                }
                'FolderId' {
                    $body.data.Add('folderId', $FolderId)
                }
                'Bulk' {
                    $body.data.Add('isBulk', [boolean]$Bulk)
                }
                'NewSecretName' {
                    $body.data.Add('newSecretName', $NewSecretName)
                }
                'SecretId' {
                    $body.data.Add('secretIds', $SecretId)
                }
                'SecretTemplateId' {
                    $body.data.Add('secretTemplateId', $SecretTemplateId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Convert-TssSecretTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.TemplateConversion](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.TemplateConversion]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
