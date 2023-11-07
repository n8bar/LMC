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

function Void(){}




var SelectedDate=null;
//Modal For New Events  ///////////////////////////////////////////////////////////////////////////////////////  
function ShowEventModal(Source,inst,sDate, RemoteCode)
{
	if(Box_Event_Click==1) //Makes it so this popup does not activate if you click the one above it
	{
		Box_Event_Click=0;
		return;
	}  
	
	SelectedDate=sDate
	
	if(RemoteCode!='NewEvent'){Gebi('NewEventTaskBox').style.display='block';} //Show the New Event cateory window if not coming from another tab.
	
	/**/
	
	for(i=1;i<Gebi('AttnList').length;i++)
	{
		if(Gebi('AttnList')[i].value==parent.accessEmpID)	{Gebi('AttnList').selectedIndex=i;}
	}
	
	document.getElementById('EventTopL').style.background = '#3599E3';
	document.getElementById('EventTopR').style.background = '#3599E3';
	document.getElementById('EventHeaderTxt').style.Color = '#FFF';
	document.getElementById('ModalScreen').style.display = 'inline';
	document.getElementById('NewEventBox').style.display = 'inline';
	document.getElementById('EventDetailsScreen').style.display = 'block';
	document.getElementById('EventDetails2').style.display = 'none';
	document.getElementById('EventDelete').style.display = 'none';
	
	sDate=sDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
	document.getElementById('Source').value = Source;
	document.getElementById('FromDateTxt').value = sDate;
	document.getElementById('ToDateTxt').value = sDate;
	document.getElementById('EventTitleText').value = '';
	document.getElementById('EventNewNotes').value = '';
	document.getElementById('CrewNames').value = 'Crew:';
	document.getElementById('EventID').value = '';
	//document.getElementById('AttnList').value = 1500;
	document.getElementById('TaskList').options.selectedIndex=0;
	document.getElementById('EventRepeat').options.selectedIndex=0;
	document.getElementById('SuperList').options.selectedIndex=0;
	document.getElementById('AreaList').options.selectedIndex=0;
	document.getElementById('AreaList2').options.selectedIndex=0;
	document.getElementById('CustomerList').options.selectedIndex=0;
	document.getElementById('CrewList').options.selectedIndex=0;

	document.getElementById('EventHeaderTxt').innerHTML = 'Create New Event';
	document.getElementById('EventDelete').style.display = 'none';
	
	document.getElementById('DoneCheck').checked = false;
  }   
  
  
  
function hideEventModal()
{
	document.getElementById('ModalScreen').style.display = 'none';
	document.getElementById('NewEventBox').style.display = 'none';
	document.getElementById('NewEventTaskBox').style.display = 'none';
}
  


function TaskListerRedirect(TaskNum,TaskIndex)
{
	//alert(TaskNum.toString());
	switch(TaskNum.toString())
	{
		case '1' : // -------------General Note------------------
			
			Gebi('ProjectSelectionBox').style.display='block';
					 
						
			return true;
		break; // -------------General Note------------------
		
		case '//2' : // -------------General Note------------------
			//alert('u got 2');
			
			parent.document.getElementById('GeneralIframe').contentWindow.document.getElementById('txtDate').value=SelectedDate;
			parent.ShowGeneral();
			parent.document.getElementById('GeneralIframe').contentWindow.TaskBox('New Task');
			hideEventModal();
			parent.document.getElementById('GeneralIframe').contentWindow.document.getElementById('txtJob').focus();
						
			return true;
		break; // -------------General Note------------------
		
		case '//3' : // -------------General Note------------------
			
			parent.document.getElementById('ServiceIframe').contentWindow.document.getElementById('txtDate').value=SelectedDate;
			parent.ShowService();
			parent.document.getElementById('ServiceIframe').contentWindow.TaskBox('New Task');
			hideEventModal();
			parent.document.getElementById('ServiceIframe').contentWindow.document.getElementById('txtJob').focus();
						
			return true;
		break; // -------------General Note------------------
		
		case '//4' : // -------------General Note------------------
						
			parent.document.getElementById('TestMaintIframe').contentWindow.document.getElementById('txtDate').value=SelectedDate;
			parent.ShowTestMaint();
			parent.document.getElementById('TestMaintIframe').contentWindow.TaskBox('New Task');
			hideEventModal();
			parent.document.getElementById('TestMaintIframe').contentWindow.document.getElementById('txtJob').focus();
						
			return true;
		break; // -------------General Note------------------
		
/*

		case  // -------------//------------------
		
		break; // -------------//------------------
		
*/		
		
		default:
			//alert('u got default');
			Gebi('TaskList').selectedIndex=TaskIndex;
			Gebi('NewEventTaskBox').style.display='none';
			return false;
		break;
	}
}

