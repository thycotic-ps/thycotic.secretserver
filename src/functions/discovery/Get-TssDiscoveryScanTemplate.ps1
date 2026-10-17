function Get-TssDiscoveryScanTemplate {
    <#
    .SYNOPSIS
    Get a Discovery scan template

    .DESCRIPTION
    Returns one or more Discovery scan templates by id, including their fields and parent template.
    An id with no matching Discovery scan template writes an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Scan template id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryScanTemplate -TssSession $session -Id 6

    Get scan template 6

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryScanTemplate -TssSession $session -SearchText Account | Get-TssDiscoveryScanTemplate -TssSession $session

    Get the detail of every active scan template whose name contains Account

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.ScanTemplate')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScanTemplateId')]
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
                $uri = $TssSession.ApiUrl, 'discovery', 'scan-templates', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDiscoveryScanTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -eq 'null') {
                    $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Discovery scan template $currentId not found"), 'ScanTemplateNotFound', 'ObjectNotFound', $currentId))
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.Discovery.ScanTemplate](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.ScanTemplate]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
