function Copy-TssSecretTemplate {
    <#
    .SYNOPSIS
    Copy a secret template

    .DESCRIPTION
    Creates a new secret template that duplicates an existing template, including its fields.
    Use -Name to name the copy; Secret Server requires a name.
    Returns the detail of the new template, including its ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template ID to copy

    .PARAMETER Name
    Name of the new template

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Copy-TssSecretTemplate -TssSession $session -Id 6001 -Name 'Windows Account (Ops)'

    Copy template 6001 to a new template named Windows Account (Ops)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Copy-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Copy-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Detail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [string]
        $Name
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates', $Id, 'copy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('name', $Name)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Copy-TssSecretTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Detail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Detail]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
