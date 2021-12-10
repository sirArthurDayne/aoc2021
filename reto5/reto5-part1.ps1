# Advent of Code day5-part1
# sirArthurDayne

class Line {
        [int]$x1
        [int]$y1
        [int]$x2
        [int]$y2
    }

function Get-Maximun([int]$a, [int]$b) {
        if ($a -gt $b) {
                $a
            } else {
                $b
            }
    }
function Get-Minimun([int]$a, [int]$b) {
        if ($a -gt $b) {
                $b
            } else {
                $a
            }
    }

# parse filedata into lines
$filedata = Get-Content "../src/data5.txt"

# make data structure
$PointList = New-Object System.Collections.ArrayList($null)

$index=0
foreach ($line in $filedata) {
        $numArr = $line.Split(",").Split("-").Split(">").Split(" ").Split("",[System.StringSplitOptions]::RemoveEmptyEntries)
        # Write-Output "i $($numArr.Length):"
        $p = [Line]::new()
        $p.x1 = [Convert]::ToInt32($numArr[0])
        $p.y1 = [Convert]::ToInt32($numArr[1])
        $p.x2 = [Convert]::ToInt32($numArr[2])
        $p.y2 = [Convert]::ToInt32($numArr[3])
        $PointList.Add($p)
    }

# borrar lineas que NO sean horizontales o verticales
for ($i=0;$i -lt $PointList.count; $i++) {
        if (($PointList[$i].x1 -eq $PointList.x2) -or ($PointList[$i].y1 -eq $PointList[$i].y2) ) {
                $PointList.RemoveAt($i)
                Write-Output "borrando punto: $i"
            }
    }
Write-Output $PointList

# encontrar el tamano maximo de la gradilla
$max_x = 0
$max_y = 0
foreach ($p in $PointList) {
        $max_x = Get-Maximun -a $max_x -b (Get-Maximun -a $p.x1 -b $p.x2)
        $max_y = Get-Maximun -a $max_y -b (Get-Maximun -a $p.y1 -b $p.y2)
    }
Write-Output "max_X: $max_x , max_y: $max_y"
[int[,]]$grid = (New-Object 'int[,]' $($max_x+1), $($max_y+1))

for ($x=0;$x -lt $max_x+1;$x++) {
 for ($y=0;$y -lt $max_y+1;$y++) {
             $grid[$x, $y] = 0
         }
     }
#iterar en busca de colisiones
foreach ($p in $PointList) {
        #vertical lines
        if ($p.x1 -eq $p.x2) {
                $bottom = Get-Minimun -a $p.y1 -b $p.y2
                $top = Get-Maximun -a $p.y1 -b $p.y2
                for ($y=$bottom; $y -lt $top+1;$y++) {
                        $grid[$p.x1, $y] += 1
                        Write-Output "linea vertical $($p.x1) , $y"
                    }
            }
        else { #horizontal lines
            if ($p.y1 -eq $p.y2) {continue}
            $left = Get-Minimun -a $p.x1 -b $p.x2
            $right = Get-Maximun -a $p.x1 -b $p.x2
                for ($x=$left; $x -lt $right+1;$x++) {
                        $grid[$x, $p.y1] += 1
                        Write-Output "linea horizontal $x , $($p.y1)"
                    }

        }
    }

$counter = 0
for ($x0;$x -lt $grid.count;$x++) {
 for ($y=0;$y -lt $grid.count;$y++) {
             if ($grid[$x, $y] -ge 2) {
                     $counter++
                     Write-Output "$x $y  -> $($grid[$x, $y])"
                 }
         }
     }
Write-Output $counter
