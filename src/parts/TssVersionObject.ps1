<#
.Synopsis
    Creates a TssVersion object and outputs
.Description
    Creates an instance of the TssVersion class to output based on the calling command
#>
[cmdletbinding()]
param(
    [TssSession]
    $TssSession,

    [System.Management.Automation.InvocationInfo]
    $Invocation
)

begin {
    $versionParams = $PSBoundParameters + @{}
    $invokeParams = @{ }
}

process {
    $source = $Invocation.MyCommand

    $uri = $TssSession.ApiUrl, 'version' -join '/'
    $invokeParams.Uri = $Uri
    $invokeParams.Method = 'GET'
    $invokeParams.PersonalAccessToken = $TssSession.AccessToken

    try {
        $restResponse = Invoke-TssRestApi @invokeParams
    } catch {
        Write-Warning "Issue reading version, verify Hide Secret Server Version Numbers is disabled in Secret Server"
        $err = $_
        . $ErrorHandling $err
    }

    $versionProperties = $restResponse.model.PSObject.Properties.Name
    $VersionRecord = $restResponse.model

    $outVersion = [TssVersion]::new()
    foreach ($v in $VersionRecord) {
        foreach ($vProp in $versionProperties) {
            $outVersion.$vProp = $v.$vProp
        }
    }

    switch ($source.Name) {
        'Get-TssVersion' {
            $returnProps = 'Version'
        }
        'Test-TssVersion' {
            $getLatestUrl = "https://updates.thycotic.net/secretserver/LatestVersion.aspx?v=$($outVersion.Version.ToString())"
            Write-Verbose "Accessing $getLatestUrl to validate latest version"
            try {
                $latest = Invoke-RestMethod -Uri $getLatestUrl -UseBasicParsing
            } catch {
                Write-Warning "Issue getting latest version information"
                $err = $_
                . $ErrorHandling $err
            }

            $outVersion.LatestVersion = $latest
            $outVersion.IsLatest = if ($outVersion.Version -ge $latest) { $true }

            $returnProps = 'Version','LatestVersion','IsLatest'
        }
    }
    Select-Object -InputObject $outVersion -Property $returnProps
}