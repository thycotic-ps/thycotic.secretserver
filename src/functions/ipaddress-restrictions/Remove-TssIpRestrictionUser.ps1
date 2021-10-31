function Remove-TssIpRestrictionUser {
    <#
    .SYNOPSIS
    Remove a User IP Address restriction by ID

    .DESCRIPTION
    Remove a User IP Address restriction by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestrictionUser -TssSession $session -Id 45 -UserId 98

    Remove IP Address restriction 45 from User ID 98

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestrictionUser -TssSession $session -Id 45 -UserId 98, 54, 164, 4254

    Remove IP Address Restriction 45 from each User

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestrictionUser -TssSession $session -Id 45, 98, 12 -UserId 98, 54, 164, 4254

    Remove each IP Address Restriction from each User

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestrictionUser -TssSession $session -Id 45, 98, 12 -UserId 98, 54, 164, 4254 -WhatIf

    Verbose output of actions to be performed.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Remove-TssIpRestrictionUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Remove-TssIpRestrictionUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # IP Address Restriction ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("IpAddressRestrictionId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($user in $UserId) {
                foreach ($restriction in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $restriction, 'users', $user -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'DELETE'

                    if ($PSCmdlet.ShouldProcess("IP Restriction: $restriction","$($invokeParams.Method) $($invokeParams.Uri)")) {
                        Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with $body"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            Write-Warning "Issue removing IP Restriction [$restriction] from User [$user]"
                            $err = $_
                            . $ErrorHandling $err
                        }

                        if ($restResponse) {
                            [Thycotic.PowerShell.Common.Delete]@{
                                Id         = $restResponse.id
                                ObjectType = $restResponse.objectType
                            }
                        }
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}