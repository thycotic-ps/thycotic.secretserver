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

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newSecret = Get-TssSecretStub -TssSession $session -SecretTemplateId 6001
    $newSecret.Name = 'IT Dept Domain Admin'
    $newSecret.SetFieldValue('username','therealboss')

    Getting the Active Directory template stub object, setting the Name and Username on the Secret stub.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-SecretStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecret')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Template ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secrets', 'stub' -join '/'
            $uri = $uri, "secretTemplateId=$SecretTemplateId" -join '?'

            if ($tssParams['FolderId']) {
                $uri = $uri, "folderId=$FolderId" -join '&'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "$($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue getting secret stub template [$SecretTemplateId]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssSecret]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}