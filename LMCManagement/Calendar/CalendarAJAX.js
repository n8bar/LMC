// JavaScript Document
var GetTaskListSw = 0;
var xmlHttp;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////
function GetXmlHttpObject() {
	try	{// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e)	{ // Internet Explorer
		try	{xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)	{ xmlHttp=new ActiveXObject("Microsoft.XMLHTTP"); }
	}
	if (xmlHttp==null)	{
		alert ("Your browser does not support AJAX!");
		return;
	}
	return xmlHttp;
}//------------------------------------------------------------------------------------------------

//AJAX Loads all of the Calendar day events--////////////////////////////////////////////////
var CalEventsURLString;
var EventCountMax;
function CalendarEventsAJAX(DayArray) {
	if(Gebi("ViewAttn")==null){return false}
	sArray = encodeURIComponent( DayArray.join(",") );
	var ViewAttn = Gebi("ViewAttn").value;
	var ViewTask = Gebi("ViewTask").value;
	var ViewPM = Gebi("ViewPM").value;
	var ViewArea = Gebi("ViewArea").value;
	var ViewPhase = Gebi("ViewPhase").value;
	var ViewCustomer = Gebi("ViewCustomer").value;
	
	if(CalRows==6){EventCountMax=3}
	if(CalRows==5){EventCountMax=4}
	if(CalRows==4){EventCountMax=5}
	//if(document.body.offsetHeight<480) { alert('The size of the window is too small to display the calendar. \n\n Just press F11 to go fullscreen then F5 to reload'); }
	if(document.body.offsetHeight>=610){EventCountMax+=1}
	if(document.body.offsetHeight>=695){EventCountMax+=1}
	if(document.body.offsetHeight>=790){EventCountMax+=1}
	if(document.body.offsetHeight>=895){EventCountMax+=1}
	if(document.body.offsetHeight>=985){EventCountMax+=1}
	if(document.body.offsetHeight>=1075){EventCountMax+=1}
	if(document.body.offsetHeight>=1165){EventCountMax+=1}
	if(document.body.offsetHeight>=1260){EventCountMax+=1}
	if(document.body.offsetHeight>=1360){EventCountMax+=1}
	if(document.body.offsetHeight>=1450){EventCountMax+=1}
	if(document.body.offsetHeight>=1550){EventCountMax+=1}
	
	//alert(document.body.offsetHeight+' '+EventCountMax);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCalEventsAJAX;
	var URLString = 'CalendarASP.asp?action=CalendarEvents&CSS=DayEvent&Array='+sArray+'&QuickViewID='+QuickViewID+'&Source=Month';
	URLString += '&ViewAttn='+ViewAttn+'&ViewTask='+ViewTask+'&ViewPM='+ViewPM+'&ViewArea='+ViewArea+'&ViewPhase='+ViewPhase+'&ViewCustomer='+ViewCustomer+'&EventCountMax='+EventCountMax+'&IE='+IEver;
	xmlHttp.open('GET',URLString, true);
	xmlHttp.send(null);
	CalEventsURLString=URLString;
	//window.location=CalEventsURLString;
	//if(xmlHttp.status==200)ReturnCalEventsAJAX(); //Firefox code for SJAX (AJAX doesn't need this line)
	
	function ReturnCalEventsAJAX() {
		if (xmlHttp.readyState == 4) {
		 if (xmlHttp.status == 200) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				var ArrLen = xmlDoc.getElementsByTagName("ArrayLength")[0].childNodes[0].nodeValue;
				var DayEv = '';
				
				function xmlTag(tagName) {  
					try { return xmlDoc.getElementsByTagName(tagName)[0].childNodes[0].nodeValue; }
					catch(e) { 
						AjaxErr('Couldn\'t find <'+tagName+'> tag in DayEventsAjax XML Response. ', URLString) 
						return false;
					}
				} 
				
				for (d = 1; d <= ArrLen; d++) {
					var DayEvents = xmlTag('Event'+d); if(DayEvents==false) { return false; }
					var DayID = xmlTag('DateID'+d); if(DayID==false) { return false; }
					DayID = 'Day'+DayID;
					
					if(DayEvents != '-No Data-') {
						Gebi(DayID).innerHTML += DayEvents; 
						DayEv += DayEvents+'-'+DayID;	
					}
					
					var dayCount=xmlTag('EventCount'+d)*1;
	
					Gebi(DayID).innerHTML='';
					var eLimit=Math.min(dayCount,EventCountMax);
					//alert(dayCount+','+EventCountMax+','+eLimit);
					for (ei=1; ei<=eLimit; ei++) {
						//window.top.document.title='CalID'+d+'-'+e;
						//if(ei<=EventCountMax) {
							var CalID=xmlTag('CalID'+d+'-'+ei); if(CalID==false) { return false; }
							var CSS=xmlTag('CSS'+d+'-'+ei); if(CSS==false) { return false; }
							var EvStyle=xmlTag('EvStyle'+d+'-'+ei); if(EvStyle==false) { return false; }
							var Title=CharsDecode(xmlTag('Title'+d+'-'+ei));// if(Title==false) { return false; }
						
							var thisEvent='';
							thisEvent+='<li '
							thisEvent+='id=li'+CalID+' ';
							thisEvent+='class='+CSS+' ';
							thisEvent+='style="'+EvStyle+'" ';
							thisEvent+='onmouseover="ShowEventNotes(event,'+CalID+',this);" ';
							thisEvent+='onMouseOut="HideEventNotes();" ';
							thisEvent+='onmousedown="CapturedID='+CalID+';" ';
							thisEvent+='onclick="LoadExistingEvent(this.id.replace(\'li\',\'\'));" ';
							//if(parent.accessUser=='n8') { thisEvent+='title= "'+CalID+'" ' }
							thisEvent+='>'
							thisEvent+=Title;
							thisEvent+='</li>';
							
							Gebi(DayID).innerHTML+=thisEvent;
						//}
						
						if (ei>=eLimit ) {
							var overMax=dayCount-EventCountMax;
							if(overMax>0) Gebi(DayID).innerHTML+='<div style="width:100%;" align=center>+'+overMax+'</div>';
						}
					}
				}
	
				if(GetTaskListSw == 0){GetTaskList();}
				initDragDropScript();
				GetTaskListSw = 1;
			}
			else
			{
				//window.location=CalEventsURLString;
			}
		}
	}
}//-------------------------------------------------------------------------------------------------

