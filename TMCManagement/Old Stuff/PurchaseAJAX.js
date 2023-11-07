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






//Loads all of the Current Purchasing --////////////////////////////////////////////////
function PurchaseList(Active)
{
	LoadCommonData();
/*	HttpText='PurchaseList.asp?Active=True';
	try{Gebi('PurchaseListFrame').contentDocument.location.reload();}
	catch(e){AjaxErr('PurchaseList Error',HttpText)}
	if(Active==undefined){Active='True'}
	//alert(Active);
	Gebi('PurchaseOverlayTxt').innerHTML='Requesting Purchasing data from server.';
	HttpText='PurchaseASP.asp?action=GetPurchaseList&Active='+Active;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnPurchaseList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	Gebi('PurchaseOverlayTxt').innerHTML='Data Request Sent. Waiting on server.';
}
var ItemAttns= new Array;
var ItemAttnsList='';

var PurchaseListTries=0;
function ReturnPurchaseList()
{
	Gebi('PurchaseOverlayTxt').innerHTML=Gebi('PurchaseOverlayTxt').innerHTML.replace('Data Request Sent. Waiting on server.','Loading Purchase Data');
	Gebi('PurchaseOverlayTxt').innerHTML+='.';
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			Gebi('PurchaseOverlayTxt').innerHTML='Interpreting Purchasing Data';
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
			setTimeout("Gebi('PurchaseOverlay').style.display='none';	Gebi('PurchaseOverlayTxt').innerHTML='';",500);
			
			
			Resize();
		}
		else
		{
			if(isNaN(parent.accessEmpID*1)){return false}
			AjaxErr('There was a problem with the PurchaseList request.',HttpText);
			PurchaseOverlay.style.display='none';
			PurchaseOverlayTxt.innerHTML='';
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
	if(TableName == 'Purchasing'){		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnProgressClick;
	  xmlHttp.open('Get','PurchaseASP.asp?action=UpdateProgress&ProjID='+ProjID+'&Phase='+Phase+'&ColumnID='+ColumnID+'&TableName='+TableName+'', true);
	  xmlHttp.send(null);	  
	}
	if(TableName == 'Systems'){		
 	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnProgressClick;
	  xmlHttp.open('Get','PurchaseASP.asp?action=UpdateSystemProgress&ProjID='+ProjID+'&Phase='+Phase+'&ColumnID='+ColumnID+'&TableName='+TableName+'&SystemID='+SystemID+'', true);
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
	  xmlHttp.open('Get','PurchaseASP.asp?action=GetExpandingInfoBox&LoopNum='+LoopNum+'&DivID='+DivID+'&ProjID='+ProjID+'', true);
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
	  xmlHttp.open('Get','PurchaseASP.asp?action=UpdateDataBaseTable&TableName='+TableName+'&ColumnName='+ColumnName+'&ProjID='+ProjID+'&InputValue='+InputValue+'', true);
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
	  xmlHttp.open('Get','PurchaseASP.asp?action=UpdateNotesandToDo&TableName='+TableName+'&ColumnName='+ColumnName+'&InputValue='+InputValue+'&TableID='+TableID+'&LoopNum='+LoopNum+'', true);
	  xmlHttp.send(null);
  
}




function NewNoteandToDo(TableName,ColumnName,ProjID,DivID,LoopNum)
{
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
	  xmlHttp.open('Get','PurchaseASP.asp?action=NewNoteandToDo&TableName='+TableName+'&ColumnName='+ColumnName+'&ProjID='+ProjID+'&LoopNum='+LoopNum+'', true);
	  xmlHttp.send(null);
  

 
 if ( TableName == "PurchaseNotes"){RefreshNotes(DivID,ProjID);}
 if ( TableName == "PurchaseToDo"){RefreshToDo(DivID,ProjID);}
  
  
}







/////Reloads Notes List///////////////////////////////////////////////////////////////////////

function RefreshNotes(DivID,ProjID)
{

	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnRefreshNotesandToDo;
	  xmlHttp.open('Get','PurchaseASP.asp?action=RefreshNotes&DivID='+DivID+'&ProjID='+ProjID, true);
	  xmlHttp.send(null);

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
















function RefreshToDo(DivID,ProjID,LoopNum)
{

	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnRefreshNotesandToDo;
	  xmlHttp.open('Get','PurchaseASP.asp?action=RefreshToDo&DivID='+DivID+'&ProjID='+ProjID+'&LoopNum='+LoopNum+'', true);
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
		 xmlHttp.open('Get','PurchaseASP.asp?action=SelectNotesAndToDo&TableName='+TableName+'&Checked='+Checked+'&ID='+ID, true);
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
				 xmlHttp.open('Get','PurchaseASP.asp?action=DeleteNotesAndToDo&TableName='+TableName+'&ProjID='+ProjID, true);
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
		  xmlHttp.open('Get','PurchaseASP.asp?action=ChangeToDoStatus&ToDoID='+ToDoID+'&TrueOrFalse='+TrueOrFalse+'&ProjID='+ProjID+'&DivID='+DivID+'&LoopNum='+LoopNum+'', true);
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
		  xmlHttp.open('Get','PurchaseASP.asp?action=RefreshNotesAndToDoSelect', true);
		  xmlHttp.send(null);	
}






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






function SelectAllNotesAndToDo(ProjID,TableName)
{	
		  xmlHttp = GetXmlHttpObject();
		  xmlHttp.onreadystatechange = ReturnUpdateDataBaseTable;
		  xmlHttp.open('Get','PurchaseASP.asp?action=SelectAllNotesAndToDo&ProjID='+ProjID+'&TableName='+TableName+'', true);
		  xmlHttp.send(null);		
}















///Update the PurchaseManager column in the Purchase/Jobs table/////////////////////////////////////////////////////////////////////////////////////

function UpdatePurchaseManager(PurchaseManager,DivID,TaskID)
{
	
	
	if (PurchaseManager == 1) {PurchaseManager = parent.EmployeeArray[1][2] + " " + parent.EmployeeArray[1][3]}
	if (PurchaseManager == 2) {PurchaseManager = parent.EmployeeArray[2][2] + " " + parent.EmployeeArray[2][3]}
	if (PurchaseManager == 3) {PurchaseManager = parent.EmployeeArray[3][2] + " " + parent.EmployeeArray[3][3]}
	if (PurchaseManager == 4) {PurchaseManager = parent.EmployeeArray[4][2] + " " + parent.EmployeeArray[4][3]}
	if (PurchaseManager == 5) {PurchaseManager = parent.EmployeeArray[5][2] + " " + parent.EmployeeArray[5][3]}
	if (PurchaseManager == 6) {PurchaseManager = parent.EmployeeArray[6][2] + " " + parent.EmployeeArray[6][3]}
	if (PurchaseManager == 7) {PurchaseManager = parent.EmployeeArray[7][2] + " " + parent.EmployeeArray[7][3]}
	if (PurchaseManager == 8) {PurchaseManager = parent.EmployeeArray[8][2] + " " + parent.EmployeeArray[8][3]}
	if (PurchaseManager == 9) {PurchaseManager = parent.EmployeeArray[9][2] + " " + parent.EmployeeArray[9][3]}
	if (PurchaseManager == 10) {PurchaseManager = parent.EmployeeArray[10][2] + " " + parent.EmployeeArray[10][3]}
	if (PurchaseManager == 11) {PurchaseManager = parent.EmployeeArray[11][2] + " " + parent.EmployeeArray[11][3]}
	if (PurchaseManager == 12) {PurchaseManager = parent.EmployeeArray[12][2] + " " + parent.EmployeeArray[12][3]}
	if (PurchaseManager == 13) {PurchaseManager = parent.EmployeeArray[13][2] + " " + parent.EmployeeArray[13][3]}
	if (PurchaseManager == 14) {PurchaseManager = parent.EmployeeArray[14][2] + " " + parent.EmployeeArray[14][3]}
	if (PurchaseManager == 15) {PurchaseManager = parent.EmployeeArray[15][2] + " " + parent.EmployeeArray[15][3]}
	if (PurchaseManager == 16) {PurchaseManager = parent.EmployeeArray[16][2] + " " + parent.EmployeeArray[16][3]}
	

alert(PurchaseManager + ' ' + TaskID);

	  xmlHttp = GetXmlHttpObject();
      xmlHttp.onreadystatechange = ReturnUpdatePurchaseManager;
	  xmlHttp.open('Get','PurchaseASP.asp?action=UpdatePurchaseManager&PurchaseManager='+PurchaseManager+'&TaskID='+TaskID+'', true);
	  xmlHttp.send(null);

	document.getElementById(DivID).innerHTML = PurchaseManager;
	
}



function ReturnUpdatePurchaseManager() 
{
      if (xmlHttp.readyState == 4)
	  {
		 
		if (xmlHttp.status == 200)
	    {
		  	
			CloseProgressMenu();

         }
		 else
		 {
            alert('There was a problem with the UpdatePurchaseManager request.');
         }
      }
	  
}


*/

function NewEmpList()
{
	PurchaseList=document.getElementById('PurchaseListFrame').contentWindow;
	SelectedRow=PurchaseList.SelectedRow;
	
	//alert(PurchaseList+', '+'JobName'+SelectedRow);
	var JobName=PurchaseList.document.getElementById('JobName'+SelectedRow).innerHTML;
	var EmpListTitle=SelI('ToDoEmpList').innerText
	if(!confirm('Add A New List For '+EmpListTitle+' Under '+JobName+'?')){return false}

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var ProjID=PurchaseList.document.getElementById('ProjID'+SelectedRow).innerHTML;

	HttpText='PurchaseASP.asp?action=NewTreeListItem&JobName='+EmpListTitle+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID=0&Notes='+Notes+'&TaskID=7&JobTable=Projects&JobTableID='+ProjID;
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

			PurchaseList.location=PurchaseList.location;
			
			PurchaseListOnLoadJS='SelectTreeItemByIdLevel2('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with PurchasingAJAX-NewEmpList.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




function NewItemList()//--------------------------------------------------------
{
	PurchaseList=document.getElementById('PurchaseListFrame').contentWindow;
	SelectedRow=PurchaseList.SelectedRow;
	SelectedItem=PurchaseList.SelectedItem;
	
	//alert(PurchaseList+', '+'JobName'+SelectedRow);
	var JobName=Gebi('txtItemListAdd').value;

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var ProjID=PurchaseList.document.getElementById('ProjID'+SelectedRow).innerHTML;
	//alert(SelectedItem.id.split('.')[3]);
	var ParentID=PurchaseList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'TreeListID')).value;
	var EmpID=PurchaseList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'EmpID')).value;

	if(!confirm('Creating the List: '+JobName/*+'.\n EmpID='+EmpID+'\n ParentID='+ParentID*/)){return false}

	HttpText='PurchaseASP.asp?action=NewTreeListItem&JobName='+CharsEncode(JobName)+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID='+ParentID+'&Notes='+Notes+'&TaskID=7&JobTable=Projects&JobTableID='+ProjID;
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

			PurchaseList.location=PurchaseList.location;
			
			PurchaseListOnLoadJS='SelectTreeItemByIdLevel3('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with PurchasingAJAX-NewItemList.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function NewListItem()//--------------------------------------------------------
{
	PurchaseList=document.getElementById('PurchaseListFrame').contentWindow;
	SelectedRow=PurchaseList.SelectedRow;
	SelectedItem=PurchaseList.SelectedItem;
	
	//alert(PurchaseList+', '+'JobName'+SelectedRow);
	var JobName=Gebi('txtListItemAdd').value;

	var Notes='NONE';//Gebi('ItemNotesText').value;
	var ProjID=PurchaseList.document.getElementById('ProjID'+SelectedRow).innerHTML;
	//alert(SelectedItem.id.split('.')[3]);
	var ParentID=PurchaseList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'TreeListID')).value;
	var EmpID=PurchaseList.document.getElementById(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'EmpID')).value;

	//if(!confirm('Creating the Item: '+JobName/*+'.\n EmpID='+EmpID+'\n ParentID='+ParentID*/)){return false}

	HttpText='PurchaseASP.asp?action=NewTreeListItem&JobName='+CharsEncode(JobName)+'&EmpID='+SelI('ToDoEmpList').value+'&ParentID='+ParentID+'&Notes='+Notes+'&TaskID=7&JobTable=Projects&JobTableID='+ProjID;
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

			PurchaseList.location=PurchaseList.location;
			
			PurchaseListOnLoadJS='SelectTreeItemByIdLevel4('+TreeListID+');';
		}
		else{AjaxErr('There is an issue with PurchasingAJAX-NewListItem.',HttpText);}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function DelTreeItem()
{
	PurchaseList=document.getElementById('PurchaseListFrame').contentWindow;
	SelectedRow=PurchaseList.SelectedRow;
	SelectedItem=PurchaseList.SelectedItem;
	
	var ItemName=SelectedItem.innerHTML;
	var ItemType=SelectedItem.id.split('.')[0];
	var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
	var ID=PurchaseList.document.getElementById(TLIDID).value
	
	if(!confirm('Deleting \''+ItemName+'\' and every last SubItem!')){return false}
	
	HttpText='PurchaseASP.asp?action=DelTreeItem&ID='+ID
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
		else{AjaxErr('There is an issue with PurchasingAJAX-DelTreeItem.',HttpText);}
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
	HttpText='PurchaseASP.asp?action=CheckDone&ID='+ID
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
		else{AjaxErr('There is an issue with PurchasingAJAX-CheckDone.',HttpText);}
	}
