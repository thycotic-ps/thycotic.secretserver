function Remove-FolderPermission {
    <#
    .SYNOPSIS
    Delete a folder permissions

    .DESCRIPTION
    Delete a folder permissions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssFolderPermission -TssSession $session -Id 9

    Delete Folder Permission ID 9

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Remove-TssFolderPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Remove-FolderPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssDelete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]$TssSession,

        # Folder Permission ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderPermissionId')]
        [int[]]
        $Id,

        # Include to remove permission inheritance
        [switch]
        $BreakInheritance
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($folderPermission in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder-permissions', $folderPermission -join '/'

                if ($tssParams.ContainsKey('BreakInheritance')) {
                    $uri = $uri, "breakInheritance=$([boolean]$BreakInheritance)" -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess("FolderPermissionId: $folderPermission", "$($invokeParams.Method) $uri")) { return }
                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue removing [$folderPermission]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssDelete]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}