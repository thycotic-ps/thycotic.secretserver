<#
.SYNOPSIS
Pulls a random song from the CSV file to use as a string value in tests.

Source: https://github.com/fivethirtyeight/data/blob/master/classic-rock/classic-rock-song-list.csv
#>
$classicRockCsv = [IO.Path]::Combine($PSScriptRoot, 'classic-rock-song-list.csv')
$data = Import-Csv $classicRockCsv

$random = Get-Random -Maximum 2229 #max records in CSV file

return $data[$random].'Song Clean'