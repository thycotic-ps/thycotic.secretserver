function Update-TssListOption {
    <#
    .SYNOPSIS
    Update the options of a list

    .DESCRIPTION
    Update existing options of a categorized list, or replace all of them.
    By default it updates the options passed in -Item (objects from Get-TssListOption with a changed Value or Category).
    Use -Single to update one option by its ID, or -Replace to remove every current option and add the given values instead.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Categorized List ID

    .PARAMETER Item
    Options to update, as returned by Get-TssListOption, with the new Value and Category set

    .PARAMETER Single
    Update one option by its ID (PUT lists/{id}/options/single)

    .PARAMETER OptionId
    Categorized List Item ID of the option to update

    .PARAMETER Replace
    Replace every option in the list with the given values (PUT lists/{id}/options/replace)

    .PARAMETER Value
    New option value. With -Single pass exactly one value; with -Replace pass every value the list should hold

    .PARAMETER Category
    Category for the updated or replacement options. Leave it out to leave the options uncategorized. With -Single that removes the option's current category: pass its current category to keep it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $options = Get-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'
    $options[0].Value = 'server1-renamed'
    Update-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Item $options[0]

    Renames the first option of the list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Single -OptionId '0a6f4c3e-1b2d-4e5f-8a9b-0c1d2e3f4a5b' -Value 'server2' -Category 'Prod'

    Changes one option's value to server2 and its category to Prod

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssListOption -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Replace -Value 'server1','server2' -Category 'Dev'

    Removes every option in the list and leaves only server1 and server2 in the Dev category

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Update-TssListOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Update-TssListOption.ps1

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
        [Thycotic.PowerShell.Lists.Item[]]
        $Item,

        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [switch]
        $Single,

        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [Alias('CategorizedListItemId')]
        [string]
        $OptionId,

        [Parameter(Mandatory, ParameterSetName = 'Replace')]
        [switch]
        $Replace,

        [Parameter(Mandatory, ParameterSetName = 'Single')]
        [Parameter(Mandatory, ParameterSetName = 'Replace')]
        [string[]]
        $Value,

        [Parameter(ParameterSetName = 'Single')]
        [Parameter(ParameterSetName = 'Replace')]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            switch ($PSCmdlet.ParameterSetName) {
                'Single' {
                    if ($Value.Count -ne 1) {
                        Write-Error '-Single updates one option: pass exactly one -Value'
                        return
                    }
                    $uri = $TssSession.ApiUrl, 'lists', $Id, 'options', 'single' -join '/'
                    $option = @{
                        categorizedListItemId = $OptionId
                        value                 = @{ dirty = $true; value = $Value[0] }
                    }
                    if ($tssParams.ContainsKey('Category')) {
                        $option.category = @{ dirty = $true; value = $Category }
                    }
                    $requestBody = @{ option = $option }
                }
                'Replace' {
                    $uri = $TssSession.ApiUrl, 'lists', $Id, 'options', 'replace' -join '/'
                    $rows = foreach ($optionValue in $Value) {
                        $row = @{ value = @{ dirty = $true; value = $optionValue } }
                        if ($tssParams.ContainsKey('Category')) {
                            $row.category = @{ dirty = $true; value = $Category }
                        }
                        $row
                    }
                    $requestBody = @{ data = @($rows) }
                }
                default {
                    $uri = $TssSession.ApiUrl, 'lists', $Id, 'options' -join '/'
                    $rows = foreach ($option in $Item) {
                        @{
                            categorizedListItemId = $option.CategorizedListItemId
                            value                 = @{ dirty = $true; value = $option.Value }
                            category              = @{ dirty = $true; value = $option.Category }
                        }
                    }
                    $requestBody = @{ data = @($rows) }
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $invokeParams.Body = $requestBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("List: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating options of List [$Id]"
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
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
