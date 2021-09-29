function Start-TssConfigurationSearchIndex {
    <#
    .SYNOPSIS
    Start a rebuild for the Secret Search Index

    .DESCRIPTION
    Start a rebuild for the Secret Search Index

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssConfigurationSearchIndex -TssSession $session

    Start a rebuild for the Secret Search Index

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssConfigurationSearchIndex

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssConfigurationSearchIndex.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'secret-search-indexer', 'rebuild-index' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            if (-not $PSCmdlet.ShouldProcess("Search Index", "$($invokeParams.Method) $($invokeParams.Uri)")) { return }
            Write-Verbose "Performing the operation: $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                Write-Verbose "Secret Search Index rebuild started successfully"
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}