function ProjRedirect(ProjID)
{
	var ProjFrame=parent.document.getElementById('ProjectsIframe');
	ProjFrame.src='ProjMan.asp?ProjID='+ProjID;
	parent.ShowProjects();
	hideEventModal();
	
	Gebi('ProjectSelectionBox').style.display='none';
	ProjRedirectShedule();
}
var SchTries=0;
function ProjRedirectShedule(ProjID)	
{
	try
	{
		parent.document.getElementById('ProjectsIframe').contentWindow.document.getElementById('SchFrame').contentWindow.NewSched(SelectedDate);
		parent.document.getElementById('ProjectsIframe').contentWindow.DataTabs('Schedu','Schedule');
		SchTries=0;
	}
	catch(e)
	{
		SchTries++;
		if(SchTries>99){return false}
		setTimeout('ProjRedirectShedule('+ProjID+');',500);
	}
}
  
function ToDateChange() //Formats the TO Date 
{
	
	var DateFrom = document.getElementById('FromDateTxt').value;
	DateFrom=DateFrom.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
	var fromMonth = parseInt(DateFrom.split("/")[0],10);
	var fromDay = parseInt(DateFrom.split("/")[1],10);
	var fromYear = parseInt(DateFrom.split("/")[2],10);
	
	var DateTo = document.getElementById('ToDateTxt').value;
	DateTo=DateTo.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
	var ToMonth = parseInt(DateTo.split("/")[0],10);
	var ToDay = parseInt(DateTo.split("/")[1],10);
	var ToYear = parseInt(DateTo.split("/")[2],10);
	
	if (ToYear < fromYear){alert('Please enter a higher To: Year'); document.getElementById('ToDateTxt').value = DateFrom}
	if ((ToYear <= fromYear)&&(ToMonth < fromMonth) ){alert('Please enter a higher To: Month'); document.getElementById('ToDateTxt').value = DateFrom}
	if ((ToYear <= fromYear)&&(ToMonth <= fromMonth)&&(ToDay < fromDay)){alert('Please enter a higher To: Day'); document.getElementById('ToDateTxt').value = DateFrom}

}


















