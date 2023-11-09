// JavaScript Document
var GetTaskListSw = 0;








var xmlHttp;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
  
  	if (xmlHttp==null)
	  {
	  alert ("Your browser does not support AJAX!");
	  return;
	  }
	  
	  
return xmlHttp;
}
//------------------------------------------------------------------------------------------------




















//AJAX Loads all of the Calendar day events--////////////////////////////////////////////////
var CalEventsUrlString;
var EventCountMax;
function CalendarEventsAJAX(DayArray)
{
	if(document.getElementById("ViewAttn")==null){return false}
	sArray = encodeURIComponent( DayArray.join(",") );
	var ViewAttn = document.getElementById("ViewAttn").value;
	var ViewTask = document.getElementById("ViewTask").value;
	var ViewPM = document.getElementById("ViewPM").value;
	var ViewArea = document.getElementById("ViewArea").value;
	var ViewPhase = document.getElementById("ViewPhase").value;
	var ViewCustomer = document.getElementById("ViewCustomer").value;
	
	if(CalRows==6){EventCountMax=4}
	if(CalRows==5){EventCountMax=5}
	if(CalRows==4){EventCountMax=6}
	if(document.body.offsetHeight<480){alert('The size of the window is too small to display the calendar. \n\n Just press F11 to go fullscreen then F5 to reload')}
	if(document.body.offsetHeight>640){EventCountMax+=(CalRows-4)}
	if(document.body.offsetHeight>768){EventCountMax+=(CalRows-4)}
	if(document.body.offsetHeight>896){EventCountMax+=(CalRows-3)}
	if(document.body.offsetHeight>960){EventCountMax+=(CalRows-3)}
	if(document.body.offsetHeight>1024){EventCountMax+=(CalRows-3)}
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCalEventsAJAX;
	var URLstring = 'CalendarASP.asp?action=CalendarEvents&CSS=DayEvent&Array='+sArray+'&QuickViewID='+QuickViewID+'&Source=Month';
	URLstring += '&ViewAttn='+ViewAttn+'&ViewTask='+ViewTask+'&ViewPM='+ViewPM+'&ViewArea='+ViewArea+'&ViewPhase='+ViewPhase+'&ViewCustomer='+ViewCustomer+'&EventCountMax='+EventCountMax+'&IE='+IEver;
	xmlHttp.open('GET',URLstring, true);
	xmlHttp.send(null);
	CalEventsUrlString=URLstring;
	//window.location=CalEventsUrlString;
	
	
	//if(xmlHttp.status==200)//Firefox code for SJAX (AJAX doesn't need this line)
	//{ReturnCalEventsAJAX();}
	
}
function ReturnCalEventsAJAX()
{
	if (xmlHttp.readyState == 4)
	{
	 if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var ArrLen = xmlDoc.getElementsByTagName("ArrayLength")[0].childNodes[0].nodeValue;
			var DayEv = '';
			for (i = 1; i <= ArrLen; i++)
			{
				var EventXML = 'Event'+i;
				var EventXML2 = 'Event2'+i;
				var DateIDXML = 'DateID'+i;
				var EventCount = 'EventCount'+i;
				var DayEvents = xmlDoc.getElementsByTagName(EventXML)[0].childNodes[0].nodeValue;
				var DayEventsAll = xmlDoc.getElementsByTagName(EventXML2)[0].childNodes[0].nodeValue;
				var DayID = xmlDoc.getElementsByTagName(DateIDXML)[0].childNodes[0].nodeValue;
				var aDayID = xmlDoc.getElementsByTagName(DateIDXML)[0].childNodes[0].nodeValue;
				DayID = 'Day'+DayID;
				
				if(DayEvents != '-No Data-')
				{
					document.getElementById(DayID).innerHTML += DayEvents; 
					DayEv += DayEvents+'-'+DayID;	
					var EventQty = xmlDoc.getElementsByTagName(EventCount)[0].childNodes[0].nodeValue;
					var EventOver = (parseInt(EventQty) -EventCountMax);
					var EventOverflow = EventOver+'';
					if(EventOverflow >=1)
					{
						Gebi(DayID).innerHTML+='<div class="OverflowNumber">'/*<a href="#" onclick="showEventHover(); EventListAJAX("'+aDayID+'");">'*/+'+'+EventOverflow+/*'</a>*/'</div>';
					}
				}
			}
			if(GetTaskListSw == 0){GetTaskList();}
			initDragDropScript();
			GetTaskListSw = 1;
		}
		else
		{
			alert('There was a problem with the request.  CalendarEventsAJAX');
			window.location=CalEventsUrlString;
		}
	}
}
//-------------------------------------------------------------------------------------------------







