#Advent of code day10 part1
# SirArthurDayne

class Stack {
        [System.Collections.ArrayList]$list= @()
        Stack() {}
        [void] Push($el) { $this.list.Add($el) }
        [string] Pop() {
            $s = $this.Peek()
            $this.list.RemoveAt($this.list.Count -1)
            return $s
        }
        [void] Clear() { $this.list.Clear() }
        [string] Peek() { return $this.list[$this.list.Count - 1]}
        [int] Size() { return $this.list.Count }
        [string[]] ToArr() {return $this.list.ToArray([string]) }
    }

#parse data
$filedata = Get-Content "../src/data10.txt"
$pointsTable = [ordered]@{
    ")" = 3;
    "]" = 57;
    "}" = 1197;
    ">" = 25137;
    }
$incorrectTotals = [ordered]@{
    ")" = 0;
    "]" = 0;
    "}" = 0;
    ">" = 0;
    }
$partner = @{
    #opening
    ")" = "(";
    "]" = "[";
    "}" = "{";
    ">" = "<";
    #closing
    "(" = ")";
    "[" = "]";
    "{" = "}";
    "<" = ">";
    }
#check for corrupted lines
foreach ($line in $filedata) {
        $stack = [Stack]::new()
        #load stack char by char
        foreach($l in $line.ToCharArray()) {
                if ($l -in @("(","{","[","<")) {
                    $stack.Push($l)
                } else {
                    $lastChar = $stack.Peek()
                    if ($partner[$lastChar] -eq $l) {
                            #found partner
                            $stack.Pop() | Out-Null
                    }
                    else {#corrupted line
                            $incorrectTotals[$l]++
                            Write-Host "Expected $($partner[$lastChar]), but found $l instead" -ForegroundColor magenta
                            break
                        }
                }
            }
        #clear before next iteration
        $stack.Clear()
    }
$incorrectTotals
$total = 0
$pointsTable.keys | % {
        $total += $pointsTable[$_] * $incorrectTotals[[string]$_]
    }
$total
#total 323,691
