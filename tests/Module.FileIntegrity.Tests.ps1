BeforeDiscovery {
    $moduleRoot = (Resolve-Path "$PSScriptRoot\..\src").Path
    $allFiles = Get-ChildItem -Path $moduleRoot -Recurse -Filter "*.ps1" |
        Where-Object FullName -NotLike "$moduleRoot\tests\*" |
        Where-Object FullName -NotLike "$moduleRoot\Build.ps1" |
        Where-Object FullName -NotLike "*class.ps1"
}
Describe "Verifying module PS1 files" -ForEach $allFiles {
    BeforeAll {
        $name = $_.Name
        $fullName = $_.FullName
        $file = $_

        $tokens, $parseErrors = $null
        $ast = [System.Management.Automation.Language.Parser]::ParseFile($fullName, [ref]$tokens, [ref]$parseErrors)
        function Get-FileEncoding {
            [CmdletBinding()]
            Param (
                [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
                [string]$Path
            )

            $params = @{
                ReadCount  = 4
                TotalCount = 4
                Path       = $Path
            }
            if ($PSVersionTable.PSEdition -ne 'Desktop') {
                $params.Add('AsByteStream',$true)
            } else {
                $params.Add('Encoding','Byte')
            }

            [byte[]]$byte = Get-Content @params
            #Write-Host Bytes: $byte[0] $byte[1] $byte[2] $byte[3]

            # EF BB BF (UTF8)
            if ( $byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf )
            { Write-Output 'UTF8' }

            # FE FF  (UTF-16 Big-Endian)
            elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff)
            { Write-Output 'Unicode UTF-16 Big-Endian' }

            # FF FE  (UTF-16 Little-Endian)
            elseif ($byte[0] -eq 0xff -and $byte[1] -eq 0xfe)
            { Write-Output 'Unicode UTF-16 Little-Endian' }

            # 00 00 FE FF (UTF32 Big-Endian)
            elseif ($byte[0] -eq 0 -and $byte[1] -eq 0 -and $byte[2] -eq 0xfe -and $byte[3] -eq 0xff)
            { Write-Output 'UTF32 Big-Endian' }

            # FE FF 00 00 (UTF32 Little-Endian)
            elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff -and $byte[2] -eq 0 -and $byte[3] -eq 0)
            { Write-Output 'UTF32 Little-Endian' }

            # 2B 2F 76 (38 | 38 | 2B | 2F)
            elseif ($byte[0] -eq 0x2b -and $byte[1] -eq 0x2f -and $byte[2] -eq 0x76 -and ($byte[3] -eq 0x38 -or $byte[3] -eq 0x39 -or $byte[3] -eq 0x2b -or $byte[3] -eq 0x2f) )
            { Write-Output 'UTF7' }

            # F7 64 4C (UTF-1)
            elseif ( $byte[0] -eq 0xf7 -and $byte[1] -eq 0x64 -and $byte[2] -eq 0x4c )
            { Write-Output 'UTF-1' }

            # DD 73 66 73 (UTF-EBCDIC)
            elseif ($byte[0] -eq 0xdd -and $byte[1] -eq 0x73 -and $byte[2] -eq 0x66 -and $byte[3] -eq 0x73)
            { Write-Output 'UTF-EBCDIC' }

            # 0E FE FF (SCSU)
            elseif ( $byte[0] -eq 0x0e -and $byte[1] -eq 0xfe -and $byte[2] -eq 0xff )
            { Write-Output 'SCSU' }

            # FB EE 28  (BOCU-1)
            elseif ( $byte[0] -eq 0xfb -and $byte[1] -eq 0xee -and $byte[2] -eq 0x28 )
            { Write-Output 'BOCU-1' }

            # 84 31 95 33 (GB-18030)
            elseif ($byte[0] -eq 0x84 -and $byte[1] -eq 0x31 -and $byte[2] -eq 0x95 -and $byte[3] -eq 0x33)
            { Write-Output 'GB-18030' }

            else
            { Write-Output 'ASCII' }
        }
    }
    Context "Validating <_>" {
        It "<_> Should have ASCII encoding" {
            Get-FileEncoding -Path $fullName | Should -Be 'ASCII'
        }

        It "<_> Should have no trailing space" {
            $count = ($file | Select-String "\s$" | Where-Object { $_.Line.Trim().Length -gt 0 } | Measure-Object).Count
            $count | Should -BeExactly 0
        }

        It "<_> Should have no syntax errors" {
            $parseErrors | Should -BeNullOrEmpty
        }
    }

    Context "Verify <_> does not contain unapproved code" {
        It "<_> should not contain any aliases" {
            $count = ($tokens | Where-Object TokenFlags -EQ CommandName | Where-Object { Test-Path "alias:\$($_.Text)" } | Measure-Object).Count
            $count | Should -BeExactly 0
        }
        It "<_> should not contain special character aliases" {
            $count = ($tokens | Where-Object TokenFlags -EQ 'BinaryPrecedenceMultiply, BinaryOperator, CommandName, CanConstantFold' | Where-Object { Test-Path "alias:\$($_.Text)" } | Measure-Object).Count
            $count | Should -BeExactly 0
        }
    }
}