#Advent of code day 7
#sirArthurDayne
$filedata = Get-Content "../src/data7.txt"
$fuelCostByPos = [System.Collections.ArrayList]::new()
foreach ($crab in $filedata.Split(",")) {
        $fuelCostByPos.Add([int]$crab) | Out-Null
}
$total = @{}

foreach ($testPos in $fuelCostByPos) {
        $val = 0
        foreach ($key in $fuelCostByPos) {
            $dist= [math]::Abs($key - $testPos)
            $cost = $dist * ($dist + 1) / 2 # EL TRUCO DEL PEQUEÑO GAUSS
            $val += $cost
        }
         Write-Output "$testPos = $val"
        if (-not $total.Contains($testPos)) {
            $total[$testPos] = $val
            }
    }
$p = $total.Values | Sort-Object -Descending
Write-Output "coste minimo de fuel: $($p[-1])"
