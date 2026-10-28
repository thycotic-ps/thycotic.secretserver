function Get-TssPasswordRequirementAudit {
    <#
    .SYNOPSIS
    Get audit entries for a password requirement

    .DESCRIPTION
    Returns the audit records for the given password requirement.
    Creating a password requirement records a Create entry, and setting rules or password dictionaries at creation adds Edit entries; the built-in password requirement has no records until it is changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password requirement ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPasswordRequirementAudit -TssSession $session -Id 4

    Returns the audit records for password requirement ID 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Get-TssPasswordRequirementAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Get-TssPasswordRequirementAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PasswordRequirements.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('PasswordRequirementId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'password-requirements', $currentId, 'audit' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssPasswordRequirementAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.PasswordRequirements.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PasswordRequirements.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
