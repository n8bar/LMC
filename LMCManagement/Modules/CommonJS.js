// JavaScript Document
var accessEngineering;
var accessPurchasing;
var accessDataEntry;
var accessEstimates;
var accessInventory;
var accessProjects;
var accessTraining;
var accessService;
var accessWebsite;
var accessOffice;
var accessAdmin;
var accessTest;
var accessTime;
var accessEmpID;
var accessEmpName;
var accessUser;


var mX;
var mY;
document.onmousemove = function (event)
{
	ResetLogoutTimer();
	
	if (!event){event = window.event;}
	mX = event.clientX;
	mY = event.clientY;
}





////////////////////
var IEver=0;
function getInternetExplorerVersion()
// Returns the version of Internet Explorer or a -1
// (indicating the use of another browser).
{
  var rv = 0; // Return value assumes failure.
  if (navigator.appName == 'Microsoft Internet Explorer')
  {
    var ua = navigator.userAgent;
    var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if (re.exec(ua) != null)
      rv = parseFloat( RegExp.$1 );
  }
  return rv;
}
function checkVersion()
{
  var msg = "You're not using Internet Explorer.";
  IEver = getInternetExplorerVersion();

  if ( IEver > -1 )
  {
  //  if ( IEver >= 8.0 ) 
  //    msg = "You're using a recent copy of Internet Explorer."
  //  else
  //    msg = "Version:"+IEver+"  You should upgrade your copy of Internet Explorer.";
  }
 //alert( msg );
}

checkVersion();









//////////////////////////////////////////////////////////////////////////////////////
//Google Calendar Biz/////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
var calService;
var calFeed;

var calServiceIsSetup=false;
function setupCalService()
{
  calService = new google.gdata.calendar.CalendarService('TricomLV-LMC-2');
  //calLogin(); 
	calServiceIsSetup=true;
	return true;
}


function getCalFeed()
{
	var didCalService=setupCalService();
	calService.getEventsFeed(calFeed, handleMyFeed, handleError);
	return didCalService;
}

function handleMyFeed(myResultsFeedRoot) {
  alert("This feed's title is: " + myResultsFeedRoot.feed.getTitle().getText());
}

function handleError(e) {
  alert("There was an error!");
  alert(e.cause ? e.cause.statusText : e.message);
}



var lastCalFeed;
var postLoginTitle;
var postLoginfromDate;
var postLogintoDate;
var eventCreatorTimer;
var eventCreatorTimeout=10000;
var eventRetried=false;
function ToCal(Title,fromDate,toDate,calFeed,jobID,phase,attnEmail,location,crew,notes)
{
	
	if(isDate(fromDate)&&isDate(toDate))
	{}
	else
	{return false}
	
	fromDate=new Date(fromDate);
	var fM=(fromDate.getMonth()+1);		if(fM<=9){fM='0'+fM;}
	var fD=fromDate.getDate();		if(fD<=9){fD='0'+fD;}
	fromDate=fromDate.getFullYear()+'-'+fM+'-'+fD;
	
	toDate=new Date(toDate);
	toDate=dayAdd(toDate);//somehow Google gets off a day!?!
	var tM=(toDate.getMonth()+1);		if(tM<=9){tM='0'+tM;}
	var tD=toDate.getDate();		if(tD<=9){tD='0'+tD;}
	toDate=toDate.getFullYear()+'-'+tM+'-'+tD;
	
	//alert(fromDate+' - '+toDate);
	
	eventRetried=false;
	buildTimeout();
	eventCreatorTimer= setTimeout('eventCreationTimeout('+eventCreatorTimeout+');',eventCreatorTimeout);
	
	
	if(!calServiceIsSetup)
	{
		postLoginTitle=Title
		postLoginFromDate=fromDate
		postLoginToDate=toDate
		getCalFeed();
	}
	
	var entry=new google.gdata.calendar.CalendarEventEntry();
	var now=new Date
	
	entry.setTitle(google.gdata.Text.create(Title));
	
	var when = new google.gdata.When();
	var startTime = google.gdata.DateTime.fromIso8601(fromDate);
	var endTime = google.gdata.DateTime.fromIso8601(toDate);
	when.setStartTime(startTime);
	when.setEndTime(endTime);
	
	entry.addTime(when);
	
	if(!!location||location!='')
	{
		var where = new google.gdata.Where();
		where.setValueString(location);
		where.setLabel(location);
		entry.addLocation(where);
	}
	
	if(!!attnEmail||attnEmail=='')
	{
		var who = new google.gdata.calendar.CalendarWho();
		who.setEmail(attnEmail);
		who.setRel('REL_TASK_ASSIGNED_TO');
		entry.addParticipant(who);
		
		var attnWho= new google.gdata.Person();
		attnWho.setEmail(attnEmail);
		entry.addAuthor(attnWho);
		
		
		var xAttn= new google.gdata.ExtendedProperty();
		xAttn.setName('Attn');
		xAttn.setValue(attnEmail);
		entry.addExtendedProperty(xAttn);
	}
	
	/** /
	if(!!crew||crew=='')
	{
		crew=crew.split(',')
		for(c=0;c<crew.length;c++)
		{
			var who = new google.gdata.calendar.CalendarWho();
			who.setValueString(crew[c]);
			who.setRel('REL_EVENT_ATTENDEE');
			entry.addParticipant(who);
		}
	}
	/**/
	
	if(!!notes&&notes!='')
	{
		notes='Notes:<br/>&nbsp;&nbsp;&nbsp;'+notes;
		
		if(!!attnEmail&&attnEmail!=''){	notes='Attention:&nbsp;&nbsp;'+attnEmail+'<br/><br/>\n\n'+notes}
		
		if(!!crew&&crew!=''){	notes+='<br/><br/>\n\nCrew:<br/>'+crew;}
		
		notes=notes.replace('<','&lt;').replace('/','&#47;');//.replace('>','&gt;')

		//alert('Notes:"'+notes+'"');
		var notesText= new google.gdata.Text();
		notesText.setType('html');
		notesText.setText(notes);
		
		entry.setContent(notesText);
	}
	
	
	
	if(!!jobID&&jobID!='')
	{
		var xJobID= new google.gdata.ExtendedProperty();
		xJobID.setName('JobID');
		xJobID.setValue(jobID);
		entry.addExtendedProperty(xJobID);
	}
	else
	{
		alert('I wasn\'t able to locate JobID#:'+jobID);
		return false;
	}
	
	
	var callback = function(result)
	{
		alert('event created!');
		killTimeout();
	}
	
	var handleError = function(error) {  alert(error);}
	
	calService.insertEntry(calFeed, entry, callback, handleError, google.gdata.calendar.CalendarEventEntry);
	
	lastCalFeed=calFeed;
}

