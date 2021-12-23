# Advent of code day 8 part2
# sirArthurDayne
#https://www.youtube.com/watch?v=6oYbHbq1nEs&t=1s
# unioue segments
# 1 : 2
# 4 : 4
# 7 : 3
# 8 : 7
# similar segments
# 2 : 5
# 3 : 5
# 5 : 5
# 6 : 6
# 9 : 6
# 0 : 6
class Signal {
    [string[]]$left
    [string[]]$right
    Signal([string[]]$l, [string[]]$r) {
            $this.left = $l
            $this.right = $r
        }
}

function SameChars([string]$a, [string]$b) {
    $output = ""
    foreach ($c in $a.ToCharArray()) {
            if ($b.Contains([string]$c) ) {
                    $output += [string]$c
                }
        }
    return $output
}

$filedata = Get-Content "../src/data8.txt"

$data = [Collections.Generic.List[Signal]]::new()
foreach ($line in $filedata) {
    #lado izquierdo
    $inputSignal  = $line.Split("|")[0].Split(" ")  | Sort-Object #sortear cada elemento por orden alfabetico
    $inputSignal = $inputSignal | Foreach-Object { [string]::Join("", ($_.ToCharArray() | Sort-Object) ) } #sortear cada string por orden alfabetico
    $inputSignal = $inputSignal | Sort-Object { $_.length } #sortear por cantidad de caracteres
    # Write-Host $inputSignal -ForegroundColor green
    #lado derecho
    $outputSignal = $line.Split("|")[1].Split(" ") | Sort-Object
    $outputSignal = $outputSignal | Foreach-Object { [string]::Join("", ($_.ToCharArray() | Sort-Object)) }
    # Write-Host $outputSignal -ForegroundColor magenta
    $signal = [Signal]::new($inputSignal,$outputSignal)
    $data.Add($signal)
    }
 Write-Host "$($data[0].left)" -ForegroundColor green
 Write-Host "$($data[0].right)" -ForegroundColor magenta

$total = 0
foreach($problem in $data) {
        $ten = $problem.left
        #1,4,7,8
        $setup = [ordered]@{
            $ten[0]=1;
            $ten[1]=7;
            $ten[2]=4;
            $ten[9]=8;
            }
        $cincos = @($ten[3],$ten[4],$ten[5])
        $seis = @($ten[6],$ten[7],$ten[8])
        #6
        for ($index=0; $index -lt $seis.count; $index++) {
                $equalChars = SameChars -a $ten[0] -b $seis[$index]
                if ($equalChars.length -eq 1) {
                        $setup[$seis[$index]] = 6
                        $seis = $seis | Where-Object { $_ -ne $seis[$index] }
                        Write-Host "$seis" -ForegroundColor cyan
                        break
                    }
            }
        #9
        for ($index=0; $index -lt $seis.count; $index++) {
                $equalChars = SameChars -a $ten[2] -b $seis[$index]
                if ($equalChars.length -eq 4) {
                        $setup[$seis[$index]] = 9
                        $seis = $seis | Where-Object { $_ -ne $seis[$index] }
                        Write-Host $seis -ForegroundColor cyan
                        break
                    }
            }
        #0
        $setup[$seis[0]] = 0
        #3
        for ($index=0; $index -lt $cincos.count; $index++) {
                $equalChars = SameChars -a $ten[0] -b $cincos[$index]
                if ($equalChars.length -eq 2) {
                        $setup[$cincos[$index]] = 3
                        $cincos = $cincos | Where-Object { $_ -ne $cincos[$index] }
                        Write-Host $cincos -ForegroundColor yellow
                        break
                    }
            }
        #2
        for ($index=0; $index -lt $cincos.count; $index++) {
                $equalChars = SameChars -a $ten[2] -b $cincos[$index]
                if ($equalChars.length -eq 2) {
                        $setup[$cincos[$index]] = 2
                        $cincos = $cincos | Where-Object { $_ -ne $cincos[$index] }
                        Write-Host $cincos -ForegroundColor yellow
                        break
                    }
            }
        #5
        $setup[$cincos[0]] = 5
        #increase total
        $counter=0
        foreach ($digit in $problem.right) {
                $counter *= 10
                Write-Host "$digit : $($setup[$digit])" -ForegroundColor blue
                $counter += $setup[$digit]
            }
        $total += $counter
    }
Write-Host "TOTAL PART2: $total" -ForegroundColor green
