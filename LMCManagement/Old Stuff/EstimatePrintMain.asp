<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>Tricom Estimate</title>

<!--#include file="../../LMC/RED.asp" -->

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

<body onload="Print();">

<!-- <a href="http://www.htm2pdf.co.uk">Save As PDF</a> -->

<!--
<div id="PDFBoxX" align="right" class="PDFBoxX" >
	<div style="float:right; width:16px; cursor:pointer;" onclick="document.getElementById('PDFBox').style.display='none'; document.getElementById('PDFBoxX').style.display='none';">X</div>
</div>
<div id="PDFBox" class="PDFBox">
	<iframe id="PDFFrame" class="PDFFrame" width="100%" height="200%" scrolling="no" frameborder="0" ></iframe>
</div>
-->

<%
'Function DecodeChars(TheString)
'	dim OldString : OldString=""
'	If Not IsNull(TheString) Then
'		while(OldString<>TheString)
'			OldString=TheString
'			TheString=Replace(Replace(Replace(TheString,"--RET--",chr(13)),"-COMMA-",","),"-AMPERSAND-","&")
'		wend
'	End If
'	DecodeChars=TheString
'End Function




	Dim ProjID
	Dim CustID
	Dim MoneyFormat
	Dim LetterHeadSrc
	
	ProjID = CStr(Request.QueryString("ProjID"))
	CustID = CStr(Request.QueryString("CustID"))
	

	

	SQL = "SELECT * FROM Projects WHERE ProjID = "&ProjID
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.Open SQL, REDconnstring
	
	SQL2 = "SELECT * FROM ProjectPrint WHERE ProjectID = "&ProjID
	set rs2=Server.CreateObject("ADODB.Recordset")
	rs2.Open SQL2, REDconnstring
	
	SQL3 = "SELECT * FROM Customers WHERE CustID = "&CustID
	set rs3=Server.CreateObject("ADODB.Recordset")
	rs3.Open SQL3, REDconnstring
	
	Dim Customer: Customer=DecodeChars(rs3("Name"))
	
	
	SQL5 = "SELECT * FROM BidTo WHERE ProjID = "&ProjID&" AND CustID = "&CustID
	set rs5=Server.CreateObject("ADODB.Recordset")
	rs5.Open SQL5, REDconnstring



%>


<script type="text/javascript">
function Print()
{
	//document.getElementById('PrintButton').style.display='none';

/*
	if(IEver==7)
	{
		document.body.innerHTML='Please Upgrade to Internet Explorer 8.';
		document.body.innerHTML+='<br/>If you have already, you need to turn off compatibility mode.';
		document.body.innerHTML+='(Click the little broken paper up by the refresh button.)<img src="images/ie8c.jpg"/>';
		document.body.innerHTML+='<br/> apoligize for any inconvenience.';
		return false;
	}
/**/
	
	function Void(){}

	if(IEver==0)
	{
		if(navigator.userAgent.indexOf('Firefox')==-1)
		{
			/** /
			document.body.style.paddingLeft='32px';
			document.body.innerHTML='<br/>It looks like your using Google Chrome, so you\'ll need to use the <a href="http://www.google.com/url?sa=D&q=https%3A%2F%2Fchrome.google.com%2Fextensions%2Fdetail%2Fhehijbfgiekmjfkfjpbkbammjbdenadd">ieTab extension</a>. <br/><br/>';
			document.body.innerHTML+='To do so, make sure its installed and just click the ieTab button';
			document.body.innerHTML+='<br/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img src="images/ieTab.png" />';
			//document.body.innerHTML+=a(window.location);
			document.body.innerHTML+='<br/><br/><br/><br/>';
			document.body.innerHTML+='<div style=" font-family:Consolas, Arial, sans-serif; font-size:11px; max-width:512px; width:100%; padding-left:10px;">Explanation:<br/> &nbsp; &nbsp; This is simply a temporary workaround for Chrome printing issues.  When Google implements better printing options in Chrome or ChromeFrame, we\'ll skip this step in the printing process.  If you\'d like, you can <a href="http://www.google.com/support/chrome/bin/static.py?page=suggestions.cs"><big><b>vote for this feature!</b></big></a> so Google will know that one more person cares.  I certainly appreciate your patience and apoligize for the inconvenience. Thank you.</div>';
			return false;
			/**/
		}
		else
		{
			//alert('Hey Firefox!');
		}
	}
	
	window.print();
	/*	
	var URL=toString(window.location);
	alert(URL);
	URL=URL.replace('?','%3F').replace('=','%3D').replace('=','%3D').replace(/&/g,'%26');
	alert(URL);
	
	window.location='http://www.web2pdfconvert.com/convert.aspx?cURL=https://www.rcstri.com/website/tmcdevelopment/EstimatePrintMain.asp%3FProjID%3D<%'=ProjID%>%26CustID%3D<%'=CustID%>&outputmode=link&allowactivex=no&ref=form';
	
	*/
	/*
	document.getElementById('PDFFrame').src='http://www.web2pdfconvert.com/convert.aspx?cURL=https://www.rcstri.com/website/tmcdevelopment/EstimatePrintMain.asp%3FProjID%3D<%'=ProjID%>%26CustID%3D<%'=CustID%>&outputmode=link&allowactivex=no&ref=form'
	setTimeout('GeneratePDF();',10000);
	*/
}

