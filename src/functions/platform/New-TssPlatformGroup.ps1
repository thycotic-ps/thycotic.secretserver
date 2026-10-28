function New-TssPlatformGroup {
    <#
    .SYNOPSIS
    Link a Delinea Platform directory group to Secret Server

    .DESCRIPTION
    Links (adds) a directory group from the Delinea Platform to Secret Server, so permissions can be granted to the group before its members log in.
    Find the group, its directory identifier and its group type with Search-TssPlatformGroup.
    For Active Directory the domain identifier must be in hex format, not GUID format.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DomainIdentifier
    Unique directory identifier of the group. For Active Directory this is the ADGuid in hex format, not GUID format

    .PARAMETER Name
    Name of the group in the directory

    .PARAMETER GroupType
    Directory group type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssPlatformGroup -TssSession $session -DomainIdentifier '4f2a9c1d8e7b6a5f4f2a9c1d8e7b6a5f' -Name 'Vault Admins' -GroupType Global

    Links the Vault Admins group from the Platform directory and returns True on success

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformGroup -TssSession $session -SearchText 'Vault' | New-TssPlatformGroup -TssSession $session

    Links every Platform group whose name starts with Vault (case-sensitive)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/New-TssPlatformGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/New-TssPlatformGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Returns True or False as returned by the server.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DsGuid')]
        [string]
        $DomainIdentifier,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $Name,

        [ValidateSet('Universal', 'Global', 'DomainLocal')]
        [string]
        $GroupType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform', 'group' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DomainIdentifier' {
                    $body.data.Add('domainIdentifier', $DomainIdentifier)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
                'GroupType' {
                    $body.data.Add('groupType', $GroupType)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Platform group", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssPlatformGroup request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
