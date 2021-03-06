# Advent of Code day5-part1
# sirArthurDayne

class Line {
        [int]$x1
        [int]$y1
        [int]$x2
        [int]$y2
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
        if ( ($p.x1 -eq $p.x2) -or ($p.y1 -eq $p.y2) ) {
            $PointList.Add($p) | Out-Null
        }
    }
# Write-Output $PointList

# encontrar el tamano maximo de la gradilla
$max_x = 0
$max_y = 0
foreach ($p in $PointList) {
        $max_x = [math]::Max($max_x, [math]::Max($p.x1,$p.x2) )
        $max_y = [math]::Max($max_y, [math]::Max($p.y1,$p.y2) )
    }
Write-Output "max_X: $max_x , max_y: $max_y"
# [int[,]]$grid = (New-Object 'int[,]' $($max_x+1), $($max_y+1))
[int[]]$grid = (New-Object 'int[]' $(($max_x+1) * ($max_y+1)))

#iterar en busca de colisiones
foreach ($p in $PointList) {
        #vertical lines
        if ($p.x1 -eq $p.x2) {
                $bottom = [math]::Min($p.y1, $p.y2)
                $top = [math]::Max($p.y1,$p.y2)
                for ($y=$bottom; $y -lt $top+1;$y++) {
                        $grid[$p.x1 * $max_x + $y] += 1
                        # Write-Output "linea vertical $($p.x1) , $y"
                    }
            }
        else { #horizontal lines
            $left = [math]::Min($p.x1, $p.x2)
            $right = [math]::Max($p.x1, $p.x2)
                for ($x=$left; $x -lt $right+1;$x++) {
                        $grid[$x * $max_x +  $p.y1] += 1
                        # Write-Output "linea horizontal $x , $($p.y1)"
                    }
        }
    }

$counter = 0

for ($x=0;$x -lt $max_x+1;$x++) {
 for ($y=0;$y -lt $max_y+1;$y++) {
             if ($grid[$x * $max_x + $y] -ge 2) {
                     $counter++
                     # Write-Output "$x $y  -> $($grid[$x, $y])"
                 }
         }
     }
Write-Output $counter
