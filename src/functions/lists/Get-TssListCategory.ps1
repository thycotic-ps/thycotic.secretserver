function Get-TssListCategory {
    <#
    .SYNOPSIS
    Return a list of categories availabe for the provided List ID

    .DESCRIPTION
    Return a list of categories availabe for the provided List ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssListCategory -TssSession $session -Id df0b8746-581f-4ac2-a9b2-5a2b7a679f3e

    Return categories for the provided ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssList -TssSession $session -SearchText "Servers" | Get-TssListCategory -TssSession $session

    Return categories for Lists with the name "Servers"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssListCategory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssListCategory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.Category')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Categorized List ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('CategorizedListId')]
        [string[]]
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
            foreach ($list in $Id) {
                $uri = $TssSession.ApiUrl, 'lists', $list, 'categories' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting List [$list] categories"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    foreach ($record in $restResponse.records) {
                        [Thycotic.PowerShell.Lists.Category]@{
                            CategorizedListId = $list
                            CategoryName = $record
                        }
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}