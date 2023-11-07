// JavaScript Document   AJAX CONTROLS

var CheckArray = "";

var xmlHttp;
var HttpText;
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject() {
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






//Loads all of the Current Jobs --////////////////////////////////////////////////
function JobList(Active) {
	LoadCommonData();
/*	HttpText='JobsList.asp?Active=True';
	try{Gebi('JobsListFrame').contentDocument.location.reload();}
	catch(e){AjaxErr('JobsList Error',HttpText)}
	if(Active==undefined){Active='True'}
	//alert(Active);
	Gebi('JobOverlayTxt').innerHTML='Requesting Jobs data from server.';
	HttpText='JobsASP.asp?action=GetJobList&Active='+Active;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnJobList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	Gebi('JobOverlayTxt').innerHTML='Data Request Sent. Waiting on server.';
}
var ItemAttns= new Array;
var ItemAttnsList='';

var JobListTries=0;
function ReturnJobList() {
	Gebi('JobOverlayTxt').innerHTML=Gebi('JobOverlayTxt').innerHTML.replace('Data Request Sent. Waiting on server.','Loading Job Data');
	Gebi('JobOverlayTxt').innerHTML+='.';
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200)
		{
			Gebi('JobOverlayTxt').innerHTML='Interpreting Jobs Data';
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var JS = xmlDoc.getElementsByTagName('JS')[0].childNodes[0].nodeValue.replace('--','');
			var RecordCount= xmlDoc.getElementsByTagName('RecordCount')[0].childNodes[0].nodeValue.replace('--','');
			
			var Rows= new Array(RecordCount);
			for(LoopNum=0;LoopNum<RecordCount;LoopNum++)
			{
				Rows[LoopNum]=xmlDoc.getElementsByTagName('Row'+LoopNum)[0]
			}
			
			
			//Tasks=Tasks.replace(/--AMPERSAND--/g,'&')
			//Tasks=Tasks.replace(/--/g,'')
			
			//Gebi('TLItemsContainer').innerHTML = L;
			//alert(JS);
			if(IEver!=0){setTimeout(JS,1);}
			setTimeout("Gebi('JobOverlay').style.display='none';	Gebi('JobOverlayTxt').innerHTML='';",500);
			
			
			Resize();
		}
		else
		{
			if(isNaN(parent.accessEmpID*1)){return false}
			AjaxErr('There was a problem with the JobList request.',HttpText);
			JobOverlay.style.display='none';
			JobOverlayTxt.innerHTML='';
		}
	}
	
*/	
}
//-------------------------------------------------------------------------------------------------


/*
function ProgressClick(NoteID,Phase,DivID,Color,Txt,ColumnID,TableName,SystemID) {
		
	document.getElementById(DivID).style.color = '#'+Color;    ///these are used to instantly change the progress without refreshing the entire page.
	document.getElementById(DivID).innerHTML = Txt ;

	//alert(NoteID+','+Phase+','+DivID+','+Color+','+Txt+','+ColumnID+','+TableName+','+SystemID);
	if(TableName == 'Jobs'){		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnProgressClick;
	  xmlHttp.open('Get','JobsASP.asp?action=UpdateProgress&NoteID='+NoteID+'&Phase='+Phase+'&ColumnID='+ColumnID+'&TableName='+TableName+'', true);
	  xmlHttp.send(null);	  
	}
	if(TableName == 'Systems'){		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnProgressClick;
	  xmlHttp.open('Get','JobsASP.asp?action=UpdateSystemProgress&NoteID='+NoteID+'&Phase='+Phase+'&ColumnID='+ColumnID+'&TableName='+TableName+'&SystemID='+SystemID+'', true);
	  xmlHttp.send(null);	
	}
	
	
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
            alert('There was a problem with the ProgressClick request.');
         }
      }
	  
}





function LoadExpandingDropdownBox(DivID,LoopNum,NoteID) {
	
	//alert(NoteID)
	  xmlHttp = GetXmlHttpObject();
      xmlHttp.onreadystatechange = ReturnGetExpandingInfoBox;
	  xmlHttp.open('Get','JobsASP.asp?action=GetExpandingInfoBox&LoopNum='+LoopNum+'&DivID='+DivID+'&NoteID='+NoteID+'', true);
	  xmlHttp.send(null);

	
}



function ReturnGetExpandingInfoBox() 
{
	
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
	
	
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var Tasks = xmlDoc.getElementsByTagName('Tasks')[0].childNodes[0].nodeValue;
			var DivID = xmlDoc.getElementsByTagName('DivID')[0].childNodes[0].nodeValue;
			
			
			document.getElementById(DivID).innerHTML = Tasks;
			
			RefreshNotesAndToDoSelect();
			
		}
		 else
		 {
            alert('There was a problem with the LoadExpandingDropdownBox request.');
         }
      }
	  
}


	


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







function UpdateDataBaseTable(TableName,ColumnName,NoteID,InputValue) {
		
	  
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
	  xmlHttp.open('Get','JobsASP.asp?action=UpdateDataBaseTable&TableName='+TableName+'&ColumnName='+ColumnName+'&NoteID='+NoteID+'&InputValue='+InputValue+'', true);
	  xmlHttp.send(null);
	  
}


function ReturnUpdateDataBaseTable() 
{
	
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
	
//			alert('yeah')
	     }
		 else
		 {
            alert('There was a problem with one of the following requests: UpdateDataBaseTable, UpdateNotesandToDo, NewNoteandToDo, RefreshNotesAndToDoSelect, or SelectAllNotesAndToDo.');
         }
      }
	  
}






function UpdateNotesandToDo(TableName,ColumnName,InputValue,TableID,LoopNum) {
		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
	  xmlHttp.open('Get','JobsASP.asp?action=UpdateNotesandToDo&TableName='+TableName+'&ColumnName='+ColumnName+'&InputValue='+InputValue+'&TableID='+TableID+'&LoopNum='+LoopNum+'', true);
	  xmlHttp.send(null);
  
}




function NewNoteandToDo(TableName,ColumnName,NoteID,DivID,LoopNum) {
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
	  xmlHttp.open('Get','JobsASP.asp?action=NewNoteandToDo&TableName='+TableName+'&ColumnName='+ColumnName+'&NoteID='+NoteID+'&LoopNum='+LoopNum+'', true);
	  xmlHttp.send(null);
  

 
 if ( TableName == "JobNotes"){RefreshNotes(DivID,NoteID);}
 if ( TableName == "JobToDo"){RefreshToDo(DivID,NoteID);}
  
  
}







/////Reloads Notes List///////////////////////////////////////////////////////////////////////

function RefreshNotes(DivID,NoteID) {

	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnRefreshNotesandToDo;
	  xmlHttp.open('Get','JobsASP.asp?action=RefreshNotes&DivID='+DivID+'&NoteID='+NoteID, true);
	  xmlHttp.send(null);

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
















function RefreshToDo(DivID,NoteID,LoopNum) {

	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnRefreshNotesandToDo;
	  xmlHttp.open('Get','JobsASP.asp?action=RefreshToDo&DivID='+DivID+'&NoteID='+NoteID+'&LoopNum='+LoopNum+'', true);
	  xmlHttp.send(null);

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
















function ReturnRefreshNotesandToDo() 
{
	
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
	
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var Tasks = xmlDoc.getElementsByTagName('Tasks')[0].childNodes[0].nodeValue;
			var DivID = xmlDoc.getElementsByTagName('DivID')[0].childNodes[0].nodeValue;
			
			document.getElementById(DivID).innerHTML = "";
			document.getElementById(DivID).innerHTML = Tasks;
			
	     }
		 else
		 {
            alert('There was a problem with the RefreshNotes request or the ToDo request.');
         }
      }	  
}













function SelectNotesAndToDo(TableName,CBID,ID) {
		
    var CheckedOrNot = document.getElementById(CBID).checked;
	
	if (CheckedOrNot == true){Checked = 1;}
	if (CheckedOrNot == false){Checked = 0;}

	//alert(TableName+' / '+CBID+' / '+ID+' / '+Checked);
	
		 
		 xmlHttp = GetXmlHttpObject();
		 xmlHttp.open('Get','JobsASP.asp?action=SelectNotesAndToDo&TableName='+TableName+'&Checked='+Checked+'&ID='+ID, true);
		 xmlHttp.send(null);	

}








////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





function DeleteNotesAndToDo(TableName,NoteID) {

	
	var Confirm1 = confirm('Are You Sure You Want To Delete These Items?')
		if (Confirm1 == true)
		{
		
				{			
			 	 xmlHttp = GetXmlHttpObject();
				 xmlHttp.open('Get','JobsASP.asp?action=DeleteNotesAndToDo&TableName='+TableName+'&NoteID='+NoteID, true);
			  	 xmlHttp.send(null);	
				}
		
		RefreshNotes(TableName,NoteID);
		
		}

}
				
			
				
				



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








function ToDoItemStatusChange(ToDoID,TrueOrFalse,NoteID,DivID,LoopNum) {
	
	if(TrueOrFalse == "True"){TrueOrFalse = "0"}
	if(TrueOrFalse == "False"){TrueOrFalse = "1"}
	
		  xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnToDoItemStatusChange;
		  xmlHttp.open('Get','JobsASP.asp?action=ChangeToDoStatus&ToDoID='+ToDoID+'&TrueOrFalse='+TrueOrFalse+'&NoteID='+NoteID+'&DivID='+DivID+'&LoopNum='+LoopNum+'', true);
		  xmlHttp.send(null);	
}

function ReturnToDoItemStatusChange() 
{
	
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
		
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var NoteID = xmlDoc.getElementsByTagName('NoteID')[0].childNodes[0].nodeValue;
			var DivID = xmlDoc.getElementsByTagName('DivID')[0].childNodes[0].nodeValue;
			var LoopNum = xmlDoc.getElementsByTagName('LoopNum')[0].childNodes[0].nodeValue;

			RefreshToDo(DivID,NoteID,LoopNum)
	
	     }
		 else
		 {
            alert('There was a problem with the ToDoItemStatusChange request.');
         }
      }  
}






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






function RefreshNotesAndToDoSelect() {
		  xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
		  xmlHttp.open('Get','JobsASP.asp?action=RefreshNotesAndToDoSelect', true);
		  xmlHttp.send(null);	
}






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






function SelectAllNotesAndToDo(NoteID,TableName) {	
		  xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
		  xmlHttp.open('Get','JobsASP.asp?action=SelectAllNotesAndToDo&NoteID='+NoteID+'&TableName='+TableName+'', true);
		  xmlHttp.send(null);		
}















///Update the JobsManager column in the Job/Jobs table/////////////////////////////////////////////////////////////////////////////////////

function UpdateJobsManager(JobsManager,DivID,TaskID) {
	
	
	if (JobsManager == 1) {JobsManager = parent.EmployeeArray[1][2] + " " + parent.EmployeeArray[1][3]}
	if (JobsManager == 2) {JobsManager = parent.EmployeeArray[2][2] + " " + parent.EmployeeArray[2][3]}
	if (JobsManager == 3) {JobsManager = parent.EmployeeArray[3][2] + " " + parent.EmployeeArray[3][3]}
	if (JobsManager == 4) {JobsManager = parent.EmployeeArray[4][2] + " " + parent.EmployeeArray[4][3]}
	if (JobsManager == 5) {JobsManager = parent.EmployeeArray[5][2] + " " + parent.EmployeeArray[5][3]}
	if (JobsManager == 6) {JobsManager = parent.EmployeeArray[6][2] + " " + parent.EmployeeArray[6][3]}
	if (JobsManager == 7) {JobsManager = parent.EmployeeArray[7][2] + " " + parent.EmployeeArray[7][3]}
	if (JobsManager == 8) {JobsManager = parent.EmployeeArray[8][2] + " " + parent.EmployeeArray[8][3]}
	if (JobsManager == 9) {JobsManager = parent.EmployeeArray[9][2] + " " + parent.EmployeeArray[9][3]}
	if (JobsManager == 10) {JobsManager = parent.EmployeeArray[10][2] + " " + parent.EmployeeArray[10][3]}
	if (JobsManager == 11) {JobsManager = parent.EmployeeArray[11][2] + " " + parent.EmployeeArray[11][3]}
	if (JobsManager == 12) {JobsManager = parent.EmployeeArray[12][2] + " " + parent.EmployeeArray[12][3]}
	if (JobsManager == 13) {JobsManager = parent.EmployeeArray[13][2] + " " + parent.EmployeeArray[13][3]}
	if (JobsManager == 14) {JobsManager = parent.EmployeeArray[14][2] + " " + parent.EmployeeArray[14][3]}
	if (JobsManager == 15) {JobsManager = parent.EmployeeArray[15][2] + " " + parent.EmployeeArray[15][3]}
	if (JobsManager == 16) {JobsManager = parent.EmployeeArray[16][2] + " " + parent.EmployeeArray[16][3]}
	

alert(JobsManager + ' ' + TaskID);

	  xmlHttp = GetXmlHttpObject();
      xmlHttp.onreadystatechange = ReturnUpdateJobsManager;
	  xmlHttp.open('Get','JobsASP.asp?action=UpdateJobsManager&JobsManager='+JobsManager+'&TaskID='+TaskID+'', true);
	  xmlHttp.send(null);

	document.getElementById(DivID).innerHTML = JobsManager;
	
}



function ReturnUpdateJobsManager() 
{
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
		  	
			CloseProgressMenu();

         }
		 else
		 {
            alert('There was a problem with the UpdateJobsManager request.');
         }
      }
	  
}


*/

function NewEmpList() {
	JobsList=document.getElementById('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	
	//alert(JobsList+', '+'JobName'+SelectedRow);
	var JobName=JobsList.document.getElementById('JobName'+SelectedRow).innerHTML;
	var EmpListTitle=SelI('ToDoEmpList').innerText
	if(!confirm('Add A New List For '+EmpListTitle+' Under '+JobName+'?')){return false}

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var NoteID=JobsList.document.getElementById('NoteID'+SelectedRow).innerHTML;

	HttpText='JobsASP.asp?action=NewTreeListItem&JobName='+EmpListTitle+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID=0&Notes='+Notes+'&JobTable=Jobs&JobTableID='+NoteID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewEmpList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//alert(HttpText);
}

function ReturnNewEmpList() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			
			var TreeListID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;

			JobsList.location=JobsList.location;
			
			JobsListOnLoadJS='SelectTreeItemByIdLevel2('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with JobsAJAX-NewEmpList.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




function NewItemList()//--------------------------------------------------------
{
	JobsList=document.getElementById('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	SelectedItem=JobsList.SelectedItem;
	
	//alert(JobsList+', '+'JobName'+SelectedRow);
	var JobName=Gebi('txtItemListAdd').value;

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var NoteID=JobsList.document.getElementById('NoteID'+SelectedRow).innerHTML;
	//alert(SelectedItem.id.split('.')[3]);
	var ParentID=JobsList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'TreeListID')).value;
	var EmpID=JobsList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'EmpID')).value;

	if(!confirm('Creating the List: '+JobName/*+'.\n EmpID='+EmpID+'\n ParentID='+ParentID*/)){return false}

	HttpText='JobsASP.asp?action=NewTreeListItem&JobName='+CharsEncode(JobName)+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID='+ParentID+'&Notes='+Notes+'&JobTable=Jobs&JobTableID='+NoteID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewItemList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//alert(HttpText);
}

