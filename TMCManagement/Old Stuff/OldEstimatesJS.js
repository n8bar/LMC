// JavaScript Document

var ProjBoxArray = new Array('ProjectMainBox','ProjPrintBox','ProjSysBox');
var ProjTabArray = new Array();

window.onload = function() 
{
  onResize();
}





//--------------------------------------------------------------------
function ProjTodoToggle()
{
	if(Gebi('ProjView').checked==true)
	{
		Gebi('ProjectContainer').style.display='block';
		//Gebi('ToDoList').style.display='none';
		//Gebi('ToDoView').checked=false;
	}
	else
	{
		//Gebi('ProjectContainer').style.display='none';
		//Gebi('ToDoList').style.display='block';
		//Gebi('ToDoView').checked=true;
	}
}

////////////////////////////////////////////////////////////////////////

//fills the screen with a Container on resize /////////////////////////////////////////////////////////////////////////////

var DocW = '';
var DocH = '';
var NewWidth;
var NewHeight;

var ResizeTimer
ResizeTimer=setTimeout('Resize();',2000);
function onResize()
{
	clearTimeout(ResizeTimer)
	ResizeTimer=setTimeout('Resize();',100);
}

function Resize()
{
	if(InsideFrame){return false;}
	try
	{
		document.body.style.height='100%';
		document.body.style.height=(document.body.offsetHeight+1)+'px';
	}
	catch(e)
	{
		//Need an IE solution.
	}
	
	DocW = document.body.offsetWidth;
  DocH = document.body.offsetHeight;

	NewWidth = DocW - 298;
	NewHeight = DocH - 12;
//	if(IEver>0&&(NewWidth<0||NewHeight<0)){return false}
	
	Gebi('RightContainer').style.width = Math.abs(DocW-Gebi('LeftContainer').offsetWidth-2)+'px';
	try{Gebi('RightContainer').style.height = NewHeight+'px';}catch(e){return false;}
	Gebi('RightContainer').style.maxHeight = NewHeight+'px';
	Gebi('RightContainer').style.minHeight = NewHeight+'px';
	
	Gebi('SystemLock').style.width=Gebi('RightContainer').style.width;

	Gebi('ProjectContainer').style.height = Math.abs(NewHeight-0)+'px';
	Gebi('ProjectContainer').style.maxHeight = Math.abs(NewHeight-0)+'px';
	Gebi('ProjectBox').style.maxHeight=Math.abs(NewHeight-24)+'px';
	Gebi('ProjectBox').style.maxHeight=Math.abs(NewHeight-24)+'px';
	
	Gebi('ProjectMainBox').style.height=Math.abs(Gebi('ProjectBox').offsetHeight-64)+'px';
	Gebi('ProjPrintBox').style.height=Math.abs(Gebi('ProjectBox').offsetHeight-64)+'px';
	Gebi('ProjSysBox').style.height=Math.abs(Gebi('ProjectBox').offsetHeight-64)+'px';
	
	Gebi('ProjInfoBox').style.height=Math.abs(Gebi('ProjectContainer').offsetHeight-136)+'px';
	Gebi('EstimateMain').style.height='100%';
	Gebi('EstimateMain').style.maxHeight=Math.abs(Gebi('ProjectContainer').offsetHeight-96)+'px';
	Gebi('InfoBox').style.height=Math.abs(Gebi('EstimateMain').offsetHeight-32)+'px';
	Gebi('PartsBox').style.height=Gebi('InfoBox').style.height;
	Gebi('LaborBox').style.height=Gebi('PartsBox').style.height;
	Gebi('AltsBox').style.height=Gebi('PartsBox').style.height;
	Gebi('ExpensesBox').style.height=Gebi('PartsBox').style.height;
	
	Gebi('ProjList').style.height=Math.abs(DocH-224)+'px';
	Gebi('ProjList').style.maxHeight=Math.abs(DocH-224)+'px';

	Gebi('CustList').style.height=Math.abs(DocH-224)+'px';

	//Gebi('LGrPos').style.height=Math.abs(Gebi('LGrad').parentNode.parentNode.offsetHeight-Gebi('LGrad').offsetHeight-96)+'px';
	
	//return false;
	//Gebi('RightContainer').style.width = Math.abs(NewWidth)+'px';
	//Gebi('RightContainer').style.height = Math.abs(NewHeight)+'px';
	
	Gebi('LeftContainer').style.height = Math.abs(Gebi('RightContainer').offsetHeight)+'px';
	
	Gebi('AreaContainer').style.height = Math.abs(Gebi('RightContainer').offsetHeight-Gebi('LeftTitle').offsetHeight-Gebi('LeftTop').offsetHeight-8)+'px';
	Gebi('ProjList').style.height=Math.abs(Gebi('AreaContainer').offsetHeight-Gebi('AreaTopBox').offsetHeight-2)+'px';
	Gebi('CustList').style.height=Math.abs(Gebi('AreaContainer').offsetHeight-Gebi('AreaTopBox').offsetHeight-6)+'px';
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function numbersOnly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) )
   {return true;}

// numbers
else if ((("0123456789").indexOf(keychar) > -1))
   {return true;}

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}




function ReadOnly(myfield, e, dec)
{
	var key;
	var keychar;
	
	if (window.event)
		 {key = window.event.keyCode;}
	else if (e)
		 {key = e.which;}
	else
		 {return true;}
	keychar = String.fromCharCode(key);
	
	// control keys
	if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) )
	   {return false;}
	
	// numbers
	//else if ((("0123456789").indexOf(keychar) > -1))
	//   {return true;}
	
	//else
	//	{
		return false;
	//	}
}













