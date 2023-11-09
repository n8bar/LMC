// JavaScript Document

//- These are global variables for the current date and Source/View showing on the calendar
var MonthShowing = '';
var DayShowing = '';
var YearShowing = '';
var WeekShowing = '';
var ViewShowing = '';// Sets wether Month, Week or Day view is showing
var DateOnHover = '';// Gets the Date of div hovered over
var EventClickID = '';//Gets the ID of the Calendar event when clicked

var EventDragToggle = 0; //Toggles the event when dragged

//These are global variables for Views
var vTask = '';

Box_Event_Click = 0; // For determining which popup is executed . Day Bubble or Event Hover

function Void() {}

function onLoad() {
	var divs=document.getElementsByTagName('div')
	for(d=0; d<divs.length; d++) {
		divs[d].onmousemove=MouseMove
	}
	
	var lis=document.getElementsByTagName('li')
	for(l=0; l<lis.length; l++) {
		lis[l].onmousemove=MouseMove
	}
}



var SelectedDate=null;
//Modal For New Events  ///////////////////////////////////////////////////////////////////////////////////////  
function ShowEventModal(Source,inst,sDate, RemoteCode) {
	if(Box_Event_Click==1) {//Makes it so this popup does not activate if you click the one above it
		Box_Event_Click=0;
		return;
	}  
	
	SelectedDate=sDate
	
	if(RemoteCode!='NewEvent') {	
		Gebi('NewEventTaskBox').style.display='block'; //Show the New Event cateory window if not coming from another tab.
		Gebi('NewEventDate').innerHTML=sDate;
	}
	
	for(i=1;i<Gebi('AttnList').length;i++) {
		if(Gebi('AttnList')[i].value==parent.accessEmpID)	Gebi('AttnList').selectedIndex=i;
	}
	
	Gebi('NewEventBoxTitle').style.background = '#3599E3';
	Gebi('EventHeaderTxt').style.Color = '#FFF';
	Gebi('ModalScreen').style.display = 'inline';
	Gebi('NewEventBox').style.display = 'inline';
	Gebi('EventDetailsScreen').style.display = 'block';
	Gebi('EventDetails2').style.display = 'none';
	Gebi('DeleteEventBtn').style.display = 'none';
	
	sDate=sDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
	Gebi('Source').value = Source;
	Gebi('FromDateTxt').value = sDate;
	Gebi('ToDateTxt').value = sDate;
	Gebi('EventTitleText').value = '';
	Gebi('EventNewNotes').value = '';
	Gebi('CrewNames').value = 'Crew:';
	Gebi('EventID').value = '';
	//Gebi('AttnList').value = 1500;
	Gebi('TaskList').options.selectedIndex=0;
	//Gebi('EventRepeat').options.selectedIndex=0;
	Gebi('SuperList').options.selectedIndex=0;
	Gebi('AreaList').options.selectedIndex=0;
	//Gebi('AreaList2').options.selectedIndex=0; 
	Gebi('CustomerList').options.selectedIndex=0;
	Gebi('CrewList').options.selectedIndex=0;

	Gebi('EventHeaderTxt').innerHTML = 'Create New Event';
	Gebi('DeleteEventBtn').style.display = 'none';
	
	Gebi('DoneCheck').checked = false;
}   
  
function hideEventModal() {
	Gebi('ModalScreen').style.display = 'none';
	Gebi('NewEventBox').style.display = 'none';
	Gebi('NewEventTaskBox').style.display = 'none';
}
  


