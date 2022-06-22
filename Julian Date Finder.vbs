'Julian Date Finder
'
'This tool interprets user input and returns a Julian Date for a given calendar date or vice versa.
'
'Created by Sgt Neal, William P 20190118
'
'If you have opened this file as a .txt, you'll have to change the file extension to .vbs in order to run the program.

Do

Dim i
i = InputBox("Type the date you're looking for below. (MM/DD/YY or Julian Date)","Sgt Neal's Badass Julian Date Finder  - " & Right(Year(Date),2) & String(3-Len(Date - DateSerial(Year(Date),1,0)),"0") & Date - DateSerial(Year(Date),1,0))
 
If InStr(i,"/") Then  

	Dim c
	c =  CDate(i)

	Dim j
	j = Right(Year(c),2) & String(3-Len(c - DateSerial(Year(c),1,0)),"0") & c - DateSerial(Year(c),1,0)

	x = MsgBox(j, 0, "Julian Date")

ElseIf Len(i) = 5 Then

	Dim y2
	y2 = Left(i,2)

	Dim fv
	fv = DateAdd("d",(Int(Right(i,3))),CDate("01/01/" & y2)-1)

	x = MsgBox(fv, 0, "Calendar Date")

ElseIf Len(i) = 4 Then

	Dim y1
	y1 = Left(i,1)

	Dim fr
	fr = DateAdd("d",(Int(Right(i,3))),CDate("01/01/201" & y1)-1)

	x = MsgBox(fr, 0, "Calendar Date")

ElseIf Len(i) < 4 And Len(i) > 0 Then

	x = MsgBox("Format not recognized.", 0, "Error!")

ElseIf Len(i) > 5 Then

	x = MsgBox("Format not recognized.", 0, "Error!")

End If

Loop While Len(i) > 0







