function Clear-TssDomainIndex {
    <#
    .SYNOPSIS
    Delete every entry in the domain name index

    .DESCRIPTION
    Delete every entry in the Discovery domain name index. Discovery rebuilds the index on its next runs. Returns True.
    The domain name index is the Discovery cache of domain names and the discovery source each one resolves to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssDomainIndex -TssSession $session -Confirm:$false

    Empty the domain name index without a confirmation prompt

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/domain-index/Clear-TssDomainIndex

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/domain-index/Clear-TssDomainIndex.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('System.Boolean')]
    param (
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'domain-index', 'delete-all' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'
            if ($PSCmdlet.ShouldProcess("Domain index", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Clear-TssDomainIndex request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
[System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
