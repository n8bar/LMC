<%
Dim REDconnstring
REDconnstring = "DRIVER={SQL Server};SERVER=RCSTRI\SQLEXPRESS;UID=rcstricom;PWD=watf-771;DATABASE=Tribase"

Dim PDconn
PDconn = "DRIVER={SQL Server};SERVER=whsql-v03.prod.mesa1.secureserver.net;UID=tricomelstore;PWD=watf-771;DATABASE=DB_16816"




Function DecodeChars(TheString)
	dim OldString : OldString=""
	If Not IsNull(TheString) Then
		while(OldString<>TheString)
			OldString=TheString
			TheString=Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(TheString,"--RET--",chr(13)),"-COMMA-",","),"-AMPERSAND-","&"),"-QUOTE-",""""),"-APOSTROPHE-","'"),"-LESSTHAN-","<"),"-GREATERTHAN-",">"),"-PERCENT-","%"),"-POUND-","#")
		wend
	End If
	DecodeChars=TheString
End Function



Function EncodeChars(TheString)
	dim OldString : OldString=""
	If Not IsNull(TheString) Then
		while(OldString<>TheString)
			OldString=TheString
			TheString=Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(TheString,chr(13),"--RET--"),",","-COMMA-"),"&","-AMPERSAND-"),"""","-QUOTE-"),"'","-APOSTROPHE-"),"<","-LESSTHAN-"),">","-GREATERTHAN-"),"%","-PERCENT-"),"#","-POUND-")
		wend
	End If
	EncodeChars=TheString
End Function



DIM rs, rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rs8, rs9
DIM SQL, SQL0, SQL1, SQL2, SQL3, SQL4, SQL5, SQL6, SQL7, SQL8, SQL9
DIM obj, obj0, obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9

Dim XML
Dim ItemName
Dim ItemDesc
Dim Cost
Dim Cost2
Dim Sell
Dim Sell2
Dim Qty
Dim MU
Dim Part
Dim Labor
Dim CostSub
Dim SellSub
Dim Total
Dim TParts
Dim TLabor
Dim TPartsC
Dim TLaborC
Dim ItemType
Dim VendID
Dim VendName
Dim Tax






sub ReadNotes()
SQL = "SELECT * FROM estimates Where EstimateID = 508981"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open SQL, REDconnstring
response.write rs("notes")
'response.write(num1*num2)
end sub




sub WriteNotes()
SQL2 = "Update estimates set Notes = 'Nice Notes 21' where EstimateID =508981"
set rs2=Server.CreateObject("ADODB.Recordset")
rs2.Open SQL2, REDconnstring

response.write ("<SCRIPT language='JavaScript'>")
response.write ("location.reload(); ")
response.write ("</Script>")
end sub








%>
