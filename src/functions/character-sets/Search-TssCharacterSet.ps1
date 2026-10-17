function Search-TssCharacterSet {
    <#
    .SYNOPSIS
    Search character sets

    .DESCRIPTION
    Returns the character sets that password requirements can use, active ones unless Status says otherwise.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Status
    Filter by status: Active (the server default), Inactive or All

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssCharacterSet -TssSession $session

    Returns all active character sets

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssCharacterSet -TssSession $session -Status All

    Returns active and inactive character sets

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Search-TssCharacterSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Search-TssCharacterSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.CharacterSets.CharacterSet[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Active', 'Inactive', 'All')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'character-sets' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
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
                Write-Warning 'Issue with Search-TssCharacterSet request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.CharacterSets.CharacterSet[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.CharacterSets.CharacterSet]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
