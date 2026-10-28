function Get-TssDiscoverySecretTemplate {
    <#
    .SYNOPSIS
    Get the secret templates a discovery rule can use for a scan template

    .DESCRIPTION
    Lists the secret templates that are compatible with a discovery scan template, for use in discovery rules.
    Returns nothing when no secret template is compatible.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Scan template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoverySecretTemplate -TssSession $session -Id 6

    List the secret templates compatible with scan template 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoverySecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoverySecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Folders.DetailTemplateView[]')]
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
                $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'secret-templates', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDiscoverySecretTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Folders.DetailTemplateView[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Folders.DetailTemplateView]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
