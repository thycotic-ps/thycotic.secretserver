function Get-TssPasswordRequirement {
    <#
    .SYNOPSIS
    Get a password requirement

    .DESCRIPTION
    Returns the password requirement with the given ID, including its allowed character set, rules, password dictionaries, usage and a sample password built from it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password requirement ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPasswordRequirement -TssSession $session -Id 1

    Returns password requirement ID 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Get-TssPasswordRequirement

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Get-TssPasswordRequirement.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PasswordRequirements.PasswordRequirement')]
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
                $uri = $TssSession.ApiUrl, 'password-requirements', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssPasswordRequirement request'
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
