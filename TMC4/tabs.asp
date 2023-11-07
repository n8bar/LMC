<!DOCTYPE html>
<html>
<head>
	<title>Tricom Management Center</title>
	



	<link rel="stylesheet" href="TMC.css" media="all">
	
	<script type="text/javascript" src="rcstri.js"></script>
	<script type="text/javascript" src="CommonAJAX.js"></script>
	<script type="text/javascript" src="TMCTabs-AJAX.js"></script>
	
	<script type="text/javascript">
	
	Validate();
	
	function mainTab(tab)	{
		try { selectedMainTab.setAttribute('class', 'mainTab'); }		catch(e) {}
		tab.setAttribute('class', 'selectedMainTab');
		selectedMainTab=tab;
		getSubTabs(tab.id.replace('mainTab',''));
	}
	
	var sstIdArray = new Array();
	function subTab(tab,fSrc)	{
		selectedSubTab=tab;
		
		//alert(tab.id);
		
		applicationWrite(selectedMainTab.id+sessionEmpID,selectedSubTab.id);

		var frameId=tab.id.replace('subTab','frame');
		if (!!selectedMainTab) { 
			sstIdArray[selectedMainTab.id]=tab.id; 
			//Gebi('mainTab5').innerHTML=selectedMainTab.id+' <- '+tab.id;
		} 
		else { 
			sstIdArray['mainTab1']=tab.id; 
			//Gebi('mainTab5').innerHTML='NoWhere <- '+tab.id;
		}

		/** /
		if(document.getElementsByClassName('frame')[0].id==frameId) {
			Gebi(frameId).contentWindow.location=Gebi(frameId).contentWindow.location;
			return false;
		}/**/
		
		try {  document.getElementsByClassName('selectedSubTab')[0].setAttribute("class", "subTab");} catch(e) {}
		tab.setAttribute("class", "selectedSubTab");
	
		try { document.getElementsByClassName('frame')[0].setAttribute("class", "hiddenFrame");	} catch(e) {}
		
		if(!!Gebi(frameId))	{	Gebi(frameId).setAttribute("class", "frame");	}
		else	{	alert('Error: broken tabFrame \''+frameId+'\'');	return false;}
		
		var now=new Date();
		now=now.getFullYear()+''+(now.getMonth()+1)+''+now.getDate()+''+now.getHours()+''+now.getMinutes()+''+now.getSeconds()+''+now.getMilliseconds();
		var src=Gebi(frameId).getAttribute('src').replace('--TIMESTAMP--',now);
		if( src=='' || src==null ) { 
			Gebi(frameId).src=fSrc; 
		}
	}
	
	var logoutSeconds=30*60;
	var logoutCounter=logoutSeconds;
	function LogoutCounter()	{	}

	var logoutTimer=setInterval('LogoutCounter();',1000);

	
	var reloadGant=true; //The Gant chart will need to be reloaded.
	
	var selectedMainTab;
	function onLoad() {
		//alert(document.getElementsByClassName('mainTab')[0].id);
		selectedMainTab=document.getElementsByClassName('mainTab')[0];
		mainTab(selectedMainTab);
		Resize();
	}

	function Resize()	{
		try {
			Gebi('frames').style.height=(document.body.offsetHeight-Gebi('heading').offsetHeight-Gebi('subTabs').offsetHeight-Gebi('footer').offsetHeight)+'px';
		} catch(e) { }
		if(reloadGant)	{ // if it ain't broke, fix it until it is.  I mean don't fix it.
			if(!!Gebi('frame102'))	{
				if(!!Gebi('frame102').src)	{ //If the Gant chart is loaded, it probably needs reloaded.
					Gebi('frame102').src=Gebi('frame102').src; 
				}
			}
			reloadGant==false;
			setTimeout('reloadGant==true; ',1000); //Don't constantly reload while resizing.
		}
	}

	function Void(){return null;}
	
	function iterateKeepAlive() { setTimeout('keepAlive()',60000*25); }
	iterateKeepAlive();
	</script>
	<!--#include file="Common.asp" -->
