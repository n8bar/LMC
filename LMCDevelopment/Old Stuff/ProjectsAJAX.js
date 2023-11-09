// JavaScript Document   AJAX CONTROLS

var CheckArray = "";

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






//Loads all of the Current Projects --////////////////////////////////////////////////
function ProjectList(Active)
{
	LoadCommonData();
/*	HttpText='ProjList.asp?Active=True';
	try{Gebi('ProjListFrame').contentDocument.location.reload();}
	catch(e){AjaxErr('ProjList Error',HttpText)}
	if(Active==undefined){Active='True'}
	//alert(Active);
	Gebi('ProjectOverlayTxt').innerHTML='Requesting projects data from server.';
	HttpText='ProjectsASP.asp?action=GetProjectList&Active='+Active;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnProjectList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	Gebi('ProjectOverlayTxt').innerHTML='Data Request Sent. Waiting on server.';
}
var ItemAttns= new Array;
var ItemAttnsList='';

var ProjectListTries=0;
function ReturnProjectList()
{
	Gebi('ProjectOverlayTxt').innerHTML=Gebi('ProjectOverlayTxt').innerHTML.replace('Data Request Sent. Waiting on server.','Loading Project Data');
	Gebi('ProjectOverlayTxt').innerHTML+='.';
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			Gebi('ProjectOverlayTxt').innerHTML='Interpreting Projects Data';
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
			setTimeout("Gebi('ProjectOverlay').style.display='none';	Gebi('ProjectOverlayTxt').innerHTML='';",500);
			
			
			Resize();
		}
		else
		{
			if(isNaN(parent.accessEmpID*1)){return false}
			AjaxErr('There was a problem with the ProjectList request.',HttpText);
			ProjectOverlay.style.display='none';
			ProjectOverlayTxt.innerHTML='';
		}
	}
	
*/	
}
//-------------------------------------------------------------------------------------------------


