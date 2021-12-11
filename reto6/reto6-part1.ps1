# advent of code day6
# sirarthurdayne

$filedata = Get-Content "../src/data6.txt"
$fishesTimer = [System.Collections.ArrayList]::new()
$numSlice = [int[]]$filedata.Split(',')
$days = 80
foreach ($num in $numSlice) {
        $fishesTimer.Add($num) 
    }

function Get-Fishes() {
    for ($i=0;$i -lt $days; $i++) {
        $amount = $fishesTimer.count
            for ($j=0; $j -lt $amount; $j++) {
                if ($fishesTimer[$j] -eq 0) {
                    $fishesTimer[$j] = 6#resetea el contador
                        $fishesTimer.Add(8)#nuevo pez
                }
                else {
                    $fishesTimer[$j] -= 1 
                }
            }
    }
    return $fishesTimer.count
}

$total = Get-Fishes
Write-Output $total

# Ni idea de por qué imprime a pesar de no haber ningun Write-Output dentro de la funcion
