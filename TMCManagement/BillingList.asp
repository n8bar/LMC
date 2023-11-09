<%@LANGUAGE=VBSCRIPT CODEPAGE=65001 %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- #include file="../LMC/RED.asp" -->
<!-- #include file="Common.ASP" -->

<%
jsLink=Request.QueryString("jsLink")
Condense=(Request.QueryString("condense")=1)
CHeading=Request.QueryString("CHeading")

Set rs=Nothing

mW=783
If Condense Then mW=0
%>

<link rel=stylesheet href="Library/ListsCommon.css" media=all >

<style media="all">
	html {width:100%; height:100%; margin:0;}
	body {width:100%; height:100%; margin:0; }
	
	#scrollbarCover { position:absolute; top:37px; right:19px; width:18px; height:24px; background:white; border-left:1px solid #999; z-index:30000; display:none; }
	
	#ItemsHead { position:relative; top:5px; -webkit-overflow-y:scroll; }
	#ItemsHead div { float:left; overflow:hidden; white-space:nowrap; height:100%; min-height:18px; text-align:center; border-left:1px solid #888; border-right:1px solid #fff; text-overflow:ellipsis;}
	.HeadCheck { overflow:visible; width:4%; }
	.HeadNum { overflow:visible; width:4%; font-size:10px; }
	.HeadAttn { width:8%; }
	.HeadCat { width:8%; }
	.HeadTitle { width:22%; }
	.HeadNotes { width:30%; }
	.HeadProg { width:4%; }
	.HeadDates { width:8%; padding:0;}
	#ItemsHead div:first-child{ border-left:none; }
	#ItemsHead div:last-child{ border-right:none; }
	
	#Rows {width:100%; height:90%; overflow-x:hidden; overflow-y:scroll;}
	.RowContainer { height:32px; line-height:32px; background-color:#<%=DoneColor%>; color:#<%=TextColor%>; min-width:<%=mW%>px !important; }
	.RowContainer:hover { background-color:#<%=BkgColor%>; }
	.RowContainer div, .RowContainer label {float:left; overflow:hidden; height:100%; white-space:nowrap; text-align:center; border-left:1px solid rgba(0,0,0,.25); border-right:1px solid rgba(255,255,255,.25);  text-overflow:ellipsis;}	
	.eCheck { width:4%; }
	.eCalID { width:4%; font-size:10px; }
	.eAttn { width:8%; font-size:12px; }
	.eCat { width:8%; font-size:14px; }
	.eTitle { width:22%; }
	.eNote { width:30%; white-space:normal; font-size:12px; line-height:10px; text-align:left !important; }
	.eDone { width:4%; }
	.eDates { width:8%; }
</style>
<%

sText=Session("eventListText"&TaskID)
sAttn=Session("eventListAttn"&TaskID)
sAttnID=Session("eventListAttnID"&TaskID) : If sAttnID="" Then sAttnID=0
sAttnID=CInt(AttnID)
sFrom=(Session("eventListFrom"&TaskID))
sTo=(Session("eventListTo"&TaskID))
sFromDate=CDate(sFrom)
sToDate=CDate(sTo)

%>
<title><%=TaskName%> Event List Detail</title>
<script type="text/javascript">
	function unBillEvent(row) {
		if (confirm('Marking not billable!')) {
			WSQL('UPDATE Calendar SET Billable=0 WHERE CalID='+Gebi('eCalID'+row).innerHTML);
			Gebi('Rows').removeChild(Gebi('RowContainer'+row));
		}
	}
	function Resize() {
		if(!!Gebi('RowContainer1')) 
			Gebi('ItemsHead').style.width=Gebi('RowContainer1').offsetWidth+('px');
	}
	var Condense=('<%=Condense%>'=='1');
</script>

</head>

<body onResize="Resize();">

<div id=scrollbarCover></div>

<div id=Top style="font-weight:normal; font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif; "><%If Condense Then %><%=CHeading%><% End If%></div>	
<span id="ItemsHead" style="margin:0; display:inline-block; font-size:12px;" >        	
	<%
	If Condense Then
		%>
		<div class=HeadTitle style="width:90%; font-size:14px; font-family:Verdana, Arial, Helvetica, sans-serif;" >Task Name</div>
		<div class=HeadProg style=width:10%; >√</div>
		<%
	Else
		%>
		<div class=HeadCheck ><font color="#900" style="font-weight:bold;">─</font></div>
		<div class=HeadNum >Task#</div >
		<div class=HeadAttn >Attention</div >
		<div class=HeadCat >Category</div>
		<div class=HeadTitle >Task</div>
		<div class=HeadNotes >Notes</div >
		<div class=HeadProg >√Done</div>
		<div class=HeadProg >√Billed</div>
		<div class=HeadDates >Start Date</div >
		<div class=HeadDates >End Date</div >
		<%
	End If
	%>
</span>

<%
Where=""
If sText<>"" THEN Where=" ( Title LIKE '%"&sText&"%' OR Note LIKE '%"&sText&"%' ) "
If sAttn<>"" And (sAttnID=0) THEN 
	If Where<>""Then Where=Where&" AND "
	Where=Where&" ( Attention LIKE '%"&sAttn&"%' OR AttentionID=0"&sAttnID&" ) "
End If
If sFrom<>"" THEN 
	If Where<>""Then Where=Where&" AND "
	Where=Where&" DateTo > '"&sFrom&"' "
End If
If sTo<>"" THEN 
	If Where<>""Then Where=Where&" AND "
	Where=Where&" DateFrom < '"&sTo&"' "
End If
If TaskID<>0 THEN 
	If Where<>""Then Where=Where&" AND "
	Where=Where&" TaskID= "&TaskID&" "
End If
If Condense THEN 
	If Where<>""Then Where=Where&" AND "
	Where=Where&" (NOT (Billed=1)) "
End If

If Where<>""Then Where=Where&" AND "
Where=Where&" (Billable=1) "

If Where<>"" Then Where=" WHERE "&Where%><%'=Where%><%
Order="ORDER BY Done, Billed, DateFrom, DateTo, Attention, AttentionID"
SQL="SELECT CalID, Title, Note, Billed, Done, DateFrom, DateTo, Attention, AttentionID, TaskID FROM Calendar "&Where&" "&Order
%><%'=SQL%><%
Set rs=Server.CreateObject("AdoDB.RecordSet")
rs.Open SQL, REDConnString
i=0
EmptyRecordSet= rs.EOF 
%><div id=Rows><%
Do Until rs.EOF
	i=i+1
	
	SQL2="SELECT BgColor, AltName FROM Tasks WHERE TaskID="&rs("TaskID")
	Set rs2=Server.CreateObject("AdoDB.RecordSet")
	rs2.Open SQL2, REDConnString
	Color="FFF"
	If Not rs2.EOF Then 
		Color=rs2("BgColor")
		TaskName=rs2("AltName")
	End If
	Set rs2=Nothing	
	
	ID=rs("CalID")
	
	Attn=rs("Attention")
	If Attn="" Then
		If rs("AttentionID")="" Or IsNull( rs("AttentionID")) Then
			Attn="Unknown"
		Else
			SQL1="SELECT FName+' '+LName AS Name FROM Employees WHERE EmpID="& rs("AttentionID")
			Set rs1=Server.CreateObject("AdoDB.RecordSet")
			rs1.Open SQL1, REDConnString
			If Not rs1.EOF Then Attn = rs1("Name") Else Attn="Unknown"
			Set rs1=Nothing
		End If
	End If		
	
	Title=DecodeChars(rs("Title"))
	
	Note=DecodeChars(rs("Note"))
	
	If rs("Done")="True" then 
		dCheck="checked" 
	Else 
		dCheck=""
	End If		
	If rs("Billed")="True" then 
		bCheck="checked" 
	Else 
		bCheck=""
	End If		
	
	dF=rs("DateFrom")
	dT=rs("DateTo")
	
	o=".3" : If bCheck="" Then o="1"
	%>
	<div id="RowContainer<%=i%>" class=RowContainer style="margin-left:0; min-width:0<%=mW%>px; opacity:<%=o%>; background-color:#<%=Color%>;" >
		<% 

		If Condense Then
			style=" style=""width:90%; text-align:left; overflow:hidden; white-space:nowrap; text-overflow:ellipsis; background-color:#"&Color&""" "
			%>
			<div id=eTitle<%=i%> class=eTitle title="<%=dF&" - "&dT%>" <%=style%> >
				<a href="javascript:parent.<%=jsLink%>(<%=ID%>);" style="float:left;"><%=Title%></a>
				<div style="float:right; border:none;"><%=dF%></div>
			</div>
			<label id=eDone<%=i%> class=eDone style="width:10%; background-color:#<%=Color%>;" >
				<input id=eDoneChk<%=i%> type=checkbox <%=dCheck%> onChange="WSQLUBit('Calendar','Done',this.checked,'CalID','<%=ID%>');" />
			</label>
			<%
		Else		
			%>		
			<label id=eDel<%=i%> class=eCheck >
				<button id=eDel<%=i%> class=ToolbarButton onClick="unBillEvent(<%=i%>);" style="padding:2px;" title="Mark Not Billable"><img src="../Images/minus_16.PNG" /></button>
			</label>
			<div id=eCalID<%=i%> class=eCalID title="<%=ID%>" ><%=ID%></div>
			<div id=eAttn<%=i%> class=eAttn title="<%=Attn%>" ><%=Attn%></div>
			<div id=eCat<%=i%> class=eCat title="<%=TaskName%>" ><%=TaskName%></div>
			<div id=eTitle<%=i%> class=eTitle title="<%=Title%>" ><%=Title%></div>
			<div id=eNote<%=i%> class=eNote title="<%=Note%>" ><%=Note%></div>
			<label id=eDone<%=i%> class=eDone >
				<input id=eDoneChk<%=i%> type=checkbox <%=dCheck%> onChange="WSQLUBit('Calendar','Done',this.checked,'CalID','<%=ID%>');" />
			</label>
			<label id=eBilled<%=i%> class=eDone >
				<input id=eBilledChk<%=i%> type=checkbox <%=bCheck%> onChange="WSQLUBit('Calendar','Billed',this.checked,'CalID','<%=ID%>');" />
			</label>
			<div id=eFrom<%=i%> class=eDates title="<%=rs("DateFrom")%>"><%=rs("DateFrom")%></div>
			<div id=eTo<%=i%> class=eDates title="<%=rs("DateTo")%>"><%=rs("DateTo")%></div>
			<%
		End If
		%>
	</div>
	<%
	rs.MoveNext
	If rs.EOF Then 
		%><script type="text/javascript">Resize();</script><%
	End If
Loop
%>
<div class=fL ><%=i%> item<%if i<>1 then %>s<% end if%></div>
</div>
</body>
</html>
