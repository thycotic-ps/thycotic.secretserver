function Get-TssListOption {
    <#
    .SYNOPSIS
    Return the List's options

    .DESCRIPTION
    Return the List's options

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Return options on the List by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssList -SearchText 'IT' | Get-TssListOption -TssSession $session

    Return options for all Lists that have "IT" in their name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssList -SearchText 'Servers' | Get-TssListOption -TssSession $session -Category $null

    Return the uncategorized options for any list with "Servers" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssListOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssListOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.Item')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Categorized List ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias("CategorizedListId")]
        [string[]]
        $Id,

        # Filter by Category name (accepts null to return un-categorized values)
        [AllowEmptyString()]
        [string]
        $Category
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            foreach ($list in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'lists', $list, 'options' -join '/'
                if ($tssParams.ContainsKey('Category')) {
                    if ([string]::IsNullOrEmpty($Category)) {
                        $uri = $uri, 'filter.nullCategoryIsUncategorized=true' -join '?'
                    }
                    else {
                        $uri = $uri, "filter.category=$Category" -join '?'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting List [$list]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [Thycotic.PowerShell.Lists.Item[]]$restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}