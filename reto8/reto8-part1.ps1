# Advent of code 2021.
# sirArthurDayne

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
