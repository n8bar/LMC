// JavaScript Document

function LoadCommonData()
{
	var Emps=parent.EmployeeArray;
	var isLoggedIn='';
	
	var Opts='';
	var CrewOpts='<option id=attnEmp value="">Choose crew names:</option>';
	var AttnName;
	var AttnOpts='';
	var empName;
	for(i=1;i<Emps.length;i++)
	{
		if(Emps[i][4]=='True')
		{
			empName=Emps[i][2]+' '+Emps[i][3];
			isLoggedIn='';
			if(parent.accessEmpID==Emps[i][1]){isLoggedIn='Selected';}
			Opts+='<option value="'+Emps[i][1]+'" '+isLoggedIn+'>'+Emps[i][2]+' '+Emps[i][3]+'</option>';
			AttnName=Emps[i][5];
			if(AttnName==''){AttnName=Emps[i][2]+'FakeUser@tricomlv.com';}
			AttnName=AttnName.replace(/ /g,'');//Remove spaces
			//AttnName=empName+' &lt;'+AttnName+'&gt;';
			CrewOpts+='<option id="crewEmp'+Emps[i][1]+'" value="'+AttnName+'" title="'+AttnName+'">'+empName+'</option>';
			AttnOpts+='<option id="attnEmp'+Emps[i][1]+'" value="'+AttnName+'" '+isLoggedIn+' title="'+AttnName+'">'+Emps[i][2]+' '+Emps[i][3]+'</option>';
		}
	}
	Gebi('ToDoEmpList').innerHTML=Opts;
	Gebi('SchAttn').innerHTML=AttnOpts;
	Gebi('Crew').innerHTML=CrewOpts;
}

function MenuMouse(Obj,BgColor,TextColor)
{
	Obj.style.backgroundColor=BgColor;
	Obj.style.color=TextColor;
}

function UpdateParentMouse()
{
	parent.mX=mX+PGebi('JobsListFrame').offsetLeft;
	parent.mY=mY+PGebi('JobsListFrame').offsetTop;
	//PGebi('HeaderRight').innerHTML=parent.mX;
}

/*


function MouseOverTab(ID){Gebi(ID).style.color='#FF0'}
function MouseOutTab(ID){Gebi(ID).style.color='#FFF'}

function DeleteTextMouseOver(ID){Gebi(ID).style.color='#CC0099'}
function DeleteTextMouseOut(ID){Gebi(ID).style.color='#000'	}


function TextMouseOver(This){This.style.color= '#'+parent.ProgressArray[1][6]+'';}

function TextMouseOut(This){This.style.color='#'+parent.ProgressArray[1][7]+'';	}





////Generic Mouseover background/////////////////////////////////////////////////////////////
var OldColor = new Array
function mOver(ID,BColor)
{
	OldColor[ID.id]=Gebi(ID.id).style.backgroundColor
	Gebi(ID.id).style.backgroundColor = BColor;//'#E6F3FB';
}
function mOut(ID)
{
	Gebi(ID.id).style.backgroundColor = OldColor[ID.id];
}




//////Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function ListBkGndOn(ID){Gebi('ItemRow'+ID+'').style.background = '#E6F3FB';}

function ListBkGndOff(ID){Gebi('ItemRow'+ID+'').style.background ='#';}
//----------------------------------------------------------------

//////Archive Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function ArchivedJobListBkGndOn(ID){Gebi('ArchivedJobItems'+ID+'').style.background = '#E6F3FB';}

function ArchivedJobListBkGndOff(ID){Gebi('ArchivedJobItems'+ID+'').style.background ='#FFF';}
//----------------------------------------------------------------


//----------------------------------------------------------------------


// Show and hide Boxes/////////////////////////////////////////Show and hide Boxes/////////////////////////////////////////



function ShowJobsList()
{
	Gebi("Lists").style.display = 'block';
	Gebi("EstimateMain").style.display = 'none';

}

function ShowJobInfo()
{
	Gebi("EstimateMain").style.display = 'block';
	Gebi("Lists").style.display = 'none';

}
*/