/*
function ProgressClick(ProjID,Phase,DivID,Color,Txt,ColumnID,TableName,SystemID)
{
		
	document.getElementById(DivID).style.color = '#'+Color;    ///these are used to instantly change the progress without refreshing the entire page.
	document.getElementById(DivID).innerHTML = Txt ;

	//alert(ProjID+','+Phase+','+DivID+','+Color+','+Txt+','+ColumnID+','+TableName+','+SystemID);
	if(TableName == 'Projects'){		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnProgressClick;
	  xmlHttp.open('Get','ProjectsASP.asp?action=UpdateProgress&ProjID='+ProjID+'&Phase='+Phase+'&ColumnID='+ColumnID+'&TableName='+TableName+'', true);
	  xmlHttp.send(null);	  
	}
	if(TableName == 'Systems'){		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnProgressClick;
	  xmlHttp.open('Get','ProjectsASP.asp?action=UpdateSystemProgress&ProjID='+ProjID+'&Phase='+Phase+'&ColumnID='+ColumnID+'&TableName='+TableName+'&SystemID='+SystemID+'', true);
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





function LoadExpandingDropdownBox(DivID,LoopNum,ProjID)
{
	
	//alert(ProjID)
	  xmlHttp = GetXmlHttpObject();
      xmlHttp.onreadystatechange = ReturnGetExpandingInfoBox;
	  xmlHttp.open('Get','ProjectsASP.asp?action=GetExpandingInfoBox&LoopNum='+LoopNum+'&DivID='+DivID+'&ProjID='+ProjID+'', true);
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







function UpdateDataBaseTable(TableName,ColumnName,ProjID,InputValue)
{
		
	  
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
	  xmlHttp.open('Get','ProjectsASP.asp?action=UpdateDataBaseTable&TableName='+TableName+'&ColumnName='+ColumnName+'&ProjID='+ProjID+'&InputValue='+InputValue+'', true);
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






function UpdateNotesandToDo(TableName,ColumnName,InputValue,TableID,LoopNum)
{
		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
	  xmlHttp.open('Get','ProjectsASP.asp?action=UpdateNotesandToDo&TableName='+TableName+'&ColumnName='+ColumnName+'&InputValue='+InputValue+'&TableID='+TableID+'&LoopNum='+LoopNum+'', true);
	  xmlHttp.send(null);
  
}




function NewNoteandToDo(TableName,ColumnName,ProjID,DivID,LoopNum)
{
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
	  xmlHttp.open('Get','ProjectsASP.asp?action=NewNoteandToDo&TableName='+TableName+'&ColumnName='+ColumnName+'&ProjID='+ProjID+'&LoopNum='+LoopNum+'', true);
	  xmlHttp.send(null);
  

 
 if ( TableName == "ProjectNotes"){RefreshNotes(DivID,ProjID);}
 if ( TableName == "ProjectToDo"){RefreshToDo(DivID,ProjID);}
  
  
}







/////Reloads Notes List///////////////////////////////////////////////////////////////////////

function RefreshNotes(DivID,ProjID)
{

	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnRefreshNotesandToDo;
	  xmlHttp.open('Get','ProjectsASP.asp?action=RefreshNotes&DivID='+DivID+'&ProjID='+ProjID, true);
	  xmlHttp.send(null);

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
















function RefreshToDo(DivID,ProjID,LoopNum)
{

	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnRefreshNotesandToDo;
	  xmlHttp.open('Get','ProjectsASP.asp?action=RefreshToDo&DivID='+DivID+'&ProjID='+ProjID+'&LoopNum='+LoopNum+'', true);
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













function SelectNotesAndToDo(TableName,CBID,ID)
{
		
    var CheckedOrNot = document.getElementById(CBID).checked;
	
	if (CheckedOrNot == true){Checked = 1;}
	if (CheckedOrNot == false){Checked = 0;}

	//alert(TableName+' / '+CBID+' / '+ID+' / '+Checked);
	
		 
		 xmlHttp = GetXmlHttpObject();
		 xmlHttp.open('Get','ProjectsASP.asp?action=SelectNotesAndToDo&TableName='+TableName+'&Checked='+Checked+'&ID='+ID, true);
		 xmlHttp.send(null);	

}








////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





function DeleteNotesAndToDo(TableName,ProjID)
{

	
	var Confirm1 = confirm('Are You Sure You Want To Delete These Items?')
		if (Confirm1 == true)
		{
		
				{			
			 	 xmlHttp = GetXmlHttpObject();
				 xmlHttp.open('Get','ProjectsASP.asp?action=DeleteNotesAndToDo&TableName='+TableName+'&ProjID='+ProjID, true);
			  	 xmlHttp.send(null);	
				}
		
		RefreshNotes(TableName,ProjID);
		
		}

}
				
			
				
				



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








function ToDoItemStatusChange(ToDoID,TrueOrFalse,ProjID,DivID,LoopNum)
{
	
	if(TrueOrFalse == "True"){TrueOrFalse = "0"}
	if(TrueOrFalse == "False"){TrueOrFalse = "1"}
	
		  xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnToDoItemStatusChange;
		  xmlHttp.open('Get','ProjectsASP.asp?action=ChangeToDoStatus&ToDoID='+ToDoID+'&TrueOrFalse='+TrueOrFalse+'&ProjID='+ProjID+'&DivID='+DivID+'&LoopNum='+LoopNum+'', true);
		  xmlHttp.send(null);	
}

function ReturnToDoItemStatusChange() 
{
	
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
		
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var ProjID = xmlDoc.getElementsByTagName('ProjID')[0].childNodes[0].nodeValue;
			var DivID = xmlDoc.getElementsByTagName('DivID')[0].childNodes[0].nodeValue;
			var LoopNum = xmlDoc.getElementsByTagName('LoopNum')[0].childNodes[0].nodeValue;

			RefreshToDo(DivID,ProjID,LoopNum)
	
	     }
		 else
		 {
            alert('There was a problem with the ToDoItemStatusChange request.');
         }
      }  
}






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






function RefreshNotesAndToDoSelect()
{
		  xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
		  xmlHttp.open('Get','ProjectsASP.asp?action=RefreshNotesAndToDoSelect', true);
		  xmlHttp.send(null);	
}






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






function SelectAllNotesAndToDo(ProjID,TableName)
{	
		  xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
		  xmlHttp.open('Get','ProjectsASP.asp?action=SelectAllNotesAndToDo&ProjID='+ProjID+'&TableName='+TableName+'', true);
		  xmlHttp.send(null);		
}















///Update the ProjManager column in the Project/Jobs table/////////////////////////////////////////////////////////////////////////////////////

function UpdateProjManager(ProjManager,DivID,TaskID)
{
	
	
	if (ProjManager == 1) {ProjManager = parent.EmployeeArray[1][2] + " " + parent.EmployeeArray[1][3]}
	if (ProjManager == 2) {ProjManager = parent.EmployeeArray[2][2] + " " + parent.EmployeeArray[2][3]}
	if (ProjManager == 3) {ProjManager = parent.EmployeeArray[3][2] + " " + parent.EmployeeArray[3][3]}
	if (ProjManager == 4) {ProjManager = parent.EmployeeArray[4][2] + " " + parent.EmployeeArray[4][3]}
	if (ProjManager == 5) {ProjManager = parent.EmployeeArray[5][2] + " " + parent.EmployeeArray[5][3]}
	if (ProjManager == 6) {ProjManager = parent.EmployeeArray[6][2] + " " + parent.EmployeeArray[6][3]}
	if (ProjManager == 7) {ProjManager = parent.EmployeeArray[7][2] + " " + parent.EmployeeArray[7][3]}
	if (ProjManager == 8) {ProjManager = parent.EmployeeArray[8][2] + " " + parent.EmployeeArray[8][3]}
	if (ProjManager == 9) {ProjManager = parent.EmployeeArray[9][2] + " " + parent.EmployeeArray[9][3]}
	if (ProjManager == 10) {ProjManager = parent.EmployeeArray[10][2] + " " + parent.EmployeeArray[10][3]}
	if (ProjManager == 11) {ProjManager = parent.EmployeeArray[11][2] + " " + parent.EmployeeArray[11][3]}
	if (ProjManager == 12) {ProjManager = parent.EmployeeArray[12][2] + " " + parent.EmployeeArray[12][3]}
	if (ProjManager == 13) {ProjManager = parent.EmployeeArray[13][2] + " " + parent.EmployeeArray[13][3]}
	if (ProjManager == 14) {ProjManager = parent.EmployeeArray[14][2] + " " + parent.EmployeeArray[14][3]}
	if (ProjManager == 15) {ProjManager = parent.EmployeeArray[15][2] + " " + parent.EmployeeArray[15][3]}
	if (ProjManager == 16) {ProjManager = parent.EmployeeArray[16][2] + " " + parent.EmployeeArray[16][3]}
	

alert(ProjManager + ' ' + TaskID);

	  xmlHttp = GetXmlHttpObject();
      xmlHttp.onreadystatechange = ReturnUpdateProjManager;
	  xmlHttp.open('Get','ProjectsASP.asp?action=UpdateProjManager&ProjManager='+ProjManager+'&TaskID='+TaskID+'', true);
	  xmlHttp.send(null);

	document.getElementById(DivID).innerHTML = ProjManager;
	
}



function ReturnUpdateProjManager() 
{
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
		  	
			CloseProgressMenu();

         }
		 else
		 {
            alert('There was a problem with the UpdateProjManager request.');
         }
      }
	  
}


*/

