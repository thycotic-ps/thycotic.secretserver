#region classes
class TssSession
{
    [string]$SecretServerUrl
    [string]$ApiVersion = "api/v1"
    [string]$AccessToken
    [string]$RefreshToken
    hidden [datetime]$StartTime
    [int]$ExpiresIn
    hidden [datetime]$TimeOfDeath
    [int]$Take = [int]::MaxValue

    [boolean]IsValidSession()
    {
        if ([string]::IsNullOrEmpty($this.AccessToken) -and [string]::IsNullOrEmpty($this.RefreshToken) -and $this.StartTime -eq '0001-01-01 00:00:00') {
            return $false
        } else {
            return $true
        }
    }

    [boolean]IsValidToken()
    {
        if ([string]::IsNullOrEmpty($this.AccessToken)) {
            Write-Host 'No valid token found for current TssSession object'
            return $false
        } elseif ([datetime]::Now -lt $this.TimeOfDeath) {
            return $true
        } elseif ([datetime]::Now -gt $this.TimeOfDeath) {
            Write-Host 'Token is not valid and has exceeded TimeOfDeath'
            return $false
        } else {
            return $true
        }
    }
}
#endregion classes

#region Import Functions
foreach ($file in Get-ChildItem -Path $psScriptRoot\functions -Filter *-*.ps1) {
    . $file.FullName
}
#endregion Import Functions
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName System.Web # Add System.Web now, in the unlikely event it was not already loaded.

#region Import Parts
# Parts are simple .ps1 files beneath a /Parts directory that can be used throughout the module.
$partsDirectory = $( # Because we want to be case-insensitive, and because it's fast
    foreach ($dir in [IO.Directory]::GetDirectories($psScriptRoot)) {
        # [IO.Directory]::GetDirectories()
        if ($dir -imatch "\$([IO.Path]::DirectorySeparatorChar)Parts$") {
            # and some Regex
            [IO.DirectoryInfo]$dir;break # to find our parts directory.
        }
    })

if ($partsDirectory) {
    # If we have parts directory
    foreach ($partFile in $partsDirectory.EnumerateFileSystemInfos()) {
        # enumerate all of the files.
        if ($partFile.Extension -ne '.ps1') { continue } # Skip anything that's not a PowerShell script.
        $partName = # Get the name of the script.
        $partFile.Name.Substring(0, $partFile.Name.Length - $partFile.Extension.Length)
        $ExecutionContext.SessionState.PSVariable.Set( # Set a variable
            $partName, # named the script that points to the script (e.g. $foo = gcm .\Parts\foo.ps1)
            $ExecutionContext.SessionState.InvokeCommand.GetCommand($partFile.Fullname, 'ExternalScript')
        )
    }
}
#endregion Import Parts

#region alias

<#
    Secret Server does not delete secrets, just disables them.
    Remove is a common term though and one used by SecretManagement module from Microsoft.
    Creating an alias to map to Disable function of the module to keep things simplified.
#>
Set-Alias -Name Remove-TssSecret -Value Disable-TssSecret
Export-ModuleMember -Alias * -Function * -Cmdlet *