function Set-TssDiscoverySecretSearchFilter {
    <#
    .SYNOPSIS
    Update a discovery secret search filter

    .DESCRIPTION
    Updates a discovery secret search filter.
    Only the parameters given are changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret search filter ID

    .PARAMETER AllowPartialMatch
    Match when the pattern is only part of the secret name

    .PARAMETER ExpectSingle
    Log a warning when more than one secret matches

    .PARAMETER FolderId
    ID of the folder to search

    .PARAMETER IncludeSubfolders
    Also search the subfolders of the folder

    .PARAMETER IsActive
    Make the filter active, or inactive with -IsActive:$false

    .PARAMETER SecretNameSearchPattern
    Secret name to match

    .PARAMETER SecretTypeId
    Secret template ID of the secrets to match

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoverySecretSearchFilter -TssSession $session -Id 4 -IsActive:$false

    Make secret search filter 4 inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoverySecretSearchFilter -TssSession $session -Id 4 -SecretNameSearchPattern 'svc-sql' -AllowPartialMatch

    Match secret names containing svc-sql

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoverySecretSearchFilter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoverySecretSearchFilter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.SecretSearchFilter')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretSearchFilterId')]
        [int]
        $Id,

        [switch]
        $AllowPartialMatch,

        [switch]
        $ExpectSingle,

        [int]
        $FolderId,

        [switch]
        $IncludeSubfolders,

        [switch]
        $IsActive,

        [string]
        $SecretNameSearchPattern,

        [int]
        $SecretTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'secret-search-filters', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            $body.data.Add('secretSearchFilterId', @{ dirty = $true; value = $Id })
            switch ($tssParams.Keys) {
                'AllowPartialMatch' {
                    $body.data.Add('allowPartialMatch', @{ dirty = $true; value = [boolean]$AllowPartialMatch })
                }
                'ExpectSingle' {
                    $body.data.Add('expectSingle', @{ dirty = $true; value = [boolean]$ExpectSingle })
                }
                'FolderId' {
                    $body.data.Add('folderId', @{ dirty = $true; value = $FolderId })
                }
                'IncludeSubfolders' {
                    $body.data.Add('includeSubfolders', @{ dirty = $true; value = [boolean]$IncludeSubfolders })
                }
                'IsActive' {
                    $body.data.Add('isActive', @{ dirty = $true; value = [boolean]$IsActive })
                }
                'SecretNameSearchPattern' {
                    $body.data.Add('secretNameSearchPattern', @{ dirty = $true; value = $SecretNameSearchPattern })
                }
                'SecretTypeId' {
                    $body.data.Add('secretTypeId', @{ dirty = $true; value = $SecretTypeId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery secret search filter: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoverySecretSearchFilter request'
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
