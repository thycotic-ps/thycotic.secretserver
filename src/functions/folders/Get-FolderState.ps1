function Get-FolderState {
    <#
    .SYNOPSIS
    Get details on a Folder

    .DESCRIPTION
    Get details on allowed actions (create subfolders, edit folder, add secret, etc.) and templates of a Folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderState -TssSession $session -Id 482

    Returns details on Folder ID 482, if no access to folder will throw API exception

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderState -TssSession $session -Id 482 -NoException

    Returns details on Folder ID 482, if no access to folder will return no results

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolderState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-FolderState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Folders.DetailView')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("FolderId")]
        [int[]]
        $Id,

        # Return empty result instead of access denied exception
        [switch]
        $NoException
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($folder in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder-details', $folder -join '/'

                if ($tssParams.ContainsKey('NoException')) {
                    $uri = $uri, "returnEmptyInsteadOfNoAccessException=$([boolean]$NoException)" -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting folder details on folder [$folder]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Folders.DetailView]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}