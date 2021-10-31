Import-Module .\src\Thycotic.SecretServer.psd1
$ssUrl = 'https://tenant.secretservercloud.com'
$folderId = 85
$SecretTemplate = 'Password'

$fakeData = [IO.Path]::Combine($PSScriptRoot, 'examples', 'data', 'fake_data.csv')
$data = Import-Csv -Path $fakeData | Select-Object -First 150

$session = New-TssSession -SecretServer $ssUrl -Credential $cred

$template = Search-TssSecretTemplate -TssSession $session -SearchText $SecretTemplate | Where-Object Name -eq $SecretTemplate
$templateStub = Get-TssSecretStub -TssSession $session -SecretTemplateId $template.Id -FolderId $folderId

$createdIds = @()
foreach ($r in $data) {
    if ($session.IsValidToken()) {
        if ($session.CheckTokenTtl(3)) {
            $session.SessionRefresh()
        }
        $currentStub = $templateStub.PSObject.Copy()

        $secretName = "{0} - {1}" -f $r.Company, $r.Occupation
        $currentStub.Name = $secretName
        $currentStub.SetFieldValue('username',$r.Username)

        $passwordValue = $r.Password
        $currentStub.SetFieldValue('password',$passwordValue)

        $resourceValue = $r.CountryFull
        $currentStub.SetFieldValue('resource',$resourceValue)

        $newSecret = New-TssSecret -TssSession $session -SecretStub $currentStub
        $createdIds += $newSecret.Id

        $currentStub = $null
    } else {
        Write-Warning "Session is no longer valid"
        return
    }
}

if ($data.Count -eq $createdIds.Count) { Write-Output "Secrets all Created" }