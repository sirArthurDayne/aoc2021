
$filedata = Get-Content "../src/data6.txt"
$days = 256
$fishTable = @{}
foreach ($f in $filedata.Split(",")) {
            $fishTable[[int]$f] += 1
    }
Write-Output "total de llaves: $($fishTable.count)"

for ($i=0; $i -lt $days; $i++) {
        $newFishTable = @{}
        foreach ($key in $fishTable.Keys ) {
                if ($key -eq 0) {
                    $newFishTable[6] += $fishTable[$key]
                    $newFishTable[8] = $fishTable[$key]
                } else {
                    $newFishTable[$key - 1] += $fishTable[$key]
                }
            }
            $fishTable = $newFishTable.Clone()
    }
Write-Output $fishTable

$total = 0
foreach ($key in $fishTable.Keys) {
        $total += $fishTable[$key]
    }
Write-Output $total

