# Advent of Code day 3- part2.
# sirArthurDayne

function Get-CommonValues($filedata, $index, [switch]$leastCommonBit) {
        [int]$zeroBit = 0
        [int]$oneBit = 0
        #verificar cual bit es el mayor en cada columna
        foreach ($row in $filedata) {
                if ([int][string]$row[$index] -eq 0) {
                     $zeroBit++ 
                } else {
                    $oneBit++
                }
            }
        #confirmamos el bit comun en esa columna
        $commonBit = '1'
        if ($zeroBit -gt $oneBit) { $commonBit = '0' } 

        if ($leastCommonBit) {
                if ($commonBit -eq 0) {  $commonBit = '1' }
                else { $commonBit = '0' }
            }
        #retorna la lista filtrada segun el bit comun en esa columna
        $filedata | Where-Object { 
                [string]$item = $_
                $item[$index] -eq $commonBit
            }
    }

function Get-OxygenRating {
        $fdata =  Get-Content "../src/data3.txt"
        for ($i=0; $i -lt $fdata[0].Length; $i++){
                $fdata = Get-CommonValues -filedata $fdata -index $i
            }
         #retorna el elemento ganador en formato decimal
         [Convert]::ToInt32($fdata,2)
    }

function Get-Co2Rating {
        $fdata =  Get-Content "../src/data3.txt"
        for ($i=0; $i -lt $fdata[0].Length; $i++){
                $fdata = Get-CommonValues -filedata $fdata -index $i -leastCommonBit
            }
         #retorna el elemento ganador en formato decimal
         [Convert]::ToInt32($fdata,2)
    }

$O = Get-OxygenRating
$CO2 = Get-Co2Rating 

Write-Output "$O"
Write-Output "$CO2"
Write-Output "el total es $($O * $CO2)"
