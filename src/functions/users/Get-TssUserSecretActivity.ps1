function Get-TssUserSecretActivity {
    <#
    .SYNOPSIS
    Get the secrets a user has accessed

    .DESCRIPTION
    Returns the secrets a user accessed, with the last access date and IP address, filtered by date range and folder.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User ID

    .PARAMETER EndDate
    Only secrets accessed before this date

    .PARAMETER ExcludeInactiveSecrets
    Skip inactive secrets

    .PARAMETER ExcludeRotatedSecrets
    Skip secrets whose passwords rotate automatically

    .PARAMETER FolderId
    Only secrets in this folder

    .PARAMETER IncludeSubfolders
    With -FolderId, also secrets in its subfolders

    .PARAMETER StartDate
    Only secrets accessed on or after this date (required: without it the server fails with a SQL date overflow)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-30)

    Returns the secrets user 12 accessed in the last 30 days

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-90) -FolderId 7 -IncludeSubfolders

    Returns the secrets user 12 accessed under folder 7 and its subfolders in the last 90 days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserSecretActivity

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserSecretActivity.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.SecretActivity[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [datetime]
        $EndDate,

        [switch]
        $ExcludeInactiveSecrets,

        [switch]
        $ExcludeRotatedSecrets,

        [int]
        $FolderId,

        [switch]
        $IncludeSubfolders,

        [Parameter(Mandatory)]
        [datetime]
        $StartDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $currentId, 'secret-activity' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'EndDate' {
                        $queryParams += "filter.endDate=$([uri]::EscapeDataString($EndDate.ToString('o')))"
                    }
                    'ExcludeInactiveSecrets' {
                        $queryParams += "filter.excludeInactiveSecrets=$([boolean]$ExcludeInactiveSecrets)"
                    }
                    'ExcludeRotatedSecrets' {
                        $queryParams += "filter.excludeRotatedSecrets=$([boolean]$ExcludeRotatedSecrets)"
                    }
                    'FolderId' {
                        $queryParams += "filter.folderId=$($FolderId)"
                    }
                    'IncludeSubfolders' {
                        $queryParams += "filter.includeSubfolders=$([boolean]$IncludeSubfolders)"
                    }
                    'StartDate' {
                        $queryParams += "filter.startDate=$([uri]::EscapeDataString($StartDate.ToString('o')))"
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
                    Write-Warning 'Issue with Get-TssUserSecretActivity request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Users.SecretActivity[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Users.SecretActivity]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
