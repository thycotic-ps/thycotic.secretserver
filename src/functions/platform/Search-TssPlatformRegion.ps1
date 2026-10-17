function Search-TssPlatformRegion {
    <#
    .SYNOPSIS
    Search the Delinea Platform regions

    .DESCRIPTION
    List the Delinea Platform regions this Secret Server can be provisioned in. IsDefault marks the default region of the instance.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformRegion -TssSession $session | Where-Object IsDefault

    Show the default Platform region

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformRegion

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformRegion.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with an error.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.Region[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform', 'get-platform-regions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssPlatformRegion request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.regions) {
                [Thycotic.PowerShell.Platform.Region[]](. $FilterTssResponse $restResponse.regions ([Thycotic.PowerShell.Platform.Region]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
