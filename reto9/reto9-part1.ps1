#Advent of code 2021
# sirArthurDayne

$filedata = Get-Content "../src/data9.txt"
[int]$rowSize = $filedata.count
[int]$colSize = $filedata[0].length
[int[,]]$board = (New-Object 'int[,]'$rowSize,$colSize)

#load board
for ($row=0; $row -lt $rowSize; $row++) {
    for ($col=0; $col -lt $colSize; $col++) {
        # Write-Host "$($filedata[$row][$col])" -ForegroundColor magenta
        $board[$row,$col] = [int]([string]$filedata[$row][$col])
        }
    }

#check for low points
$riskLevel = 0
for ($row=0; $row -lt $rowSize; $row++) {
    for ($col=0; $col -lt $colSize; $col++) {
        $low = $true
        foreach ($pos in @((0,1), (0,-1) , (-1,0) , (1,0) )) {
                $r = $row+$pos[0]
                $c = $col+$pos[1]
                if (-not ( ($r -ge 0 -and $r -lt $rowSize) -and ($c -ge 0 -and $c -lt $colSize) ) ) {
                    continue
                    }
                if ($board[$r,$c] -le $board[$row,$col]) {
                    $low = $false
                    break
                    }
            }
            if ($low) {
                    $riskLevel += $board[$row,$col]+1
                }

        }
    }
Write-Host $riskLevel -ForegroundColor green
