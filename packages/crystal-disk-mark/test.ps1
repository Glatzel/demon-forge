# First match
$string = "This is the first test string."
$string -match "first"  # This will update $matches
$firstMatch = $matches[0]  # Save the result if you need to preserve it

# Second match
$string = "This is the second test string."
$string -match "second"  # This will update $matches again
$secondMatch = $matches[0]  # Save the result of the second match

# Now you can use $firstMatch and $secondMatch without confusion
Write-Output "First match: $firstMatch"
Write-Output "Second match: $secondMatch"