function Set-TssSecretPolicy {
    <#
    .SYNOPSIS
    Set a Secret Policy property

    .DESCRIPTION
    Set a Secret Policy property

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Set-TssSecretPolicy -TssSession $session -Id 52 -Active:$false

    Set Secret Policy ID 52 to inactive, changing Active property to false

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Set-TssSecretPolicy -TssSession $session -Id 52 -Active -Name 'Set Auto Change Enabled'

    Set Secret Policy ID 52 to active and change the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/Set-TssSecretPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/Set-TssSecretPolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'policy')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Policy ID
        [Parameter(Mandatory, ParameterSetName = 'policy')]
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [Alias('SecretPolicyId')]
        [int]
        $Id,

        # Secret Policy Name
        [Parameter(ParameterSetName = 'policy')]
        [string]
        $Name,

        # Secret Policy Description
        [Parameter(ParameterSetName = 'policy')]
        [string]
        $Description,

        # Secret Policy Active or Inactive
        [Parameter(ParameterSetName = 'policy')]
        [switch]
        $Active,

        # Secret Policy Item Name
        [Parameter(ParameterSetName = 'item')]
        [Thycotic.PowerShell.Enums.SecretPolicyItem]
        $ItemName,

        # Secret Policy Item Type
        [Parameter(ParameterSetName = 'item')]
        [Thycotic.PowerShell.Enums.SecretPolicyValueType]
        $ItemType,

        # Secret Policy Item Apply Type (NotSet, Default, Enforced)
        [Parameter(ParameterSetName = 'item')]
        [Thycotic.PowerShell.Enums.SecretPolicyApplyType]
        $ItemApplyType,

        # Secret Policy Item Value (based on ItemType what object you have to pass in)
        [Parameter(ParameterSetName = 'item')]
        [object]
        $ItemValue,

        # User and Group Mapping, hashtable of UserGroupId and UserGroupMapType (User or Group)
        [Parameter(ParameterSetName = 'item')]
        [object]
        $UserGroupMap
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-policy', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setPolicyBody = @{data = @{} }
            $secretPolicyItem = @{}
            switch ($setParams.Keys) {
                'Name' {
                    $setName = @{
                        dirty = $true
                        value = $Name
                    }
                    $setPolicyBody.data.Add('secretPolicyName',$setName)
                }
                'Description' {
                    $setDesc = @{
                        dirty = $true
                        value = $Description
                    }
                    $setPolicyBody.data.Add('secretPolicyDescription',$setDesc)
                }
                'Active' {
                    $setActive = @{
                        dirty = $true
                        value = $Active
                    }
                    $setPolicyBody.Add('Active',$setActive)
                }
                'ItemName' { $secretPolicyItem.Add('secretPolicyItemId',[int]$ItemName) }
                'ItemApplyType' { $secretPolicyItem.Add('policyApplyType',[string]$ItemApplyType) }
                'ItemType' {
                    switch ($ItemType) {
                        'Bool' {
                            $valueBool = @{
                                dirty = $true
                                value = $ItemValue
                            }
                            $secretPolicyItem.Add('valueBool',$valueBool)
                        }
                        'Int' {
                            $valueInt = @{
                                dirty = $true
                                value = $ItemValue
                            }
                            $secretPolicyItem.Add('valueInt',$valueInt)
                        }
                        'SecretId' {
                            $valueSecretId = @{
                                dirty = $true
                                value = $ItemValue
                            }
                            $secretPolicyItem.Add('valueSecretId',$valueSecretId)
                        }
                        'Group' {
                            if ($setParams.ContainsKey('UserGroupMap')){
                                $userGroupMapObj = @()
                                foreach ($map in $UserGroupMap) {
                                    $userGroupMapObj += @{
                                        userGroupId      = $map.UserGroupId
                                        userGroupMapType = $map.UserGroupMapType
                                    }
                                }
                                if ($userGroupMapObj.Count -gt 0) {
                                    $userGroupMapping = @{
                                        dirty = $true
                                        value = $userGroupMapObj
                                    }
                                }
                                $secretPolicyItem.Add('userGroupMaps',$userGroupMapping)
                            } else {
                                Write-Warning 'ItemType of Group requires the -UserGroupMap to be provided'
                            }
                        }
                        'Schedule' {
                            Write-Warning "Support for this option is pending"
                        }
                        'SshMenuGroup' {
                            Write-Warning "Support for this option is pending"
                        }
                        'SshBlocklist' {
                            Write-Warning "Support for this option is pending"
                        }
                    }
                }
            }

            if ($secretPolicyItem) {
                $setPolicyBody.data.Add('secretPolicyItems',@($secretPolicyItem))
            } else {
                Write-Verbose "No policy item settings to process"
            }
            $invokeParams.Body = $setPolicyBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("description: $Primary Parameter", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue setting Secret Policy [$Id]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.SecretPolicies.Policy]$restResponse
                } else {
                    Write-Warning "No change made to Secret Policy [$Id], see previous output for errors"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}