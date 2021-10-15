---
title: "Secrets"
sort: 5
---

## Examples - Getting

The examples below offer various ways of getting a Secret and the details in it (aka fields or files).

### Get a Secret

#### By ID

```powershell
Get-TssSecret -TssSession $session -Id 642
```

#### By Path

```powershell
Get-TssSecret -TssSession $session -Path '\Testing\Secret Policies\Test Secret W/ Web Launcher 1'
```

In this example the folder path is `\Testing\Secret Policies` with the Secret Name being `Test Secret W/ Web Launcher 1`.

### Get a Secret as PSCredential

```powershell
$secret = Get-TssSecret -TssSession $session -Path '\Testing\Secret Policies\Test Secret W/ Web Launcher 1'
$psCred = $secret.GetCredential('domain','username','password')
```

In the above example, an Active Directory account is used so it requires passing in the slug names for Domain and Username. This will create the username as `domain\username` format. You can also use other fields for things like Windows Accounts. If you do not need the domain position in the username just pass in `$null`.

```powershell
$secret = Get-TssSecret -TssSession $session -Path '\Testing\Windows Local\Test Secret 2'
$psCred = $secret.GetCredential($null,'username','password')
```

### Get a Secret File/Attachment

In scenarios where you may not know the field containing the file you can use the method `GetFileFields()` to output those slug names:

```powershell
$secret = Get-TssSecret -TssSession $session -Id 1084
$secret.GetFileFields()
```

Sample output:

```console
PS > $secret.GetFileFields()

SlugName   Filename
--------   --------
attachment testfile.csv
```

When you have the slug name and file name you can download the attaching or simply retrieve the content of the file. The latter works if they are basic text files, if you have binary files like PDFs those have to be written to disk before the content can be viewed properly.

```powershell
Get-TssSecretField -TssSession $session -Id 1084 -Slug attachment
```

The above example will output the raw contents of the file on the Secret. This is useful if you wanted to get any key files for things like SSH.

To download the file to disk:

```powershell
Get-TssSecretAttachment -TssSession -Id 1084 -Slug attachment -Path c:\temp\
```

The command automatically pulls the filename of the attachment and will create that file at `c:\temp\testfile.csv` (in this example).

Sample output:

```console
PS > Get-TssSecretAttachment -Id 1084 -Slug attachment -Path c:\temp\

    Directory: C:\temp

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          10/14/2021  8:12 PM         223993 testfile.csv
```

## Examples - Creating

### Identify Secret Template Requirements

In order to create a Secret you need to reference a Secret Stub which is directly related to the Secret Template chosen.

```powershell
# Identify the Secret Template
$params = @{
    SecretServer = 'http://argos/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

# Find SecretTemplateId
Search-TssSecretTemplate -TssSession $session -SortBy Name

# Provide value to identify IsRequired for fields
(Get-TssSecretTemplate -TssSession $session -Id 6003).Fields

$session.SessionExpire()
```

### Create a single Secret

Create a single Secret via interactive session.

```powershell
# Select Windows Account for this example
$secretTemplate = Search-TssSecretTemplate -TssSession $session -SearchText 'Windows Account'

# Secret Stub for the template
$newSecret = Get-TssSecretStub -TssSession $session -SecretTemplateId $secretTemplate.Id

# Get Folder to place Secret in (root folder called Demo)
$folder = Search-TssFolder -TssSession $session -SearchText 'Demo' -ParentFolderId -1

$newSecret.FolderId = $folder.Id
$newSecret.Name = 'Created Secret via PS Module'
$newSecret.SetFieldValue('username','username-a')
$newSecret.SetFieldValue('password',(New-Guid).Guid)
$newSecret.SetFieldValue('machine','server01')

New-TssSecret -TssSession $session -SecretStub $newSecret
```

### Create multiple Secrets based on CSV

This example will take the CSV data below, saved in a file called `secrets.csv` and create them into a structured folder. See [Working With Folders](../workingwith-folders/)