//This Code Restricts Text Entry  /////////////////////////////////////////////////////////////////////////////

var letters=' ABC«DEFGHIJKLMN—OPQRSTUVWXYZabcÁdefghijklmnÒopqrstuvwxyz‡·¿¡ÈË»…ÌÏÕÃÔœÛÚ”“˙˘⁄Ÿ¸‹'
var numbers='1234567890'
var signs=',.:;@-\''
var decimal='.'
var mathsigns='+-=()*/'
var custom='<>#$%&?ø'

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function alpha(e,allow,obj)
{

	var k;
	//var evtobj=window.event? event : e;
	k=document.all?parseInt(e.keyCode): parseInt(e.which);
	//alert(k);
		  if (k!=13 && k!=8 && k!=0){
				//alert(allow.indexOf(String.fromCharCode(k))!=-1);
				if ((e.ctrlKey==false) && (e.altKey==false)) {
					  return (allow.indexOf(String.fromCharCode(k))!=-1);
				} else {
					  return true;
				}
		  } else {
				return true;
		  }

}






//This formats Money
function formatCurrency(num) {
	num = num.toString().replace(/\$|\,/g,'');
	if(isNaN(num))
	num = "0";
	sign = (num == (num = Math.abs(num)));
	num = Math.floor(num*100+0.50000000001);
	cents = num%100;
	num = Math.floor(num/100).toString();
	if(cents<10)
	cents = "0" + cents;
	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
	num = num.substring(0,num.length-(4*i+3))+','+
	num.substring(num.length-(4*i+3));
	//return (((sign)?'':'-') + '' + num + '.' + cents);
	return (((sign)?'':'-') + '$' + num + '.' + cents);   //Add A Dollar Sign $
}
/*
<input type="text" onkeypress="return alpha(event,numbers+decimal)" />
<input type="text" onkeypress="return alpha(event,letters)" />
<input type="text" onkeypress="return alpha(event,numbers+letters+signs)" />
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//Right Click Menu//////////////////////////////////////////////////////////////////////////////////////////////////////





function RcMenu(e,MenuID,SelectedID)
{
	if (e.button==2 || e.button==3) 
	{
		
		if(MenuID == 'MenuProjects'){  y = (y + 60);  x = (x + 1);  }
		if(MenuID == 'MenuSystems'){  y = (y + 1);  x = (x + 1);  }
		
		
	    var MenuHTML = '';
		
		
		
		if(MenuID == 'MenuProjects')
		{
			MenuHTML += ('<div id="'+MenuID+'1" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'1&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'1&#39)" onClick="" >COPY</div>');
			MenuHTML += ('<div id="'+MenuID+'2" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'2&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'2&#39)" onClick="ToggleActiveProject('+SelectedID+',1);" >Activate</div>');
			MenuHTML += ('<div id="'+MenuID+'3" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'3&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'3&#39)" onClick="ToggleActiveProject('+SelectedID+',0);" >Deactivate</div>');
			MenuHTML += ('<div id="'+MenuID+'4" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'4&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'4&#39)">Archive</div>');
			MenuHTML += ('<div id="'+MenuID+'5" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'5&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'5&#39)"  onClick="DeleteProject('+SelectedID+');">DELETE</div>');
		}
		
		
		if(MenuID == 'MenuSystems')
		{
			MenuHTML += ('<div id="'+MenuID+'1" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'1&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'1&#39)" onClick="" >COPY</div>');
			MenuHTML += ('<div id="'+MenuID+'2" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'2&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'2&#39)" onClick="ToggleActiveSystem('+SelectedID+',1);" >Activate</div>');
			MenuHTML += ('<div id="'+MenuID+'3" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'3&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'3&#39)" onClick="ToggleActiveSystem('+SelectedID+',0);" >Deactivate</div>');
			MenuHTML += ('<div id="'+MenuID+'5" class="RclickMenuItems" onmouseover="MouseOverMenu(&#39'+MenuID+'5&#39)" onmouseout="MouseOutMenu(&#39'+MenuID+'5&#39)"  onClick="DeleteSystem('+SelectedID+');">DELETE</div>');
		}		
		
		
				
		Gebi(MenuID).innerHTML = MenuHTML;		
		
		
		
		
		var menu = Gebi(MenuID).style;
		menu.top=y;
		menu.left=x
		menu.display="inline";
		sMenuID = MenuID;
	}
}

//////////////////////

function LoadMainLists()
{ 
//AREA DROPDOWNS------------------------------------- 
	var AreaArray = parent.AreaArray;
	var AreaLen = parent.AreaArray.length; 
	 
	 Gebi('AreaSearch').length=null;
	 
	 var newOption = document.createElement("OPTION");
	 Gebi('AreaSearch').options.add(newOption);
	 newOption.value = 0;
	 newOption.innerHTML = 'All';
	
	for (var y = 1; y < AreaLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('AreaSearch').options.add(newOption);
	   newOption.value = AreaArray[y][1];
	   newOption.innerHTML = AreaArray[y][2];
	 }

	 Gebi('NewProjArea').length=null;
	 
	   var newOption = document.createElement("OPTION");
	   Gebi('NewProjArea').options.add(newOption);
	   newOption.value = 1;
	   newOption.innerHTML = '';
	
	for (var y = 1; y < AreaLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('NewProjArea').options.add(newOption);
	   newOption.value = AreaArray[y][1];
	   newOption.innerHTML = AreaArray[y][2];
	 }
	Gebi('NewProjArea').selectedIndex=1;
//Franchise DROPDOWN------------------------------------- 

	var FranArray = parent.FranchiseArray;
	var FranLen = parent.FranchiseArray.length;
	
	Gebi('NewProjFran').length=null;
	 
	var newOption = document.createElement("OPTION");
	Gebi('NewProjFran').options.add(newOption);
	newOption.value = 1;
	newOption.innerHTML = '';
	
	for (var y = 1; y < AreaLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('NewProjFran').options.add(newOption);
	   newOption.value = FranArray[y][1];
	   newOption.innerHTML = FranArray[y][2];
	 }
	Gebi('NewProjFran').selectedIndex=1;

	onResize();
}









// This function loads all of the dropdown lists in Estimates from the CommonAJAX.js file///////////////////////////////////////////////////

 
////LOAD LISTS//////////////////////////////////////////////////////////////////////////////////////////////// 
  
function LoadEstimateLists()
{ 

//Employee Lists------------------------------------- 
	var EmpArray = parent.EmployeeArray;
	var EmpLen = parent.EmployeeArray.length;

/*
	Gebi('EnteredBy').length=null;
	
	 var newOption = document.createElement("OPTION");
	 Gebi('EnteredBy').options.add(newOption);
	 newOption.value = parent.accessEmpID;
	 newOption.innerText = parent.accessUser ;
	for (var y = 1; y < EmpLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('EnteredBy').options.add(newOption);
	   newOption.value = EmpArray[y][1];
	   newOption.innerText = EmpArray[y][2];
	 } 
*/

	 Gebi('NewSysEnteredBy').length=null;
	 
	 var newOption = document.createElement("OPTION");
	 Gebi('NewSysEnteredBy').options.add(newOption);
	 newOption.value = parent.accessEmpID;
	 newOption.innerText = parent.accessUser ;
	 for (var y = 1; y < EmpLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('NewSysEnteredBy').options.add(newOption);
	   newOption.value = EmpArray[y][1];
	   newOption.innerText = EmpArray[y][2];
	 } 
	 



	 
