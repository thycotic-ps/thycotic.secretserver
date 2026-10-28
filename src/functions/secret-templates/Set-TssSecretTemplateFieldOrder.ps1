function Set-TssSecretTemplateFieldOrder {
    <#
    .SYNOPSIS
    Set the order of the fields on a secret template

    .DESCRIPTION
    Sorts the fields of a secret template in the order of the field IDs given.
    Returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template ID

    .PARAMETER FieldId
    Secret template field IDs in the order to show them

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $fields = Search-TssSecretTemplateField -TssSession $session -SecretTemplateId 6001 | Sort-Object Name
    Set-TssSecretTemplateFieldOrder -TssSession $session -Id 6001 -FieldId $fields.Id

    Sort the fields of template 6001 by name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateFieldOrder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateFieldOrder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Result')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [Alias('FieldIds')]
        [int[]]
        $FieldId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates', $Id, 'fields', 'sort' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'FieldId' {
                    $body.data.Add('fieldIds', $FieldId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template field order: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretTemplateFieldOrder request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Result](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Result]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
