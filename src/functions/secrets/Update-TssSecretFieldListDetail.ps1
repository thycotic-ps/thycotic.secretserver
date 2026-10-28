function Update-TssSecretFieldListDetail {
    <#
    .SYNOPSIS
    Assign lists to a list field on a secret

    .DESCRIPTION
    Assigns categorized lists to a List type field on a secret and returns the lists assigned to the field.

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

    .PARAMETER ListId
    ID (GUID) of each list to assign to the field

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretFieldListDetail -TssSession $session -Id 42 -Slug allowed-domains -ListId 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Assigns the list to the allowed-domains field of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretFieldListDetail

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretFieldListDetail.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
        $ForceCheckIn,

        [Parameter(Mandatory)]
        [Alias('CategorizedListId')]
        [string[]]
        $ListId
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
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'ListId' {
                    $body.Add('listGuids', $ListId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret field list detail: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretFieldListDetail request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Lists.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Lists.Summary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
