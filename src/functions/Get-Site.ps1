function Get-Site {
    <#
    .SYNOPSIS
    Get a list of Sites

    .DESCRIPTION
    Get a list of Sites

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSite -TssSession $session -IncludeInactive

    Get a list of Sites, including those disabled in the results

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/Get-Site.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSite')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Include inactive sites
        [switch]
        $IncludeInactive
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'sites' -join '/'
            $uri = $uri, "includeInactive=$([boolean]$IncludeInactive)" -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue getting list of Sites"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssSite[]]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}