function ReturnNewItemList() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var TreeListID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;

			JobsList.location=JobsList.location;
			
			JobsListOnLoadJS='SelectTreeItemByIdLevel3('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with JobsAJAX-NewItemList.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function NewListItem()//--------------------------------------------------------
{
	JobsList=document.getElementById('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	SelectedItem=JobsList.SelectedItem;
	
	//alert(JobsList+', '+'JobName'+SelectedRow);
	var JobName=Gebi('txtListItemAdd').value;

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var NoteID=JobsList.document.getElementById('NoteID'+SelectedRow).innerHTML;
	//alert(SelectedItem.id.split('.')[3]);
	var ParentID=JobsList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'TreeListID')).value;
	var EmpID=JobsList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'EmpID')).value;

	//if(!confirm('Creating the Item: '+JobName/*+'.\n EmpID='+EmpID+'\n ParentID='+ParentID*/)){return false}

	HttpText='JobsASP.asp?action=NewTreeListItem&JobName='+CharsEncode(JobName)+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID='+ParentID+'&Notes='+Notes+'&JobTable=Jobs&JobTableID='+NoteID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewListItem;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//alert(HttpText);
}

function ReturnNewListItem() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var TreeListID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;

			JobsList.location=JobsList.location;
			
			JobsListOnLoadJS='SelectTreeItemByIdLevel4('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with JobsAJAX-NewListItem.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function DelTreeItem() {
	JobsList=document.getElementById('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	SelectedItem=JobsList.SelectedItem;
	
	var ItemName=SelectedItem.innerHTML;
	var ItemType=SelectedItem.id.split('.')[0];
	var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
	var ID=JobsList.document.getElementById(TLIDID).value
	
	if(!confirm('Deleting \''+ItemName+'\' and every last SubItem!')){return false}
	
	HttpText='JobsASP.asp?action=DelTreeItem&ID='+ID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnDelTreeItem;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnDelTreeItem() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			SelectedItem.parentNode.style.display='none';
			SelectedItem.parentNode.innerHTML='';
		}
		else{AjaxErr('There is an issue with JobsAJAX-DelTreeItem.',HttpText);}
	}
}



