function Get-TssExtendedFieldRegex {
    <#
    .SYNOPSIS
    Get the extended field regex values of a secret

    .DESCRIPTION
    Returns the regular expressions that apply to the extended fields of a secret, taken from the extended mappings of its secret template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssExtendedFieldRegex -TssSession $session -Id 42

    Returns the extended field regex values of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/extended-fields/Get-TssExtendedFieldRegex

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/extended-fields/Get-TssExtendedFieldRegex.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExtendedFields.Regex')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
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
                $uri = $TssSession.ApiUrl, 'extended-fields', 'regex', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssExtendedFieldRegex request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.model) {
                    [Thycotic.PowerShell.ExtendedFields.Regex](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.ExtendedFields.Regex]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