function ChangeToArchive()
{
	Gebi("TestButton2").style.display = 'block';
	Gebi("TestButton1").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('JobsListFrame').src=Gebi('JobsListFrame').src.replace('Active=True','Active=False');
	Active='False';
}

function ChangeToActive()
{
	Gebi("TestButton2").style.display = 'none';
	Gebi("TestButton1").style.display = 'block';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('JobsListFrame').src=Gebi('JobsListFrame').src.replace('Active=False','Active=True');
	Active='True';
}

function SortBy(NewSortBy)
{
	var URL='JobsList.asp?TaskType='+TaskType+'&Active='+Active+'&SortBy='+NewSortBy;
	Gebi('JobsListFrame').src=URL
	SortedBy=NewSortBy;
	
}


/*
function ChangeToInfo(LoopNum)
{	
		
	Gebi("InfoTab"+LoopNum).style.background = '#FF7900';
	Gebi("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("NotesTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("DocsTab"+LoopNum).style.background = '#FFD1A8';
	
	Gebi("InfoTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	Gebi("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';
	
	Gebi("JobInfoBoxBody"+LoopNum).style.display = 'block';
	Gebi("JobContactsBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobNotesBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobToDoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobBOMBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobDocsBoxBody"+LoopNum).style.display = 'none';

}

 
function ChangeToContacts(LoopNum)
{
	Gebi("InfoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ContactsTab"+LoopNum).style.background = '#FF7900';	
	Gebi("NotesTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("DocsTab"+LoopNum).style.background = '#FFD1A8';
			
	Gebi("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ContactsTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	Gebi("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';
	
	Gebi("JobInfoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobContactsBoxBody"+LoopNum).style.display = 'block';
	Gebi("JobNotesBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobToDoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobBOMBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobDocsBoxBody"+LoopNum).style.display = 'none';

}

function ChangeToNotes(LoopNum)
{
	Gebi("InfoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ContactsTab"+LoopNum).style.background = '#FFD1A8';	
	Gebi("NotesTab"+LoopNum).style.background = '#FF7900';
	Gebi("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("DocsTab"+LoopNum).style.background = '#FFD1A8';
		
	Gebi("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("NotesTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	Gebi("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';

	Gebi("JobInfoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobContactsBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobNotesBoxBody"+LoopNum).style.display = 'block';
	Gebi("JobToDoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobBOMBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobDocsBoxBody"+LoopNum).style.display = 'none';

}


function ChangeToToDo(LoopNum)
{
	Gebi("InfoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("NotesTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ToDoTab"+LoopNum).style.background = '#FF7900';
	Gebi("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("DocsTab"+LoopNum).style.background = '#FFD1A8';
	
	Gebi("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ToDoTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	Gebi("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';

	Gebi("JobInfoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobContactsBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobNotesBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobToDoBoxBody"+LoopNum).style.display = 'block';
	Gebi("JobBOMBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobDocsBoxBody"+LoopNum).style.display = 'none';
	
}


function ChangeToBOM(LoopNum)
{
	Gebi("InfoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("NotesTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("BillOfMaterialsTab"+LoopNum).style.background = '#FF7900';
	Gebi("DocsTab"+LoopNum).style.background = '#FFD1A8';
	
	Gebi("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	Gebi("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';

	Gebi("JobInfoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobContactsBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobNotesBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobToDoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobBOMBoxBody"+LoopNum).style.display = 'block';
	Gebi("JobDocsBoxBody"+LoopNum).style.display = 'none';
	
}

function ChangeToDocs(LoopNum)
{
	
	Gebi("InfoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("NotesTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	Gebi("DocsTab"+LoopNum).style.background = '#FF7900';
	
	Gebi("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	Gebi("DocsTab"+LoopNum).style.borderBottom = '1px solid #FF7900';

	Gebi("JobInfoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobContactsBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobNotesBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobToDoBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobBOMBoxBody"+LoopNum).style.display = 'none';
	Gebi("JobDocsBoxBody"+LoopNum).style.display = 'block';

}











//Right Click Menu//////////////////////////////////////////////////////////////////////////////////////////////////////

var x,y;

if(!document.all){document.captureEvents(Event.MOUSEMOVE);}
document.onmousemove=getMousePos;

function getMousePos(e)
{
  if(document.all){x=event.x+document.body.scrollLeft;y=event.y+document.body.scrollTop;}
  else{x=e.pageX;y=e.pageY;}
}

function showMenu(obj,ID)
{
  var menu = Gebi('menu').style;
  
  var Menu1 ='<div onMouseOver="this.style.backgroundColor=&#39;#D8E0E9&#39;" onMouseOut="this.style.backgroundColor=&#39;#F3F3F3&#39;"';
      Menu1 +='class="RclickMenuItems" onClick="alert('+ID+');">Open</div>';
  var Menu2 ='<div onMouseOver="this.style.backgroundColor=&#39;#D8E0E9&#39;" onMouseOut="this.style.backgroundColor=&#39;#F3F3F3&#39;"';
      Menu2 +='class="RclickMenuItems" onClick="alert('+ID+');">Copy</div>';
  var Menu3 ='<div onMouseOver="this.style.backgroundColor=&#39;#D8E0E9&#39;" onMouseOut="this.style.backgroundColor=&#39;#F3F3F3&#39;"';
      Menu3 +='class="RclickMenuItems" onClick="alert('+ID+');">Delete</div>';
  Gebi('MenuItem1').innerHTML = Menu1;
  Gebi('MenuItem2').innerHTML = Menu2;
  Gebi('MenuItem3').innerHTML = Menu3;
    
  menu.top=y;
  menu.left=x;
  menu.display="inline";
  return false;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









// Click Menus//////////////////////////////////////////////////////////////////////////////////////////////////////
*/
var x,y;

