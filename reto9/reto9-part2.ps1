# Advent of Code day 9 part2
# sirArthurDayne

class Stack {
        $list = [Collections.Generic.List[int[]]]::new()
        $size = 0
        Stack() {$this.size = 0}
        [void]Push([int[]]$element ) {
                $this.list.Add($element)
                $this.size++
            }
        [void]Pop() {
                $this.list.RemoveAt($this.size -1)
                $this.size = $this.size -1
            }
        [int[]]Peek() {
                return $this.list[-1]
        }
        [void]Clear() {
                $this.list.Clear()
                $this.size = 0
            }
        [int]GetSize() {
                return $this.size
            }
    }

$filedata = Get-Content "../src/data9.txt"
[int]$rowSize = $filedata.count
[int]$colSize = $filedata[0].length
[int[,]]$board = (New-Object 'int[,]'$rowSize,$colSize)
[int[,]]$ids = (New-Object 'int[,]'$rowSize,$colSize)
$lowPoints = [Collections.Generic.List[int[]]]::new()
$curr_id = 1
#load board
for ($row=0; $row -lt $rowSize; $row++) {
    for ($col=0; $col -lt $colSize; $col++) {
        # Write-Host "$($filedata[$row][$col])" -ForegroundColor magenta
        $board[$row,$col] = [int]([string]$filedata[$row][$col])
        }
    }
#check and append low points
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
                    # Write-Host "$row, $col = $($board[$row,$col])" -ForegroundColor magenta
                    $a = @( ($row,$col) )
                    $lowPoints.Add($a)
                }

        }
    }

#Depth First Search
$stack = New-Object Stack
foreach ($p in $lowPoints) {
        $visited = @{}
        $stack.Push($p)
        # Write-Host "$($stack.Peek())" -ForegroundColor yellow
        while ($stack.GetSize() -gt 0) {
                $point = $stack.Peek()
                $stack.Pop()
                if ($visited.ContainsKey($point)) {
                        continue
                    }
                $visited[$p] = $true
                $ids[$p[0],$p[1]] = $curr_id
                foreach ($d in @((0,1), (0,-1) , (-1,0) , (1,0) )) {
                        $r = $p[0] + $d[0]
                        $c = $p[1] + $d[1]
                        if (-not ( ($r -ge 0 -and $r -lt $rowSize) -and ($c -ge 0 -and $c -lt $colSize) ) ) {
                            continue
                        }
                        if ($board[$r,$c] -eq 9) {
                                continue
                            }
                        $a = @($r,$c)
                        $stack.Push($a)
                }
            }
            $curr_id++
    }

Write-Host "$($stack.Peek()) | $($stack.GetSize()) " -ForegroundColor blue