function NewEmpList()
{
	ProjList=document.getElementById('ProjListFrame').contentWindow;
	SelectedRow=ProjList.SelectedRow;
	
	//alert(ProjList+', '+'JobName'+SelectedRow);
	var JobName=ProjList.document.getElementById('JobName'+SelectedRow).innerHTML;
	var EmpListTitle=SelI('ToDoEmpList').innerText
	if(!confirm('Add A New List For '+EmpListTitle+' Under '+JobName+'?')){return false}

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var ProjID=ProjList.document.getElementById('ProjID'+SelectedRow).innerHTML;

	HttpText='ProjectsASP.asp?action=NewTreeListItem&JobName='+EmpListTitle+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID=0&Notes='+Notes+'&JobTable=Projects&JobTableID='+ProjID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewEmpList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//alert(HttpText);
}

function ReturnNewEmpList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			
			var TreeListID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;

			ProjList.location=ProjList.location;
			
			ProjListOnLoadJS='SelectTreeItemByIdLevel2('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with ProjectsAJAX-NewEmpList.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




function NewItemList()//--------------------------------------------------------
{
	ProjList=document.getElementById('ProjListFrame').contentWindow;
	SelectedRow=ProjList.SelectedRow;
	SelectedItem=ProjList.SelectedItem;
	
	//alert(ProjList+', '+'JobName'+SelectedRow);
	var JobName=Gebi('txtItemListAdd').value;

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var ProjID=ProjList.document.getElementById('ProjID'+SelectedRow).innerHTML;
	//alert(SelectedItem.id.split('.')[3]);
	var ParentID=ProjList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'TreeListID')).value;
	var EmpID=ProjList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'EmpID')).value;

	if(!confirm('Creating the List: '+JobName/*+'.\n EmpID='+EmpID+'\n ParentID='+ParentID*/)){return false}

	HttpText='ProjectsASP.asp?action=NewTreeListItem&JobName='+CharsEncode(JobName)+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID='+ParentID+'&Notes='+Notes+'&JobTable=Projects&JobTableID='+ProjID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewItemList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//alert(HttpText);
}

