function Search-TssSdkClientAudit {
    <#
    .SYNOPSIS
    Search SDK client audit entries

    .DESCRIPTION
    Search the SDK client audit entries (account created, authenticated, revoked) by text or by user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Operator
    How the UserId filter applies: All, Include or Exclude

    .PARAMETER SearchText
    Search text

    .PARAMETER UserId
    Filter by user ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSdkClientAudit -TssSession $session -SearchText 'build-agent-01'

    Returns the SDK client audit entries matching build-agent-01

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-audits/Search-TssSdkClientAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-audits/Search-TssSdkClientAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SdkClientAudits.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('All', 'Include', 'Exclude')]
        [string]
        $Operator,

        [string]
        $SearchText,

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
            $uri = $TssSession.ApiUrl, 'sdk-client-audits' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Operator' {
                    $queryParams += "filter.operator=$([uri]::EscapeDataString($Operator))"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'UserId' {
                    $queryParams += "filter.userId=$($UserId)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSdkClientAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SdkClientAudits.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SdkClientAudits.Summary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
