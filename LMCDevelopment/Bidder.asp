<!--#include file="../LMC/RED.asp" -->
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Bidder</title>
	
	<link rel="stylesheet" href="Bid/Bidder.css" media="screen">
	<link rel="stylesheet" href="Bid/Bidder.css" media="print">
	
	<script type="text/javascript" src="Modules/rcstri.js"></script>
	<script type="text/javascript" src="Modules/CommonAJAX.js"></script>
	<script type="text/javascript" src="LMCTabs-AJAX.js"></script>

	<script type="text/javascript">
		
		Validate();
		
		function mainTab(tab)	{
			document.getElementsByClassName('selectedMainTab')[0].setAttribute("class", "mainTab");
			tab.setAttribute("class", "selectedMainTab");
			getSubTabs(tab.id.replace('mainTab',''));
		}
		
		function subTab(tab,fSrc)	{
			var frameId=tab.id.replace('subTab','frame');
			try	{	document.getElementsByClassName('frame')[0].setAttribute("class", "hiddenFrame");	} catch(e){}
			
			if(!!Gebi(frameId))	{	Gebi(frameId).setAttribute("class", "frame");	}
			else	{	alert('Error: broken tabFrame \''+frameId+'\'');	return false;}
			
			Gebi(frameId).src=fSrc;
			
			try	{	document.getElementsByClassName('selectedSubTab')[0].setAttribute("class", "subTab");	} catch(e){}
			tab.setAttribute("class", "selectedSubTab");
		}
		
		function Resize()	{
			Gebi('frames').style.height=(document.body.offsetHeight-Gebi('heading').offsetHeight)+'px';
		}
		
		
		function OpenBid(projId)	{
			document.getElementById('frame2').setAttribute('src','Estimates.asp?ProjId='+projId);
			subTab(document.getElementById('subTab2'),'Estimates.asp');
			alert(projId);
		}
		
		
		
		function Void(){}


	</script>
</head>

<body onResize="Resize();" onLoad="Resize();" onSelectStart="return false">

<div id=heading align=left>
<%
	SQL="SELECT bidTabID, tabName, frameSrc FROM bidTabs ORDER BY OrderIndex"
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.open SQL, REDConnString
	
	rCount=0
	Do Until rs.EOF
		rCount=rCount+1
		rs.MoveNext
	Loop
	tW=" width:"&(1/(rCount+1)*100)&"%;"
	rs.MoveFirst
	Do Until rs.EOF
		fSrc=DecodeChars(rs("frameSrc"))
		tName=rs("tabName")
		If tName="Bid List" Then tabClass="selectedSubTab" Else tabClass="subTab"
		%>
		<div id=subTab<%=rs("bidTabID")%> class="<%=tabClass%>" onClick="subTab(this,'<%=fSrc%>');" style="<%=tW%>"><%=tName%></div>
		<%
		rs.MoveNext
	Loop
	set rs= Nothing
%>
</div>	

<div id=frames>
	<%
	
	SQL="SELECT bidTabID, tabName, frameSrc FROM bidTabs"
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.open SQL, REDConnString
	
	Do Until rs.EOF
		If rs("tabName")="Bid List" Then 
			frameClass="frame"
			fSrc="bid.asp"
		Else	
			frameClass="hiddenFrame"
			fSrc=""
		End If
		%>
		<iframe id=frame<%=rs("bidTabID")%> class="<%=frameClass%>" src="<%=fSrc%>" ></iframe>
		<%
		rs.MoveNext
	Loop
	
	set rs=Nothing
	%>
</div>
</body>
</html>
