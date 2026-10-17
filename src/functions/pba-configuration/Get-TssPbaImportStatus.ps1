function Get-TssPbaImportStatus {
    <#
    .SYNOPSIS
    Get the Privilege Behavior Analytics (PBA) historical import status

    .DESCRIPTION
    Returns the total number of historical events and how many are not yet processed into PBA.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPbaImportStatus -TssSession $session

    Returns the historical event counts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Get-TssPbaImportStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Get-TssPbaImportStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the View or Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PbaConfiguration.ImportStatus')]
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
            $uri = $TssSession.ApiUrl, 'pba-configuration', 'get-historical-import-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPbaImportStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PbaConfiguration.ImportStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PbaConfiguration.ImportStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
