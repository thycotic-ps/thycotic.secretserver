function Search-TssPlatformGroup {
    <#
    .SYNOPSIS
    Search the Delinea Platform directories for groups

    .DESCRIPTION
    Searches the directories of the Delinea Platform for groups, using the Platform credentials of the integration. Use the results with New-TssPlatformGroup to link a group.
    When the Platform reports a problem the message is written as a warning.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SearchText
    Start of the group name. The Platform matches names that start with this text, case-sensitive; * is not a wildcard, so 'Admin' finds Administrators but 'admin' and 'Admin*' do not

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformGroup -TssSession $session -SearchText 'Admin'

    Returns the Platform groups whose name starts with Admin

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformGroup -TssSession $session -SearchText 'Vault Admins'

    Returns the Vault Admins group and any other group whose name starts with Vault Admins

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.Group[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'platform', 'groups', 'search-directory' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'SearchText' {
                    $queryParams += "searchText=$([uri]::EscapeDataString($SearchText))"
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
                Write-Warning 'Issue with Search-TssPlatformGroup request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.errorMessage) {
                Write-Warning $restResponse.errorMessage
            }
            if ($restResponse.groups) {
                [Thycotic.PowerShell.Platform.Group[]](. $FilterTssResponse $restResponse.groups ([Thycotic.PowerShell.Platform.Group]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
