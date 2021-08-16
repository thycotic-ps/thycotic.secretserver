function Remove-TssMetadata {
    <#
    .SYNOPSIS
    Deletes the metadata value and all history for that item

    .DESCRIPTION
    Deletes the metadata value and all history for that item

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssMetadata -TssSession $session -ItemId 5 -ItemDataId 1 -Type User

    Delete Item ID 5 and allits history

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Remove-TssMetadata

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Remove-TssMetadata.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Item ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int]
        $ItemId,

        # Metadata Item Data ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('MetadataItemDataId')]
        [int]
        $ItemDataId,

        # Item Type
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.MetadataType]
        [Alias('MetadataType')]
        $Type
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '11.0.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'metadata', $Type, $ItemId, $ItemDataId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'

            if (-not $PSCmdlet.ShouldProcess("Metadata Item: $ItemId","$($invokeParams.Method) $uri")) { return }
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue removing metadata item [$ItemId]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Common.Delete]@{
                    Id         = $ItemId
                    ObjectType = 'Metadata'
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}