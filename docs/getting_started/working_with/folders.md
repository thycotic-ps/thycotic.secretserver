---
title: "Folders"
sort: 2
---

These are example scripts that can be used individually or combined into building a full workflow automation using the Thycotic.SecretServer module.

# Examples

## Create a single, root Folder

This will create a new folder under All Secrets folder (-1):

```powershell
$session = New-TssSession -SecretServer 'http://argos/SecretServer' -Credential (Get-Credential)
New-TssFolder -TssSession $session -FolderName 'NewRootFolder' -Verbose
```

### Output

```console
VERBOSE: Provided command parameters: New-TssFolder -FolderName:'NewRootFolder' -Verbose:$True -TssSession:TssSessionObject
VERBOSE: GET http://argos/SecretServer/api/v1/version with 0-byte payload
VERBOSE: received 190-byte response of content type application/json
VERBOSE: Content encoding: utf-8
VERBOSE: POST http://argos/SecretServer/api/v1/folders with:

VERBOSE: Performing the operation "POST http://argos/SecretServer/api/v1/folders with {
  "InheritPermissions": false,
  "parentFolderId": -1,
  "folderName": "NewRootFolder",
  "folderTypeId": 1
}" on target "".
VERBOSE: POST http://argos/SecretServer/api/v1/folders with 116-byte payload
VERBOSE: received 276-byte response of content type application/json
VERBOSE: Content encoding: utf-8

FolderId FolderName    FolderPath     InheritSecretPolicy InheritPermissions ParentFolderId SecretTemplates
-------- ----------    ----------     ------------------- ------------------ -------------- ---------------
16       NewRootFolder \NewRootFolder False               False              -1
```

## Create a Child Folder

This example will create a child folder under a current folder called "Demo":

```powershell
$session = New-TssSession -SecretServer 'http://argos/SecretServer' -Credential (Get-Secret apidemo)

$parentFolder = Search-TssFolder -TssSession $session -SearchText 'Demo'

$newFolderParams = @{
    TssSession = $session
    FolderName = 'NewChildFolder'
    ParentFolder = $parentFolder.Id
    InheritPermissions = $true
    Verbose = $true
}
New-TssFolder @newFolderParams
```

### Output

```console
VERBOSE: Provided command parameters: New-TssFolder -TssSession:TssSessionObject -FolderName:'NewChildFolder'
-ParentFolderId:4 -InheritPermissions:$True -Verbose:$True
VERBOSE: GET http://argos/SecretServer/api/v1/version with 0-byte payload
VERBOSE: received 190-byte response of content type application/json
VERBOSE: Content encoding: utf-8
VERBOSE: POST http://argos/SecretServer/api/v1/folders with:

VERBOSE: Performing the operation "POST http://argos/SecretServer/api/v1/folders with {
  "InheritPermissions": true,
  "parentFolderId": 4,
  "folderName": "NewChildFolder",
  "folderTypeId": 1
}" on target "".
VERBOSE: POST http://argos/SecretServer/api/v1/folders with 115-byte payload
VERBOSE: received 281-byte response of content type application/json
VERBOSE: Content encoding: utf-8

FolderId FolderName     FolderPath           InheritSecretPolicy InheritPermissions ParentFolderId
-------- ----------     ----------           ------------------- ------------------ --------------
19       NewChildFolder \Demo\NewChildFolder True                True               4
```

## Create a Full Folder Structure

