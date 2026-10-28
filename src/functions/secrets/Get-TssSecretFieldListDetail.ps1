function Get-TssSecretFieldListDetail {
    <#
    .SYNOPSIS
    Get the lists assigned to a list field on a secret

    .DESCRIPTION
    Returns the categorized lists assigned to a List type field on a secret, with the number of options in each list.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER Slug
    Slug of the List type field

    .PARAMETER AutoCheckIn
    Check the secret back in after the request completes

    .PARAMETER AutoCheckout
    Check out the secret automatically when it requires checkout

    .PARAMETER AutoComment
    Comment to record with the automatic checkout, for secrets that require a comment

    .PARAMETER ForceCheckIn
    Force check in the secret if another user has it checked out

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretFieldListDetail -TssSession $session -Id 42 -Slug allowed-domains

    Returns the lists assigned to the allowed-domains field of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretFieldListDetail

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretFieldListDetail.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $Slug,

        [switch]
        $AutoCheckIn,

        [switch]
        $AutoCheckout,

        [string]
        $AutoComment,

        [switch]
        $ForceCheckIn
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', $Id, 'fields', $Slug, 'listdetails' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'AutoCheckIn' {
                    $queryParams += "autoCheckIn=$([boolean]$AutoCheckIn)"
                }
                'AutoCheckout' {
                    $queryParams += "autoCheckout=$([boolean]$AutoCheckout)"
                }
                'AutoComment' {
                    $queryParams += "autoComment=$([uri]::EscapeDataString($AutoComment))"
                }
                'ForceCheckIn' {
                    $queryParams += "forceCheckIn=$([boolean]$ForceCheckIn)"
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
                Write-Warning 'Issue with Get-TssSecretFieldListDetail request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Lists.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Lists.Summary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
