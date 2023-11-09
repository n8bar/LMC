<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Project Schedule</title>

<!-- <script type="text/javascript" src="jQuery.js"></script> -->
<!-- <script type="text/javascript" src="gears_init.js"></script> -->
<script type="text/javascript" src="../Modules/rcstri.js"></script>
<!-- script type="text/javascript" src="https://wave-api.appspot.com/public/embed.js"></script> 
<script type="text/javascript" src="Library/WaveEmbed.js"></script>  -->
<!-- #include file="../../LMC/RED.asp" -->

<%
	Dim ProjID:
	ProjID= Request.QueryString("ProjID")
	
	If ProjID = "" or (isNull(ProjID)) then ProjID=8702
%>
<script type="text/javascript">
var ProjID=<%=ProjID%>; //Copy the ASP ProjID to a JS ProjID
</script>

<style>
html{text-align:center;}
body{background:none; height:100%; text-align:center; width:800px; max-width:800px; }

.L1{font-family:Georgia, "Times New Roman", Times, serif; font-size:19px; padding-left:16px; padding-top:8px;}
.L2{font-family:Georgia, "Times New Roman", Times, serif; font-size:16px; padding-left:32px; padding-top:16px;}
.L3{font-family:Georgia, "Times New Roman", Times, serif; font-size:14px; padding-left:48px; padding-top:24px;}
.Status{font-family:Consolas, "Courier New", Courier, monospace;}
</style>

</head>

<body>
<%
	SQL="SELECT * FROM Projects WHERE ProjID="&ProjID
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.Open SQL, REDConnString

	SQL1 = "SELECT * FROM Progress"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.Open SQL1, REDconnstring
		
	Dim ProgID
	Dim BGColor
	Dim AltBGColor
	Dim BGText
	Dim Text
	Dim MOTextColor
	Dim MOutTextColor
	
	Dim PrCount
	
	Dim ProgArr(16)
		
	PrCount = 0
	
	Do While Not rs1.EOF
		PrCount=PrCount+1
		
		ProgID= rs1("ProgID")
		BGColor = rs1("BGColor")
		AltBGColor= rs1("AltBGColor")
		BGText= rs1("BGText")
		Text= rs1("Text")
		MOTextColor= rs1("MOTextColor")
		MOutTextColor= rs1("MOutTextColor")
		
		ProgArr(PrCount) = array(ProgID,BGColor,AltBGColor,BGText,Text,MOutTextColor)

		rs1.MoveNext
	Loop		
	set rs1=nothing
	
	Dim Overall: Overall=ProgArr(CInt(rs("JobCompleted")))(4)
	Dim Eng: Eng=ProgArr(CInt(rs("Plans")))(4)
	Dim EngOrig: EngOrig=ProgArr(CInt(rs("PlansOrig")))(4)
	Dim EngDraw: EngDraw=ProgArr(CInt(rs("PlansDraw")))(4)
	Dim EngPlot: EngPlot=ProgArr(CInt(rs("PlansPlot")))(4)
	Dim EngReview: EngReview=ProgArr(CInt(rs("PlansReview")))(4)
	Dim EngSubmit: EngSubmit=ProgArr(CInt(rs("PlansSubmit")))(4)
	Dim EngApproved: EngApproved=ProgArr(CInt(rs("PlansApproved")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
'	Dim : =ProgArr(CInt(rs("")))(4)
%>

<h1><%=rs("ProjName")%></h1>
<h2>Progress report <small>as of</small> <%=Date%></h2>
<hr/>
<div style="width:100%; text-align:left;">
	<div class="L1">Overall Job Status: <span class="Status"><%=OverAll%></span></div>
		<div class="L2">Engineering Status: <span class="Status"><%=Eng%></span></div>
			<div class="L3">Obtain Originals: <span class="Status"><%=EngOrig%></span></div>
			<div class="L3">Draw Plans: <span class="Status"><%=EngDraw%></span></div>
			<div class="L3">Plot: <span class="Status"><%=EngPlot%></span></div>
			<div class="L3">Review: <span class="Status"><%=EngReview%></span></div>
			<div class="L3">Submit: <span class="Status"><%=EngSubmit%></span></div>
			<div class="L3">Approved: <span class="Status"><%=EngApproved%></span></div>
</div>
<%


	Set rs= Nothing
%>
<hr/>
</body>
</html>
