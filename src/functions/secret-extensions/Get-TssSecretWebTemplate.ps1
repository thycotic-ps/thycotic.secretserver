function Get-TssSecretWebTemplate {
    <#
    .SYNOPSIS
    Get a list of Secret Templates valid for Web Password Filler

    .DESCRIPTION
    Get a list of Secret Templates valid for Web Password Filler

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretWebTemplate -TssSession $session

    Return list of Secret Templates that can be used by Web Password Filler

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-extensions/Get-TssSecretWebTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-extensions/Get-TssSecretWebTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Template')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
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
            $uri = $TssSession.ApiUrl, 'secret-extensions', 'web-secret-templates' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting Secret Templates for web passwords"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretTemplates.Template[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}