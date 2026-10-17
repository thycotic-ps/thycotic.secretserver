function Search-TssPbaChallenge {
    <#
    .SYNOPSIS
    Search Privilege Behavior Analytics (PBA) challenges

    .DESCRIPTION
    Returns the PBA challenges raised against users, with who cleared each one and when.
    An empty result is normal when PBA has raised no challenges.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Completed
    Return only completed (cleared) challenges

    .PARAMETER DayRange
    Number of days back to search. Defaults to 1, the last day

    .PARAMETER SearchText
    Text to match against the challenge records, such as a user name

    .PARAMETER ChallengeType
    Challenge type id to filter by

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPbaChallenge -TssSession $session

    Returns the PBA challenges from the last day

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPbaChallenge -TssSession $session -SearchText jsmith -DayRange 7

    Returns challenges from the last 7 days that match jsmith

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Search-TssPbaChallenge

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Search-TssPbaChallenge.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the View or Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PbaConfiguration.Challenge[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Completed,

        [int]
        $DayRange = 1,

        [string]
        $SearchText,

        [long]
        $ChallengeType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'pba-challenges' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $queryParams += "filter.dayRange=$($DayRange)"
            switch ($tssParams.Keys) {
                'Completed' {
                    $queryParams += "filter.completed=$([boolean]$Completed)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'ChallengeType' {
                    $queryParams += "filter.type=$($ChallengeType)"
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
                Write-Warning 'Issue with Search-TssPbaChallenge request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PbaConfiguration.Challenge[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PbaConfiguration.Challenge]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
