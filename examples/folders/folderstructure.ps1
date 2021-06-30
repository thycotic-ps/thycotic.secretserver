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