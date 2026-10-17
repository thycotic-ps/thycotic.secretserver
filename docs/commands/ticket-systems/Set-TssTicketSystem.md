---
title: Set-TssTicketSystem
parent: Ticket Systems
grand_parent: Commands
---
# Set-TssTicketSystem

## SYNOPSIS
Update a ticket system

## SYNTAX

```
Set-TssTicketSystem [-TssSession] <Session> -Id <Int32> [-Active] [-AddCommentsToTicket]
 [-BmcChangeManagementCommentWorkType <String>] [-BmcIncidentManagementCommentWorkType <String>]
 [-BmcRemedyAuthentication <String>] [-BmcRemedyUrlEndpoint <String>] [-Description <String>]
 [-DisplayMessage <String>] [-EnableTicketOverride <String>] [-ForceRequireTicketNumber <String>]
 [-HideComment] [-IsDefault] [-Name <String>] [-PowerShellAddCommentScriptArguments <String>]
 [-PowerShellAddCommentScriptId <Int32>] [-PowerShellAddTicketCommentScriptArguments <String>]
 [-PowerShellAddTicketCommentScriptId <Int32>] [-PowerShellRunAsAccountSecretId <Int32>]
 [-PowerShellTicketStatusScriptArguments <String>] [-PowerShellTicketStatusScriptId <Int32>]
 [-ServiceNowAllowedStatuses <String>] [-ServiceNowDomainName <String>] [-SiteId <Int32>]
 [-SystemCredentialSecretId <Int32>] [-TicketNumberErrorMessage <String>] [-TicketNumberValidation <String>]
 [-TicketOverrideApproverGroupId <Int32[]>] [-TicketOverrideApproverUserId <Int32[]>]
 [-TicketOverrideDenyComment <String>] [-TicketOverrideDurationMinutes <Int32>] [-TicketOverrideSecretOwners]
 [-TicketSystemType <String>] [-ViewTicketUrl <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Changes the settings of a ticket system.
Only the parameters you pass are sent; every other setting stays as it is.
Returns the updated ticket system.
The default ticket system cannot be made inactive on its own: pass -IsDefault:$false with -Active:$false, or make another ticket system the default first.
TicketOverrideApproverUserId and TicketOverrideApproverGroupId replace the whole override approver list; pass both when the list holds users and groups, and an empty array to clear it.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssTicketSystem -TssSession $session -Id 3 -Description 'Change requests from the CAB' -ForceRequireTicketNumber TicketNumberOrReasonRequired
```

Change the description of ticket system 3 and accept a reason or a ticket number

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssTicketSystem -TssSession $session -Id 3 -EnableTicketOverride OnlyWhenValidationFails -TicketOverrideApproverGroupId 5 -TicketOverrideDurationMinutes 60
```

Allow override requests when validation fails, approved by group 5 within an hour

### EXAMPLE 3
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
Set-TssTicketSystem -TssSession $session -Id 3 -Active:$false
```

Retire ticket system 3

## PARAMETERS

### -TssSession
TssSession object created by New-TssSession for authentication

```yaml
Type: Session
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
Ticket system ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TicketSystemId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Make the ticket system active, so users can select it

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AddCommentsToTicket
Add the access request comment to the ticket in the integrated ticket system

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BmcChangeManagementCommentWorkType
BMC Remedy Change Management only: work type of the comments added to a ticket

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BmcIncidentManagementCommentWorkType
BMC Remedy Incident Management only: work type of the comments added to a ticket

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BmcRemedyAuthentication
BMC Remedy only: authentication value, usually the login server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BmcRemedyUrlEndpoint
BMC Remedy only: SOAP endpoint URL (the CHG_ChangeInterface_WS or HPD_IncidentInterface_WS endpoint)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description of the ticket system

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayMessage
Label shown to users for the ticket number field

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableTicketOverride
Whether users can request an approved override when the ticket system rejects a ticket number

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceRequireTicketNumber
What a user must enter: a reason only, a ticket number only, both, or either

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HideComment
Hide the comment box on secret access requests

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsDefault
Make this the default ticket system

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the ticket system, unique among active ticket systems

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellAddCommentScriptArguments
PowerShell only: arguments for the add comment script, separated by spaces

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellAddCommentScriptId
PowerShell only: ID of the script that adds a comment to the ticket system

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellAddTicketCommentScriptArguments
PowerShell only: arguments for the add ticket comment script, separated by spaces

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellAddTicketCommentScriptId
PowerShell only: ID of the script that adds a comment to a ticket

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellRunAsAccountSecretId
PowerShell only: ID of the secret whose credentials run the scripts

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellTicketStatusScriptArguments
PowerShell only: arguments for the ticket status script, separated by spaces

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellTicketStatusScriptId
PowerShell only: ID of the script that returns the ticket status

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceNowAllowedStatuses
ServiceNow only: ticket statuses to accept, separated by commas

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceNowDomainName
ServiceNow only: domain name that hosts the ServiceNow REST web services

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteId
ID of the site that runs the integration

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SystemCredentialSecretId
ID of the secret whose credentials connect to the integrated ticket system

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketNumberErrorMessage
Message shown when a ticket number fails validation

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketNumberValidation
Regular expression a ticket number must match

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketOverrideApproverGroupId
IDs of the groups that approve override requests

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketOverrideApproverUserId
IDs of the users who approve override requests

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketOverrideDenyComment
Comment sent to pending override requests when the ticket system or ticket override is turned off

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketOverrideDurationMinutes
Minutes an override request stays open for approval

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketOverrideSecretOwners
Let secret owners approve override requests

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TicketSystemType
Type of ticket system: TicketNumberValidation checks a regular expression in Secret Server, the others call ServiceNow, BMC Remedy or PowerShell scripts

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ViewTicketUrl
URL pattern to view a ticket in the ticket system

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Thycotic.PowerShell.TicketSystems.TicketSystem
## NOTES
Requires TssSession object returned by New-TssSession

## RELATED LINKS

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Set-TssTicketSystem](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Set-TssTicketSystem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Set-TssTicketSystem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Set-TssTicketSystem.ps1)
