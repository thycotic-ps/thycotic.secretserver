function New-TssCharacterSet {
    <#
    .SYNOPSIS
    Create a character set

    .DESCRIPTION
    Creates a character set that password requirements use as their allowed character set or in their rules.
    Character sets cannot be deleted; deactivate one with Set-TssCharacterSet -Active:$false.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Abbreviation
    Short abbreviation shown in password requirements

    .PARAMETER Active
    Create the character set active; omit to create it inactive

    .PARAMETER Description
    Description

    .PARAMETER Name
    Display name

    .PARAMETER Value
    The characters in the set, for example 0123456789abcdef

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssCharacterSet -TssSession $session -Name 'Hex' -Abbreviation 'hex' -Value '0123456789abcdef' -Active

    Creates an active character set holding the hexadecimal digits

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/New-TssCharacterSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/New-TssCharacterSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.CharacterSets.CharacterSet')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Abbreviation,

        [switch]
        $Active,

        [string]
        $Description,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [string]
        $Value
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'character-sets' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ active = [boolean]$Active } }
            switch ($tssParams.Keys) {
                'Abbreviation' {
                    $body.data.Add('abbreviation', $Abbreviation)
                }
                'Description' {
                    $body.data.Add('description', $Description)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
                'Value' {
                    $body.data.Add('value', $Value)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Character set", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssCharacterSet request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.CharacterSets.CharacterSet](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.CharacterSets.CharacterSet]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