//AJAX Loads all of the Week events--////////////////////////////////////////////////
function WeekEventsAJAX(WeekArray)
{
		sArray = encodeURIComponent( WeekArray.join(",") );
	  var ViewAttn = document.getElementById("ViewAttn").value;
	  var ViewTask = document.getElementById("ViewTask").value;
	  var ViewPM = document.getElementById("ViewPM").value;
	  var ViewArea = document.getElementById("ViewArea").value;
	  var ViewPhase = document.getElementById("ViewPhase").value;
	  var ViewCustomer = document.getElementById("ViewCustomer").value;
	  
		if(CalRows==6){EventCountMax=4}
		if(CalRows==5){EventCountMax=5}
		if(CalRows==4){EventCountMax=6}
		
		xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnWeekEventsAJAX;
	  var URLstring = 'CalendarASP.asp?action=CalendarEvents&CSS=DayEvent&Array='+sArray+'&QuickViewID='+QuickViewID+'&Source=Week';
	      URLstring += '&ViewAttn='+ViewAttn+'&ViewTask='+ViewTask+'&ViewPM='+ViewPM+'&ViewArea='+ViewArea+'&ViewPhase='+ViewPhase+'&ViewCustomer='+ViewCustomer+'&EventCountMax='+EventCountMax+'&IE='+IEver;
	  xmlHttp.open('GET',URLstring, true);
	  xmlHttp.send(null);
}


function ReturnWeekEventsAJAX()
{
	
	
      if (xmlHttp.readyState == 4)
	  {
		 
		 if (xmlHttp.status == 200)
	    {
           			var xmlDoc = xmlHttp.responseXML.documentElement;
			var ArrLen = xmlDoc.getElementsByTagName("ArrayLength")[0].childNodes[0].nodeValue;
			

			var DayEv = '';
			
			for (i = 1; i <= ArrLen; i++)
			{
				
				//EvNum += i+'';
				var EventXML = 'Event'+i;
				var DateIDXML = 'DateID'+i;
				var DayEvents = xmlDoc.getElementsByTagName(EventXML)[0].childNodes[0].nodeValue;

				var DayID = xmlDoc.getElementsByTagName(DateIDXML)[0].childNodes[0].nodeValue;
				DayID = 'Day'+DayID
				
					if(DayEvents != '-No Data-')
					{
						document.getElementById(DayID).innerHTML += DayEvents; 
						DayEv += DayEvents+'-'+DayID;	
					}
		     }
			 
			initDragDropScript();
            
         }
		 else
		 {
            alert('There was a problem with the request.  WeekEventsAJAX');
         }
      }


}
//-------------------------------------------------------------------------------------------------






















//AJAX Loads all of the Day View events--////////////////////////////////////////////////
function DayEventsAJAX(sDate)
{
      xmlHttp = GetXmlHttpObject();
	  
	  xmlHttp.onreadystatechange = ReturnDayEventsAJAX;
	  xmlHttp.open('GET','CalendarASP.asp?action=DayEvents&CSS=WeekEvent&Date='+sDate, true);
	  xmlHttp.send(null);
}


function ReturnDayEventsAJAX()
{
	
	
      if (xmlHttp.readyState == 4)
	  {
		
		
		if (xmlHttp.status == 200)
	    {
			
           var xmlDoc = xmlHttp.responseXML.documentElement;
		   var DayEvents = xmlDoc.getElementsByTagName('Event')[0].childNodes[0].nodeValue;
												
				if(DayEvents != '-No Data-')
				{
					document.getElementById('sDayEvents').innerHTML = DayEvents; 
					
				}
		     
            
         }
		 else
		 {
            alert('There was a problem with the request.  DayEventsAJAX');
         }
      }


}
//-------------------------------------------------------------------------------------------------