var eventCreationTimeout= function(waited){}
function buildTimeout()  //workaround for clearTimout() not working.
{
	eventCreationTimeout= function(waited)
	{
		killTimeout();
		if(eventRetried) {  alert('Sorry I wasn\'t able to create your event.')  }
		else
		{
			buildTimeout();
			eventCreatorTimer= setTimeout('eventCreationTimeout('+eventCreatorTimeout+');',eventCreatorTimeout);
			eventRetried=true;
		}
	}
}
function killTimeout(){eventCreationTimeout= function(waited){}}


/* The following function is designed for clearing an entire calendar.
I haven't intended it to be implemented, just used manually for integration purposes.*/ 
var eventsDeleted=0;
function delAllCalEvents(calFeed)
{
	var searchText='';
	
	if(!calServiceIsSetup)
	{
		getCalFeed();
	}
	
	if(eventsDeleted==0)
	{
		if(!calFeed)
		{
			if(!lastCalFeed)
			{
				alert('Event Deletion Error:No calendar specified');
				return false;
			}
			calFeed=lastCalFeed;
		}
		
		var RUSure='You are about to all events for this calendar';
		if(!searchText)	{		searchText='*';	}
		else {	RUSure+=' with "'+searchText+'"';	}
		//if(!confirm(RUSure+'!')){return false}
	}
		
	var Query = new google.gdata.calendar.CalendarEventQuery(calFeed);
	Query.setMaxResults(1024);
	//Query.setFullTextQuery(searchText);
	//var d = new Date(0)
	//Query.setUpdatedMin(d);
	
	
	var callback = function(result)
	{
		var entries = result.feed.entry;
		if (entries.length > 0)
		{
			if(!confirm('Deleting '+entries.length+' matches!')){return false}
			for(e=0;e<entries.length;e++)
			{
				var thisEvent = entries[e];
				thisEvent.deleteEntry(function(result){},handleError);
				eventsDeleted++;
			}
		}
		else
		{
    	// No match is found for the full text query
			if(eventsDeleted<=0){		alert('No event(s) found with text: '+searchText+'.');	}
			else{		alert(eventsDeleted+' events have been deleted.');	}
			eventsDeleted=0;
  		return false;
		}
	}
	
	var handleError = function(error) { alert(error);	}
	
	calService.getEventsFeed(Query, callback, handleError);
	
	//if(eventsDeleted>64)
	//{
	//	alert('Maximum of 64 events deleted.');
	//}
	//delCalEvents(calFeed,searchText);// function executes until it hits a return statement
	
	eventsDeleted=0;
	return true;
}
/**/




/************************************************************************************/

