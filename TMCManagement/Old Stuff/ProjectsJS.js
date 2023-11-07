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
	//Gebi('').innerHTML=Opts;
	//Gebi('').innerHTML=Opts;
}

function MenuMouse(Obj,BgColor,TextColor)
{
	Obj.style.backgroundColor=BgColor;
	Obj.style.color=TextColor;
}

function UpdateParentMouse()
{
	parent.mX=mX+PGebi('ProjListFrame').offsetLeft;
	parent.mY=mY+PGebi('ProjListFrame').offsetTop;
	//PGebi('HeaderRight').innerHTML=parent.mX;
}

/*


function MouseOverTab(ID){document.getElementById(ID).style.color='#FF0'}
function MouseOutTab(ID){document.getElementById(ID).style.color='#FFF'}

function DeleteTextMouseOver(ID){document.getElementById(ID).style.color='#CC0099'}
function DeleteTextMouseOut(ID){document.getElementById(ID).style.color='#000'	}


function TextMouseOver(This){This.style.color= '#'+parent.ProgressArray[1][6]+'';}

function TextMouseOut(This){This.style.color='#'+parent.ProgressArray[1][7]+'';	}





////Generic Mouseover background/////////////////////////////////////////////////////////////
var OldColor = new Array
function mOver(ID,BColor)
{
	OldColor[ID.id]=document.getElementById(ID.id).style.backgroundColor
	document.getElementById(ID.id).style.backgroundColor = BColor;//'#E6F3FB';
}
function mOut(ID)
{
	document.getElementById(ID.id).style.backgroundColor = OldColor[ID.id];
}




//////Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function ListBkGndOn(ID){document.getElementById('ItemRow'+ID+'').style.background = '#E6F3FB';}

function ListBkGndOff(ID){document.getElementById('ItemRow'+ID+'').style.background ='#';}
//----------------------------------------------------------------

//////Archive Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function ArchivedProjectListBkGndOn(ID){document.getElementById('ArchivedProjectItems'+ID+'').style.background = '#E6F3FB';}

function ArchivedProjectListBkGndOff(ID){document.getElementById('ArchivedProjectItems'+ID+'').style.background ='#FFF';}
//----------------------------------------------------------------


//----------------------------------------------------------------------


// Show and hide Boxes/////////////////////////////////////////Show and hide Boxes/////////////////////////////////////////



function ShowProjList()
{
	document.getElementById("Lists").style.display = 'block';
	document.getElementById("EstimateMain").style.display = 'none';

}

function ShowProjectInfo()
{
	document.getElementById("EstimateMain").style.display = 'block';
	document.getElementById("Lists").style.display = 'none';

}
*/


function ChangeToArchive()
{
	document.getElementById("TestButton2").style.display = 'block';
	document.getElementById("TestButton1").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ProjListFrame').src=Gebi('ProjListFrame').src.replace('Active=True','Active=False');
	Active='False';
}

function ChangeToActive()
{
	document.getElementById("TestButton2").style.display = 'none';
	document.getElementById("TestButton1").style.display = 'block';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ProjListFrame').src=Gebi('ProjListFrame').src.replace('Active=False','Active=True');
	Active='True';
}

function SortBy(NewSortBy)
{
	Gebi('ProjListFrame').src='ProjList.asp?Active='+Active+'&SortBy='+NewSortBy;
	SortedBy=NewSortBy;
	
}


