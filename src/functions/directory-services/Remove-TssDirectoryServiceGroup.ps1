function Remove-TssDirectoryServiceGroup {
    <#
    .SYNOPSIS
    Remove or unlink a Group from a Directory Services domain

    .DESCRIPTION
    Remove or unlink a Group from a Directory Services domain

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDirectoryServiceGroup -TssSession $session -DomainId 2 -GroupId 6

    Remove Group ID 6 from Directory Services domain Id 2, will also disable the Group in Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssGroup -TssSession $session -DomainId 1 -SearchText 'Secret' | Remove-TssDirectoryServiceGroup -TssSession $session -DomainId 1 -Verbose

    Remove all Groups in Domain ID that contain "Secret" in the Group Name from the Directory Services Domain ID 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Remove-TssDirectoryServiceGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Remove-TssDirectoryServiceGroup.ps1

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

        # Domain ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int]
        $DomainId,

        # Group ID(s) to remove
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int[]]
        $GroupId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($group in $GroupId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'directory-services', 'domains', $DomainId, 'group', $group -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess("GroupID: $group","$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with $body"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue removing Group ID [$group] from Domain [$DomainId]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $group
                            ObjectType = "Domain Group"
                        }
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}