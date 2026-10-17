function New-TssDomainIndex {
    <#
    .SYNOPSIS
    Add a domain to the domain name index

    .DESCRIPTION
    Add a domain name to the Discovery domain name index, optionally marked as ignored or with the discovery source it should resolve to. Returns the new entry.
    The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source the domain should resolve to

    .PARAMETER Ignored
    Mark the domain as ignored by Discovery

    .PARAMETER DomainName
    Domain name to add

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDomainIndex -TssSession $session -DomainName corp.example.com -DiscoverySourceId 2

    Map corp.example.com to discovery source 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDomainIndex -TssSession $session -DomainName lab.example.com -Ignored

    Add lab.example.com as an ignored domain

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/New-TssDomainIndex

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/New-TssDomainIndex.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DomainIndex.DomainNameIndex')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Alias('DiscoverySourceIdSuggested')]
        [int]
        $DiscoverySourceId,

        [Alias('DomainMarkedAsIgnored')]
        [switch]
        $Ignored,

        [Parameter(Mandatory)]
        [Alias('DomainNameDiscovered')]
        [string]
        $DomainName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'domain-index', 'create' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceIdSuggested', @{ dirty = $true; value = $DiscoverySourceId })
                }
                'Ignored' {
                    $body.data.Add('domainMarkedAsIgnored', @{ dirty = $true; value = [boolean]$Ignored })
                }
                'DomainName' {
                    $body.data.Add('domainNameDiscovered', @{ dirty = $true; value = $DomainName })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Domain index", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDomainIndex request'
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
