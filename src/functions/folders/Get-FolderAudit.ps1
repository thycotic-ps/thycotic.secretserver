function Get-FolderAudit {
    <#
    .SYNOPSIS
    Get a list of audits

    .DESCRIPTION
    Get a list of audit for Folder ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderAudit -TssSession $session -Id 42

    Gets the audit entries for Folder ID

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderAudit

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssFolderAuditSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("FolderAuditId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($folder in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folders', $folder, 'audit' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'


                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting folder [$folder]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    . $TssFolderAuditSummaryObject $restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}