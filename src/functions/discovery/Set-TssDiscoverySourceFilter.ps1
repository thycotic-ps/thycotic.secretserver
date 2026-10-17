function Set-TssDiscoverySourceFilter {
    <#
    .SYNOPSIS
    Update an OU filter of a discovery source

    .DESCRIPTION
    Updates the site, credential secret or scan target of one OU or container in the scope of an Active Directory discovery source.
    Only the parameters given are changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source ID

    .PARAMETER MemberId
    Filter ID, the DiscoveryFilterId of an item of Get-TssDiscoverySourceFilter

    .PARAMETER ScanTargetType
    What to scan in the OU: Users, Computers or UsersAndComputers

    .PARAMETER SecretId
    ID of the secret used to scan the OU

    .PARAMETER SiteId
    ID of the site that scans the OU

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoverySourceFilter -TssSession $session -DiscoverySourceId 3 -MemberId 7 -ScanTargetType Computers

    Scan only computers in filter 7 of discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoverySourceFilter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoverySourceFilter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.SourceFilterItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $DiscoverySourceId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DiscoveryFilterId')]
        [int]
        $MemberId,

        [ValidateSet('Users', 'Computers', 'UsersAndComputers')]
        [string]
        $ScanTargetType,

        [int]
        $SecretId,

        [int]
        $SiteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $DiscoverySourceId, 'filter', $MemberId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ScanTargetType' {
                    $body.data.Add('scanTargetType', @{ dirty = $true; value = $ScanTargetType })
                }
                'SecretId' {
                    $body.data.Add('secretId', @{ dirty = $true; value = $SecretId })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery source filter: $DiscoverySourceId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoverySourceFilter request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceFilterItem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceFilterItem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
