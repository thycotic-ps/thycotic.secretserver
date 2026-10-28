function Get-TssCharacterSet {
    <#
    .SYNOPSIS
    Get a character set

    .DESCRIPTION
    Returns the character set with the given ID: name, abbreviation, description, the characters in the set, and whether it is active and standard.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Character set ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssCharacterSet -TssSession $session -Id 1

    Returns character set ID 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/character-sets/Get-TssCharacterSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/character-sets/Get-TssCharacterSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.CharacterSets.CharacterSet')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CharacterSetId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'character-sets', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssCharacterSet request'
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
