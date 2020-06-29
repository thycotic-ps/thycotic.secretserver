function Get-TssSession {
    [cmdletbinding()]
    param()

    $TssSession | ConvertTo-Json | ConvertFrom-Json
}