//AJAX Loads all of the Week events--////////////////////////////////////////////////
function WeekEventsAJAX(WeekArray) {
	sArray = encodeURIComponent( WeekArray.join(",") );
	//alert(WeekArray);
	var ViewAttn = Gebi("ViewAttn").value;
	var ViewTask = Gebi("ViewTask").value;
	var ViewPM = Gebi("ViewPM").value;
	var ViewArea = Gebi("ViewArea").value;
	var ViewPhase = Gebi("ViewPhase").value;
	var ViewCustomer = Gebi("ViewCustomer").value;
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnWeekEventsAJAX;
	var URLString = 'CalendarASP.asp?action=CalendarEvents&CSS=DayEvent&Array='+sArray+'&QuickViewID='+QuickViewID+'&Source=Week';
	URLString += '&ViewAttn='+ViewAttn+'&ViewTask='+ViewTask+'&ViewPM='+ViewPM+'&ViewArea='+ViewArea+'&ViewPhase='+ViewPhase+'&ViewCustomer='+ViewCustomer+'&EventCountMax='+EventCountMax+'&IE='+IEver;
	xmlHttp.open('GET',URLString, true);
	xmlHttp.send(null);

	function ReturnWeekEventsAJAX() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				//AjaxErr('There wasn\'t a problem with the request: WeekEventsAJAX',URLString);
				var xmlDoc = xmlHttp.responseXML.documentElement;
				var ArrLen = xmlDoc.getElementsByTagName("ArrayLength")[0].childNodes[0].nodeValue;
				var DayEv = '';
				
				for (d = 1; d <= ArrLen; d++) {
					try {
						var DayEvents = xmlDoc.getElementsByTagName('Event'+d)[0].childNodes[0].nodeValue.replace('--');
						var DayID = xmlDoc.getElementsByTagName('DateID'+d)[0].childNodes[0].nodeValue.replace('--');
					}
					catch(e) { 
						return false;
					}
					DayID = 'Day'+DayID
					
					if(DayEvents != '-No Data-') {
						try { Gebi(DayID).innerHTML += DayEvents; }
						catch(e) {
							AjaxErr('No element with id="'+DayID+'" in the DOM. \nDateID'+d,URLString);
							return false;
						}
						DayEv += DayEvents+'-'+DayID;	
					}
					
					var dayCount=xmlDoc.getElementsByTagName('EventCount'+d)[0].childNodes[0].nodeValue;

					Gebi(DayID).innerHTML='';
					for (e=1; e<=dayCount; e++) {
						var CalID=xmlDoc.getElementsByTagName('CalID'+d+'-'+e)[0].childNodes[0].nodeValue;
						var CSS=xmlDoc.getElementsByTagName('CSS'+d+'-'+e)[0].childNodes[0].nodeValue;
						var EvStyle=xmlDoc.getElementsByTagName('EvStyle'+d+'-'+e)[0].childNodes[0].nodeValue;
						var Title=CharsDecode(xmlDoc.getElementsByTagName('Title'+d+'-'+e)[0].childNodes[0].nodeValue);
						
						var thisEvent='';
						thisEvent+='<li id=li'+CalID+' class='+CSS+' style="'+EvStyle+'" onmouseover="ShowEventNotes(event,'+CalID+',this);" onMouseOut="HideEventNotes();" onmousedown="CapturedID='+CalID+';" onclick="LoadExistingEvent('+CalID+');" >';
						thisEvent +=	Title;
						thisEvent+='</li>';
						
						Gebi(DayID).innerHTML+=thisEvent;
					}
				}
				initDragDropScript();
			}
			else {	
				AjaxErr('There was a problem with the request: WeekEventsAJAX',URLString);
			}
		}
	}
}//-------------------------------------------------------------------------------------------------