function TaskListerRedirect(TaskNum,TaskIndex) {
	//alert(TaskNum.toString());
	Gebi('TaskList').selectedIndex=TaskIndex;
	Gebi('NewEventTaskBox').style.display='none';
	Gebi('EventTitleText').focus();
	
	switch(TaskNum.toString()) {
		case '1' : // -------------Projects------------------
			
			Gebi('ProjectSelectionBox').style.display='block';
			return true;
		break; // -------------Projects------------------
		
		case '//2' : // -------------General Note------------------
			//alert('u got 2');
			
			parent.Gebi('GeneralIframe').contentWindow.Gebi('txtDate').value=SelectedDate;
			parent.ShowGeneral();
			parent.Gebi('GeneralIframe').contentWindow.TaskBox('New Task');
			hideEventModal();
			parent.Gebi('GeneralIframe').contentWindow.Gebi('txtJob').focus();
						
			return true;
		break; // -------------General Note------------------
		
		case '3' : // -------------Service------------------
			
			/** /
			parent.Gebi('ServiceIframe').contentWindow.Gebi('txtDate').value=SelectedDate;
			parent.ShowService();
			parent.Gebi('ServiceIframe').contentWindow.TaskBox('New Task');
			hideEventModal();
			parent.Gebi('ServiceIframe').contentWindow.Gebi('txtJob').focus();
			/**/			
		//	Gebi('ServiceSelectionBox').style.display='block';
			return true;
		break; // -------------Service------------------
		
		case '4' : // -------------General Note------------------
			
			/** /		
			parent.Gebi('TestMaintIframe').contentWindow.Gebi('txtDate').value=SelectedDate;
			parent.ShowTestMaint();
			parent.Gebi('TestMaintIframe').contentWindow.TaskBox('New Task');
			hideEventModal();
			parent.Gebi('TestMaintIframe').contentWindow.Gebi('txtJob').focus();
			/**/
		//	Gebi('TestMaintSelectionBox').style.display='block';
			return true;
		break; // -------------General Note------------------
		
/*

		case  // -------------//------------------
		
		break; // -------------//------------------
		
*/		
		
		default:
			//alert('u got default');
			return false;
		break;
	}

}

function JobSched(OptionObject) {
	var JobID=OptionObject.value;
	var Title=OptionObject.innerHTML;
	var Area=OptionObject.getAttribute('area');
	var Attn=OptionObject.getAttribute('attn');
	
	//var ProjFrame=parent.Gebi('ProjectsIframe');
	//ProjFrame.src='ProjMan.asp?ProjID='+ProjID;
	//parent.ShowProjects();
	//hideEventModal();
	
	Gebi('ProjectSelectionBox').style.display='none';
	Gebi('ServiceSelectionBox').style.display='none';
	Gebi('TestMaintSelectionBox').style.display='none';
	//ProjRedirectShedule();
	
	//Gebi('TaskList').selectedIndex=TaskIndex;
	Gebi('NewEventTaskBox').style.display='none';
	
	Gebi('NewEventBox').style.display='block';
	Gebi('EventTitleText').value=Title; 
	Gebi('EventJobID').value=JobID
	
	for(a=0; a<Gebi('AreaList').length; a++) {
		if(Area==Gebi('AreaList')[a].innerHTML) {
			Gebi('AreaList').selectedIndex=a;
		}
	}
	
	for(a=0; a<Gebi('AttnList').length; a++) {
		if(Attn==Gebi('AttnList')[a].innerHTML) {
			Gebi('AttnList').selectedIndex=a;
		}
	}
	
}

/** /
var SchTries=0;
function ProjRedirectShedule(ProjID) {
	try	{
		parent.Gebi('ProjectsIframe').contentWindow.Gebi('SchFrame').contentWindow.NewSched(SelectedDate);
		parent.Gebi('ProjectsIframe').contentWindow.DataTabs('Schedu','Schedule');
		SchTries=0;
	}
	catch(e) {
		SchTries++;
		if(SchTries>99) {	return false	}
		setTimeout('ProjRedirectShedule('+ProjID+');',500);
	}
}
/**///unused function
  
function ToDateChange() { //Formats the TO Date 
	var DateFrom = Gebi('FromDateTxt').value;
	DateFrom=DateFrom.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
	var fromMonth = parseInt(DateFrom.split("/")[0],10);
	var fromDay = parseInt(DateFrom.split("/")[1],10);
	var fromYear = parseInt(DateFrom.split("/")[2],10);
	
	var DateTo = Gebi('ToDateTxt').value;
	DateTo=DateTo.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
	var ToMonth = parseInt(DateTo.split("/")[0],10);
	var ToDay = parseInt(DateTo.split("/")[1],10);
	var ToYear = parseInt(DateTo.split("/")[2],10);
	
	if (ToYear < fromYear) {alert('Please enter a higher To: Year'); Gebi('ToDateTxt').value = DateFrom}
	if ((ToYear <= fromYear)&&(ToMonth < fromMonth) ) {alert('Please enter a higher To: Month'); Gebi('ToDateTxt').value = DateFrom}
	if ((ToYear <= fromYear)&&(ToMonth <= fromMonth)&&(ToDay < fromDay)) {alert('Please enter a higher To: Day'); Gebi('ToDateTxt').value = DateFrom}
}

