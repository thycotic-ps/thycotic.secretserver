function New-TssListOption {
    <#
    .SYNOPSIS
    Add new options to a list

    .DESCRIPTION
    Add new options to a categorized list, optionally tagged with a category.
    By default all values are sent in one request. Use -Single to send one request per value, or -Path to upload the options from a file.
    How it differs from Add-TssListOption: Add-TssListOption requires a category, puts it in the request URL, and creates the category when it is missing. New-TssListOption makes the category optional and adds the single-value and file upload ways of adding options.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Categorized List ID

    .PARAMETER Value
    Option value(s) to add

    .PARAMETER Category
    Category to tag every added option with. Leave it out for uncategorized options

    .PARAMETER Single
    Add each value with its own request (POST lists/{id}/options/single)

    .PARAMETER Path
    Path to a delimited text file of options to upload (POST lists/{id}/options/file)

    .PARAMETER Delimiter
    Delimiter used in the uploaded file, default is a comma

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Value 'server1','server2','server3'

    Adds three uncategorized options to the list in one request

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Value 'server4' -Category 'Dev' -Single

    Adds one option tagged with the Dev category using the single option endpoint

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Path ./servers.csv

    Uploads the options in servers.csv (comma delimited) to the list

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/New-TssListOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/New-TssListOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Lists.Item[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CategorizedListId')]
        [string]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [string[]]
        $Value,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'Single')]
        [string]
        $Category,

        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [switch]
        $Single,

        [Parameter(Mandatory, ParameterSetName = 'File')]
        [string]
        $Path,

        [Parameter(ParameterSetName = 'File')]
        [ValidateLength(1, 1)]
        [string]
        $Delimiter = ','
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'Single' {
                    $uri = $TssSession.ApiUrl, 'lists', $Id, 'options', 'single' -join '/'
                    $requestBodies = foreach ($optionValue in $Value) {
                        $option = @{ value = @{ dirty = $true; value = $optionValue } }
                        if ($tssParams.ContainsKey('Category')) {
                            $option.category = @{ dirty = $true; value = $Category }
                        }
                        @{ option = $option }
                    }
                }
                'File' {
                    $uri = $TssSession.ApiUrl, 'lists', $Id, 'options', 'file' -join '/'
                    $fileBytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $Path).ProviderPath)
                    $requestBodies = @(
                        @{
                            file      = @{
                                buffer       = [System.Convert]::ToBase64String($fileBytes)
                                fileName     = (Split-Path -Path $Path -Leaf)
                                mediaType    = 'application/octet-stream'
                                mediaSubType = 'octet-stream'
                            }
                            delimiter = $Delimiter
                        }
                    )
                }
                default {
                    $uri = $TssSession.ApiUrl, 'lists', $Id, 'options' -join '/'
                    $rows = foreach ($optionValue in $Value) {
                        $row = @{ value = @{ dirty = $true; value = $optionValue } }
                        if ($tssParams.ContainsKey('Category')) {
                            $row.category = @{ dirty = $true; value = $Category }
                        }
                        $row
                    }
                    $requestBodies = @(@{ data = @($rows) })
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            foreach ($requestBody in $requestBodies) {
                $restResponse = $null
                $invokeParams.Body = $requestBody | ConvertTo-Json -Depth 100
                $bodyText = if ($PSCmdlet.ParameterSetName -eq 'File') { "file $(Split-Path -Path $Path -Leaf)" } else { $invokeParams.Body }
                if ($PSCmdlet.ShouldProcess("List: $Id", "$($invokeParams.Method) $uri with:`n$bodyText`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$bodyText`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue adding options to List [$Id]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.records) {
                        foreach ($record in $restResponse.records) {
                            $categoryValue = if ($record.category -is [string]) { $record.category } else { $record.category.value }
                            $itemValue = if ($record.value -is [string]) { $record.value } else { $record.value.value }
                            [Thycotic.PowerShell.Lists.Item]@{
                                CategorizedListId     = $record.categorizedListId
                                CategorizedListItemId = $record.categorizedListItemId
                                Category              = $categoryValue
                                Value                 = $itemValue
                            }
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
