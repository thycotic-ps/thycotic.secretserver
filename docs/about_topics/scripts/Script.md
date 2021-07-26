---
title: Script
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Scripts.Script class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Scripts.Script

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Scripts.Script class represents the ScriptModel object returned by Secret Server endpoint GET /userscripts/{id}

# CONSTRUCTORS
    new()

# PROPERTIES
    Active: boolean
        Whether the Script is Active

    AdditionalData: string
        Addition Data

    ConcurrencyId: string
        Unique Script Concurrency Id

    Description: string
        Script Description

    Name: string
        Script Name

    OdbcConnectionStringArgs: string[]
        ODBC Connection String Options

    Script: string
        Script Text

    ScriptCategoryId: integer (int32)
        Script Category Id

    ScriptCategoryName: string
        Script Category Name

    ScriptId: integer (int32)
        Script Id

    ScriptType: UserScriptType
        Script Type (Powershell = 1, SQL = 2, SSH = 3)

    UsageCount: integer (int32)
        Usage Count

# METHODS

# RELATED LINKS:
    Get-TssScript