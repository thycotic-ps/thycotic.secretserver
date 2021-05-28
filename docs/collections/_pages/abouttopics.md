---
title: "Thycotic.SecretServer About topics"
permalink: /abouttopics/
excerpt: "About Topics"
last_modified_at: 2021-03-03T00:00:00-00:00
toc: false
layout: single-mod
classes: wide
author_profile: false
share: false
sidebar:
  nav: "abouttopics"
---

About topics cover the [PowerShell classes](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_classes) coded for use in the Thycotic.SecretServer module.

## Authentication

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssSession] | [New-TssSession]

## Configurations

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssConfigurationGeneral]                 | [Get-TssConfiguration]
[TssConfigurationApplicationSettings]     | [Get-TssConfiguration]
[TssConfigurationEmailSettings]           | [Get-TssConfiguration]
[TssConfigurationFolders]                 | [Get-TssConfiguration]
[TssConfigurationLauncherSettings]        | [Get-TssConfiguration]
[TssConfigurationLocalUserPasswords]      | [Get-TssConfiguration]
[TssConfigurationPermissionOptions]       | [Get-TssConfiguration]
[TssConfigurationProtocolHandlerSettings] | [Get-TssConfiguration]
[TssConfigurationUserExperience]          | [Get-TssConfiguration]
[TssConfigurationUserInterface]           | [Get-TssConfiguration]

## Distributed Engines

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssSiteSummary] | [Search-TssDistributeEngineSite]
[TssSiteMetrics] | [Search-TssDistributeEngineSite]

## Directory Services

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssDomainSummary] | [Search-TssDirectoryServiceDomain]

## Folder Permissions

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssFolderPermission] | [Get-TssFolderPermission] [Get-TssFolderPermissionStub] [New-TssFolderPermission]
[TssFolderPermissionSummary] | [Search-TssFolderPermission]

## Folders

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssFolder] | [Get-TssFolder] [Get-TssFolderStub] [New-TssFolder]
[TssFolderTemplate] | [Get-TssFolder]
[TssFolderLookup] | [Find-TssFolder]
[TssFolderSummary] | [Search-TssFolder]
[TssFolderAuditSummary] | [Get-TssFolderAudit]

## General

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssDelete] | [Remove-TssSecret] [Remove-TssFolder] [Remove-TssReportCategory]
[TssVersion] | [Get-TssVersion] [Test-TssVersion]

## Groups

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssGroup] | [Get-TssGroup]
[TssGroupLookup] | [Find-TssGroup]
[TssGroupOwner] | [Get-TssGroup]
[TssGroupSummary] | [Search-TssGroup]
[TssGroupUserSummary] | [Get-TssGroupMember]

## Reports

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssReport] | [Get-TssReport]
[TssReportCategoryDetail] | [Get-TssReportCategory]
[TssReportCategory] | [Get-TssReportCategory]
[TssReportScheduleSummary] | [Search-TssReportScheduleSummary]

## Roles

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssRole] | [Search-TssRole]

## RPC

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssPasswordType] | [Get-TssRpcPasswordType]
[TssPasswordTypeField] | [Get-TssRpcPasswordType]
[TssPasswordTypeSummary] | [Search-TssRpcPasswordType]
[TssSecretRpcAssociated] | [Get-TssSecretRpcAssociated]

## Secret Dependencies

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssSecretDependency] | [Get-TssSecretDependency]
[TssSecretDependencyGroup] | [New-TssSecretDependencyGroup]
[TssSecretDependencySummary] | [Search-TssSecretDependency]
[TssSecretDependencyTaskError] | [Get-TssSecretDependencyRunStatus]
[TssSecretDependencyTaskProgress] | [Get-TssSecretDependencyRunStatus]
[TssDependencyTemplate] | [Get-TssSecretDependencyTemplate]

## Secret Templates

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssSecretTemplate] | [Get-TssSecretTemplate]
[TssSecretTemplateField] | [Get-TssSecretTemplate]
[TssSecretTemplateSummary] | [Search-TssSecretTemplate]

## Secrets

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssSecret] | [Get-TssSecret] [Get-TssSecretStub] [New-TssSecret]
[TssSecretItem] | [Get-TssSecret]
[TssSecretAudit] | [Get-TssSecretAudit]
[TssSecretLookup] | [Find-TssSecret]
[TssSecretSummary] | [Search-TssSecret]
[TssSecretSummaryExtendedField] | [Search-TssSecret]
[TssSecretPasswordStatus] | [Get-TssSecretPasswordStatus]
[TssSecretDetailState] | [Get-TssSecretState]
[TssSecretDetailSettings] | [Get-TssSecretState]
[TssOneTimePasswordSettings] | [Get-TssSecretState]
[TssRdpLauncherSettings] | [Get-TssSecretState]
[TssSshLauncherSettings] | [Get-TssSecretState]
[TssSecretHeartbeatStatus] | [Get-TssSecretHeartbeatStatus]

