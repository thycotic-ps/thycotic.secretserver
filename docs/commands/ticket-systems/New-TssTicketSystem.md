---
title: New-TssTicketSystem
parent: Ticket Systems
grand_parent: Commands
---
# New-TssTicketSystem

## SYNOPSIS
Create a ticket system

## SYNTAX

```
New-TssTicketSystem [-TssSession] <Session> [-Active] [-AddCommentsToTicket]
 [-BmcChangeManagementCommentWorkType <String>] [-BmcIncidentManagementCommentWorkType <String>]
 [-BmcRemedyAuthentication <String>] [-BmcRemedyUrlEndpoint <String>] [-Description <String>]
 [-DisplayMessage <String>] [-EnableTicketOverride <String>] [-ForceRequireTicketNumber <String>]
 [-HideComment] [-IsDefault] -Name <String> [-PowerShellAddCommentScriptArguments <String>]
 [-PowerShellAddCommentScriptId <Int32>] [-PowerShellAddTicketCommentScriptArguments <String>]
 [-PowerShellAddTicketCommentScriptId <Int32>] [-PowerShellRunAsAccountSecretId <Int32>]
 [-PowerShellTicketStatusScriptArguments <String>] [-PowerShellTicketStatusScriptId <Int32>]
 [-ServiceNowAllowedStatuses <String>] [-ServiceNowDomainName <String>] [-SiteId <Int32>]
 [-SystemCredentialSecretId <Int32>] [-TicketNumberErrorMessage <String>] [-TicketNumberValidation <String>]
 [-TicketOverrideSecretOwners] [-TicketSystemType <String>] [-ViewTicketUrl <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a ticket system for secret access requests and secret view comments.
TicketNumberValidation checks ticket numbers against a regular expression inside Secret Server; the other types call ServiceNow, BMC Remedy or custom PowerShell scripts and use the matching integration parameters.
An active ticket system needs Name (unique among active ticket systems), DisplayMessage and TicketNumberErrorMessage.
Omit -Active to create it inactive.
The first active ticket system becomes the default.
Ticket systems cannot be deleted: retire one with Set-TssTicketSystem -Active:$false.
Requires the Administer Configuration permission.

## EXAMPLES

### EXAMPLE 1
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssTicketSystem -TssSession $session -Name 'Change requests' -Active -DisplayMessage 'Change number' -TicketNumberErrorMessage 'Enter a valid change number.' -TicketSystemType TicketNumberValidation -TicketNumberValidation '^CHG\d+$' -ForceRequireTicketNumber BothRequired
```

Create an active ticket system that requires a reason and a change number starting with CHG

### EXAMPLE 2
```
$session = New-TssSession -SecretServer https://alpha -Credential $ssCred
New-TssTicketSystem -TssSession $session -Name 'ServiceNow incidents' -TicketSystemType ServiceNowIncidentManagement -ServiceNowDomainName 'example.service-now.com' -SystemCredentialSecretId 42 -DisplayMessage 'Incident number' -TicketNumberErrorMessage 'Incident not found.'
```

Create an inactive ServiceNow incident ticket system that connects with the credentials of secret 42

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

Required: True
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

[https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/New-TssTicketSystem](https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/New-TssTicketSystem)

[https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/New-TssTicketSystem.ps1](https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/New-TssTicketSystem.ps1)
