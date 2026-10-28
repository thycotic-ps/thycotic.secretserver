function Update-TssSecretTemplate {
    <#
    .SYNOPSIS
    Update the settings of a secret template

    .DESCRIPTION
    Changes one or more settings of a secret template, such as name, description, secret name pattern, expiration, one-time password and SSH key settings. Only the parameters you pass are changed.
    Set-TssSecretTemplate only changes the active state; this command covers the full set of template settings.
    Returns the updated template detail.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template ID

    .PARAMETER Active
    Set the template active, or inactive with -Active:$false

    .PARAMETER DaysToShowAdExpiration
    Number of days before an Active Directory password expires to start showing a warning

    .PARAMETER Description
    Template description

    .PARAMETER ExpirationChangeRequiredOnFieldId
    Secret Template Field ID that will require change on Expiration

    .PARAMETER ExpirationDays
    Number of days after which secrets expire. Applied when ExpirationChangeRequiredOnFieldId is a valid field

    .PARAMETER ExpirationEnabled
    Expiration enabled

    .PARAMETER IconName
    Icon name to show for secret

    .PARAMETER Name
    Template name

    .PARAMETER NamePattern
    Regex pattern enforced on secret names

    .PARAMETER NamePatternErrorMessage
    Error shown when name doesn't match pattern

    .PARAMETER OneTimePasswordDuration
    Duration in seconds that the One Time Password is valid, updated when one time password is enabled

    .PARAMETER OneTimePasswordEnabled
    One time password enabled

    .PARAMETER OneTimePasswordHash
    Hash algorithm used to generate the one-time password. Applied when one-time passwords are enabled

    .PARAMETER OneTimePasswordLength
    Length of the generated One Time Password, updated when one time password is enabled

    .PARAMETER PermissionRequiredToEditPasswordChangeConfiguration
    Permission required to edit password change configuration

    .PARAMETER SaveAllNameHistory
    Indicates that all Secret Name history will be saved

    .PARAMETER SecretNameHistoryLength
    The number of Secret Names to be saved. If SaveAllNameHistory is true, this will be ignored

    .PARAMETER SshKeyAlgorithm
    Algorithm of the SSH Key, updated when the template contains a private SSH Key

    .PARAMETER SshKeyFormat
    Format of the SSH Key, updated when the template contains a private SSH Key

    .PARAMETER SshKeySize
    Size of the SSH Key in bits, updated when the template contains a private SSH Key

    .PARAMETER TicketSystemScriptArgs
    A list of field slugs that will be passed as parameters to a PowerShell ticket system

    .PARAMETER ValidatePasswordRequirementsOnCreate
    Validate password requirements on create

    .PARAMETER ValidatePasswordRequirementsOnEdit
    Validate password requirements on edit

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretTemplate -TssSession $session -Id 6001 -Description 'Domain service accounts' -NamePattern '^svc-' -NamePatternErrorMessage 'Secret names must start with svc-'

    Change the description of template 6001 and require secret names to start with svc-

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Detail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateId', 'TemplateId')]
        [int]
        $Id,

        [switch]
        $Active,

        [int]
        $DaysToShowAdExpiration,

        [string]
        $Description,

        [int]
        $ExpirationChangeRequiredOnFieldId,

        [int]
        $ExpirationDays,

        [switch]
        $ExpirationEnabled,

        [string]
        $IconName,

        [string]
        $Name,

        [string]
        $NamePattern,

        [string]
        $NamePatternErrorMessage,

        [int]
        $OneTimePasswordDuration,

        [switch]
        $OneTimePasswordEnabled,

        [ValidateSet('SHA1', 'SHA256', 'SHA512')]
        [string]
        $OneTimePasswordHash,

        [int]
        $OneTimePasswordLength,

        [string]
        $PermissionRequiredToEditPasswordChangeConfiguration,

        [switch]
        $SaveAllNameHistory,

        [int]
        $SecretNameHistoryLength,

        [string]
        $SshKeyAlgorithm,

        [string]
        $SshKeyFormat,

        [ValidateSet('Key1024', 'Key2048', 'Key4096')]
        [string]
        $SshKeySize,

        [string]
        $TicketSystemScriptArgs,

        [switch]
        $ValidatePasswordRequirementsOnCreate,

        [switch]
        $ValidatePasswordRequirementsOnEdit
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace 'v1$','v2'), 'secret-templates', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'DaysToShowAdExpiration' {
                    $body.data.Add('daysToShowAdExpiration', @{ dirty = $true; value = $DaysToShowAdExpiration })
                }
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'ExpirationChangeRequiredOnFieldId' {
                    $body.data.Add('expirationChangeRequiredOnFieldId', @{ dirty = $true; value = $ExpirationChangeRequiredOnFieldId })
                }
                'ExpirationDays' {
                    $body.data.Add('expirationDays', @{ dirty = $true; value = $ExpirationDays })
                }
                'ExpirationEnabled' {
                    $body.data.Add('expirationEnabled', @{ dirty = $true; value = [boolean]$ExpirationEnabled })
                }
                'IconName' {
                    $body.data.Add('iconName', @{ dirty = $true; value = $IconName })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'NamePattern' {
                    $body.data.Add('namePattern', @{ dirty = $true; value = $NamePattern })
                }
                'NamePatternErrorMessage' {
                    $body.data.Add('namePatternErrorMessage', @{ dirty = $true; value = $NamePatternErrorMessage })
                }
                'OneTimePasswordDuration' {
                    $body.data.Add('oneTimePasswordDuration', @{ dirty = $true; value = $OneTimePasswordDuration })
                }
                'OneTimePasswordEnabled' {
                    $body.data.Add('oneTimePasswordEnabled', @{ dirty = $true; value = [boolean]$OneTimePasswordEnabled })
                }
                'OneTimePasswordHash' {
                    $body.data.Add('oneTimePasswordHash', @{ dirty = $true; value = $OneTimePasswordHash })
                }
                'OneTimePasswordLength' {
                    $body.data.Add('oneTimePasswordLength', @{ dirty = $true; value = $OneTimePasswordLength })
                }
                'PermissionRequiredToEditPasswordChangeConfiguration' {
                    $body.data.Add('permissionRequiredToEditPasswordChangeConfiguration', @{ dirty = $true; value = $PermissionRequiredToEditPasswordChangeConfiguration })
                }
                'SaveAllNameHistory' {
                    $body.data.Add('saveAllNameHistory', @{ dirty = $true; value = [boolean]$SaveAllNameHistory })
                }
                'SecretNameHistoryLength' {
                    $body.data.Add('secretNameHistoryLength', @{ dirty = $true; value = $SecretNameHistoryLength })
                }
                'SshKeyAlgorithm' {
                    $body.data.Add('sshKeyAlgorithm', @{ dirty = $true; value = $SshKeyAlgorithm })
                }
                'SshKeyFormat' {
                    $body.data.Add('sshKeyFormat', @{ dirty = $true; value = $SshKeyFormat })
                }
                'SshKeySize' {
                    $body.data.Add('sshKeySize', @{ dirty = $true; value = $SshKeySize })
                }
                'TicketSystemScriptArgs' {
                    $body.data.Add('ticketSystemScriptArgs', @{ dirty = $true; value = $TicketSystemScriptArgs })
                }
                'ValidatePasswordRequirementsOnCreate' {
                    $body.data.Add('validatePasswordRequirementsOnCreate', @{ dirty = $true; value = [boolean]$ValidatePasswordRequirementsOnCreate })
                }
                'ValidatePasswordRequirementsOnEdit' {
                    $body.data.Add('validatePasswordRequirementsOnEdit', @{ dirty = $true; value = [boolean]$ValidatePasswordRequirementsOnEdit })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Detail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Detail]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
