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








function TabSlideOut(sThis)
{
	
   sThis.style.width = '60px'; 	
	
}

function TabSlideIn(sThis)
{

	sThis.style.width = '12px';
	
}







function CreateCalendarTabs()
{
	
    var HTML = '';

   HTML +='<li id="TaskTabs1000" style="padding:0px 0px 0px 0px; background:#3599E3; color:#FFF;" ><div id="SlideTabText1000" class="SlideTabText" onclick="ShowCalendar();">Calendar</div></li>'; 
   HTML +='<li id="TaskTabs1001" style="background:#FF99CC;"><div id="SlideTabText1001" class="SlideTabText"  onclick="">Gant Chart</div></li>'; 

	
	for (i = 1; i <= NumTasks; i++)
	{
       //HTML +='<li style="background:#CC99CC; text-align:center;"><div id="SlideTabText'+i+'" class="SlideTabText" >Task'+i+'</div></li>';
	   HTML +='<li id="TaskTabs'+i+'" onMouseUp="showViews()" style="background:#'+TaskArray[i][3]+';color:#'+TaskArray[i][4]+';"><div id="SlideTabText1" class="SlideTabText" onclick="'+TaskArray[i][5]+'();">'+TaskArray[i][2]+'</div></li>';
	
	}
   
   
   
   //slideMenu.build('SlideTabs',150,2,2,1);
   //document.getElementById('SlideTabs').innerHTML = HTML;
    
}









function showMonths()
{


	document.getElementById("Months").style.display = 'block';
	//document.getElementById("Board").style.display = 'none';
	//document.getElementById("Alerts").style.display = 'none';
	document.getElementById("Views").style.display = 'none';
	
	document.getElementById("MonthsTab").style.background = '#55A9E8';
	//document.getElementById("BoardTab").style.background = '#D5EBF9';
	//document.getElementById("AlertsTab").style.background = '#D5EBF9';
	document.getElementById("ViewsTab").style.background = '#D5EBF9';
	
	document.getElementById("MonthsTab").style.color = '#000';
	//document.getElementById("BoardTab").style.color = '#324358';
	//document.getElementById("AlertsTab").style.color = '#324358';
	document.getElementById("ViewsTab").style.color = '#324358';

}

function showBoard()
{

	document.getElementById("Months").style.display = 'none';
	//document.getElementById("Board").style.display = 'block';
	//document.getElementById("Alerts").style.display = 'none';
	document.getElementById("Views").style.display = 'none';
	
	document.getElementById("MonthsTab").style.background = '#D5EBF9';
	//document.getElementById("BoardTab").style.background = '#55A9E8';
	//document.getElementById("AlertsTab").style.background = '#D5EBF9';
	document.getElementById("ViewsTab").style.background = '#D5EBF9';
	
	document.getElementById("MonthsTab").style.color = '#324358';
	//document.getElementById("BoardTab").style.color = '#000';
	//document.getElementById("AlertsTab").style.color = '#324358';
	document.getElementById("ViewsTab").style.color = '#324358';

}

function showAlerts()
{

	document.getElementById("Months").style.display = 'none';
	//document.getElementById("Board").style.display = 'none';
	//document.getElementById("Alerts").style.display = 'block';
	document.getElementById("Views").style.display = 'none';
	
	document.getElementById("MonthsTab").style.background = '#D5EBF9';
	document.getElementById("BoardTab").style.background = '#D5EBF9';
	document.getElementById("AlertsTab").style.background = '#55A9E8';
	document.getElementById("ViewsTab").style.background = '#D5EBF9';
	
	document.getElementById("MonthsTab").style.color = '#324358';
	document.getElementById("BoardTab").style.color = '#324358';
	document.getElementById("AlertsTab").style.color = '#000';
	document.getElementById("ViewsTab").style.color = '#324358';

}

function showViews()
{

	document.getElementById("Months").style.display = 'none';
	//document.getElementById("Board").style.display = 'none';
	//document.getElementById("Alerts").style.display = 'none';
	document.getElementById("Views").style.display = 'block';
	
	document.getElementById("MonthsTab").style.background = '#D5EBF9';
	//document.getElementById("BoardTab").style.background = '#D5EBF9';
	//document.getElementById("AlertsTab").style.background = '#D5EBF9';
	document.getElementById("ViewsTab").style.background = '#55A9E8';
	
	document.getElementById("MonthsTab").style.color = '#324358';
	//document.getElementById("BoardTab").style.color = '#324358';
	//document.getElementById("AlertsTab").style.color = '#000';
	document.getElementById("ViewsTab").style.color = '#324358';

}






function Resize()
{
	document.getElementById('CalendarMain').style.oveflow='hidden';
	
	if(parent.IEver!=7)
	{
		document.body.style.height='100%';
		document.body.style.height=Math.abs(document.body.offsetHeight-60)+'px';
		
		
		document.getElementById('Calendar1').style.height=Math.abs(document.body.offsetHeight-16)+'px';
		document.getElementById('CalendarMain').style.width=document.body.offsetWidth+'px';
		/*
		var H=document.body.offsetHeight;
		document.getElementById('CalendarMainContainer').style.height=Math.abs(H-document.getElementById('CalendarLeftContainer').offsetHeight)+'px';
		Gebi('CalendarPlaner').style.height='100%';
		Gebi('CalendarPlaner').style.height=Math.abs(Gebi('CalendarPlaner').offsetHeight-80)+'px';
		//document.getElementById('Calendar1').style.height=Math.abs(H-document.getElementById('CalendarLeftContainer').offsetHeight)+'px';
		var W=document.body.offsetWidth;
		document.getElementById('CalendarMainContainer').style.width=Math.abs(W-document.getElementById('CalendarLeftContainer').offsetWidth)+'px';
		*/
	}
	
}






//-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX-----AJAX



var xmlHttp


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
	  xmlHttp.open('POST','CalendarMain-ASP.asp?action=NewEventSingle&EmpName='+EmpName+'', true);
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

			//document.getElementById('StatusLine').innerHTML = 'Completed';
         }
		 else
		 {
            alert('There was a problem with the ReturnBubbleDayPost request.');
         }
      }
	  
   }
//-------------------------------------------------------------------------------------------------




function TestASP()

{
	
	var arr=new Array('john doe', '1245 Cedar Grove', 'New York', 'NY'); 
    arr = encodeURIComponent( arr.join(",") );
	
    document.location = 'Test1.asp?Array='+arr;
	
}




