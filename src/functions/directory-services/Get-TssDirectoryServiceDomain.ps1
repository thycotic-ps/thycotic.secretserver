function Get-TssDirectoryServiceDomain {
    <#
    .SYNOPSIS
    Get a Directory Service Domain

    .DESCRIPTION
    Get a Directory Service Domain

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDirectoryServiceDomain -TssSession $session -Id 4

    Return details on Directory Services Domain ID 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceDomain -TssSession $session | Get-TssDirectoryServiceDomain -TssSession $session

    Return details on all active Directory Services domains found

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.Domain')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("DomainId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            foreach ($domain in $Id) {
                $uri = $TssSession.ApiUrl, 'directory-services', 'domains', $domain -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Domain [$domain]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.DirectoryServices.Domain[]]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}