//AJAX Loads all of the Day View events--////////////////////////////////////////////////
function DayEventsAJAX(sDate) {
	var ViewAttn = Gebi("ViewAttn").value;
	var ViewTask = Gebi("ViewTask").value;
	var ViewPM = Gebi("ViewPM").value;
	var ViewArea = Gebi("ViewArea").value;
	var ViewPhase = Gebi("ViewPhase").value;
	var ViewCustomer = Gebi("ViewCustomer").value;

	var URLString = 'CalendarASP.asp?action=CalendarEvents&CSS=DayEvent&Array='+encodeURI(sDate+',')+'&QuickViewID='+QuickViewID+'&Source=Day';
	URLString += '&ViewAttn='+ViewAttn+'&ViewTask='+ViewTask+'&ViewPM='+ViewPM+'&ViewArea='+ViewArea+'&ViewPhase='+ViewPhase+'&ViewCustomer='+ViewCustomer+'&EventCountMax='+EventCountMax+'&IE='+IEver;

	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnDayEventsAJAX;
	xmlHttp.open('GET',URLString, true);
	xmlHttp.send(null);

	function ReturnDayEventsAJAX() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				//AjaxErr('hi', URLString);
				function xmlTag(tagName) {  
					try { return xmlDoc.getElementsByTagName(tagName)[0].childNodes[0].nodeValue; }
					catch(e) { 
						AjaxErr('Couldn\'t find <'+tagName+'> tag in DayEventsAjax XML Response. ', URLString) 
						return false;
					}
				} 
				var DayEvents=xmlTag('Event1');  if (DayEvents==false) { return false }
				var DayID = 'sDayEvents';  if (DayID==false) { return false }//xmlTag('DateID1');
				var dayCount=xmlTag('EventCount1'); if (dayCount==false) { return false }
				
				if(DayEvents != '-No Data-') {
					Gebi(DayID).innerHTML += DayEvents;
					//DayEv += DayEvents+'-'+DayID;	
				}
				
				Gebi(DayID).innerHTML='';
				for (e=1; e<=dayCount; e++) {
					var CalID=xmlDoc.getElementsByTagName('CalID1'+'-'+e)[0].childNodes[0].nodeValue;
					var CSS=xmlDoc.getElementsByTagName('CSS1'+'-'+e)[0].childNodes[0].nodeValue;
					var EvStyle=xmlDoc.getElementsByTagName('EvStyle1'+'-'+e)[0].childNodes[0].nodeValue;
					var Title=CharsDecode(xmlDoc.getElementsByTagName('Title1'+'-'+e)[0].childNodes[0].nodeValue);
					
					var thisEvent='';
					thisEvent+='<li id=li'+CalID+' class='+CSS+' style="'+EvStyle+'" onmouseover="ShowEventNotes(event,'+CalID+',this);" onMouseOut="HideEventNotes();" onmousedown="CapturedID='+CalID+';" onclick="LoadExistingEvent('+CalID+');" >';
					thisEvent +=	Title;
					thisEvent+='</li>';
					
					Gebi(DayID).innerHTML+=thisEvent;
				}
			}
			else {
			}
		}
	}
}
//-------------------------------------------------------------------------------------------------

