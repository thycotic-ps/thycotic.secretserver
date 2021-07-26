---
title: "Summary"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Scripts.Summary class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Scripts.Summary

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Scripts.Summary class represents the ScriptSummary object returned by Secret Server endpoint GET /userscripts

# CONSTRUCTORS
    new()

# PROPERTIES
    Active: boolean
        Whether the Script is Active

    ConcurrencyId: string
        Unique Script Concurrency Id

    Description: string
        Script Description

    Name: string
        Script Name

    ScriptCategoryId: integer (int32)
        Script Category Id

    ScriptCategoryName: string
        Script Category Name

    ScriptId: integer (int32)
        Script Id

    ScriptType: UserScriptType
        Script Type (Powershell = 1, SQL = 2, SSH = 3)

# METHODS

# RELATED LINKS:
    Search-TssScript