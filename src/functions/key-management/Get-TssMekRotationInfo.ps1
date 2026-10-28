function Get-TssMekRotationInfo {
    <#
    .SYNOPSIS
    Get the master encryption key rotation status

    .DESCRIPTION
    Gets the status of the master encryption key rotation: process state, items left to rotate, last start and end dates, and whether a rotation or a retry can be requested now.
    RotationInfo holds the detailed status (Status, StartedDateUtc, LastEndDateUtc, StatusUpdatedDateUtc).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssMekRotationInfo -TssSession $session

    Get the master encryption key rotation status

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssMekRotationInfo -TssSession $session).RotationInfo.Status

    Show the detailed status of the last rotation

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssMekRotationInfo

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssMekRotationInfo.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.KeyManagement.MekRotation')]
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
            Compare-TssVersion $TssSession '11.1.000006' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'key-management', 'mekrotationinfo' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssMekRotationInfo request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.KeyManagement.MekRotation](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.KeyManagement.MekRotation]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
