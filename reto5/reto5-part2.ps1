# Advent of Code day5-part1
# sirArthurDayne

class Line {
        [int]$x1
        [int]$y1
        [int]$x2
        [int]$y2
        [int]$directX
        [int]$directY
    }

# parse filedata into lines
$filedata = Get-Content "../src/data5.txt"

# make data structure
$PointList = New-Object System.Collections.ArrayList($null)
$index=0
foreach ($line in $filedata) {
        $numArr = $line.Split(",").Split("-").Split(">").Split(" ").Split("",[System.StringSplitOptions]::RemoveEmptyEntries)
        $p = [Line]::new()
        $p.x1 = [Convert]::ToInt32($numArr[0])
        $p.y1 = [Convert]::ToInt32($numArr[1])
        $p.x2 = [Convert]::ToInt32($numArr[2])
        $p.y2 = [Convert]::ToInt32($numArr[3])
        $p.directX = [math]::Sign($p.x2 - $p.x1)
        $p.directY = [math]::Sign($p.y2 - $p.y1)
        $PointList.Add($p) | Out-Null
    }

# encontrar el tamano maximo de la gradilla
$max_x = 0
$max_y = 0
foreach ($p in $PointList) {
        $max_x = [math]::Max($max_x, [math]::Max($p.x1,$p.x2) )
        $max_y = [math]::Max($max_y, [math]::Max($p.y1,$p.y2) )
    }
Write-Output "max_X: $max_x , max_y: $max_y"
[int[]]$grid = (New-Object 'int[]' $(($max_x+1) * ($max_y+1)))

#iterar en busca de colisiones
foreach ($line in $PointList) {
    $starX, $starY = $line.x1, $line.y1
    $endX, $endY = $line.x2, $line.y2
    $PX, $PY = $startX, $startY
        while ( ($PX -ne $endX) -and ($PY -ne $endY) ) {
                $grid[$PX * $max_x + $PY] += 1
                $PX += $line.directX
                $PY += $line.directY
                Write-Output "$PX , $PY"
            }
        $grid[$endX * $max_x + $endY] += 1 
    }

$counter = 0

for ($x=0;$x -lt $max_x+1;$x++) {
 for ($y=0;$y -lt $max_y+1;$y++) {
             if ($grid[$x * $max_x + $y] -ge 2) {
                     $counter++
                 }
         }
     }
Write-Output $counter
