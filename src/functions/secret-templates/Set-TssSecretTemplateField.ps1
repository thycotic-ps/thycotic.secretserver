function Set-TssSecretTemplateField {
    <#
    .SYNOPSIS
    Set properties of a secret template field

    .DESCRIPTION
    Changes one or more properties of a secret template field. Only the parameters you pass are changed.
    Returns the updated field.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template field ID

    .PARAMETER Active
    Set the field active, or inactive with -Active:$false

    .PARAMETER DataType
    Field data type. Rarely changed after secrets use the field

    .PARAMETER Description
    Field description

    .PARAMETER DropdownOptionsToAdd
    Values to add to the dropdown options of a list field

    .PARAMETER DropdownOptionsToRemove
    Dropdown options to remove: objects with id and value properties, as in the DropdownOptions of Get-TssSecretTemplateField

    .PARAMETER DropdownOptionsToUpdate
    Dropdown options to change: objects with the id of an existing option and its new value

    .PARAMETER EditRequiresPermission
    Permission a user needs to edit the field value

    .PARAMETER ExposeForDisplay
    Expose the field value for display, or hide it with -ExposeForDisplay:$false

    .PARAMETER HistoryLength
    Number of previous values to keep. Ignored when SaveAllHistory is set

    .PARAMETER Name
    Display name of the field

    .PARAMETER PasswordRequirement
    Password requirement ID for a password field

    .PARAMETER Required
    Make the field required, or optional with -Required:$false

    .PARAMETER SaveAllHistory
    Keep every previous value of the field

    .PARAMETER Searchable
    Make the field searchable, or not with -Searchable:$false

    .PARAMETER SlugName
    Slug name that scripts and the API use to reference the field. Changing it breaks scripts that use the old slug

    .PARAMETER SortOrder
    Position of the field on the template

    .PARAMETER ViewingRequiresEdit
    Require edit permission to view the field value

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretTemplateField -TssSession $session -Id 312 -Description 'Owner of the service account' -Searchable

    Change the description of field 312 and make it searchable

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretTemplateField -TssSession $session -Id 314 -DropdownOptionsToAdd 'Production', 'Staging'

    Add two dropdown options to list field 314

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.FieldDetail')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateFieldId', 'FieldId')]
        [int]
        $Id,

        [switch]
        $Active,

        [ValidateSet('Text', 'Notes', 'Url', 'Password', 'File', 'List', 'UrlList')]
        [string]
        $DataType,

        [string]
        $Description,

        [string[]]
        $DropdownOptionsToAdd,

        [object[]]
        $DropdownOptionsToRemove,

        [object[]]
        $DropdownOptionsToUpdate,

        [ValidateSet('Edit', 'Owner', 'NotEditable')]
        [string]
        $EditRequiresPermission,

        [switch]
        $ExposeForDisplay,

        [int]
        $HistoryLength,

        [string]
        $Name,

        [int]
        $PasswordRequirement,

        [switch]
        $Required,

        [switch]
        $SaveAllHistory,

        [switch]
        $Searchable,

        [string]
        $SlugName,

        [int]
        $SortOrder,

        [switch]
        $ViewingRequiresEdit
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates', 'fields', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'DataType' {
                    $body.data.Add('dataType', @{ dirty = $true; value = $DataType })
                }
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'DropdownOptionsToAdd' {
                    $body.data.Add('dropdownOptionsToAdd', @{ dirty = $true; value = $DropdownOptionsToAdd })
                }
                'DropdownOptionsToRemove' {
                    $body.data.Add('dropdownOptionsToRemove', @{ dirty = $true; value = $DropdownOptionsToRemove })
                }
                'DropdownOptionsToUpdate' {
                    $body.data.Add('dropdownOptionsToUpdate', @{ dirty = $true; value = $DropdownOptionsToUpdate })
                }
                'EditRequiresPermission' {
                    $body.data.Add('editRequiresPermission', @{ dirty = $true; value = $EditRequiresPermission })
                }
                'ExposeForDisplay' {
                    $body.data.Add('exposeForDisplay', @{ dirty = $true; value = [boolean]$ExposeForDisplay })
                }
                'HistoryLength' {
                    $body.data.Add('historyLength', @{ dirty = $true; value = $HistoryLength })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'PasswordRequirement' {
                    $body.data.Add('passwordRequirement', @{ dirty = $true; value = $PasswordRequirement })
                }
                'Required' {
                    $body.data.Add('required', @{ dirty = $true; value = [boolean]$Required })
                }
                'SaveAllHistory' {
                    $body.data.Add('saveAllHistory', @{ dirty = $true; value = [boolean]$SaveAllHistory })
                }
                'Searchable' {
                    $body.data.Add('searchable', @{ dirty = $true; value = [boolean]$Searchable })
                }
                'SlugName' {
                    $body.data.Add('slugName', @{ dirty = $true; value = $SlugName })
                }
                'SortOrder' {
                    $body.data.Add('sortOrder', @{ dirty = $true; value = $SortOrder })
                }
                'ViewingRequiresEdit' {
                    $body.data.Add('viewingRequiresEdit', @{ dirty = $true; value = [boolean]$ViewingRequiresEdit })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template field: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretTemplateField request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.FieldDetail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.FieldDetail]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
