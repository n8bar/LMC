<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	
	<!--#include file="../LMC/RED.asp" -->
	<!--#include file="common.asp" -->
	<%
	SysID = CStr(Request.QueryString("SysID"))
	CustID = CStr(Request.QueryString("CustID"))
	
	sysprojSQL="SELECT ProjectID FROM Systems WHERE SystemID="&SysID
	%><%'=sysprojSQL%><%
	Set sysprojRS=Server.CreateObject("AdoDB.RecordSet")
	sysprojRS.Open sysprojSQL, REDConnString
	If sysprojRS.eof Then
		%>Invalid System identifier "<%=SysID%>"<%
		Response.End()
	Else
		ProjID=sysprojRS("ProjectID")
	End If
	Set sRS=Nothing
	
	F="ProjName, ProjAddress, ProjCity, ProjState, ProjZip, pLHeadID, CustomerID, CustName, RCSPM"
	SQL = "SELECT "&F&" FROM Projects WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring

	projName=DecodeChars(rs("ProjName")	)
	rcsPM=rs("rcspm")
	%>	
	
  <title>Budget for <%=system%> <%=projName%> </title>
  
	<link rel=stylesheet href="Library/CSS_DEFAULTS.css" media=all>
	
	<script type="text/javascript" src="Modules/rcstri.js"></script>
	<script type="text/javascript" src="Modules/Num2word.js"></script>

<script type="text/javascript">
	function onLoad() {
		
		<%pageH=10.5%>
		var pageH=<%=pageH%>;
		
		var spacer=document.getElementsByClassName('nextPage');
		for(s=0;s<spacer.length;s++) {
			var npB=0;
			var npH=0;
			var t=spacer[s].offsetTop;
			
			document.body.innerHTML+='<hr id=np'+s+' class=pageCalc style=" top:.'+s+'in;" />';
			
			while ( t>Gebi('np'+s).offsetTop ) {
				npB++;
				Gebi('np'+s).style.top=(pageH*npB)+'in';
			}
			npH=Gebi('np'+s).offsetTop-t;
			spacer[s].style.height=npH+('px');
			spacer[s].style.lineHeight=((2*npH)-36)+'px';
		}
		
		var h=document.body.offsetHeight;
		document.body.style.height='auto';
		var H=document.body.offsetHeight;
		
		var p=H/h;
		var P=Math.round(p);
		if(P<p) { P++; }
		
		document.body.style.height=(P*h)+'px';
		for(l=0;l<P;l++) {                                             
			document.body.innerHTML+='<hr class=pageBreak style=" top:'+(pageH*l)+'in;" />';
		}
		
		//window.print();
	}
</script>
	
