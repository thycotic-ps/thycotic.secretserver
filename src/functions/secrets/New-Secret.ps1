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
        $currentTemplate.Items.SetFieldValue('Machine',$item.Machine) > $null
        $currentTemplate.Items.SetFieldValue('Username',$item.Username) > $null
        $currentTemplate.Items.SetFieldValue('Password',$item.Password) > $null
        $created = New-TssSecret -TssSession $session -SecretStub $currentTemplate -Verbose
        $createdSecrets += $created
        Remove-Variable currentTemplate,machine,user -Force
    }
    return $createdSecrets | Select-Object FolderId, Name, SecretTemplateName, Active

    Accept input from CSV file that contains Machine, Username and Password. Iterate over each record and create a secret.
    Output will show the FolderId, Name, SecretTemplateName, and Active properties.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSecret

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssSecret')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Input object obtained via Get-TssSecretStub
        [Parameter(Mandatory, Position = 1)]
        [TssSecret]
        $SecretStub
    )

    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secrets' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            <# validate propert default values #>
            if ($SecretStub.SiteId -lt 1) {
                $SecretStub.SiteId = 1
            }
            $invokeParams.Body = ($SecretStub | ConvertTo-Json)
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
            Write-Verbose "$($invokeParams.Method) $uri with:`n $SecretStub"
            if (-not $PSCmdlet.ShouldProcess($SecretStub.Name, "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue creating secret [$($SecretStub.Name)]"
                $err = $_.ErrorDetails.Message
                Write-Error $err
            }
            if ($restResponse) {
                . $TssSecretObject $restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}