//Saves the Information from the day Popup Bubble--////////////////////////////////////////////////
function BubbleDayPost(obj) {
	var EmpSelect = Gebi("EmployeesSelect");
	var EmpName = (EmpSelect[EmpSelect.selectedIndex].text);
	var poststr = "Date=" + encodeURI( Gebi("DateID").value ) +
		"&Day=" + encodeURI( Gebi("DateDayID").value )+
		"&Event=" + encodeURI( Gebi("EventInput").value )+
		"&Employee=" + encodeURI( Gebi("EmployeesSelect").value )+
		"&Notes=" + encodeURI( Gebi("DayNotes").value );
	var http='CalendarASP.asp?action=NewEventSingle&EmpName='+EmpName+'';			
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				// var result = xmlHttp.responseText;
				var xmlDoc=xmlHttp.responseXML.documentElement;
				
				var sDate = xmlDoc.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
				var DayEvent = sDate;
				DayEvent=DayEvent.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
				
				DayEvent='Day'+DayEvent;
			
				Gebi(DayEvent).innerHTML += xmlDoc.getElementsByTagName("Event")[0].childNodes[0].nodeValue;
				
				Gebi('StatusLine').innerHTML = 'Completed';
				//alert('-'+WeekEvent+'-');
			}
			else { AjaxErr('There was a problem with the request.   BubbleDayPost',http); }
		}
	};
	xmlHttp.open('POST',http, true);
	xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlHttp.setRequestHeader("Content-length", poststr.length);
	xmlHttp.setRequestHeader("Connection", "close");
	xmlHttp.send(poststr);
}
//-------------------------------------------------------------------------------------------------