## Users

**Class** | **Thycotic.SecretServer Command** |
--------------------------------- | -------------------------------------------------- |
[TssUser] | [Get-TssUser] [Get-TssUserStub]
[TssUserAuditSummary] | [Get-TssUserAudit]
[TssRoleSummary] | [Get-TssUserRole]
[TssUserRoleSummary] | [Get-TssUserRoleAssigned]
[TssGroupAssignedRole] | [Get-TssUserRoleAssigned]
[TssUserSummary] | [Search-TssUser]
[TssUserLookup] | [Find-TssUser]
[TssCurrentUser] | [Show-TssCurrentUser]
[TssRolePermission] | [Show-TssCurrentUser]
[TssMenuLink] | [Show-TssCurrentUser]

[New-TssSession]:/thycotic.secretserver/commands/New-TssSession
[Get-TssSecret]:/thycotic.secretserver/commands/Get-TssSecret
[Find-TssSecret]:/thycotic.secretserver/commands/Find-TssSecret
[Search-TssSecret]:/thycotic.secretserver/commands/Search-TssSecret
[Get-TssSecretTemplate]:/thycotic.secretserver/commands/Get-TssSecretTemplate
[Get-TssSecretTemplate]:/thycotic.secretserver/commands/Get-TssSecretTemplate
[Get-TssFolder]:/thycotic.secretserver/commands/Get-TssFolder
[Get-TssSecretStub]:/thycotic.secretserver/commands/Get-TssSecretStub
[New-TssSecret]:/thycotic.secretserver/commands/New-TssSecret
[New-TssFolder]:/thycotic.secretserver/commands/New-TssFolder
[Get-TssFolderStub]:/thycotic.secretserver/commands/Get-TssFolderStub
[Remove-TssSecret]:/thycotic.secretserver/commands/Remove-TssSecret
[Remove-TssFolder]:/thycotic.secretserver/commands/Remove-TssFolder
[Remove-TssReportCategory]:/thycotic.secretserver/commands/Remove-TssReportCategory
[Test-TssVersion]:/thycotic.secretserver/commands/Test-TssVersion
[Get-TssVersion]:/thycotic.secretserver/commands/Get-TssVersio
[Find-TssFolder]:/thycotic.secretserver/commands/Find-TssFolder
[Search-TssFolder]:/thycotic.secretserver/commands/Search-TssFolder
[Search-TssGroup]:/thycotic.secretserver/commands/Search-TssGroup
[Get-TssReport]:/thycotic.secretserver/commands/Get-TssReport
[Get-TssReportCategory]:/thycotic.secretserver/commands/Get-TssReportCategory
[Search-TssReportScheduleSummary]:/thycotic.secretserver/commands/Search-TssReportScheduleSummary
[Get-TssFolderAudit]:/thycotic.secretserver/commands/Get-TssFolderAudit
[Search-TssFolderPermission]:/thycotic.secretserver/commands/Search-TssFolderPermission
[Get-TssFolderPermission]:/thycotic.secretserver/commands/Get-TssFolderPermission
[Get-TssFolderPermissionStub]:/thycotic.secretserver/commands/Get-TssFolderPermissionStub
[New-TssFolderPermission]:/thycotic.secretserver/commands/New-TssFolderPermission
[Search-TssRole]:/thycotic.secretserver/commands/Search-TssRole
[Get-TssUserRole]:/thycotic.secretserver/commands/Get-TssUserRole
[Get-TssUserRoleAssigned]:/thycotic.secretserver/commands/Get-TssuserRoleAssigned
[Get-TssSecretPasswordStatus]:/thycotic.secretserver/commands/Get-TssSecretPasswordStatus
[Search-TssUser]:/thycotic.secretserver/commands/Search-TssUser
[Find-TssUser]:/thycotic.secretserver/commands/Find-TssUser
[Search-TssDirectoryServiceDomain]:/thycotic.secretserver/commands/Search-TssDirectoryServiceDomain
[Show-TssCurrentUser]:/thycotic.secretserver/commands/Show-TssCurrentUser
[Get-TssUser]:/thycotic.secretserver/commands/Get-TssUser
[Get-TssSecretAudit]:/thycotic.secretserver/commands/Get-TssSecretAudit
[Get-TssSecretState]:/thycotic.secretserver/commands/Get-TssSecretState
[Search-TssSecretTemplate]:/thycotic.secretserver/commands/Search-TssSecretTemplate
[Get-TssSecretState]:/thycotic.secretserver/commands/Get-TssSecretState
[Get-TssSecretHeartbeatStatus]:/thycotic.secretserver/commands/Get-TssSecretHeartbeatStatus
[Get-TssUserAudit]:/thycotic.secretserver/commands/Get-TssUserAudit
[Get-TssUserStub]:/thycotic.secretserver/commands/Get-TssUserStub
[Get-TssConfiguration]:/thycotic.secretserver/commands/Get-TssConfiguration
[Get-TssDistributedEngineSite]:/thycotic.secretserver/commands/Get-TssDistributedEngineSite
[Get-TssSecretRpcAssociated]:/thycotic.secretserver/commands/Get-TssSecretRpcAssociated
[Search-TssRpcPasswordType]:/thycotic.secretserver/commands/Search-TssRpcPasswordType
[Get-TssRpcPasswordType]:/thycotic.secretserver/commands/Get-TssRpcPasswordType
[New-TssSecretDependencyGroup]:/thycotic.secretserver/commands/New-TssSecretDependencyGroup
[Search-TssSecretDependency]:/thycotic.secretserver/commands/Search-TssSecretDependency
[Get-TssSecretDependency]:/thycotic.secretserver/commands/Get-TssSecretDependency
[Get-TssSecretDependencyRunStatus]:/thycotic.secretserver/commands/Get-TssSecretDependencyRunStatus
[Get-TssSecretDependencyTemplate]:/thycotic.secretserver/commands/Get-TssSecretDependencyTemplate
[Find-TssGroup]:/thycotic.secretserver/commands/Find-TssGroup
[Get-TssGroupMember]:/thycotic.secretserver/commands/Get-TssGroupMember
[Get-TssGroup]:/thycotic.secretserver/commands/Get-TssGroup

