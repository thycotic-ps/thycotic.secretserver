function Get-TssKeyManagementStub {
    <#
    .SYNOPSIS
    Get a default Key Management configuration

    .DESCRIPTION
    Gets the default values for a new Key Management configuration: provider None and every provider setting empty.
    Nothing is changed on the server.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssKeyManagementStub -TssSession $session

    Get the default Key Management configuration values

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagementStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagementStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.KeyManagement.KeyManagement')]
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
            $uri = $TssSession.ApiUrl, 'key-management', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssKeyManagementStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.KeyManagement.KeyManagement](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.KeyManagement.KeyManagement]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
