<#
.Synopsis
Gets the input parameters and values
.Description
Gets the inputs and values from the parameters of the called command and outputs as a string value
ref: https://stackoverflow.com/a/65521994/12974596
#>
param(
    # A collection of parameters.  Parameters not used in Invoke-TssRestApi will be removed
    [Parameter(Position = 0,Mandatory)]
    [System.Management.Automation.InvocationInfo]
    $Invocation
)

$cmdText = $Invocation.InvocationName
foreach ($param in $Invocation.BoundParameters.GetEnumerator()) {
    $name = $param.Key
    $paramValue = switch ($param.Value) {
        { $_ -is [TssSession] } {
            "TssSessionObject"
        }
        { $_ -is [PSCredential] } {
            "CredentialObject"
        }
        { $_ -is [string] } {
            # Quote and escape all string values as single-quoted literals
            "'{0}'" -f [System.Management.Automation.Language.CodeGeneration]::EscapeSingleQuotedStringContent($_)
        }
        { $_ -is [datetime] } {
            # Quote datetime using a culture-independent format
            "'{0}'" -f $_.ToString('o')
        }
        { $_ -is [bool] -or $_ -is [switch] } {
            # Map booleans to their respective automatic variables
            '${0}' -f "$_"
        }
        { $_ -is [enum] -or $_.GetType().IsPrimitive } {
            # Leave numerals
            $_
        }
    }

    $cmdText += " -${name}:${paramValue}"
}

$cmdText