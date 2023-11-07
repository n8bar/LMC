<!--#include file="../TMC/RED.asp" -->
<!DOCTYPE html>
<html>
<head>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<title>RedOak Management Center</title>
	
	<link rel="stylesheet" href="TMC/TMC.css?noCache=<%=timer%>" media="all">
	
	<script type="text/javascript" src="Modules/rcstri.js?noCache=<%=timer%>"></script>
	<script type="text/javascript" src="Modules/CommonAJAX.js?noCache=<%=timer%>"></script>
	<script type="text/javascript" src="TMCTabs-AJAX.js?noCache=<%=timer%>"></script>
	
	<script type="text/javascript">
	
	Validate();
	
	function mainTab(tab)	{
		try { selectedMainTab.setAttribute('class', 'mainTab'); }	catch(e) {}
		tab.setAttribute('class', 'selectedMainTab');
		selectedMainTab=tab;
		var toolbars=document.getElementsByClassName('toolbar');
		for(var t=0; t<toolbars.length; t++) {
			toolbars[t].style.display='none';
		}
		var toolbarId=tab.id.replace('mainTab','')+'SubTabs'
		Gebi(toolbarId).style.display='block';
		
		var lastUserSelectedSubTabId=appGet(selectedMainTab.id+sessionEmpID).replace('undefined','');
		if(!!Gebi(lastUserSelectedSubTabId)) { 
			Gebi(lastUserSelectedSubTabId).onclick(); 
		} else {
			Gebi(Gebi(toolbarId).getElementsByClassName('subTab')[0].id).onclick();
		}
	}
	
	var sstIdArray = new Array();
	function subTab(tab,fSrc)	{
		selectedSubTab=tab;
		
		if(!fSrc) {
			tab.onclick();
			return false;
		}
		
		var ts=new Date();
		ts=ts.getFullYear()+''+(ts.getMonth()+1)+''+ts.getDate()+''+ts.getHours()+''+ts.getMinutes()+''+ts.getSeconds()+''+ts.getMilliseconds();
		fSrc=fSrc.replace('-TSTAMP',ts);
		
		//alert(tab.id);
		applicationWrite(selectedMainTab.id+sessionEmpID,selectedSubTab.id);
		
		var frameId=tab.id+'Frame';
		if (!!selectedMainTab) { 
			sstIdArray[selectedMainTab.id]=tab.id; 
			//Gebi('mainTab5').innerHTML=selectedMainTab.id+' <- '+tab.id;
		} 
		else { 
			sstIdArray['mainTab1']=tab.id; 
			//Gebi('mainTab5').innerHTML='NoWhere <- '+tab.id;
		}
		
		try {  document.getElementsByClassName('selectedSubTab')[0].setAttribute("class", "subTab");} catch(e) {}
		tab.setAttribute("class", "selectedSubTab");
		Gebi(selectedMainTab.id.replace('mainTab','')+'SubTabs').style.borderBottomColor=tab.style.borderTopColor;
	
		try { document.getElementsByClassName('frame')[0].setAttribute("class", "hiddenFrame");	} catch(e) {}
		
		if(!!Gebi(frameId))	{	
			Gebi(frameId).setAttribute("class", "frame");	
			if( Gebi(frameId).src=='' || Gebi(frameId).src==null || !Gebi(frameId).src) { 
				Gebi(frameId).contentWindow.location=fSrc; 
			}
		}
		else {
			Gebi('frames').innerHTML+='<iframe id='+frameId+' class=frame src="'+fSrc+'" ></iframe>'
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
		//selectedMainTab=document.getElementsByClassName('mainTab')[0];
		//mainTab(selectedMainTab);
		Resize();
		<%
		tabs=Split(Request.QueryString("tabs"),"-")
		if uBound(tabs)=1 Then
			%>mainTab(Gebi('<%=tabs(0)%>'));<%
			%>subTab(Gebi('<%=tabs(1)%>'));<%
		Else
			%>mainTab(Gebi('mainTabMain'));<%
			%>subTab(Gebi('mainCalendar'));<%
		End If
		%>
		
		if(document.getElementsByClassName('selectedMainTab').length!=1) mainTab(Gebi('mainTabMain'));
	}

	function Resize()	{
			var H=document.body.offsetHeight;
			var h=Gebi('heading').offsetHeight;
			h+=29;//Gebi(selectedMainTab.id.replace('mainTab','')+'SubTabs').offsetHeight;
			h+=Gebi('footer').offsetHeight;
			Gebi('frames').style.height=(H-h)+'px';
			//Gebi('frames').style.height=(document.body.offsetHeight-Gebi('heading').offsetHeight-Gebi(selectedMainTab.id.replace('mainTab','')+'SubTabs').offsetHeight-Gebi('footer').offsetHeight)+'px';
		try {
		} catch(e) { document.body.innerHTML+='resize failed<br/>'; }
	}

	function Void(){return null;}
	
	function iterateKeepAlive() { setTimeout('keepAlive()',60000*25); }
	iterateKeepAlive();
	</script>
	<!--#include file="Common.asp" -->
	<script>var commonIsDone=true;</script>
</head>

<body onResize="Resize();" onLoad="onLoad();" onmousemove="LogoutCounter();" onSelectStart="return false" >

<div id=heading align=center>
	<div id=topLinks align=right >
		<a href="JavaScript:LogOut();" onClick="LogOut();">Log Out</a> (<%=Session("user")%>)
		&nbsp;
	</div>
	
<!-- % It suddenly occurred to me that I don't want these in the database really.
'	tabClass="selectedMainTab"
'	SQL="SELECT TabID, tabName FROM Tabs ORDER BY OrderIndex DESC"
'	Set rs=Server.CreateObject("AdoDB.RecordSet")
'	rs.open SQL, REDConnString
'	rCount=0
'	Do Until rs.EOF
'		rCount=rCount+1
'		rs.MoveNext
'	Loop
'	tW=(1/(rCount+2)*100)&"%"
'	rs.MoveFirst
'	Do Until rs.EOF
'		tName=rs("tabName")
'		tabClass="mainTab"
'		'If tName="My TMC" Then tabClass="selectedMainTab"
'		%>
'		<div id=mainTab< %=rs("TabID")%> class="< %=tabClass%>" onClick="mainTab(this);" style="width:< %'=tW%>;">&nbsp;< %=tName%>&nbsp;</div>
'		< %
'		rs.MoveNext
'	Loop
'	
'	Set rs=Nothing
% -->

	<div id=mainTabMain class=mainTab onClick="mainTab(this);" >&nbsp;Main&nbsp;</div>
	<div id=mainTabProj class=mainTab onClick="mainTab(this);" >&nbsp;Projects&nbsp;</div>
	<div id=mainTabServ class=mainTab onClick="mainTab(this);" >&nbsp;Service&nbsp;</div>
	<div id=mainTabMgmt class=mainTab onClick="mainTab(this);" >&nbsp;Management&nbsp;</div>
</div>	

<!-- div id=subTabs class=toolbar -->
<!-- %
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
		fSrc=Replace(fSrc,"-TSTAMP",timer)
		%>
		<div class=spacer></div>
		<div id=subTab< %=rs("subTabID")%> class="< %=tabClass%>" onClick="subTab(this,'< %=fSrc%>');" style="< %=tW%>< %=cScolor%>">< %=tName%></div>
		<div class=spacer></div>
		< %
		rs.MoveNext
	Loop
	set rs= Nothing
% -->
<div id=MainSubTabs class="toolbar dB">
	<div class=spacer></div>
	<div id=mainCalendar class=subTab style="border-color:#6be; color:#07c; width:16%;" onClick="subTab(this,'CalendarMain.asp?nc=--TSTAMP');" >Calendar</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mainMyTodo class=subTab style="border-color:#6be; color:#07c; width:16%;" onClick="subTab(this,'Events.asp?Type=11&Active=True&nc=--TSTAMP');" >My ToDo</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mainContacts class=subTab style="border-color:#bbe; color:#22a; width:16%;" onClick="subTab(this,'Contacts.asp?nc=--TSTAMP');" >Contacts</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mainGeneralNotes class=subTab style="border-color:#bb4; color:#660; width:16%;" onClick="subTab(this,'Events.asp?Type=2&Active=True&nc=--TSTAMP');" >General Notes</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mainPreferences class="subTab o50" style="border-color:#6be; color:#07c; width:16%;" onClick="subTab(this,'Preferences.asp?nc=--TSTAMP');" >Preferences</div>
	<div class=spacer></div>
	<div class=spacer style="float:right; height:29px; width:15%; ">&nbsp;</div>
</div>
<div id=ProjSubTabs class="toolbar dN">
	<div class=spacer></div>
	<div id=projEstimatingSales class=subTab style="border-color:8c0#; color:#680; width:16%;" onClick="subTab(this,'bid.asp?nc=--TSTAMP');" >Estimating / Sales</div>
	<div class=spacer></div>	<div class=spacer></div>
	<div id=projProjects class=subTab style="border-color:#f90; color:#e70; width:16%;" onClick="subTab(this,'Projects.asp?nc=--TSTAMP');" >Projects</div>
	<div class=spacer></div>	<div class=spacer></div>
	<div id=projEngineering class=subTab style="border-color:#0d0; color:#090; width:16%;" onClick="subTab(this,'Events.asp?Type=5&Active=True&nc=--TSTAMP');" >Engineering</div>
	<div class=spacer></div>	<div class=spacer></div>
	<div id=projMaterials class=subTab style="border-color:#0dd; color:#088; width:16%;" onClick="subTab(this,'Materials.asp?nc=--TSTAMP');" >Materials</div>
	<div class=spacer></div>	<div class=spacer></div>
	<div id=projTimeEntry class=subTab style="border-color:#cc6; color:#662; width:16%;" onClick="subTab(this,'Time_Entry.asp?nc=--TSTAMP');" >Time Entry</div>
	<div class=spacer></div>
	<div class=spacer style="float:right; height:29px; width:15%; ">&nbsp;</div>
</div>
<div id=ServSubTabs class="toolbar dN">
	<div class=spacer></div>
	<div id=servMonitoring class=subTab style="border-color:#35f; color:#00f; width:20%;" onClick="subTab(this,'Monitoring.asp?nc=--TSTAMP');" >Monitoring</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=servTaskList class=subTab style="border-color:#35f; color:#00f; width:20%;" onClick="subTab(this,'Events.asp?type=3&type2=4&Active=True&nc=--TSTAMP');" >Service Task List</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=servMaterials class=subTab style="border-color:#0dd; color:#088; width:20%;" onClick="subTab(this,'Materials.asp?nc=--TSTAMP');" >Materials</div>
	<div class=spacer></div>	<div class=spacer></div>
	<div id=servTimeEntry class=subTab style="border-color:#cc6; color:#662; width:20%;" onClick="subTab(this,'Time_Entry.asp?nc=--TSTAMP');" >Time Entry</div>
	<div class=spacer></div>
	<div class=spacer style="float:right; height:29px; width:16%; ">&nbsp;</div>
</div>
<div id=MgmtSubTabs class="toolbar dN">
	<div class=spacer></div>
	<div id=mgmtTimeEntry class=subTab style="border-color:#cc6; color:#662; width:16%;" onClick="subTab(this,'Time_Entry.asp?nc=--TSTAMP');" >Time Entry</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mgmtBilling class=subTab style="border-color:#80f; color:#50c; width:16%;" onClick="subTab(this,'Billing.asp?nc=--TSTAMP');" >Billing</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mgmtOfficeManagementIT class=subTab style="border-color:#60f; color:#50c; width:16%;" onClick="subTab(this,'Events.asp?Type=12&Active=True&Events.asp?Type=8&Active=True&nc=--TSTAMP');" >Office Management / IT</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mgmtLicensingCertification class=subTab style="border-color:#60f; color:#50c; width:16%;" onClick="subTab(this,'Events.asp?Type=9&Active=True&Events.asp?Type=8&Active=True&nc=--TSTAMP');" >Licensing / Certification</div>
	<div class=spacer></div>
	<div class=spacer></div>
	<div id=mgmtAdministration class=subTab style="border-color:#fff; color:#444; width:16%;" onClick="subTab(this,'Admin.asp?nc=--TSTAMP');" >Administration</div>
	<div class=spacer></div>
	<div class=spacer style="float:right; height:29px; width:15%; ">&nbsp;</div>
</div>

<div id=frames></div>

<div id=footer style="background:#444; color:#eee; font-size:12px; font-weight:normal; height:14px; width:100%; ">
	<div style="float:left;"> &nbsp; TMC version <%=Application("tmcVersion")%></div>
	<div style="float:right;">&nbsp; <big>&copy;</big> 2013 Tricom Software Development &nbsp; </div>
</div>

<div id=bigModal></div>
</body>
</html>