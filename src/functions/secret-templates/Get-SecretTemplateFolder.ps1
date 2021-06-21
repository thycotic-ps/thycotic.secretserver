function Get-SecretTemplateFolder {
    <#
    .SYNOPSIS
    Get Secret Templates allowed on a given folder

    .DESCRIPTION
    Get Secret Templates allowed on a given folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplateFolder -TssSession $session -FolderId 64

    Returns a list of Secret Templates allowed for Folder ID 64

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-SecretTemplateFolder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretTemplateView')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Folder ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int[]]
        $FolderId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($folder in $FolderId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'templates', $folder -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting templates on [$folder]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssSecretTemplateView[]]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}