/*
function ChangeToInfo(LoopNum)
{	
		
	document.getElementById("InfoTab"+LoopNum).style.background = '#FF7900';
	document.getElementById("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("NotesTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("DocsTab"+LoopNum).style.background = '#FFD1A8';
	
	document.getElementById("InfoTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	document.getElementById("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';
	
	document.getElementById("ProjectInfoBoxBody"+LoopNum).style.display = 'block';
	document.getElementById("ProjectContactsBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectNotesBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectToDoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectBOMBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectDocsBoxBody"+LoopNum).style.display = 'none';

}

 
function ChangeToContacts(LoopNum)
{
	document.getElementById("InfoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ContactsTab"+LoopNum).style.background = '#FF7900';	
	document.getElementById("NotesTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("DocsTab"+LoopNum).style.background = '#FFD1A8';
			
	document.getElementById("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ContactsTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	document.getElementById("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';
	
	document.getElementById("ProjectInfoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectContactsBoxBody"+LoopNum).style.display = 'block';
	document.getElementById("ProjectNotesBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectToDoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectBOMBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectDocsBoxBody"+LoopNum).style.display = 'none';

}

function ChangeToNotes(LoopNum)
{
	document.getElementById("InfoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ContactsTab"+LoopNum).style.background = '#FFD1A8';	
	document.getElementById("NotesTab"+LoopNum).style.background = '#FF7900';
	document.getElementById("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("DocsTab"+LoopNum).style.background = '#FFD1A8';
		
	document.getElementById("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("NotesTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	document.getElementById("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';

	document.getElementById("ProjectInfoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectContactsBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectNotesBoxBody"+LoopNum).style.display = 'block';
	document.getElementById("ProjectToDoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectBOMBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectDocsBoxBody"+LoopNum).style.display = 'none';

}


function ChangeToToDo(LoopNum)
{
	document.getElementById("InfoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("NotesTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ToDoTab"+LoopNum).style.background = '#FF7900';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("DocsTab"+LoopNum).style.background = '#FFD1A8';
	
	document.getElementById("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ToDoTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';

	document.getElementById("ProjectInfoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectContactsBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectNotesBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectToDoBoxBody"+LoopNum).style.display = 'block';
	document.getElementById("ProjectBOMBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectDocsBoxBody"+LoopNum).style.display = 'none';
	
}


function ChangeToBOM(LoopNum)
{
	document.getElementById("InfoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("NotesTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.background = '#FF7900';
	document.getElementById("DocsTab"+LoopNum).style.background = '#FFD1A8';
	
	document.getElementById("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #FF7900';
	document.getElementById("DocsTab"+LoopNum).style.borderBottom = '1px solid #000';

	document.getElementById("ProjectInfoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectContactsBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectNotesBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectToDoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectBOMBoxBody"+LoopNum).style.display = 'block';
	document.getElementById("ProjectDocsBoxBody"+LoopNum).style.display = 'none';
	
}

function ChangeToDocs(LoopNum)
{
	
	document.getElementById("InfoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ContactsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("NotesTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("ToDoTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.background = '#FFD1A8';
	document.getElementById("DocsTab"+LoopNum).style.background = '#FF7900';
	
	document.getElementById("InfoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ContactsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("NotesTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("ToDoTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("BillOfMaterialsTab"+LoopNum).style.borderBottom = '1px solid #000';
	document.getElementById("DocsTab"+LoopNum).style.borderBottom = '1px solid #FF7900';

	document.getElementById("ProjectInfoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectContactsBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectNotesBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectToDoBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectBOMBoxBody"+LoopNum).style.display = 'none';
	document.getElementById("ProjectDocsBoxBody"+LoopNum).style.display = 'block';

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
  var menu = document.getElementById('menu').style;
  
  var Menu1 ='<div onMouseOver="this.style.backgroundColor=&#39;#D8E0E9&#39;" onMouseOut="this.style.backgroundColor=&#39;#F3F3F3&#39;"';
      Menu1 +='class="RclickMenuItems" onClick="alert('+ID+');">Open</div>';
  var Menu2 ='<div onMouseOver="this.style.backgroundColor=&#39;#D8E0E9&#39;" onMouseOut="this.style.backgroundColor=&#39;#F3F3F3&#39;"';
      Menu2 +='class="RclickMenuItems" onClick="alert('+ID+');">Copy</div>';
  var Menu3 ='<div onMouseOver="this.style.backgroundColor=&#39;#D8E0E9&#39;" onMouseOut="this.style.backgroundColor=&#39;#F3F3F3&#39;"';
      Menu3 +='class="RclickMenuItems" onClick="alert('+ID+');">Delete</div>';
  document.getElementById('MenuItem1').innerHTML = Menu1;
  document.getElementById('MenuItem2').innerHTML = Menu2;
  document.getElementById('MenuItem3').innerHTML = Menu3;
    
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

function showProgressMenu(DivID,ProjID,ColumnID,TableName,SystemID)
{
	var Progarr=parent.ProgressArray;
	x1 = event.clientX + document.body.scrollLeft +5;
	y1 = event.clientY + document.body.scrollTop +5;
	
	//alert(SystemID)
	//var TableName = "Projects"
   var menu = document.getElementById('PhaseProgressMenu').style;
   var MenuItems ='<div class="ProgressItemsHead">Progress</div>';  
     
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ProjID+','+Progarr[1][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[1][2]+'\',\''+Progarr[1][4]+'\' ,\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[1][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[1][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[1][2]+'\'">'
	MenuItems +=''+Progarr[1][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">'+Progarr[1][5]+'</div></div>';	 
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ProjID+','+Progarr[2][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[2][2]+'\',\''+Progarr[2][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[2][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[2][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[2][2]+'\'">'
	MenuItems +=''+Progarr[2][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[2][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ProjID+','+Progarr[3][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[3][2]+'\',\''+Progarr[3][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[3][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[3][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[3][2]+'\'">'
	MenuItems +=''+Progarr[3][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[3][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ProjID+','+Progarr[4][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[4][2]+'\',\''+Progarr[4][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[4][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[4][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[4][2]+'\'">'
	MenuItems +=''+Progarr[4][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[4][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ProjID+','+Progarr[5][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[5][2]+'\',\''+Progarr[5][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[5][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[5][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[5][2]+'\'">'
	MenuItems +=''+Progarr[5][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[5][5]+'</div></div>';
	MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ProjID+','+Progarr[6][1]+',\''+DivID+'\','
	MenuItems +='\''+Progarr[6][2]+'\',\''+Progarr[6][4]+'\',\''+ColumnID+'\',\''+TableName+'\',\''+SystemID+'\')">'
	MenuItems +='<div class="ProgressColor" style="background:#'+Progarr[6][2]+';" onMouseOver="this.style.backgroundColor=\''
	MenuItems +='#'+Progarr[6][3]+'\'" onMouseOut="this.style.backgroundColor=\'#'+Progarr[6][2]+'\'">'
	MenuItems +=''+Progarr[6][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+Progarr[6][5]+'</div></div>';
	MenuItems +='<div class="ProgressItemsCancel"><button class="PICancelBtn" onClick="CloseProgressMenu();">Cancel</button></div>';
	
	document.getElementById('PhaseProgressMenu').innerHTML = MenuItems;
	
	var MenuH=document.getElementById('PhaseProgressMenu').offsetHeight;
	var MenuW=document.getElementById('PhaseProgressMenu').offsetWidth;
	
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
  try{document.getElementById('PhaseProgressMenu').style.display = "none";}
	catch(e){return false}
	
  return true;
}

//-------------------------------------------------------------------------------------------------------------------------------,UpdateEngineer(value,&#39;'+DivID+'&#39;,'+ID+)-



function ShowEmployeeList(DivID,ID,LoopNum)
{	
	x1 = event.clientX + document.body.scrollLeft +5;
	y1 = event.clientY + document.body.scrollTop +5;


    var menu = document.getElementById('EmployeeList').style;
  var MenuItems ='<select size= 7 class="EmployeeListInside" onchange= "CloseEmployeeList(),UpdateProjManager(value,&#39;'+DivID+'&#39;,'+ID+')">'
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
	 
	
      document.getElementById('EmployeeList').innerHTML = MenuItems;
	
  menu.top=y1;
  menu.left=x1 ;
  menu.display="block";
  return false;
}


function CloseEmployeeList()
{
	try{document.getElementById('EmployeeList').style.display = "none";}
	catch(e){return false;}
	return true
}




///Expanding Project Info Box//////////////////////////////////////////////////////////////////////////////////////////////////


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
				document.getElementById(InfoIDLast).style.display = 'none';
				document.getElementById(BackgroundIDLast).style.background ='url(Images/BookClosed.gif)';	
			}
		document.getElementById(InfoID).style.display = 'block';
		document.getElementById(BackgroundID).style.background ='url(Images/BookOpen.gif)';
		Switch = 1;
	}
	else
	{
		if(InfoIDLast != '')
			{
				document.getElementById(InfoIDLast).style.display = 'none';
				document.getElementById(BackgroundIDLast).style.background ='url(Images/BookClosed.gif)';
			}
		document.getElementById(InfoID).style.display = 'none';
		document.getElementById(BackgroundID).style.background ='url(Images/BookClosed.gif)';
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
	if(!Gebi('RowContainer'+RowNum)){return false}
	try{SelectedRowBGColor=Gebi('RowContainer'+RowNum).style.backgroundColor;}
	catch(e){document.body.innerHTML+='List is Empty.'; return false;}
	SelectedItemName=Gebi('')
	
	SelectTreeItem(Gebi('JobName'+RowNum));
}//////////////////////////////////////////////////////

//-----------------------------------------------------
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
			try
			{
				Gebi('RowContainer'+SelectedRow).style.backgroundColor=SelectedRowBGColor;
				Gebi('RowContainer'+SelectedRow).style.color='#000';
			}
			catch(e){document.body.innerHTML+='List is Empty.'; return false;}
		}
	}
	
	SelectedItemBGColor=ThisItem.parentNode.style.backgroundColor;
	SelectedItemColor=ThisItem.style.color;
	SelectedItemFontWeight=ThisItem.style.fontWeight;
	SelectedItem=ThisItem;
	
	ThisItem.style.backgroundColor='#00F';
	ThisItem.style.fontWeight='bold';
	ThisItem.style.color='#FF0';
	
	PGebi('ProjectListControl').style.display='none';
	PGebi('ItemListControl').style.display='none';
	PGebi('ListItemControl').style.display='none';
	PGebi('SubItemControl').style.display='none';
	PGebi('ItemNotesText').disabled=false;
	PGebi('ItemNotesText').value='';
	PGebi('btnRemove').disabled=false;
	PGebi('RemItemName').innerHTML='';
	PGebi('txtRename').disabled=false;
	
	//alert(ThisItem.parentNode.id.split('.')[0]+', '+'ItemJob'+SelectedRow);
	
	SelectedItemType=ThisItem.parentNode.id.split('.')[0]
	
	if(SelectedItemType=='ItemJob'+SelectedRow)
	{
		PGebi('ItemNotesText').value=Gebi('Notes'+SelectedRow).value;
		PGebi('btnRemove').disabled=true;
		PGebi('ProjectListControl').style.display='block';
		PGebi('txtRename').disabled=true;
		PGebi('txtRename').value='';
	}
	else
	{
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
		
		if(SelectedItemType=='ListItem')
		{
			PGebi('lblSubItemAdd').innerHTML='New Sub-Item For '+SelectedItem.innerHTML;
			PGebi('SubItemControl').style.display='block';
		}
	}
}

function SelectTreeItemByIdLevel5(ID)
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
				
				var PMDivID=Item.parentNode.parentNode.parentNode.parentNode.id.replace('ItemEmp.2','PlusMinus.1');
				PMDA=PMDivID.split('.');
				PMDivID=PMDA[0]+'.'+PMDA[1]+'.'+PMDA[2]+'.'+PMDA[4];

				PlusMinusToggle(Gebi(PMDivID), RowNum);
				
				PMDivID=Item.parentNode.parentNode.parentNode.parentNode.id.replace('ItemEmp','PlusMinus')+'.0';
				PlusMinusToggle(Gebi(PMDivID), RowNum);
				
				PMDivID=Item.parentNode.parentNode.parentNode.id.replace('ItemList','PlusMinus');
				PlusMinusToggle(Gebi(PMDivID), RowNum)
				
				PMDivID=Item.parentNode.parentNode.id.replace('ItemList','PlusMinus');
				PlusMinusToggle(Gebi(PMDivID), RowNum)
				
				SelectTreeItem(Item);
				return true;
			}
		}
	}
	
	alert('TreeListID: '+ID+' was not found.');
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
		if(PMIndex[3]==0){Gebi('RowContainer'+RowNum).style.height='15px';}
		else{PlusMinusDiv.parentNode.style.height='15px';}
	}
	else
	{
		PlusMinusDiv.style.background=Gebi('Minus').style.background;
		if(PMIndex[3]==0){Gebi('RowContainer'+RowNum).style.height='auto';}
		else{PlusMinusDiv.parentNode.style.height='auto';}
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

var ProgressCol;
function ShowProgMenu(ProgObj,ProgCol)
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
	*/
	ProgressCol=ProgCol;
}