if(!document.all){document.captureEvents(Event.MOUSEMOVE);}
document.onmousemove=getMousePos;



function getMousePos(e)
{
	try
	{
		if(document.all)
		{
			x=event.x+document.body.scrollLeft;
			y=event.y+document.body.scrollTop;
		}
		else{x=e.pageX;y=e.pageY;}
	}
	catch(e)
	{}
}


/*

function showProgressMenu(DivID,NoteID,ColumnID,TableName,SystemID)
{
	var Progarr=parent.ProgressArray;
	x1 = event.clientX + document.body.scrollLeft +5;
	y1 = event.clientY + document.body.scrollTop +5;
	
	//alert(SystemID)
	//var TableName = "Jobs"
   var menu = Gebi('PhaseProgressMenu').style;
   var MenuItems ='<div class="ProgressItemsHead">Progress</div>';  
     
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+NoteID+','+Progarr[1][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[1][2]+'\',\''+Progarr[1][4]+'\' ,\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[1][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[1][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[1][2]+'\'">'
	MenuItems +=''+Progarr[1][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">'+Progarr[1][5]+'</div></div>';	 
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+NoteID+','+Progarr[2][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[2][2]+'\',\''+Progarr[2][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[2][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[2][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[2][2]+'\'">'
	MenuItems +=''+Progarr[2][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[2][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+NoteID+','+Progarr[3][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[3][2]+'\',\''+Progarr[3][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[3][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[3][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[3][2]+'\'">'
	MenuItems +=''+Progarr[3][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[3][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+NoteID+','+Progarr[4][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[4][2]+'\',\''+Progarr[4][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[4][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[4][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[4][2]+'\'">'
	MenuItems +=''+Progarr[4][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[4][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+NoteID+','+Progarr[5][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[5][2]+'\',\''+Progarr[5][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[5][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[5][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[5][2]+'\'">'
	MenuItems +=''+Progarr[5][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[5][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+NoteID+','+Progarr[6][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[6][2]+'\',\''+Progarr[6][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[6][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[6][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[6][2]+'\'">'
	MenuItems +=''+Progarr[6][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[6][5]+'</div></div>';
	MenuItems +='<div class="ProgressItemsCancel"><button class="PICancelBtn" onClick="CloseProgressMenu();">Cancel</button></div>';
	
	Gebi('PhaseProgressMenu').innerHTML = MenuItems;
	
	var MenuH=Gebi('PhaseProgressMenu').offsetHeight;
	var MenuW=Gebi('PhaseProgressMenu').offsetWidth;
	
	//alert(x1+','+y1);
	if(y1>document.body.offsetHeight-MenuH)
	{y1=y1-MenuH-24;}
	if(x1>document.body.offsetWidth-MenuW)
	{x1-=MenuW-24;}
  menu.top=y1;
  menu.left=x1;
  menu.display="block";
  //return false;
}


function CloseProgressMenu()
{
  try{Gebi('PhaseProgressMenu').style.display = "none";}
	catch(e){return false}
	
  return true;
}

//-------------------------------------------------------------------------------------------------------------------------------,UpdateEngineer(value,&#39;'+DivID+'&#39;,'+ID+)-



function ShowEmployeeList(DivID,ID,LoopNum)
{	
	x1 = event.clientX + document.body.scrollLeft +5;
	y1 = event.clientY + document.body.scrollTop +5;


    var menu = Gebi('EmployeeList').style;
  var MenuItems ='<select size= 7 class="EmployeeListInside" onchange= "CloseEmployeeList(),UpdateJobsManager(value,&#39;'+DivID+'&#39;,'+ID+')">'
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
			MenuItems +='<option value=12 >'+parent.EmployeeArray[12][2]+' '+parent.EmployeeArray[12][3]+'</option>'
			MenuItems +='<option value=13 >'+parent.EmployeeArray[13][2]+' '+parent.EmployeeArray[13][3]+'</option>'
			MenuItems +='<option value=14 >'+parent.EmployeeArray[14][2]+' '+parent.EmployeeArray[14][3]+'</option>'
			MenuItems +='<option value=15 >'+parent.EmployeeArray[15][2]+' '+parent.EmployeeArray[15][3]+'</option>'
			MenuItems +='<option value=16 >'+parent.EmployeeArray[16][2]+' '+parent.EmployeeArray[16][3]+'</option></select>';
	 
	
      Gebi('EmployeeList').innerHTML = MenuItems;
	
  menu.top=y1;
  menu.left=x1 ;
  menu.display="block";
  return false;
}


function CloseEmployeeList()
{
	try{Gebi('EmployeeList').style.display = "none";}
	catch(e){return false;}
	return true
}




///Expanding Job Info Box//////////////////////////////////////////////////////////////////////////////////////////////////


var InfoIDLast;
InfoIDLast = '';
BackgroundIDLast = '';
var Switch = 0;



function ExpandingInfo(InfoID,BackgroundID)
{ 


	if (Switch == 0 || InfoIDLast != InfoID)
	{
		if(InfoIDLast != '')
			{
				Gebi(InfoIDLast).style.display = 'none';
				Gebi(BackgroundIDLast).style.background ='url(Images/BookClosed.gif)';	
			}
		Gebi(InfoID).style.display = 'block';
		Gebi(BackgroundID).style.background ='url(Images/BookOpen.gif)';
		Switch = 1;
	}
	else
	{
		if(InfoIDLast != '')
			{
				Gebi(InfoIDLast).style.display = 'none';
				Gebi(BackgroundIDLast).style.background ='url(Images/BookClosed.gif)';
			}
		Gebi(InfoID).style.display = 'none';
		Gebi(BackgroundID).style.background ='url(Images/BookClosed.gif)';
		Switch = 0;
	}

	
	
	
	InfoIDLast = InfoID;
	BackgroundIDLast = BackgroundID;
}

*/

