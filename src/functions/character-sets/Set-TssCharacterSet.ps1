function Set-TssCharacterSet {
    <#
    .SYNOPSIS
    Update a character set

    .DESCRIPTION
    Changes only the fields you pass; everything else is left unchanged.
    Character sets cannot be deleted; use -Active:$false to deactivate one.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Character set ID

    .PARAMETER Abbreviation
    New abbreviation

    .PARAMETER Active
    Activate the character set, or deactivate it with -Active:$false

    .PARAMETER Description
    New description

    .PARAMETER Name
    New name

    .PARAMETER Value
    New characters in the set

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssCharacterSet -TssSession $session -Id 9 -Description 'Hexadecimal digits'

    Changes the description of character set ID 9

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssCharacterSet -TssSession $session -Id 9 -Active:$false

    Deactivates character set ID 9

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Set-TssCharacterSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Set-TssCharacterSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.CharacterSets.CharacterSet')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CharacterSetId')]
        [int]
        $Id,

        [string]
        $Abbreviation,

        [switch]
        $Active,

        [string]
        $Description,

        [string]
        $Name,

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
            $uri = $TssSession.ApiUrl, 'character-sets', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Abbreviation' {
                    $body.data.Add('abbreviation', @{ dirty = $true; value = $Abbreviation })
                }
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'Value' {
                    $body.data.Add('value', @{ dirty = $true; value = $Value })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Character set: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssCharacterSet request'
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