</head>

<body onResize="Resize();" onLoad="onLoad();" onmousemove="LogoutCounter();" onSelectStart="return false" >

<div id=heading align=center>
	<div id=topLinks align=right >
		<a href="JavaScript:Void();" onClick="LogOut();">Log Out</a> (<%=Session("user")%>)
		&nbsp;
	</div>
<%
	tabClass="selectedMainTab"
	SQL="SELECT TabID, tabName FROM Tabs ORDER BY OrderIndex DESC"
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.open SQL, REDConnString
	
	rCount=0
	Do Until rs.EOF
		rCount=rCount+1
		rs.MoveNext
	Loop
	tW=(1/(rCount+2)*100)&"%"
	rs.MoveFirst
	Do Until rs.EOF
		tName=rs("tabName")
		tabClass="mainTab"
		'If tName="My TMC" Then tabClass="selectedMainTab"
		%>
		<div id=mainTab<%=rs("TabID")%> class="<%=tabClass%>" onClick="mainTab(this);" style="width:<%'=tW%>;">&nbsp;<%=tName%>&nbsp;</div>
		<%
		rs.MoveNext
	Loop
	
	Set rs=Nothing
%>
</div>	

<div id=subTabs class=toolbar>
<%
	WhereElse=""
	If session("User") <> "n8" Then WhereElse="AND comingSoon!='True'"
	SQL="SELECT subTabID, tabName, frameSrc, comingSoon FROM subTabs WHERE parentTabID=1 "&WhereElse&" ORDER BY OrderIndex "
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.open SQL, REDConnString
	
	rCount=0
	Do Until rs.EOF
		rCount=rCount+1
		rs.MoveNext
	Loop
	tW=" width:"&(1/(rCount+1.25)*100)&"%;"
	rs.MoveFirst
	Do Until rs.EOF
		fSrc=DecodeChars(rs("frameSrc"))
		tName=rs("tabName")
		'If tName="Gant Chart" Then tabClass="selectedSubTab" Else tabClass="subTab"
		If tName="Calendar" Then tabClass="selectedSubTab" Else tabClass="subTab"
		If rs("comingSoon")="True" Then 
			cScolor=" color:#ccc;"
			fSrc="coming.asp?link="&fSrc
		Else 
			cScolor=" color:white;"
		End If
		fSrc=Replace(fSrc,"--TIMESTAMP--",timer)
		%>
		<div id=subTab<%=rs("subTabID")%> class="<%=tabClass%>" onClick="subTab(this,'<%=fSrc%>');" style="<%=tW%><%=cScolor%>"><%=tName%></div>
		<%
		rs.MoveNext
	Loop
	set rs= Nothing
%>
</div>

<div id=frames><%
	SQL="SELECT subTabID, tabName FROM subTabs"
	If session("User") <> "n8" Then SQL=SQL&" WHERE comingSoon!='True'"
	Set rs=Server.CreateObject("AdoDB.RecordSet")
	rs.open SQL, REDConnString
	
	'Do Until rs.EOF
		'If rs("tabName")="Gant Chart" Then 
		'	frameClass="frame"
		'	fSrc="coming.asp?link=GantChartMain.asp"
		If rs("tabName")="Calendar" Then 
			frameClass="frame"
			fSrc="CalendarMain.asp?nocache="&timer
		Else	
			frameClass="hiddenFrame"
			fSrc=""
		End If
		%>
		<iframe id=frame0<%=DecodeChars(rs("subTabID"))%> class="<%=frameClass%>" src="<%=fSrc%>" ></iframe>
		<%
	'	rs.MoveNext
	'Loop
	'
	'set rs=Nothing
	
'&nbsp;% ></div>
%></div>
<div id=bigModal></div>
</body>
</html>
