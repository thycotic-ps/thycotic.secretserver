function Import-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Import an event pipeline policy

    .DESCRIPTION
    Creates an event pipeline policy, with its pipelines, from an export made by Export-TssEventPipelinePolicy, and returns the new policy.
    Pass the export text with Data, or a file holding it with Path.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Data
    Event pipeline policy export (JSON text from Export-TssEventPipelinePolicy)

    .PARAMETER Path
    Path of a file holding an event pipeline policy export

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Import-TssEventPipelinePolicy -TssSession $session -Path ./policy-3.json

    Imports an event pipeline policy from a file

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $export = Export-TssEventPipelinePolicy -TssSession $session -Id 3
    Import-TssEventPipelinePolicy -TssSession $session -Data $export

    Imports a policy from an export held in a variable

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Import-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Import-TssEventPipelinePolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.Policy')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'data')]
        [string]
        $Data,

        [Parameter(Mandatory, ParameterSetName = 'path')]
        [string]
        $Path
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', 'import' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $policyExport = $Data
            $target = 'Event pipeline policy export'
            if ($PSCmdlet.ParameterSetName -eq 'path') {
                $target = "Event pipeline policy export: $Path"
                $policyExport = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath $Path -ErrorAction Stop).ProviderPath)
            }
            $body = @{ data = $policyExport }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess($target, "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssEventPipelinePolicy request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EventPipelinePolicy.Policy](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipelinePolicy.Policy]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
