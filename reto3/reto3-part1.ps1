# Advent of Code day 3
# sirArthurDayne

$filedata = Get-Content "../src/data3.txt"
$totalSize = $filedata.Length
$OxygenList = $filedata
$Co2List = $filedata

#12bits per report
$consumption = @(0,0,0,0,0,0,
                 0,0,0,0,0,0)

Foreach ($report in $filedata) {
    for ($i=0; $i -lt $filedata[0].Length; $i++) {
        if ($report[$i] -eq '1') {
            $consumption[$i]++
        }
    }
}

$resultBytes = ""
# check for common bit
for ($j=0; $j -lt $consumption.Length; $j++) {
    if ($consumption[$j] -lt ($totalSize - $consumption[$j])) {
        $resultBytes += "0"
    }
    else {
        $resultBytes += "1"
    }
}
Write-Output $resultBytes

$gammaRate = [Convert]::ToInt32($resultBytes,2)
$epsilonRate = ([Convert]::ToString(-bnot $gammaRate,2))[-12..-1] -join ''
$epsilonRate = [Convert]::ToInt32($epsilonRate,2)
Write-Output $gammaRate
Write-Output $epsilonRate
Write-Output $($gammaRate * $epsilonRate)
