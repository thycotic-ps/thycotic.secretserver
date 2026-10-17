function New-TssDiscoverySecretSearchFilter {
    <#
    .SYNOPSIS
    Create a discovery secret search filter

    .DESCRIPTION
    Creates a secret search filter.
    Discovery scanners use it to find the secret that holds the credential for a scan by matching secret names in a folder.
    The filter is created active and searches subfolders unless -IsActive:$false or -IncludeSubfolders:$false is given.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FolderId
    ID of the folder to search for matching secrets

    .PARAMETER SecretTypeId
    Secret template ID of the secrets to match

    .PARAMETER SecretNameSearchPattern
    Secret name to match

    .PARAMETER IncludeSubfolders
    Also search the subfolders of the folder (default true)

    .PARAMETER AllowPartialMatch
    Match when the pattern is only part of the secret name

    .PARAMETER ExpectSingle
    Log a warning when more than one secret matches

    .PARAMETER IsActive
    Create the filter active (default true)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoverySecretSearchFilter -TssSession $session -FolderId 12 -SecretTypeId 6003 -SecretNameSearchPattern 'svc-sql' -AllowPartialMatch

    Create a filter that finds secrets of template 6003 in folder 12 or its subfolders whose name contains svc-sql

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySecretSearchFilter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySecretSearchFilter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.SecretSearchFilter')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $FolderId,

        [Parameter(Mandatory)]
        [int]
        $SecretTypeId,

        [Parameter(Mandatory)]
        [string]
        $SecretNameSearchPattern,

        [switch]
        $IncludeSubfolders,

        [switch]
        $AllowPartialMatch,

        [switch]
        $ExpectSingle,

        [switch]
        $IsActive
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'secret-search-filters' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    folderId                = $FolderId
                    secretTypeId            = $SecretTypeId
                    secretNameSearchPattern = $SecretNameSearchPattern
                    includeSubfolders       = (-not $tssParams.ContainsKey('IncludeSubfolders')) -or [boolean]$IncludeSubfolders
                    allowPartialMatch       = [boolean]$AllowPartialMatch
                    expectSingle            = [boolean]$ExpectSingle
                    isActive                = (-not $tssParams.ContainsKey('IsActive')) -or [boolean]$IsActive
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery secret search filter", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoverySecretSearchFilter request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SecretSearchFilter](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SecretSearchFilter]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