function EventProjectSelect() // shows certain select options when certain tasks are selected from the TASK dropdown
{
	var Selected = document.getElementById("TaskList").value;
	
	if(Selected == 1 || Selected == 3 || Selected == 4 || Selected == 6)
	{
		if(Selected == 1)
		{
			document.getElementById('EventDetailsScreen').style.display = 'none';
			document.getElementById('EventDetails2').style.display = 'none';
			document.getElementById('JobName').options.selectedIndex=0;
			document.getElementById('SuperList').options.selectedIndex=0;
			document.getElementById('AreaList').options.selectedIndex=0;
			document.getElementById('AreaList2').options.selectedIndex=0;
			document.getElementById('CustomerList').options.selectedIndex=0;
			document.getElementById('PhaseList').options.selectedIndex=0;
			document.getElementById('CrewList').options.selectedIndex=0;
			var CrewObj=document.getElementById('NewEstCrew')
			if(CrewObj!=null){CrewObj.value = 'Crew:';}
		}
		
		if(Selected == 3 || Selected == 4 || Selected == 6)
		{
			document.getElementById('EventDetailsScreen').style.display = 'none';
			document.getElementById('EventDetails2').style.display = 'block';
			document.getElementById('JobName').options.selectedIndex=0;
			document.getElementById('SuperList').options.selectedIndex=0;
			document.getElementById('AreaList').options.selectedIndex=0;
			document.getElementById('AreaList2').options.selectedIndex=0;
			document.getElementById('CustomerList').options.selectedIndex=0;
			document.getElementById('PhaseList').options.selectedIndex=0;
			document.getElementById('CrewList').options.selectedIndex=0;
			var CrewObj=document.getElementById('NewEstCrew')
			if(CrewObj!=null){CrewObj.value = 'Crew:';}
		}		
		
	}
	else
	{
		document.getElementById('EventDetailsScreen').style.display = 'block';
		document.getElementById('EventDetails2').style.display = 'none';
		document.getElementById('JobName').options.selectedIndex=0;
		document.getElementById('SuperList').options.selectedIndex=0;
		document.getElementById('AreaList').options.selectedIndex=0;
		document.getElementById('AreaList2').options.selectedIndex=0;
		document.getElementById('CustomerList').options.selectedIndex=0;
		document.getElementById('PhaseList').options.selectedIndex=0;
		document.getElementById('CrewList').options.selectedIndex=0;
		var CrewObj=document.getElementById('NewEstCrew')
		if(CrewObj!=null){CrewObj.value = 'Crew:';}
	}
	
}






 
  
