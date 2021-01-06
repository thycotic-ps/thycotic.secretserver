function Get-TssSecretTemplate {
    <#
    .SYNOPSIS
    Get a secret template from Secret Server

    .DESCRIPTION
    Get a secret template(s) from Secret Server

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecretTemplate -Id 93

    Returns secret associated with the Secret ID, 93

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('TssSecretTemplate')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret template ID to retrieve
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("TemplateId")]
        [int[]]
        $Id,

        #  Output the raw response from the REST API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssSecretTemplate'
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($template in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-templates', $template.ToString() -join '/'
                $invokeParams.Uri = $Uri
                $invokeParams.Method = 'GET'
                $invokeParams.PersonalAccessToken = $TssSession.AccessToken

                Write-Verbose "$($invokeParas.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting template [$template]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }

                if ($tssParams['Raw']) {
                    return $restResponse
                }
                if ($restResponse) {
                    . $GetTssSecretTemplateObject $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}