#### CSV Data

```console
App Name,Department,Username,Notes,Machine
Andalax,Human Resources,rroutledge0,Goldenrod,170.208.208.129
Overhold,Customers,cgrane1,Aquamarine,25.129.108.198
Mat Lam Tam,Security,rpoetz2,Purple,6.182.222.80
Regrant,Programmers,dosullivan3,Violet,151.238.167.88
Temp,Customers,braubenheimer4,Red,14.47.192.67
Viva,Network Infrastructure,btamas5,Puce,200.144.118.184
Tampflex,Network Infrastructure,bgollop6,Fuscia,124.13.25.34
Konklux,Customers,usawford7,Purple,69.74.133.87
Zaam-Dox,Programmers,amunnis8,Green,99.172.143.163
Otcom,Windows,kcousans9,Orange,99.161.56.105
Solarbreeze,Oracle,rshortana,Crimson,81.58.159.41
Span,Network Infrastructure,smeharryb,Fuscia,22.134.232.19
Asoka,Human Resources,rklinkc,Yellow,19.198.3.84
Ronstring,Windows,dervind,Khaki,109.99.47.94
Sub-Ex,Customers,tleminge,Violet,131.158.76.119
Lotlux,SQL Server,flooneyf,Crimson,61.200.62.92
Zoolab,Windows,caldinsg,Violet,227.114.145.126
Tampflex,Network Infrastructure,jandrih,Green,245.89.173.56
Mat Lam Tam,Network Infrastructure,dmurrayi,Khaki,110.30.15.164
Cardguard,Oracle,cmonnoyerj,Green,162.138.171.203
Duobam,Windows,mtottlek,Teal,177.57.146.190
Ventosanzap,Human Resources,pcarradicel,Teal,195.133.51.3
Tin,Network Infrastructure,rriddettm,Indigo,157.218.17.58
Flowdesk,Unix,cantoszczykn,Turquoise,181.106.171.18
Tampflex,Unix,nlarko,Aquamarine,224.13.76.247
Matsoft,Security,pbrodleyp,Violet,229.42.149.114
Lotstring,Programmers,lsmithersq,Yellow,93.234.9.27
Voyatouch,Security,msandlinr,Green,221.37.90.46
Prodder,Security,dfindlaters,Puce,27.156.160.80
Rank,Programmers,dweildisht,Green,234.131.45.236
Trippledex,Human Resources,jfansyu,Goldenrod,25.23.242.36
Alphazap,Customers,mhelliarv,Violet,252.38.130.9
Prodder,Windows,rsinclairw,Orange,8.42.212.40
Rank,SQL Server,sfawlox,Orange,148.130.194.23
Matsoft,Unix,cguntony,Khaki,230.252.2.188
Temp,Vendors,mgreenhamz,Yellow,32.178.249.171
Cardify,Vendors,awinspare10,Khaki,204.168.109.11
Regrant,SQL Server,arubie11,Violet,100.238.245.74
Hatity,Programmers,eead12,Teal,97.83.105.109
Cookley,SQL Server,fklesse13,Maroon,16.228.234.161
Andalax,Programmers,adonavan14,Indigo,124.11.161.127
Zontrax,Security,ofortnam15,Yellow,128.113.124.120
Rank,Programmers,amcquaide16,Indigo,206.192.156.60
Cookley,Unix,tmeese17,Khaki,198.47.202.247
Pannier,Security,ldavid18,Turquoise,212.211.254.145
```

#### Script

