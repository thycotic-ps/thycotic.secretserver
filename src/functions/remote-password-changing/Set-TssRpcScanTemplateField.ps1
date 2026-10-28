function Set-TssRpcScanTemplateField {
    <#
    .SYNOPSIS
    Map the fields of a password type to the fields of a scan item template

    .DESCRIPTION
    Set the scan item template of a password type and map each password type field to a field of that template.
    Each field entry needs PasswordTypeFieldId and ScanItemFieldId; the Fields property of Get-TssRpcPasswordType output has that shape, so read it, change the ScanItemFieldId values you want and pass it back.
    A ScanItemFieldId of 0 or null leaves that password type field unmapped. Fields you do not pass keep their current mapping. Every required field of the scan item template must stay mapped (see Get-TssRpcScanTemplate).
    The output is the updated password type.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password type ID

    .PARAMETER ScanTemplateId
    Scan item template ID the password type uses (Get-TssRpcScanTemplate)

    .PARAMETER Field
    Field mappings: objects or hashtables with PasswordTypeFieldId and ScanItemFieldId, for example the Fields property of Get-TssRpcPasswordType output

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssRpcScanTemplateField -TssSession $session -Id 9 -ScanTemplateId 10 -Field @{ PasswordTypeFieldId = 21; ScanItemFieldId = 7 }

    Keep password type 9 on scan item template 10 and map its password type field 21 to scan item field 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $passwordType = Get-TssRpcPasswordType -TssSession $session -Id 9
    ($passwordType.Fields | Where-Object Name -eq 'Machine').ScanItemFieldId = 7
    $passwordType | Set-TssRpcScanTemplateField -TssSession $session

    Read password type 9, remap its Machine field to scan item field 7 and save every mapping back

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssRpcScanTemplateField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssRpcScanTemplateField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Rpc.PasswordType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('PasswordTypeId')]
        [int]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScanItemTemplateId')]
        [int]
        $ScanTemplateId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Fields')]
        [object[]]
        $Field
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
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'scan-templates-fields', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $fieldMaps = foreach ($fieldMap in $Field) {
                @{
                    passwordTypeFieldId = [int]$fieldMap.PasswordTypeFieldId
                    scanItemFieldId     = if ($fieldMap.ScanItemFieldId) { [int]$fieldMap.ScanItemFieldId } else { $null }
                }
            }
            $body = @{
                scanTemplateId = $ScanTemplateId
                fields         = @($fieldMaps)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Password type: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssRpcScanTemplateField request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    if ($restResponse.fields) {
                        $restResponse.fields = @(
                            $restResponse.fields | ForEach-Object {
                                [Thycotic.PowerShell.Rpc.PasswordTypeField](. $FilterTssResponse $_ ([Thycotic.PowerShell.Rpc.PasswordTypeField]))
                            }
                        )
                    }
                    [Thycotic.PowerShell.Rpc.PasswordType](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Rpc.PasswordType]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