var SelectedRow=0;
var SelectedRowBGColor='#fff';
function SelectRow(RowNum)
{
	if(SelectedRow==RowNum){return false}
	
	if(SelectedRow!=0)
	{
		Gebi('RowContainer'+SelectedRow).style.backgroundColor=SelectedRowBGColor;
		Gebi('RowContainer'+SelectedRow).style.color='#000';
	}
	
	SelectedRow=RowNum;
	
	if(Gebi('RowContainer'+RowNum)){}
	else{return false;}
	
	SelectedRowBGColor=Gebi('RowContainer'+RowNum).style.backgroundColor;
	SelectedItemName='';//Gebi('')
	
	//Gebi('RowContainer'+RowNum).style.background='#3399FF';
	//Gebi('RowContainer'+RowNum).style.color='#FFF';
	
	SelectTreeItem(Gebi('JobName'+RowNum));
}


var SelectedItem;
var SelectedItemType='ItemJob1';
var SelectedItemColor='#000';
var SelectedItemFontWeight='bold';
var SelectedItemBGColor='#FFF';
function SelectTreeItem(ThisItem)
{
	try{
		SelectedItem.style.backgroundColor=SelectedItemBGColor;
		SelectedItem.style.color=SelectedItemColor;
		SelectedItem.style.fontWeight=SelectedItemFontWeight;
	}catch(e){}
	
	if(SelectedRow!=0)
	{
		if(SelectedItemType.replace('ItemJob','')==SelectedItemType)
		{}
		else
		{
			Gebi('RowContainer'+SelectedRow).style.backgroundColor=SelectedRowBGColor;
			Gebi('RowContainer'+SelectedRow).style.color='#000';
		}
	}
	
	SelectedItemBGColor=ThisItem.parentNode.style.backgroundColor;
	SelectedItemColor=ThisItem.style.color;
	SelectedItemFontWeight=ThisItem.style.fontWeight;
	SelectedItem=ThisItem;
	
	ThisItem.style.backgroundColor='#00F';
	ThisItem.style.fontWeight='bold';
	ThisItem.style.color='#FF0';
	
	PGebi('JobListControl').style.display='none';
	PGebi('ItemListControl').style.display='none';
	PGebi('ListItemControl').style.display='none';
	PGebi('ItemNotesText').disabled=false;
	PGebi('ItemNotesText').value='';
	PGebi('btnRemove').disabled=false;
	PGebi('RemItemName').innerHTML='';
	PGebi('txtRename').disabled=false;
	
	//alert(ThisItem.parentNode.id.split('.')[0]+', '+'ItemJob'+SelectedRow);
	
	SelectedItemType=ThisItem.parentNode.id.split('.')[0]
	
	PGebi('ItemNotesHead').innerHTML=ThisItem.innerHTML;
	
	if(SelectedItemType=='ItemJob'+SelectedRow)
	{
		PGebi('JobRenamer').disabled=false;
		PGebi('JobRenamer').value=SelectedItem.innerHTML;
		PGebi('ItemNotesText').disabled=false;
		PGebi('ItemNotesText').value=CharsDecode(Gebi('Notes'+SelectedRow).value);
		PGebi('btnRemove').disabled=true;
		PGebi('JobListControl').style.display='block';
		PGebi('txtRename').disabled=true;
		PGebi('txtRename').value='';
	}
	else
	{
		PGebi('JobRenamer').value='';
		PGebi('JobRenamer').disabled=true;
		PGebi('ItemNotesText').value=CharsDecode(Gebi(SelectedItem.id.replace(SelectedItem.id.split('.')[0],'Notes')).value);
		PGebi('RemItemName').innerHTML=SelectedItem.innerHTML;
		PGebi('txtRename').value=SelectedItem.innerHTML;
		
		if(SelectedItemType=='ItemEmp')
		{
			PGebi('lblItemListAdd').innerHTML='New Task For '+SelectedItem.innerHTML;
			PGebi('ItemListControl').style.display='block';
		}
		
		if(SelectedItemType=='ItemList')
		{
			PGebi('lblListItemAdd').innerHTML='New Task For '+SelectedItem.innerHTML;
			PGebi('ListItemControl').style.display='block';
		}
	}
}


