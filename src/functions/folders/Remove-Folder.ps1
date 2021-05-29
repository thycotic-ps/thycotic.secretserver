function Remove-Folder {
    <#
    .SYNOPSIS
    Delete secret folder

    .DESCRIPTION
    Delete secret folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssFolder -TssSession $session -Id 28

    Delete Folder ID 28

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Remove-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Remove-Folder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssDelete')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Folder ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'folders', $folder -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'


                if (-not $PSCmdlet.ShouldProcess("FolderId: $folder", "$($invokeParams.Method) $uri")) { return }
                Write-Verbose "$($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning 'Issue removing [$]'
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