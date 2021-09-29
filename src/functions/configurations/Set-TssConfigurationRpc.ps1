function Set-TssConfigurationRpc {
    <#
    .SYNOPSIS
    Set Remote Password Changing Configuration

    .DESCRIPTION
    Set Remote Password Changing Configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationRpc -TssSession session -Heartbeat:$false

    Disable Heartbeat globally

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationRpc -TssSession session -LogRetention 10

    Update Operation Log retention to 10 days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationRpc

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationRpc.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Enable Heartbeat
        [switch]
        $Heartbeat,

        # Enable Remote Password Changing
        [switch]
        $Rpc,

        # Enable Password Changing on Check In
        [switch]
        $RpcOnCheckIn,

        # Check Out interval - days
        [int]
        [int]
        $CheckOutDay,

        # Check Out interval - hours
        [int]
        $CheckOutHour,

        # Check Out interval - minutes
        [int]
        $CheckOutMinute,

        # Days to keep operational logs
        [int]
        $LogRetention
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'rpc' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setBody = @{ data = @{ } }
            switch ($setParams.Keys) {
                'Heartbeat' {
                    $hb = @{
                        dirty = $true
                        value = [boolean]$Heartbeat
                    }
                    $setBody.data.Add('enableHeartbeat',$hb)
                }
                'Rpc' {
                    $enableRpc = @{
                        dirty = $true
                        value = [boolean]$Rpc
                    }
                    $setBody.data.Add('enableRpc',$enableRpc)
                }
                'RpcOnCheckIn' {
                    $pwdCheckIn = {
                        dirty = $true
                        value = [boolean]$RpcOnCheckIn
                    }
                    $setBody.data.Add('enablePasswordCHangeOnCheckIn',$pwdCheckIn)
                }
                'CheckOutDay' {
                    $checkDay = @{
                        dirty = $true
                        value = $CheckOutDay
                    }
                    $setBody.data.Add('checkOutIntervalDays',$checkDay)
                }
                'CheckOutHour' {
                    $checkHr = @{
                        dirty = $true
                        value = $CheckOutHour
                    }
                    $setBody.data.Add('checkOutIntervalHours',$checkHr)
                }
                'CheckOutMinute' {
                    $checkMin = @{
                        dirty = $true
                        value = $CheckOutMinute
                    }
                    $setBody.data.Add('checkOutIntervalMinutes',$checkMin)
                }
                'LogRetention' {
                    $keepOpLogs = @{
                        dirty = $true
                        value = $LogRetention
                    }
                    $setBody.data.Add('daysToKeepLogs',$keepOpLogs)
                }
            }
            $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("RPC Configuration", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting Description"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose 'Setting updated successfully'
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}