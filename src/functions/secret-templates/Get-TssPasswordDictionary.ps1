function Get-TssPasswordDictionary {
    <#
    .SYNOPSIS
    Get the items of a custom password dictionary

    .DESCRIPTION
    Returns the items of a custom password dictionary, one string per item, sorted alphabetically ignoring case. Secret Server does not keep the order of the uploaded file.
    Use Search-TssPasswordDictionary to find dictionary IDs and names.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password dictionary ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPasswordDictionary -TssSession $session -Id 3

    Returns the items of password dictionary 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPasswordDictionary -TssSession $session -Id 3 | Set-Content -Path .\BlockedWords.txt

    Saves the items of password dictionary 3 to a text file, one item per line

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssPasswordDictionary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssPasswordDictionary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DictionaryId')]
        [int]
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
            $uri = $TssSession.ApiUrl, 'secret-templates', 'password-requirements', 'password-dictionaries', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            $restResponse = $null
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPasswordDictionary request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                $restResponse -split '\r?\n' | Where-Object { $_ }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
