#Advent of code 2021
# sirArthurDayne day 11 part2

$filedata = Get-Content "../src/data11.txt"

#parse data into octopus
$gridSize = 10
[int[,]]$octopus = (New-Object 'int[,]'$($gridSize),$($gridSize))
$x,$y = 0,0
foreach ($line in $filedata) {
        foreach ($c in $line.ToCharArray()) {
                $octopus[$x, $y] = [int]([string]$c)
                $y++
            }
            $y=0
            $x++
    }

function flash([int]$r, [int]$c) {
    $count = 1
    #set cell to zero
    $octopus[$r,$c] = 0
    #update neighbors state using axis
    foreach ($dr in @(-1,0,1)) {
        foreach ($dc in @(-1,0,1)) {
            #check state of 4 adyacent neighbors and make sure not checking the current cell
                if ( ($r+$dr -ge 0 -and $r+$dr -lt $gridSize -and $c+$dc -ge 0 -and $c+$dc -lt $gridSize) -and $octopus[$($r+$dr), $($c+$dc)] -ne 0) {
                        $octopus[$($r+$dr),$($c+$dc)] += 1
                        #check for neighbors state before updating the count
                        if ($octopus[$($r+$dr),$($c+$dc)] -gt 9) {
                            #traverse neighbors recursively for updating count
                            $count += flash $($r+$dr) $($c+$dc)
                        }
                    }
            }
        }
    return $count
    }
$flashes = 0
$total = 0 #count the step
#iterate until you found the first sync state
while ($true) {
        $new_flashes = 0
        #traverse and increase each cell
        for ($r=0;$r -lt $gridSize; $r++) {
            for($c=0;$c -lt $gridSize; $c++) {
                $octopus[$r,$c] += 1
            }}
        #check for flash state
        for ($r=0;$r -lt $gridSize; $r++) {
            for($c=0;$c -lt $gridSize; $c++) {
                if ($octopus[$r,$c] -gt 9) {
                        $new_flashes += flash $r $c
                    }
            }}
        $flashes += $new_flashes
        $total++
        if ($new_flashes -eq 100) {
                Write-Host "Step: $total | totalflashes: $flashes" -foregroundcolor yellow
                break
            }
}