function CheckDone(Done, ID) {
	if(Done===true)
		{Done='True'}
	else
		{Done='False'}
	
	var SQL='UPDATE TreeList SET Done=\''+Done+'\' WHERE TreeListID='+ID
	SendSQL('Write',SQL);
/*	
	HttpText='JobsASP.asp?action=CheckDone&ID='+ID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCheckDone;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnCheckDone() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
		}
		else{AjaxErr('There is an issue with JobsAJAX-CheckDone.',HttpText);}
	}
*/
}


function CheckJobs(Done, NoteID, cb) {
	var Confirm;
	var JavaScript;
	var Nevermind;
	var Now= new Date;
	var date=(Now.getMonth()+1)+'/'+Now.getDate()+'/'+Now.getFullYear();
	if(Done) {
		Confirm='This will De-Activate the job, mark it complete, and set all progress phases to Done.';
		SQL='UPDATE JobsLists SET Active=\'False\', Progress=5, DateCompleted=\''+date+'\' WHERE NoteID='+NoteID;
		JavaScript='';//parent.ChangeToArchive();';
		Nevermind='Gebi(\''+cb.id+'\').checked=false;';
	}
	else {
		Confirm='This will Re-Activate the job.';
		SQL='UPDATE JobsLists SET Active=\'True\' WHERE NoteID='+NoteID;
		JavaScript='';//parent.ChangeToActive();';
		Nevermind='Gebi(\''+cb.id+'\').checked=true;';
	}
	
	if(confirm(Confirm)) {
		SendSQL('Write',SQL)
		cb.parentNode.parentNode.parentNode.removeChild(cb.parentNode.parentNode);
		//setTimeout(JavaScript,50);
	}
	else {
		//setTimeout(Nevermind,50);
	}
}


