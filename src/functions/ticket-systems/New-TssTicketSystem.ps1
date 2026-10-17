function New-TssTicketSystem {
    <#
    .SYNOPSIS
    Create a ticket system

    .DESCRIPTION
    Creates a ticket system for secret access requests and secret view comments. TicketNumberValidation checks ticket numbers against a regular expression inside Secret Server; the other types call ServiceNow, BMC Remedy or custom PowerShell scripts and use the matching integration parameters.
    An active ticket system needs Name (unique among active ticket systems), DisplayMessage and TicketNumberErrorMessage. Omit -Active to create it inactive. The first active ticket system becomes the default.
    Ticket systems cannot be deleted: retire one with Set-TssTicketSystem -Active:$false. Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

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

    .PARAMETER TicketOverrideSecretOwners
    Let secret owners approve override requests

    .PARAMETER TicketSystemType
    Type of ticket system: TicketNumberValidation checks a regular expression in Secret Server, the others call ServiceNow, BMC Remedy or PowerShell scripts

    .PARAMETER ViewTicketUrl
    URL pattern to view a ticket in the ticket system

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssTicketSystem -TssSession $session -Name 'Change requests' -Active -DisplayMessage 'Change number' -TicketNumberErrorMessage 'Enter a valid change number.' -TicketSystemType TicketNumberValidation -TicketNumberValidation '^CHG\d+$' -ForceRequireTicketNumber BothRequired

    Create an active ticket system that requires a reason and a change number starting with CHG

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssTicketSystem -TssSession $session -Name 'ServiceNow incidents' -TicketSystemType ServiceNowIncidentManagement -ServiceNowDomainName 'example.service-now.com' -SystemCredentialSecretId 42 -DisplayMessage 'Incident number' -TicketNumberErrorMessage 'Incident not found.'

    Create an inactive ServiceNow incident ticket system that connects with the credentials of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/New-TssTicketSystem

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/New-TssTicketSystem.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.TicketSystems.TicketSystem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

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

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'ticket-systems' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'AddCommentsToTicket' {
                    $body.data.Add('addCommentsToTicket', [boolean]$AddCommentsToTicket)
                }
                'BmcChangeManagementCommentWorkType' {
                    $body.data.Add('bmcChangeManagementCommentWorkType', $BmcChangeManagementCommentWorkType)
                }
                'BmcIncidentManagementCommentWorkType' {
                    $body.data.Add('bmcIncidentManagementCommentWorkType', $BmcIncidentManagementCommentWorkType)
                }
                'BmcRemedyAuthentication' {
                    $body.data.Add('bmcRemedyAuthentication', $BmcRemedyAuthentication)
                }
                'BmcRemedyUrlEndpoint' {
                    $body.data.Add('bmcRemedyUrlEndpoint', $BmcRemedyUrlEndpoint)
                }
                'Description' {
                    $body.data.Add('description', $Description)
                }
                'DisplayMessage' {
                    $body.data.Add('displayMessage', $DisplayMessage)
                }
                'EnableTicketOverride' {
                    $body.data.Add('enableTicketOverride', $EnableTicketOverride)
                }
                'ForceRequireTicketNumber' {
                    $body.data.Add('forceRequireTicketNumber', $ForceRequireTicketNumber)
                }
                'HideComment' {
                    $body.data.Add('hideComment', [boolean]$HideComment)
                }
                'IsDefault' {
                    $body.data.Add('isDefault', [boolean]$IsDefault)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
                'PowerShellAddCommentScriptArguments' {
                    $body.data.Add('powerShellAddCommentScriptArguments', $PowerShellAddCommentScriptArguments)
                }
                'PowerShellAddCommentScriptId' {
                    $body.data.Add('powerShellAddCommentScriptId', $PowerShellAddCommentScriptId)
                }
                'PowerShellAddTicketCommentScriptArguments' {
                    $body.data.Add('powerShellAddTicketCommentScriptArguments', $PowerShellAddTicketCommentScriptArguments)
                }
                'PowerShellAddTicketCommentScriptId' {
                    $body.data.Add('powerShellAddTicketCommentScriptId', $PowerShellAddTicketCommentScriptId)
                }
                'PowerShellRunAsAccountSecretId' {
                    $body.data.Add('powerShellRunAsAccountSecretId', $PowerShellRunAsAccountSecretId)
                }
                'PowerShellTicketStatusScriptArguments' {
                    $body.data.Add('powerShellTicketStatusScriptArguments', $PowerShellTicketStatusScriptArguments)
                }
                'PowerShellTicketStatusScriptId' {
                    $body.data.Add('powerShellTicketStatusScriptId', $PowerShellTicketStatusScriptId)
                }
                'ServiceNowAllowedStatuses' {
                    $body.data.Add('serviceNowAllowedStatuses', $ServiceNowAllowedStatuses)
                }
                'ServiceNowDomainName' {
                    $body.data.Add('serviceNowDomainName', $ServiceNowDomainName)
                }
                'SiteId' {
                    $body.data.Add('siteId', $SiteId)
                }
                'SystemCredentialSecretId' {
                    $body.data.Add('systemCredentialSecretId', $SystemCredentialSecretId)
                }
                'TicketNumberErrorMessage' {
                    $body.data.Add('ticketNumberErrorMessage', $TicketNumberErrorMessage)
                }
                'TicketNumberValidation' {
                    $body.data.Add('ticketNumberValidation', $TicketNumberValidation)
                }
                'TicketOverrideSecretOwners' {
                    $body.data.Add('ticketOverrideSecretOwners', [boolean]$TicketOverrideSecretOwners)
                }
                'TicketSystemType' {
                    $body.data.Add('ticketSystemType', $TicketSystemType)
                }
                'ViewTicketUrl' {
                    $body.data.Add('viewTicketUrl', $ViewTicketUrl)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ticket system: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssTicketSystem request'
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
