$var = read-host "user input needed: "
write-output “Hallo” | where-object { $_.length –gt 10 }
write-host “some text” –foreground $color1 –background green