function BillStatus() {
	if (Gebi('BillCheck').checked) Gebi('BilledField').style.visibility='visible'; else Gebi('BilledField').style.visibility='hidden'; 
	if (Gebi('BilledCheck').checked) Gebi('BillField').style.visibility='hidden'; else Gebi('BillField').style.visibility='visible'; 
}
















function EventProjectSelect() // shows certain select options when certain tasks are selected from the TASK dropdown
{
	var Selected = Gebi("TaskList").value;
	
	if(Selected == 1 || Selected == 3 || Selected == 4 || Selected == 6) {
		if(Selected == 1) {
			Gebi('EventDetailsScreen').style.display = 'none';
			Gebi('EventDetails2').style.display = 'none';
			Gebi('JobName').options.selectedIndex=0;
			Gebi('SuperList').options.selectedIndex=0;
			Gebi('AreaList').options.selectedIndex=0;
			Gebi('AreaList2').options.selectedIndex=0;
			Gebi('CustomerList').options.selectedIndex=0;
			Gebi('PhaseList').options.selectedIndex=0;
			Gebi('CrewList').options.selectedIndex=0;
			var CrewObj=Gebi('NewEstCrew')
			if(CrewObj!=null) {CrewObj.value = 'Crew:';}
		}
		
		if(Selected == 3 || Selected == 4 || Selected == 6) {
			Gebi('EventDetailsScreen').style.display = 'none';
			Gebi('EventDetails2').style.display = 'block';
			Gebi('JobName').options.selectedIndex=0;
			Gebi('SuperList').options.selectedIndex=0;
			Gebi('AreaList').options.selectedIndex=0;
			Gebi('AreaList2').options.selectedIndex=0;
			Gebi('CustomerList').options.selectedIndex=0;
			Gebi('PhaseList').options.selectedIndex=0;
			Gebi('CrewList').options.selectedIndex=0;
			var CrewObj=Gebi('NewEstCrew')
			if(CrewObj!=null) {CrewObj.value = 'Crew:';}
		}		
		
	}
	else
	{
		Gebi('EventDetailsScreen').style.display = 'block';
		Gebi('EventDetails2').style.display = 'none';
		Gebi('JobName').options.selectedIndex=0;
		Gebi('SuperList').options.selectedIndex=0;
		Gebi('AreaList').options.selectedIndex=0;
		Gebi('AreaList2').options.selectedIndex=0;
		Gebi('CustomerList').options.selectedIndex=0;
		Gebi('PhaseList').options.selectedIndex=0;
		Gebi('CrewList').options.selectedIndex=0;
		var CrewObj=Gebi('NewEstCrew')
		if(CrewObj!=null) {CrewObj.value = 'Crew:';}
	}
	
}






 
  
//Deletes an Event---------------------------------------------------- 
 
 function EventDeleteConfirm() {
	
	if (confirm("Are you sure you want to delete this Event?.")) {
	   DeleteEvent();
	   return false;
	   
	}
	else
	{
	return false;
	}
}
 
 

 
 
////////////////////////////////////////////Views////////////////////////////////////////////////////////////////////////
 
var QuickViewID = '';
 
function QuickView(TaskID) {
    QuickViewID = TaskID;
   
	Gebi('ViewAttn').options.selectedIndex=0;
	Gebi('ViewTask').options.selectedIndex=0;
	Gebi('ViewPM').options.selectedIndex=0;
	Gebi('ViewArea').options.selectedIndex=0;
	Gebi('ViewPhase').options.selectedIndex=0;
	Gebi('ViewCustomer').options.selectedIndex=0;
				
				
	if(ViewShowing == 'Month') {Make_Calendar(YearShowing,MonthShowing,1);}
	if(ViewShowing == 'Week') {Make_Week(1,YearShowing,WeekShowing);}
   
} 

function DetailView() {
   QuickViewID = '';
   
   if(ViewShowing == 'Month') {Make_Calendar(YearShowing,MonthShowing,1);}
   if(ViewShowing == 'Week') {Make_Week(1,YearShowing,WeekShowing);}
   
} 