function SelectTreeItemByIdLevel4(ID)
{
	var AllInputs=document.getElementsByTagName('input');
	
	for(a=1;a<AllInputs.length;a++)
	{
		if(AllInputs[a].id.replace('TreeListID','')!=AllInputs[a].id)
		{
			if(AllInputs[a].value==ID)
			{
				var RowNum=AllInputs[a].id.split('.')[2];
				SelectRow(RowNum);
				
				var Item=Gebi(AllInputs[a].id.replace('ItemName',''));
				
				var PMDivID=Item.parentNode.parentNode.parentNode.id.replace('ItemEmp.2','PlusMinus.1');
				PMDA=PMDivID.split('.');
				PMDivID=PMDA[0]+'.'+PMDA[1]+'.'+PMDA[2]+'.'+PMDA[4];

				PlusMinusToggle(Gebi(PMDivID), RowNum);
				
				PMDivID=Item.parentNode.parentNode.parentNode.id.replace('ItemEmp','PlusMinus')+'.0';
				PlusMinusToggle(Gebi(PMDivID), RowNum);
				
				PMDivID=Item.parentNode.parentNode.id.replace('ItemList','PlusMinus');
				PlusMinusToggle(Gebi(PMDivID), RowNum)
				
				SelectTreeItem(Item);
				return true;
			}
		}
	}
	
	alert('TreeListID: '+ID+' was not found.');
}

