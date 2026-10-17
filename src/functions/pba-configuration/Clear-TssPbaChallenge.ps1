function Clear-TssPbaChallenge {
    <#
    .SYNOPSIS
    Clear Privilege Behavior Analytics (PBA) challenges

    .DESCRIPTION
    Clears (acknowledges) one or more PBA challenges by challenge id, recording the user who cleared them.
    Ids the server does not find are skipped. Returns true when the request succeeds.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    PBA challenge id (SecurityAnalyticsChallengeId in Search-TssPbaChallenge output)

    .PARAMETER ClearingUserId
    User id recorded as the user who cleared the challenges

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssPbaChallenge -TssSession $session -Id 42, 43 -ClearingUserId 2

    Clears challenges 42 and 43 as user 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPbaChallenge -TssSession $session -SearchText jsmith | Clear-TssPbaChallenge -TssSession $session -ClearingUserId 2

    Clears every challenge from the last day that matches jsmith as user 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Clear-TssPbaChallenge

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Clear-TssPbaChallenge.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecurityAnalyticsChallengeId', 'ChallengeId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $ClearingUserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'clear-pba-challenges' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $challenges = @(foreach ($currentId in $Id) { @{ challengeId = $currentId; clearingUserId = $ClearingUserId } })
            $body = @{ data = $challenges }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("PBA challenge $($Id -join ', ')", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Clear-TssPbaChallenge request'
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
