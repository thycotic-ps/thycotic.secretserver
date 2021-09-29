function Remove-TssIpRestriction {
    <#
    .SYNOPSIS
    Delete an IP Address restriction

    .DESCRIPTION
    Delete an IP Address restriction

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssIpRestriction -TssSession $session -Id 5

    Delete the IP Address restriction 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/Remove-TssIpRestriction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/Remove-TssIpRestriction.ps1

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

        # IP Address Restriction Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("IpAddressRestrictionId")]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($ipRestriction in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'ipaddress-restrictions', $ipRestriction -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess("IP Restriction: $ipRestriction","$($invokeParams.Method) $($invokeParams.Uri)")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue removing IP Address restriction [$ipRestriction]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Common.Delete]@{
                        Id = $restResponse.id
                        ObjectType = $restResponse.objectType
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}