<%
Dim REDconnstring
REDconnstring = "DRIVER={SQL Server};SERVER=172.30.6.18;UID=rcstricom;PWD=watf-771;DATABASE=Tribase"
'REDconnstring = "DRIVER={SQL Server};SERVER=172.30.6.18;UID=sa;PWD=Tri1234;DATABASE=Tribase"
'REDconnstring = "DRIVER={SQL Server};SERVER=172.30.6.18;UID=n8@rnet.local;PWD=7.zionian;DATABASE=Tribase"
'REDconnstring = "DRIVER={SQL Server};SERVER=172.30.6.18;UID=Guest;DATABASE=Tribase"

SQL1 ="SELECT UserName, EmpID, Email, Password, URL, mURL FROM Access WHERE (UserName='n8') AND Password='TmcDev'"
%><SQL1><%=SQL1%></SQL1><%
set rs1=Server.CreateObject("ADODB.Recordset")
rs1.Open SQL1, REDconnstring

%>
