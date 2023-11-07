<!--#include file="../TMC/RED.asp" -->

<%
Response.ContentType="text/xml"
If Request.QueryString("html")=1 Then Response.ContentType="text/html"

sAction = CStr(Request.QueryString("action"))

%><root><%	
Select Case sAction

	Case "SearchContacts"
		SearchContacts
	
	Case "ContactEdit"
		ContactEdit
		
	case "ContactUpdate"
		ContactUpdate
	
	case "SaveContact"
		SaveContact
	
	case "SaveNewContact"
		SaveNewContact
	
	case "ContactDel"
		ContactDel
		
	Case Else 
		 oops 
				
End Select		


Sub SearchContacts  () '--------------------------------------------------------------------------------------------------------

	SearchTxt = CStr(Request.QueryString("SearchTxt"))
	SearchType = CStr(Request.QueryString("SearchType"))
	
	HTML=""
	
	SQL = "SELECT * FROM Contacts WHERE Name LIKE '%"&SearchTxt&"%' OR Address LIKE '%"&SearchTxt&"%' OR Contact1 LIKE '%"&SearchTxt&"%' OR Contact2 LIKE '%"&SearchTxt&"%' order by Name"
	Set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring	
	
	rC=0	
	Do While Not rs.EOF
		rC=rC+1 ' Increment record counter
		
		Address2 = (rs("City")&", "&rs("State")&" "&rs("Zip"))
		Website=rs("website")
		cName=EncodeChars(rs("Name"))
		
		If Instr(lcase(Website),"http")=-1 AND Website<>"" Then Website="Http://"&Website
		
		%>
		<%="<ID"&rC&">--"&rs("ID")&"</ID"&rC&">"%>
		<%="<Name"&rC&">--"&cName&"</Name"&rC&">"%>
		<%="<Address"&rC&">--"&rs("Address")&"</Address"&rC&">"%>
		<%="<Address2"&rC&">--"&Address2&"</Address2"&rC&">"%>
		<%="<Phone"&rC&">--"&Phone(rs("Phone1"))&"</Phone"&rC&">"%>
		<%="<Fax"&rC&">--"&Phone(rs("Fax"))&"</Fax"&rC&">"%>
		<%="<Email"&rC&">--"&rs("Email")&"</Email"&rC&">"%>
		<%="<Contact"&rC&">--"&rs("Contact1")&"</Contact"&rC&">"%>
		<%="<CPhone"&rC&">--"&Phone(rs("Cphone1"))&"</CPhone"&rC&">"%>
		<%="<Website"&rC&">--"&rs("website")&"</Website"&rC&">"%>
		<%
		rs.MoveNext 
	Loop
	set rs = nothing	
	
	%><recordCount><%=rC%></recordCount><%
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub ContactEdit  () '--------------------------------------------------------------------------------------------------------
	GlobalID = CStr(Request.QueryString("ID"))
	
	XML_List = "" 
	
	Dim vName, vAddress, vCity, vState, vZip, vPhone1, vPhone2, vFax, vEmail, vContact1, vCphone1, vEmail1
	Dim vContact2, vCphone2, vEmail2, vTax, vMU, vNotes, vWebsite
	Dim vCustomer, vVendor 'as Boolean
	
	SQL = "SELECT * FROM Contacts WHERE ID = "&GlobalID
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	vName = rs("Name")			:	if IsNull(vName) then vName = "--"			:if vName = "" then vName = "--"
	vAddress = rs("Address")	:	if IsNull(vAddress) then vAddress = "--"	:if vAddress = "" then vAddress = "--"
	vCity = rs("City")			:	if IsNull(vCity) then vCity = "--"			:if vCity = "" then vCity = "--"
	vState = rs("State")		:	if IsNull(vState) then vState = "--"		:if vState = "" then vState = "--"
	vZip = rs("Zip")			:	if IsNull(vZip) then vZip = "--"			:if vZip = "" then vZip = "--"
	vPhone1 = rs("Phone1")		:	if IsNull(vPhone1) then vPhone1 = "--"		:if vPhone1 = "" then vPhone1 = "--"
	vPhone2 = rs("Phone2")		:	if IsNull(vPhone2) then vPhone2 = "--"		:if vPhone2 = "" then vPhone2 = "--"
	vFax = rs("Fax")			:	if IsNull(vFax) then vFax = "--"			:if vFax = "" then vFax = "--"
	vEmail = rs("Email")		:	if IsNull(vEmail) then vEmail = "--"		:if vEmail = "" then vEmail = "--"
	vContact1 = rs("Contact1")	:	if IsNull(vContact1) then vContact1 = "--"	:if vContact1 = "" then vContact1 = "--"
	vCphone1 = rs("Cphone1")	:	if IsNull(vCphone1) then vCphone1 = "--"	:if vCphone1 = "" then vCphone1 = "--"
	vEmail1 = rs("Email1")		:	if IsNull(vEmail1) then vEmail1 = "--"		:if vEmail1 = "" then vEmail1 = "--"
	vContact2 = rs("Contact2")	:	if IsNull(vContact2) then vContact2 = "--"	:if vContact2 = "" then vContact2 = "--"
	vCphone2 = rs("Cphone2")	:	if IsNull(vCphone2) then vCphone2 = "--"	:if vCphone2 = "" then vCphone2 = "--"
	vEmail2 = rs("Email2")		:	if IsNull(vEmail2) then vEmail2 = "--"		:if vEmail2 = "" then vEmail2 = "--"
	vTax = rs("Tax")			:	if IsNull(vTax) then vTax = "--"			:if vTax = "" then vTax = "--"
	vMU = rs("MU")				:	if IsNull(vMU) then vMU = "--"				:if vMU = "" then vMU = "--"
	vNotes = rs("Notes")		:	if IsNull(vNotes) then vNotes = "--"		:if vNotes = "" then vNotes = "--"
	vWebsite = rs("Website")	:	if IsNull(vWebsite) then vWebsite = "--"	:if vWebsite = "" then vWebsite = "--"
	vCustomer = rs("Customer")	:	if IsNull(vCustomer) then vCustomer = "False"
	vVendor = rs("Vendor")		:	if IsNull(vVendor) then vVendor = "False"
	
	ctSQL="SELECT * FROM ContactsType WHERE ContactID="&GlobalID
	Set ctRS=Server.CreateObject("AdoDB.RecordSet")
	ctRS.Open ctSQL,REDConnString
	
	ctList=""
	Do Until ctRS.EOF
		If ctList<>"" Then ctList=ctList+","
		ctList=ctList+CStr(ctRS("TypeID"))
		ctRS.MoveNext
	Loop
	
	XML_List = XML_List & "<ID>-CannotBeNull-" &rs("ID") &"</ID>"
	XML_List = XML_List & "<Name>-CannotBeNull-" &EncodeChars(vName) &"</Name>"
	XML_List = XML_List & "<Address>-CannotBeNull-" &EncodeChars(vAddress) &"</Address>"
	XML_List = XML_List & "<City>-CannotBeNull-" &EncodeChars(vCity) &"</City>"
	XML_List = XML_List & "<State>-CannotBeNull-" &vState &"</State>"
	XML_List = XML_List & "<Zip>-CannotBeNull-" &vZip &"</Zip>"
	XML_List = XML_List & "<Phone1>-CannotBeNull-" &vPhone1 &"</Phone1>"
	XML_List = XML_List & "<Phone2>-CannotBeNull-" &vPhone2 &"</Phone2>"
	XML_List = XML_List & "<Fax>-CannotBeNull-" &vFax &"</Fax>"
	XML_List = XML_List & "<Email>-CannotBeNull-" &EncodeChars(vEmail) &"</Email>"
	XML_List = XML_List & "<Contact1>-CannotBeNull-" &EncodeChars(vContact1) &"</Contact1>"
	XML_List = XML_List & "<Cphone1>-CannotBeNull-" &vCphone1&"</Cphone1>"
	XML_List = XML_List & "<Email1>-CannotBeNull-" &EncodeChars(vEmail1) &"</Email1>"
	XML_List = XML_List & "<Contact2>-CannotBeNull-" &EncodeChars(vContact2) &"</Contact2>"
	XML_List = XML_List & "<Cphone2>-CannotBeNull-" &vCphone2 &"</Cphone2>"
	XML_List = XML_List & "<Email2>-CannotBeNull-" &EncodeChars(vEmail2) &"</Email2>"
	XML_List = XML_List & "<Tax>-CannotBeNull-" &vTax &"</Tax>"
	XML_List = XML_List & "<MU>-CannotBeNull-" &vMU &"</MU>"
	XML_List = XML_List & "<Notes>-CannotBeNull-" &EncodeChars(vNotes) &"</Notes>"
	XML_List = XML_List & "<Website>-CannotBeNull-" &EncodeChars(vWebsite) &"</Website>"
	XML_List = XML_List & "<Customer>-CannotBeNull-" &vCustomer &"</Customer>"
	XML_List = XML_List & "<Vendor>-CannotBeNull-" &vVendor &"</Vendor>"
	XML_List = XML_List & "<ctList>-CannotBeNull-" &ctList &"</ctList>"
	
	%><%=XML_List%><%
	set rs = nothing

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub ContactUpdate() 'Updates Contact----------------------------------------------------

	ID = EncodeChars(Request.QueryString("ID"))
	vName = EncodeChars(Request.QueryString("Name"))
	vAddress = EncodeChars(Request.QueryString("Address"))
	vCity = EncodeChars(Request.QueryString("City"))
	vState = EncodeChars(Request.QueryString("State"))
	vZip = EncodeChars(Request.QueryString("Zip"))
	vPhone1 = EncodeChars(Request.QueryString("Phone1"))
	vPhone2 = EncodeChars(Request.QueryString("Phone2"))
	vFax = EncodeChars(Request.QueryString("Fax"))
	vEmail = EncodeChars(Request.QueryString("Email"))
	vContact1 = EncodeChars(Request.QueryString("Contact1"))
	vCphone1 = EncodeChars(Request.QueryString("Cphone1"))
	vEmail1 = EncodeChars(Request.QueryString("Email1"))
	vContact2 = EncodeChars(Request.QueryString("Contact2"))
	vCphone2 = EncodeChars(Request.QueryString("Cphone2"))
	vEmail2 = EncodeChars(Request.QueryString("Email2"))
	vTax = EncodeChars(Request.QueryString("Tax"))
	vMU = EncodeChars(Request.QueryString("MU"))
	vNotes = EncodeChars(Request.QueryString("Notes"))
	vWebsite = EncodeChars(Request.QueryString("Website"))
	vCustomer = EncodeChars(Request.QueryString("Customer"))
	vVendor = EncodeChars(Request.QueryString("Vendor"))
	
	SQL = "UPDATE Contacts SET Name = '"&vName&"'"
	SQL = SQL & ", Address = '"&vAddress&"'"
	SQL = SQL & ", City = '"&vCity&"'"
	SQL = SQL & ", State = '"&vState&"'"
	SQL = SQL & ", Zip = '"&vZip&"'"
	SQL = SQL & ", Phone1 = '"&vPhone1&"'"
	SQL = SQL & ", Phone2 = '"&vPhone2&"'"
	SQL = SQL & ", Fax = '"&vFax&"'"
	SQL = SQL & ", Email = '"&vEmail&"'"
	SQL = SQL & ", Contact1 = '"&vContact1&"'"
	SQL = SQL & ", Cphone1 = '"&vCphone1&"'"
	SQL = SQL & ", Email1 = '"&vEmail1&"'"
	SQL = SQL & ", Contact2 = '"&vContact2&"'"
	SQL = SQL & ", Cphone2 = '"&vCphone2&"'"
	SQL = SQL & ", Email2 = '"&vEmail2&"'"
	SQL = SQL & ", Tax = '"&vTax&"'"
	SQL = SQL & ", MU = '"&vMU&"'"
	SQL = SQL & ", Notes = '"&vNotes&"'"
	SQL = SQL & ", Website = '"&vWebsite&"'"
	SQL = SQL & ", Customer = '"&vCustomer&"'"
	SQL = SQL & ", Vendor = '"&vVendor&"'"
	SQL = SQL & " WHERE ID = "&ID
	%><SQL><%=SQL%></SQL><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	%>
	<ID><%=ID%></ID>
	<Name><%=vName%></Name>
	<Customer><%=vCustomer%></Customer>
	<Vendor><%=vVendor%></Vendor>

	<%