function GeneratePDF()
{	
	document.getElementById('PDFBox').style.display='block';
	document.getElementById('PDFBoxX').style.display='block';
	
	document.getElementById('PrintButton').style.display='block';
	document.getElementById('PrintButton').style.top='0px';
}
</script>
<!--
<button id="PrintButton" onclick="Print();">Print</button>
-->
<div id="pdfWindow" style="display:none; width:800px; height:128px; margin-left:auto; margin-right:auto;">

</div>

<div class="Body">
  <!--<div class="PageBreak"><hr/></div>-->

	<div class="PrintBody">
		
		
		<%
			LetterHeadSrc = "Images/LetterHead-TFP-TCS.jpg"
			if rs2("TFP") = "True" then LetterHeadSrc = "Images/LetterHead-TFP.jpg"
			if rs2("TCS") = "True" then LetterHeadSrc = "Images/LetterHead-TCS.jpg"
			
			dim Body: Body = DecodeChars(rs2("Body"))
		%>
		<img src="<%=LetterHeadSrc%>" class="LetterHeadPic" />
		
		
		<div class="LetterTitle"><%=DecodeChars(rs2("LetterTitle"))%></div>
		
		<div class="LineSpace1-4"></div> 
		
		<div class="Line">  
			<div class="CustomerName"><%=Customer%></div> 
			<div class="Date"><%=rs2("PrintDate")%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo"><%=rs3("Address")%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo"><%=rs3("City")%>,&nbsp;<%=rs3("State")%>&nbsp;<%=rs3("Zip")%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo">Phone: <%=rs3("Phone1")%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo">Fax: <%=rs3("Fax")%></div> 
		</div>
		
		
		<div class="LineSpace1-8"></div> 
		
		
		<div class="Line">  
			<div class="CustomerName">Re:&nbsp;<%=DecodeChars(rs("ProjName"))%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo"><%=rs("ProjAddress")%></div> 
		</div>
		<div class="Line">  
			<div class="CustomerInfo"><%=rs("ProjCity")%>,&nbsp;<%=rs("ProjState")%>&nbsp;<%=rs("ProjZip")%></div> 
		</div>
		
		<div class="LineSpace1-8"></div>
		
		<div class="Line">  
			<div class="Addressing"><%=rs5("Contact")%>&#44;</div> 
		</div>
		
		<div class="MultiLine">  
			<div class="TextBody">&nbsp; &nbsp; <%=Body%></div> 
		</div>
		
		
		<div class="LineSpace1-4"></div>
		
		<%
			
			SQL4 = "SELECT * FROM Systems WHERE ProjectID = "&ProjID'&" AND PrintChecked = 1 "
			set rs4=Server.CreateObject("ADODB.Recordset")
			rs4.Open SQL4, REDconnstring
			
			Dim SysID
			Dim PrintChecked
			Dim SysSystem 	
			Dim SysNotes 		
			Dim SysIncludes  
			Dim SysExcludes 
			Dim SysSalesTax
			Dim SysTaxRate
			Dim TotalTax
			Dim SysTotal
			Dim SubTotal
			Dim TotalsTotal
			
			Dim Parts
			Dim Travel
			Dim Equipment
			Dim Expenses
			Dim FixedPrice
			Dim Overhead
			
			Do While Not rs4.EOF
				
				SysID = rs4("SystemID")
				PrintChecked = rs4("PrintChecked")
				'RoundUp=rs4("Round")
				
				
				Dim ProfitDollars
				Dim OverheadCost
				
				If PrintChecked = "True" then
					SysSystem = rs4("System")
					
					
					Dim itemCost
					Dim itemQty
					Parts=0
					Labor=0
					SQL6="Select * From BidItems WHERE SysID = "&SysID
					set rs6=Server.CreateObject("ADODB.Recordset")
					rs6.Open SQL6, REDconnstring
					
					Do Until rs6.EOF
						
						itemCost=rs6("Cost")
						itemQty=rs6("Qty")
						
						Select Case rs6("Type")
							Case "Part"
								Parts=Parts+(itemCost*itemQty)

							Case "Labor"
								Labor=Labor+(itemCost*itemQty)
						
						End Select
						
						rs6.MoveNext
					Loop
					
					Set rs6=Nothing
					
					Equipment=0
					Travel=0
					SQL7="Select * From Expenses WHERE SysID = "&SysID
					set rs7=Server.CreateObject("ADODB.Recordset")
					rs7.Open SQL7, REDconnstring
					
					Do Until rs7.EOF
						
						itemCost=rs7("UnitCost")
						itemQty=rs7("Units")
						
						Select Case rs7("Type")
							Case "Equip"
								Equipment=Equipment+(itemCost*itemQty)

							Case "Travel"
								Travel=Travel+(itemCost*itemQty)
						
						End Select
						
						rs7.MoveNext
					Loop
					
					Set rs7=Nothing
					
					if Parts = "" or (IsNull(Parts)) then Parts = 0
					if Labor = "" or (IsNull(Labor)) then Labor = 0
					if Travel = "" or (IsNull(Travel)) then Travel = 0
					if Equipment = "" or (IsNull(Equipment)) then Equipment = 0
					Expenses=Travel+Equipment
					
					
					
					
					
					SysTaxRate = rs4("TaxRate") : if SysTaxRate = "" or (IsNull(SysTaxRate)) then SysTaxRate = 0
					SysSalesTax = (SysTaxRate*Parts)/100
					FixedPrice="0"&rs4("FixedPrice")
					Overhead="0"&rs4("Overhead")
					Profit="0"&rs4("MU")
					
					TotalFixed=rs4("TotalFixed")
					
					%>
					
					<div style="display:none; white-space:pre; color:silver; font-size:10px; font-family:Consolas, 'Courier New', Courier, monospace;">
						SysSystem: <%=SysSystem%>
						Parts: <%=Parts%>
						Labor: <%=Labor%>
						Travel: <%=Travel%>
						Equipment: <%=Equipment%>
						Expenses: <%=Expenses%>
						Overhead: <%=Overhead%>
						Profit: <%=Profit%>
						FixedPrice: <%=FixedPrice%>
						SysTaxRate: <%=SysTaxRate%>
						SysSalesTax: <%=SysSalesTax%>
					</div>

					<%
					If TotalFixed="True" Then

						SysTotal=(FixedPrice*1)+(SysSalesTax*1)
						OverheadCost=(Overhead*FixedPrice)/100
						
					
						ProfitDollars=FixedPrice-OverheadCost-Expenses-Parts-Labor
						
						ProfitDollars=(ProfitDollars*100)/100

					Else 'TotalFixed=false
						
					
						FixedPrice=Parts+Labor+Expenses
						OverheadCost=Round(Overhead*FixedPrice)/100
						SysTotal=FixedPrice+OverheadCost
						ProfitDollars=(Profit*SysTotal)/100
						SysTotal=SysTotal+SysSalesTax
						
						If rs4("Round")="True" Then
							withProfit=SysTotal+ProfitDollars
							roundUp10= (Round(withProfit/10)*10)+10
							roundDiff= roundUp10-withProfit
							ProfitDollars=ProfitDollars+roundDiff
						End If
						
						'response.write("<br/>withProfit:"&withProfit)
						'response.write("<br/>roundUp10:"&roundUp10)
						'response.write("<br/>roundDiff:"&roundDiff)
						'response.write("<br/>ProfitDollars:"&ProfitDollars)
						
						SysTotal=SysTotal+ProfitDollars
						
						FixedPrice=SysTotal
						
					End If
					
					
					If rs2("Tax")="True" Then SysTotal=SysTotal - SysSalesTax
					
					'% ><script type="text/javascript">alert('<%=SysTotal% >');< /script><%
					MoneyFormat = SysTotal-SysSalesTax
					MoneyFormat = FormatCurrency(MoneyFormat,2)
					
					
					SysNotes = rs4("Notes")
					if not IsNull(SysNotes) then 
						SysNotes = Replace(SysNotes, "--RET--", "<br/>")
						'SysNotes = Replace(SysNotes, "-COMMA-", ",")
						'SysNotes = Replace(SysNotes, "-AMPERSAND-", "&")
					end if
					SysNotes=DecodeChars(SysNotes)

					SysIncludes = rs4("Includes")
					if not IsNull(SysIncludes) then
						SysIncludes = Replace(SysIncludes, "--RET--", "<br/>")
						'SysIncludes = Replace(SysIncludes, "-COMMA-", ",")
						'SysIncludes = Replace(SysIncludes, "-AMPERSAND-", "&")
					End if
					SysIncludes=DecodeChars(SysIncludes)

					SysExcludes = rs4("Excludes")
					If not IsNull(SysExcludes) then
						SysExcludes = Replace(SysExcludes, "--RET--", "<br/>")
						'SysExcludes = Replace(SysExcludes, "-COMMA-", ",")
						'SysExcludes = Replace(SysExcludes, "-AMPERSAND-", "&")
					End If
					SysExcludes=DecodeChars(SysExcludes)

		%>
		
					<div class="Line">
						<div class="SystemTitle"><%=SysSystem%></div>
					</div> 
					
		<%			If rs2("Notes") = "True" Then 
		%>
						<div class="LineIndent1-4">
							<div class="SubTitles">Scope Of Work:</div>
						</div> 
						<div class="MultiLine1-2">
							<div class="TextBodyIndent"><%=SysNotes%></div>
						</div> 
		<%			End If 
					

					If rs2("Includes") = "True" Then 
		%>
						<div class="LineIndent1-4">
							<div class="SubTitles">Includes:</div>
						</div> 
						<div class="MultiLine1-2">
							<div class="TextBodyIndent"><%=SysIncludes%></div>
						</div> 
		<%			End If 
					

					If rs2("Excludes") = "True" Then 
		%>
						<div class="LineIndent1-4">
							<div class="SubTitles">Excludes:</div>
						</div> 
						<div class="MultiLine1-2">
							<div class="TextBodyIndent"><%=SysExcludes%></div>
						</div> 
		<%			End If 

					Dim AltSQL, AltRS
					AltSQL="SELECT * FROM SysAlt WHERE SysID="&SysID&" AND (Exclude Is Null Or Exclude='False')"
					Set AltRS=Server.CreateObject("AdoDB.RecordSet")
					AltRS.Open AltSQL, REDConnString

					If Not AltRS.EOF Then
			%>		
						<br />
						<br />
	
						<div class="Line">
							<div class="SystemTitle">Add Alts:</div>
						</div> 
			<%
					End If
					
					Do Until AltRS.EOF
						MoreOrLess="more"
						style="style=""color:black;"""
						
						If AltRS("Price")<0.01 Then MoreOrLess="less": style="style=""color:green;""" : End If
		%>
						<br />
						<div class="LineIndent1-4">
							<div class="SubTitles">Initial:_____ <%=AltRS("Description")%><span <%=style%>> &nbsp;$<%=Replace(AltRS("Price"),"-","")&" "&MoreOrLess%></span></div>
						</div> 
						<div class="MultiLine1-2">
							<div class="TextBodyIndent"> &nbsp; &nbsp; &nbsp;<%=AltRS("Details")%></div>
						</div>
						<br />
		<%			
					
						AltRS.MoveNext
					Loop
					
					
					

					SubTotal = SubTotal + SysTotal
					If rs2("SystemTotals") = "True" Then 
						
		%>
                        <div class="LineSpace1-8"></div>
                        <div class="Line">
                            <div class="Totals">Total For: <%=SysSystem%> &nbsp; &nbsp; <%=FormatCurrency(SysTotal,2)%></div>
                        </div>
                        <div class="LineSpace1-8"></div>
		<%			End If 

				if rs2("Tax")="True" Then TotalTax = TotalTax+SysSalesTax
					
				End If
		
				rs4.MoveNext 
			Loop



				If rs2("Subtotal") = "True" Then 
		%>
				<div class="LineSpace1-8"></div>
				<div class="Line">
					<div class="Totals">Subtotal: <%=FormatCurrency(SubTotal,2)%> </div>
				</div>
		<%		End If
		
		
			
			If rs2("Tax")="True" Then 
		%>
				<div class="Line">
					<div class="Totals">Sales Tax @<%=SysTaxRate%>%: &nbsp; &nbsp; <%=FormatCurrency(TotalTax)%></div>
				</div>
				
				<div class="LineSpace1-8"></div>
		<%
				'TotalsTotal = TotalsTotal*(1+(SysSalesTax/100))
			End If


			If rs2("Total") = "True" Then 
			TotalsTotal=Round((SubTotal+TotalTax)*100)/100
			
		%>
				<div class="Line">
					<div class="Totals"><big><b>Total: </b><%=FormatCurrency(TotalsTotal,2)%></big></div>
				</div>
				<div class="Line">
					<div id="WordPrice" class="WordPrice"></div>
					<script type="text/javascript">
						var Price = '<%=Round(TotalsTotal*100)/100%>';
						Price=Price.split('.');
						var Dollars= Num2Word(Price[0]);
						var Cents=Num2Word(Price[1]*1);
						Gebi('WordPrice').innerHTML=Dollars+' dollars and '+Cents+' cents';
					</script>
				</div>
		<%End If 
			 		
			Set rs4 = Nothing
		%>  
		
		<div class="LineBottomBorder"></div>  
		
		<div class="MultiLine1-2">
		<div class="TextBodyIndent">&nbsp; &nbsp; This Bid is good for up to 45 days from the date shown herein. All bids accepted after this period are subject to a price increase due to the vastly fluctuating metals market and our systems dependency on wire and cable. We specifically exclude any and all material or labor not specifically included in this proposal. The acceptance of this proposal by a signature from the Customer or Customers representative constitutes a legally binding contract between the Customer and RCS Tricom for the goods and services described herein and the Customer agrees to the total price as listed herein for these goods and services.</div>
		</div> 
		
		<div class="LineSpace1-8"></div>     
		
		<div class="LineL">
		<div class="SignTop">The undersigned parties herby acknowledge the acceptance of the above detailed Proposal: </div>
		</div>   
		
		<div class="LineSpace1-8"></div>
		
		<div class="Line">  
		
		<div class="SplitLeft">
		<div class="SignerTop">Tricom Representative</div>
		<div class="LineSpace1-4"></div>
		<div class="SignLineL"></div>
		<div class="Signer"><%=rs2("SignedTCS")%></div>
		</div>
		
		<div class="SplitRight">
		<div class="SignerTop"><%=Customer%> Representative</div>
		<div class="LineSpace1-4"></div>
		<div class="SignLineR"></div>
		<div class="Signer"><%=rs2("SignedCust")%></div>
		</div>
		
		</div>
		
		
		
		
		<div class="Line">  
		<div class="BidInfoLine">Re:&nbsp;<%=DecodeChars(rs3("Name"))%>,&nbsp;<%=DecodeChars(rs("ProjName"))%>&nbsp;Bid# <%=rs("ProjID")%></div>    
		</div>
		<div class="LineBottomBorder"></div>
	
		<div class="Line" align="center" style="overflow:visible; text-align:center; width:100%;">  
			<div class="CompanyInfo">3540W Sahara Ave, Las Vegas NV 89102 &nbsp; Ph:702-383-2800&nbsp; Fax:702-531-6709</div>
			<div id="FooterContainer"></div>
			<script type="text/javascript">
				Gebi('FooterContainer').innerHTML=CharsDecode('<%=rs2("LicenseFooterHTML")%>');
			</script>      
		
		</div>
		
	</div>
</div>
		
		



<%
	set rs = nothing
	set rs2 = nothing
	set rs3 = nothing

%>

</body>
</html>
