#Advent of code 2021
# sirArthurDayne

$filedata = Get-Content "../src/data11.txt"

#parse data into octopusay
$gridSize = 10
[int[,]]$octopus = (New-Object 'int[,]'$($gridSize+1),$($gridSize+1))

$x,$y = 0,0
foreach ($line in $filedata) {
        foreach ($c in $line.ToCharArray()) {
                $octopus[$x, $y] = [int]([string]$c)
                $y++
            }
            $y=0
            $x++
    }

$total = 0
$steps = 1

for ($i=0; $i -lt $steps; $i++) {
        #track octopus
        [bool[,]]$flashed = (New-Object 'bool[,]'$($gridSize+1),$($gridSize+1))
        #update values
        for ($r=0;$r -lt $gridSize;$r) {
            for ($c=0;$c -lt $gridSize;$c) {
                $octopus[$r, $c]++
            }}
    # if we have 9 -> 0 and increase every neighbor cell by one 
        while ($true) {
            $keep_looping = $false
            # [int[,]]$octopusChange= (New-Object 'int[,]'$($gridSize+1),$($gridSize+1))
        for ($r=0;$r -lt $gridSize;$r) {
            for ($c=0;$c -lt $gridSize;$c) {
                if ( -not$flashed[$r, $c] -and $octopus[$r, $c] -gt 9) {
                        $total++
                        flashed[$r, $c] = $true
                        $keep_looping = $true

                        for ($di=-1;$di -lt 2;$di++) {
                            for ($dj=-1;$dj -lt 2;$dj++) {
                                if ($di -eq 0 -and $dj -eq 0) {
                                        continue
                                    }
                                    $ii = $r + $di
                                    $jj = $c + $dj

                                    if () {
                                            continue
                                        }
                                    $octopus[$ii, $jj] += 1
                    }}
            }
            }}
# if we have 0 -> total++
    }
}
Write-Host $total -ForegroundColor green
