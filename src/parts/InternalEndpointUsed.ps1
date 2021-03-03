<#
    .Synopsis
    To centralize the code around verbose/warning output when an internal endpoint is utilized
#>
[cmdletbinding()]
param (
    [Parameter(Mandatory,Position = 2)]
    [System.Management.Automation.InvocationInfo]
    $Invocation
)
process {
    $source = $Invocation.MyCommand
    Write-Verbose "[Important]: $source utilizes an internal endpoint that is not formally supported by Thycotic"
}