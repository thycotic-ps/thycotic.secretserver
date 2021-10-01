function Update-TssIpRestriction {
    <#
    .SYNOPSIS
    Update Id

    .DESCRIPTION
    Update Id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $ip = Search-TssIpRestriction.Where({$_.Name -eq 'Office Range 1'})
    $ip.Range = '192.0.1.0/24'
    Update-TssIpRestriction -TssSession $session -IpRestriction $ip

    Update the range on IP restrition "Office Range 1"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Update-TssIpRestriction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Update-TssIpRestriction.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('Thycotic.PowerShell.IpRestrictions.IpRestriction')]
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Ip Address Restriction ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [Thycotic.PowerShell.IpRestrictions.IpRestriction]
        $IpRestriction
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $restrictionId = $IpRestriction.Id
            $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $restrictionId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $restriction = $IpRestriction | ConvertTo-Json | ConvertFrom-Json
            $updateBody = @{
                id = $restriction.Id
                name = $restriction.Name
                range = $restriction.Range
            }
            $invokeParams.Body = $updateBody | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("IP Restriction: $Id", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue updating Ip Address Restriction [$Id]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.IpRestrictions.IpRestriction]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}