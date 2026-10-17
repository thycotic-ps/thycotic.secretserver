function New-TssPasswordDictionary {
    <#
    .SYNOPSIS
    Create a custom password dictionary

    .DESCRIPTION
    Uploads a text file as a new custom password dictionary. Password requirements can reference a dictionary to block the passwords it lists.
    The file holds one item per line. An item can be at most 255 characters and a dictionary at most 1,000,000 items. The name must be unique.
    The endpoint returns only a success flag, so the cmdlet makes a second call (Search-TssPasswordDictionary) to return the new dictionary.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Dictionary name, unique on the server

    .PARAMETER Path
    Path to a text file with one dictionary item per line

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssPasswordDictionary -TssSession $session -Name 'Blocked words' -Path .\BlockedWords.txt

    Creates the password dictionary "Blocked words" from the items in BlockedWords.txt and returns it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssPasswordDictionary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssPasswordDictionary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.PasswordDictionary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('DictionaryName')]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path -LiteralPath $_ -PathType Leaf })]
        [string]
        $Path
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
            $invokeParams.Method = 'POST'
            $fileName = Split-Path -Path $Path -Leaf
            $fileBytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $Path).ProviderPath)
            $body = @{
                dictionaryName = $Name
                file           = @{
                    buffer    = [System.Convert]::ToBase64String($fileBytes)
                    fileName  = $fileName
                    mediaType = 'text/plain'
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            $bodyText = "name '$Name', items from file $fileName"
            if ($PSCmdlet.ShouldProcess("Password dictionary: $Name", "$($invokeParams.Method) $uri with:`n$bodyText`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$bodyText`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssPasswordDictionary request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ("$restResponse" -match '\btrue\b') {
                    Search-TssPasswordDictionary -TssSession $TssSession | Where-Object Name -EQ $Name
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