```powershell
$params = @{
    SecretServer = 'http://argos/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

# Using the Windows Account template
$secretTemplateId = 6003

# Setting TssSession Default parameter (set once and forget)
try {
    $PSDefaultParameterValues.Add("*:TssSession",$session)
} catch {
    $PSDefaultParameterValues.Remove("*:TssSession")
    $PSDefaultParameterValues.Add("*:TssSession",$session)
}

# Load the data
$secretData = Import-Csv .\secrets.csv

# Get Departments from CSV File
$departments = ($secretData | Select-Object Department -Unique).Department

# Grab the Parent Folder
$parentFolder = Search-TssFolder -TssSession $session -SearchText 'ABC Company'

# Create collection for capturing created secrets
$createdSecrets = @()
foreach ($dept in $departments) {
    # loop over each department, get the ID for the folder
    $folder = Search-TssFolder -TssSession $session -SearchText $dept -ParentFolderId $parentFolder.FolderId

    # pull all secrets for that department
    foreach ($item in ($secretData.Where({$_.Department -eq $dept}))) {
        # copy our stub object so we can reuse it safely without residual data being left
        $newSecret = $secretStub.PSObject.Copy()

        # Set properties and fields
        $newSecret.FolderId = $folder.FolderId
        $newSecret.Name = "$($item.'App Name') Secret - $($item.Machine)"
        $newSecret.SetFieldValue('username',$item.'username')
        $newSecret.SetFieldValue('password',(New-Guid).Guid)
        $newSecret.SetFieldValue('machine',$item.Machine)
        $newSecret.SetFieldValue('notes',$item.Notes)
        $createdSecret = New-TssSecret -TssSession $session -SecretStub $newSecret

        # collecting created secret output
        $createdSecrets += $createdSecret

        # cleaning variables for reuse
        Remove-Variable newSecret, createdSecret -Force
    }
}
# End Session
$session.SessionExpire()

# Verify counts
[pscustomobject]@{
    DataCount = $secretData.Count
    Created = $createdSecrets.Count
}
```

## Examples - Modifying

Once you have secrets created there will be times where they need to be updated for some reason.

> **Note** The examples below utilize the secrets created in the previous examples. Filtering is done using the color that is in the Notes field of the secrets.

### Move Secrets to another Folder

```powershell
$params = @{
    SecretServer = 'http://argos/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

# Setting TssSession Default parameter (set once and forget)
try {
    $PSDefaultParameterValues.Add("*:TssSession",$session)
} catch {
    $PSDefaultParameterValues.Remove("*:TssSession")
    $PSDefaultParameterValues.Add("*:TssSession",$session)
}

# Get ID for Security folder and update secrets
$securityFolder = Get-TssFolder -FolderPath '\ABC Company\Security'
Search-TssSecret -FieldSlug Notes -SearchText 'Violet' | Set-TssSecret -FolderId $securityFolder.Id

# Confirm Secrets where moved
Search-TssSecret -FieldSlug Notes -SearchText 'Violet'
```

### Initiate Heartbeat on Secrets

```powershell
$params = @{
    SecretServer = 'http://argos/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

# Setting TssSession Default parameter (set once and forget)
try {
    $PSDefaultParameterValues.Add("*:TssSession",$session)
} catch {
    $PSDefaultParameterValues.Remove("*:TssSession")
    $PSDefaultParameterValues.Add("*:TssSession",$session)
}

Search-TssSecret -FieldSlug Notes -SearchText 'Purple' | Start-TssSecretHeartbeat -Verbose
```

### Modify Fields on Secrets

Updates the Domain field on all secrets that have the value `lab.local` to `newdomain.local`

```powershell
$params = @{
    SecretServer = 'http://argos/SecretServer'
    Credential = Get-Secret apidemo
}
$session = New-TssSession @params

# Setting TssSession Default parameter (set once and forget)
try {
    $PSDefaultParameterValues.Add("*:TssSession",$session)
} catch {
    $PSDefaultParameterValues.Remove("*:TssSession")
    $PSDefaultParameterValues.Add("*:TssSession",$session)
}

Set-TssSecretField -FieldSlug Domain -SearchText 'lab.local' | Set-TssSecretField -TssSession $session -Slug domain -Value 'newdomain.local'
```
