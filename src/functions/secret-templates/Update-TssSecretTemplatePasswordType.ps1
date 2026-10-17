function Update-TssSecretTemplatePasswordType {
    <#
    .SYNOPSIS
    Assign a password type to a secret template, replacing its field mappings

    .DESCRIPTION
    Assigns a password type (password changer) to a secret template together with the mapping of every template field to a password type field.
    The request replaces the current assignment. -FieldMapping must have one entry for each field of the template; map the fields the password type does not use to -1. To change single settings, such as heartbeat or remote password changing intervals, use Set-TssSecretTemplatePasswordType instead.
    Returns the secret template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template ID

    .PARAMETER PasswordTypeId
    Password type (password changer) ID to assign

    .PARAMETER FieldMapping
    Mapping of every secret template field ID (keys) to a password type field ID, or -1 for fields the password type does not use (values)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $mapping = @{ }
    (Get-TssSecretTemplate -TssSession $session -Id 6007).Fields | ForEach-Object { $mapping[$_.SecretTemplateFieldId] = -1 }
    $mapping[108] = 26
    $mapping[110] = 27
    $mapping[111] = 28
    Update-TssSecretTemplatePasswordType -TssSession $session -Id 6007 -PasswordTypeId 9 -FieldMapping $mapping

    Assign password type 9 to template 6007, map its machine, password and username fields, and leave the other fields unmapped
    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplatePasswordType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplatePasswordType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Template')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateId', 'TemplateId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $PasswordTypeId,

        [Parameter(Mandatory)]
        [hashtable]
        $FieldMapping
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
            $uri = $TssSession.ApiUrl, 'secret-templates', 'password-type', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $mappings = @{ }
            foreach ($secretFieldId in $FieldMapping.Keys) {
                $mappings["$([int]$secretFieldId)"] = [int]$FieldMapping[$secretFieldId]
            }
            $body = @{
                passwordTypeId                         = $PasswordTypeId
                secretFieldPasswordTypeFieldDictionary = $mappings
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretTemplatePasswordType request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Template](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Template]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
