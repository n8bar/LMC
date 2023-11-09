// JavaScript Document



function TextMouseOver(This){This.style.color= '#'+parent.ProgressArray[1][6]+'';}

function TextMouseOut(This){This.style.color='#'+parent.ProgressArray[1][7]+'';	}


//////Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function TaskListBkGndOn(ID){document.getElementById('TaskListItems'+ID+'').style.background = '#E6F3FB';}

function TaskListBkGndOff(ID){document.getElementById('TaskListItems'+ID+'').style.background ='#FFF';}
//----------------------------------------------------------------

//////Archive Task List MouseOver Back Ground/////////////////////////////////////////////////////////////
function ArchivedTaskListBkGndOn(ID){document.getElementById('ArchivedTaskListItems'+ID+'').style.background = '#E6F3FB';}

function ArchivedTaskListBkGndOff(ID){document.getElementById('ArchivedTaskListItems'+ID+'').style.background ='#FFF';}
//----------------------------------------------------------------

//////Archive button MouseOver BackGround///////////////////////////////////////////////////////////
function ArchiveButtonMouseOver(ID){document.getElementById('ArchiveButton'+ID+'').style.background = 'url(Images/Arrow20X25R2.gif)';}

function ArchiveButtonMouseOut(ID){document.getElementById('ArchiveButton'+ID+'').style.background ='url(Images/Arrow20X25R.gif)';}

//----------------------------------------------------------------------

//////Active Button MouseOver BackGround///////////////////////////////////////////////////////////
function ArchiveButtonMouseOver1(ID){document.getElementById('ArchivedArchiveButton'+ID+'').style.background = 'url(Images/Arrow20X25L2.gif)';}

function ArchiveButtonMouseOut1(ID){document.getElementById('ArchivedArchiveButton'+ID+'').style.background ='url(Images/Arrow20X25L.gif)';}

//----------------------------------------------------------------------





// Click Menus//////////////////////////////////////////////////////////////////////////////////////////////////////

var x,y;

if(!document.all){document.captureEvents(Event.MOUSEMOVE);}
document.onmousemove=getMousePos;



function getMousePos(e)
{
  if(document.all){x=event.x+document.body.scrollLeft;y=event.y+document.body.scrollTop;}
  else{x=e.pageX;y=e.pageY;}
}


function showProgressMenu(DivID,ID,ColumnID)
{
	////alert(parent.EmployeeArray[4][2]);
   var menu = document.getElementById('PhaseProgressMenu').style;
  var MenuItems ='<div class="ProgressItemsHead">Progress</div>';  
     
				MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ID+','+parent.ProgressArray[1][1]+',&#39;'+DivID+'&#39;,'
				MenuItems +='&#39;'+parent.ProgressArray[1][2]+'&#39;,&#39;'+parent.ProgressArray[1][4]+'&#39; ,&#39;'+ColumnID+'&#39;)">'
				MenuItems +='<div class="ProgressColor" style="background:#'+parent.ProgressArray[1][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
				MenuItems +='#'+parent.ProgressArray[1][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+parent.ProgressArray[1][2]+'&#39;">'
				MenuItems +=''+parent.ProgressArray[1][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)">'+parent.ProgressArray[1][5]+'</div></div>';	 
				MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ID+','+parent.ProgressArray[2][1]+',&#39;'+DivID+'&#39;,'
				MenuItems +='&#39;'+parent.ProgressArray[2][2]+'&#39;,&#39;'+parent.ProgressArray[2][4]+'&#39;,&#39;'+ColumnID+'&#39;)">'
				MenuItems +='<div class="ProgressColor" style="background:#'+parent.ProgressArray[2][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
				MenuItems +='#'+parent.ProgressArray[2][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+parent.ProgressArray[2][2]+'&#39;">'
				MenuItems +=''+parent.ProgressArray[2][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+parent.ProgressArray[2][5]+'</div></div>';
				MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ID+','+parent.ProgressArray[3][1]+',&#39;'+DivID+'&#39;,'
				MenuItems +='&#39;'+parent.ProgressArray[3][2]+'&#39;,&#39;'+parent.ProgressArray[3][4]+'&#39;,&#39;'+ColumnID+'&#39;)">'
				MenuItems +='<div class="ProgressColor" style="background:#'+parent.ProgressArray[3][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
				MenuItems +='#'+parent.ProgressArray[3][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+parent.ProgressArray[3][2]+'&#39;">'
				MenuItems +=''+parent.ProgressArray[3][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+parent.ProgressArray[3][5]+'</div></div>';
				MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ID+','+parent.ProgressArray[4][1]+',&#39;'+DivID+'&#39;,'
				MenuItems +='&#39;'+parent.ProgressArray[4][2]+'&#39;,&#39;'+parent.ProgressArray[4][4]+'&#39;,&#39;'+ColumnID+'&#39;)">'
				MenuItems +='<div class="ProgressColor" style="background:#'+parent.ProgressArray[4][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
				MenuItems +='#'+parent.ProgressArray[4][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+parent.ProgressArray[4][2]+'&#39;">'
				MenuItems +=''+parent.ProgressArray[4][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+parent.ProgressArray[4][5]+'</div></div>';
				MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ID+','+parent.ProgressArray[5][1]+',&#39;'+DivID+'&#39;,'
				MenuItems +='&#39;'+parent.ProgressArray[5][2]+'&#39;,&#39;'+parent.ProgressArray[5][4]+'&#39;,&#39;'+ColumnID+'&#39;)">'
				MenuItems +='<div class="ProgressColor" style="background:#'+parent.ProgressArray[5][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
				MenuItems +='#'+parent.ProgressArray[5][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+parent.ProgressArray[5][2]+'&#39;">'
				MenuItems +=''+parent.ProgressArray[5][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+parent.ProgressArray[5][5]+'</div></div>';
				MenuItems +='<div class="ProgressItems" onclick="ProgressClick('+ID+','+parent.ProgressArray[6][1]+',&#39;'+DivID+'&#39;,'
				MenuItems +='&#39;'+parent.ProgressArray[6][2]+'&#39;,&#39;'+parent.ProgressArray[6][4]+'&#39;,&#39;'+ColumnID+'&#39;)">'
				MenuItems +='<div class="ProgressColor" style="background:#'+parent.ProgressArray[6][2]+';" onMouseOver="this.style.backgroundColor=&#39;'
				MenuItems +='#'+parent.ProgressArray[6][3]+'&#39;" onMouseOut="this.style.backgroundColor=&#39;#'+parent.ProgressArray[6][2]+'&#39;">'
				MenuItems +=''+parent.ProgressArray[6][4]+'</div><div class="ProgressDesc" onMouseOver="TextMouseOver(this)" onMouseOut="TextMouseOut(this)" >'+parent.ProgressArray[6][5]+'</div></div>';
				MenuItems +='<div class="ProgressItemsCancel"><button class="PICancelBtn" onClick="CloseProgressMenu();">Cancel</button></div>';
				
      document.getElementById('PhaseProgressMenu').innerHTML = MenuItems;
	
menu.top=y;
  menu.left=x;
  menu.display="block";
  return false;
}


function CloseProgressMenu()
{
  document.getElementById('PhaseProgressMenu').style.display = "none";
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




