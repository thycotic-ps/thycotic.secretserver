function Set-TssDomainIndex {
    <#
    .SYNOPSIS
    Update a domain name index entry

    .DESCRIPTION
    Mark a domain name index entry as ignored, or set the discovery source it resolves to. Only the parameters you pass are sent. The server expires and re-indexes the entry as part of the update. Returns the updated entry.
    The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Domain name index entry ID

    .PARAMETER DiscoverySourceId
    Discovery source the domain should resolve to

    .PARAMETER Ignored
    Mark the domain as ignored by Discovery; -Ignored:$false clears it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDomainIndex -TssSession $session -Id 12 -DiscoverySourceId 2

    Map entry 12 to discovery source 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDomainIndex -TssSession $session -DomainName lab.example.com | Set-TssDomainIndex -TssSession $session -Ignored

    Ignore every index entry for lab.example.com

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Set-TssDomainIndex

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Set-TssDomainIndex.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DomainIndex.DomainNameIndex')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DomainNameIndexId')]
        [int]
        $Id,

        [Alias('DiscoverySourceIdSuggested')]
        [int]
        $DiscoverySourceId,

        [Alias('DomainMarkedAsIgnored')]
        [switch]
        $Ignored
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'domain-index', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceIdSuggested', @{ dirty = $true; value = $DiscoverySourceId })
                }
                'Ignored' {
                    $body.data.Add('domainMarkedAsIgnored', @{ dirty = $true; value = [boolean]$Ignored })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Domain index: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDomainIndex request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DomainIndex.DomainNameIndex](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DomainIndex.DomainNameIndex]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
