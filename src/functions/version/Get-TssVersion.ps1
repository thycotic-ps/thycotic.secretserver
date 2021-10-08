function Get-TssVersion {
    <#
    .SYNOPSIS
    Get version of Secret Server

    .DESCRIPTION
    Get the version of Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssVersion -TssSession $session

    Returns version of Secret Server alpha

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/version/Get-TssVersion

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/version/Get-TssVersion.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('Thycotic.PowerShell.Common.SemanticVersion')]
    param(
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
            $uri = $TssSession.ApiUrl, 'version' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting version details for [$($TssSession.SecretServer)]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.model) {
                $vString = $restResponse.model.version
                [Thycotic.PowerShell.Common.SemanticVersion]@{
                    Version = $vString
                    Major   = $vString.Split('.')[0]
                    Minor   = $vString.Split('.')[1]
                    Build   = $vString.Split('.')[2]
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}