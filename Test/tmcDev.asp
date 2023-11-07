<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>TMC Development</title>
<!--#include file="global.asp" -->

<link rel=stylesheet href="global.css" media=all>

<style>
html { margin:0; width:100%; height:100%; overflow:hidden; font-family:Verdana, Geneva, sans-serif; }
body { margin:0; width:100%; height:100%; overflow:hidden; }

h1,h2,h3,h4,h5,h6 { text-align:center; width:100%; margin:0; padding:4px; max-width:100%; }

#left { float:left; width:15%; height:100%; color:#0060C0; background-color:rgba(0,128,255,.125); overflow:hidden; }
#left p { font-size:12px; }
#main{ float:left; width:55%; height:100%; padding:8px; background-color:rgba(0,128,255,.0625); overflow:hidden; }
#right { float:left; width:30%; height:100%; background-color:rgba(0,128,255,.3333); overflow:hidden; }

.scrollBox { overflow-x:hidden; overlow-y:auto; }
.pre {white-space:pre-wrap; font-family:Consolas, "Courier New", Courier, Monospace; }

.kiRow {height:24px; width:100%; font-size:14px; }
.kiRow div { float:left; display:block; text-decoration:inherit; }
.kiCheck {width:5%; }
.kiID {width:15%; }
.kiIssue { width:35%; }
.kiDesc { width:45%; }
</style>

</head>
<body>
	<div id=left class="shade20">
		<h3>Upcoming Features</h3>
		<p><b> &nbsp; &nbsp; I need help prioritizing this, so please don't withold any input you have to offer.</b></p>
		<p></p>
		<p style="white-space:pre-wrap;">
 •Inventory for iOS & Android browsers
 •Time Entry for iOS & Android browsers
 •Calendar Tasks fully integrated with Projects and Service calls complete with Gantt charts
 •Scheduling upgrades: intelligent recurrence with fine-grain flexibility (With service dept in mind)
 •Daily uncompleted tasklist emails and email reminders.
 •Laptop Syncability for offline use:
  ·Time Entry
  ·Bidder - This will be interesting.
		</p>
	</div>
	<div id=main class="shade scrollBox">
		<h2>&nbsp;</h2>
		<h1>Tricom Management Center</h1>
		<h3><%=application("tmcVersion")%></h3>
		<h5>latest update: <%=Application("tmcBuildDate")%></h5>
		<h3>&nbsp;</h3>
		<p> &nbsp; &nbsp; I can't thank you folks enough for your patience with me!  This tab is dedicated to keeping you updated on the development of this management software.  <a href="mailto:nateb@tricomlv.com?subject=TMC%20Info%20Page">Let me know what you think. </a> </p>
		<br/> 
		<%
		Build=Split(Application("tmcVer"),".")(3)
		%><%'=Build%><%
		%>
		<br/>
		<h3 style="text-align:left;"> &nbsp; Known Bugs:</h3>
		<%
		kiSQL="SELECT * FROM KnownIssues WHERE BuildFixed=0 OR BuildFixed > "&Build
		Set kiRS=Server.CreateObject("AdoDB.RecordSet")
		kiRS.Open kiSQL, REDConnString
		
		If kiRS.EOF Then
			%><p>There are no known issues to report!</p><%
		Else		
			%>
			<div class="kiRow" style="font-weight:bold; text-decoration:underline;">
				<div class=kiCheck >&nbsp;</div>
				<div class=kiID >Issue #</div>
				<div class=kiIssue > Issue </div>
				<div class=kiDesc > Details </div>
			</div>
			<%
			Do Until kiRS.EOF
				%>
				<div class="kiRow">
					<div class=kiCheck style="font-family:Consolas, Calibri, Arial, monospace" >&nbsp;</div>
					<div class=kiID ><%=kiRS("ID")%></div>
					<div class=kiIssue ><%=kiRS("Issue")%></div>
					<div class=kiDesc ><%=kiRS("Description")%></div>
				</div>
				<%
				kiRS.MoveNext
			Loop
		End If
		
		msgBody="Hi%20n8,%0D%0A%20%20%20%20I%20am%20experiencing%20the%20following%20problem%20on%20TMC:%0D%0A"
		%>
		<br/>
		<p><a href="mailto:nateb@tricomlv.com?subject=TMC%20Issue&body=<%=msgBody%>">Report an issue</a></p>
		<br/>
		<h3 style="text-align:left;"> &nbsp; Recently Fixed Bugs:</h3>
		<%
		kiSQL="SELECT * FROM KnownIssues WHERE BuildFixed>="&(Build-2)
		Set kiRS=Server.CreateObject("AdoDB.RecordSet")
		kiRS.Open kiSQL, REDConnString
		
		If kiRS.EOF Then
			%><p>There are no recently fixed issues to report!</p><%
		Else		
			%>
			<div class="kiRow" style="font-weight:bold; text-decoration:underline;">
				<div class=kiCheck > &nbsp; </div>
				<div class=kiID >Issue #</div>
				<div class=kiIssue > Issue </div>
				<div class=kiDesc > Details </div>
			</div>
			<%
			Do Until kiRS.EOF
				%>
				<div class="kiRow" style="color:#666; font-style:italic; text-decoration:line-through;">
					<div class="kiCheck taR" style="font-family:Consolas, Calibri, Arial, monospace; color:#080; text-decoration:none; font-size:18px;" >√&nbsp;</div>
					<div class=kiID ><%=kiRS("ID")%></div>
					<div class=kiIssue ><%=kiRS("Issue")%></div>
					<div class=kiDesc ><%=kiRS("Description")%></div>
				</div>
				<%
				kiRS.MoveNext
			Loop
		End If
		
		%>
	</div>
	
	<div id=right class="shade20">
		<div class="h25p w100p fL scrollBox shade" id=vHistory >
			<h2>Version history</h2>
			<p class=pre ><%=Application("versionHistory")%></p>
		</div>
		<div class="h75p w100p fL scrollBox shade20" id=vRoadMap >
			<h2>Roadmap</h2>
			<h4>(Very subject to change)</h4>
			<p class=pre><%=Application("versionRoadMap")%></p>
		</div>
	</div>
</body>
</html>
