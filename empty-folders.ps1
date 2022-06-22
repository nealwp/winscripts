# empty files from deep folders into parent folder
Get-ChildItem -Path "C:\xfer\datasets\ASCII-TAB\" -Recurse -File | Move-Item -Destination "C:\xfer\datasets\EXCEL\"

Get-ChildItem -Path "C:\xfer\datasets\ASCII-COMMA\*.txt" | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "csv") } 