function Set-TssPasswordRequirement {
    <#
    .SYNOPSIS
    Update a password requirement

    .DESCRIPTION
    Changes only the fields you pass; everything else is left unchanged.
    Use Update-TssPasswordRequirementRule to change the rules.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password requirement ID

    .PARAMETER AllowedCharacterSetId
    ID of the character set passwords are built from (see Search-TssCharacterSet); 1 is the built-in Default set

    .PARAMETER Description
    Description

    .PARAMETER DifokMinDifferentCharacters
    Minimum number of characters that must differ from the previous password when EnforceDifok is set

    .PARAMETER EnforceDifok
    Require a new password to differ from the previous one by DifokMinDifferentCharacters characters

    .PARAMETER IsDefault
    Make this the default password requirement

    .PARAMETER MaxPasswordLength
    Maximum password length, at least MinPasswordLength

    .PARAMETER MinimumRequiredCharacterSets
    Number of MinimumOf rules a password must satisfy when AllowMinimumCharacterSets is set

    .PARAMETER MinPasswordLength
    Minimum password length, greater than 0

    .PARAMETER Name
    New name

    .PARAMETER PasswordDictionaries
    IDs of the password dictionaries checked when PreventDictionaryWords is set

    .PARAMETER PreventDictionaryWords
    Reject passwords containing dictionary words

    .PARAMETER PreventSequentialPattern
    Reject passwords containing sequential patterns such as abc or 123

    .PARAMETER PreventSpatialPattern
    Reject passwords containing keyboard patterns such as qwerty

    .PARAMETER PreventUsername
    Reject passwords containing the username

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPasswordRequirement -TssSession $session -Id 4 -MinPasswordLength 24 -PreventDictionaryWords

    Raises the minimum length of password requirement ID 4 to 24 and turns on the dictionary check

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Set-TssPasswordRequirement

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Set-TssPasswordRequirement.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'Setting names from the REST model, not a credential pair')]
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.PasswordRequirements.PasswordRequirement')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('PasswordRequirementId')]
        [int]
        $Id,

        [int]
        $AllowedCharacterSetId,

        [string]
        $Description,

        [int]
        $DifokMinDifferentCharacters,

        [switch]
        $EnforceDifok,

        [switch]
        $IsDefault,

        [int]
        $MaxPasswordLength,

        [int]
        $MinimumRequiredCharacterSets,

        [int]
        $MinPasswordLength,

        [string]
        $Name,

        [int[]]
        $PasswordDictionaries,

        [switch]
        $PreventDictionaryWords,

        [switch]
        $PreventSequentialPattern,

        [switch]
        $PreventSpatialPattern,

        [switch]
        $PreventUsername
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'password-requirements', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowedCharacterSetId' {
                    $body.data.Add('allowedCharacterSet', @{ dirty = $true; value = $AllowedCharacterSetId })
                }
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'DifokMinDifferentCharacters' {
                    $body.data.Add('difokMinDifferentCharacters', @{ dirty = $true; value = $DifokMinDifferentCharacters })
                }
                'EnforceDifok' {
                    $body.data.Add('enforceDifok', @{ dirty = $true; value = [boolean]$EnforceDifok })
                }
                'IsDefault' {
                    $body.data.Add('isDefault', @{ dirty = $true; value = [boolean]$IsDefault })
                }
                'MaxPasswordLength' {
                    $body.data.Add('maxPasswordLength', @{ dirty = $true; value = $MaxPasswordLength })
                }
                'MinimumRequiredCharacterSets' {
                    $body.data.Add('minimumRequiredCharacterSets', @{ dirty = $true; value = $MinimumRequiredCharacterSets })
                }
                'MinPasswordLength' {
                    $body.data.Add('minPasswordLength', @{ dirty = $true; value = $MinPasswordLength })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'PasswordDictionaries' {
                    $body.data.Add('passwordDictionaries', @{ dirty = $true; value = $PasswordDictionaries })
                }
                'PreventDictionaryWords' {
                    $body.data.Add('preventDictionaryWords', @{ dirty = $true; value = [boolean]$PreventDictionaryWords })
                }
                'PreventSequentialPattern' {
                    $body.data.Add('preventSequentialPattern', @{ dirty = $true; value = [boolean]$PreventSequentialPattern })
                }
                'PreventSpatialPattern' {
                    $body.data.Add('preventSpatialPattern', @{ dirty = $true; value = [boolean]$PreventSpatialPattern })
                }
                'PreventUsername' {
                    $body.data.Add('preventUsername', @{ dirty = $true; value = [boolean]$PreventUsername })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Password requirement: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPasswordRequirement request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PasswordRequirements.PasswordRequirement](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PasswordRequirements.PasswordRequirement]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