//Saves the Information from the day Popup Bubble--////////////////////////////////////////////////

function BubbleDayPost(obj)

	{
		
	  var EmpSelect = document.getElementById("EmployeesSelect");
      var EmpName = (EmpSelect.options[EmpSelect.selectedIndex].text);
		
	  var poststr = "Date=" + encodeURI( document.getElementById("DateID").value ) +
	  				"&Day=" + encodeURI( document.getElementById("DateDayID").value )+
				    "&Event=" + encodeURI( document.getElementById("EventInput").value )+
					"&Employee=" + encodeURI( document.getElementById("EmployeesSelect").value )+
					"&Notes=" + encodeURI( document.getElementById("DayNotes").value );				

      xmlHttp = GetXmlHttpObject();

	  xmlHttp.onreadystatechange = ReturnBubbleDayPost;
	  xmlHttp.open('POST','CalendarASP.asp?action=NewEventSingle&EmpName='+EmpName+'', true);
	  xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xmlHttp.setRequestHeader("Content-length", poststr.length);
	  xmlHttp.setRequestHeader("Connection", "close");
	  xmlHttp.send(poststr);
		  
	  	
	}


function ReturnBubbleDayPost() {
	
	
      if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	    {
			
           // var result = xmlHttp.responseText;
             
			var xmlDoc=xmlHttp.responseXML.documentElement;
			
			var sDate = xmlDoc.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
			var DayEvent = sDate;
			DayEvent=DayEvent.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
			
			DayEvent='Day'+DayEvent;
		
			document.getElementById(DayEvent).innerHTML += xmlDoc.getElementsByTagName("Event")[0].childNodes[0].nodeValue;
			
			document.getElementById('StatusLine').innerHTML = 'Completed';
			alert('-'+WeekEvent+'-');
			
			
			
         }
		 else
		 {
            alert('There was a problem with the request.   BubbleDayPost');
         }
      }
	  //hidePopup('bubble_tooltip');
   }
//-------------------------------------------------------------------------------------------------








//Saves the Information from the Event Popup--////////////////////////////////////////////////

