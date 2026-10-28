function Search-TssPlatformDirectory {
    <#
    .SYNOPSIS
    Search the directories configured in the Delinea Platform

    .DESCRIPTION
    Returns the directory services of the Delinea Platform tenant that Secret Server is integrated with, with their display name and status.
    Requires Delinea Platform integration on the Secret Server instance.
    When the server reports the search as unsuccessful (Platform integration not enabled, access denied, or a user restricted by teams) the cmdlet writes a warning and returns nothing; the server does not say which.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformDirectory -TssSession $session

    Returns the Platform directories and their status

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformDirectory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformDirectory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.Directory[]')]
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
            $uri = $TssSession.ApiUrl, 'platform', 'directories' -join '/'
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
                Write-Warning 'Issue with Search-TssPlatformDirectory request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.success -eq $false) {
                Write-Warning 'The server reported the Platform directory search as unsuccessful: Delinea Platform integration is not enabled, or the current user lacks access'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Platform.Directory[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Platform.Directory]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
