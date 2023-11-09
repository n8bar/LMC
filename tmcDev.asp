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

strike {text-decoration:line-through;}

#left { float:left; width:15%; height:100%; color:#0060C0; background-color:rgba(0,128,255,.125); overflow-x:hidden; }
#left p { font-size:12px; }
#main{ float:left; width:55%; height:100%; padding:8px; background-color:rgba(0,128,255,.0625); overflow-x:hidden; }
#right { float:left; width:30%; height:100%; background-color:rgba(0,128,255,.3333); overflow:hidden; }

.scrollBox { overflow-x:hidden; overflow-y:auto; }
.pre,pre {white-space:pre-wrap; font-family:Consolas, "Courier New", Courier, Monospace; height:auto; overflow:hidden; }

.kiRow {min-height:16px; height:auto; width:100%; font-size:14px; line-height:15px; overflow:hidden; }
.kiRow div { float:left; display:block; text-decoration:inherit; }
.kiCheck {width:5%; }
.kiID {width:15%; }
.kiIssue { width:35%; }
.kiDesc { width:45%; }

@font-face {
	font-family:Condensed;
	src:url(fonts/swisscl.ttf);
}
</style>

<script type="text/javascript">
	function nav() {
		alert('http://tmc.tricom.sc/tmcDevelopment/'+devURL.value);
		window.location='http://tmc.tricom.sc/tmcDevelopment/'+devURL.value; 
	}
</script>
</head>
<body>
	<div id=left class="shade20">
		<h3>Upcoming Features</h3>
		<p><b><i> &nbsp; &nbsp; I need help prioritizing this, so please don't withold any input you have to offer.</i></b></p>
		<p></p>
		<p style="white-space:pre-wrap;">
 •Material Requests, Job Pack Management, and Purchase Orders<br/>
 <strike>•Time Entry for iOS & Android browsers</strike><br/>
 •Calendar Tasks fully integrated with Projects and Service calls complete with Gantt charts<br/>
 •Scheduling upgrades: intelligent recurrence with fine-grain flexibility (With service dept in mind)<br/>
 •Daily uncompleted tasklist emails and email reminders.<br/>
 •Laptop Syncability for offline use:<br/>
  <strike>·Time Entry</strike><br/>
  ·Bidder<b><i><big>!</big></i></b><br/>
		</p>
	</div>
	<div id=main class="shade scrollBox">
		<h2>&nbsp;</h2>
		<h1 onDblClick="this.innerHTML='<input id=devURL /><button onclick=nav(); >Go</button>'; devURL.focus();" >Tricom Management Center</h1>
		<h3><!--#include file="LMC/LoginASP.asp" --><%'=application("tmcVersion")%></h3>
		<h5>latest update: <%=Application("tmcBuildDate")%></h5>
		
		<h3>&nbsp;</h3>
		<p>6/7/2013</p>
		<p> &nbsp; &nbsp; We now have the site up and running @ RE! &amp; I am keeping an open mind for what the needs will be. <a href="mailto:nateb@tricomlv.com?subject=TMC">Please let me know what <i>you</i> would like to see.</a></p>
		<br/>
		<p> &nbsp; &nbsp; I have been working on expanding the Materials section.  we were going to have a Material Requests Manager, Job Pack Management, and even Purchase Orders!!!  We did get Inventory Control up and running! <a href="mailto:nateb@tricomlv.com?subject=TMC%20Info%20Page">Let me know what you think.</a> </p>
		<br/>
		<p> &nbsp; &nbsp; Basically I'm wondering if and how this software fits in the grand scheme of things at this point &amp; what more I can do &amp; what the current and anticipated needs are. </p>
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
			%><p>There aren't any more known issues to report!</p><%
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
					<div class="kiCheck taR" style="font-family:Consolas, Calibri, Arial, monospace; color:#080; text-decoration:none; font-size:18px; font-style:normal;" >✓ &nbsp;</div>
					<div class=kiID ><%=kiRS("ID")%></div>
					<div class=kiIssue ><%=kiRS("Issue")%></div>
					<div class=kiDesc ><%=kiRS("Description")%></div>
				</div>
				<%
				kiRS.MoveNext
			Loop
		End If
		
		%>
		<br><br>
		<h2>Other Stuff</h2>
		
		<h4><br/>Downloads</h4>
		<a href="downloads/ChromeStandaloneSetup v22.exe">Chrome 22</a><br/>
		<a href="downloads/Firefox Setup 16.0.1.exe">Firefox 16.0.1</a><br/>
		<br/>
		<p> &nbsp; &nbsp; The following no longer works.  If anyone still wants it, we'll have to ask Will Dan about setting it up again.</p>
		<strike><h4><br>Want to try TMC at a distance?</h4>
		<!--#include file="TMC Copy Note.asp"--></strike>
	</div>
	
	
	<div id=right class="shade20">
		<div class="h75p w100p fL scrollBox shade20" id=vRoadMap >
			<h2>Roadmap</h2>
			<h4>(Very subject to change)</h4>
			<p class=pre><%'=Application("versionRoadMap")%>
  •3.2 Material Requests, Job Packs with Inventory Integration, and Order Requisitions / Purchase Orders

  <strike>•3.3 Mobile Version of Time Entry</strike>

  •3.4 One of the following:

   -Daily uncompleted tasklist emails and email reminders.

   -Calendar Tasks fully integrated with Projects and Service calls complete with Gantt charts or

   -Scheduling upgrades: intelligent recurrence with fine-grain flexibility (With service dept in mind) or

  •3.5 One of the ones that 3.4 wasn't

  •3.6 The one remaining of the 3 things on 3.4

  •3.7 User Preferences Settings

 •4.0 Beginnings of Laptop Synchronization possibly utilizing Database replication & differentiation technologies

   •4.0.1 Time Entry for offline use: This does not neccesarily need to use db replication.  It can be a mass upload type thing.

   •4.0.2 Bidder for offline use: We have a couple of options:
   -we can try to replicate the database into a Client-Side Database or
   -export the current contacts, parts, projects, etc. databases to read-only xml data & keep all new data separate until synchronization can be done.
   both of these methods will require a concurrent bidding software to be developed for this purpose!

 •5.0 Whoa... what does the future hold?
			</p>
		</div>
		<div class="h25p w100p fL scrollBox shade" id=vHistory >
			<h2>Version history</h2>
			<p class=pre ><%'=Application("versionHistory")%>
  •3.1.2 Added UPC and Bar code scanning for Android
   •3.1.1 Added Mobile Version of Inventory Control
 •3.1 Added Inventory Control
  •3.0.1 Finished restoring complete functionality as before the v3.0 overhaul.
 •3.0 Awesome new Interface -Many sections rebuilt -Much cleaner and easier to use.
 			</p>
		</div>
	</div>
</body>
</html>
