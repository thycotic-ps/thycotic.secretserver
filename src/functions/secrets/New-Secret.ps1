function New-Secret {
    <#
    .SYNOPSIS
    Create a new secret

    .DESCRIPTION
    Create a new secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $TemplateId = 6003
    $WindowsAccountTemplate = Get-TssSecretStub -TssSession $session -SecretTemplateId $TemplateId
    $data = Import-Csv c:\temp\testdata.csv
    $createdSecrets = @()
    foreach ($item in $data) {
        $currentTemplate = $WindowsAccountTemplate.PSObject.Copy()
        $machine = $item.Machine
        $user = $item.Username
        $currentTemplate.Name = "$machine $user"
        $currentTemplate.FolderId = 9
        $currentTemplate.SetFieldValue('Machine',$item.Machine)
        $currentTemplate.SetFieldValue('Username',$item.Username)
        $currentTemplate.SetFieldValue('Password',$item.Password)
        $created = New-TssSecret -TssSession $session -SecretStub $currentTemplate -Verbose
        $createdSecrets += $created
        Remove-Variable currentTemplate,machine,user -Force
    }
    return $createdSecrets | Select-Object FolderId, Name, SecretTemplateName, Active

    Accept input from CSV file that contains Machine, Username and Password. Iterate over each record and create a secret.
    Output will show the FolderId, Name, SecretTemplateName, and Active properties.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/New-Secret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssSecret')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Input object obtained via Get-TssSecretStub
        [Parameter(Mandatory, Position = 1)]
        [TssSecret]
        $SecretStub
    )

    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secrets' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            <# validate propert default values #>
            if ($SecretStub.SiteId -lt 1) {
                $SecretStub.SiteId = 1
            }
            $invokeParams.Body = ($SecretStub | ConvertTo-Json)

            Write-Verbose "$($invokeParams.Method) $uri with:`n $SecretStub"
            if (-not $PSCmdlet.ShouldProcess($SecretStub.Name, "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue creating secret [$($SecretStub.Name)]"
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [TssSecret]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}