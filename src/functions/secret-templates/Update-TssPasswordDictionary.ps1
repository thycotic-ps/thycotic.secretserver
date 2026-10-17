function Update-TssPasswordDictionary {
    <#
    .SYNOPSIS
    Update a custom password dictionary

    .DESCRIPTION
    Replaces the name and items of a custom password dictionary with a name and a text file. Password requirements that use the dictionary keep using it.
    The file holds one item per line. An item can be at most 255 characters and a dictionary at most 1,000,000 items. The name must be unique.
    The endpoint returns only a success flag, so the cmdlet makes a second call (Search-TssPasswordDictionary) to return the updated dictionary.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password dictionary ID

    .PARAMETER Name
    Dictionary name, unique on the server. Pass the current name to keep it

    .PARAMETER Path
    Path to a text file with one dictionary item per line; replaces every current item

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssPasswordDictionary -TssSession $session -Id 3 -Name 'Blocked words' -Path .\BlockedWords.txt

    Replaces the items of password dictionary 3 with the items in BlockedWords.txt and keeps its name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPasswordDictionary -TssSession $session | Where-Object Name -EQ 'Blocked words' | Update-TssPasswordDictionary -TssSession $session -Path .\BlockedWords.txt

    Replaces the items of the password dictionary named "Blocked words"; Id and Name come from the pipeline

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Update-TssPasswordDictionary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Update-TssPasswordDictionary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.PasswordDictionary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DictionaryId')]
        [int]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
            $invokeParams.Method = 'PUT'
            $fileName = Split-Path -Path $Path -Leaf
            $fileBytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $Path).ProviderPath)
            $body = @{
                dictionaryId   = $Id
                dictionaryName = $Name
                file           = @{
                    buffer    = [System.Convert]::ToBase64String($fileBytes)
                    fileName  = $fileName
                    mediaType = 'text/plain'
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            $bodyText = "name '$Name', items from file $fileName"
            if ($PSCmdlet.ShouldProcess("Password dictionary: $Id", "$($invokeParams.Method) $uri with:`n$bodyText`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$bodyText`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssPasswordDictionary request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ("$restResponse" -match '\btrue\b') {
                    Search-TssPasswordDictionary -TssSession $TssSession | Where-Object Id -EQ $Id
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
