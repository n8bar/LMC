// JavaScript Document


var Order = 'Date';
var ActiveList = true;


var mX=0;
var mY=0;
function MouseMove(event)
{
		parent.ResetLogoutTimer();

		if (!event){event = window.event;}
		mX = event.clientX;
		mY = event.clientY;
}



function TaskBox(Title)
{
	TaskBoxTitle.innerHTML = '<b>'+Title+'</b>';
	if (Title == "New Task"){BoxUpdate.style.display='none'; BoxSave.style.display = 'block';}else{BoxUpdate.style.display = 'block'}
	
	Modal.style.display = 'block';
	document.getElementById('TaskBox').style.display = 'block';
	var W = document.body.offsetWidth ;
	var H = document.body.offsetHeight ;
	document.getElementById('TaskBox').style.left = (.5-((document.getElementById('TaskBox').offsetWidth/2)/W))*100+'%'; //Center Box
	document.getElementById('TaskBox').style.top = ((1/3)-((document.getElementById('TaskBox').offsetHeight/3)/H))*100+'%'; //Space from Top
	document.getElementById('CustSearchBox').style.left = document.getElementById('TaskBox').style.left;
	document.getElementById('CustSearchBox').style.top = document.getElementById('TaskBox').style.top;
}/**/

function TaskBoxClose()
{
	Modal.style.display = 'none';
	document.getElementById('TaskBox').style.display = 'none';
	document.getElementById('BoxSave').style.display = 'none';
	document.getElementById('BoxUpdate').style.dispaly = 'none';
	txtDate.value = '';
	txtJob.value = '';
	txtCust.value = '';
	selArea.selectedIndex = 0;
	selAttn.selectedIndex = 0;
	txtNotes.value = '';
/**/}
//-----------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////
function ShowActive()
{
	document.getElementById('ArchiveButton').style.display = 'block';
	document.getElementById('ActiveButton').style.display = 'none';
	LoadNotes(Order);	
}
function ShowArchive()
{
	document.getElementById('ArchiveButton').style.display = 'none';
	document.getElementById('ActiveButton').style.display = 'block';
	LoadNotes(Order);	
}//-----------------------------------------------------------------------

//------------------------------------------------------------------------
var NotesLoader;
function Resizer()
{
	document.getElementById('TaskLists').style.height = Math.abs(document.getElementById('RightContainer').offsetHeight-38);
	
	document.getElementById('Header').style.fontSize=document.getElementById('Header').offsetHeight*.8;
	
	LeftOverHeight = String(Math.abs(document.getElementById('TaskListBody').offsetHeight-document.getElementById('ItemsHead').offsetHeight-2));
	document.getElementById('TLItemsContainer').style.height = LeftOverHeight+'px';
	
	
	var LeftOverWidth = (document.body.offsetWidth-HeadEdit.offsetWidth-HeadDel.offsetWidth-HeadSch.offsetWidth-HeadArch.offsetWidth-HeadPri.offsetWidth-HeadDone.offsetWidth-HeadDate.offsetWidth-HeadArea.offsetWidth-HeadArea.offsetWidth-0);
	//alert((LeftOverWidth*.56)+'px');
	HeadJob.style.width = (LeftOverWidth*.56)+'px';
	HeadCust.style.width = String(Math.abs((LeftOverWidth*.36)-0))+'px';
	
//	alert(FakeItemRow.offsetWidth);
	//if(==0){return false;}
	var ItemRow = document.getElementById('FakeItemRow').offsetWidth;
	var wide = 72 + ((ItemsHead.offsetWidth - ItemRow)*1.333);
	HeadAttn.style.width = wide;
	
	
	var TheDivs = new Array;
	TheDivs = document.getElementsByTagName('div')
	
for(var i=1;i<TheDivs.length;i++)
	{
		if(TheDivs[i].id.replace('sizeCust','') != TheDivs[i].id)
		{
			//alert(Math.abs(parseInt(HeadCust.style.width)-10));
			TheDivs[i].style.width = String(Math.abs(parseInt(HeadCust.style.width)-20))+'px';
		}
		if(TheDivs[i].id.replace('sizeJob','') != TheDivs[i].id)
		{
			TheDivs[i].style.width = String(Math.abs(parseInt(HeadJob.style.width)-10))+'px';
		}
	}
	//alert('wait 30 sec.');
	if(NotesLoader>0)
	{	NotesLoader--;
		document.getElementById("OverAllContainerWhite").innerHTML += '.'
	}
	else
	{
		document.getElementById('OverAllContainerWhite').style.display = 'none';
	}
}
//////////////////////////////////////////////////////////







 