function SaveEvent(obj)
{
	var EventID = document.getElementById("EventID").value;
	
	
	
	var Repeat1 = document.getElementById("EventRepeat");
	var Repeat = (Repeat1.options[Repeat1.selectedIndex].text);
	var Attn1 = document.getElementById("AttnList");
	var Attn = (Attn1.options[Attn1.selectedIndex].text);
	var Task1 = document.getElementById("TaskList");
	var Task  = (Task1.options[Task1.selectedIndex].text);
	//var Job1 = document.getElementById("JobName");
	//var Job = (Job1.options[Job1.selectedIndex].text);
	var Super1 = document.getElementById("SuperList");
	var Super = (Super1.options[Super1.selectedIndex].text);
	var Phase1 = document.getElementById("PhaseList");
	var Phase = (Phase1.options[Phase1.selectedIndex].text);
	var Customer = document.getElementById("CustomerList");
	var Customer = (Phase1.options[Phase1.selectedIndex].text);
	
	var EventNotes = document.getElementById("EventNewNotes").value;
	if (EventNotes == '') {EventNotes ='Notes:';}
	
	
	var Areas = document.getElementById("AreaList");
	var Area1 = (Areas.options[Areas.selectedIndex].text);
	var Area0 = document.getElementById("AreaList2");
	var Area2 = (Area0.options[Area0.selectedIndex].text);
	var AreaVal1 = document.getElementById("AreaList").value
	var AreaVal2 = document.getElementById("AreaList2").value
	if (AreaVal1 != 0) {var AreaVal = AreaVal1; var Area = Area1;}
	if (AreaVal2 != 0) {var AreaVal = AreaVal2; var Area = Area2;}
	if (AreaVal1 == 0 && AreaVal2 == 0) {var AreaVal = 0; var Area = '----';}
	
	
	var Title = document.getElementById("EventTitleText").value;
	var FromDate = document.getElementById("FromDateTxt").value;
	var ToDate = document.getElementById("ToDateTxt").value;
	var RepeatVal = document.getElementById("EventRepeat").value;
	var AttnVal = document.getElementById("AttnList").value;
	var TaskVal = document.getElementById("TaskList").value;
	//var JobVal = document.getElementById("JobList").value;
	var SuperVal = document.getElementById("SuperList").value;
	var PhaseVal = document.getElementById("PhaseList").value;
	var CustomerVal = document.getElementById("CustomerList").value;
	var CrewNames = document.getElementById("CrewNames").value;
	var Source = document.getElementById("Source").value;
	var DoneCheck = document.getElementById('DoneCheck').checked;
	
	
	if(Title == ''){alert('Please Fill Out The Title'); Gebi('EventTitleText').focus(); return;}
	if(TaskVal == '0'){alert('Error: Task Category could not be determined');  return;}
	/*
	if(FromDate == ''){alert('Please Fill Out From Date');  return;}
	if(ToDate == ''){alert('Please Fill Out To Date');  return;}
	if(AttnVal == '1500'){alert('Please Choose To Whose Attention');  return;}
	
	if (TaskVal == 1)
	{
	  if(JobValue == '0'){alert('Please Choose A Job');  return false;} 
	  if(SuperVal == '0'){alert('Please Choose A Supervisor');  return;}
	  if(AreaVal == '0'){alert('Please Choose An Area');  return;}
	  if(PhaseVal == '0'){alert('Please Choose A Phase');  return;}
	}
	
	if (TaskVal == 3  || TaskVal == 4  || TaskVal == 6)
	{
	  if(CustomerVal == '0'){alert('Please Choose A Customer');return;}
	  if(AreaVal2 == '0'){alert('Please Choose An Area'); return;}
	}
	*/
	
	if(ToDate==null||ToDate==''||ToDate=='1/1/1900') {ToDate=FromDate;}
	
	
	var poststr = "Title=" + encodeURI(Title)+
				"&Source=" + encodeURI(Source)+
				"&DoneCheck=" + encodeURI(DoneCheck)+
				"&DateFrom=" + encodeURI(FromDate)+
				"&DateTo=" + encodeURI(ToDate)+
				"&RepeatVal=" + encodeURI(RepeatVal)+
				"&Repeat=" + encodeURI(Repeat)+
				"&Notes=" + encodeURI(EventNotes)+
				"&AttnVal=" + encodeURI(AttnVal)+	
				"&Attn=" + encodeURI(Attn)+
				"&TaskVal=" + encodeURI(TaskVal)+	
				"&Task=" + encodeURI(Task)+
				//"&JobVal=" + encodeURI( document.getElementById("JobName").value )+	
				//"&Job=" + encodeURI(Job)+
				"&SuperVal=" + encodeURI(SuperVal)+	
				"&Super=" + encodeURI(Super)+
				"&AreaVal=" + encodeURI(AreaVal)+	
				"&Area=" + encodeURI(Area)+
				"&PhaseVal=" + encodeURI(PhaseVal)+	
				"&Phase=" + encodeURI(Phase)+
				"&CustomerVal=" + encodeURI(CustomerVal)+	
				"&Customer=" + encodeURI(Customer)+
				"&CrewNames=" + encodeURI(CrewNames);
	/**/			
		
	if(EventID == ''){var ActionType = 'NewEvent';} else{var ActionType = 'UpdateEvent';}	
	
	xmlHttp = GetXmlHttpObject();
	
	//alert(ActionType+'  '+EventID);
	xmlHttp.onreadystatechange = ReturnSaveEvent;
	HttpText='CalendarASP.asp?action=Events&Type='+ActionType+'&EventID='+EventID+'&'+poststr;
	xmlHttp.open('Get',HttpText, true);
	//xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	//xmlHttp.setRequestHeader("Content-length", poststr.length);
	//xmlHttp.setRequestHeader("Connection", "close");
	xmlHttp.send(null);
	
	/*AjaxErr('Skipping XML window', HttpText)*/
}


function ReturnSaveEvent() {
	
	
      if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	    {
			
            hideEventModal();
             
			var xmlDoc=xmlHttp.responseXML.documentElement;
			
			if(ViewShowing == 'Month'){GoToDateMonth(1,YearShowing,MonthShowing);}
			if(ViewShowing == 'Week'){Make_Week(1,YearShowing,WeekShowing);}
			
			
			
			
			
         }
		 else
		 {
            AjaxErr('There was a problem with the SaveEvent request.',HttpText);
         }
      }
	  //hidePopup('bubble_tooltip');
   }
