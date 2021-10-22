function Add-TssListOption {
    <#
    .SYNOPSIS
    Add option(s) to a list with the specified category

    .DESCRIPTION
    Add option(s) to a list with the specified category, the category will be created if missing

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Category Dev -Option 'server1','server2','server3'

    Add the 3 server item values to the category Dev on the specified List ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $list = Search-TssList -TssSession $session -SearchText 'Test List - Servers'
    $data = Import-Csv c:\temp\newlist.csv
    foreach ($category in $data.Category) { Add-TssListOption -TssSession $session -Id $list.CategorizedListId -Category $category -Option $data.Where({$_.Category -eq $Category}).Option }

    List "Test List - Servers" ID retrieved, import a CSV (newlist.csv) that contains multiple categories and option values. Each is imported into the provided List.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Add-TssListOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Add-TssListOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.List.Item')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Categorized List ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CategorizedListId')]
        [string]
        $Id,

        # Category name
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'cat')]
        [Alias('CategoryName')]
        [string]
        $Category,

        # Item value
        [Parameter(Mandatory, ParameterSetName = 'cat')]
        [string[]]
        $Option
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
            Get-TssInvocation $PSCmdlet.MyInvocation
            if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
                Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
                $uri = $TssSession.ApiUrl, 'lists', $Id, 'options', $Category -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $categoryBody = @{}
                $categoryOptions = @()
                foreach ($item in $Option) {
                    $categoryOptions += @{
                        category = @{
                            dirty = $true
                            value = $Category
                        }
                        value = @{
                            dirty = $true
                            value = $item
                        }
                    }
                }
                $categoryBody.Add('data',@($categoryOptions))

                $invokeParams.Body = $categoryBody | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Category: $Category", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with request'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.records) {
                        foreach ($record in $restResponse.records) {
                            [Thycotic.PowerShell.Lists.Item]@{
                                CategorizedListID = $record.categorizedListId
                                CategorizedListItemId = $record.categorizedListItemId
                                Category = $record.category.value
                                Value = $record.value.value
                            }
                        }
                    }
                }
            } else {
                Write-Warning 'No valid session found'
            }
        }
}