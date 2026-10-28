function Get-TssSdkClientAccount {
    <#
    .SYNOPSIS
    Get an SDK client account by ID

    .DESCRIPTION
    Get one or more SDK client accounts by ID.
    An ID with no matching SDK client account writes an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SDK client account ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSdkClientAccount -TssSession $session -Id 7

    Returns SDK client account 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Get-TssSdkClientAccount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Get-TssSdkClientAccount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'sdk-client-accounts', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSdkClientAccount request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -eq 'null') {
                    $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("SDK client account $currentId not found"), 'SdkClientAccountNotFound', 'ObjectNotFound', $currentId))
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SdkClientAccounts.SdkClientAccount]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
