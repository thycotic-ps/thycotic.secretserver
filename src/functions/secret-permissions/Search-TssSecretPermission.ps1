function Search-TssSecretPermission {
    <#
    .SYNOPSIS
    Search Secret Permissions

    .DESCRIPTION
    Search Secret Permissions

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Search-TssSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Search-TssSecretPermission.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretPermission -TssSession $session -SecretId 42

    Get list of permissions for Secret ID 42

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPermissions.Permission')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ParameterSetName = 'filter', ValueFromPipelineByPropertyName)]
        # Domain Name
        [string]
        $DomainName,

        [Parameter(ParameterSetName = 'filter', ValueFromPipelineByPropertyName)]
        # Group ID
        [int]
        $GroupId,

        [Parameter(ParameterSetName = 'filter', ValueFromPipelineByPropertyName)]
        # Group Name
        [string]
        $GroupName,

        [Parameter(ParameterSetName = 'filter', ValueFromPipelineByPropertyName)]
        # Secret ID
        [int]
        $SecretId,

        [Parameter(ParameterSetName = 'filter', ValueFromPipelineByPropertyName)]
        # User ID
        [int]
        $UserId,

        [Parameter(ParameterSetName = 'filter', ValueFromPipelineByPropertyName)]
        # Username
        [string]
        $Username,

        # Sort by specific property, default Id
        [string]
        $SortBy = 'Id'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $filterParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'filter'
        $filterParams = @()
        foreach ($f in $filterParamSet) {
            if ($tssParams.ContainsKey($f)) {
                $filterParams += $r
            }
        }
    }
    process {
        if ($filterParams.Count -eq 0) {
            Write-Error 'At least one filter parameter is required'
            return
        }
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-permissions' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'DomainName' { $filters += "filter.domainName=$DomainName" }
                'GroupId' { $filters += "filter.groupId=$GroupId" }
                'GroupName' { $filters += "filter.groupName=$GroupName" }
                'SecretId' { $filters += "filter.secretId=$SecretId" }
                'UserId' { $filters += "filter.userId=$UserId" }
                'Username' { $filters += "filter.username=$Username" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No SecretPermission found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretPermissions.Permission[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}