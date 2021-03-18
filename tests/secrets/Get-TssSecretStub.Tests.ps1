BeforeDiscovery {
    $commandName = Split-Path ($PSCommandPath.Replace('.Tests.ps1','')) -Leaf
    . ([IO.Path]::Combine([string]$PSScriptRoot, '..', 'constants.ps1'))
}
Describe "$commandName verify parameters" {
    BeforeDiscovery {
        [object[]]$knownParameters = 'TssSession','SecretTemplateId', 'FolderId'
        [object[]]$currentParams = ([Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')).Parameters.Keys
        [object[]]$commandDetails = [System.Management.Automation.CommandInfo]$ExecutionContext.SessionState.InvokeCommand.GetCommand($commandName,'Function')
        $unknownParameters = Compare-Object -ReferenceObject $knownParameters -DifferenceObject $currentParams -PassThru
    }
    Context "Verify parameters" -Foreach @{currentParams = $currentParams } {
        It "$commandName should contain <_> parameter" -TestCases $knownParameters {
            $_ -in $currentParams | Should -Be $true
        }
        It "$commandName should not contain parameter= <_>" -TestCases $unknownParameters {
            $_ | Should -BeNullOrEmpty
        }
    }
    Context "Command specific details" {
        It "$commandName should set OutputType to TssSecret" -TestCases $commandDetails {
            $_.OutputType.Name | Should -Be 'TssSecret'
        }
    }
}
Describe "$commandName functions" {
    Context "Checking" {
        BeforeAll {
            $session = [pscustomobject]@{
                ApiVersion   = 'api/v1'
                Take         = 2147483647
                SecretServer = 'http://alpha/'
                ApiUrl       = 'http://alpha/api/v1'
                AccessToken  = 'AgJf5YLFWtzw2UcBrM1s1KB2BGZ5Ufc4qLZ'
                RefreshToken = '9oacYFZZ0YqgBNg0L7VNIF6-Z9ITE51Qplj'
                TokenType    = 'bearer'
                ExpiresIn    = 1199
            }
            Mock -Verifiable -CommandName Get-TssVersion -MockWith {
                return @{
                    Version = '10.9.000033'
                }
            }

            $SecretTemplateId = 6001
            $folderId = 42
            Mock -Verifiable -CommandName Invoke-TssRestApi -ParameterFilter { $Uri -eq "$($session.ApiUrl)/secrets/stub?secretTemplateId=$SecretTemplateId"; $Method -eq 'GET' } -MockWith {
                return [pscustomobject]@{
                    id                                 = 0
                    name                               = ""
                    secretTemplateId                   = $SecretTemplateId
                    folderId                           = $folderId
                    active                             = $true
                    items                              = @( @{fileAttachmentId = ""; filename = ""; itemValue = ""; fieldId = 87; fieldName = 'Domain'; slug = 'domain'; fieldDescription = 'The Server or Location of the Active Directory Domain.'; isFile = $false; isNotes = $false; isPassword = $false }, @{fileAttachmentId = ""; filename = ""; itemValue = ""; fieldId = 90; fieldName = 'Username'; slug = 'username'; fieldDescription = 'The Domain Username.'; isFile = $false; isNotes = $false; isPassword = $false }, @{fileAttachmentId = ""; filename = ""; itemValue = ""; fieldId = 89; fieldName = 'Password'; slug = 'password'; fieldDescription = 'The password of the Domain User.'; isFile = $false; isNotes = $false; isPassword = $true }, @{fileAttachmentId = ""; filename = ""; itemValue = ""; fieldId = 88; fieldName = 'Notes'; slug = 'notes'; fieldDescription = 'Any additional notes.'; isFile = $false; isNotes = $true; isPassword = $false } )
                    launcherConnectAsSecretId          = -1
                    checkOutMinutesRemaining           = -1
                    checkedOut                         = $false
                    checkOutUserDisplayName            = ""
                    checkOutUserId                     = 0
                    isRestricted                       = $false
                    isOutOfSync                        = $false
                    outOfSyncReason                    = ""
                    autoChangeEnabled                  = $false
                    autoChangeNextPassword             = ""
                    requiresApprovalForAccess          = $false
                    requiresComment                    = $false
                    checkOutEnabled                    = $false
                    checkOutIntervalMinutes            = -1
                    checkOutChangePasswordEnabled      = $false
                    accessRequestWorkflowMapId         = ""
                    proxyEnabled                       = $false
                    sessionRecordingEnabled            = $false
                    restrictSshCommands                = $false
                    allowOwnersUnrestrictedSshCommands = $false
                    isDoubleLock                       = $false
                    doubleLockId                       = 0
                    enableInheritPermissions           = $true
                    passwordTypeWebScriptId            = -1
                    siteId                             = -1
                    enableInheritSecretPolicy          = $false
                    secretPolicyId                     = -1
                    lastHeartBeatStatus                = 'Pending'
                    lastHeartBeatCheck                 = '1/1/0001 12:00:00 AM'
                    failedPasswordChangeAttempts       = 0
                    lastPasswordChangeAttempt          = '1/1/0001 12:00:00 AM'
                    secretTemplateName                 = 'Active Directory Account'
                    responseCodes                      = @{}
                    webLauncherRequiresIncognitoMode   = $false
                }
            }
            $object = Get-TssSecretStub -TssSession $session -SecretTemplateId $SecretTemplateId -FolderId $folderId
            Assert-VerifiableMock
        }
        It "Should not be empty" {
            $object | Should -Not -BeNullOrEmpty
        }
        It "Should have property <_>" -TestCases 'Name', 'Active', 'SecretTemplateId', 'FolderId' {
            $object[0].PSObject.Properties.Name | Should -Contain $_
        }
        It "Should have property FolderId set to 42" {
            $object.FolderId | Should -Be 42
        }
        It "Should update ItemValue using SetFieldValue() method" {
            $object.SetFieldValue('notes','If I do do this update')
            $object.GetFieldValue('notes') | Should -Be 'If I do do this update'
        }
    }
}