//AREA DROPDOWN------------------------------------- 
	var AreaArray = parent.AreaArray;
	var AreaLen = parent.AreaArray.length; 
	 
	 Gebi('ProjectArea').length=null;
	 
	   var newOption = document.createElement("OPTION");
	   Gebi('ProjectArea').options.add(newOption);
	   newOption.value = 1;
	   newOption.innerText = '';
	
	for (var y = 1; y < AreaLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('ProjectArea').options.add(newOption);
	   newOption.value = AreaArray[y][1];
	   newOption.innerText = AreaArray[y][2];
	 } 
	 
	 Gebi('AreaSearch').length=null;
	 
	   var newOption = document.createElement("OPTION");
	   Gebi('AreaSearch').options.add(newOption);
	   newOption.value = 1;
	   newOption.innerText = '';
	
	for (var y = 1; y < AreaLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('AreaSearch').options.add(newOption);
	   newOption.value = AreaArray[y][1];
	   newOption.innerText = AreaArray[y][2];
	 }
	 
	 
	 
	 
//Franchise DROPDOWN------------------------------------- 
	var FranArray = parent.FranchiseArray;
	var FranLen = parent.FranchiseArray.length; 
	 
	 Gebi('ProjectFranchise').length=null;
	 
	   var newOption = document.createElement("OPTION");
	   Gebi('ProjectFranchise').options.add(newOption);
	  // newOption.value = 0;
	 //  newOption.innerText = 'None';
	 
	for (var y = 0; y < FranLen; y++)
	 {
	   var newOption = document.createElement("OPTION");
	   Gebi('ProjectFranchise').options.add(newOption);
	   newOption.value = FranArray[y][1];
	   newOption.innerText = FranArray[y][2];
	 } 
	 	 



}  
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  
  
  
  
function UpdateSubOf()//Updates the Faranchise Owner
{
   
	
	var Obj = Gebi('ProjectFranchise'); 
	var ID = (Obj.options.value);
    var Text = (Obj.options[Obj.selectedIndex].text ); //Gets the Text Value----++++
	
	var FranArray = parent.FranchiseArray;
	var FranLen = parent.FranchiseArray.length; 
	
	Gebi('SubOf').value = '';
	
	// This Function Searches The Array And Returns The Franchise Owner
	var TxtValue = '';
	for (var y = 1; y < FranLen; y++)
	{
		TxtValue = (FranArray[y][2]);
		if(TxtValue == Text){var Owner = (FranArray[y][3]);}
		
	} 
   
    if(Text == ''){var Owner = '';}
	
	Gebi('SubOf').value = Owner;
	Gebi('SubOf').focus();
}



function NewProjUpdateSubOf()//Updates the Faranchise Owner
{
	var Obj = Gebi('NewProjFran'); 
	var ID = (Obj.options.value);
	var Text = (Obj.options[Obj.selectedIndex].text ); //Gets the Text Value----++++
	//alert(Text);
	
	var FranArray = parent.FranchiseArray;
	var FranLen = parent.FranchiseArray.length; 
	
	Gebi('NewProjSubOf').value = '';
	
	// This Function Searches The Array And Returns The Franchise Owner
	var TxtValue = '';
	for (var y = 1; y < FranLen; y++)
	{
		TxtValue = (FranArray[y][2]);
		if(TxtValue == Text){var Owner = (FranArray[y][3]);}
		
	} 
   
    if(Text == ''){var Owner = '';}
	
	Gebi('NewProjSubOf').value = Owner;
	
	Gebi('NewProjSubOf').focus();
}




 function SubsidiaryBlur()
{
	Gebi('OwnName').focus();
} 
  
  
  
  
  
  
  
  
  
  
  
                
                
