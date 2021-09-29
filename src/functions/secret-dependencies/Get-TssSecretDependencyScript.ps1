function Get-TssSecretDependencyScript {
    <#
    .SYNOPSIS
    Get Scripts that are possible to use for Dependencies

    .DESCRIPTION
    Get Scripts that are possible to use for Dependencies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretDependencyScript -TssSession $session - some test value

    Return Dependency scripts available for use

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Get-TssSecretDependencyScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Get-TssSecretDependencyScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretDependencies.Script')]
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
                $uri = $TssSession.ApiUrl, 'secret-dependencies', 'scripts' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting dependency scripts"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.model) {
                    [Thycotic.PowerShell.SecretDependencies.Script[]]$restResponse.model
                }
        } else {
            Write-Warning "No valid session found"
        }
    }
}