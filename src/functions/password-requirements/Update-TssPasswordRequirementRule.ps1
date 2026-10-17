function Update-TssPasswordRequirementRule {
    <#
    .SYNOPSIS
    Replace the rules of a password requirement

    .DESCRIPTION
    Sends the full rule set for the password requirement.
    Rules with a PasswordRequirementRuleId are updated, rules without one are added, and existing rules left out are deleted, so pass every rule you want to keep; an empty list removes all rules.
    Start from the PasswordRequirementRules returned by Get-TssPasswordRequirement to keep the existing rules.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password requirement ID

    .PARAMETER Rule
    Rules a password must satisfy. Each item has PasswordRequirementType (MinimumOf, StartsWith, EndsWith, MaxConsecutive, Repeating or RepeatingConsecutive), MinCharactersRequired and CharacterSetId (not used by Repeating and RepeatingConsecutive). Pass hashtables or the PasswordRequirementRules objects returned by Get-TssPasswordRequirement; items with a PasswordRequirementRuleId update that rule

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $req = Get-TssPasswordRequirement -TssSession $session -Id 4 -ErrorAction Stop
    $rules = @($req.PasswordRequirementRules) + @{ PasswordRequirementType = 'StartsWith'; MinCharactersRequired = 1; CharacterSetId = 5 }
    Update-TssPasswordRequirementRule -TssSession $session -Id 4 -Rule $rules

    Keeps the rules of password requirement ID 4 and adds one requiring passwords to start with an upper case letter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Update-TssPasswordRequirementRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Update-TssPasswordRequirementRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
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

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
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
            $uri = $TssSession.ApiUrl, 'password-requirements', $Id, 'rules' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $rules = @(foreach ($currentRule in $Rule) {
                $characterSetId = $currentRule.CharacterSetId
                if ($null -eq $characterSetId) {
                    $characterSetId = $currentRule.CharacterSet.CharacterSetId
                }
                $ruleId = $currentRule.PasswordRequirementRuleId
                if ($null -eq $ruleId) {
                    $ruleId = 0
                }
                @{
                    passwordRequirementRuleId = $ruleId
                    characterSetId            = $characterSetId
                    minCharactersRequired     = $currentRule.MinCharactersRequired
                    passwordRequirementType   = [string]$currentRule.PasswordRequirementType
                }
            })
            $body = @{ data = $rules }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Password requirement: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssPasswordRequirementRule request'
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