function SelectTreeItemByIdLevel3(ID)
{
	var AllInputs=document.getElementsByTagName('input');
	
	for(a=1;a<AllInputs.length;a++)
	{
		if(AllInputs[a].id.replace('TreeListID','')!=AllInputs[a].id)
		{
			if(AllInputs[a].value==ID)
			{
				var RowNum=AllInputs[a].id.split('.')[2];
				SelectRow(RowNum);
				
				var Item=Gebi(AllInputs[a].id.replace('ItemName',''));
				
				var PMDivID=Item.parentNode.parentNode.id.replace('ItemEmp.2','PlusMinus.1');
				PMDA=PMDivID.split('.');
				PMDivID=PMDA[0]+'.'+PMDA[1]+'.'+PMDA[2]+'.'+PMDA[4];

				PlusMinusToggle(Gebi(PMDivID), RowNum);
				
				PMDivID=Item.parentNode.parentNode.id.replace('ItemEmp','PlusMinus')+'.0';
				PlusMinusToggle(Gebi(PMDivID), RowNum);
				
				SelectTreeItem(Item);
				return true;
			}
		}
	}
	
	alert('TreeListID: '+ID+' was not found.');
}



function SelectTreeItemByIdLevel2(ID)
{
	var AllInputs=document.getElementsByTagName('input');
	
	for(a=1;a<AllInputs.length;a++)
	{
		if(AllInputs[a].id.replace('TreeListID','')!=AllInputs[a].id)
		{
			if(AllInputs[a].value==ID)
			{
				var RowNum=AllInputs[a].id.split('.')[2];
				SelectRow(RowNum);
				
				var Item=Gebi(AllInputs[a].id.replace('ItemName',''));
				
				var PMDivID=Item.parentNode.id.replace('ItemEmp.2','PlusMinus.1');
				PMDA=PMDivID.split('.');
				PMDivID=PMDA[0]+'.'+PMDA[1]+'.'+PMDA[2]+'.'+PMDA[4];

				PlusMinusToggle(Gebi(PMDivID), RowNum);
				
				setTimeout('SelectTreeItem(Gebi(\''+Item.id+'\'))',500);

				return true;
			}
		}
	}
	
	alert('TreeListID: '+ID+' was not found.');
}