function LoadMainLists()
{ 
//AREA DROPDOWNS------------------------------------- 
	var AreaArray = parent.AreaArray;
	var AreaLen = parent.AreaArray.length; 
	 
	 selArea.length=null;
	 
	 var newOption = document.createElement("OPTION");
	 selArea.options.add(newOption);
	 newOption.value = 1;
	 newOption.innerText = '--';
	
	for (var y = 1; y < AreaLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   selArea.options.add(newOption);
	   newOption.value = AreaArray[y][1];
	   newOption.innerText = AreaArray[y][2];
	 }
//Attention DROPDOWN------------------------------------- 
	var EmpArray = parent.EmployeeArray;
	var EmpLen = parent.EmployeeArray.length;
	//alert(parent.EmployeeArray);
	
	selAttn.length=null;
	 
	   var newOption = document.createElement("OPTION");
	   selAttn.options.add(newOption);
	   newOption.value = 1;
	   newOption.innerText = '--';
	
	for (var y = 1; y < EmpLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   selAttn.options.add(newOption);
	   newOption.value = EmpArray[y][1];
	   newOption.innerText = EmpArray[y][2]+' '+EmpArray[y][3];
	 }
Resizer();
LoadNotes(Order);
}



//  Edits A Task//////////////////////////////////////////////////////////////////////////////
function EditTask(TestMaintID)
{
	txtJob.value = document.getElementById('sizeJob'+TestMaintID).innerHTML;
	txtDate.value = document.getElementById('Date'+TestMaintID).innerHTML;
	txtCust.value = document.getElementById('sizeCust'+TestMaintID).innerHTML;
	HiddenTestMaintID.value = TestMaintID;
	
	for(var i=0;i<selArea.length;i++)
	{
		if (selArea[i].innerText == document.getElementById('Area'+TestMaintID).innerHTML)
		{	selArea.selectedIndex = i;}
	}
	for(var i=0;i<selAttn.length;i++)
	{
		if (selAttn[i].innerText == document.getElementById('Attn'+TestMaintID).innerHTML)
		{	selAttn.selectedIndex = i;}
	}
	
	txtNotes.innerText = document.getElementById('HiddenNotes'+TestMaintID).value;

	var Job = document.getElementById('sizeJob'+TestMaintID).innerHTML;
	TaskBox('Edit: '+Job);
}
//--------------------------------------------------------------------------------------------


//Highlights the sort-by column
function HighlightOrder()
{
	HeadJob.style.color='#FFF';
	HeadJob.style.fontSize='12px';
	HeadCust.style.color='#FFF';
	HeadCust.style.fontSize='12px';
	HeadArea.style.color='#FFF';
	HeadArea.style.fontSize='12px';
	HeadAttn.style.color='#FFF';
	HeadAttn.style.fontSize='12px';
	HeadDate.style.color='#FFF';
	HeadDate.style.fontSize='12px';
	HeadPri.style.color='#FFF';
	HeadPri.style.fontSize='12px';
	
	switch(Order)
	{	case 'Job':
			document.getElementById('HeadJob').style.color='#00C';
			document.getElementById('HeadJob').style.fontSize='14px';
			break;
		case 'Priority':
			document.getElementById('HeadPri').style.color='#00C';
			document.getElementById('HeadPri').style.fontSize='14px';
			break;
		case 'Cust':
			document.getElementById('HeadCust').style.color='#00C';
			document.getElementById('HeadCust').style.fontSize='14px';
			break;
		case 'Area':
			document.getElementById('HeadArea').style.color='#00C';
			document.getElementById('HeadArea').style.fontSize='14px';
			break;
		case 'Attn':
			document.getElementById('HeadAttn').style.color='#00C';
			document.getElementById('HeadAttn').style.fontSize='14px';
			break;
		default:
			document.getElementById('HeadDate').style.color='#00C';
			document.getElementById('HeadDate').style.fontSize='14px';
			break;
	}
}


