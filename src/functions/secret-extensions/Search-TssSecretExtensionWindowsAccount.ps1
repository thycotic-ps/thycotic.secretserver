function Search-TssSecretExtensionWindowsAccount {
    <#
    .SYNOPSIS
    Search Windows account secrets by computer name

    .DESCRIPTION
    Returns the Windows account secrets that match a computer name, as the browser extension finds them.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ComputerName
    Computer name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretExtensionWindowsAccount -TssSession $session -ComputerName 'web01'

    Returns the Windows account secrets for computer web01

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Search-TssSecretExtensionWindowsAccount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Search-TssSecretExtensionWindowsAccount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretExtensions.Secret[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $ComputerName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-extensions', 'search-windows-account-secrets-by-computer-name' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $invokeParams.Body = ConvertTo-Json -InputObject $ComputerName -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretExtensionWindowsAccount request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.model) {
                [Thycotic.PowerShell.SecretExtensions.Secret[]](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.SecretExtensions.Secret]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
