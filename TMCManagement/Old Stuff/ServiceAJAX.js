// JavaScript Document   AJAX CONTROLS


//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

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

//Loads all tasks-------------------------------------------------------------------------------------
var DidLoadNotes = false;
var OrderHeadId;

function LoadNotes(OrderBy)
{
	if(NotesLoader > 0){document.getElementById('OverAllContainerWhite').style.display = 'block';}
	
	if (OrderBy == 'undefined'){OrderBy = 'Date'; alert('OrderBy is undefined');}
	if (OrderBy != Order){
		OldMOColor[OrderHeadId] = 'FFF';
		Order = OrderBy;
	}
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLoadNotes;
	xmlHttp.open('Get','ServiceASP.asp?action=LoadNotes&OrderBy='+Order, true);
	xmlHttp.send(null);
}

function ReturnLoadNotes() 
{
if (xmlHttp.readyState == 4)
	{
		
		if (xmlHttp.status == 200)
		{
			//alert('Not me!');
			
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			//alert(xmlDoc);
			//var Job = xmlDoc.getElementsByTagName('Job')[0].childNodes[0].nodeValue.replace('--NotNull--','');
			
			if (document.getElementById('ActiveButton').style.display=='block'){
				var List = xmlDoc.getElementsByTagName('Archive')[0].childNodes[0].nodeValue.replace(/--AMPERSAND--/g,'&');
				document.getElementById('TLItemsContainer').innerHTML = '<div>'+List+'</div>';
			}
			else{
				var Archive = xmlDoc.getElementsByTagName('List')[0].childNodes[0].nodeValue.replace(/--AMPERSAND--/g,'&');
				document.getElementById('TLItemsContainer').innerHTML = Archive;
			}
			
			var TaskLength = xmlDoc.getElementsByTagName('TaskLength')[0].childNodes[0].nodeValue;
			var ArchiveLength = xmlDoc.getElementsByTagName('ArchiveLength')[0].childNodes[0].nodeValue.replace('--','');
			//alert(ArchiveLength);
			/*document.getElementById('HeadEdit').style.marginLeft = ((Math.pow(document.body.offsetWidth,2.02))/200000)+3;
			for(var i=0;(i<=TaskLength)||(i<=ArchiveLength);i++)
			{
				var W = document.getElementById('HeadJob').offsetWidth;
				var ID = document.getElementById('HiddenJobID'+i).value;
				document.getElementById(ID).style.width = W-7;
				var W = document.getElementById('HeadCust').offsetWidth;
				var ID = document.getElementById('HiddenCustID'+i).value;
				document.getElementById(ID).style.width = W-7;
			}
			/*document.getElementById('SendToArchive').innerHTML = "Arch<br />ive";
			document.getElementById('TLItemsContainer').innerHTML = Tasks;
			document.getElementById('ActiveButton').style.display = "none";
			document.getElementById('ArchiveButton').style.display = "block";
			document.getElementById('HeaderRight').style.display = "none";
			/**/
			
			Resizer();
			HighlightOrder();
			//NiftyAll();
			//Nifty("div#Taskbox","large transparent top");
			if(!DidLoadNotes){LoadMainLists();}
			DidLoadNotes = true;
			//alert('Loaded Notes!');
		}
		else
		{
			alert('There was a problem with the Service-LoadNotes request.');
}	}	}////////////////////////////////////////////////////////////////////////////


function SearchCust()
{
		SearchCustList.style.display='block'; 
		var CustText = document.getElementById('txtCustSearch').value;
		if (CustText == '') {return false;}
	  //var CustText = 're';
		//alert(CustText);
	  xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnGetCustomerForNewProj;
	  xmlHttp.open('Get','ServiceASP.asp?action=FindCust&CustText='+CustText+'', true);
	  xmlHttp.send(null);
}

function ReturnGetCustomerForNewProj()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var Test = xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue;
			var CusList = xmlDoc.getElementsByTagName('CustList')[0].childNodes[0].nodeValue;
			document.getElementById('SearchCustList').innerHTML = CusList;
		}
		else
		{
			alert('There was a problem with the Service-SearchCust request.');
}	}	}
//-------------------------------------------------------------------------------------------------

//Saves a new task
function SaveTask()
{
	//alert(txtDate.value+txtJob.value);
	var HTTP = 'ServiceASP.asp?action=SaveTask';
	HTTP += '&d8='+txtDate.value;
	HTTP += '&Job='+txtJob.value;
	HTTP += '&Cust='+txtCust.value;
	HTTP += '&Area='+selArea[selArea.selectedIndex].innerText;
	HTTP += '&Attn='+selAttn[selAttn.selectedIndex].innerText;
	HTTP += '&Notes='+txtNotes.innerText;
	//alert(HTTP);
	
	if ((txtDate.value=='') || (txtDate.value==null) || (txtJob.value=='') || (txtJob.value==null))
	{	alert('Date & Description are required.'); return false;}
	
	//alert(HTTP);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSaveTask;
	xmlHttp.open('Get',HTTP, true);
	xmlHttp.send(null);
}


function ReturnSaveTask() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			//			var List = xmlDoc.getElementsByTagName('List')[0].childNodes[0].nodeValue;
			//			document.getElementById('TLItemsContainer').innerHTML = List;
			LoadNotes(Order);
			TaskBoxClose();
		}
		else
		{
			alert('There was a problem with the Service-SaveTask request.');
		}
	}
}