This example will create a folder structure loosly based on the content documented under [Secret Server Best Practices - Folder Structure](https://docs.thycotic.com/ss/10.9.0/best-practices#folder_structure).

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

### CSV Representation

A CSV representation of the above structure that will be utilized in the example code to dynamically create the folder structure.

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
Import-Module C:\git\thycotic.secretserver\src\Thycotic.SecretServer.psd1
$session = New-TssSession -SecretServer 'http://argos/SecretServer' -Credential (Get-Secret apidemo)

# Pull the JSON data in to calculate root and child folders
$folderStructure = Import-Csv c:\temp\FolderStructure.csv

$rootFolders = ($folderStructure | Select-Object -Unique).ParentFolder
foreach ($parent in $rootFolders) {
    # create root parent folder
    $root = New-TssFolder -TssSession $session -FolderName $parent -ParentFolderId -1
    # Creating folder under API account, giving SS Admin (UserID = 2) ownership
    New-TssFolderPermission -TssSession $session -FolderId $root.FolderId -UserId 2 -FolderAccessRoleName Owner -SecretAccessRoleName Owner >$null
    $level1 = $folderStructure.Where({$_.ParentFolder -eq $parent}).ChildFolder
    if ($null -ne $level1 -and $root) {
        foreach ($l1Folder in $level1) {
            # create level 1 folders
            $l1 = New-TssFolder -TssSession $session -FolderName $l1Folder -ParentFolderId $root.FolderId -InheritPermissions
            $level2 = $folderStructure.Where({$_.ParentFolder -eq $l1Folder}).ChildFolder
            if ($null -ne $level2 -and $l1) {
                foreach ($l2Folder in $level2) {
                    # create level 2 folders
                    $l2 = New-TssFolder -TssSession $session -FolderName $l2Folder -ParentFolderId $l1.FolderId -InheritPermissions
                    $level3 = $folderStructure.Where({$_.ParentFolder -eq $l2Folder}).ChildFolder
                    if ($null -ne $level3 -and $l2) {
                        foreach ($l3Folder in $level3) {
                            # create level 3 folders
                            $l3 = New-TssFolder -TssSession $session -FolderName $l3Folder -ParentFolderId $l2.FolderId -InheritPermissions
                            $level4 = $folderStructure.Where({$_.ParentFolder -eq $l3Folder}).ChildFolder
                            if ($null -ne $level4 -and $l3) {
                                foreach ($l4Folder in $level4) {
                                    # create level 4 folders
                                    $l4 = New-TssFolder -TssSession $session -FolderName $l4Folder -ParentFolderId $l3.FolderId -InheritPermissions
                                    $level5 = $folderStructure.Where({$_.ParentFolder -eq $l4Folder}).ChildFolder
                                    if ($null -ne $level5 -and $l4) {
                                        foreach ($l5Folder in $level5) {
                                            # create level 5 folders
                                            $l5 = New-TssFolder -TssSession $session -FolderName $l5Folder -ParentFolderId $l4.FolderId -InheritPermissions
                                            $level5 = $folderStructure.Where({$_.ParentFolder -eq $l5Folder}).ChildFolder
                                            if ($null -ne $level5 -and $l5) {
                                                # Should be no more
                                            } else {
                                                Write-Host "Level 5 has no further child folders"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

Search-TssFolder -TssSession $session -ParentFolderId $root.FolderId
```

### Output

```console
FolderId FolderName             FolderPath                                                                            Inheri
                                                                                                                      tSecre
                                                                                                                      tPolic
                                                                                                                      y
-------- ----------             ----------                                                                            ------
28       Customers              \ABC Company\Customers                                                                True
29       Human Resources        \ABC Company\Human Resources                                                          True
30       Information Technology \ABC Company\Information Technology                                                   True
31       Development Services   \ABC Company\Information Technology\Development Services                              True
32       Programmers            \ABC Company\Information Technology\Development Services\Programmers                  True
33       Technical Services     \ABC Company\Information Technology\Technical Services                                True
34       Databases              \ABC Company\Information Technology\Technical Services\Databases                      True
35       Oracle                 \ABC Company\Information Technology\Technical Services\Databases\Oracle               True
36       SQL Server             \ABC Company\Information Technology\Technical Services\Databases\SQL Server           True
37       Systems                \ABC Company\Information Technology\Technical Services\Systems                        True
38       Network Infrastructure \ABC Company\Information Technology\Technical Services\Systems\Network Infrastructure True
39       Unix                   \ABC Company\Information Technology\Technical Services\Systems\Unix                   True
40       Windows                \ABC Company\Information Technology\Technical Services\Systems\Windows                True
41       Vendors                \ABC Company\Vendors                                                                  True
```