//Saves the Information from the Event Popup--////////////////////////////////////////////////
function SaveEvent(obj) {
	var EventID = Gebi("EventID").value;
	var JobID = Gebi('EventJobID').value;
	
	//var Repeat1 = Gebi("EventRepeat");
	//var Repeat = (Repeat1[Repeat1.selectedIndex].text);
	var Attn1 = Gebi("AttnList");
	var Attn = (Attn1[Attn1.selectedIndex].innerHTML);
	var Task1 = Gebi("TaskList");
	var Task  = (Task1[Task1.selectedIndex].innerHTML);
	//var Job1 = Gebi("JobName");
	//var Job = (Job1[Job1.selectedIndex].innerHTML);
	var Super1 = Gebi("SuperList");
	var Super = (Super1[Super1.selectedIndex].innerHTML);
	var Phase1 = Gebi("PhaseList");
	try { var Phase = (Phase1[Phase1.selectedIndex].innerHTML); } catch(e) { var Phase=0 }
	var Customer = SelI("CustomerList").textContent;
	
	var EventNotes = CharsEncode(Gebi("EventNewNotes").value.replace('--'));
	if (EventNotes == '') {EventNotes ='Notes:';}
	
	try { var Area1 = SelI('AreaList').innerHTML; } catch(e) { var Area1='NONE'; }
	//var Area0 = Gebi("AreaList2");
	//var Area2 = (Area0[Area0.selectedIndex].text);
	try { var AreaVal = Gebi("AreaList").value } catch(e) { var AreaVal=0 }
	//var AreaVal2 = Gebi("AreaList2").value
	if (AreaVal != 0) var Area = Area1;
	else Area = '';
	//if (AreaVal2 != 0) {var AreaVal = AreaVal2; var Area = Area2;}
	//if (AreaVal1 == 0 && AreaVal2 == 0) {var AreaVal = 0; var Area = '----';}
	
	var Title = CharsEncode(Gebi("EventTitleText").value.replace('--'));
	var FromDate = (Gebi("FromDateTxt").value);
	var ToDate = (Gebi("ToDateTxt").value);
	//var RepeatVal = Gebi("EventRepeat").value;
	var AttnVal = Gebi("AttnList").value;
	var TaskVal = Gebi("TaskList").value;
	//var JobVal = Gebi("JobList").value;
	var SuperVal = Gebi("SuperList").value;
	var PhaseVal = Gebi("PhaseList").value;
	var CustomerVal = SelI("CustomerList").value;
	var CrewNames = Gebi("CrewNames").value;
	var Source = Gebi("Source").value;
	var DoneCheck = Gebi('DoneCheck').checked;
	
	var BillCheck = Gebi('BillCheck').checked;
	var BilledCheck = Gebi('BilledCheck').checked;
	
	if(Title == ''){alert('Please Fill Out The Title'); Gebi('EventTitleText').focus(); return false;}
	if(TaskVal == '0'){alert('Error: Task Category could not be determined');  return false;}
	/*
	if(FromDate == ''){alert('Please Fill Out From Date');  return;}
	if(ToDate == ''){alert('Please Fill Out To Date');  return;}
	if(AttnVal == '1500'){alert('Please Choose To Whose Attention');  return;}
	
	if (TaskVal == 1) {
	  if(JobValue == '0'){alert('Please Choose A Job');  return false;} 
	  if(SuperVal == '0'){alert('Please Choose A Supervisor');  return;}
	  if(AreaVal == '0'){alert('Please Choose An Area');  return;}
	  if(PhaseVal == '0'){alert('Please Choose A Phase');  return;}
	}
	
	if (TaskVal == 3  || TaskVal == 4  || TaskVal == 6) {
	  if(CustomerVal == '0'){alert('Please Choose A Customer');return;}
	  if(AreaVal2 == '0'){alert('Please Choose An Area'); return;}
	}
	*/
	
	
	
	var DateFromDate=new Date(FromDate);
	var DateToDate=new Date(ToDate);
	if(ToDate==null||ToDate==''||ToDate==('1/1/1900')||DateToDate<DateFromDate) {
		ToDate=FromDate;
		DateToDate=new Date(ToDate);
	}
	
	var poststr = 
		"Title=" + Title+
		"&Source=" + Source+
		"&DateFrom=" + FromDate+
		"&DateTo=" + ToDate+
		//"&RepeatVal=" + RepeatVal+
		//"&Repeat=" + Repeat+
		"&Notes=" + EventNotes+
		"&DoneCheck=" + DoneCheck+
		"&AttnVal=" + AttnVal+	
		"&Attn=" + Attn+
		"&TaskVal=" + TaskVal+	
		"&Task=" + Task+
		"&BillCheck=" + BillCheck+
		"&BilledCheck=" + BilledCheck+
		//"&JobVal=" +  Gebi("JobName").value )+	
		//"&Job=" + Job+
		"&JobID=" + JobID+
		"&SuperVal=" + SuperVal+	
		"&Super=" + Super+
		"&AreaVal=" + AreaVal+	
		"&Area=" + Area+
		"&PhaseVal=" + PhaseVal+	
		"&Phase=" + Phase+
		"&CustomerVal=" + CustomerVal+	
		"&Customer=" + Customer+
		"&CrewNames=" + CrewNames;
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
	function ReturnSaveEvent()	{
		if (xmlHttp.readyState==4)	{
			if (xmlHttp.status==200)	{
				hideEventModal();
				var xmlDoc=xmlHttp.responseXML.documentElement;
				if(ViewShowing == 'Month'){GoToDateMonth(1,YearShowing,MonthShowing);}
				if(ViewShowing == 'Week'){Make_Week(1,YearShowing,(WeekShowing+1));}
				//AjaxErr('Nothing is wrong with the request. I hope.  SaveEventRabbit',HttpText);
			}
			else	{ AjaxErr('There was a problem with the SaveEvent request.',HttpText); }
		}
	//hidePopup('bubble_tooltip');
	}
}//-------------------------------------------------------------------------------------------------

