function Get-TssConfigurationAutoExport {
    <#
    .SYNOPSIS
    Get the Automatic Export configuration

    .DESCRIPTION
    Get the Automatic Export configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssConfigurationAutoExport -TssSession $session -Id 42

    Return the Automatic Export configuration settings

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationAutoExport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationAutoExport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.AutomaticExport')]
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
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'configuration', 'auto-export' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting Automatic Export configuration"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.AutomaticExport]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}