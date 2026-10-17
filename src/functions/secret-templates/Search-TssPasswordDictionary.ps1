function Search-TssPasswordDictionary {
    <#
    .SYNOPSIS
    Search custom password dictionaries

    .DESCRIPTION
    Returns the ID and name of every custom password dictionary.
    Items are not included; Get-TssPasswordDictionary returns the items of one dictionary.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPasswordDictionary -TssSession $session

    Returns every custom password dictionary

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPasswordDictionary -TssSession $session | Where-Object Name -EQ 'Blocked words' | Get-TssPasswordDictionary -TssSession $session

    Returns the items of the password dictionary named "Blocked words"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssPasswordDictionary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssPasswordDictionary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.PasswordDictionary[]')]
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
            $uri = $TssSession.ApiUrl, 'secret-templates', 'password-requirements', 'password-dictionaries' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssPasswordDictionary request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretTemplates.PasswordDictionary[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.PasswordDictionary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
