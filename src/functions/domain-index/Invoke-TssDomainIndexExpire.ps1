function Invoke-TssDomainIndexExpire {
    <#
    .SYNOPSIS
    Expire domain name index entries so Discovery re-indexes them

    .DESCRIPTION
    Expire domain name index entries. With -All every entry expires (add -ReIndexNow to re-index the expired entries right away) and the cmdlet returns True. With -Id each entry expires and is re-indexed, and the cmdlet returns the updated entry.
    The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Domain name index entry ID to expire and re-index

    .PARAMETER All
    Expire every entry in the domain name index

    .PARAMETER ReIndexNow
    With -All, re-index the expired entries right away instead of on the next Discovery run

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssDomainIndexExpire -TssSession $session -All -ReIndexNow

    Expire and re-index the whole domain name index

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDomainIndex -TssSession $session -DomainResolveType CouldNotResolve | Invoke-TssDomainIndexExpire -TssSession $session

    Re-index every entry Discovery could not resolve

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Invoke-TssDomainIndexExpire

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Invoke-TssDomainIndexExpire.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'id')]
    [OutputType('Thycotic.PowerShell.DomainIndex.DomainNameIndex', ParameterSetName = 'id')]
    [OutputType('System.Boolean', ParameterSetName = 'all')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [Alias('DomainNameIndexId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'all')]
        [switch]
        $All,

        [Parameter(ParameterSetName = 'all')]
        [switch]
        $ReIndexNow
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'all' {
                    $uri = $TssSession.ApiUrl, 'domain-index', 'expire-all' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'
                    $invokeParams.Body = @{ data = @{ reIndexNow = [boolean]$ReIndexNow } } | ConvertTo-Json -Depth 100
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    $restResponse = $null
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Invoke-TssDomainIndexExpire request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [System.Convert]::ToBoolean($restResponse)
                    }
                }
                'id' {
                    foreach ($currentId in $Id) {
                        $restResponse = $null
                        $uri = $TssSession.ApiUrl, 'domain-index', 'expire', $currentId -join '/'
                        $invokeParams.Uri = $uri
                        $invokeParams.Method = 'POST'
                        Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            Write-Warning 'Issue with Invoke-TssDomainIndexExpire request'
                            $err = $_
                            . $ErrorHandling $err
                        }
                        if ($restResponse) {
                            [Thycotic.PowerShell.DomainIndex.DomainNameIndex](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DomainIndex.DomainNameIndex]))
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