//Puts a task on the Calendar
function ToCal(TestMaintID)
{
	parent.ShowCalendar();
	var Target = parent.document.getElementById('CalendarIframe').contentWindow.document
	Target.getElementById('ModalScreen').style.display = 'inline';
	Target.getElementById('NewEventBox').style.display = 'inline';
	Target.getElementById('EventTitleText').value = document.getElementById('sizeJob'+TestMaintID).innerHTML;
	Target.getElementById('FromDateTxt').value = document.getElementById('Date'+TestMaintID).innerHTML;
	Target.getElementById('ToDateTxt').value = document.getElementById('Date'+TestMaintID).innerHTML;
	Target.getElementById('EventNewNotes').value = document.getElementById('Notes'+NoteID).innerHTML.replace('<b>','').replace('Notes:','').replace('</b>','');
	
	var AttnSel = Target.getElementById('AttnList');
	for(var i=1;i<=AttnSel.length-1;i++)
	{		
		//alert(i);
		if(AttnSel[i].innerText == document.getElementById('Attn'+TestMaintID).innerHTML)
		{
			AttnSel.selectedIndex = i;
			break;
		}
	}
	var TaskList = Target.getElementById('TaskList');
	for(var i=1;i<=TaskList.length-1;i++)
	{		
		//alert(i);
		if(TaskList[i].innerText != TaskList[i].innerText.replace('Test',''))
		{
			TaskList.selectedIndex = i;
			break;
		}
	}
	var AreaSel = Target.getElementById('AreaList');
	for(var i=1;i<=AttnSel.length-1;i++)
	{		
		//alert(i);
		if(AreaSel[i].innerText == document.getElementById('Area'+TestMaintID).innerHTML)
		{
			AreaSel.selectedIndex = i;
			break;
		}
	}
	
	
}



function GrabCust(CustName){CustSearchBox.style.display='none'; document.getElementById('txtCust').value = CustName; }


var OldMOColor = new Array
function MouseOver(This,NewColor){OldMOColor[This]=This.style.color; This.style.color=NewColor;}
function MouseOut(This){This.style.color=OldMOColor[This];}


function TextMouseOver(This){This.style.color= '#'+parent.ProgressArray[1][6]+'';}

function TextMouseOut(This){This.style.color='#'+parent.ProgressArray[1][7]+'';	}


//////Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function TaskListBkGndOn(ID){document.getElementById('Items'+ID+'').style.background = '#E6F3FB';}

function TaskListBkGndOff(ID){document.getElementById('Items'+ID+'').style.background ='#FFF';}
//----------------------------------------------------------------

//////Archive Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function ArchMOut(TheDiv){TheDiv.style.background='url(Images/Arrow20X25R.gif) no-repeat'}
function ArchMOver(TheDiv){TheDiv.style.background='url(Images/Arrow20X25R2.gif) no-repeat'}
function UnArchMOut(TheDiv){TheDiv.style.background='url(Images/Arrow20X25L.gif) no-repeat'}
function UnArchMOver(TheDiv){TheDiv.style.background='url(Images/Arrow20X25L2.gif) no-repeat'}

function ArchivedTaskListBkGndOn(ID){document.getElementById('ArchivedItems'+ID+'').style.background = '#E6F3FB';}

function ArchivedTaskListBkGndOff(ID){document.getElementById('ArchivedItems'+ID+'').style.background ='#FFF';}
//----------------------------------------------------------------

//////Archive button MouseOver BackGround///////////////////////////////////////////////////////////
function ArchiveButtonMouseOver(ID){document.getElementById('ArchiveButton'+ID+'').style.background = 'url(Images/Arrow20X25R2.gif)';}

function ArchiveButtonMouseOut(ID){document.getElementById('ArchiveButton'+ID+'').style.background ='url(Images/Arrow20X25R.gif)';}

//----------------------------------------------------------------------

//////Active Button MouseOver BackGround///////////////////////////////////////////////////////////
function ArchiveButtonMouseOver1(ID){document.getElementById('ArchivedArchiveButton'+ID+'').style.background = 'url(Images/Arrow20X25L2.gif)';}

function ArchiveButtonMouseOut1(ID){document.getElementById('ArchivedArchiveButton'+ID+'').style.background ='url(Images/Arrow20X25L.gif)';}

