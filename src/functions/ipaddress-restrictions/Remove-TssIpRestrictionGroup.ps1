function Remove-TssIpRestrictionGroup {
    <#
    .SYNOPSIS
    Remove a Group IP Address restriction by ID

    .DESCRIPTION
    Remove a Group IP Address restriction by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestrictionGroup -TssSession $session -Id 5 -GroupId 64

    Remove IP Address Restriction 5 from Group ID 64

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestrictionGroup -TssSession $session -Id 5,10,42,65 -GroupId 64,90,1897,43

    Move through each Group ID and remove each IP Address Restriction from them

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestrictionGroup -TssSession $session -Id 5,10,42,65 -GroupId 64,90,1897,43 -WhatIf

    Outputs verbose messages of action to be performed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Remove-TssIpRestrictionGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Remove-TssIpRestrictionGroup.ps1

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
        $Id,

        # Group ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int[]]
        $GroupId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($group in $GroupId) {
                foreach ($restriction in $Id) {
                    $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $restriction, 'groups', $group -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'DELETE'

                    if ($PSCmdlet.ShouldProcess("IP Restriction: $restriction","$($invokeParams.Method) $($invokeParams.Uri)")) {
                        Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with $body"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            Write-Warning "Issue removing IP Address Restriction [$restriction] from Group [$group]"
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