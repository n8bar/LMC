<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Google Logger-Inner</title>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="../../LMCManagement/Old Stuff/rcstri.js"></script>
<script type="text/javascript">
//<Google Calendar biz>///////////////////////////////////////////////////////////////////////////
var calService;

var calFeed = '<%=Request.QueryString("feed")%>';

function getCalFeed() {
  setupCalService();
 calService.getEventsFeed(calFeed, handleMyFeed, handleError);
}

function handleMyFeed(myResultsFeedRoot) {
  alert("This feed's title is: " + myResultsFeedRoot.feed.getTitle().getText());
}

function handleError(e) {
	//alert("There was an error!");
  alert(e.cause ? e.cause.statusText : e.message);
}

function calLogin() {
	scope = "<%=Request.QueryString("scope")%>";
	var token=google.accounts.user.login(scope);
}

var calServiceIsSetup=false;
function setupCalService() {
  calService = new google.gdata.calendar.CalendarService('TricomLV-LMC-2');
  calLogin();
	calServiceIsSetup=true;
	return false;
}



google.load('gdata', '1');


function ToCal(Title,fromDate,toDate)
{
		
	fromDate=new Date(fromDate);
	var fM=(fromDate.getMonth()+1);		if(fM<=9){fM='0'+fM;}
	var fD=fromDate.getDate();		if(fD<=9){fD='0'+fD;}
	fromDate=fromDate.getFullYear()+'-'+fM+'-'+fD;
	
	toDate=new Date(toDate);
	var tM=(toDate.getMonth()+1);		if(tM<=9){tM='0'+tM;}
	var tD=toDate.getDate();		if(tD<=9){tD='0'+tD;}
	toDate=toDate.getFullYear()+'-'+tM+'-'+tD;
	
	alert(fromDate+' - '+toDate);
	

	var entry=new google.gdata.calendar.CalendarEventEntry();
	var now=new Date
	
	entry.setTitle(google.gdata.Text.create(Title));
	
	var when = new google.gdata.When();
	var startTime = google.gdata.DateTime.fromIso8601(fromDate);
	var endTime = google.gdata.DateTime.fromIso8601(toDate);
	when.setStartTime(startTime);
	when.setEndTime(endTime);
	
	entry.addTime(when);
	
	var callback = function(result) { alert('event created!');}
	
	var handleError = function(error) {  alert(error);}
	
	calService.insertEntry(calFeed, entry, callback, handleError, google.gdata.calendar.CalendarEventEntry);
	
	Gebi('ScheduleBox').style.display='none';
	Gebi('Modal').style.display='none'; 
}
////////////////////////////////////////////////////////////////////////</Google Calendar biz>

</script>


</head>
<body onLoad="ToCal('<%=Request.QueryString("Title")%>','<%=Request.QueryString("From")%>','<%=Request.QueryString("To")%>');">
<%=Server.URLEncode(Request.QueryString("scope"))%><br/>
<%=Request.QueryString("Title")%><br/>
<%=Request.QueryString("From")%><br/>
<%=Request.QueryString("To")%><br/>
</body>
</html>