//-------------------------------------------------------------------------------------------------




//AJAX Loads all of the Day View events--////////////////////////////////////////////////
function LoadExistingEvent(EventID)
{
	Box_Event_Click =1;
	
	document.getElementById('EventDelete').style.display = 'block';
	document.getElementById('EventID').value = EventID;

	if (Initiated == 0)
	{
		HttpText='CalendarASP.asp?action=GetEvent&EventID='+EventID;
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnLoadExistingEvent;
		xmlHttp.open('GET', HttpText, true);
		xmlHttp.send(null);
	}
}


function ReturnLoadExistingEvent()
{
	
	
		if (xmlHttp.readyState == 4)
	  {
		
		
		if (xmlHttp.status == 200)
	    {
			
				var xmlDoc = xmlHttp.responseXML.documentElement;
				
				
				document.getElementById('EventDetailsScreen').style.display = 'block';
				document.getElementById('EventDetails2').style.display = 'none';
				
				var Title = xmlDoc.getElementsByTagName('Title')[0].childNodes[0].nodeValue;
				var DateFrom = xmlDoc.getElementsByTagName('DateFrom')[0].childNodes[0].nodeValue;
				var DateTo = xmlDoc.getElementsByTagName('DateTo')[0].childNodes[0].nodeValue;
				var RepeatID = xmlDoc.getElementsByTagName('RepeatID')[0].childNodes[0].nodeValue;
				var Note = CharsDecode(xmlDoc.getElementsByTagName('Note')[0].childNodes[0].nodeValue).replace('--','');
				var AttentionID = xmlDoc.getElementsByTagName('AttentionID')[0].childNodes[0].nodeValue.replace('--','');
				var TaskID = xmlDoc.getElementsByTagName('TaskID')[0].childNodes[0].nodeValue.replace('--','');
				//var JobID = xmlDoc.getElementsByTagName('JobID')[0].childNodes[0].nodeValue;
				//var SuperID = xmlDoc.getElementsByTagName('SuperID')[0].childNodes[0].nodeValue;
				var AreaID = xmlDoc.getElementsByTagName('AreaID')[0].childNodes[0].nodeValue;
				var PhaseID = xmlDoc.getElementsByTagName('PhaseID')[0].childNodes[0].nodeValue;
				var CustomerID = xmlDoc.getElementsByTagName('CustomerID')[0].childNodes[0].nodeValue;
				var CrewNames = xmlDoc.getElementsByTagName('CrewNames')[0].childNodes[0].nodeValue.replace('--','');
				var TaskLength = xmlDoc.getElementsByTagName('TaskLength')[0].childNodes[0].nodeValue;
				
				var DoneCheck = xmlDoc.getElementsByTagName('DoneCheck')[0].childNodes[0].nodeValue.replace('--','');
				
				for (i = 1; i <= TaskLength; i++) //Sets Text of header bar
				{
				   var HXML = 'TaskName'+i;
				   eval('var TaskName'+i+' = xmlDoc.getElementsByTagName("'+HXML+'")[0].childNodes[0].nodeValue;');
				}
				for (i = 1; i <= TaskLength; i++) //Sets Background color of header bar
				{
				   var BGXML = 'BgColor'+i;
				   eval('var BgColor'+i+' = xmlDoc.getElementsByTagName("'+BGXML+'")[0].childNodes[0].nodeValue;');
				}
				for (i = 1; i <= TaskLength; i++) //Sets Text color of header bar
				{
				   var TXML = 'TextColor'+i;
				   eval('var TextColor'+i+' = xmlDoc.getElementsByTagName("'+TXML+'")[0].childNodes[0].nodeValue;');
				}
				
													
				document.getElementById("EventTitleText").value = Title;
				document.getElementById("FromDateTxt").value = DateFrom;
				document.getElementById("ToDateTxt").value = DateTo;
				document.getElementById("EventRepeat").value = RepeatID;
				document.getElementById("EventNewNotes").value = Note;
				document.getElementById("AttnList").value = AttentionID;
				document.getElementById("TaskList").value = TaskID;
				document.getElementById('EventHeaderTxt').innerHTML = 'Edit Event';
				
				
				document.getElementById('JobName').options.selectedIndex=0;
				document.getElementById('SuperList').options.selectedIndex=0;
				document.getElementById('AreaList').options.selectedIndex=0;
				document.getElementById('AreaList2').options.selectedIndex=0;
				document.getElementById('PhaseList').options.selectedIndex=0;
				document.getElementById('CustomerList').options.selectedIndex=0;
				document.getElementById('CrewList').options.selectedIndex=0;
				document.getElementById("CrewNames").value = 'Crew:';
				
				if(DoneCheck == 'False'){document.getElementById('DoneCheck').checked = false;}
				if(DoneCheck == 'True'){document.getElementById('DoneCheck').checked = true;}
				
				
		   
		   
		   if(TaskID == 1)
		   {
				// document.getElementById("EventTitleText").value = JobID;
				//document.getElementById("SuperList").value = SuperID;
				document.getElementById("AreaList").value = AreaID;
				document.getElementById("PhaseList").value = PhaseID;
				document.getElementById("CrewNames").value = CrewNames;
				document.getElementById('EventDetailsScreen').style.display = 'none';
				document.getElementById('EventDetails2').style.display = 'none';   
		   }
		   
		   if(TaskID == 3 || TaskID == 4 || TaskID == 6)
		   {
			    document.getElementById("CustomerList").value = CustomerID;
				document.getElementById("AreaList2").value = AreaID;
				document.getElementById('EventDetailsScreen').style.display = 'none';
				document.getElementById('EventDetails2').style.display = 'block';   
		   }
		   
				var Color = '';
				var HText = '';
				var TextColor = '';

				
				for (i = 1; i <= TaskLength; i++)
				{
				   if (TaskID == i){  eval('  HText = TaskName'+i+';  Color = "#"+BgColor'+i+'; TextColor = "#"+TextColor'+i+';   ');  }
				   
				}
				

				  
		        document.getElementById('EventTopL').style.background = Color;
				document.getElementById('EventTopR').style.background = Color;
				document.getElementById('EventHeaderTxt').style.color = TextColor;
				document.getElementById('EventHeaderTxt').innerHTML = 'Edit: '+HText;
		   
				document.getElementById('ModalScreen').style.display = 'inline';
				document.getElementById('NewEventBox').style.display = 'inline';


         }
		 else
		 {
            AjaxErr('There was a problem with the request.  LoadExistingEvent',HttpText);
         }
      }


}
//-------------------------------------------------------------------------------------------------