/**/
function ToCal()
{
	
	parent.ShowCalendar();
	
	var Target = parent.parent.document.getElementById('CalendarIframe').contentWindow
	
	/**/
	Target.document.getElementById('ModalScreen').style.display = 'block';
	Target.document.getElementById('ModalScreen').style.visibility = 'visible';
	Target.document.getElementById('NewEventBox').style.display = 'inline';
	Target.ShowEventModal('Month',1,document.getElementById('ItemDateStarted'+SelectedRow).value,'NewEvent');
	
	var FromDate=Gebi('ItemDateStarted'+SelectedRow).value;
	var ToDate=Gebi('ItemDateDue'+SelectedRow).value;
	
	if(!FromDate)
	{
		var Today= new Date;
		FromDate=(Today.getMonth()+1)+'/'+Today.getDate()+'/'+Today.getFullYear();
	}
	
	if(!ToDate){ToDate=FromDate;}
	
	Target.document.getElementById('EventTitleText').value = document.getElementById('JobName'+SelectedRow).innerHTML;
	Target.document.getElementById('EventTitleText').style.display='block';
	Target.document.getElementById('FromDateTxt').value = FromDate;
	Target.document.getElementById('FromDateTxt').style.display='block';
	Target.document.getElementById('ToDateTxt').value = ToDate;
	Target.document.getElementById('ToDateTxt').style.display='block';
	Target.document.getElementById('EventNewNotes').value = PGebi('ItemNotesText').value;
	Target.document.getElementById('EventNewNotes').style.display='block';
	
	
	var AttnSel = Target.document.getElementById('AttnList');
	for(var i=1;i<=AttnSel.length-1;i++)
	{		
		if(AttnSel[i].innerText == parent.parent.accessEmpName)		{AttnSel.selectedIndex = i;}
	}
	var TaskList = Target.document.getElementById('TaskList');
	
	
	var AreaSel = Target.document.getElementById('AreaList');
	for(var i=1;i<=AreaSel.length-1;i++)
	{	
		if(AreaSel[i].innerText == Gebi('Area'+SelectedRow).value)		{AreaSel.selectedIndex = i;}
	}

	TaskList.selectedIndex=5//OrderNum of "Project / Jobs"
	/**/
}
/**/


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









function Resize()
{
	var H= Math.abs(document.body.offsetHeight-0);
	Gebi('OverAllContainer').style.height =H +'px';
	Gebi('RightContainer').style.height=H +'px';
	Gebi('ListBody').style.height = Math.abs(Gebi('Lists').offsetHeight-Gebi('SearchSort').offsetHeight-96)+'px';
	Gebi('TLItemsContainer').style.height=(Gebi('ListBody').offsetHeight-0)+'px';
	var FrameH=Gebi('TLItemsContainer').offsetHeight-32;
	try{Gebi('ProjListFrame').style.height=FrameH+'px';}
	catch(e){Gebi('ProjListFrame').height=FrameH+'px';}
	Gebi('ItemNotesContainer').style.height=Math.abs(Gebi('ListBody').offsetHeight-28)+'px';
}