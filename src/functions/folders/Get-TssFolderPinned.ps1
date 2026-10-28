function Get-TssFolderPinned {
    <#
    .SYNOPSIS
    Get the folders the current user has pinned

    .DESCRIPTION
    Returns the folders the current user has pinned, with the display name and browse settings saved for each pin.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderPinned -TssSession $session

    Returns every folder pinned by the user the session belongs to

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderPinned

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolderPinned.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Folders.Pinned[]')]
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
            $uri = $TssSession.ApiUrl, 'folders', 'pinned' -join '/'
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
                Write-Warning 'Issue with Get-TssFolderPinned request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Folders.Pinned[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Folders.Pinned]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
