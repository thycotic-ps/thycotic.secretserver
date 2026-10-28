function Update-TssSdkClientAccount {
    <#
    .SYNOPSIS
    Update an SDK client account

    .DESCRIPTION
    Rename an SDK client account or change its user.
    The current account is read first, so parameters not given keep their value.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SDK client account ID

    .PARAMETER Name
    New name of the SDK client account

    .PARAMETER UserId
    ID of the user the SDK client account runs as

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSdkClientAccount -TssSession $session -Id 7 -Name 'build-agent-02'

    Renames SDK client account 7 to build-agent-02

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Update-TssSdkClientAccount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Update-TssSdkClientAccount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [string]
        $Name,

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
            $currentAccount = Get-TssSdkClientAccount -TssSession $TssSession -Id $Id
            if (-not $currentAccount) {
                return
            }
            $uri = $TssSession.ApiUrl, 'sdk-client-accounts', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                name   = $currentAccount.Name
                userId = $currentAccount.UserId
            }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.name = $Name
                }
                'UserId' {
                    $body.userId = $UserId
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Sdk client account: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSdkClientAccount request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
