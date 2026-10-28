function Import-TssSecretXml {
    <#
    .SYNOPSIS
    Import secrets from Secret Server XML

    .DESCRIPTION
    Starts an import of secrets from XML in the Secret Server export format.
    Secret Server imports in the background and returns the task identifier.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ChangeRemotePasswords
    Change the passwords on the remote systems after import

    .PARAMETER ImportWithFolder
    Create the folders named in the XML

    .PARAMETER InheritFolderPermissions
    Imported secrets inherit permissions from their folder

    .PARAMETER Xml
    XML to import, in the Secret Server export format

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $xml = Get-Content -Path ./secrets-export.xml -Raw
    Import-TssSecretXml -TssSession $session -Xml $xml -ImportWithFolder

    Imports the secrets in secrets-export.xml, creating their folders

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Import-TssSecretXml

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Import-TssSecretXml.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.XmlImport')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $ChangeRemotePasswords,

        [switch]
        $ImportWithFolder,

        [switch]
        $InheritFolderPermissions,

        [Parameter(Mandatory)]
        [string]
        $Xml
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', 'import-xml-process' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ChangeRemotePasswords' {
                    $body.data.Add('changeRemotePasswords', [boolean]$ChangeRemotePasswords)
                }
                'ImportWithFolder' {
                    $body.data.Add('importWithFolder', [boolean]$ImportWithFolder)
                }
                'InheritFolderPermissions' {
                    $body.data.Add('inheritFolderPermissions', [boolean]$InheritFolderPermissions)
                }
                'Xml' {
                    $body.data.Add('xml', $Xml)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret xml", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssSecretXml request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.XmlImport](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.XmlImport]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
