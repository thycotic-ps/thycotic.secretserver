---
title: "Report"
---

# TOPIC
    This help topic describes the Thycotic.PowerShell.Reports.Report class in the Thycotic.SecretServer module

# CLASS
    Thycotic.PowerShell.Reports.Report

# INHERITANCE
    None

# DESCRIPTION
    The Thycotic.PowerShell.Reports.Report class represents the ReportModel object returned by Secret Server endpoint /reports

# CONSTRUCTORS
    new()

# PROPERTIES
    CategoryId
        The Report Category Id

    ChartType
        The report chart Type. Null if no chart

    Description
        Report Description

    Enabled
        Whether the Report is active

    Id
        Report ID

    Is3DReport
        Whether the Report chart is displayed in 3d

    Name
        Report name

    PageSize
        The page size of the report

    ReportSql
        The SQL used to generate the report

    SystemReport
        Whether the Report is a system Report

    UseDatabasePaging
        When true paging of a report will be done in SQL server. Not all SQL is compatible with this option.

# METHODS

# RELATED LINKS:
    Get-TssReport