//Deletes an Event---------------------------------------------------- 
 
 function EventDeleteConfirm()
{
	
	if (confirm("Are you sure you want to delete this Event?."))
	{
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
 
function QuickView(TaskID)
{
    QuickViewID = TaskID;
   
	document.getElementById('ViewAttn').options.selectedIndex=0;
	document.getElementById('ViewTask').options.selectedIndex=0;
	document.getElementById('ViewPM').options.selectedIndex=0;
	document.getElementById('ViewArea').options.selectedIndex=0;
	document.getElementById('ViewPhase').options.selectedIndex=0;
	document.getElementById('ViewCustomer').options.selectedIndex=0;
				
				
	if(ViewShowing == 'Month'){Make_Calendar(YearShowing,MonthShowing,1);}
	if(ViewShowing == 'Week'){Make_Week(1,YearShowing,WeekShowing);}
   
} 

function DetailView()
{
   QuickViewID = '';
   
   if(ViewShowing == 'Month'){Make_Calendar(YearShowing,MonthShowing,1);}
   if(ViewShowing == 'Week'){Make_Week(1,YearShowing,WeekShowing);}
   
} 

function ClearViews()
{
    QuickViewID = '';
   
	document.getElementById('ViewAttn').options.selectedIndex=0;
	document.getElementById('ViewTask').options.selectedIndex=0;
	document.getElementById('ViewPM').options.selectedIndex=0;
	document.getElementById('ViewArea').options.selectedIndex=0;
	document.getElementById('ViewPhase').options.selectedIndex=0;
	document.getElementById('ViewCustomer').options.selectedIndex=0;
				

   
}
 
 
 
function HoverUpdate(sDate)
{
//alert(sDate);
DateOnHover = sDate;

	
}
 
 
 
 
 
function EventClickUpdate(CalID)
{
	
	EventClickID = CalID;
	CapturedID=CalID;
	alert(EventClickID);

}
 
 
 
 
 
 



 
 
 
 
 
 //Buble Hover//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function showEventBubble(inst,ev,sDate,sDay,Row,Col)
  {
	  
	
	
	
	if(document.all)ev = event;
	
   
		if(Box_Event_Click==1)
		{
            Box_Event_Click=0;
            return;
        }
		
			
			
			document.getElementById('DateID').value =sDate;
			document.getElementById('EmployeesSelect').options[0].selected = true;
			document.getElementById('DateDayID').value =sDay;
			
			document.getElementById('BubbleTop').innerHTML = ('<div align="right" class="BubbleTopPlain">')+
								  ('<div class="TopDivTopPlain"><a href="Javascript:Void()" onMouseUp="hideToolTip();"><img src="Images/close12X12.gif" height="12px" width-"12px" border="0"  margin="0" padding="0"/></a></div>')+
								  ('</div>');
			document.getElementById('DayNotes').innerHTML = ('');					  
			document.getElementById('BubbleBottom').innerHTML = ('<div class="BubbleBottomPlain"></div>');
			
			//var obj = document.getElementById('bubble_tooltip');
			
			var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
			
			if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
			
			//obj.style.display = 'block';
			
		//  This Positions the popup relative to the mouse pointer-------------------------
		
		if(Row == 1 || Row == 2)
		{
			
			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Row == 3 || Row == 4 || Row == 5 || Row == 6)
		{
				
			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}
		
		
	   if(Col == 1 && (Row == 1 || Row == 2))
		{
			
			var leftPos = ev.clientX - 80;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Col == 1 && (Row == 3 || Row == 4 || Row == 5 || Row == 6))
		{
				
			var leftPos = ev.clientX - 80;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}			


		
		if(Col == 2 && (Row == 1 || Row == 2))
		{
			
			var leftPos = ev.clientX - 120;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Col == 2 && (Row == 3 || Row == 4 || Row == 5 || Row == 6))
		{
				
			var leftPos = ev.clientX - 120;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}
		
		
		
		if(Col == 7 && (Row == 1 || Row == 2))
		{
			
			var leftPos = ev.clientX - 270;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
		}
			
			
		if(Col == 7 && (Row == 3 || Row == 4 || Row == 5 || Row == 6))
		{
				
			var leftPos = ev.clientX - 270;
			if(leftPos<0)leftPos = 0;
			//obj.style.left = leftPos + 'px';
			//obj.style.top = ev.clientY - obj.offsetHeight -1 + st + 'px';	
		}
		
		
 }


function hideToolTip()
  {
	//document.getElementById('bubble_tooltip').style.display = 'none';
	
  }
  
  
  
  
  
  
//Popup Hover//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function showPopup(PopID,ev,Position)
  {
	  
  
	var PopupID =  ('Popup'+PopID);
   
 	  
//document.getElementById(PopupID).innerHTML = ('Hi');


		var obj = document.getElementById(PopupID);
		
		var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
		
		if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
		
		obj.style.display = 'block';

	//find the div height and width
		var DivHeight = (obj.offsetHeight);
		var DivWidth = (obj.offsetWidth);
	    var HalfWidth = (DivWidth*.5);
		var aHeight = parseInt(DivHeight);
		var HeightAdj = (aHeight+10);
		
					
		if (Position == 'Top'){	
			
		    var leftPos = ev.clientX - HalfWidth;
			if(leftPos<0)leftPos = 0;
			obj.style.left = leftPos + 'px';
			obj.style.top = ev.clientY - obj.offsetHeight -20 + st + 'px';
		}
		
 		if (Position == 'Bottom'){
			var leftPos = ev.clientX - HalfWidth;
			if(leftPos<0)leftPos = 0;
			obj.style.left = leftPos + 'px';
			obj.style.top = ev.clientY - obj.offsetHeight +HeightAdj + st + 'px';
		}
		//alert(obj.offsetTop + "," + obj.offsetLeft);
		
    
	
	GoToToday(PopID);

 }


function hidePopup(PopID)
  {
		alert(PopID);
		document.getElementById(PopID).style.display = 'none';
	
  }
  
  
  
//Set  
 function PopupSet(sDate,sObject,PopID)
  {
	var PopupID =  ('Popup'+PopID);
	document.getElementById(sObject).value = sDate;
	
	hidePopup(PopupID);
	
  } 
  
  
  







//AJAX For Loading the Event List popup--////////////////////////////////////////////////

function EventListAJAX(sDate)
{
	  var ev = event;
	
	  var aDate = '9/17/2008';
      xmlHttp = GetXmlHttpObject();
	  	  
	  xmlHttp.onreadystatechange = showEventListAJAX;
	  xmlHttp.open('GET','CalendarASP.asp?action=DayEvents&Event='+ev+'&CSS=WeekEvent&Date='+aDate, true);
	  xmlHttp.send(null);
}



function showEventListAJAX()
{
	
	
      if (xmlHttp.readyState == 4)
	  {
		
		
		if (xmlHttp.status == 200)
	    {
			
           var xmlDoc = xmlHttp.responseXML.documentElement;
		   var DayEvents = xmlDoc.getElementsByTagName('Event')[0].childNodes[0].nodeValue;
												
			var ev = event;
			if(document.all)ev = event;
	
	        document.getElementById('EventPopupItems').innerHTML = ('<div>Hi Bob</div>');
			
			var obj = document.getElementById('EventPopup');
			
			var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
			
			if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
			
			obj.style.display = 'block';
			
		//  This Positions the popup relative to the mouse pointer-------------------------

			
			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			obj.style.left = leftPos + 'px';
			obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	
			
			
						
         }
		 else
		 {
            alert('There was a problem with the CalendarJS-showEventListAJAX request.');
         }
      }


}

function showEventList(sDate)
  {
	  
			var ev = event;
			if(document.all)ev = event;
			
			alert(event);
	
	        document.getElementById('EventPopupItems').innerHTML = ('<div>Hi Bob</div>');
			
			var obj = document.getElementById('EventPopup');
			
			var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
			
			if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
			
			obj.style.display = 'block';
			
		//  This Positions the popup relative to the mouse pointer-------------------------

			
			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			obj.style.left = leftPos + 'px';
			obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	

		
		
 }


function hideEventList()
  {
	document.getElementById('EventPopup').style.display = 'none';
	
  }
  
  
  
  function showDatePicker(ev)
  {
	  
	
	
	
	if(document.all)ev = event;
	
				  
			//document.getElementById('DatePicker').innerHTML = ('BOB');
			
			var obj = document.getElementById('DatePicker');
			
			var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
			
			if(navigator.userAgent.toLowerCase().indexOf('safari')>=0)st=0;
			
			obj.style.display = 'block';
			
		//  This Positions the popup relative to the mouse pointer-------------------------

			var leftPos = ev.clientX - 220;
			if(leftPos<0)leftPos = 0;
			obj.style.left = leftPos + 'px';
			obj.style.top = ev.clientY - obj.offsetHeight +220 + st + 'px';	


		
		
 }


function hideDatePicker()
  {
	document.getElementById('ModalScreen').style.display = 'none';
	
  }




var mX
var mY
document.onmousemove = function (event)
{
	if (!event){event = window.event;}
	mX = event.clientX;
	mY = event.clientY;
}
var ThisObject = new Object;
function FadeIn(Obj)
{
	Obj.style.filter='alpha(opacity=0)';
	ThisObject=Obj;
	for(i=1;i<=25;i++)
	{
		setTimeout("ThisObject.style.filter='alpha(opacity="+(i*4)+")'",i*10);
	}
}


function HideEventNotes(){HoverNotes.style.display='none';/**/}
function PosEventNotes()
{
	var PosX=24;//X Distance from Cursor Hotspot
	var PosY=24;//Y Distance from Cursor Hotspot
	
	if(mX+PosX+HoverNotes.offsetWidth>=document.body.offsetWidth){PosX=0-HoverNotes.offsetWidth;}	//If it goes off the right edge, switch to the left side
	if(mY+PosY+HoverNotes.offsetHeight+48>=document.body.offsetHeight){PosY=0-HoverNotes.offsetHeight} //If it goes off the bottom edge, switch to the top side
			
	//HoverNotes.innerHTML=(mX+'  '+PosX+'  '+mY+'  '+PosY);
	//alert(mX+'+'+PosX);
	if(isNaN(mX)||isNaN(PosX)||isNaN(mY)||isNaN(PosY)){return false;}
	var doThis=(document.getElementById('HoverNotes').style.left = Math.abs(mX+PosX)+'px')
	if(doThis){}else{alert('mX:'+mX+'  PosX:'+PosX)/**/}
	doThis=(document.getElementById('HoverNotes').style.top = Math.abs(mY+PosY)+'px')
	if(doThis){}else{alert('mY:'+mY+'  PosY:'+PosY)/**/}
}
