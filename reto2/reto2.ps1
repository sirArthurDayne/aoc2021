# Advent of code day2
# sirArthurDayne

$filedata = Get-Content "../src/data2.txt"

# PART 1
$depth = 0
$position = 0
ForEach ($command in $filedata) {
    $instruction = $command.Split(" ")
    switch ($instruction[0]) {
        "forward" { $position += $instruction[1]}
        "up" { $depth -= $instruction[1]}
        "down" { $depth += $instruction[1]}
    }
}
$result = $depth * $position
Write-Output $result

# PART 2
$depth = 0
$position = 0
$aim = 0
ForEach ($command in $filedata) {
    $instruction = $command.Split(" ")
    switch ($instruction[0]) {
        "forward" {
            $position += $instruction[1]
            $depth += $aim * $instruction[1]
        }
        "up" { $aim -= $instruction[1]}
        "down" { $aim += $instruction[1]}
    }
}
$result = $depth * $position
Write-Output $result
