function Set-TssSecretExpiration {
    <#
    .SYNOPSIS
    Set Secret expiration

    .DESCRIPTION
    Set Secret expiration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretExpiration -TssSession $session -Id 46 -DateExpiration (Get-Date).AddDays(21)

    Set Secret expiration on Secret 46 to specific date 21 days from the current date

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretExpiration -TssSession $session -Id 23 -Template

    Set Secret expiration on Secret 23 to template, expiration being controlled with the Secret Template

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretExpiration -TssSession $session -Id 42 -Interval 21

    Set Secret expiration on Secret 23 to interval of 21 days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretExpiration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretExpiration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Set expiration to specific date and time
        [Parameter(ParameterSetName = 'SpecificDate')]
        [datetime]
        $DateExpiration,

        # Set expiration to an interval (days)
        [Parameter(ParameterSetName = 'DayInterval')]
        [int]
        $Interval,

        # Set expiration to Template
        [Parameter(ParameterSetName = 'Template')]
        [switch]
        $Template
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'expiration' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $setExpirationBody = @{ data = @{ } }

                if ($setParams.ContainsKey('Template')) {
                    $type = @{
                        dirty = $true
                        value = 'Template'
                    }
                    $setExpirationBody.data.Add('expirationType', $type)
                }
                if ($setParams.ContainsKey('Interval')) {
                    $type = @{
                        dirty = $true
                        value = 'DayInterval'
                    }
                    $dayInterval = @{
                        dirty = $true
                        value = $Interval
                    }
                    $setExpirationBody.data.Add('expirationType', $type)
                    $setExpirationBody.data.Add('expirationDayInterval', $dayInterval)
                }
                if ($setParams.ContainsKey('DateExpiration')) {
                    $type = @{
                        dirty = $true
                        value = 'SpecificDate'
                    }
                    $expDate = @{
                        dirty = $true
                        value = $DateExpiration.ToShortDateString()
                    }
                    $setExpirationBody.data.Add('expirationType', $type)
                    $setExpirationBody.data.Add('expirationDate', $expDate)
                }

                $invokeParams.Body = $setExpirationBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting expiration on [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    if ($setParams.ContainsKey('DateOfExpiration') -and $restResponse.expirationDate -eq $DateOfExpiration) {
                        Write-Verbose "Secret [$secret] expiration date set to $DateOfExpiration"
                    }
                    if ($setParams.ContainsKey('Interval') -and $restResponse.expirationDayInterval -eq $Interval) {
                        Write-Verbose "Secret [$secret] expiration set to $Interval Days"
                    }
                    if ($setParams.ContainsKey('Template') -and $restResponse.expirationType -eq $Template) {
                        Write-Verbose "Secret [$secret] expiration type set to Template"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}