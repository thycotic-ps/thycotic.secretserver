function New-TssIpRestriction {
    <#
    .SYNOPSIS
    Create a new IP Address Restriction

    .DESCRIPTION
    Create a new IP Address Restriction

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ipaddress-restrictions/New-TssIpRestriction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ipaddress-restrictions/New-TssIpRestriction.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssIpRestriction -TssSession $session -Name 'Corp Network' -Range '172.56.23.0/24'

    Create a new IP restriction named "Corp Network"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssIpRestriction -TssSession $session -Name 'Remote Office' -Range '172.56.24.72', '172.56.25.72'

    Create a new IP restriction named "Remote Office"

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.IpRestrictions.IpRestriction')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # IP Address Restriction Name
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]
        $Name,

        # IP Address Range, CIDR
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]
        $Range
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'ipaddress-restrictions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = [ordered]@{}
            switch ($tssNewParams.Keys) {
                'Name' { $newBody.Add('name',$Name) }
                'Range' { $newBody.Add('range',$Range) }
            }
            $invokeParams.Body = ($newBody | ConvertTo-Json)

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("IP Restriction: $Name", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating IP Restriction [Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.IpRestrictions.IpRestriction]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}