//AJAX Loads all of the Day View events--////////////////////////////////////////////////
function LoadExistingEvent(EventID)	{
	Box_Event_Click=1;
	Gebi('DeleteEventBtn').style.display = 'block';
	Gebi('EventID').value = EventID;

	if (Initiated==0)	{
		HttpText='CalendarASP.asp?action=GetEvent&EventID='+EventID;
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnLoadExistingEvent;
		xmlHttp.open('GET', HttpText, true);
		xmlHttp.send(null);
	}
	
	function ReturnLoadExistingEvent()	{
		if (xmlHttp.readyState== 4)	{
			if (xmlHttp.status == 200)	{
				//try { 
					var xmlDoc = xmlHttp.responseXML.documentElement;
					var Title = CharsDecode(xmlDoc.getElementsByTagName('Title')[0].childNodes[0].nodeValue.replace('--',''));
					var DateFrom = xmlDoc.getElementsByTagName('DateFrom')[0].childNodes[0].nodeValue;
					var DateTo = xmlDoc.getElementsByTagName('DateTo')[0].childNodes[0].nodeValue;
					var RepeatID = xmlDoc.getElementsByTagName('RepeatID')[0].childNodes[0].nodeValue;
					var Note = CharsDecode(xmlDoc.getElementsByTagName('Note')[0].childNodes[0].nodeValue).replace('--','');
					var AttentionID = xmlDoc.getElementsByTagName('AttentionID')[0].childNodes[0].nodeValue.replace('--','');
					var TaskID = xmlDoc.getElementsByTagName('TaskID')[0].childNodes[0].nodeValue.replace('--','');
					var JobID = xmlDoc.getElementsByTagName('JobID')[0].childNodes[0].nodeValue;
					//var SuperID = xmlDoc.getElementsByTagName('SuperID')[0].childNodes[0].nodeValue;
					var AreaID = xmlDoc.getElementsByTagName('AreaID')[0].childNodes[0].nodeValue;
					var PhaseID = xmlDoc.getElementsByTagName('PhaseID')[0].childNodes[0].nodeValue;
					var CustomerID = xmlDoc.getElementsByTagName('CustomerID')[0].childNodes[0].nodeValue;
					var CrewNames = xmlDoc.getElementsByTagName('CrewNames')[0].childNodes[0].nodeValue.replace('--','');
					var TaskLength = xmlDoc.getElementsByTagName('TaskLength')[0].childNodes[0].nodeValue;
					
					var DoneCheck = xmlDoc.getElementsByTagName('DoneCheck')[0].childNodes[0].nodeValue.replace('--','');
					var BillCheck = xmlDoc.getElementsByTagName('BillCheck')[0].childNodes[0].nodeValue.replace('--','');
					var BilledCheck = xmlDoc.getElementsByTagName('BilledCheck')[0].childNodes[0].nodeValue.replace('--','');
				//}
				//catch(e) {
					//AjaxErr('There was a problem with the XML response: LoadExistingEvent',HttpText);
					//return false;
				//}
				
				Gebi('EventDetailsScreen').style.display = 'block';
				Gebi('EventDetails2').style.display = 'none';
				
				var HXML= new Array;
				var BGXML=new Array;
				var TXML= new Array;
				for (i = 1; i <= TaskLength; i++)	{ //Sets Text of header bar
					 HXML[i]= xmlDoc.getElementsByTagName('TaskName'+i)[0].childNodes[0].nodeValue;
				}
				
				for (i = 1; i <= TaskLength; i++)	{ //Sets Background color of header bar
					 BGXML[i]= xmlDoc.getElementsByTagName('BgColor'+i)[0].childNodes[0].nodeValue;
				}
				
				for (i = 1; i <= TaskLength; i++)	{ //Sets Text color of header bar
					 TXML[i]= xmlDoc.getElementsByTagName('TextColor'+i)[0].childNodes[0].nodeValue;
				}
				
				Gebi("EventJobID").value = JobID;
				Gebi("EventTitleText").value = Title;
				Gebi("FromDateTxt").value = DateFrom;
				Gebi("ToDateTxt").value = DateTo;
				//Gebi("EventRepeat").value = RepeatID;
				Gebi("EventNewNotes").value = Note;
				Gebi("AttnList").value = AttentionID;
				Gebi("TaskList").value = TaskID;
				Gebi('EventHeaderTxt').innerHTML = 'Edit Event';
				
				Gebi('JobName').selectedIndex=0;
				Gebi('SuperList').selectedIndex=0;
				Gebi('AreaList').selectedIndex=0;
				//Gebi('AreaList2').selectedIndex=0;
				Gebi('PhaseList').selectedIndex=0;
				Gebi('CustomerList').selectedIndex=0;
				Gebi('CrewList').selectedIndex=0;
				Gebi("CrewNames").value = 'Crew:';
				
				Gebi('DoneCheck').checked =(DoneCheck == 'True');
				
				Gebi('BillCheck').checked =(BillCheck == 'True');
				Gebi('BilledCheck').checked =(BilledCheck == 'True');
				BillStatus();
				
				Gebi("CrewNames").value = CrewNames;

				if(TaskID == 1) {
					// Gebi("EventTitleText").value = JobID;
					//Gebi("SuperList").value = SuperID;
					//Gebi("AreaList").value = AreaID;
					//Gebi("PhaseList").value = PhaseID;
					Gebi('EventDetailsScreen').style.display = 'none';
					Gebi('EventDetails2').style.display = 'none';   
				}
				
				if(TaskID == 3 || TaskID == 4 || TaskID == 6) {
					//Gebi("CustomerList").value = CustomerID;
					//Gebi("AreaList2").value = AreaID;
					Gebi('EventDetailsScreen').style.display = 'none';
					Gebi('EventDetails2').style.display = 'block';   
				}
				
				var Color = '';
				var HText = '';
				var TextColor = '';
	
				HText = HXML[TaskID];
				Color = "#"+BGXML[TaskID];
				TextColor = "#"+TXML[TaskID];
					
				Gebi('NewEventBoxTitle').style.background = Color;
				Gebi('EventHeaderTxt').style.color = TextColor;
				Gebi('EventHeaderTxt').innerHTML = 'Edit: '+HText;
			 
				Gebi('ModalScreen').style.display = 'inline';
				Gebi('NewEventBox').style.display = 'inline';
			}
			else {
				AjaxErr('There was a problem with the request.  LoadExistingEvent',HttpText);
			}
		}
	}
}
//-------------------------------------------------------------------------------------------------