function ClearViews() {
    QuickViewID = '';
   
	Gebi('ViewAttn').options.selectedIndex=0;
	Gebi('ViewTask').options.selectedIndex=0;
	Gebi('ViewPM').options.selectedIndex=0;
	Gebi('ViewArea').options.selectedIndex=0;
	Gebi('ViewPhase').options.selectedIndex=0;
	Gebi('ViewCustomer').options.selectedIndex=0;
				

   
}
 
 
 
function HoverUpdate(sDate) { 
	DateOnHover = sDate; 
	Gebi('HoverNotes').style.visibility='hidden';
}
 
 
 
 
 
function EventClickUpdate(CalID) {
	EventClickID = CalID;
	CapturedID=CalID;
	alert(EventClickID);
}
 
 
 
 
 
 



 
 
 
 
 
 //Buble Hover//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function showEventBubble(inst,ev,sDate,sDay,Row,Col) {
	if(document.all)ev = event;
		if(Box_Event_Click==1) {
			Box_Event_Click=0;
			return;
		}
		
		Gebi('DateID').value =sDate;
		Gebi('EmployeesSelect').options[0].selected = true;
		Gebi('DateDayID').value =sDay;
		
		Gebi('BubbleTop').innerHTML = 
			('<div align="right" class="BubbleTopPlain">')+
			('	<div class="TopDivTopPlain"><a href="Javascript:Void()" onMouseUp="hideToolTip();"><img src="../../images/close12X12.gif" height="12px" width-"12px" border="0"  margin="0" padding="0"/></a></div>')+
			('</div>');
		Gebi('DayNotes').innerHTML = ('');					  
		Gebi('BubbleBottom').innerHTML = ('<div class="BubbleBottomPlain"></div>');
			
		//var obj = Gebi('bubble_tooltip');
		
		var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
		
		if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
		
		//obj.style.display = 'block';
			
		//  This Positions the popup relative to the mouse pointer-------------------------
		
		if(Row == 1 || Row == 2) {
			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Row == 3 || Row == 4 || Row == 5 || Row == 6) {
			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}
		
		if(Col == 1 && (Row == 1 || Row == 2)) {
			var leftPos = ev.clientX - 80;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Col == 1 && (Row == 3 || Row == 4 || Row == 5 || Row == 6)) {
			var leftPos = ev.clientX - 80;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}			


		
		if(Col == 2 && (Row == 1 || Row == 2)) {
			var leftPos = ev.clientX - 120;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Col == 2 && (Row == 3 || Row == 4 || Row == 5 || Row == 6)) {
			var leftPos = ev.clientX - 120;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}
		
		
		
		if(Col == 7 && (Row == 1 || Row == 2)) {
			var leftPos = ev.clientX - 270;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Col == 7 && (Row == 3 || Row == 4 || Row == 5 || Row == 6)) {
			var leftPos = ev.clientX - 270;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}
}


function hideToolTip() {
	//Gebi('bubble_tooltip').style.display = 'none';
}
  
  
  
  
  
  
//Popup Hover//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function showPopup(PopID,ev,Position) {
	var PopupID =  ('Popup'+PopID);
	//Gebi(PopupID).innerHTML = ('Hi');
	var obj = Gebi(PopupID);
	
	var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
	
	if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
	
	obj.style.display = 'block';

	//find the div height and width
	var DivHeight = (obj.offsetHeight);
	var DivWidth = (obj.offsetWidth);
	var HalfWidth = (DivWidth*.5);
	var aHeight = parseInt(DivHeight);
	var HeightAdj = (aHeight+10);
	
				
	if (Position == 'Top') {	
		var leftPos = ev.clientX - HalfWidth;
		if(leftPos<0)leftPos = 0;
		obj.style.left = leftPos + 'px';
		obj.style.top = ev.clientY - obj.offsetHeight -20 + st + 'px';
	}
		
	if (Position == 'Bottom') {
		var leftPos = ev.clientX - HalfWidth;
		if(leftPos<0)leftPos = 0;
		obj.style.left = leftPos + 'px';
		obj.style.top = ev.clientY - obj.offsetHeight +HeightAdj + st + 'px';
	}
	//alert(obj.offsetTop + "," + obj.offsetLeft);
		
	GoToToday(PopID);
}


function hidePopup(PopID) {
		alert(PopID);
		Gebi(PopID).style.display = 'none';
	
}
  
  
  
//Set  
function PopupSet(sDate,sObject,PopID) {
var PopupID =  ('Popup'+PopID);
Gebi(sObject).value = sDate;

hidePopup(PopupID);
} 
  
  
  