<style>
html{background:#ccc; height:100%; margin:0; overflow:auto; padding:0; text-align:center; width:100%; }
body{background:#fff; border:none; box-sizing:border-box; font-family:Verdana, Geneva, sans-serif; font-size:.15625in; height:<%=pageH%>in; margin:0; margin:.0625in auto .25in auto; overflow:hidden; padding:0; text-align:left; width:8in;}


.pageBreak {border-color:skyblue; display:none; font-size:10px; position:absolute; width:8in; }
.pageCalc {border-color:rgba(192,0,0,0); position:absolute; width:8in; }
.nextPage { float:left; width:100%; height:1px; text-align:center; font-style:italic; }

.bold {font-weight:bold;}
.ul {text-decoration:underline;}

.mL25 {margin-left:.25in;}

.mB0625 {margin-bottom:.0625in;}
.mB125 {margin-bottom:.125in;}

.pR25 {padding-right:.25in;}

.fs3-32 {font-size:.09375in;}
.fs1-8  {font-size:.125in;}
.fs5-32 {font-size:.15625in;}
.fs3-16 {font-size:.1875in;}
.fs11-64 {font-size:.171875in;}
.fs7-32  {font-size:.21875in;}
.fs1-4  {font-size:.25in;}
.fs5-16  {font-size:.3125in;}


@media screen { body{border:.0078125in skyblue outset;} .pageBreak {display:block;} }
</style>

</head>

<body onLoad="onLoad();">
<%

If Customer="" Then
	CustWhere="CustID = "&CustID
	CustID=rs("CustomerID")
	If IsNull(CustID) OR CustID="" Then CustWhere=" Name LIKE '"&rs("CustName")&"'"
	SQL3 = "SELECT Name, Address, City, State, Zip, Phone1, Fax, Contact1 FROM Contacts WHERE "&CustWhere
	%><%'=SQL3&"<br/>"%><%
	set rs3=Server.CreateObject("ADODB.Recordset")
	rs3.Open SQL3, REDconnstring
	If Not rs3.Eof Then Customer=DecodeChars(rs3("Name"))
End If
If Customer="" Then
	SQL5 = "SELECT CustName, Addressing, SignedBy FROM BidTo WHERE ProjID = "&ProjID
	%><%'=SQL5&"<br/>"%><%
	set rs5=Server.CreateObject("ADODB.Recordset")
	rs5.Open SQL5, REDconnstring
	If Not rs5.Eof Then Customer=DecodeChars(rs5("CustName"))
	
	CustWhere=" Name LIKE '"&Customer&"'"
	SQL3 = "SELECT Name, Address, City, State, Zip, Phone1, Fax, Contact1 FROM Contacts WHERE "&CustWhere
	%><%'=SQL3&"<br/>"%><%
	set rs3=Server.CreateObject("ADODB.Recordset")
	rs3.Open SQL3, REDconnstring
	If Not rs3.Eof Then Customer=DecodeChars(rs3("Name"))
End If

SQL2="SELECT Image FROM LetterHeads WHERE HeaderID="&rs("pLHeadID")
set rs2=Server.CreateObject("ADODB.Recordset")
rs2.Open SQL2, REDconnstring

sSQL = "SELECT SystemID, System FROM Systems WHERE SystemID = "&SysID
%><%'=sSQL%><%
set sRS=Server.CreateObject("ADODB.Recordset")
sRS.Open sSQL, REDconnstring

%>
<div style="position:absolute; float:right; text-align:right; width:8in;"><%=Date%>&nbsp;<%'=Time%></div>

<img src="../Images/<%=rs2("Image")%>" width=100% />	
	
<div class="fs5-16 taC w100p bold" >Budget</div>
<div class="fs5-32 taC w100p bold" >for</div>
<div class="fs3-16 taC w100p bold" ><%=DecodeChars(rs("projName"))%></div>
<div class="fs5-32 taC w100p" ><%=DecodeChars(sRS("System"))%></div>
<div class="fs5-32 taC w100p" >&nbsp;</div>
<div class="taC w100p"><hr class=w80p /></div>
<div class="fs5-32 taC w100p" >&nbsp;</div>

<div class="w100p fL" style="height:1.25in;">
	<div class="w50p fL" style="margin-left:10%;">
		<div class="fs5-32 taLP fL"><b>Customer: </b></div><br/>
		<div class="fs5-32 taLP fL"></div><%=Customer%>
		<div class="fs1-8 taLP">
			<%=rs3("Address")%><br/><%=rs3("City")%>,&nbsp;<%=rs3("State")%>&nbsp;<%=rs3("Zip")%><br/>
			Phone: <%=rs3("Phone1")%><br/>Fax: <%=rs3("Fax")%>
		</div>
	</div>
	<div class="w40p fL">
		<div class="fs1-8 taLP">
			<div class="fs5-32 taLP fL w100p"><b>Project: </b></div><br/>
			<div class="fs5-32 taLP fL w100p"><%=DecodeChars(rs("ProjName"))%></div><br/>
			<div class="taLP fL w100p"><%=rs("ProjAddress")%></div><br/> 
			<div class="taLP fL w100p"><%=rs("ProjCity")%>,&nbsp;<%=rs("ProjState")%>&nbsp;<%=rs("ProjZip")%></div><br/>
			
			<div class="fs5-32 taLP fL w100p"><br/>Job #: <font face="Consolas, Courier New, Courier, monospace"><%=ProjID%></font></div>
			</div>
	</div>
</div>

<div class="taC w100p"><hr class=w80p /></div>
<div class="fs5-32 taC w100p" >&nbsp;</div>

<br/><br/><br/>
<br/><br/><br/>

<div class="fL taC w100p" >
	<div class="fs1-4 taC fL w100p">Project Manager</div><br/>
	<span class="fs5-16 taC " style="border-bottom:groove 1px #ccc; white-space:pre;" >        <small><%=rcspm%></small>        </span>
	<div class="fs1-8 taC w100p"></div>
</div>

<br/><br/><br/>
<br/><br/><br/>
<br/><br/><br/>

<div class="fL taC w100p ">
	<div class="fs1-4 taC fL w100p">On-Site Forman</div><br/>
	<span class="fs5-16 taC" style="border-bottom:groove 1px #ccc; white-space:pre; ">                       </span>
	<div class="fs1-8 taC w100p"></div>
</div>


<%	
Session("BudgetSysID")=sRS("SystemID")

%>
<div class=nextPage>Giving our best improves the best we can give.</div>
<!--#include file="SysBudgetReport.asp" -->
<%

sRS.MoveNext

set rs = nothing
set rs2 = nothing
set rs3 = nothing
%>
</body>
</html>