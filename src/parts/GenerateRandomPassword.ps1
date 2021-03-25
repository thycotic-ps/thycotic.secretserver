<#
.SYNOPSIS
Generate a random password.
.NOTES
Original: https://gist.github.com/indented-automation/2093bd088d59b362ec2a5b81a14ba84e
#>
param (
    [parameter(ValueFromPipeline)]
    [ValidateRange(8, 255)]
    [int]
    $Length = 8,

    [string[]]
    $CharacterSet = ('abcdefghjkmnpqrstuvwxyz','ABCDEFGHJKMNPQRSTUVWXYZ','23456789','!$%&.#;'),

    [int[]]
    $CharacterSetCount = (@(1) * $CharacterSet.Count)
)
begin {
    $bytes = [Byte[]]::new(4)
    $randomGenerator = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $randomGenerator.GetBytes($bytes)

    $seed = [System.BitConverter]::ToInt32($bytes, 0)
    $random = [Random]::new($seed)

    $allCharacterSets = [String]::Concat($CharacterSet)
}
process {
    $requiredCharLength = 0
    foreach ($i in $CharacterSetCount) {
        $requiredCharLength += $i
    }

    if ($requiredCharLength -gt $Length) {
        throw "The sum of characters specified by CharacterSetCount is higher than the desired password length"
    }

    $password = [Char[]]::new($Length)
    $index = 0

    for ($i = 0; $i -lt $CharacterSet.Count; $i++) {
        for ($j = 0; $j -lt $CharacterSetCount[$i]; $j++) {
            $password[$index++] = $CharacterSet[$i][$random.Next($CharacterSet[$i].Length)]
        }
    }

    for ($i = $index; $i -lt $Length; $i++) {
        $password[$index++] = $allCharacterSets[$random.Next($allCharacterSets.Length)]
    }

    # Fisher-Yates shuffle
    for ($i = $Length; $i -gt 0; $i--) {
        $n = $i - 1
        $m = $random.Next($i)
        $j = $password[$m]
        $password[$m] = $password[$n]
        $password[$n] = $j
    }

    [string]::new($password)
}