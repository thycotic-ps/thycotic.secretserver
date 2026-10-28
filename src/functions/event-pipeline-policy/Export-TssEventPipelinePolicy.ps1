function Export-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Export an event pipeline policy

    .DESCRIPTION
    Returns an event pipeline policy and its pipelines as JSON text, for Import-TssEventPipelinePolicy or Copy-TssEventPipelinePolicy.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline policy ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssEventPipelinePolicy -TssSession $session -Id 3 | Set-Content -Path ./policy-3.json

    Exports event pipeline policy 3 to a file

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Export-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Export-TssEventPipelinePolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelinePolicyId')]
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
                $uri = $TssSession.ApiUrl, 'event-pipeline-policy', 'export', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Export-TssEventPipelinePolicy request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -is [string] -and $restResponse.StartsWith('"')) {
                    $restResponse | ConvertFrom-Json
                } elseif ($null -ne $restResponse) {
                    $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
