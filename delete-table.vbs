Dim connStr, objConn, getNames
'''''''''''''''''''''''''''''''''''''
'Define the driver and data source
'Access 2007, 2010, 2013 ACCDB:
'Provider=Microsoft.ACE.OLEDB.12.0
''''''''''''''''''''''''''''''''''''''
connStr = "Provider=Microsoft.ACE.OLEDB.12.0; Data Source=C:\Users\Owner\Documents\Database1.accdb"

'Define object type
Set objConn = CreateObject("ADODB.Connection")

'Open Connection
objConn.open connStr

'Define recordset and SQL query
'Set rs = objConn.execute("SELECT Fname FROM people")

objConn.execute("DELETE FROM demands")

'While loop, loops through all available results
'DO WHILE NOT rs.EOF
'add names seperated by comma to getNames
'getNames = getNames + rs.Fields(0) & ","
'move to next result before looping again
'this is important
'rs.MoveNext
'continue loop
'Loop

'Close connection and release objects
objConn.Close
Set rs = Nothing
Set objConn = Nothing

'Return Results via MsgBox
'MsgBox getNames