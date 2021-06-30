---
title: "Folders"
sort: 2
---

These are example scripts that can also be found on the repository under the [examples folder]. The code and data in the examples is free to use.

# Examples

## Create a single, root Folder

This will create a new folder under All Secrets folder (-1) named `A root folder`. The user used in the call will be the only one that has access to this folder once created.

```powershell
Import-Module Thycotic.SecretServer

$sessionParams = @{
    SecretServer = 'http://prod/SecretServer'
    Credential = Get-Credential
}
$session = New-TssSession @sessionParams

New-TssFolder -TssSession $session -FolderName 'A root folder' -Verbose
```

### Output

```console
PowerShell credential request
Enter your credentials.
User: ssadmin
Password for user ssadmin: ********

VERBOSE: Provided command parameters: New-TssFolder -TssSession:TssSessionObject -FolderName:'A root folder' -Verbose:$True
VERBOSE: POST http://prod/SecretServer/api/v1/folders with:

VERBOSE: Performing the operation "POST http://prod/SecretServer/api/v1/folders with {
  "parentFolderId": -1,
  "folderTypeId": 1,
  "folderName": "A root folder",
  "InheritPermissions": false
}" on target "".
VERBOSE: POST http://prod/SecretServer/api/v1/folders with 116-byte payload
VERBOSE: received 275-byte response of content type application/json
VERBOSE: Content encoding: utf-8

FolderId FolderName    FolderPath     InheritSecretPolicy InheritPermissions ParentFolderId
-------- ----------    ----------     ------------------- ------------------ --------------
3        A root folder \A root folder False               False              -1
```

## Add Permissions to a Root Folder

For a folder to be of any user to your users they need to have rights to the folder. The below example will add `Group 1` with edit rights on the folder and owner rights for the secrets in the folder.

```powershell
Import-Module Thycotic.SecretServer

$sessionParams = @{
    SecretServer = 'http://prod/SecretServer'
    Credential = Get-Credential
}
$session = New-TssSession @sessionParams

$rootFolder = Search-TssFolder -TssSession $session -SearchText 'A root folder'
$group = Search-TssGroup -TssSession $session -SearchText 'Group 1'

$folderPermParams = @{
    TssSession = $session
    FolderId = $rootFolder.Id
    GroupId = $group.GroupId
    FolderAccessRoleName = 'Edit'
    SecretAccessRoleName = 'Owner'
}
New-TssFolderPermission @folderPermParams
```

### Output

```console
FolderPermissionId FolderId FolderAccessRoleName GroupName KnownAs SecretAccessRoleName Username
------------------ -------- -------------------- --------- ------- -------------------- --------
4                  3        Edit                 Group 1   Group 1 Owner
```

## Create a Child Folder

Creating a child folder is not far off of the process to create a root folder, exception is specifying the `ParentFolderId`.

```powershell
Import-Module Thycotic.SecretServer

$sessionParams = @{
    SecretServer = 'http://prod/SecretServer'
    Credential = Get-Credential
}
$session = New-TssSession @sessionParams

$rootFolder = Search-TssFolder -TssSession $session -SearchText 'A root folder'

$newFolderParams = @{
    TssSession = $session
    FolderName = 'A child folder'
    ParentFolderId = $rootFolder.Id
    InheritPermissions = $true
}
New-TssFolder @newFolderParams -Verbose
```

### Output

```console
VERBOSE: Provided command parameters: New-TssFolder -Verbose:$True -InheritPermissions:$True -ParentFolderId:3 -FolderName:'A child folder' -TssSession:TssSessionObject
VERBOSE: POST http://prod/SecretServer/api/v1/folders with:

VERBOSE: Performing the operation "POST http://prod/SecretServer/api/v1/folders with {
  "parentFolderId": 3,
  "folderTypeId": 1,
  "folderName": "A child folder",
  "InheritPermissions": true
}" on target "".
VERBOSE: POST http://prod/SecretServer/api/v1/folders with 115-byte payload
VERBOSE: received 289-byte response of content type application/json
VERBOSE: Content encoding: utf-8

FolderId FolderName     FolderPath                    InheritSecretPolicy InheritPermissions ParentFolderId
-------- ----------     ----------                    ------------------- ------------------ --------------
4        A child folder \A root folder\A child folder True                True               3
```

## Create a Full Folder Structure