function ReturnNewItemList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var TreeListID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;

			ProjList.location=ProjList.location;
			
			ProjListOnLoadJS='SelectTreeItemByIdLevel3('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with ProjectsAJAX-NewItemList.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function NewListItem()//--------------------------------------------------------
{
	ProjList=document.getElementById('ProjListFrame').contentWindow;
	SelectedRow=ProjList.SelectedRow;
	SelectedItem=ProjList.SelectedItem;
	
	//alert(ProjList+', '+'JobName'+SelectedRow);
	var JobName=Gebi('txtListItemAdd').value;

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var ProjID=ProjList.document.getElementById('ProjID'+SelectedRow).innerHTML;
	//alert(SelectedItem.id.split('.')[3]);
	var ParentID=ProjList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'TreeListID')).value;
	var EmpID=ProjList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'EmpID')).value;

	//if(!confirm('Creating the Item: '+JobName/*+'.\n EmpID='+EmpID+'\n ParentID='+ParentID*/)){return false}

	HttpText='ProjectsASP.asp?action=NewTreeListItem&JobName='+CharsEncode(JobName)+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID='+ParentID+'&Notes='+Notes+'&JobTable=Projects&JobTableID='+ProjID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewListItem;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//alert(HttpText);
}

function ReturnNewListItem()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var TreeListID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;

			ProjList.location=ProjList.location;
			
			ProjListOnLoadJS='SelectTreeItemByIdLevel4('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with ProjectsAJAX-NewListItem.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function NewSubItem()//--------------------------------------------------------
{
	ProjList=document.getElementById('ProjListFrame').contentWindow;
	SelectedRow=ProjList.SelectedRow;
	SelectedItem=ProjList.SelectedItem;
	
	//alert(ProjList+', '+'JobName'+SelectedRow);
	var JobName=Gebi('txtSubItemAdd').value;

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var ProjID=ProjList.document.getElementById('ProjID'+SelectedRow).innerHTML;
	//alert(SelectedItem.id.split('.')[3]);
	var ParentID=ProjList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'TreeListID')).value;
	var EmpID=ProjList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'EmpID')).value;

	if(!confirm('Creating the Item: '+JobName/*+'.\n EmpID='+EmpID+'\n ParentID='+ParentID*/)){return false}

	HttpText='ProjectsASP.asp?action=NewTreeListItem&JobName='+CharsEncode(JobName)+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID='+ParentID+'&Notes='+Notes+'&JobTable=Projects&JobTableID='+ProjID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewSubItem;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	//alert(HttpText);
}

function ReturnNewSubItem()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var TreeListID=xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;

			ProjList.location=ProjList.location;
			
			ProjListOnLoadJS='SelectTreeItemByIdLevel5('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with ProjectsAJAX-NewSubItem.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function DelTreeItem()
{
	ProjList=document.getElementById('ProjListFrame').contentWindow;
	SelectedRow=ProjList.SelectedRow;
	SelectedItem=ProjList.SelectedItem;
	
	var ItemName=SelectedItem.innerHTML;
	var ItemType=SelectedItem.id.split('.')[0];
	var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
	var ID=ProjList.document.getElementById(TLIDID).value
	
	if(!confirm('Deleting \''+ItemName+'\' and every last SubItem!')){return false}
	
	HttpText='ProjectsASP.asp?action=DelTreeItem&ID='+ID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnDelTreeItem;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnDelTreeItem()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			SelectedItem.parentNode.style.display='none';
			SelectedItem.parentNode.innerHTML='';
		}
		else{AjaxErr('There is an issue with ProjectsAJAX-DelTreeItem.',HttpText);}
	}
}



function CheckDone(Done, ID)
{
	if(Done===true)
		{Done='True'}
	else
		{Done='False'}
	
	var SQL='UPDATE TreeList SET Done=\''+Done+'\' WHERE TreeListID='+ID
	SendSQL('Write',SQL);
/*	
	HttpText='ProjectsASP.asp?action=CheckDone&ID='+ID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCheckDone;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnCheckDone()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
	  {
			var xmlDoc = xmlHttp.responseXML.documentElement;
		}
		else{AjaxErr('There is an issue with ProjectsAJAX-CheckDone.',HttpText);}
	}
*/
}