//Deletes a task
function DelTask(NoteID)
{
	var Job = document.getElementById('sizeJob'+NoteID).innerHTML;
	if (confirm('Deleting "'+Job+'" Are you sure?')== false){return false;}
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnDelTask;
	xmlHttp.open('Get','ServiceASP.asp?action=DelTask&NoteID='+NoteID, true);
	xmlHttp.send(null);
}


function ReturnDelTask() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//var xmlDoc = xmlHttp.responseXML.documentElement;			
			//			var List = xmlDoc.getElementsByTagName('List')[0].childNodes[0].nodeValue;
			//			document.getElementById('TLItemsContainer').innerHTML = List;
			LoadNotes(Order);
		}
		else
		{
			alert('There was a problem with the Service-DelTask request.');
		}
	}
}



//Updates an existing task////////////////////////////////////////////////////////////////////////////
function UpdateTask()
{
	//alert(txtDate.value+txtJob.value);
	var HTTP = 'ServiceASP.asp?action=UpdateTask';
	HTTP += '&NoteID='+HiddenNoteID.value;
	HTTP += '&d8='+txtDate.value;
	HTTP += '&Job='+txtJob.value;
	HTTP += '&Cust='+txtCust.value;
	HTTP += '&Area='+selArea[selArea.selectedIndex].innerText;
	HTTP += '&Attn='+selAttn[selAttn.selectedIndex].innerText;
	HTTP += '&Notes='+txtNotes.innerText;
	//alert(HTTP);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnUpdateTask;
	xmlHttp.open('Get',HTTP, true);
	xmlHttp.send(null);
}


function ReturnUpdateTask() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			//alert(xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue);
			LoadNotes(Order);
			TaskBoxClose();
		}
		else
		{
			alert('There was a problem with the Service-UpdateTask request.');
}	}	}
//--------------------------------------------------------------------------------------


//Puts an old task in the Archive
function ArchiveTask(NoteID)
{
	var oldDoc=document.body.innerHTML;
	document.body.innerHTML+='<div id="JS2HTML">'+parent.ProgressArray[5][4]+'</div>'
	var ProgID=document.getElementById('ProgByNoteID'+NoteID).value;
	var Progress=document.getElementById('Prog'+ProgID).innerText;
	
	//if(Progress.replace(document.getElementById('JS2HTML').innerHTML,'')==Progress)
	//{alert('Progress must be \'Done\' before archiving.'); return false;}
	
	document.body.innerHTML=oldDoc;
	
	if(confirm('Archive this task?')==false){return false;}
	var HTTP = 'ServiceASP.asp?action=ArchiveTask';
	HTTP += '&NoteID='+NoteID;
	//alert(HTTP);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnArchiveTask;
	xmlHttp.open('Get',HTTP, true);
	xmlHttp.send(null);
}
function ReturnArchiveTask() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			//alert(xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue);
			LoadNotes(Order);
			TaskBoxClose();
		}
		else
		{
			alert('There was a problem with the Service-ArchiveTask request.');
}	}	}
//-----------------------------------------------------
//Restores an old task from the Archive
function Activate(NoteID)
{
	if(confirm('Do you really want to Re-Activate this task?')==false){return false;}
	var HTTP = 'ServiceASP.asp?action=Activate';
	HTTP += '&NoteID='+NoteID;
	//alert(HTTP);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnActivate;
	xmlHttp.open('Get',HTTP, true);
	xmlHttp.send(null);
}
function ReturnActivate() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			//alert(xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue);
			LoadNotes(Order);
			TaskBoxClose();
		}
		else
		{
			alert('There was a problem with the Service-Activate request.');
}	}	}
//-----------------------------------------------------


//updates the progress in the database//////////////////////////////////////////////////////////////////////////////////////
function ProgressClick(NoteID,Phase,DivID,Color,Txt,ColumnID)
{
	document.getElementById(DivID).style.background = '#'+Color;    ///these are used to dynamically change the progress.
	document.getElementById(DivID).innerHTML = Txt ;
	
	
	var HTTP = 'ServiceASP.asp?action=UpdateProgress&NoteID='+NoteID+'&Phase='+Phase+'&ColumnID='+ColumnID+''; // alert (HTTP);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnProgressClick;
	xmlHttp.open('Get',HTTP, true);
	xmlHttp.send(null);
}

function ReturnProgressClick() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			CloseProgressMenu();
		}
		else
		{
			alert('There was a problem with the Service-ProgressClick request.');
}	}	}
//-----------------------------------------------------------------------------------------------------------------------


//updates the priority in the database//////////////////////////////////////////////////////////////////////////////////////
function PriClick(NoteID,Phase,DivID,Color,Txt)
{
	//document.getElementById(DivID).style.background = '#'+Color;    ///these are used to dynamically change the progress.
	//alert(DivID);
	document.getElementById(DivID).innerHTML = Txt ;
	
	
	var HTTP = 'ServiceASP.asp?action=UpdateProgress&NoteID='+NoteID+'&Phase='+Phase+'&ColumnID=Priority';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnPriClick;
	xmlHttp.open('Get',HTTP, true);
	xmlHttp.send(null);
}

function ReturnPriClick() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			ClosePriMenu();
		}
		else
		{
			alert('There was a problem with the Service-PriClick request.');
}	}	}
//-----------------------------------------------------------------------------------------------------------------------




//-------------------------------------------------------------------------------------------------
