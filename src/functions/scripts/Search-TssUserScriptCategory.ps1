function Search-TssUserScriptCategory {
    <#
    .SYNOPSIS
    Search user script categories

    .DESCRIPTION
    Lists the user script categories (ID and name).
    Use the ID with New-TssUserScript and Set-TssUserScript -ScriptCategoryId.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SearchText
    Only return categories whose name contains this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUserScriptCategory -TssSession $session

    List every user script category

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUserScriptCategory -TssSession $session -SearchText Dependency

    Find the categories whose name contains Dependency

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Search-TssUserScriptCategory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Search-TssUserScriptCategory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Scripts.UserScriptCategory[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'userscripts', 'categories' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
            }
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
                Write-Warning 'Issue with Search-TssUserScriptCategory request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Scripts.UserScriptCategory[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Scripts.UserScriptCategory]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
