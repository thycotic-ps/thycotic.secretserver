function Get-TssAppClientStub {
    <#
    .SYNOPSIS
    Get the default values for a new OAuth app client

    .DESCRIPTION
    Get an OAuth app client object with the default values for a new app client.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssAppClientStub -TssSession $session

    Returns the default values for a new app client

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Get-TssAppClientStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Get-TssAppClientStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.AppClients.AppClient')]
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
            $uri = $TssSession.ApiUrl, 'app-clients', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssAppClientStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.AppClients.AppClient](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AppClients.AppClient]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
