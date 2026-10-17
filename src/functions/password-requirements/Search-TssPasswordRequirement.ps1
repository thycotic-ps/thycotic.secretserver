function Search-TssPasswordRequirement {
    <#
    .SYNOPSIS
    Search password requirements

    .DESCRIPTION
    Returns every password requirement with its ID, name, description and whether it is the default.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPasswordRequirement -TssSession $session

    Returns all password requirements

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/password-requirements/Search-TssPasswordRequirement

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/password-requirements/Search-TssPasswordRequirement.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PasswordRequirements.PasswordRequirementItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
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
                Write-Warning 'Issue with Search-TssPasswordRequirement request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PasswordRequirements.PasswordRequirementItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PasswordRequirements.PasswordRequirementItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
