function New-TssPasswordRequirement {
    <#
    .SYNOPSIS
    Create a password requirement

    .DESCRIPTION
    Creates a password requirement: length bounds, the allowed character set, prevention flags and optional rules.
    The server rejects a duplicate name, a maximum length below the minimum, an unknown character set (reported as Access denied) and rules that cannot be satisfied together.
    Password requirements cannot be deleted.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AllowedCharacterSetId
    ID of the character set passwords are built from (see Search-TssCharacterSet); 1 is the built-in Default set

    .PARAMETER AllowMinimumCharacterSets
    Require only MinimumRequiredCharacterSets of the MinimumOf rules instead of all of them

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
    Display name, unique across password requirements

    .PARAMETER PasswordDictionaries
    IDs of the password dictionaries checked when PreventDictionaryWords is set

    .PARAMETER Rule
    Rules a password must satisfy. Each item has PasswordRequirementType (MinimumOf, StartsWith, EndsWith, MaxConsecutive, Repeating or RepeatingConsecutive), MinCharactersRequired and CharacterSetId (not used by Repeating and RepeatingConsecutive). Pass hashtables or the PasswordRequirementRules objects returned by Get-TssPasswordRequirement

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
    $rules = @{ PasswordRequirementType = 'MinimumOf'; MinCharactersRequired = 2; CharacterSetId = 4 }
    New-TssPasswordRequirement -TssSession $session -Name 'Service accounts' -MinPasswordLength 20 -MaxPasswordLength 32 -AllowedCharacterSetId 1 -PreventUsername -Rule $rules

    Creates a password requirement for 20 to 32 character passwords from the Default character set with at least two digits

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/New-TssPasswordRequirement

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/New-TssPasswordRequirement.ps1

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

        [Parameter(Mandatory)]
        [int]
        $AllowedCharacterSetId,

        [switch]
        $AllowMinimumCharacterSets,

        [string]
        $Description,

        [int]
        $DifokMinDifferentCharacters,

        [switch]
        $EnforceDifok,

        [switch]
        $IsDefault,

        [Parameter(Mandatory)]
        [int]
        $MaxPasswordLength,

        [int]
        $MinimumRequiredCharacterSets,

        [Parameter(Mandatory)]
        [int]
        $MinPasswordLength,

        [Parameter(Mandatory)]
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
        $PreventUsername,

        [object[]]
        $Rule
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'password-requirements' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowedCharacterSetId' {
                    $body.data.Add('allowedCharacterSetId', $AllowedCharacterSetId)
                }
                'AllowMinimumCharacterSets' {
                    $body.data.Add('allowMinimumCharacterSets', [boolean]$AllowMinimumCharacterSets)
                }
                'Description' {
                    $body.data.Add('description', $Description)
                }
                'DifokMinDifferentCharacters' {
                    $body.data.Add('difokMinDifferentCharacters', $DifokMinDifferentCharacters)
                }
                'EnforceDifok' {
                    $body.data.Add('enforceDifok', [boolean]$EnforceDifok)
                }
                'IsDefault' {
                    $body.data.Add('isDefault', [boolean]$IsDefault)
                }
                'MaxPasswordLength' {
                    $body.data.Add('maxPasswordLength', $MaxPasswordLength)
                }
                'MinimumRequiredCharacterSets' {
                    $body.data.Add('minimumRequiredCharacterSets', $MinimumRequiredCharacterSets)
                }
                'MinPasswordLength' {
                    $body.data.Add('minPasswordLength', $MinPasswordLength)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
                'PasswordDictionaries' {
                    $body.data.Add('passwordDictionaries', $PasswordDictionaries)
                }
                'PreventDictionaryWords' {
                    $body.data.Add('preventDictionaryWords', [boolean]$PreventDictionaryWords)
                }
                'PreventSequentialPattern' {
                    $body.data.Add('preventSequentialPattern', [boolean]$PreventSequentialPattern)
                }
                'PreventSpatialPattern' {
                    $body.data.Add('preventSpatialPattern', [boolean]$PreventSpatialPattern)
                }
                'PreventUsername' {
                    $body.data.Add('preventUsername', [boolean]$PreventUsername)
                }
                'Rule' {
                    $rules = @(foreach ($currentRule in $Rule) {
                        $characterSetId = $currentRule.CharacterSetId
                        if ($null -eq $characterSetId) {
                            $characterSetId = $currentRule.CharacterSet.CharacterSetId
                        }
                        @{
                            characterSetId          = $characterSetId
                            minCharactersRequired   = $currentRule.MinCharactersRequired
                            passwordRequirementType = [string]$currentRule.PasswordRequirementType
                        }
                    })
                    $body.data.Add('passwordRequirementRules', $rules)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Password requirement", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssPasswordRequirement request'
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