function CheckProj(Done, ProjID, cb)
{
	var Confirm;

	var JavaScript;

	var Nevermind;

	var Now= new Date;

	var date=(Now.getMonth()+1)+'/'+Now.getDate()+'/'+Now.getFullYear();


	if(Done)
	{
		Confirm='This will De-Activate the job, mark it complete, and set all progress phases to Done.';
		SQL='UPDATE Projects SET Active=\'False\', Plans=5, Permits=5, UnderGround=5, RoughIn=5, RoughInspect=5, OrderMaterials=5, Trim=5, FinishInspect=5, JobCompleted=5, DateCompleted=\''+date+'\' WHERE ProjID='+ProjID;
		//JavaScript='parent.ChangeToArchive();';
		window.location=window.location;
		Nevermind='Gebi(\''+cb.id+'\').checked=false;';
	}
	else
	{
		Confirm='This will Re-Activate the job.';
		SQL='UPDATE Projects SET Active=\'True\' WHERE ProjID='+ProjID;
		JavaScript='parent.ChangeToActive();';
		Nevermind='Gebi(\''+cb.id+'\').checked=true;';
	}
	
	if(confirm(Confirm))
	{
		SendSQL('Write',SQL)
		setTimeout(JavaScript,50);
	}
	else
	{
		setTimeout(Nevermind,50);
	}
}


function RenameItem(NewName)
{
	ProjList=document.getElementById('ProjListFrame').contentWindow;
	SelectedRow=ProjList.SelectedRow;
	SelectedItem=ProjList.SelectedItem;
	
	var ItemName=SelectedItem.innerHTML;
	var ItemType=SelectedItem.id.split('.')[0];
	var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
	var ID=ProjList.document.getElementById(TLIDID).value;
	
	var SQL='UPDATE TreeList SET Name=\''+CharsEncode(NewName)+'\' WHERE TreeListID='+ID
	SendSQL('Write',SQL);
	
	SelectedItem.innerHTML=NewName
}

function SaveNotes(Notes)
{
	ProjList=document.getElementById('ProjListFrame').contentWindow;
	SelectedRow=ProjList.SelectedRow;
	SelectedItem=ProjList.SelectedItem;
	
	if(SelectedItem.id=='JobName'+SelectedRow)
	{
		var SQL="UPDATE Projects SET Notes='"+CharsEncode(Notes)+"' WHERE ProjID="+ProjList.document.getElementById('ProjID'+SelectedRow).innerHTML;
		SendSQL('Write',SQL);
		
		ProjList.document.getElementById('Notes'+SelectedRow).value=Notes;
	}
	else
	{
		var ItemName=SelectedItem.innerHTML;
		var ItemType=SelectedItem.id.split('.')[0];
		var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
		var ID=ProjList.document.getElementById(TLIDID).value;
		
		var SQL='UPDATE TreeList SET Notes=\''+CharsEncode(Notes)+'\' WHERE TreeListID='+ID
		SendSQL('Write',SQL);
		
		ProjList.document.getElementById(SelectedItem.id.replace(ItemType,'Notes')).value=Notes;
	}
}

function SetPriority(PriID,PriObj)
{
	var ProjID=Gebi('ProjID'+SelectedRow).innerHTML;
	var SQL="UPDATE Projects SET Priority="+PriID+" WHERE ProjID="+ProjID;
	SendSQL('Write',SQL);
	Gebi('PriorityMenu').style.display='none';
	Gebi('InnerPri'+SelectedRow).style.background=PriObj.style.background;
	Gebi('InnerPri'+SelectedRow).style.color=PriObj.style.color;
	Gebi('InnerPri'+SelectedRow).innerHTML=PriObj.innerHTML;
}

function SetProgress(ProgID, ProgObj)
{
	var ProjID=Gebi('ProjID'+SelectedRow).innerHTML;
	var SQL="UPDATE Projects SET "+ProgressCol+"="+ProgID+" WHERE ProjID="+ProjID;
	SendSQL('Write',SQL);
	Gebi('ProgressMenu').style.display='none';
	Gebi('InnerProg'+SelectedRow+ProgressCol).style.background=ProgObj.style.background;
	Gebi('InnerProg'+SelectedRow+ProgressCol).style.color=ProgObj.style.color;
	Gebi('InnerProg'+SelectedRow+ProgressCol).innerHTML=ProgObj.innerHTML;
}

