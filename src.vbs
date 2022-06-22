Dim myArray(4), myTxt

myArray(0) = 100
myArray(1) = 116
myArray(2) = 102
myArray(3) = 63

txt = ""

for each index in myArray
	txt = txt & Chr(index)
next

MsgBox txt & "?", vbYesNo, "Preston says..."
