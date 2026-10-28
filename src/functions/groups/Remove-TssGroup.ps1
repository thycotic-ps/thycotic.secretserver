function Remove-TssGroup {
    <#
    .SYNOPSIS
    Disable a group

    .DESCRIPTION
    Removes a group the way Secret Server does it: the group is disabled, not deleted, so its audit history and permission references stay intact.
    Re-enable the group with Set-TssGroup -Enabled.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssGroup -TssSession $session -Id 42

    Disables group 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Remove-TssGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Remove-TssGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
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
                $uri = $TssSession.ApiUrl, 'groups', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Group: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssGroup request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Common.Delete]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