function PlusMinusToggle(PlusMinusDiv, RowNum)
{
	if(!PlusMinusDiv)
	{
		alert('PlusMinusErr');
		return false;
	}
	if(PlusMinusDiv.style.background=='none'){return false;}

	var PMIndex=PlusMinusDiv.id.split('.');
	
	//alert(PMIndex);
	
	if(PlusMinusDiv.style.background==Gebi('Minus').style.background){
		PlusMinusDiv.style.background=Gebi('Plus').style.background;
		if(PMIndex[3]==0){Gebi('RowContainer'+RowNum).style.height='25px';}
		else{PlusMinusDiv.parentNode.style.height='25px';}
	}
	else
	{
		PlusMinusDiv.parentNode.style.height='auto';
		PlusMinusDiv.style.background=Gebi('Minus').style.background;
		if(PMIndex[3]==0){Gebi('RowContainer'+RowNum).style.height='auto'; }
		else{}
	}
}
function ShowPriMenu(PriObj)
{
	var Menu=Gebi('PriorityMenu');
	
	var MenuX=PriObj.offsetLeft+7;
	var MenuY=PriObj.offsetTop+6;
	
	Menu.style.left=MenuX+'px';
	Menu.style.top=MenuY+'px';
	Menu.style.display='block';
	/*
	while((MenuY+16)+Menu.offsetHeight>document.body.offsetHeight)
	{
		Menu.style.top=(Menu.offsetTop-3)+'px';
	}
	*/
}

function ShowProgMenu(ProgObj)
{
	var Menu=Gebi('ProgressMenu');
	
	var MenuX=ProgObj.offsetLeft+7;
	var MenuY=ProgObj.offsetTop+6;
	
	Menu.style.left=MenuX+'px';
	Menu.style.top=MenuY+'px';
	Menu.style.display='block';
	
	/*
	while((MenuY+16)+Menu.offsetHeight>document.body.offsetHeight)
	{
		Menu.style.top=(Menu.offsetTop-3)+'px';
	}
	ProgressCol=ProgCol;
	*/
}


var TaskOrderByType=new Array;

TaskOrderByType[1]=1//'General';
TaskOrderByType[2]=6//'Service';
TaskOrderByType[3]=7//'Test';

function ToCal(NoteID)
{
	parent.ShowCalendar();
	var Target = parent.parent.Gebi('CalendarIframe').contentWindow
	Target.Gebi('ModalScreen').style.display = 'block';
	Target.Gebi('ModalScreen').style.visibility = 'visible';
	Target.Gebi('NewEventBox').style.display = 'inline';
	Target.Gebi('EventTopL').style.backgroundColor='#3599E3';
	Target.Gebi('EventTopR').style.backgroundColor='#3599E3';
	Target.Gebi('EventHeaderTxt').innerHTML='Create An Event';
	Target.ShowEventModal('Month',1,Gebi('ItemDateStarted'+SelectedRow).value,'NewEvent');
	Target.Gebi('EventTitleText').value = Gebi('JobName'+SelectedRow).innerHTML;
	Target.Gebi('FromDateTxt').value = Gebi('ItemDateStarted'+SelectedRow).value;
	Target.Gebi('ToDateTxt').value = Gebi('ItemDateDue'+SelectedRow).value;
	Target.Gebi('EventNewNotes').value = PGebi('ItemNotesText').value;
	
	var AttnSel = Target.Gebi('AttnList');
	for(var i=1;i<=AttnSel.length-1;i++)
	{		
		if(AttnSel[i].innerText == SelI('SelAttn'+SelectedRow).innerHTML)		{AttnSel.selectedIndex = i;}
	}
	var TaskList = Target.Gebi('TaskList');

	//TaskList.selectedIndex=TaskOrderByType[parent.TaskType]
	
	for(t=0;t<TaskList.length;t++)
	{
		if(TaskList[t].value==TaskType)
		{
			TaskList.selectedIndex=t;
			break;
		}
	}
	
}


