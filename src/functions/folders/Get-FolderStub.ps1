function Get-FolderStub {
    <#
    .SYNOPSIS
    Get template for new secret folder

    .DESCRIPTION
    Get template for new secret folder

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssFolderStub -TssSession $session

    Returns folder template as an object

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
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'folders/stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
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