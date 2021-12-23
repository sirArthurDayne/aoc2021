# Advent of code 2021.
# sirArthurDayne
#num : segment
# unioue segments
# 1 : 2
# 4 : 4
# 7 : 3
# 8 : 7
# similar segments
# 2 : 5
# 3 : 5
# 5 : 5
# 0 : 6
# 6 : 6
# 9 : 6
$filedata = Get-Content "../src/data8.txt"

[int[]]$validSignals = 2,3,4,7

$total = 0
foreach ($line in $filedata) {
    # $inputSignal  = $line.Split("|")[0].Split(" ")
    $outputSignal = $line.Split("|")[1].Split(" ")
    # Write-Host $outputSignal

    foreach ($signal in $outputSignal) {
        # Write-Host "$signal , length: $($signal.length)" -ForegroundColor red
            if ($validSignals -contains $signal.Length) {
                $total++
                }
       }
}
Write-Host "total de signals: $total" -ForegroundColor green