//----------------------------------------------------------------------

////////////////////////////////////
////////////////////////////////////
function NiftyAll()
{
	var AllDivs = document.getElementsByTagName("div");
	//alert(AllDivs.length);
	for (var i=0;i<AllDivs.length;i++)
	{
		if (AllDivs[i].id.replace('ItemRow','') != AllDivs[i].id)
		{	
			//alert(AllDivs[i].id);
			Nifty("div#"+AllDivs[i].id,"medium transparent bottom");
		}
	}
}
//___________________________________________
//


// Click Menus//////////////////////////////////////////////////////////////////////////////////////////////////////

var x,y;

if(!document.all){document.captureEvents(Event.MOUSEMOVE);}
document.onmousemove=getMousePos;


function getMousePos(e)
{
  if(document.all){x=event.x+document.body.scrollLeft;y=event.y+document.body.scrollTop;}
  else{x=e.pageX;y=e.pageY;}
}

function showProgressMenu(DivID,TestMaintID,ColumnID,X,Y)
{
	var MenuItems ='<div class="ProgressItemsHead">Progress</div>';  
  
	var pArray = parent.ProgressArray; //alert(pArray);
	for(var i = 1;i<=6;i++)
	//var i = 1
	{
		MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+TestMaintID+','+pArray[i][1]+',&#39;'+DivID+'&#39;,'
		MenuItems +='&#39;'+pArray[i][2]+'&#39;,&#39;'/*+pArray[i][4]*/+'&#39; ,&#39;'+ColumnID+'&#39;)">'
		MenuItems +='<div class="ProgressColor" style="background:#'+pArray[i][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
		MenuItems +='#'+pArray[i][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+pArray[i][2]+'&#39;">'
		//MenuItems +=''+pArray[i][4]
		MenuItems +='</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">'+pArray[i][5]+'</div></div>';	 
	}
	
	MenuItems +='<div class="ProgressItemsCancel"><button class="PICancelBtn" onClick="CloseProgressMenu();">Cancel</button></div>';
	Gebi('PhaseProgressMenu').innerHTML = MenuItems;
	
	Gebi('PhaseProgressMenu').style.top=y+'px';
	Gebi('PhaseProgressMenu').style.left=x+'px';
	var Offset=Gebi('PhaseProgressMenu').offsetHeight;
	var ListH=Gebi('TLItemsContainer');
	if(y+Offset>(ListH.offsetHeight+(ListH.offsetTop*1))){Gebi('PhaseProgressMenu').style.top=(y-Offset)+'px';}

	Gebi('PhaseProgressMenu').style.display="block";
}


function CloseProgressMenu()
{
  document.getElementById('PhaseProgressMenu').style.display = "none";
  return false;
}



function showPriMenu(DivID,TestMaintID)
{
	var menu = document.getElementById('PhasePriMenu').style;
	var MenuItems ='<div class="ProgressItemsHead">Priority</div>';  
  
	var prArray = new Array;
	var prArray = parent.PriorityArray; 
	//alert(DivID);
		for(var i = 1;i<=5;i++)
	//var i = 1
	{
		MenuItems +='<div class="ProgressItems" onclick="PriClick('+TestMaintID+','+prArray[i][1]+',&#39;'+DivID+'&#39;,'
		MenuItems +='&#39;'+prArray[i][2]+'&#39;,&#39;'+prArray[i][4]+'&#39;)">'
		MenuItems +='<div class="ProgressColor" style="background:#'+prArray[i][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
		MenuItems +='#'+prArray[i][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+prArray[i][2]+'&#39;">'
		MenuItems +=''+prArray[i][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">'+prArray[i][5]+'</div></div>';	 
	}
	
	MenuItems +='<div class="ProgressItemsCancel"><button class="PICancelBtn" onClick="ClosePriMenu();">Cancel</button></div>';
	document.getElementById('PhasePriMenu').innerHTML = MenuItems;
	
	menu.top=y;
	menu.left=x;
	menu.display="block";
	return false;
}
function ClosePriMenu()
{
  document.getElementById('PhasePriMenu').style.display = "none";
  return false;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function ShowEmployeeList(DivID,ID)
{	
    var menu = document.getElementById('EmployeeList').style;
  var MenuItems ='<select size= 4 onchange= "CloseEmployeeList(),UpdateEngineer(value,&#39;'+DivID+'&#39;,'+ID+')">'
			MenuItems +='<option value=1 >'+parent.EmployeeArray[1][2]+' '+parent.EmployeeArray[1][3]+'</option>'
			MenuItems +='<option value=2 >'+parent.EmployeeArray[2][2]+' '+parent.EmployeeArray[2][3]+'</option>'
			MenuItems +='<option value=3 >'+parent.EmployeeArray[3][2]+' '+parent.EmployeeArray[3][3]+'</option>'
			MenuItems +='<option value=4 >'+parent.EmployeeArray[4][2]+' '+parent.EmployeeArray[4][3]+'</option>'
			MenuItems +='<option value=5 >'+parent.EmployeeArray[5][2]+' '+parent.EmployeeArray[5][3]+'</option>'
			MenuItems +='<option value=6 >'+parent.EmployeeArray[6][2]+' '+parent.EmployeeArray[6][3]+'</option>'
			MenuItems +='<option value=7 >'+parent.EmployeeArray[7][2]+' '+parent.EmployeeArray[7][3]+'</option>'
			MenuItems +='<option value=8 >'+parent.EmployeeArray[8][2]+' '+parent.EmployeeArray[8][3]+'</option>'
			MenuItems +='<option value=9 >'+parent.EmployeeArray[9][2]+' '+parent.EmployeeArray[9][3]+'</option>'
			MenuItems +='<option value=10 >'+parent.EmployeeArray[10][2]+' '+parent.EmployeeArray[10][3]+'</option>'
			MenuItems +='<option value=11 >'+parent.EmployeeArray[11][2]+' '+parent.EmployeeArray[11][3]+'</option>'
			MenuItems +='<option value=12 >'+parent.EmployeeArray[12][2]+' '+parent.EmployeeArray[12][3]+'</option></select>';
	 
	
      document.getElementById('EmployeeList').innerHTML = MenuItems;
	
  menu.top=y;
  menu.left=x ;
  menu.display="block";
  return false;
}


function CloseEmployeeList()
{
  document.getElementById('EmployeeList').style.display = "none";
  return false;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function NewTask()
{
	
}



function ShowNotes(DivID,ID)
{
	var Notes = document.getElementById(''+DivID+'').innerHTML;
  	var menu = document.getElementById('EngineeringNotes').style;
			var MenuItems ='<div>Notes:</div>';   
				MenuItems +='<textarea name="EngineeringNoteBox" id="EngineeringNoteBox" rows="5" cols="20">'
				MenuItems +=''+Notes+'</textarea><br/>'
				MenuItems +='<button class="PICancelBtn" style="float:left;" onClick="UpdateEngineerNotes(&#39;'+DivID+'&#39;,'+ID+')">Save</button>'
				MenuItems +='<div id="SeperatorDiv" style="width:60px; float:left; background:clear;" ></div><button style="float:left;" class="PICancelBtn" onClick="CloseNotes()">Cancel</button>';
				
	document.getElementById('EngineeringNotes').innerHTML = MenuItems;

	
	
		menu.top=y;
		menu.left=x;
		menu.display="block";
		return false;
}

function CloseNotes()
{
  document.getElementById('EngineeringNotes').style.display = "none";
  return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function NotesPopUpBox(DivID)
{
	var Notes = document.getElementById(''+DivID+'').innerHTML;
  	var menu = document.getElementById('EngineeringNotesPopUp').style;
			var MenuItems ='<div id="EngineeringDetailedNoteBox"><div style=" left:0px; float:left; white-space:normal; color:#EAECEE; width:120px; background-color:black; ">Detailed Notes</div>'+Notes+'</div>'
				
				
	document.getElementById('EngineeringNotesPopUp').innerHTML = MenuItems;
  
  
  
			var	xx = event.clientX + document.body.scrollLeft +15;
			var	yy = event.clientY + document.body.scrollTop -10;	
				
		menu.top=yy;
		menu.left=xx;
		menu.display="block";
		return false;
}

function NotesPopUpBoxClose()
{
  document.getElementById('EngineeringNotesPopUp').style.display = "none";
  return false;
}



