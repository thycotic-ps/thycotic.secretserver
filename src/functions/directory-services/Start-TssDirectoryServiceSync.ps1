function Start-TssDirectoryServiceSync {
    <#
    .SYNOPSIS
    Run synchronization to update users and groups for all enabled Directories

    .DESCRIPTION
    Run synchronization to update users and groups for all enabled Directories

    .PARAMETER PassThru
    Output the Boolean Secret Server returns, True when the synchronization is queued

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssDirectoryServiceSync -TssSession $session

    Run Directory Services synchronization

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssDirectoryServiceSync -TssSession $session -PassThru

    Run Directory Services synchronization and output True when it is queued

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Start-TssDirectoryServiceSync

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Start-TssDirectoryServiceSync.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $PassThru
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'directory-services', 'synchronization-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $invokeParams.Body = $discoverBody | ConvertTo-Json
            if (-not $PSCmdlet.ShouldProcess("Directory Sync", "$($invokeParams.Method) $uri")) { return }
            Write-Verbose "Performing the operation: $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                Write-Verbose "Directory Service sync successfully started"
            }
            if ($PassThru -and $null -ne $restResponse) {
                [System.Convert]::ToBoolean($restResponse)
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}