//AJAX For Loading the Event List popup--////////////////////////////////////////////////

function EventListAJAX(sDate) {
	  var ev = event;
	
	  var aDate = '9/17/2008';
      xmlHttp = GetXmlHttpObject();
	  	  
	  xmlHttp.onreadystatechange = showEventListAJAX;
	  xmlHttp.open('GET','CalendarASP.asp?action=DayEvents&Event='+ev+'&CSS=WeekEvent&Date='+aDate, true);
	  xmlHttp.send(null);
}



function showEventListAJAX() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var DayEvents = xmlDoc.getElementsByTagName('Event')[0].childNodes[0].nodeValue;
												
			var ev = event;
			if(document.all)ev = event;
	
			Gebi('EventPopupItems').innerHTML = ('<div>Hi Bob</div>');
			
			var obj = Gebi('EventPopup');
			
			var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
			
			if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
			
			obj.style.display = 'block';
			
			//  This Positions the popup relative to the mouse pointer-------------------------
			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			obj.style.left = leftPos + 'px';
			obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		} else {
		 alert('There was a problem with the CalendarJS-showEventListAJAX request.');
}	} }


function showEventList(sDate) {
	var ev = event;
	if(document.all)ev = event;
	
	alert(event);
	
	Gebi('EventPopupItems').innerHTML = ('<div>Hi Bob</div>');
	
	var obj = Gebi('EventPopup');
	
	var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
	
	if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
	
	obj.style.display = 'block';
	
	//  This Positions the popup relative to the mouse pointer-------------------------
	
	
	var leftPos = ev.clientX - 220;
	if(leftPos<0)leftPos = 0;
	obj.style.left = leftPos + 'px';
	obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
}


function hideEventList() { Gebi('EventPopup').style.display = 'none'; }
  
function showDatePicker(ev) {
	if(document.all)ev = event;
	
	//Gebi('DatePicker').innerHTML = ('BOB');
	
	var obj = Gebi('DatePicker');
	
	var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
	
	if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
	
	obj.style.display = 'block';
	
	//This Positions the popup relative to the mouse pointer-------------------------

	var leftPos = ev.clientX - 220;
	if(leftPos<0)leftPos = 0;
	obj.style.left = leftPos + 'px';
	obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
}

function hideDatePicker() { Gebi('ModalScreen').style.display = 'none'; }


var mX;
var mY;
document.onmousemove = function (event) {
	if (!event) {event = window.event;}
	mX = event.clientX;
	mY = event.clientY;
}
var ThisObject = new Object;
function FadeIn(Obj) {
	Obj.style.filter='alpha(opacity=0)';
	ThisObject=Obj;
	for(i=1;i<=25;i++) {	setTimeout("ThisObject.style.filter='alpha(opacity="+(i*4)+")'",i*10);	}
}

function HideEventNotes() { Gebi('HoverNotes').style.visiblity='hidden'; }

function PosEventNotes() {
	var PosX=24;//X Distance from Cursor Hotspot
	var PosY=24;//Y Distance from Cursor Hotspot
	
	//If it goes off the right edge, switch to the left side
	if(mX+PosX+Gebi('HoverNotes').offsetWidth>=document.body.offsetWidth) {PosX=0-Gebi('HoverNotes').offsetWidth;}
	
	//If it goes off the bottom edge, switch to the top side
	if(mY+PosY+Gebi('HoverNotes').offsetHeight+48>=document.body.offsetHeight) {PosY=0-Gebi('HoverNotes').offsetHeight} 
			
	//HoverNotes.innerHTML=(mX+'  '+PosX+'  '+mY+'  '+PosY);
	//alert(mX+'+'+PosX);
	if(isNaN(mX)||isNaN(PosX)||isNaN(mY)||isNaN(PosY)) { alert('mX:'+mX+'  PosX:'+PosX+' mY:'+mY+'  PosY:'+PosY); return false;}
	
	var doThis=(Gebi('HoverNotes').style.left = Math.abs(mX+PosX)+'px');
	
	if(doThis) {} else {alert('mX:'+mX+'  PosX:'+PosX)/**/}
	doThis=(Gebi('HoverNotes').style.top = Math.abs(mY+PosY)+'px');
	if(doThis) {} else {alert('mY:'+mY+'  PosY:'+PosY)/**/}
}
