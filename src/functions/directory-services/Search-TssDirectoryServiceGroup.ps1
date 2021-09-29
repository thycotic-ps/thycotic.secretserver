function Search-TssDirectoryServiceGroup {
    <#
    .SYNOPSIS
    Search the Directory Service for the groups assigned

    .DESCRIPTION
    Search the Directory Service for the groups assigned

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectoryServiceGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectoryServiceGroup.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceGroup -TssSession $session -DomainId 2 -SearchText Admin*

    Return list of Groups assigned to Domain ID 2 that start with Admin

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceGroup -TssSession $session -DomainId 1

    Return list of all Groups accessible in Domain ID 1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.Group')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Domain ID
        [Parameter(Mandatory)]
        [int]
        $DomainId,

        # Search Text, supports wildcard usage (e.g. *Admin*, Admin*)
        [Parameter()]
        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'directory-services', 'domains', $DomainId, 'groups', 'search-directory' -join '/'
            $uri = $uri, "searchText=$SearchText" -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.groups.Count -le 0 -and $restResponse.groups.Length -eq 0) {
                Write-Warning "No Directory Service Group found"
            }
            if ($restResponse.groups) {
                [Thycotic.PowerShell.DirectoryServices.Group[]]$restResponse.groups
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}