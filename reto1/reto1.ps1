# Advent of code day 1: sirArthurDayne
# leer el archivo
$fileData = Get-Content "..\src\data1.txt"

function get-result1()
{
    $counter = 0
    $prev = -1
    Foreach ($numString in $fileData) {
        # parsear a una lista de numeros
        $current = [int]$numString
        if (-not($prev -eq -1) -and ($current - $prev -gt 0) ) {
            $counter++
        }
        $prev = $current
    }
    Write-Output $counter
}

function get-result2()
{
    $counter = 0
    [int[]] $prevArr = [int]$fileData[0], [int]$fileData[1], [int]$fileData[2]
    [int[]] $currArr = [int]$fileData[1], [int]$fileData[2], [int]$fileData[3]
    for ($index=3; $index -lt $fileData.Length; $index++) {
        $a = 0
        $b = 0
        $prevArr | Foreach-Object {$a += $_}
        $currArr | Foreach-Object {$b += $_}

        if ($a -lt $b) {
            $counter++
        }
        $prevArr[$index % 3] = $currArr[($index - 1) % 3]
        $currArr[$index % 3] = $fileData[$index]
    }
    Write-Output $counter
}

get-result1
get-result2