function RenameJob(NewName) {
	JobsList=document.getElementById('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	SelectedItem=JobsList.SelectedItem;
	
	var ID=JobsList.document.getElementById('NoteID'+SelectedRow).innerHTML;
	var SQL="UPDATE JobsLists SET Job='"+CharsEncode(NewName)+"' WHERE NoteID="+ID;
	SendSQL('Write',SQL);

	SelectedItem.innerHTML=NewName
}

function RenameItem(NewName) {
	JobsList=document.getElementById('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	SelectedItem=JobsList.SelectedItem;
	
	var ItemName=SelectedItem.innerHTML;
	var ItemType=SelectedItem.id.split('.')[0];
	
	var NoteID=SelectedItem.id.replace('JobName','NoteID');
	
	NoteID=null;
	var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
	var ID=JobsList.document.getElementById(TLIDID).value;
	
	var SQL="UPDATE TreeList SET Name='"+CharsEncode(NewName)+"' WHERE TreeListID="+ID;
	SendSQL('Write',SQL);
	
	SelectedItem.innerHTML=NewName
}



function SaveNotes(Notes) {
	JobsList=document.getElementById('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	SelectedItem=JobsList.SelectedItem;
	
	if(SelectedItem.id=='JobName'+SelectedRow) {
		var SQL="UPDATE JobsLists SET Notes='"+CharsEncode(Notes)+"' WHERE NoteID="+JobsList.document.getElementById('NoteID'+SelectedRow).innerHTML;
		SendSQL('Write',SQL);
		
		JobsList.document.getElementById('Notes'+SelectedRow).value=Notes;
	}
	else {
		var ItemName=SelectedItem.innerHTML;
		var ItemType=SelectedItem.id.split('.')[0];
		var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
		var ID=JobsList.document.getElementById(TLIDID).value;
		
		var SQL='UPDATE TreeList SET Notes=\''+CharsEncode(Notes)+'\' WHERE TreeListID='+ID
		SendSQL('Write',SQL);
		
		JobsList.document.getElementById(SelectedItem.id.replace(ItemType,'Notes')).value=Notes;
	}
}



function SetPriority(PriID,PriObj) {
	var NoteID=Gebi('NoteID'+SelectedRow).innerHTML;
	var SQL="UPDATE JobsLists SET Priority="+PriID+" WHERE NoteID="+NoteID;
	SendSQL('Write',SQL);
	Gebi('PriorityMenu').style.display='none';
	Gebi('InnerPri'+SelectedRow).style.background=PriObj.style.background;
	Gebi('InnerPri'+SelectedRow).style.color=PriObj.style.color;
	Gebi('InnerPri'+SelectedRow).innerHTML=PriObj.innerHTML;
}

function SetProgress(ProgID,ProgObj) {
	var NoteID=Gebi('NoteID'+SelectedRow).innerHTML;
	var SQL="UPDATE JobsLists SET Progress="+ProgID+" WHERE NoteID="+NoteID;
	SendSQL('Write',SQL);
	Gebi('ProgressMenu').style.display='none';
	
	Gebi('InnerProg'+SelectedRow).style.background=ProgObj.style.background;
	Gebi('InnerProg'+SelectedRow).style.color=ProgObj.style.color;
	Gebi('InnerProg'+SelectedRow).innerHTML=ProgObj.innerHTML;
}

function AddNewJob(Job,Cust,Attn,date,Due) {
	SQL='INSERT INTO JobsLists (Type, Job, Cust, Attn, Date, DateDue, Active) VALUES ('+TaskType+', \''+Job+'\', \''+Cust+'\', \''+Attn+'\', \''+date+'\', \''+Due+'\', 1 )';
	SendSQL('Write',SQL);  
	JobsList.location=JobsList.location;
	Gebi('CSearchBox').style.display='none';
	Gebi('ModalScreen').style.display='none';
	Gebi('NewJobBox').style.display='none';
}

function DelJob() {
	JobsList=Gebi('JobsListFrame').contentWindow;
	SelectedRow=JobsList.SelectedRow;
	SelectedItem=JobsList.SelectedItem;
	
	if(!confirm('You are about to completely remove \''+JobsList.Gebi('JobName'+SelectedRow).innerHTML+'\'! \n\n Note: Click Cancel if you want to archive an active job with its checkbox instead.')) {return false;}
	
	var SQL='DELETE FROM JobsLists WHERE NoteID='+JobsList.document.getElementById('NoteID'+SelectedRow).innerHTML;
	SendSQL('Write', SQL);
	JobsList.document.getElementById('RowContainer'+SelectedRow).innerHTML='';
	JobsList.document.getElementById('RowContainer'+SelectedRow).style.display='none';
}



var cSearchObj=null;
function LoadCustList(SearchObj) {
	if(SearchObj.value=='') {
		Gebi('CSearchBox').style.display='none';
		return false;
	}
	else {
		Gebi('CSearchBox').style.display='block';
	}
	
	cSearchObj=SearchObj
	HttpText='JobsASP.asp?action=LoadCustList&Search='+encodeURI(SearchObj.value);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLoadCustList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnLoadCustList() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200)
	  {
			try
			{
				var xmlDoc = xmlHttp.responseXML.documentElement;
			
				var length= xmlDoc.getElementsByTagName('length')[0].childNodes[0].nodeValue;
			}
			catch(e)
			{
				AjaxErr('There is an issue with JobsAJAX-LoadCustList xmlDoc.',HttpText);
				return false;
			}
			
			Gebi('CSearchBox').innerHTML='';
			
			var CustName='';
			var HTMLLine='';
			for(c=1;c<length;c++)
			{
				CustName=xmlDoc.getElementsByTagName('Cust'+c)[0].childNodes[0].nodeValue;
				//document.body.innerHTML+='<br/>Cust'+c;
				HTMLLine='<div id="CustResult'+c+'" class="CustLine" onclick="UpdateCust(cSearchObj,this.innerHTML)" title="'+CustName+'">'+CustName+'</div>';;
				
				Gebi('CSearchBox').innerHTML+=HTMLLine;
			}
			
			var btnStyle='style="padding:0; margin:0 float:left; width:100%; font-size:11px;" ';
			Gebi('CSearchBox').innerHTML+='<div style="width:100%;" align="center">';
			Gebi('CSearchBox').innerHTML+=	'<button '+btnStyle+' onclick="Gebi(\'CSearchBox\').style.display=\'none\';">Cancel</button>';
			Gebi('CSearchBox').innerHTML+='</div>';

			
			cSearchObj.focus();
			
			//parent.document.getElementsByClassName('HeadCust')[0].innerHTML=
			//PGebi('ItemNotesText').value=xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue;
			//PGebi('ItemNotesText').value+='\n \n '+HttpText
		}
		else{AjaxErr('There is an issue with JobsAJAX-LoadCustList.',HttpText);}
	}
}

function UpdateCust(txtCust, Customer) {
	if(!Gebi('NoteID'+SelectedRow)) {	//this is what happens outside of JobsLists.															
		txtCust.value=Customer;
		txtCust.style.color='inherit';
		Gebi('CSearchBox').style.display='none';
		return false;
	}
	var SQL="UPDATE JobsLists SET Cust='"+Customer+"' WHERE NoteID="+Gebi('NoteID'+SelectedRow).innerHTML;
	SendSQL('Write',SQL)
	txtCust.value=Customer;
	txtCust.style.color='inherit';
	Gebi('CSearchBox').style.display='none';
}