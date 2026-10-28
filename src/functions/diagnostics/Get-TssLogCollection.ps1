function Get-TssLogCollection {
    <#
    .SYNOPSIS
    Get the status of the log collection

    .DESCRIPTION
    Gets the log collection status shown under Admin, Diagnostics: when the last collection started (StartDate) and one LogCollection item per web node or distributed engine with its status (Collecting, Done or Failed).
    Start a collection with Start-TssLogCollection. Requires the Administer Configuration or View Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLogCollection -TssSession $session

    Get the log collection status

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssLogCollection -TssSession $session).LogCollection | Where-Object Status -EQ Failed

    List the nodes and engines whose log collection failed

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssLogCollection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssLogCollection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.LogCollectionSummary')]
    param (
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'diagnostics', 'log-collections' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssLogCollection request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                $items = @(. $FilterTssResponse $restResponse.logCollection ([Thycotic.PowerShell.Diagnostics.LogCollectionItem]))
                [Thycotic.PowerShell.Diagnostics.LogCollectionSummary]@{
                    LogCollection = [Thycotic.PowerShell.Diagnostics.LogCollectionItem[]]$items
                    StartDate     = $restResponse.startDate
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
