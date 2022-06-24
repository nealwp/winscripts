$userhome = [Environment]::GetFolderPath('UserProfile')

if (Test-Path -Path $userhome\.vimrc) {
  Rename-Item -Path $userhome\.vimrc -NewName $userhome\.vimrc-old -Force
}

Copy-Item -Path $PSScriptRoot\.vimrc -Destination $userhome\.vimrc