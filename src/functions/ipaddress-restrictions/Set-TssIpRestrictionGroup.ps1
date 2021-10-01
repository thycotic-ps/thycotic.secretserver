function Set-TssIpRestrictionGroup {
    <#
    .SYNOPSIS
    Set IP Address Restriction(s) for a group(s)

    .DESCRIPTION
    Set IP Address Restriction(s) for a group(s)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssIpRestrictionGroup -TssSession session -Id 42 -GroupId 14

    Set IP Restriction 42 on Group 14

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssIpRestrictionGroup -TssSession session -Id 65, 43, 13 -GroupId 97, 463, 109

    Set each IP Restriction provided on each Group provided

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssIpRestrictionGroup -TssSession session -Id 65, 43, 13 -GroupId 97, 463, 109 -WhatIf

    Outputs verbose messages of action to be performed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Set-TssIpRestrictionGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Set-TssIpRestrictionGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # IP Address Restriction ID(s)
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('IpAddressRestrictionId')]
        [int[]]
        $Id,

        # Group ID(s)
        [Parameter(Mandatory)]
        [int[]]
        $GroupId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($group in $GroupId) {
                foreach ($restriction in $Id) {
                    $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $restriction, 'groups' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'

                    $setBody = @{
                        GroupId                = $group
                        IpAddressRestrictionId = $restriction
                    }
                    $invokeParams.Body = $setBody | ConvertTo-Json
                    if ($PSCmdlet.ShouldProcess("IP Restriction: $restriction", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                        Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            Write-Warning "Issue setting IP Restriction [$restriction] on Group [$group]"
                            $err = $_
                            . $ErrorHandling $err
                        }
                    }
                    if ($restResponse.groupId -eq $group) {
                        Write-Verbose 'Group [$group] assigned to IP Restriction [$restriction]'
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}