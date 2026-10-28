function Set-TssLauncherTypeFileAttachment {
    <#
    .SYNOPSIS
    Upload a batch file or shell script for a custom launcher type

    .DESCRIPTION
    Upload a batch file (.bat) or shell script (.sh) as a custom launcher file attachment. The returned FileAttachmentId is the value for -BatchFileId or -ShellScriptId on New-TssLauncherType and Set-TssLauncherType. The file is sent base64 encoded in a JSON body.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Path
    Path of the .bat or .sh file to upload

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $attachment = Set-TssLauncherTypeFileAttachment -TssSession $session -Path .\launch.bat
    Set-TssLauncherType -TssSession $session -Id 9 -BatchFileId $attachment.FileAttachmentId

    Upload launch.bat and attach it to custom launcher type 9

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Set-TssLauncherTypeFileAttachment

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Set-TssLauncherTypeFileAttachment.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Launchers.FileAttachment')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Path
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'launchers', 'types', 'file-attachments' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Path' {
                    $fileBytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $Path).ProviderPath)
                    $body.Add('file', @{
                        buffer       = [System.Convert]::ToBase64String($fileBytes)
                        fileName     = (Split-Path -Path $Path -Leaf)
                        mediaType    = 'application/octet-stream'
                        mediaSubType = 'octet-stream'
                    })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Launcher type file attachment", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssLauncherTypeFileAttachment request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Launchers.FileAttachment](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Launchers.FileAttachment]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
