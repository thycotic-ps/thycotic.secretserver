class TssReport {
    # Report Category Id
    [int]$CategoryId
    # Report chart type, null if no chart
    [string]$ChartType
    # Report description
    [string]$Description
    # Report is active
    [boolean]$Enabled
    # Report Id
    [int]$Id
    #Report chart is displayed in 3D
    [boolean]$Is3DReport
    # Report Name
    [string]$Name
    # Report page size
    [int]$PageSize
    # Report T-SQL
    [string]$ReportSql
    # Report is a System Report
    [boolean]$SystemReport
    # Report paging will be done in SQL Server; not all SQL is compatible with this option
    [boolean]$UseDatabasePaging
}