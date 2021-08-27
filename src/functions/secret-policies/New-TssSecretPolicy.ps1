function New-TssSecretPolicy {
    <#
    .SYNOPSIS
    Create a new Secret Policy

    .DESCRIPTION
    Create a new Secret Policy, configure Policy Items using Update-TssSecretPolicy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-policies/New-TssSecretPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-policies/New-TssSecretPolicy.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSecretPolicy -TssSession $session -Name 'Require Checkout'

    Create a new secret policy setting enforcing various policy items

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretPolicies.Policy')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Policy Name
        [Parameter(Mandatory)]
        [string]
        $Name,

        # Secret Policy Description
        [string]
        $Description,

        # Activate the policy after creation
        [switch]
        $Active
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-policy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{data = @{} }
            switch ($tssNewParams.Keys) {
                'Name' { $newBody.data.Add('secretPolicyName',$Name) }
                'Description' { $newBody.data.Add('secretPolicyDescription',$Description) }
                'Active' { $newBody.data.Add('active',[boolean]$Active) }
            }
            $invokeParams.Body = $newBody | ConvertTo-Json -Depth 100

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n $newBody"
            if (-not $PSCmdlet.ShouldProcess("Secret Policy: $Name", "$($invokeParams.Method) $($invokeParams.Uri) with $($invokeParams.Body)")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating Secret Policy [$Name]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.SecretPolicies.Policy]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}