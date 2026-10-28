function Search-TssSecretTemplateSimple {
    <#
    .SYNOPSIS
    Search the secret templates the current user can use

    .DESCRIPTION
    Returns the ID and name of the active secret templates the current user can see, and whether the user can create secrets from each one.
    Basic users can call it, unlike Search-TssSecretTemplate.
    Use -OnlyIncludeCreatable with -FolderId to list the templates the user can create secrets from in that folder.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FolderId
    Folder ID used with -OnlyIncludeCreatable

    .PARAMETER OnlyIncludeCreatable
    Return only templates the user can create secrets from in the folder given by -FolderId

    .PARAMETER OnlyIncludeTemplatesWithUrl
    Return only templates that have a URL or URL list field

    .PARAMETER PasswordTypeId
    Return only templates that use one of these password type IDs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplateSimple -TssSession $session -FolderId 12 -OnlyIncludeCreatable

    List the templates the current user can create secrets from in folder 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Search-TssSecretTemplateSimple

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Search-TssSecretTemplateSimple.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.ListItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $FolderId,

        [switch]
        $OnlyIncludeCreatable,

        [switch]
        $OnlyIncludeTemplatesWithUrl,

        [Alias('PasswordTypeIds')]
        [int[]]
        $PasswordTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates-list' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'FolderId' {
                    $queryParams += "filter.folderId=$($FolderId)"
                }
                'OnlyIncludeCreatable' {
                    $queryParams += "filter.onlyIncludeCreatable=$([boolean]$OnlyIncludeCreatable)"
                }
                'OnlyIncludeTemplatesWithUrl' {
                    $queryParams += "filter.onlyIncludeTemplatesWithUrl=$([boolean]$OnlyIncludeTemplatesWithUrl)"
                }
                'PasswordTypeId' {
                    foreach ($queryValue in $PasswordTypeId) {
                        $queryParams += "filter.passwordTypeIds=$($queryValue)"
                    }
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretTemplateSimple request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretTemplates.ListItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecretTemplates.ListItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