End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub SaveContact() 'Updates the calculation entries from a parts or labor entry----------------------------------------------------

	vName = EncodeChars(Request.QueryString("Name"))
	vAddress = EncodeChars(Request.QueryString("Address"))
	vCity = EncodeChars(Request.QueryString("City"))
	vState = EncodeChars(Request.QueryString("State"))
	vZip = EncodeChars(Request.QueryString("Zip"))
	vPhone1 = EncodeChars(Request.QueryString("Phone1"))
	vPhone2 = EncodeChars(Request.QueryString("Phone2"))
	vFax = EncodeChars(Request.QueryString("Fax"))
	vEmail = EncodeChars(Request.QueryString("Email"))
	vContact1 = EncodeChars(Request.QueryString("Contact1"))
	vCphone1 = EncodeChars(Request.QueryString("Cphone1"))
	vEmail1 = EncodeChars(Request.QueryString("Email1"))
	vContact2 = EncodeChars(Request.QueryString("Contact2"))
	vCphone2 = EncodeChars(Request.QueryString("Cphone2"))
	vEmail2 = EncodeChars(Request.QueryString("Email2"))
	vTax = EncodeChars(Request.QueryString("Tax"))
	vMU = EncodeChars(Request.QueryString("MU"))
	vNotes = EncodeChars(Request.QueryString("Notes"))
	vWebsite = EncodeChars(Request.QueryString("Website"))
	vCustomer = EncodeChars(Request.QueryString("Customer"))
	vVendor = EncodeChars(Request.QueryString("Vendor"))

	
	SQL ="INSERT INTO Contacts (Name, Address, City, State, Zip, Phone1, Phone2, Fax, Email, Contact1, Cphone1, Email1, Contact2, Cphone2, Email2, Tax, MU, Notes, Website, Customer, Vendor)"		
	SQL=SQL&" VALUES ('"&vName&"','"&vAddress&"','"&vCity&"','"&vState&"','"&vZip&"','"&vPhone1&"','"&vPhone2&"','"&vFax&"','"&vEmail&"','"&vContact1 &"','"&vCphone1 &"','"&vEmail1&"','"&vContact2&"','"&vCphone2&"','"&vEmail2&"','"&vTax&"','"&vMU&"','"&vNotes&"','"&vWebsite&"','"&vCustomer&"','"&vVendor&"')"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	%><Name><%=vName%></Name><%
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub SaveNewContact() '----------------------------------------------------

	vName = EncodeChars(Request.QueryString("Name"))
	cKey = newCreationKey()
		
	
	SQL ="INSERT INTO Contacts (Name, cKey)"		
	SQL=SQL&" VALUES ('"&vName&"','"&cKey&"')"
	%><Name><%=vName%></Name><%
	%><cKey><%=cKey%></cKey><%
	%><SQL><%=SQL%></SQL><%
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing
	
	
	SQL="SELECT Id FROM Contacts WHERE cKey='"&cKey&"'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	%><id><%=rs("ID")%></id><%
	set rs = nothing
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub ContactDel() '----------------------------------------------------------------------------------------------------------

	Dim ID
	ID = CStr(Request.QueryString("ID"))

	SQL = "DELETE FROM Contacts WHERE ID = " & ID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	set rs = nothing

	SQL1 = "DELETE FROM ContactContacts WHERE MasterID = "&ID&" OR DetailID="&ID
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
	set rs1 = nothing

	SQL2 = "DELETE FROM ContactsType WHERE ContactID="&ID
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	set rs2 = nothing


	%><ID>Deleted <%=ID%></ID><%
	
End Sub '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Sub oops  () '--------------------------------------------------------------------------------------------------------

response.write "<error>Not Found: "&sAction&"</error>"

End Sub '------------------------------------------------------------------------------------------------------------------------

%>
</root>
