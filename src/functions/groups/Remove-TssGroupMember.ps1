function Remove-TssGroupMember {
    <#
    .SYNOPSIS
    Remove membership of a given group

    .DESCRIPTION
    Remove membership of a given group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssGroupMember -TssSession $session -Id 8 -UserId 34

    Remove User ID 34 from Group ID 8

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Remove-TssGroupMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Remove-TssGroupMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Group ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int]
        $Id,

        # User ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $UserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'groups', $Id, 'users', $UserId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'

            if (-not $PSCmdlet.ShouldProcess("Group ID: $Id | User ID: $UserId", "$($invokeParams.Method) $($invokeParams.Uri)")) { return }
            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue removing User [$UserId] from Group [$Id]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Common.Delete]@{
                    Id         = $restResponse.id
                    ObjectType = $restResponse.objectType
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}