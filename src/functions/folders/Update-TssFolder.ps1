function Update-TssFolder {
    <#
    .SYNOPSIS
    Update all members of a group

    .DESCRIPTION
    Update all members of a group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folder = Get-TssFolder -TssSession $session -Id 77
    $folder.SecretPolicyId = 15
    Update-TssFolder -TssSession $session -Folder $folder

    Updates Folder ID 77 setting Secret Policy ID 15

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Update-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Update-TssFolder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('Thycotic.PowerShell.Folders.Folder')]
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder object, output from Get-TssFolder
        [Parameter(Mandatory, Position = 1)]
        [Thycotic.PowerShell.Folders.Folder]
        $Folder
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $folderId = $Folder.Id
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'folders', $folderId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $invokeParams.Body = $Folder | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("Folder ID: $folderId", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating folder [$folderId]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Folders.Folder]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}