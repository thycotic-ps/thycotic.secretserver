function Get-TssRpcScanTemplate {
    <#
    .SYNOPSIS
    Get the scan item templates available to password types

    .DESCRIPTION
    Get the scan item templates a password type can be mapped to, with the fields each template defines and whether each field is required.
    A password type's fields are mapped to these fields with Set-TssRpcScanTemplateField.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRpcScanTemplate -TssSession $session

    List every scan item template and its fields

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssRpcScanTemplate -TssSession $session | Where-Object ScanItemTemplateId -eq 10).Fields | Where-Object IsRequired

    List the required fields of scan item template 10

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssRpcScanTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssRpcScanTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.ScanTemplate[]')]
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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'scan-templates' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $uri = $uri, ($queryParams -join '&') -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssRpcScanTemplate request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Rpc.ScanTemplate[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Rpc.ScanTemplate]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
