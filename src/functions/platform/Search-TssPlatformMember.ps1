function Search-TssPlatformMember {
    <#
    .SYNOPSIS
    Search the Delinea Platform for the members of a directory group

    .DESCRIPTION
    Returns the members of a Delinea Platform directory group, using the Platform credentials of the integration.
    When the Platform reports a problem the message is written as a warning.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER GroupName
    Name of the group. Optional: the server finds the group by -DomainIdentifier

    .PARAMETER DomainIdentifier
    Unique directory identifier of the group, the DsGuid that Search-TssPlatformGroup returns. Required by the server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $group = Search-TssPlatformGroup -TssSession $session -SearchText 'Vault Admins'
    Search-TssPlatformMember -TssSession $session -GroupName $group.Name -DomainIdentifier $group.DsGuid

    Returns the display name of each member of the Vault Admins group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformGroup -TssSession $session -SearchText 'Vault Admins' | Search-TssPlatformMember -TssSession $session

    Returns the members of the group found by the search

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.GroupMember[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [string]
        $GroupName,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DsGuid')]
        [string]
        $DomainIdentifier
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform', 'members' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'GroupName' {
                    $queryParams += "groupName=$([uri]::EscapeDataString($GroupName))"
                }
                'DomainIdentifier' {
                    $queryParams += "domainIdentifier=$([uri]::EscapeDataString($DomainIdentifier))"
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
                Write-Warning 'Issue with Search-TssPlatformMember request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.errorMessage) {
                Write-Warning $restResponse.errorMessage
            }
            if ($restResponse.members) {
                [Thycotic.PowerShell.DirectoryServices.GroupMember[]](. $FilterTssResponse $restResponse.members ([Thycotic.PowerShell.DirectoryServices.GroupMember]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