function closeMenu()
{
	if (sMenuID='undefined'){return false;}
	if (sMenuID != '') {Gebi(sMenuID).style.display="none";}
}






//---Highlights the menu selection
//---Highlights the menu selection

function MouseOverMenu(This)
{
	Gebi(This).style.background = '#D2D2FF';
}
function MouseOutMenu(This)
{
	Gebi(This).style.background = '#FFF';
}










//parent.FrameTop.document.all('TopBarLeft').style.background = '#2E4615'; 
//parent.FrameTop.document.all('TopBarCenter').style.background = '#2E4615';
//parent.FrameTop.document.all('TopBarRight').style.background = '#2E4615';
//parent.FrameTop.document.all('DatePopup').style.color = '#FFF';
//			^Null or not an object
//





// Mouseover/////////////////////////////////////////Mouseover/////////////////////////////////////////


function MouseOverTab(ID){Gebi(ID).style.color='#FF0';}
function MouseOutTab(ID){Gebi(ID).style.color='#FFF';}


function MouseOverPartsAdd(This)
{
	Gebi(This).style.background = '#D2FFD2';
}
function MouseOutPartsAdd(This)
{
	Gebi(This).style.background = '#FFF';
}



// Show and hide Boxes/////////////////////////////////////////Show and hide Boxes/////////////////////////////////////////
function ShowCustNewBox()
{
	Gebi('CustNewBox').style.display = 'block';
	Gebi('CustName').value = '';
	Gebi('CustAddress').value = '';
	Gebi('CustCity').value = '';
	Gebi('CustState').value = '';
	Gebi('CustZip').value = '';
	Gebi('CustPhone').value = '';
}

function CloseCustNewBox()
{
	Gebi('CustNewBox').style.display = 'none';
}

function SwitchToProjView()
{
	Gebi('ProjView').checked=true;
	Gebi('ProjView').onchange();
}

function ShowNewProjBox()
{
	Gebi('NewProjModal').style.display = 'block';
	Gebi('NewProjBox').style.display = 'block';
	Gebi('NewProjName').value = '';
	SwitchToProjView();
}

function CloseNewProjBox()
{
	Gebi('NewProjModal').style.display = 'none';
	Gebi('NewProjBox').style.display = 'none';
}


function ShowBidNewBox()
{
	Gebi('BidNewBox').style.display = 'block';
	Gebi('BidName').value = '';

}

function CloseBidNewBox()
{
	Gebi('BidNewBox').style.display = 'none';
}




function ShowAddPartModal()
{
	Gebi('AddPartModal').style.display = 'block';
	Gebi('AddPartContainer').style.display = 'block';

	
}   
  
  
function HideAddPartModal()
{
	Gebi('AddPartModal').style.display = 'none';
	Gebi('AddPartContainer').style.display = 'none';
	
}