function DeleteEvent() {
	var EventID = Gebi("EventID").value;
	var http='CalendarASP.asp?action=DeleteEvent&EventID='+EventID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				hideEventModal();
				var xmlDoc = xmlHttp.responseXML.documentElement;
				if(ViewShowing == 'Month'){GoToDateMonth(1,YearShowing,MonthShowing);}
				if(ViewShowing == 'Week'){Make_Week(1,YearShowing,WeekShowing+1);}
			}
			else {
				AjaxErr('There was a problem with the request.  DeleteEvent',http);
			}
		}
	};
	xmlHttp.open('GET',http, true);
	xmlHttp.send(null);
}
//-------------------------------------------------------------------------------------------------

//Updates an event when it is moved--////////////////////////////////////////////////
function UpdateDragDrop(Obj) {
	//alert(Obj.id);
	CapturedID=Obj.id.replace('li','');
	var http='CalendarASP.asp?action=UpdateDragDrop&DropedDate='+DateOnHover+'&EventID='+CapturedID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			//var EventID = xmlDoc.getElementsByTagName('EventID')[0].childNodes[0].nodeValue;
			//var DropedDate = xmlDoc.getElementsByTagName('DropedDate')[0].childNodes[0].nodeValue;
			//var Refresh = xmlDoc.getElementsByTagName('Refresh')[0].childNodes[0].nodeValue;
			if(ViewShowing == 'Month'){GoToDateMonth(1,YearShowing,MonthShowing);}
			if(ViewShowing == 'Week'){Make_Week(1,YearShowing,WeekShowing+1);}
		 }
		 else { AjaxErr('There was a problem with the UpdateDragDrop request.',http); }
		}
	}
	xmlHttp.open('GET',http, true);
	xmlHttp.send(null);
}
//-------------------------------------------------------------------------------------------------

//Gets the Task Headers and their information and creates a global array called TaskArray-////////////////////////////////////////////////
function GetTaskList() {
	var http='CalendarASP.asp?action=GetTasks';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {			
				//alert(xmlHttp);
				//alert(xmlHttp.responseXML); 
				var xmlDoc = xmlHttp.responseXML.documentElement;			
				var TaskLength //= xmlDoc.getElementsByTagName('TaskLength')[0].childNodes[0].nodeValue;
				TArray = new Array();
				for (i = 1; i <= TaskLength; i++) {
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
			else { AjaxErr('There was a problem with the request. GetTaskList',http); }
		}
	}
	//xmlHttp.open('GET',http, true);
	//xmlHttp.send(null);
}
//-------------------------------------------------------------------------------------------------

function populateExistingContacts(searchText) { 
	if (searchText=='') {
		Gebi('existingContactList').innerHTML='';
		Gebi('addCustExistingListLabel').style.display='none';
		return;
	}
	HttpText='CalendarASP.asp?action=populateExistingContacts&searchText='+searchText;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = returnExistingContacts;
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
	function returnExistingContacts() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				if(xmlHttp.responseXML==null){DebugBox(a(HttpText)); return false;}
				//console.log(xmlHttp.responseXML);
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the populateExistingContacts:"'+searchText+'" response.',HttpText);
					return;
				}
				var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue;
				
				if (recordCount>0) {
					Gebi('addCustExistingListLabel').style.display='inline-block';
				} else {
					Gebi('addCustExistingListLabel').style.display='none';
				}
				var contactList='';
				for(r=1;r<=recordCount;r++) {
					var contactId=xmlDoc.getElementsByTagName('ID'+r)[0].childNodes[0].nodeValue;
					var name=CharsDecode(xmlDoc.getElementsByTagName('Name'+r)[0].childNodes[0].nodeValue.replace('--',''));
					contactList+='<button onclick="useAsCust('+contactId+',\''+name+'\');" class=existingContactListItem >'+name+'</button> <br/>';
					
				}
				Gebi('existingContactList').innerHTML=contactList;
			}
			else { AjaxErr('There was a problem with the populateExistingContacts request.',HttpText)}
		}		
	}
}

