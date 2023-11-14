// JavaScript Document

//GLOBAL VARIABLES
TaskArray = new Array();//For creating an array of the task masters
NumTasks = 0;

//Sets the color of the top frame bottom border
/*parent.FrameTop.document.all('TopBarLeft').style.background = '#104974';
parent.FrameTop.document.all('TopBarCenter').style.background = '#104974';
parent.FrameTop.document.all('TopBarRight').style.background = '#104974';
parent.FrameTop.document.all('DatePopup').style.color = '#FFF';
*/


//--TAB CONTROLLS--TAB CONTROLLS--TAB CONTROLLS--TAB CONTROLLS--TAB CONTROLLS--TAB CONTROLLS--TAB CONTROLLS


function TabSlideOut(sThis) { sThis.style.width = '60px'; }

function TabSlideIn(sThis) { sThis.style.width = '12px'; }







function CreateCalendarTabs() {
	
    var HTML = '';

   HTML +='<li id="TaskTabs1000" style="padding:0px 0px 0px 0px; background:#3599E3; color:#FFF;" ><div id="SlideTabText1000" class="SlideTabText" onclick="ShowCalendar();">Calendar</div></li>'; 
   HTML +='<li id="TaskTabs1001" style="background:#FF99CC;"><div id="SlideTabText1001" class="SlideTabText"  onclick="">Gant Chart</div></li>'; 

	
	for (i = 1; i <= NumTasks; i++) {
       //HTML +='<li style="background:#CC99CC; text-align:center;"><div id="SlideTabText'+i+'" class="SlideTabText" >Task'+i+'</div></li>';
	   HTML +='<li id="TaskTabs'+i+'" onMouseUp="showViews()" style="background:#'+TaskArray[i][3]+';color:#'+TaskArray[i][4]+';"><div id="SlideTabText1" class="SlideTabText" onclick="'+TaskArray[i][5]+'();">'+TaskArray[i][2]+'</div></li>';
	
	}
   //slideMenu.build('SlideTabs',150,2,2,1);
   //Gebi('SlideTabs').innerHTML = HTML;
}


function tab(tabObj) {
	var tabs=document.getElementsByClassName('selVTab');
	for(t=0;t<tabs.length;t++) {
		tabs[t].setAttribute('class','vTab');
	}
	tabs=document.getElementsByClassName('vTab');
	for(t=0;t<tabs.length;t++) {
		Gebi(tabs[t].id.replace('Tab','')).style.display='none';
		tabs[t].setAttribute('class','vTab');
	}
	Gebi(tabObj.id.replace('Tab','')).style.display='block';
	tabObj.setAttribute('class','selVTab');
}



function Resize() {
	//Gebi('CalendarMain').style.oveflow='hidden';
	
	if(parent.IEver!=7) {
		/*
		document.body.style.height='100%';
		document.body.style.height=Math.abs(document.body.offsetHeight-60)+'px';
		
		
		Gebi('Calendar1').style.height=Math.abs(document.body.offsetHeight-0)+'px';
		Gebi('CalendarMain').style.width=document.body.offsetWidth+'px';
		/*
		var H=document.body.offsetHeight;
		Gebi('CalendarMainContainer').style.height=Math.abs(H-Gebi('CalendarLeftContainer').offsetHeight)+'px';
		Gebi('CalendarPlaner').style.height='100%';
		Gebi('CalendarPlaner').style.height=Math.abs(Gebi('CalendarPlaner').offsetHeight-80)+'px';
		//Gebi('Calendar1').style.height=Math.abs(H-Gebi('CalendarLeftContainer').offsetHeight)+'px';
		var W=document.body.offsetWidth;
		Gebi('CalendarMainContainer').style.width=Math.abs(W-Gebi('CalendarLeftContainer').offsetWidth)+'px';
		*/
	}
}



//-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX



var xmlHttp


//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject() {
	var xmlHttp=null;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e) {
		// Internet Explorer
		try {
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	if (xmlHttp==null) {
		alert ("Your browser does not support AJAX!");
		return;
	}
			
			
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------









//Saves the Information from the day Popup Bubble--////////////////////////////////////////////////
function BubbleDayPost(obj) {
		
	  var EmpSelect = Gebi("EmployeesSelect");
      var EmpName = (EmpSelect.options[EmpSelect.selectedIndex].text);
		
	  var poststr = "Date=" + encodeURI( Gebi("DateID").value ) +
	  				"&Day=" + encodeURI( Gebi("DateDayID").value )+
				    "&Event=" + encodeURI( Gebi("EventInput").value )+
					"&Employee=" + encodeURI( Gebi("EmployeesSelect").value )+
					"&Notes=" + encodeURI( Gebi("DayNotes").value );				

      xmlHttp = GetXmlHttpObject();

	  xmlHttp.onreadystatechange = ReturnBubbleDayPost;
	  xmlHttp.open('POST','CalendarMain-ASP.asp?action=NewEventSingle&EmpName='+EmpName+'', true);
	  xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xmlHttp.setRequestHeader("Content-length", poststr.length);
	  xmlHttp.setRequestHeader("Connection", "close");
	  xmlHttp.send(poststr);
}
function ReturnBubbleDayPost() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			
			// var result = xmlHttp.responseText;
			
			var xmlDoc=xmlHttp.responseXML.documentElement;
			
			var sDate = xmlDoc.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
			var DayEvent = sDate;
			DayEvent=DayEvent.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
			DayEvent='Day'+DayEvent;
			
			Gebi(DayEvent).innerHTML += xmlDoc.getElementsByTagName("Event")[0].childNodes[0].nodeValue;
			
			//Gebi('StatusLine').innerHTML = 'Completed';
		}
		else {
			alert('There was a problem with the ReturnBubbleDayPost request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------

