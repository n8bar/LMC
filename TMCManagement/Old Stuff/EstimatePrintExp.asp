<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>Tricom Estimate</title>

<!--#include file="../../TMC/RED.asp" -->

<script type="text/javascript" src="../Modules/rcstri.js"></script>
<script type="text/javascript" src="../Modules/Num2word.js"></script>

<style type="text/css">

html,body{  height:auto;  width: 100%;  margin-top:0px;  margin-bottom:0px; text-align:center;}

.Body{ width:768px; height:auto; background:#FFF; text-align:center;   margin-left:auto; margin-right:auto;}
.PageBody{position:static; width:8.5in; height:Auto; background:#FFF; text-align:center; }
.PrintBody{position:static; width:7in; height:Auto; background:#FFF; text-align:center; }

.Line{position:static;  width:6.8in; height:auto; background:inherit; overflow:hidden; padding:0px 0px 0px 0px;}
.LineL{position:static;  width:6.8in; height:auto; background:inherit; overflow:hidden; padding:0px 0px 0px 0px; text-align:left;}

.LineIndent1-2{position:static;  width:6.3in; height:auto; background:inherit; overflow:hidden; white-space:nowrap; margin-left:.5in;}
.LineIndent1-4{position:static;  width:6.55in; height:auto; background:inherit; overflow:hidden; white-space:nowrap; margin-left:.25in;}


.MultiLine{position:static;  width:6.8in; height:auto; background:inherit;  overflow:hidden; white-space:normal; padding:0px 0px 0px 0px;}
.MultiLine1-2{position:static;  width:6.3in; height:auto; background:inherit;  overflow:hidden; white-space:normal;  margin-left:.5in;}
.MultiLine1-4{position:static;  width:6.55in; height:auto; background:inherit;  overflow:hidden; white-space:normal;  margin-left:.25in;}

.LineSpace1-8{position:static;  width:100%; height:.125in; background:inherit; overflow:hidden; white-space:nowrap; padding:0px 0px 0px 0px;}
.LineSpace1-4{position:static;  width:100%; height:.25in; background:inherit; overflow:hidden; white-space:nowrap; padding:0px 0px 0px 0px;}
.LineSpace1-2{position:static;  width:100%; height:.5in; background:inherit; overflow:hidden; white-space:nowrap; padding:0px 0px 0px 0px;}
.LineSpace3-4{position:static;  width:100%; height:.75in; background:inherit; overflow:hidden; white-space:nowrap; padding:0px 0px 0px 0px;}
.LineBottomBorder{position:static; width:100%; height:.01in; overflow:hidden; white-space:nowrap; border-bottom: .01in solid #000;}

.LetterHeadPic{ width:7in; height:.9in; }

.PageBreak{ position:static; top:9.5in; left:0in; }

.LetterTitle { overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size:16px; font-weight: bold; color:#000; }

.CustomerName{position:static; float:left; overflow:hidden; white-space:nowrap; font-family:Arial,Helvetica,sans-serif; font-size:12px; font-weight:bold; color:#000; }
.CustomerInfo{ position:static; float:left; overflow:hidden; white-space:nowrap;font-family: Arial,Helvetica,sans-serif; font-size: 12px;  font-weight:normal; color:#000; }

.Date{ position:static; float:right; overflow:hidden; white-space:nowrap; font-family:Arial,Helvetica,sans-serif; font-size:12px; font-weight:normal; color:#000; }
.Addressing{ position:static; float:left; overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 12px;  font-weight:normal;  color:#000; }
.TextBody{ position:static; font-family: Arial,Helvetica,sans-serif; font-size: 12px;  font-weight:normal; text-align:left; color:#000; }
.TextBodyIndent{ position:static; white-space:normal; overflow:visible; font-family: Arial,Helvetica,sans-serif; font-size: 10px;  font-weight:normal; text-align:left; color:#000; }
/*.TextBodyIndentPre{ position:static; white-space:pre; font-family: Arial,Helvetica,sans-serif; font-size: 10px;  font-weight:normal; text-align:left; color:#000; }*/
.SystemTitle{ position:static; float:left; overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 12px;  font-weight:bold;  color:#000; }
.SubTitles{ position:static; float:left; overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 11px;  font-weight:normal;  color:#000; }
.Totals{ position:static; float:right; overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 11px;  font-weight:normal;  color:#000; border-bottom: 1px solid #000;}

.WordPrice{position:static; white-space:normal; overflow:visible; font-family:Georgia, "Times New Roman", Times, serif; font-size: 16px;  font-weight:normal; text-align:right; color:#000;}

.SignTop{ position:static; overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 11px;  font-weight:normal;  color:#000;}
.SignLineL{ position:static; width:2in; float:left; border-bottom: .01in solid #000; margin-top:20px; }
.SignLineR{ position:static; width:2in; float:right; border-bottom: .01in solid #000; margin-top:20px; }
.SplitLeft{ position:static; width:3.4in; height:auto; float:left;  text-align:left;}
.SplitRight{ position:static; width:2in; height:auto; float:right;  text-align:left;}
.Signer{ position:static; width:2in; overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 10px;  font-weight:normal;  color:#000; text-align:center; border-top:1px #000 solid;}
.SignerTop{ position:static; width:2in; overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 10px;  font-weight:normal;  color:#000; text-align:left;}

.BidInfoLine{overflow:hidden; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 9px;  font-weight:normal;  color:#000; }
.CompanyInfo{overflow:visible; text-align:center; white-space:nowrap; font-family: Arial,Helvetica,sans-serif; font-size: 12px;  font-weight:normal;  color:#000; }

.PDFFrame{position:relative; top:-50%;}
.PDFBox{position:absolute; top:96px; left:12.5%; width:75%; height:256px; overflow:hidden; background:-webkit-gradient(linear, left top, left bottom, color-stop(0, rgba(202, 223, 178, .5)), color-stop(1, rgba(89, 113, 66, 1))); display:none;"}
.PDFBoxX{position:absolute; top:80px; left:12.5%; width:75%; height:16px; overflow:hidden; background:-webkit-gradient(linear, left top, left bottom, color-stop(1, rgba(202, 223, 178, .5)), color-stop(0, rgba(89, 113, 66, 1))); display:none;" color:#900; cursor:pointer;" }
</style>
 


</head>

<body onload="//Print();">

<%
	Dim ProjID
	Dim MoneyFormat
	Dim LetterHeadSrc
	
	ProjID = CStr(Request.QueryString("ProjID"))
	PartsOrLabor=Request.QueryString("PartsOrLabor")
	
	SQL = "SELECT * FROM Projects WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
%>


<script type="text/javascript">
function Print()
{
	
	function Void(){}
	/*
	if(IEver==0)
	{
		if(navigator.userAgent.indexOf('Firefox')==-1)
		{
			document.body.style.paddingLeft='32px';
			document.body.innerHTML='<br/>It looks like your using Google Chrome, so you\'ll need to use the <a href="http://www.google.com/url?sa=D&q=https%3A%2F%2Fchrome.google.com%2Fextensions%2Fdetail%2Fhehijbfgiekmjfkfjpbkbammjbdenadd">ieTab extension</a>. <br/><br/>';
			document.body.innerHTML+='To do so, make sure its installed and just click the ieTab button';
			document.body.innerHTML+='<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img src="images/ieTab.png" />';
			//document.body.innerHTML+=a(window.location);
			document.body.innerHTML+='<br/><br/><br/><br/>';
			document.body.innerHTML+='<div style=" font-family:Consolas, Arial, sans-serif; font-size:11px; max-width:512px; width:100%; padding-left:10px;">Explanation:<br/> &nbsp; &nbsp; This is simply a temporary workaround for Chrome printing issues.  When Google implements better printing options in Chrome or ChromeFrame, we\'ll skip this step in the printing process.  If you\'d like, you can <a href="http://www.google.com/support/chrome/bin/static.py?page=suggestions.cs"><big><b>vote for this feature!</b></big></a> so Google will know that one more person cares.  I certainly appreciate your patience and apoligize for the inconvenience. Thank you.</div>';
			return false;
		}
	}
	/**/
	window.print();
}

function GeneratePDF()
{	
	document.getElementById('PDFBox').style.display='block';
	document.getElementById('PDFBoxX').style.display='block';
	
	document.getElementById('PrintButton').style.display='block';
	document.getElementById('PrintButton').style.top='0px';
}
</script>

<div id="pdfWindow" style="display:none; width:800px; height:128px; margin-left:auto; margin-right:auto;">

</div>

<div class="Body">

	<div class="PrintBody">
		
		<div class="LetterTitle"><%=DecodeChars(rs("ProjName"))%></div>
		
		<div class="LineSpace1-4"><small>#<%=ProjID%></small></div> 
		
		<div class="LineSpace1-4">Expense List</div> 
		
		<div class="Line">  
			<div class="CustomerName"><%=Customer%></div> 
			<div class="Date"><%=Date%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo"><%=rs("ProjAddress")%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo"><%=rs("ProjCity")%>,&nbsp;<%=rs("ProjState")%>&nbsp;<%=rs("ProjZip")%></div> 
		</div>
		
		
		<div class="LineSpace1-8"></div> 
		
		
		<div class="MultiLine">  
			<div class="TextBody">
				<br />
				<div style="float:left; font-size:16px; border-bottom:1px #000 solid;"> Travel</div>
				<br />
				
				<hr style="margin-bottom:0;" />
				<span class="LineIndent1-4" style="float:left; width:30%; margin:0;">Type</span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">Quantity</span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">Cost Each</span>
				<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">Total Cost</span>
				<br/>
				<hr style="margin-top:0;" />

		<%
			
			SQL1 = "SELECT * FROM Systems WHERE ProjectID = "&ProjID
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			TravelCost=0
			
			Do Until rs1.EOF
				
				If rs1("ExcludeSys") <> "True" Then
					SysID = rs1("SystemID")
					
				%>
				<%
				
					SQL2= "SELECT * FROM Expenses WHERE Type='Travel' AND SysID="&SysID
					set rs2=Server.CreateObject("ADODB.Recordset")
					rs2.Open SQL2, REDconnstring
					
					Do Until rs2.EOF
						
						TCost=(Round(rs2("UnitCost")*100)/100)*rs2("Units")
						UnitType="Units"
						
						SQL3="SELECT * FROM TravelType WHERE Type='"&rs2("SubType")&"'"
						Set rs3= Server.CreateObject("AdoDB.RecordSet")
						rs3.Open SQL3, REDConnString
						UnitType=rs3("Unit")
						Set rs3=Nothing
					%>
						<span class="LineIndent1-4" style="float:left; width:30%; margin:0;"><%=rs2("SubType")%></span>
						<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"><%=rs2("Units")%>&nbsp;<%=UnitType%>s</span>
						<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">$<%=rs2("UnitCost")%></span>
						<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">$<%=TCost%></span>
						<br />
						<br />
					<%
						
						TravelCost=TravelCost+TCost
						
						rs2.MoveNext
					Loop
					Set rs2 = nothing
				End If
					
				rs1.MoveNext 
			Loop
			Set rs1=Nothing
			
			
			
		%>
			<hr/>
			<big>
				<span class="LineIndent1-4" style="float:left; width:30%; margin:0;">Total Travel</span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"></span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"></span>
				<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">$<%=TravelCost%></span>
			</big>
			<br />
			<hr/>
			<hr/>
			<br />




			<br />
			<div style="float:left; font-size:16px; border-bottom:1px #000 solid;">Equipment</div>
			<br />
			
			<hr style="margin-bottom:0;" />
			<span class="LineIndent1-4" style="float:left; width:30%; margin:0;">Type</span>
			<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">Quantity</span>
			<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">Cost Each</span>
			<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">Total Cost</span>
			<br/>
			<hr style="margin-top:0;" />

		<%
			
			SQL1 = "SELECT * FROM Systems WHERE ProjectID = "&ProjID
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			EquipCost=0
			
			Do Until rs1.EOF
				
				If rs1("ExcludeSys") <> "True" Then
					SysID = rs1("SystemID")
					
				%>
				<%
				
					SQL2= "SELECT * FROM Expenses WHERE Type='Equip' AND SysID="&SysID
					set rs2=Server.CreateObject("ADODB.Recordset")
					rs2.Open SQL2, REDconnstring
					
					Do Until rs2.EOF
						
						TCost=(Round(rs2("UnitCost")*100)/100)*rs2("Units")
						UnitType="Units"
						
					%>
						<span class="LineIndent1-4" style="float:left; width:30%; margin:0;"><%=rs2("SubType")%></span>
						<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"><%=rs2("Units")%></span>
						<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">$<%=rs2("UnitCost")%></span>
						<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">$<%=TCost%></span>
						<br />
						<br />
					<%
						
						EquipCost=EquipCost+TCost
						
						rs2.MoveNext
					Loop
					set rs2 = nothing
				End If
					
				rs1.MoveNext 
			Loop
			Set rs1=Nothing
			
			
			
			
		%>
			<hr/>
			<big>
				<span class="LineIndent1-4" style="float:left; width:30%; margin:0;">Total Equipment</span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"></span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"></span>
				<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">$<%=EquipCost%></span>
			</big>
			<br />
			<hr/>
			<hr/>
			<br />





			<br />
			<div style="float:left; font-size:16px; border-bottom:1px #000 solid;">Overhead</div>
			<br />
			
			<hr style="margin-bottom:0;" />
			<span class="LineIndent1-4" style="float:left; width:30%; margin:0;">Type</span>
			<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">Quantity</span>
			<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">Cost Each</span>
			<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">Total Cost</span>
			<br/>
			<hr style="margin-top:0;" />

		<%
			
			SQL1 = "SELECT * FROM Systems WHERE ProjectID = "&ProjID
			set rs1=Server.CreateObject("ADODB.Recordset")
			rs1.Open SQL1, REDconnstring
			
			OHCost=0
			
			Do Until rs1.EOF
				
				If rs1("ExcludeSys") <> "True" Then
					SysID = rs1("SystemID")
					
				%>
				<%
				
					SQL2= "SELECT * FROM Expenses WHERE Type='OH' AND SysID="&SysID
					set rs2=Server.CreateObject("ADODB.Recordset")
					rs2.Open SQL2, REDconnstring
					
					Do Until rs2.EOF
						
						TCost=(Round(rs2("UnitCost")*100)/100)*rs2("Units")
						UnitType="Units"
						
					%>
						<span class="LineIndent1-4" style="float:left; width:30%; margin:0;"><%=rs2("SubType")%></span>
						<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"><%=rs2("Units")%></span>
						<span class="LineIndent1-4" style="float:left; width:20%; margin:0;">$<%=rs2("UnitCost")%></span>
						<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">$<%=TCost%></span>
						<br />
						<br />
					<%
						
						OHCost=OHCost+TCost
						
						rs2.MoveNext
					Loop
					set rs2 = nothing
				End If
					
				rs1.MoveNext 
			Loop
			Set rs1=Nothing
			
			
			
			
		%>
			
			<hr/>
			<big>
				<span class="LineIndent1-4" style="float:left; width:30%; margin:0;">Total Overhead</span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"></span>
				<span class="LineIndent1-4" style="float:left; width:20%; margin:0;"></span>
				<span class="LineIndent1-4" style="float:right; width:20%; margin:0;">$<%=OHCost%></span>
			</big>
			<br />
			<hr/>
			<hr/>
			<br />
			
		<%
		TotalExpenses=TravelCost+EquipCost+OHCost
		%>
			

		<br/>
		<div class="Line">
			<div class="SystemTitle" style="float:left; width:30%; margin:0;"><big><big>Total Expenses</big></big></div>
			<div class="SystemTitle" style="float:left; width:20%; margin:0;"><big></big></div>
			<div class="SystemTitle" style="float:right; width:20%; margin:0;"><big><big>$<%=TotalExpenses%></big></big></div>
		</div>
		<hr style="margin-bottom:0;" />
		<hr style="margin-top:0;" />


<%
	set rs = nothing
	set rs3 = nothing
	set rs4 = nothing
%>

		</div> 
	</div> 

</body>
</html>
