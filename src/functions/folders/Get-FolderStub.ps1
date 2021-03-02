function Get-FolderStub {
    <#
    .SYNOPSIS
    Get template for new secret folder

    .DESCRIPTION
    Get template for new secret folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderStub -TssSession $session

    Returns folder template as an object

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolderStub

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssFolder')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession
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
            $uri = $TssSession.ApiUrl, 'folders/stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'


            Write-Verbose "$($invokeParams.Method) $uri with $body"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue getting folder stub"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                . $TssFolderObject $restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}