function Remove-TssPlatformGroup {
    <#
    .SYNOPSIS
    Unlink a Delinea Platform group from Secret Server

    .DESCRIPTION
    Unlinks a group that was linked from the Delinea Platform. Secret Server disables the group; the group record and its history are kept.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret Server group ID of the linked Platform group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssPlatformGroup -TssSession $session -Id 12

    Unlinks the Platform group with Secret Server group ID 12 and returns True on success

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Remove-TssPlatformGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Remove-TssPlatformGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Returns True or False per group ID as returned by the server.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'platform', 'group', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Platform group: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssPlatformGroup request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [System.Convert]::ToBoolean($restResponse)
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
