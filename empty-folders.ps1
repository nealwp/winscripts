# empty files from deep folders into parent folder
Get-ChildItem -Recurse -File | Move-Item -Destination "."