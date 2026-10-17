function Set-TssTicketSystem {
    <#
    .SYNOPSIS
    Update a ticket system

    .DESCRIPTION
    Changes the settings of a ticket system. Only the parameters you pass are sent; every other setting stays as it is. Returns the updated ticket system.
    The default ticket system cannot be made inactive on its own: pass -IsDefault:$false with -Active:$false, or make another ticket system the default first.
    TicketOverrideApproverUserId and TicketOverrideApproverGroupId replace the whole override approver list; pass both when the list holds users and groups, and an empty array to clear it. Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Ticket system ID

    .PARAMETER Active
    Make the ticket system active, so users can select it

    .PARAMETER AddCommentsToTicket
    Add the access request comment to the ticket in the integrated ticket system

    .PARAMETER BmcChangeManagementCommentWorkType
    BMC Remedy Change Management only: work type of the comments added to a ticket

    .PARAMETER BmcIncidentManagementCommentWorkType
    BMC Remedy Incident Management only: work type of the comments added to a ticket

    .PARAMETER BmcRemedyAuthentication
    BMC Remedy only: authentication value, usually the login server

    .PARAMETER BmcRemedyUrlEndpoint
    BMC Remedy only: SOAP endpoint URL (the CHG_ChangeInterface_WS or HPD_IncidentInterface_WS endpoint)

    .PARAMETER Description
    Description of the ticket system

    .PARAMETER DisplayMessage
    Label shown to users for the ticket number field

    .PARAMETER EnableTicketOverride
    Whether users can request an approved override when the ticket system rejects a ticket number

    .PARAMETER ForceRequireTicketNumber
    What a user must enter: a reason only, a ticket number only, both, or either

    .PARAMETER HideComment
    Hide the comment box on secret access requests

    .PARAMETER IsDefault
    Make this the default ticket system

    .PARAMETER Name
    Name of the ticket system, unique among active ticket systems

    .PARAMETER PowerShellAddCommentScriptArguments
    PowerShell only: arguments for the add comment script, separated by spaces

    .PARAMETER PowerShellAddCommentScriptId
    PowerShell only: ID of the script that adds a comment to the ticket system

    .PARAMETER PowerShellAddTicketCommentScriptArguments
    PowerShell only: arguments for the add ticket comment script, separated by spaces

    .PARAMETER PowerShellAddTicketCommentScriptId
    PowerShell only: ID of the script that adds a comment to a ticket

    .PARAMETER PowerShellRunAsAccountSecretId
    PowerShell only: ID of the secret whose credentials run the scripts

    .PARAMETER PowerShellTicketStatusScriptArguments
    PowerShell only: arguments for the ticket status script, separated by spaces

    .PARAMETER PowerShellTicketStatusScriptId
    PowerShell only: ID of the script that returns the ticket status

    .PARAMETER ServiceNowAllowedStatuses
    ServiceNow only: ticket statuses to accept, separated by commas

    .PARAMETER ServiceNowDomainName
    ServiceNow only: domain name that hosts the ServiceNow REST web services

    .PARAMETER SiteId
    ID of the site that runs the integration

    .PARAMETER SystemCredentialSecretId
    ID of the secret whose credentials connect to the integrated ticket system

    .PARAMETER TicketNumberErrorMessage
    Message shown when a ticket number fails validation

    .PARAMETER TicketNumberValidation
    Regular expression a ticket number must match

    .PARAMETER TicketOverrideApproverGroupId
    IDs of the groups that approve override requests

    .PARAMETER TicketOverrideApproverUserId
    IDs of the users who approve override requests

    .PARAMETER TicketOverrideDenyComment
    Comment sent to pending override requests when the ticket system or ticket override is turned off

    .PARAMETER TicketOverrideDurationMinutes
    Minutes an override request stays open for approval

    .PARAMETER TicketOverrideSecretOwners
    Let secret owners approve override requests

    .PARAMETER TicketSystemType
    Type of ticket system: TicketNumberValidation checks a regular expression in Secret Server, the others call ServiceNow, BMC Remedy or PowerShell scripts

    .PARAMETER ViewTicketUrl
    URL pattern to view a ticket in the ticket system

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssTicketSystem -TssSession $session -Id 3 -Description 'Change requests from the CAB' -ForceRequireTicketNumber TicketNumberOrReasonRequired

    Change the description of ticket system 3 and accept a reason or a ticket number

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssTicketSystem -TssSession $session -Id 3 -EnableTicketOverride OnlyWhenValidationFails -TicketOverrideApproverGroupId 5 -TicketOverrideDurationMinutes 60

    Allow override requests when validation fails, approved by group 5 within an hour

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssTicketSystem -TssSession $session -Id 3 -Active:$false

    Retire ticket system 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Set-TssTicketSystem

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Set-TssTicketSystem.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.TicketSystems.TicketSystem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TicketSystemId')]
        [int]
        $Id,

        [switch]
        $Active,

        [switch]
        $AddCommentsToTicket,

        [string]
        $BmcChangeManagementCommentWorkType,

        [string]
        $BmcIncidentManagementCommentWorkType,

        [string]
        $BmcRemedyAuthentication,

        [string]
        $BmcRemedyUrlEndpoint,

        [string]
        $Description,

        [string]
        $DisplayMessage,

        [ValidateSet('Off', 'On', 'OnlyWhenValidationFails')]
        [string]
        $EnableTicketOverride,

        [ValidateSet('ReasonOnlyRequired', 'BothRequired', 'TicketNumberOrReasonRequired', 'TicketNumberOnlyRequired')]
        [string]
        $ForceRequireTicketNumber,

        [switch]
        $HideComment,

        [switch]
        $IsDefault,

        [string]
        $Name,

        [string]
        $PowerShellAddCommentScriptArguments,

        [int]
        $PowerShellAddCommentScriptId,

        [string]
        $PowerShellAddTicketCommentScriptArguments,

        [int]
        $PowerShellAddTicketCommentScriptId,

        [int]
        $PowerShellRunAsAccountSecretId,

        [string]
        $PowerShellTicketStatusScriptArguments,

        [int]
        $PowerShellTicketStatusScriptId,

        [string]
        $ServiceNowAllowedStatuses,

        [string]
        $ServiceNowDomainName,

        [int]
        $SiteId,

        [int]
        $SystemCredentialSecretId,

        [string]
        $TicketNumberErrorMessage,

        [string]
        $TicketNumberValidation,

        [AllowEmptyCollection()]
        [int[]]
        $TicketOverrideApproverGroupId,

        [AllowEmptyCollection()]
        [int[]]
        $TicketOverrideApproverUserId,

        [string]
        $TicketOverrideDenyComment,

        [int]
        $TicketOverrideDurationMinutes,

        [switch]
        $TicketOverrideSecretOwners,

        [ValidateSet('TicketNumberValidation', 'BmcRemedyIncidentManagement', 'BmcRemedyChangeManagement', 'PowerShell', 'ServiceNowChangeManagement', 'ServiceNowIncidentManagement')]
        [string]
        $TicketSystemType,

        [string]
        $ViewTicketUrl
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ticket-systems', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'AddCommentsToTicket' {
                    $body.data.Add('addCommentsToTicket', @{ dirty = $true; value = [boolean]$AddCommentsToTicket })
                }
                'BmcChangeManagementCommentWorkType' {
                    $body.data.Add('bmcChangeManagementCommentWorkType', @{ dirty = $true; value = $BmcChangeManagementCommentWorkType })
                }
                'BmcIncidentManagementCommentWorkType' {
                    $body.data.Add('bmcIncidentManagementCommentWorkType', @{ dirty = $true; value = $BmcIncidentManagementCommentWorkType })
                }
                'BmcRemedyAuthentication' {
                    $body.data.Add('bmcRemedyAuthentication', @{ dirty = $true; value = $BmcRemedyAuthentication })
                }
                'BmcRemedyUrlEndpoint' {
                    $body.data.Add('bmcRemedyUrlEndpoint', @{ dirty = $true; value = $BmcRemedyUrlEndpoint })
                }
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'DisplayMessage' {
                    $body.data.Add('displayMessage', @{ dirty = $true; value = $DisplayMessage })
                }
                'EnableTicketOverride' {
                    $body.data.Add('enableTicketOverride', @{ dirty = $true; value = $EnableTicketOverride })
                }
                'ForceRequireTicketNumber' {
                    $body.data.Add('forceRequireTicketNumber', @{ dirty = $true; value = $ForceRequireTicketNumber })
                }
                'HideComment' {
                    $body.data.Add('hideComment', @{ dirty = $true; value = [boolean]$HideComment })
                }
                'IsDefault' {
                    $body.data.Add('isDefault', @{ dirty = $true; value = [boolean]$IsDefault })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'PowerShellAddCommentScriptArguments' {
                    $body.data.Add('powerShellAddCommentScriptArguments', @{ dirty = $true; value = $PowerShellAddCommentScriptArguments })
                }
                'PowerShellAddCommentScriptId' {
                    $body.data.Add('powerShellAddCommentScriptId', @{ dirty = $true; value = $PowerShellAddCommentScriptId })
                }
                'PowerShellAddTicketCommentScriptArguments' {
                    $body.data.Add('powerShellAddTicketCommentScriptArguments', @{ dirty = $true; value = $PowerShellAddTicketCommentScriptArguments })
                }
                'PowerShellAddTicketCommentScriptId' {
                    $body.data.Add('powerShellAddTicketCommentScriptId', @{ dirty = $true; value = $PowerShellAddTicketCommentScriptId })
                }
                'PowerShellRunAsAccountSecretId' {
                    $body.data.Add('powerShellRunAsAccountSecretId', @{ dirty = $true; value = $PowerShellRunAsAccountSecretId })
                }
                'PowerShellTicketStatusScriptArguments' {
                    $body.data.Add('powerShellTicketStatusScriptArguments', @{ dirty = $true; value = $PowerShellTicketStatusScriptArguments })
                }
                'PowerShellTicketStatusScriptId' {
                    $body.data.Add('powerShellTicketStatusScriptId', @{ dirty = $true; value = $PowerShellTicketStatusScriptId })
                }
                'ServiceNowAllowedStatuses' {
                    $body.data.Add('serviceNowAllowedStatuses', @{ dirty = $true; value = $ServiceNowAllowedStatuses })
                }
                'ServiceNowDomainName' {
                    $body.data.Add('serviceNowDomainName', @{ dirty = $true; value = $ServiceNowDomainName })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
                'SystemCredentialSecretId' {
                    $body.data.Add('systemCredentialSecretId', @{ dirty = $true; value = $SystemCredentialSecretId })
                }
                'TicketNumberErrorMessage' {
                    $body.data.Add('ticketNumberErrorMessage', @{ dirty = $true; value = $TicketNumberErrorMessage })
                }
                'TicketNumberValidation' {
                    $body.data.Add('ticketNumberValidation', @{ dirty = $true; value = $TicketNumberValidation })
                }
                'TicketOverrideDenyComment' {
                    $body.data.Add('ticketOverrideDenyComment', $TicketOverrideDenyComment)
                }
                'TicketOverrideDurationMinutes' {
                    $body.data.Add('ticketOverrideDurationMinutes', @{ dirty = $true; value = $TicketOverrideDurationMinutes })
                }
                'TicketOverrideSecretOwners' {
                    $body.data.Add('ticketOverrideSecretOwners', @{ dirty = $true; value = [boolean]$TicketOverrideSecretOwners })
                }
                'TicketSystemType' {
                    $body.data.Add('ticketSystemType', @{ dirty = $true; value = $TicketSystemType })
                }
                'ViewTicketUrl' {
                    $body.data.Add('viewTicketUrl', @{ dirty = $true; value = $ViewTicketUrl })
                }
            }
            if ($tssParams.ContainsKey('TicketOverrideApproverGroupId') -or $tssParams.ContainsKey('TicketOverrideApproverUserId')) {
                $approvers = @()
                foreach ($approverGroupId in $TicketOverrideApproverGroupId) {
                    $approvers += @{ groupId = $approverGroupId }
                }
                foreach ($approverUserId in $TicketOverrideApproverUserId) {
                    $approvers += @{ userId = $approverUserId }
                }
                $body.data.Add('ticketOverrideApprovers', @{ dirty = $true; value = $approvers })
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ticket system: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssTicketSystem request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.TicketSystems.TicketSystem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.TicketSystems.TicketSystem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