function ShowAddLaborModal()
{
	Gebi('AddLaborModal').style.display = 'block';
	Gebi('AddLaborContainer').style.display = 'block';

	
}   
  
  
function HideAddLaborModal()
{
	Gebi('AddLaborModal').style.display = 'none';
	Gebi('AddLaborContainer').style.display = 'none';
	
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










//Tabs///////////////////Tabs///////////////////////////Tabs///////////////////////////Tabs///////////////////////////

function ShowTabCBids()
{
	Gebi("AreaContainer").style.display = 'none';
	Gebi("CustomerContainer").style.display = 'none';
	Gebi("CBidsContainer").style.display = 'block';
	
	Gebi("AreaTab").style.background = '#9FB986';
	Gebi("CustTab").style.background = '#9FB986';
	Gebi("CBidsTab").style.background = '#40512F';

	//Gebi('AreaSearch').focus();
}

function ShowTabCust()
{
	Gebi("CustomerContainer").style.display = 'block';
	Gebi("AreaContainer").style.display = 'none';
	Gebi("CBidsContainer").style.display = 'none';
	
	Gebi("CustTab").style.background = '#40512F';
	Gebi("AreaTab").style.background = '#9FB986';
	Gebi("CBidsTab").style.background = '#9FB986';

	Gebi('CustomerTxt').focus();
}

function ShowTabArea()
{
	Gebi("CustomerContainer").style.display = 'none';
	Gebi("AreaContainer").style.display = 'block';
	Gebi("CBidsContainer").style.display = 'none';
	
	Gebi("CustTab").style.background = '#9FB986';
	Gebi("AreaTab").style.background = '#40512F';
	Gebi("CBidsTab").style.background = '#9FB986';

	Gebi('AreaSearch').focus();
}






function ShowTabLeftInfo()
{
	Gebi("InfoBoxLeft").style.display = 'block';
	Gebi("CostingBox").style.display = 'none';
	
	Gebi("InfoLeftTab").style.background = '#40512F';
	Gebi("CostingLeftTab").style.background = '#9FB986';

}

function ShowTabLeftCosting()
{
	Gebi("InfoBoxLeft").style.display = 'none';
	Gebi("CostingBox").style.display = 'block';
	
	Gebi("InfoLeftTab").style.background = '#9FB986';
	Gebi("CostingLeftTab").style.background = '#40512F';

}












function ShowSysTab(TabID)
{
	Gebi("InfoBox").style.display = 'none';
	Gebi("AltsBox").style.display = 'none';
	Gebi("PartsBox").style.display = 'none';
	Gebi("LaborBox").style.display = 'none';
	Gebi("ExpensesBox").style.display = 'none';
	
	Gebi("InfoTab").style.background = '#708D52';
	Gebi("AltsTab").style.background = '#708D52';
	Gebi("PartsTab").style.background = '#708D52';
	Gebi("LaborTab").style.background = '#708D52';
	Gebi("ExpensesTab").style.background = '#708D52';

	Gebi(TabID.replace('Tab','Box')).style.display = 'block';
	Gebi(TabID).style.background = '#40512F';
	
	onResize();
}



function ProjTabs(Box,Tab)//Dynamic Tab Selection
{
	var key;
	
	for(key in ProjBoxArray)
	{
	  //alert(key+'='+ProjBoxArray[key]);
	  Gebi(ProjBoxArray[key]).style.display = 'none';
	}
	
	Gebi(Box).style.display = 'block';
	

//alert(Tab);	
//alert(ProjTabArray);	
	var i

	for(i in ProjTabArray)
	{
	  //alert(i+'='+ProjTabArray[key]);
	  Gebi(ProjTabArray[i]).style.background = '#708D52';
	}
	
	Gebi(Tab).style.background = '#40512F';	
	
	CalcProjTotals();
	onResize();
}







function MouseOverSysList(ID)
{
	//alert(ID);
	Gebi(ID).style.background = '#C2DACC';
}
function MouseOutSysList(ID)
{
	Gebi(ID).style.background = '#FFF';
}








function ShowProjMainTab()
{
	Gebi("ProjectMainBox").style.display = 'block';
	Gebi("ProjPrintBox").style.display = 'none';
	
	Gebi("ProjMainTab").style.background = '#FF0';
	Gebi("ProjPrintTab").style.background = '#708D52';

}
function ShowProjPrintTab()
{
	Gebi("ProjectMainBox").style.display = 'none';
	Gebi("ProjPrintBox").style.display = 'block';
	
	Gebi("ProjMainTab").style.background = '#708D52';
	Gebi("ProjPrintTab").style.background = '#40512F';

}





function NewSystemModal()
{
	d=new Date();
	var month = d.getMonth();
	var monthday = d.getDate();
	var year = d.getYear();
	
	var sDate =(month+1+"/"+monthday+"/"+year);
	
	
	Gebi('NewSysEnteredBy').options.value = '';
	Gebi('NewSysName').value = '';
	Gebi('NewSysDate').value = sDate;
	Gebi('NewSysMU').value = '100';
	Gebi('NewSysTax').value = '7.75';
	
	Gebi('SystemModal').style.display = 'block';
	Gebi('NewSystemBox').style.display = 'block';	
}

function CloseNewSystemModal()
{
	Gebi('SystemModal').style.display = 'none';
	Gebi('NewSystemBox').style.display = 'none';	
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function ObtainBidModal()
{
	GetBidTo();
	var Today = new Date;
	Gebi('ObtainDate').value = (Today.getMonth()+1)+'/'+Today.getDate()+'/'+Today.getFullYear() ;
	Gebi('NewProjModal').style.display = 'block';
	Gebi('ObtainBidBox').style.display = 'block';
}

function CloseObtainBidModal()
{
	Gebi('NewProjModal').style.display = 'none';
	Gebi('ObtainBidBox').style.display = 'none';	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



var BidFrames=0;
function OpenPrintMain()
{
	var ProjID = Gebi('HiddenProjID').value;
	var HTTP = 'OldEstimatePrintMain.asp?ProjID='+ProjID+'';
	var ACustomerIsSelected = false;
	var openWindow = new Array;
	
	var HTTP2
	
	var Bid='';
	for (i=1;i<=Gebi('CustCount').value;i++)
	{
		if(Gebi('cbCust'+i).checked == true)
		{
			ACustomerIsSelected = true;
			var CustID = Gebi('PrintCustId'+i).value;
			HTTP2=HTTP+'&CustID='+CustID;
			openWindow[i]=window.open(HTTP2)//,'Bid'+i, WindowOptions,true);
		}
	}
	if (ACustomerIsSelected == false)
	{
		alert('Please choose a customer.');
		return false;
	}
	else
	{
	}
}

function OpenPrintPartsLabor(PartsOrLabor)
{
	var ProjID = Gebi('HiddenProjID').value;
	var HTTP = 'EstimatePrintPartsLabor.asp?ProjID='+ProjID+'&PartsOrLabor='+PartsOrLabor+'&Costs=1';
	var openWindow = new Array;
	
	openWindow[i]=window.open(HTTP)
}

function OpenPrintExpenses(PartsOrLabor)
{
	var ProjID = Gebi('HiddenProjID').value;
	var HTTP = 'EstimatePrintExp.asp?ProjID='+ProjID;
	var openWindow = new Array;
	
	openWindow[i]=window.open(HTTP)
}
//----------------------------------------------------------------------



function GrabNewProjCust(cName,CustID)
{
	NewProjCustomer.value=cName;
	NewProjCustID.value=CustID;
	//NewProjCustListToggle();
	Gebi('NewProjSearch').style.display='none';
}

function NewProjCustListToggle()
{
//	if (Gebi('NewProjSearch').style.display == 'none')
//	{
		NewProjSearch.style.display='block';
		NewProjCustSearch.focus();
//	}
//	else
//	{
//		Gebi('NewProjSearch').style.display='none';
//	}
}

///////////////////////////////////////////////////
function clearALLradio()
//==========================================
// Check all or uncheck all?
//==========================================
{
	var AllInputs = document.getElementsByTagName("input");
	//alert(AllInputs.length);
	for (var i=0;i<AllInputs.length;i++)
	{
		if (AllInputs[i].type=="radio")
		{
			//alert('Got One!')
			AllInputs[i].checked = false;
		}
	}
}
//////////////////////////////////////



////////////////////
function disableALLtext()
//==========================================
// Check all or uncheck all?
//==========================================
{
	var AllInputs = document.getElementsByTagName("input");
	//alert(AllInputs.length);
	for (var i=0;i<AllInputs.length;i++)
	{
		if (AllInputs[i].type=="text")
		{
			//alert('Got One!  '+AllInputs[i].id);
			AllInputs[i].disabled = true;
		}
	}
}
//////////////////////////////////////


////////////////////
function enableALLtext()
//==========================================
// Check all or uncheck all?
//==========================================
{
	var AllInputs = document.getElementsByTagName("input");
	//alert(AllInputs.length);
	for (var i=0;i<AllInputs.length;i++)
	{
		if (AllInputs[i].type=="text")
		{
			//alert('Got One!  '+AllInputs[i].id);
			AllInputs[i].disabled = false;
		}
	}
}
//////////////////////////////////////







//Displays a box to add a Customer to Bid To://////////////////////////////////////////////////////////////////////////////////

function BidToAdd()
{
	//alert('Howdy'); return false;
	Gebi('NewProjModal').style.display = 'block';	
	Gebi('BidToCustBox').style.display = 'block';
	
}
	
function BidToAddClose()
{
	Gebi('NewProjModal').style.display = 'none';	
	Gebi('BidToCustBox').style.display = 'none';	
}
	
	
//-------------------------------------------------------------------------------------------------


function OpenPresets()
{
	Gebi('PresetPage2').style.visibility = 'hidden';
	Gebi('PresetPage2').style.display = 'none';
	Gebi('BidPresetsModal').style.display = 'block';
	Gebi('BidPresetsContainer').style.display = 'block';	
	Gebi('PresetPage1').style.display = 'block';
	
}

function ClosePresets()
{
	Gebi('BidPresetsModal').style.display = 'none';
	Gebi('BidPresetsContainer').style.display = 'none';	
	Gebi('PresetPage2').style.display = 'none';
	Gebi('PresetPage2').style.visibility = 'hidden';
}


function SetPresetID(ID)
{
	var PreviousID = Gebi("PreHiddenTxt").innerHTML;
	
	if(PreviousID != 0)
	{
		var PreLineID = 'Pre'+PreviousID;
		if(Gebi(PreLineID)){Gebi(PreLineID).style.background='#FFF'}
	}
	
	Gebi("PreHiddenTxt").innerHTML = ID;
	
	var LineID = 'Pre'+ID;
	Gebi(LineID).style.background = '#FF0';
	
}






function CheckLock(Obj)
{
	Gebi('AddCustLink').focus;
}




//--------------------------------------------------------------------------------------
var OldTxt = new Array;
function CheckPhone(e,TxtObj)
{
	var key = ( document.all ) ? window.event.keyCode : e.keyCode;
	
	var o = TxtObj.value;
	var i = TxtObj.value;	if(i.length==null){return false}
	var n = i;
	while (n != n.replace('(','')){n = n.replace('(','')}
	while (n != n.replace(')','')){n = n.replace(')','')}
	while (n != n.replace(',','')){n = n.replace(',','')}
	while (n != n.replace('-','')){n = n.replace('-','')}
	
	if (OldTxt[TxtObj.id]==null||OldTxt[TxtObj.id]==undefined){OldTxt[TxtObj.id]=''}
	
	if ((key<=46) && (key>=35 )||(key==9))//home, end, etc..
	{
		OldTxt[TxtObj.id] = TxtObj.value;
		return false;
	}
	
	var Digit = new Array;
	var BadDigitOffset=0;
	var a;
	for(d=0;d<n.length;d++)
	{	
		a = n.substr(d,1);
		if(a==a*1)
		{
			Digit[(d*1)-BadDigitOffset] = a;
		}
		else
		{	
			alert('Invalid character: '+a);
			
			TxtObj.value = TxtObj.value.substr(0,TxtObj.value.length-1)
			while (TxtObj.value != TxtObj.value.replace('NaN','')){TxtObj.value = TxtObj.value.replace('NaN','')}
			while (TxtObj.value != TxtObj.value.replace('Undefined','')){TxtObj.value = TxtObj.value.replace('Undefined','')}
			//o = TxtObj.value;
			return false;
		}
	}
	
	
	
	if(key==8&&o!=null&&o!=''&&OldTxt[TxtObj.id]!=null&&OldTxt[TxtObj.id]!='')//Backspace
	{
		var LastChar = OldTxt[TxtObj.id].substr(OldTxt[TxtObj.id].length-1)
		if(LastChar=='('||LastChar==')'||LastChar=='-')
		{
			//if the last char was a colon, backspace the previous char as well.
			o = OldTxt[TxtObj.id].substr(0,OldTxt[TxtObj.id].length-2);
		}
	}
	else{ if(key==8){return false;} }
	
	
	//alert(Digit);
	if (   (  ( (key>47)&&(key<58) ) || ( (key>=96)&&(key<=105) )  )   ||   (key==8&&o!=null&&o!=''&&OldTxt[TxtObj.id]!=null&&OldTxt[TxtObj.id]!='')   )//#'s + Bksp
	{
		var Digit123=Digit[0]+Digit[1]+Digit[2];
		//alert(Digit.length+' '+n);
		switch(Digit.length)
		{
			case 1:
				o = n;
			break
			case 2:
				o = n;
			break
			case 3:
				o = n;
			break
			case 4:
				o = Digit123+Digit[3];
			break
			case 5:
				o = Digit123+'-'+Digit[3]+Digit[4];
			break
			case 6:
				o = Digit123+'-'+Digit[3]+Digit[4]+Digit[5];
			break
			case 7:
				o = Digit123+'-'+Digit[3]+Digit[4]+Digit[5]+Digit[6];
			break
			case 8:
				o='('+Digit123+')'+Digit[3]+Digit[4]+Digit[5]+'-'+Digit[6]+Digit[7];
			break
			case 9:
				o='('+Digit123+')'+Digit[3]+Digit[4]+Digit[5]+'-'+Digit[6]+Digit[7]+Digit[8];
			break
			default:
				o='('+Digit123+')'+Digit[3]+Digit[4]+Digit[5]+'-'+Digit[6]+Digit[7]+Digit[8]+Digit[9];
			break
			
		}
		
		//o=o.replace('undefined','');
		OldTxt[TxtObj.id] = o;
		TxtObj.value = o;
		return false;
	}
	else
	{
			if(OldTxt[TxtObj.id]!=null){o = OldTxt[TxtObj.id];}
	}

	//o=o.replace('undefined','');
	while (o != o.replace('NaN','')){o = o.replace('NaN','')}
	while (o != o.replace('Undefined','')){o = o.replace('Undefined','')}
	TxtObj.value = o;
	OldTxt[TxtObj.id] = TxtObj.value;
}
///////////////////////////////////////////////////////////////////////////////////////////////


//--------------------------------------------------------------------------------------
var OldTxt = new Array;
function CheckZip(e,TxtObj)
{
	var key = ( document.all ) ? window.event.keyCode : e.keyCode;
	
	var o = TxtObj.value;
	var i = TxtObj.value;	if(i.length==null){return false}
	var n = i;
	while (n != n.replace('-','')){n = n.replace('-','')}
	
	if (OldTxt[TxtObj.id]==null||OldTxt[TxtObj.id]==undefined){OldTxt[TxtObj.id]=''}
	
	if ((key<=46) && (key>=35 )||(key==9))//home, end, etc..
	{
		OldTxt[TxtObj.id] = TxtObj.value;
		return false;
	}
	
	var Digit = new Array;
	var BadDigitOffset=0;
	var a;
	for(d=0;d<n.length;d++)
	{	
		a = n.substr(d,1);
		if(a==a*1)
		{
			Digit[(d*1)-BadDigitOffset] = a;
		}
		else
		{	
			alert(n+'  '+d+'  '+BadDigitOffset+'     ');
			BadDigitOffset++;
		}
	}
	//alert(Digit);
	if (( (key>47)&&(key<58) ) || ( (key>=96)&&(key<=105) ))//numbers
	{
		//alert(Digit.length+' '+n);
		switch(Digit.length)
		{
			case 1:
				o = n;
			break
			case 2:
				o = n;
			break
			case 3:
				o = n;
			break
			case 4:
				o = n;
			break
			case 5:
				o = n;
			break
			case 6:
				o = Digit[0]+Digit[1]+Digit[2]+Digit[3]+Digit[4]+'-'+Digit[5];
			break
			case 7:
				o = Digit[0]+Digit[1]+Digit[2]+Digit[3]+Digit[4]+'-'+Digit[5]+Digit[6];
			break
			case 8:
				o = Digit[0]+Digit[1]+Digit[2]+Digit[3]+Digit[4]+'-'+Digit[5]+Digit[6]+Digit[7];
			break
			case 9:
				o = Digit[0]+Digit[1]+Digit[2]+Digit[3]+Digit[4]+'-'+Digit[5]+Digit[6]+Digit[7]+Digit[8];
			break
		}
		
		//o=o.replace('undefined','');
		OldTxt[TxtObj.id] = o;
		TxtObj.value = o;
		return false;
	}
	else
	{
		if (key==8)//backspace
		{
			var LastChar =OldTxt[TxtObj.id].substr(OldTxt[TxtObj.id].length-1)
			if(LastChar=='-')
			{
				//if the last char was a hyphen, backspace the previous char as well.
				o = OldTxt[TxtObj.id].substr(0,OldTxt[TxtObj.id].length-2);
			}
		}
		else
		{
			if(OldTxt[TxtObj.id]!=null){o = OldTxt[TxtObj.id];}
		}
	}

	//o=o.replace('undefined','');
	TxtObj.value = o;
	OldTxt[TxtObj.id] = TxtObj.value;
}
///////////////////////////////////////////////////////////////////////////////////////////////


//--------------------------------------------------------------------------------------
var OldTxt = new Array;
function CheckComma(e,TxtObj)
{
	var key = ( document.all ) ? window.event.keyCode : e.keyCode;
	
	var o = TxtObj.value;
	var i = TxtObj.value;	if(i.length==null){return false}
	var n = i;
	while (n != n.replace(',','')){n = n.replace(',','')}
	
	if (OldTxt[TxtObj.id]==null||OldTxt[TxtObj.id]==undefined){OldTxt[TxtObj.id]=''}
	
	if ((key<=46) && (key>=35 )||(key==9))//home, end, etc..
	{
		OldTxt[TxtObj.id] = TxtObj.value;
		return false;
	}
	
	var Digit = new Array;
	var BadDigitOffset=0;
	var a;
	for(d=0;d<n.length;d++)
	{	
		a = n.substr(d,1);
		if(a==a*1)
		{
			Digit[(d*1)-BadDigitOffset] = a;
			//alert(Digit[d*1]+'  '+d);
		}
		else
		{	
			alert('Invalid character: '+a);
			
			TxtObj.value = TxtObj.value.substr(0,TxtObj.value.length-1)
			while (TxtObj.value != TxtObj.value.replace('NaN','')){TxtObj.value = TxtObj.value.replace('NaN','')}
			while (TxtObj.value != TxtObj.value.replace('undefined','')){TxtObj.value = TxtObj.value.replace('undefined','')}
			//o = TxtObj.value;
			return false;
		}
	}
	
	
	
	if(key==8&&o!=null&&o!=''&&OldTxt[TxtObj.id]!=null&&OldTxt[TxtObj.id]!='')//Backspace
	{
		var LastChar = OldTxt[TxtObj.id].substr(OldTxt[TxtObj.id].length-1)
		if(LastChar==',')
		{
			//if the last char was a colon, backspace the previous char as well.
			o = OldTxt[TxtObj.id].substr(0,OldTxt[TxtObj.id].length-2);
		}
	}
	else{ if(key==8){return false;} }
	
	
	//alert(Digit);
	if (   (  ( (key>47)&&(key<58) ) || ( (key>=96)&&(key<=105) )  )   ||   (key==8&&o!=null&&o!=''&&OldTxt[TxtObj.id]!=null&&OldTxt[TxtObj.id]!='')   )//#'s + Bksp
	{
		//alert(Digit.length+' '+n);

/*		o='';
		var M;
		for(d=Digit.length;d>=0;d--)
		{
			M=d+(Digit.length%3)-1;
			d1=d-1;
			if(M%3==0&&d>1){o=','+o}
			o=Digit[d1]+o
		}*/
		switch(Digit.length)
		{
			case 1:
				o = Digit[0];			break
			case 2:
				o = Digit[0]+Digit[1];			break
			case 3:
				o = Digit[0]+Digit[1]+Digit[2];			break
			case 4:
				o = Digit[0]+','+Digit[1]+Digit[2]+Digit[3];			break							//Yeah I know its spaghetti.
			case 5:
				o = Digit[0]+Digit[1]+','+Digit[2]+Digit[3]+Digit[4];			break
			case 6:
				o = Digit[0]+Digit[1]+Digit[2]+','+Digit[3]+Digit[4]+Digit[5];			break
			case 7:
				o = Digit[0]+','+Digit[1]+Digit[2]+Digit[3]+','+Digit[4]+Digit[5]+Digit[6];			break
			case 8:
				o = Digit[0]+Digit[1]+','+Digit[2]+Digit[3]+Digit[4]+','+Digit[5]+Digit[6]+Digit[7];			break
			case 9:
				o = Digit[0]+Digit[1]+Digit[2]+','+Digit[3]+Digit[4]+Digit[5]+','+Digit[6]+Digit[7]+Digit[8];			break
			case 10:
				o = Digit[0]+','+Digit[1]+Digit[2]+Digit[3]+','+Digit[4]+Digit[5]+Digit[6]+','+Digit[7]+Digit[8]+Digit[9];			break
			case 11:
				o = Digit[0]+Digit[1]+','+Digit[2]+Digit[3]+Digit[4]+','+Digit[5]+Digit[6]+Digit[7]+','+Digit[8]+Digit[9]+Digit[10];			break
			case 12:
				o = Digit[0]+Digit[1]+Digit[2]+','+Digit[3]+Digit[4]+Digit[5]+','+Digit[6]+Digit[7]+Digit[8]+','+Digit[9]+Digit[10]+Digit[11];			break
			case 13:
				o = Digit[0]+','+Digit[1]+Digit[2]+Digit[3]+','+Digit[4]+Digit[5]+Digit[6]+','+Digit[7]+Digit[8]+Digit[9]+','+Digit[10]+Digit[11]+Digit[12];			break
			case 14:
				o = Digit[0]+Digit[1]+','+Digit[2]+Digit[3]+Digit[4]+','+Digit[5]+Digit[6]+Digit[7]+','+Digit[8]+Digit[9]+Digit[10]+','+Digit[11]+Digit[12]+Digit[13];	break
		}
		
		//o=o.replace('undefined','');
		while (o != o.replace('undefined','')){o = o.replace('undefined','')}
		OldTxt[TxtObj.id] = o;
		TxtObj.value = o;
		return false;
	}
	else
	{
			if(OldTxt[TxtObj.id]!=null){o = OldTxt[TxtObj.id];}
	}

	//o=o.replace('undefined','');
	while (o != o.replace('NaN','')){o = o.replace('NaN','')}
	while (o != o.replace('Undefined','')){o = o.replace('Undefined','')}
	TxtObj.value = o;
	OldTxt[TxtObj.id] = TxtObj.value;
}
///////////////////////////////////////////////////////////////////////////////////////////////
function Void(){}