*/
}


function CheckPurchase(Done, ProjID, cb)
{
	var Confirm;
	var JavaScript;
	var Nevermind;
	var Now= new Date;
	var date=(Now.getMonth()+1)+'/'+Now.getDate()+'/'+Now.getFullYear();
	if(Done)
	{
		Confirm='This will De-Activate the job, mark it complete, and set all Engineering progress phases to Done.';
		SQL='UPDATE Projects SET PurchasingArchive=\'True\', OrderUG=5, ReceiveUG=5, OrderRoughIn=5, ReceiveRoughIn=5, OrderFinish=5, ReceiveFinish=5, OrderMaterials=5, PurchasingCompletedDate=\''+date+'\' WHERE ProjID='+ProjID;
		//JavaScript='parent.ChangeToArchive();';
		window.location=window.location;
		Nevermind='Gebi(\''+cb.id+'\').checked=false;';
	}
	else
	{
		Confirm='This will Re-Activate the job.';
		SQL='UPDATE Projects SET PurchasingArchive=\'False\' WHERE ProjID='+ProjID;
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
	PurchaseList=document.getElementById('PurchaseListFrame').contentWindow;
	SelectedRow=PurchaseList.SelectedRow;
	SelectedItem=PurchaseList.SelectedItem;
	
	var ItemName=SelectedItem.innerHTML;
	var ItemType=SelectedItem.id.split('.')[0];
	var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
	var ID=PurchaseList.document.getElementById(TLIDID).value;
	
	var SQL='UPDATE TreeList SET Name=\''+CharsEncode(NewName)+'\' WHERE TreeListID='+ID
	SendSQL('Write',SQL);
	
	SelectedItem.innerHTML=NewName
}

function SaveNotes(Notes)
{
	PurchaseList=document.getElementById('PurchaseListFrame').contentWindow;
	SelectedRow=PurchaseList.SelectedRow;
	SelectedItem=PurchaseList.SelectedItem;
	
	if(SelectedItem.id=='JobName'+SelectedRow)
	{
		var SQL="UPDATE Projects SET PurchasingNotes='"+CharsEncode(Notes)+"' WHERE ProjID="+PurchaseList.document.getElementById('ProjID'+SelectedRow).innerHTML;
		SendSQL('Write',SQL);
		
		PurchaseList.document.getElementById('Notes'+SelectedRow).value=Notes;
	}
	else
	{
		var ItemName=SelectedItem.innerHTML;
		var ItemType=SelectedItem.id.split('.')[0];
		var TLIDID=SelectedItem.id.replace(ItemType,'TreeListID')
		var ID=PurchaseList.document.getElementById(TLIDID).value;
		
		var SQL='UPDATE TreeList SET Notes=\''+CharsEncode(Notes)+'\' WHERE TreeListID='+ID
		SendSQL('Write',SQL);
		
		PurchaseList.document.getElementById(SelectedItem.id.replace(ItemType,'Notes')).value=Notes;
	}
}

function SetPriority(PriID,PriObj)
{
	var ProjID=Gebi('ProjID'+SelectedRow).innerHTML;
	var SQL="UPDATE Projects SET PurchasePriority="+PriID+" WHERE ProjID="+ProjID;
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