//AJAX Loads all of the Week events--////////////////////////////////////////////////
function DeleteEvent()
{
      
	  var EventID = document.getElementById("EventID").value;
	
      xmlHttp = GetXmlHttpObject();
	  
	  xmlHttp.onreadystatechange = ReturnDeleteEvent;
	  xmlHttp.open('GET','CalendarASP.asp?action=DeleteEvent&EventID='+EventID, true);
	  xmlHttp.send(null);
}


function ReturnDeleteEvent()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			hideEventModal();
			var xmlDoc = xmlHttp.responseXML.documentElement;
			if(ViewShowing == 'Month'){GoToDateMonth(1,YearShowing,MonthShowing);}
			if(ViewShowing == 'Week'){Make_Week(1,YearShowing,WeekShowing);}
		}
		else
		{
			alert('There was a problem with the request.  DeleteEvent');
		}
	}
}
//-------------------------------------------------------------------------------------------------













//Updates an event when it is moved--////////////////////////////////////////////////
function UpdateDragDrop(Obj)
{
	//alert(Obj.id);
	CapturedID=Obj.id.replace('li','');
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnUpdateDragDrop;
	//alert(DateOnHover+'   '+CapturedID);
	xmlHttp.open('GET','CalendarASP.asp?action=UpdateDragDrop&DropedDate='+DateOnHover+'&EventID='+CapturedID, true);
	xmlHttp.send(null);
  
}