function useAsCust(id,cName) {
	var fName='UseAsCust';
	HttpText='CalendarASP.asp?action='+fName+'&id='+id+'&cName='+cName;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = returnExistingContacts;
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
	function returnExistingContacts() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				if(xmlHttp.responseXML==null){DebugBox(a(HttpText)); return false;}
				console.log(xmlHttp.responseXML);
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the '+fName+':"'+id+','+cName+'" response.',HttpText);
					return;
				}
				//var recordCount=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue;
				

				//var contactId=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;
				//var name=CharsDecode(xmlDoc.getElementsByTagName('Name')[0].childNodes[0].nodeValue.replace('--',''));
				Gebi('CustomerList').innerHTML='<option value='+id+'>'+cName+'<option>'+Gebi('CustomerList').innerHTML;
				Gebi('CustomerList').selectedIndex=0;
				
				
				hideAddCustBox();
			}
			else { AjaxErr('There was a problem with the '+fName+' request.',HttpText)}
		}		
	}
}

function insertNewCustomer() {
	var cName=Gebi('addCustSearchText').value;
	var phone=Gebi('addCustPhone').value;
	var email=Gebi('addCustEmail').value;
	var fName='insertNewCustomer';
	
	HttpText='CalendarASP.asp?action='+fName+'&cName='+cName+'&phone='+phone+'&email='+email;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = returnExistingContacts;
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
	function returnExistingContacts() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				if(xmlHttp.responseXML==null){DebugBox(a(HttpText)); return false;}
				console.log(xmlHttp.responseXML);
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{	
					AjaxErr('There was a problem with the '+fName+':"'+cName+'" response.',HttpText);
					return;
				}
					
				var newCustId=xmlDoc.getElementsByTagName('id')[0].childNodes[0].nodeValue;
				
				Gebi('CustomerList').innerHTML='<option value='+newCustId+'>'+cName+'<option>'+Gebi('CustomerList').innerHTML;
				Gebi('CustomerList').selectedIndex=0;
				
				
				hideAddCustBox();
			}
		}
	}
}


function ShowEventNotes(e,CalID, HoverItem) {
	CalID=HoverItem.id.replace('li','');
	
	var nX=e.clientX+16; //HoverItem.offsetLeft+(HoverItem.offsetWidth/2);
	var nY=e.clientY+16; //HoverItem.offsetTop+(HoverItem.offsetHeight);
	
	Gebi('HoverNotes').innerHTML=CalID;
	CapturedID=CalID;
	
	HttpText='CalendarASP.asp?action=ShowEventNotes&CalID='+CalID;
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnShowEventNotes;
	xmlHttp.open('GET',HttpText, true);
	xmlHttp.send(null);
	
	function ReturnShowEventNotes() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				if(xmlHttp.responseXML==null){DebugBox(a(HttpText)); return false;}
				var xmlDoc = xmlHttp.responseXML.documentElement;			
				Gebi('HoverNotes').style.visibility = 'visible';
				Gebi('HoverNotes').innerHTML='';
				var Note=CharsDecode((xmlDoc.getElementsByTagName('Notes')[0].childNodes[0].nodeValue.replace('--','')));
	
				var NotesArray= new Array;
				NotesArray = Note.split(String.fromCharCode(13));
				for(n=0;n<NotesArray.length;n++) { Gebi('HoverNotes').innerHTML+=NotesArray[n]+'<br/>'; }
				Gebi('HoverNotes').style.left=nX+('px');
				Gebi('HoverNotes').style.top=nY+('px');
				if(parent.accessUser=='n8') { Gebi('HoverNotes').innerHTML+='nX:'+nX+' nY:'+nY+' &nbsp; calID:'+CalID; }
			}
			else { AjaxErr('There was a problem with the ShowEventNotes request.',HttpText); }
		}
	}
}
//-------------------------------------------------------------------------------------------------