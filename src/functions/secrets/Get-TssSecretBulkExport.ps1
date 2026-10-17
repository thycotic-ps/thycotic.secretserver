function Get-TssSecretBulkExport {
    <#
    .SYNOPSIS
    Get a bulk secret export job

    .DESCRIPTION
    Reads an export job started by Export-TssSecretBulk -Job.
    By default it returns the exported file text in ExportedSecretsFileText. -Status returns the job status (Pending, Completed or Failed); -Detail returns the secret count and any errors.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Export job ID returned by Export-TssSecretBulk -Job

    .PARAMETER Status
    Return the status of the export job (GET api/v2/secrets/export/job/{jobId})

    .PARAMETER Detail
    Return the secret count and errors of the export job (GET api/v2/secrets/export/{jobId}/details)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretBulkExport -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Status

    Returns the status of the export job

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSecretBulkExport -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e').ExportedSecretsFileText | Set-Content -Path ./secrets.xml

    Saves the file of a completed export job

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretBulkExport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretBulkExport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.Secrets.BulkExport')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExportJobId')]
        [string[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'Status')]
        [switch]
        $Status,

        [Parameter(Mandatory, ParameterSetName = 'Detail')]
        [switch]
        $Detail
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
                switch ($PSCmdlet.ParameterSetName) {
                    'Detail' {
                        $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'secrets', 'export', $currentId, 'details' -join '/'
                    }
                    'Status' {
                        $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'secrets', 'export', 'job', $currentId -join '/'
                    }
                    default {
                        $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'secrets', 'export' -join '/'
                        $uri = $uri, "jobId=$([uri]::EscapeDataString($currentId))" -join '?'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretBulkExport request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -is [string]) {
                    [Thycotic.PowerShell.Secrets.BulkExport]@{
                        ExportJobId             = $currentId
                        ExportedSecretsFileText = $restResponse
                    }
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.Secrets.BulkExport](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.BulkExport]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
