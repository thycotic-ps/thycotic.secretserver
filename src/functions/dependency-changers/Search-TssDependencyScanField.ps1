function Search-TssDependencyScanField {
    <#
    .SYNOPSIS
    List the scan fields of a discovery scan template

    .DESCRIPTION
    Returns the fields of a discovery scan template that dependency changers can match on.
    The server requires a scan template ID and returns HTTP 500 without one.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ScanTemplateId
    Discovery scan template ID (ScanItemTemplateId on a dependency changer)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDependencyScanField -TssSession $session -ScanTemplateId 11

    List the scan fields of scan template 11

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDependencyChanger -TssSession $session -Id 1 | Search-TssDependencyScanField -TssSession $session

    List the scan fields of the scan template that dependency changer 1 uses

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyScanField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyScanField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DependencyChangers.ScanField[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScanItemTemplateId')]
        [int]
        $ScanTemplateId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dependency-changers', 'scan-fields' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'ScanTemplateId' {
                    $queryParams += "scanTemplateId=$($ScanTemplateId)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDependencyScanField request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DependencyChangers.ScanField[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DependencyChangers.ScanField]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
