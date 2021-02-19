function Get-SecretStub {
    <#
    .SYNOPSIS
    Return template object

    .DESCRIPTION
    Return a template object to be used for create a new secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretStub -TssSession $session -SecretTemplateId 6001

    Return the Active Directory template as an object

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretStub

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecret')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret Template ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('TemplateId')]
        [int]
        $SecretTemplateId,

        # Folder ID, sets the Folder ID property on the output object
        [Parameter(ValueFromPipeline)]
        [int]
        $FolderId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secrets/stub' -join '/'
            $uri = $uri, "secretTemplateId=$SecretTemplateId" -join '?'

            if ($tssParams['FolderId']) {
                $uri = $uri, "folderId=$FolderId" -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'


            Write-Verbose "$($invokeParams.Method) $uri"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue getting secret stub template [$SecretTemplateId]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                . $TssSecretObject $restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}