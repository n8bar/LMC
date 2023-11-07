<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<!-- DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" -->
<!-- html xmlns="http://www.w3.org/1999/xhtml" -->
<!-- Calendar Access URL= https://www.google.com/a/tricomlv.com/AuthSubRequestJS?session=1&scope=https://www.google.com/calendar/feeds/&next=https://www.rcstri.com/website/tmcdevelopment/tmc.html 

Login URL:
https://www.google.com/a/UniversalLogin
-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Calendar 2.0</title>

<!--#include file="RED.asp" -->

<script type="text/javascript" src="rcstri.js"></script>
<script type="text/javascript" src="Cal2.js"></script>

<link rel="stylesheet" href="Cal2.css" media="screen">

</head>

<body onResize="Resize();" onLoad="Resize(); load1x1();">
<!--
-->
<div id="Overall" class="Overall">
	<div id="Left" class="Left">
		<small><a href="https://www.google.com/a/tricomlv.com/ServiceLogin" target="_blank"style="text-decoration:underline;">tricomlv.com signin</a>&nbsp;</small>
		<br/>
		<small><a href="calendarmain.asp" target="_self"style="text-decoration:underline;">Old Calendar</a>&nbsp;</small>
		<br/>
		<hr/>
		<small><a href="http://docs.tricomlv.com" target="_self"style="text-decoration:underline;">Google Docs</a>&nbsp;</small>
		<br/>
		<small><a href="http://mail.tricomlv.com" target="_self"style="text-decoration:underline;">eMail</a>&nbsp;</small>
		<br/>
		<small><a href="http://wave.tricomlv.com" target="_self"style="text-decoration:underline;">Wave</a>&nbsp;</small>
		<br/>
		<small><a href="https://www.google.com/contacts/a/tricomlv.com" target="_self"style="text-decoration:underline;">Contacts</a>&nbsp;</small>
		
		<div id=Months>
		</div>
		
		<div id=WhichCalendars align=left>
			<%
			Set rs=Server.CreateObject("AdoDB.RecordSet")
			SQL="SELECT * FROM Tasks WHERE GoogleCalendarKey !='0'"
			rs.Open SQL, REDConnString
			
			If rs.EOF Then response.End()
			
			FrameSRC=""'&amp;src=tricomlv.com_"&rs("GoogleCalendarKey")&"%40group.calendar.google.com&amp;color=%23"&rs("CompatibleColor")
			Do Until rs.EOF
				Alt=rs("AltName")
				cClr=rs("CompatibleColor")
				key=rs("GoogleCalendarKey")
				show=rs("ShowCalAtStartup")
				%>
				<label class=CalToggle id=Toggle<%=Alt%> style="color:#<%=cClr%>" align=left>
					<input class=chkCalToggle id=chk<%=Alt%> type="checkbox" value="<%=show%>" onChange="toggleCal('<%=key%>','<%=cClr%>',this)"><%=rs("TaskName")%>
				</label>
				<%
				rs.MoveNext
			Loop
			
			Set rs=Nothing
			%>
		</div>
	</div> 
	
	<div id="Right" class="Right">
		<script type="text/javascript">
			parent.gCalLogin();
		</script>
		<div id="Cal" class="Cal">
			<%
				'Set rs=Server.CreateObject("AdoDB.RecordSet")
				'SQL="SELECT * FROM Tasks WHERE GoogleCalendarKey !='0'"
				'rs.Open SQL, REDConnString
				'
				'If rs.EOF Then response.End()
				'
				'FrameSRC=""
				'CalNum=0
				'Do Until rs.EOF
				'	CalNum=CalNum+1
				'	SRCAdd="&amp;src=tricomlv.com_"&rs("GoogleCalendarKey")&"%40group.calendar.google.com&amp;color=%23"&rs("CompatibleColor")
				'	FrameSRC=FrameSRC&SRCAdd
				'	rs.MoveNext
				'	if CalNum>=8 Then Exit Do
				'Loop
			%>
			<iframe id="CalFrame" name="CalFrame" src="https://www.google.com/calendar/hosted/tricomlv.com/embed?showTitle=0&amp;showNav=1&amp;showDate=1&amp;showPrint=1&amp;showTabs=1&amp;showCalendars=0&amp;showTz=0&amp;wkst=1&amp;mode=MONTH&amp;<%=FrameSRC%>" style=" border-width:0 " width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
			<script type="text/javascript">//setTimeout("Gebi('CalFrame').src=Gebi('CalFrame').src+'<%=FrameSRC%>';Gebi('CalFrame').contentWindow.reload();",3000);// alert('I care!')</script>
		</div> 
		
	</div>
</div> 
</body>
</html>