function ReturnUpdateDragDrop()
{
	
	
      if (xmlHttp.readyState == 4)
	  {
		 
		 if (xmlHttp.status == 200)
	    {
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			//var EventID = xmlDoc.getElementsByTagName('EventID')[0].childNodes[0].nodeValue;
			//var DropedDate = xmlDoc.getElementsByTagName('DropedDate')[0].childNodes[0].nodeValue;
			//var Refresh = xmlDoc.getElementsByTagName('Refresh')[0].childNodes[0].nodeValue;
						
				if(ViewShowing == 'Month'){GoToDateMonth(1,YearShowing,MonthShowing);}
				if(ViewShowing == 'Week'){Make_Week(1,YearShowing,WeekShowing);}
			
			    //offsetX = 1; //sets the Drag Object offset to opperating degault
            
         }
		 else
		 {
            alert('There was a problem with the UpdateDragDrop request.');
         }
      }


}
//-------------------------------------------------------------------------------------------------









//Gets the Task Headers and their information and creates a global array called TaskArray-////////////////////////////////////////////////
function GetTaskList()
{
	
      xmlHttp = GetXmlHttpObject();
	  
	  xmlHttp.onreadystatechange = ReturnGetTaskList;
	  //xmlHttp.open('GET','CalendarASP.asp?action=GetTasks', true);
	  //xmlHttp.send(null);

}


function ReturnGetTaskList()
{
	
	
	if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	  {			
			//alert(xmlHttp);
			//alert(xmlHttp.responseXML); 
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var TaskLength //= xmlDoc.getElementsByTagName('TaskLength')[0].childNodes[0].nodeValue;
			
			TArray = new Array();
			
			for (i = 1; i <= TaskLength; i++)
				{
					
					var sTaskID = 'TaskID'+i;
					var sTaskName = 'TaskName'+i;
					var sBgColor = 'BgColor'+i;
					var sTextColor = 'TextColor'+i;
					var sLink = 'Link'+i;
					
					var TaskID = xmlDoc.getElementsByTagName(sTaskID)[0].childNodes[0].nodeValue;
					var TaskName = xmlDoc.getElementsByTagName(sTaskName)[0].childNodes[0].nodeValue;
					var BgColor = xmlDoc.getElementsByTagName(sBgColor)[0].childNodes[0].nodeValue;
					var TextColor = xmlDoc.getElementsByTagName(sTextColor)[0].childNodes[0].nodeValue;
					var Link = xmlDoc.getElementsByTagName(sLink)[0].childNodes[0].nodeValue;
					
					
					TArray[i] = new Array('',TaskID,TaskName,BgColor,TextColor,Link);
					
				}
			
			NumTasks = TaskLength;
			
			TaskArray = TArray;
			
			CreateCalendarTabs();
            
            
         }
		 else
		 {
            alert('There was a problem with the request.');
         }
      }


}
//-------------------------------------------------------------------------------------------------





var HoverNotes = new Object;
function ShowEventNotes(CalID)
{
	HoverNotes = Gebi('HoverNotes');
	
	HoverNotes.innerHTML=CalID;
	CapturedID=CalID;
	
	HttpText='CalendarASP.asp?action=ShowEventNotes&CalID='+CalID;
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnShowEventNotes;
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
}
function ReturnShowEventNotes()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			if(xmlHttp.responseXML==null){DebugBox(a(HttpText)); return false;}
			var xmlDoc = xmlHttp.responseXML.documentElement;			
		
			//alert(xmlDoc.getElementsByTagName('Notes')[0].childNodes[0].nodeValue);
			HoverNotes.style.display = 'block';
			//FadeIn(HoverNotes);
			HoverNotes.innerHTML='';
			var Note=CharsDecode(xmlDoc.getElementsByTagName('Notes')[0].childNodes[0].nodeValue.replace('--',''));
			
			var NotesArray= new Array;
			NotesArray = Note.split(String.fromCharCode(13));
			for(n=0;n<NotesArray.length;n++)
			{
				HoverNotes.innerHTML+=NotesArray[n];
			}
			
			//while(Note!=Note.replace(String.fromCharCode(13),'<br/>'))
			//{Note=Note.replace(String.fromCharCode(13),'<br/>');}
			
			//HoverNotes.innerHTML +='<br />'+mX+'px';
			PosEventNotes();
			
		}
		else
		{
			AjaxErr('There was a problem with the ShowEventNotes request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
