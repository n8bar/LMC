// JavaScript Document




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


function ChangeToArchive()
{
	document.getElementById("TestButton2").style.display = 'block';
	document.getElementById("TestButton1").style.display = 'none';
	document.getElementById("HeaderRight2").style.display = 'block';
	document.getElementById("HeaderRight").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ProjListFrame').src=Gebi('ProjListFrame').src.replace('True','False');
}

function ChangeToActive()
{
	document.getElementById("TestButton2").style.display = 'none';
	document.getElementById("TestButton1").style.display = 'block';
	document.getElementById("HeaderRight").style.display = 'block';
	document.getElementById("HeaderRight2").style.display = 'none';
	//Gebi('TLItemsContainer').innerHTML = '';
	Gebi('ProjListFrame').src=Gebi('ProjListFrame').src.replace('False','True');
}




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




function AngleText(txt,objId)
{
	var obj=document.getElementById(objId);
	if(obj==null){return false;}
	//alert(obj);

	var vSp=8; //vertical spacing in pixels
	var hSp=0; //horizontal spacing

	var Text= new Array;
	Text= txt.split(',')

	obj.innerHTML=''
	var HTML=''
	for(c=0;c<Text.length;c++)
	{
		//var char=txt.substring(c,c+1);
		HTML+='<div style="height:'+vSp+'px; margin-left:'+c*hSp+'px; overflow:visible;" align="center">';
		
		//for(s=0;s<c*hSp;s++)
		//{HTML+='&nbsp;'}
		
		//HTML+=char+'</div>';
		HTML+=Text[c]+'</div>';
	}
	
	obj.innerHTML=HTML;
}


var alignmentInterval;
function Resize()
{
	alignColumns();
	alignmentInterval=setInterval('alignColumns();',500);
	
	var H= Math.abs(document.body.offsetHeight-43);
	Gebi('OverAllContainer').style.height =H +'px';
	Gebi('RightContainer').style.height=H +'px';
	Gebi('ListBody').style.height = Math.abs(Gebi('Lists').offsetHeight-Gebi('Header').offsetHeight-20)+'px';
	//alert(RightContainer.offsetHeight+'  '+OverAllContainer.offsetHeight);
	
	Gebi('TLItemsContainer').style.width = Math.abs(Gebi('ItemsHead').offsetWidth-9)+'px';
	Gebi('TLItemsContainer').style.height = Math.abs(Gebi('ListBody').offsetHeight-56)+'px';
	Gebi('TLItemsContainer').style.maxHeight = Math.abs(Gebi('ListBody').offsetHeight-56)+'px';
	
	var W=Math.abs(Gebi('ItemsHead').offsetWidth-9)//100//TLItemsContainer.offsetWidth
	/*
	var Width;
	for(i=0;i<ItemAttns.length-1;i++)
	{
		Width=(W*.63)-360;
		if(Width>64)
		{document.getElementById(ItemAttns[i]).style.width=Width+'px';}
		else
		{document.getElementById(ItemAttns[i]).style.width='64px';}
		//document.getElementById(ItemAttns[i]).innerHTML=((W*.75)-200);
	}
	/**/
	Gebi('ProjListFrame').contentWindow.reload;
}

var alignmentIterations=0;
function alignColumns()//To Be Called From Within ProjList.asp
{
	//alignmentIterations++;
	//PGebi('HeaderRight').value=alignmentIterations;
	
	if(alignmentIterations>10){
		clearInterval(alignmentInterval);
		alignmentIterations=0;
	}
	
	
	if(PGebi('ProjListFrame')==null)
	{
		setTimeout('alignColumns();',300);
		return false;
	}
	
	var OL=0//PGebi('ProjListFrame').offsetLeft;
	var OH=(PGebi('TLItemsContainer').offsetHeight-0)+'px';
	
	
	if(Gebi('iPlans1')==null)return false;
	
	Gebi('HeadProg').style.left=(Gebi('iPlans1').offsetLeft+OL)+'px';
	Gebi('PlansColumn').style.left=Math.abs(Gebi('iPlans1').offsetLeft-1)+'px';
	Gebi('UndergroundColumn').style.left=Math.abs(Gebi('iUnderGround1').offsetLeft-1)+'px';
	Gebi('DoneColumn').style.left=Math.abs(Gebi('iJobFinish1').offsetLeft-1)+'px';
	Gebi('RoughInspColumn').style.left=Math.abs(Gebi('iRoughInspect1').offsetLeft-1)+'px';
	Gebi('TrimColumn').style.left=Math.abs(Gebi('iTrim1').offsetLeft-1)+'px';
	
	Gebi('PlansColumn').style.height=OH;
	Gebi('UndergroundColumn').style.height=OH;
	Gebi('RoughInspColumn').style.height=OH;
	Gebi('TrimColumn').style.height=OH;
	Gebi('DoneColumn').style.height=OH;
}

function PGebi(objID){return parent.document.getElementById(objID);}