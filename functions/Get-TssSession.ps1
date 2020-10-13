function Get-TssSession {
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
    [cmdletbinding()]
    param()

    $TssSession | ConvertTo-Json | ConvertFrom-Json
}