This example will create a folder structure loosly based on the [Secret Server Best Practices - Folder Structure](https://docs.thycotic.com/ss/10.9.0/best-practices#folder_structure).

### Folder Structure

```bash
|-- ABC Company
|   |-- Customers
|   |-- Human Resources
|   |-- Information Technology
|   |   |-- Development Services
|   |   |   |-- Programmers
|   |   |-- Technical Services
|   |   |   |-- Databases
|   |   |   |   |-- Oracle
|   |   |   |   |-- SQL Server
|   |   |   |-- Systems
|   |   |   |   |-- Network Infrastructure
|   |   |   |   |-- Unix
|   |   |   |   |-- Windows
|   |-- Vendors
|   |-- Security
```

### CSV Data

The CSV that represents the above folder structure is below, you can also download it from [examples folder].

```console
ParentFolder, ChildFolder
ABC Company, Customers
ABC Company, Human Resources
ABC Company, Information Technology
ABC Company, Vendors
ABC Company, Security
Information Technology, Development Services
Information Technology, Technical Services
Development Services, Programmers
Technical Services, Databases
Technical Services, Systems
Databases, Oracle
Databases, SQL Server
Systems, Network Infrastructure
Systems, Unix
Systems, Windows
```

### Script

```powershell
#grant this user access to the root folder created
$userPermission = 'ssadmin'

Import-Module Thycotic.SecretServer
$sessionParams = @{
    SecretServer = 'http://prod/SecretServer'
    Credential   = Get-Secret apidemo
}
$session = New-TssSession @sessionParams

# Pull the CSV file in and construct an object that will contain the known structure
$folderStructureData = Import-Csv ([IO.Path]::Combine('..','data','folder_structure.csv'))
$folderStructure = @()
$rootFolders = ($folderStructureData | Select-Object -Unique).ParentFolder

# First get the root folders and load those into the object, folderStructure
$rootFolders.foreach({
        $folderStructure += [pscustomobject]@{
            FullPath     = Join-Path '\' $_
            FolderName   = $_
            ParentFolder = $null
            IsRoot       = $true
        }
    })

# Work through the data to build each folder
$folderStructureData.foreach({
        $folderParent = $_.ParentFolder
        $child = $_.ChildFolder
        if ($folderParent -in $rootFolders) {
            $folderPath = Join-Path '\' $folderParent $child
            $folderStructure += [pscustomobject]@{
                FullPath     = $folderPath
                ParentFolder = $folderParent
                FolderName   = $child
                IsRoot       = $null
            }
        } else {
            $subParent = $folderStructure.Where({ $_.FullPath.split('\')[-1] -eq $folderParent }).FullPath
            if ($subParent) {
                $folderPath = Join-Path $subParent $child
            }
            $folderStructure += [pscustomobject]@{
                FullPath     = $folderPath
                ParentFolder = $folderParent
                FolderName   = $child
                IsRoot       = $null
            }
        }
        $folderParent = $child = $folderPath = $null
    })
$folderStructure | Format-Table

$created = @()
foreach ($f in $folderStructure) {
    $folderName = $f.FolderName
    $folderPath = $f.FullPath
    $parentFolder = $f.ParentFolder

    Write-Output "Processing [$folderPath]"
    if ($parentFolder) {
        $parent = $folderStructure.Where({ $_.FolderName -eq $parentFolder })
        $parentFullPath = $parent.FullPath
        $parentRoot = $parent.IsRoot
        # see if parent folder already exists
        Write-Output "  Check if Parent [$parentFullPath] exists"
        $parentFolderObj = Search-TssFolder -TssSession $session -WarningAction SilentlyContinue | Where-Object FolderPath -EQ $parentFullPath
        if (-not $parentFolderObj) {
            Write-Output "  Parent path not found, creating"
            # root folder not found, create it
            $newFolderParams = @{
                TssSession = $session
                FolderName = $parentFolder
            }
            if (-not $parentRoot) {
                $newFolderParams.Add('InheritPermissions',$true)
            }
            $parentFolderObj = New-TssFolder @newFolderParams
            Write-Output "  Parent [$parentFullPath] created"
            $created += $parentFolderObj
        }
    }

    # make sure child folder is not already created
    $folderSearchParams = @{
        TssSession = $session
        SearchText = $folderName
    }
    Write-Output "  Verifying if folder path [$folderPath] already exists"
    $childFolder = Search-TssFolder @folderSearchParams -WarningAction SilentlyContinue
    if (-not $childFolder) {
        Write-Output "  Folder path not found, creating"
        # does not exists, create it
        $createFolderParams = @{
            TssSession = $session
            FolderName = $folderName
        }

        if ($parentFolderObj) {
            $createFolderParams.Add('ParentFolderId',$parentFolderObj.FolderId)
        } else {
            $createFolderParams.Add('ParentFolderId',-1)
        }
        $newFolder = New-TssFolder @createFolderParams
        Write-Output "  Folder [$folderPath] created"

        Write-Output "  Adding permission for user [$userPermission], if not inheriting"
        if (-not $newFolder.InheritPermissions) {
            $null = Add-TssFolderPermission -TssSession $session -Username $userPermission -FolderId $newFolder.Id -FolderRole Owner -SecretRole Owner
        }
        $created += $newFolder
    }
}

$createdCount = $created.Count
$folderStructureCount = $folderStructure.Count
if ($createdCount -eq $folderStructureCount) {
    Write-Output "Folder structure successfully created"
} else {
    Write-Warning "Folder created count [$createdCount] does not match structure count [$folderStructureCount]"
}
$null = $session.SessionExpire()
```

### Output

```console
FullPath                                                                              FolderName             ParentFolder           IsRoot
--------                                                                              ----------             ------------           ------
\ABC Company                                                                          ABC Company                                     True
\ABC Company\Customers                                                                Customers              ABC Company
\ABC Company\Human Resources                                                          Human Resources        ABC Company
\ABC Company\Information Technology                                                   Information Technology ABC Company
\ABC Company\Vendors                                                                  Vendors                ABC Company
\ABC Company\Security                                                                 Security               ABC Company
\ABC Company\Information Technology\Development Services                              Development Services   Information Technology
\ABC Company\Information Technology\Technical Services                                Technical Services     Information Technology
\ABC Company\Information Technology\Development Services\Programmers                  Programmers            Development Services
\ABC Company\Information Technology\Technical Services\Databases                      Databases              Technical Services
\ABC Company\Information Technology\Technical Services\Systems                        Systems                Technical Services
\ABC Company\Information Technology\Technical Services\Databases\Oracle               Oracle                 Databases
\ABC Company\Information Technology\Technical Services\Databases\SQL Server           SQL Server             Databases
\ABC Company\Information Technology\Technical Services\Systems\Network Infrastructure Network Infrastructure Systems
\ABC Company\Information Technology\Technical Services\Systems\Unix                   Unix                   Systems
\ABC Company\Information Technology\Technical Services\Systems\Windows                Windows                Systems

Processing [\ABC Company]
  Verifying if folder path [\ABC Company] already exists
  Folder path not found, creating
  Folder [\ABC Company] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Customers]
  Check if Parent [\ABC Company] exists
  Verifying if folder path [\ABC Company\Customers] already exists
  Folder path not found, creating
  Folder [\ABC Company\Customers] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Human Resources]
  Check if Parent [\ABC Company] exists
  Verifying if folder path [\ABC Company\Human Resources] already exists
  Folder path not found, creating
  Folder [\ABC Company\Human Resources] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology]
  Check if Parent [\ABC Company] exists
  Verifying if folder path [\ABC Company\Information Technology] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Vendors]
  Check if Parent [\ABC Company] exists
  Verifying if folder path [\ABC Company\Vendors] already exists
  Folder path not found, creating
  Folder [\ABC Company\Vendors] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Security]
  Check if Parent [\ABC Company] exists
  Verifying if folder path [\ABC Company\Security] already exists
  Folder path not found, creating
  Folder [\ABC Company\Security] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Development Services]
  Check if Parent [\ABC Company\Information Technology] exists
  Verifying if folder path [\ABC Company\Information Technology\Development Services] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Development Services] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services]
  Check if Parent [\ABC Company\Information Technology] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Development Services\Programmers]
  Check if Parent [\ABC Company\Information Technology\Development Services] exists
  Verifying if folder path [\ABC Company\Information Technology\Development Services\Programmers] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Development Services\Programmers] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services\Databases]
  Check if Parent [\ABC Company\Information Technology\Technical Services] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services\Databases] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services\Databases] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services\Systems]
  Check if Parent [\ABC Company\Information Technology\Technical Services] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services\Systems] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services\Systems] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services\Databases\Oracle]
  Check if Parent [\ABC Company\Information Technology\Technical Services\Databases] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services\Databases\Oracle] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services\Databases\Oracle] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services\Databases\SQL Server]
  Check if Parent [\ABC Company\Information Technology\Technical Services\Databases] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services\Databases\SQL Server] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services\Databases\SQL Server] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services\Systems\Network Infrastructure]
  Check if Parent [\ABC Company\Information Technology\Technical Services\Systems] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services\Systems\Network Infrastructure] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services\Systems\Network Infrastructure] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services\Systems\Unix]
  Check if Parent [\ABC Company\Information Technology\Technical Services\Systems] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services\Systems\Unix] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services\Systems\Unix] created
  Adding permission for user [ssadmin], if not inheriting
Processing [\ABC Company\Information Technology\Technical Services\Systems\Windows]
  Check if Parent [\ABC Company\Information Technology\Technical Services\Systems] exists
  Verifying if folder path [\ABC Company\Information Technology\Technical Services\Systems\Windows] already exists
  Folder path not found, creating
  Folder [\ABC Company\Information Technology\Technical Services\Systems\Windows] created
  Adding permission for user [ssadmin], if not inheriting
Folder structure successfully created
```

[examples folder]:https://github.com/thycotic-ps/thycotic.secretserver/tree/main/docs