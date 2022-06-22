Dim fso, newfolder, newfolderpath

newfolderpath = "C:\Users\Owner\Desktop\hello"

Set fso = CreateObject("Scripting.FileSystemObject")

For i = 0 to 100
	If Not fso.FolderExists(newfolderpath & i) Then
		Set newfolder = fso.CreateFolder(newfolderpath & i)
   	End If
Next