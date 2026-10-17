function Get-TssSecretTemplatePermissionGrouped {
    <#
    .SYNOPSIS
    Get secret template permissions grouped by template and role

    .DESCRIPTION
    Returns one record per secret template and role, with the users and groups that hold the role in Assignments.
    Filter by template, group or user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER GroupId
    Return only permissions held by this group ID

    .PARAMETER SecretTemplateId
    Return only permissions on this secret template ID

    .PARAMETER UserId
    Return only permissions held by this user ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplatePermissionGrouped -TssSession $session -SecretTemplateId 6001

    Get the roles on template 6001 and who holds each one

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Get-TssSecretTemplatePermissionGrouped

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Get-TssSecretTemplatePermissionGrouped.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplatePermissions.Grouped[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $GroupId,

        [Alias('TemplateId')]
        [int]
        $SecretTemplateId,

        [int]
        $UserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-template-permissions', 'grouped' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'GroupId' {
                    $queryParams += "filter.groupId=$($GroupId)"
                }
                'SecretTemplateId' {
                    $queryParams += "filter.templateId=$($SecretTemplateId)"
                }
                'UserId' {
                    $queryParams += "filter.userId=$($UserId)"
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
                Write-Warning 'Issue with Get-TssSecretTemplatePermissionGrouped request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretTemplatePermissions.Grouped[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecretTemplatePermissions.Grouped]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
