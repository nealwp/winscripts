Dim fso, folder, newfolderpath

newfolderpath = "C:\Users\Owner\Desktop\hello"

Set fso = CreateObject("Scripting.FileSystemObject")

For i = 0 to 100
	If fso.FolderExists(newfolderpath & i) Then
		Set folder = fso.GetFolder(newfolderpath & i)
		folder.Delete(True)
   	End If
Next