[TssGroup]:/thycotic.secretserver/abouttopics/about_tssgroup
[TssGroupOwner]:/thycotic.secretserver/abouttopics/about_tssgroupowner
[TssGroupSummary]:/thycotic.secretserver/abouttopics/about_tssgroupsummary
[TssGroupUserSummary]:/thycotic.secretserver/abouttopics/about_tssgroupusersummary
[TssGroupLookup]:/thycotic.secretserver/abouttopics/about_tssgrouplookup
[TssDependencyTemplate]:/thycotic.secretserver/abouttopics/about_tssdependencytemplate
[TssSecretDependencyTaskError]:/thycotic.secretserver/abouttopics/about_tsssecretdependencytaskerror
[TssSecretDependencyTaskProgress]:/thycotic.secretserver/abouttopics/about_tsssecretdependencytaskprogress
[TssSecretDependency]:/thycotic.secretserver/abouttopics/about_tsssecretdependency
[TssSecretDependencyGroup]:/thycotic.secretserver/abouttopics/about_tsssecretdependencygroup
[TssSecretDependencySummary]:/thycotic.secretserver/abouttopics/about_tsssecretdependencysummary
[TssPasswordTypeField]:/thycotic.secretserver/abouttopics/about_tsspasswordtypefield
[TssPasswordType]:/thycotic.secretserver/abouttopics/about_tsspasswordtype
[TssPasswordTypeSummary]:/thycotic.secretserver/abouttopics/about_tsspasswordtypesummary
[TssSecretRpcAssociated]:/thycotic.secretserver/abouttopics/about_tsssecretrpcassociated
[TssSiteSummary]:/thycotic.secretserver/abouttopics/about_tsssitesummary
[TssSiteMetrics]:/thycotic.secretserver/abouttopics/about_tsssitemetrics
[TssConfigurationGeneral]:/thycotic.secretserver/abouttopics/about_tssconfigurationgeneral
[TssConfigurationApplicationSettings]:/thycotic.secretserver/abouttopics/about_tssconfigurationapplicationsettings
[TssConfigurationEmailSettings]:/thycotic.secretserver/abouttopics/about_tssconfigurationemailsettings
[TssConfigurationFolders]:/thycotic.secretserver/abouttopics/about_tssconfigurationfolders
[TssConfigurationLauncherSettings]:/thycotic.secretserver/abouttopics/about_tssconfigurationlaunchersettings
[TssConfigurationLocalUserPasswords]:/thycotic.secretserver/abouttopics/about_tssconfigurationlocaluserpasswords
[TssConfigurationPermissionOptions]:/thycotic.secretserver/abouttopics/about_tssconfigurationpermissionoptions
[TssConfigurationProtocolHandlerSettings]:/thycotic.secretserver/abouttopics/about_tssconfigurationprotocolhandlersettings
[TssConfigurationUserExperience]:/thycotic.secretserver/abouttopics/about_tssconfigurationuserexperience
[TssConfigurationUserInterface]:/thycotic.secretserver/abouttopics/about_tssconfigurationuserinterface
[TssUserAuditSummary]:/thycotic.secretserver/abouttopics/about_tssuserauditsummary
[TssSecretHeartbeatStatus]:/thycotic.secretserver/abouttopics/about_tsssecretheartbeatstatus
[TssSecretDetailState]:/thycotic.secretserver/abouttopics/about_tsssecretdetailstate
[TssSecretDetailSettings]:/thycotic.secretserver/abouttopics/about_tsssecretdetailsettings
[TssOneTimePasswordSettings]:/thycotic.secretserver/abouttopics/about_tssonetimepasswordsettings
[TssRdpLauncherSettings]:/thycotic.secretserver/abouttopics/about_tssrdplaunchersettings
[TssSshLauncherSettings]:/thycotic.secretserver/abouttopics/about_tsssshlaunchersettings
[TssSecretTemplateSummary]:/thycotic.secretserver/abouttopics/about_tsssecrettemplatesummary
[TssSecretState]:/thycotic.secretserver/abouttopics/about_tsssecretstate
[TssSecretAudit]:/thycotic.secretserver/abouttopics/about_tsssecretaudit
[TssUser]:/thycotic.secretserver/abouttopics/about_tssuser
[TssCurrentUser]:/thycotic.secretserver/abouttopics/about_tsscurrentlink
[TssRolePermission]:/thycotic.secretserver/abouttopics/about_tssrolepermission
[TssMenuLink]:/thycotic.secretserver/abouttopics/about_tssmenulink
[TssCurrentUser]:/thycotic.secretserver/abouttopics/about_tsscurrentuser
[TssDomainSummary]:/thycotic.secretserver/abouttopics/about_tssdomainsummary
[TssUserLookup]:/thycotic.secretserver/abouttopics/about_tssuserlookup
[TssUserSummary]:/thycotic.secretserver/abouttopics/about_tssusersummary
[TssSecretPasswordStatus]:/thycotic.secretserver/abouttopics/about_tsssecretpasswordstatus
[TssUserRoleSummary]:/thycotic.secretserver/abouttopics/about_tssuserrolesummary
[TssGroupAssignedRole]:/thycotic.secretserver/abouttopics/about_tssgroupassignedrole
[TssRoleSummary]:/thycotic.secretserver/abouttopics/about_tssrolesummary
[TssRole]:/thycotic.secretserver/abouttopics/about_tssrole
[TssFolderPermission]:/thycotic.secretserver/abouttopics/about_tssfolderpermission
[TssFolderPermissionSummary]:/thycotic.secretserver/abouttopics/about_tssfolderpermissionsummary
[TssFolderAuditSummary]:/thycotic.secretserver/abouttopics/about_tssfolderauditsummary
[TssSession]:/thycotic.secretserver/abouttopics/about_tsssession
[TssSecret]:/thycotic.secretserver/abouttopics/about_tsssecret
[TssSecretItem]:/thycotic.secretserver/abouttopics/about_tsssecretitem
[TssSecretLookup]:/thycotic.secretserver/abouttopics/about_tsssecretlookup
[TssSecretSummary]:/thycotic.secretserver/abouttopics/about_tsssecretsummary
[TssSecretSummaryExtendedField]:/thycotic.secretserver/abouttopics/about_tsssecretsummaryextendedfield
[TssSecretTemplate]:/thycotic.secretserver/abouttopics/about_tsssecrettemplate
[TssSecretTemplateField]:/thycotic.secretserver/abouttopics/about_tsssecrettemplatefield
[TssFolder]:/thycotic.secretserver/abouttopics/about_tssfolder
[TssFolderTemplate]:/thycotic.secretserver/abouttopics/about_tssfoldertemplate
[TssDelete]:/thycotic.secretserver/abouttopics/about_tssdelete
[TssVersion]:/thycotic.secretserver/abouttopics/about_tssversion
[TssFolderLookup]:/thycotic.secretserver/abouttopics/about_tssfolderlookup
[TssFolderSummary]:/thycotic.secretserver/abouttopics/about_tssfoldersummary
[TssGroupSummary]:/thycotic.secretserver/abouttopics/about_tssgroupsummary
[TssReport]:/thycotic.secretserver/abouttopics/about_tssreport
[TssReportCategoryDetail]:/thycotic.secretserver/abouttopics/about_tssreportcategory
[TssReportCategory]:/thycotic.secretserver/abouttopics/about_tssreportcategory
[TssReportScheduleSummary]:/thycotic.secretserver/abouttopics/about_tssreportschedulesummary