function CustSearch(CustDiv,LeftAdd,TopAdd)
{
	if(!LeftAdd){LeftAdd=0;}
	if(!TopAdd){TopAdd=0;}
	
	Gebi('CSearchBox').style.display='block';
	Gebi('CSearchBox').style.top=(CustDiv.offsetTop-1+CustDiv.offsetHeight)+'px';
	Gebi('CSearchBox').style.left=(CustDiv.offsetLeft-1)+'px';
	Gebi('CSearchBox').style.width=(CustDiv.offsetWidth-1)+'px'; 
	
	LoadCustList(CustDiv);
}





function Schedule(ProjID,ProjName,From,To,Attn,Location)
{
	var today=new Date;
	if(!isDate(From)){From=(today.getMonth()+1)+'/'+today.getDate()+'/'+today.getFullYear()}
	if(!isDate(To)){To=From}
	
	Gebi('SchProjID').innerHTML=ProjID;
	Gebi('SchProjName').innerHTML=ProjName;
	Gebi('Modal').style.display='block'; 
	Gebi('ScheduleBox').style.display='block';
	
	Gebi('SchDateFrom').value=From;
	Gebi('SchDateTo').value=To;
	
	if(!!Attn)
	{
		for(a=0;a<Gebi('SchAttn').length;a++)
		{
			if(Gebi('SchAttn')[a].value==Attn) Gebi('SchAttn').selectedIndex=a;
		}
	}
	
	if(!!Location) Gebi('SchLoc').value=Location;
	
	//if(!!Recurrence)...
}
function ScheduleEvent()
{
	var schedProjName=Gebi('SchProjName').innerHTML;
	var schedD8From=Gebi('SchDateFrom').value;
	var schedD8To=Gebi('SchDateTo').value;
	var schedProjID=Gebi('SchProjID').innerHTML;
	var schedAttention=SelI('SchAttn').value;
	var schedLocation=Gebi('SchLoc').value;
	var schedCrew=Gebi('CrewList').value;
	var schedNotes=Gebi('NotesText').value;
	var schedPhase=SelI('SchPhase').innerHTML;
	
	
	//alert(schedNotes);
	parent.ToCal(schedProjName,schedD8From,schedD8To,calFeed,schedProjID,schedPhase,schedAttention,schedLocation,schedCrew,schedNotes);
	
	Gebi('ScheduleBox').style.display='none';		Gebi('Modal').style.display='none';
}




var alignmentInterval;
function Resize()
{
	//alignColumns();
	//alignmentInterval=setInterval('alignColumns();',500);
	
	var H= Math.abs(document.body.offsetHeight-0);
	Gebi('OverAllContainer').style.height =H +'px';
	Gebi('RightContainer').style.height=H +'px';
	Gebi('ListBody').style.height = Math.abs(Gebi('Lists').offsetHeight-Gebi('SearchSort').offsetHeight-96)+'px';
	Gebi('TLItemsContainer').style.height=(Gebi('ListBody').offsetHeight-0)+'px';
	var FrameH=Gebi('TLItemsContainer').offsetHeight-14;
	try{Gebi('JobsListFrame').style.height=FrameH+'px';}
	catch(e){Gebi('JobsListFrame').height=FrameH+'px';}
	Gebi('ItemNotesContainer').style.height=Math.abs(Gebi('ListBody').offsetHeight-28)+'px';
	//alert(RightContainer.offsetHeight+'  '+OverAllContainer.offsetHeight);

	//Gebi('JobsListFrame').contentWindow.reload;
	/*
	var AllDivs=document.body.getElementsByTagName('div');
	for(d=1;d<AllDivs.length;d++)
	{
		AllDivs[d].draggable=true;
	}
	*/
	
}


function ListResize()
{
	var Divs=document.getElementsByTagName('div');
	var RowNum=0;
	for(d=0;d<Divs.length;d++)
	{
		if( Divs[d].id.indexOf('RowContainer')!=-1)
		{
			RowNum++;
			Gebi('RowContainer'+RowNum).style.width=PGebi('ItemsHead').offsetWidth+'px';
		}
	}
}