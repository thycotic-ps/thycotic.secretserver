function Get-TssMetadataField {
    <#
    .SYNOPSIS
    Get list of all metadata fields

    .DESCRIPTION
    Get list of all metadata fields

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssMetadataField -TssSession $session

    Return list of all metadata fields that exists

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Get-TssMetadataField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Get-TssMetadataField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Metadata.FieldSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
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
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'metadata', 'fields' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting reference name on [$var name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records) {
                [Thycotic.PowerShell.Metadata.FieldSummary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}