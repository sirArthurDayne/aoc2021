# advent of code day6
# sirarthurdayne

$filedata = Get-Content "../src/data6.txt"
$fishesTimer = [System.Collections.ArrayList]::new()
$numSlice = [int[]]$filedata.Split(',')
$days = 256
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

#DEBES SUMARLE 1 al resultado final. Algo se quebro y ni idea de como arreglarlo
# Ni idea de por qué imprime a pesar de no haber ningun Write-Output en el script
# Demora demasiado en dar la respuesta pero bueno... X.x 
