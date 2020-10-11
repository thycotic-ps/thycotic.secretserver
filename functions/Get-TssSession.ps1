<#
.SYNOPSIS
Retrieve the internal TssSession Object

.DESCRIPTION
Retrieve the internal TssSession Object

.EXAMPLE
PS C:\> Get-TssSession

Outputs the current session properties

.OUTPUTS
System.Management.Automation.PSCustomObject
#>
function Get-TssSession {
    [cmdletbinding()]
    param()

    $TssSession | ConvertTo-Json | ConvertFrom-Json
}