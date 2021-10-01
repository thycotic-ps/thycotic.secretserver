function Set-TssIpRestrictionUser {
    <#
    .SYNOPSIS
    Set IP Address Restriction(s) for a user(s)

    .DESCRIPTION
    Set IP Address Restriction(s) for a user(s)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssIpRestrictionUser -TssSession session -Id 42 -UserId 14

    Set IP Restriction 42 on User 14

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssIpRestrictionUser -TssSession session -Id 65, 43, 13 -UserId 97, 463, 109

    Set each IP Restriction provided on each User provided

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssIpRestrictionUser -TssSession session -Id 65, 43, 13 -UserId 97, 463, 109 -WhatIf

    Outputs verbose messages of action to be performed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Set-TssIpRestrictionUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Set-TssIpRestrictionUser.ps1

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

        # User ID(s)
        [Parameter(Mandatory)]
        [int[]]
        $UserId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($user in $UserId) {
                foreach ($restriction in $Id) {
                    $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $restriction, 'users' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'

                    $setBody = @{
                        UserId                = $user
                        IpAddressRestrictionId = $restriction
                    }
                    $invokeParams.Body = $setBody | ConvertTo-Json
                    if ($PSCmdlet.ShouldProcess("IP Restriction: $restriction", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                        Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            Write-Warning "Issue setting IP Restriction [$restriction] on User [$user]"
                            $err = $_
                            . $ErrorHandling $err
                        }
                    }
                    if ($restResponse.userId -eq $user) {
                        Write-Verbose 'User [$user] assigned to IP Restriction [$restriction]'
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}