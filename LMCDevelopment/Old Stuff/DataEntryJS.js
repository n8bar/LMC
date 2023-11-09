//JavaScriptDocument



var DataBoxArray=new Array('PartsBox','LaborBox','GeneralBox','BidPreset');
var DataTabArray=new Array('PartsTabBox','LaborTabBox','BidPresetTabBox','GeneralTabBox');

var TabBGcolor="";





function Validate(This)
{
	if((/[^\d\.]/).test(This.value))
	{
		alert('InvalidCharacter!Onlynumbersareallowed');
		This.value=This.value.replace(/[^\d\.]/,'');
	}
}


function Replace(This)
{
This.value=This.value.replace(/[^\d\.]/,'');	
}




function numbersonly(e)//fortextboxes
{
	var unicode=e.charCode?e.charCode:e.keyCode;
	
	//ifthekeyisn'tthebackspacekeyorhyphen
	if(unicode!=8&&unicode!=45)
	{
	//ifnotanumberora/
		if(unicode<47||unicode>57){return false;}else{return true;}
	}//endif
	else{return true;}
}//endfunction 


function EditFalse(e)//fortextboxes
{
	return false;
}//endfunction 




function getStyle(el,styleProp)//Getsthestyleelementfromadivid
{
	var x=document.getElementById(el);
	if(x.currentStyle)
		var y=x.currentStyle[styleProp];
	else if(window.getComputedStyle)
		var y=document.defaultView.getComputedStyle(x,null).getPropertyValue(styleProp);
	return y;
}









function DataTabs(Box,Tab)//DynamicTabSelection
{
	var key;
	
	for(key in  DataBoxArray)
	{
	//alert(key+'='+DataBoxArray[key]);
		Gebi(DataBoxArray[key]).style.display='none';
	}
	Gebi(Box).style.display='block';
	
	
	for(key in  DataTabArray)
	{
	Gebi(DataTabArray[key]).style.background='#B689A0';
	}
	Gebi(Tab).style.background='#6D4358';
	TabBGcolor='#6D4358';
	
	if(Box=='EmployeeBox'){LoadLists();}
	Resize();
}







function LoadLists()//LoadsAllOfTheLists
{
	LoadEmpList();
	return false;
	//SystemTypeLists-------------------------------------
	var SysListArray=parent.SystemsListArray;
	var SysLen=parent.SystemsListArray.length;
	
	SystemTypes.length=null;
	
	for(var y=1;y<SysLen;y++)
	{
	var newOption=document.createElement("OPTION");
	SystemTypes.options.add(newOption);
	newOption.value=SysListArray[y][0];
	newOption.innerText=SysListArray[y][1];
	}
	
	SystemTypesNew.length=null;
	
	for(var y=1;y<SysLen;y++)
	{
	var newOption=document.createElement("OPTION");
	SystemTypesNew.options.add(newOption);
	newOption.value=SysListArray[y][0];
	newOption.innerText=SysListArray[y][1];
	}	
	
}

//--GetsEmployeeList--////////////////////////////////////////////////

function LoadEmpList()
{
	//alert('HereIam');
	//DataTabs('EmployeeBox','EmployeeTabBox');
	
	var EmpArray=parent.EmployeeArray;
	var EmpLen=parent.EmployeeArray.length;
	var EmpList='<divstyle="width:100%"><buttonid="NewEmp"style="float:left;height:22px;margin-top:4px;"onclick="NewEmployee();">CreateNew</button></div>';
	var MouseEvents;
	var onclick;
	var EmpID;
	var FName;
	var LName;
	
	for(var y=1;y<EmpLen;y++)
	{
		EmpID=EmpArray[y][1];
		FName=EmpArray[y][2];
		LName=EmpArray[y][3];
		
		MouseEvents='onmouseover="EmpmOver(&#39;'+EmpID+'&#39;);"onmouseout="EmpmOut(&#39;'+EmpArray[y][1]+'&#39;);"';
		onclick='onclick="OpenEmployee(&#39;'+EmpID+'&#39;);"';
		EmpList=EmpList+'<divid="'+EmpID+'"class="EmpListItem"'+MouseEvents+onclick+'>'+FName+''+LName+'</div>';
	}
	
	
	
	//alert(EmpList);
	//document.getElementById('EmployeeDR').innerHTML=EmpList;
	
}
//-------------------------------------------------------------------------------------------------











function MouseOverTab(ID)
{
TabBGcolor=(getStyle(ID,'backgroundColor'));
	Gebi(ID).style.background='#895671';
}
function MouseOutTab(ID)
{
	Gebi(ID).style.background=TabBGcolor;
}





function MouseOverPartsAdd(This)
{
	Gebi(This).style.background='#D2FFD2';
}
function MouseOutPartsAdd(This)
{
	Gebi(This).style.background='#FFF';
}





function ShowPartEditModal()
{
	Gebi('PartEditModal').style.display='block';
	Gebi('PartEditBox').style.display='block';
}

function HidePartEditModal()
{
	Gebi('PartEditModal').style.display='none';
	Gebi('PartEditBox').style.display='none';
}








function ClearPartEdit()
{
	Gebi('SaveExisting').style.visibility='hidden';
	
	Gebi('PartsEntryFoot').innerHTML='';
	Gebi('HiddenPartID').value='';
	Gebi('Manufacturer').options.value='';
	Gebi('Model').value='';
	Gebi('PartNumber').value='';
	Gebi('Description').value='';
	Gebi('Cost').value='';
	Gebi('LaborValue').value='';
	Gebi('System').options.value='';
	Gebi('Category1').options.value='';
	Gebi('Category2').options.value='';
	Gebi('Cost1').value='';
	Gebi('Cost2').value='';
	Gebi('Cost3').value='';
	Gebi('Cost4').value='';
	Gebi('Cost5').value='';
	Gebi('Cost6').value='';
	Gebi('Vendor1').options.value='';
	Gebi('Vendor2').options.value='';
	Gebi('Vendor3').options.value='';
	Gebi('Vendor4').options.value='';
	Gebi('Vendor5').options.value='';
	Gebi('Vendor6').options.value='';
	Gebi('Date1').value='';
	Gebi('Date2').value='';
	Gebi('Date3').value='';
	Gebi('Date4').value='';
	Gebi('Date5').value='';
	Gebi('Date6').value='';
	

	
	

	
	Gebi('PartEditBoxHead').innerHTML='Edit Part';
	Gebi('SubPartsBtn').style.display='block';
	Gebi('SubPartsNote').style.display='none';
	IncludedPartsList();
}




function NewPart()
{
	Gebi('SaveExisting').style.visibility='hidden';
	
	Gebi('PartsEntryFoot').innerHTML='';
	Gebi('HiddenPartID').value='';
	Gebi('Manufacturer').selectedIndex=0;
	Gebi('Model').value='';
	Gebi('PartNumber').value='';
	Gebi('Description').value='';
	Gebi('Cost').value='';
	Gebi('LaborValue').value='';
	Gebi('System').selectedIndex=0;
	Gebi('Category1').selectedIndex=0;
	Gebi('Category2').selectedIndex=0;
	Gebi('Cost1').value='';
	Gebi('Cost2').value='';
	Gebi('Cost3').value='';
	Gebi('Cost4').value='';
	Gebi('Cost5').value='';
	Gebi('Cost6').value='';
	Gebi('Vendor1').selectedIndex=0;
	Gebi('Vendor2').selectedIndex=0;
	Gebi('Vendor3').selectedIndex=0;
	Gebi('Vendor4').selectedIndex=0;
	Gebi('Vendor5').selectedIndex=0;
	Gebi('Vendor6').selectedIndex=0;
	Gebi('Date1').value='';
	Gebi('Date2').value='';
	Gebi('Date3').value='';
	Gebi('Date4').value='';
	Gebi('Date5').value='';
	Gebi('Date6').value='';
	
	
	/*document.getElementById('Manufacturer').options.style.background='#F3EFC5';
	Gebi('Model').style.background='#F3EFC5';
	Gebi('PartNumber').style.background='#F3EFC5';
	Gebi('Description').style.background='#F3EFC5';
	Gebi('LaborValue').style.background='#F3EFC5';
	Gebi('System').options.style.background='#F3EFC5';
	Gebi('Category1').options.style.background='#F3EFC5';
	Gebi('Cost').style.background='#F3EFC5';
	Gebi('Cost1').style.background='#F3EFC5';
	Gebi('Vendor1').options.style.background='#F3EFC5';
	Gebi('Date1').style.background='#F3EFC5';
	/**/
	Gebi('PartEditBoxHead').innerHTML='Create A New Part';
	
	
	Gebi('SaveNew').style.display='block';
	Gebi('SaveNew').style.visibility='visible';
	Gebi('PartEditModal').style.display='block';
	Gebi('PartEditBox').style.display='block';
	Gebi('SubPartsBtn').style.display='none';
	Gebi('SubPartsNote').style.display='block';
}
function SubParts()
{
	//if(confirm('The Current Part Must Be saved before adding sub-parts'))
	//{
		IncludedPartsList();
		Gebi('IncludePartsBox').style.display='block';
	//}
}


function SetDateToday(ID)
{
	var datenow=new Date();
	var TheDate=(datenow.getMonth()+1+"/"+datenow.getDate()+"/"+datenow.getFullYear());
	Gebi(ID).value=TheDate;
	Gebi(ID).style.background='#FFF';
}





function ClearPartsList()
{
document.getElementById('AddPartBoxScroll').innerHTML='';
	
}















function ShowPresetParts()
{
	Gebi('BidPresetPartsBox').style.display='block';
	Gebi('BidPresetLaborBox').style.display='none';
	Gebi('BidPresetTextBox').style.display='none';
	Gebi('PrePartsTabBox').style.backgroundColor='#6D4358';
	Gebi('PreLaborTabBox').style.backgroundColor='#B689A0';
	Gebi('PreTextTabBox').style.backgroundColor='#B689A0';
}

function ShowPresetLabor()
{
	Gebi('BidPresetPartsBox').style.display='none';
	Gebi('BidPresetLaborBox').style.display='block';
	Gebi('BidPresetTextBox').style.display='none';
	Gebi('PrePartsTabBox').style.backgroundColor='#B689A0';
	Gebi('PreLaborTabBox').style.backgroundColor='#6D4358';
	Gebi('PreTextTabBox').style.backgroundColor='#B689A0';
}

function ShowPresetText()
{
	Gebi('BidPresetPartsBox').style.display='none';
	Gebi('BidPresetLaborBox').style.display='none';
	Gebi('BidPresetTextBox').style.display='block';
	Gebi('PrePartsTabBox').style.backgroundColor='#B689A0';
	Gebi('PreLaborTabBox').style.backgroundColor='#B689A0';
	Gebi('PreTextTabBox').style.backgroundColor='#6D4358';
}





function BidPresetsNew()
{
	Gebi('BidPresetLBottom').style.display='none';
	Gebi('BidPresetLTop').style.display='none';
	Gebi('BidPresetModal').style.display='block';
	Gebi('BidPresetNewBox').style.display='block';
	Gebi('PresetNameTxtNew').value='';

}

function BidPresetsNewCancel()
{
	
	Gebi('BidPresetModal').style.display='none';
	Gebi('BidPresetNewBox').style.display='none';

}


function BidPresetAddParts()
{
	
	//document.getElementById('AddPartContainer').style.display='block';
	Gebi('AddPartContainer').style.display='block';
	Gebi('BidPresetModal').style.display='block';

}



function BidPresetsPartsCancel()
{
	
	Gebi('BidPresetModal').style.display='none';
	Gebi('AddPartContainer').style.display='none';

}




function BidPresetAddLabor()
{
	
	//document.getElementById('AddPartContainer').style.display='block';
	Gebi('AddLaborContainer').style.display='block';
	Gebi('BidPresetModal').style.display='block';

}



function BidPresetsLaborCancel()
{
	
	Gebi('BidPresetModal').style.display='none';
	Gebi('AddLaborContainer').style.display='none';

}












////////////CONTACTS////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////CONTACTS////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////CONTACTS////////////////////////////////////////////////////////////////////////////////////////////////////////////


//--ClosesContactsModal////////////////////////////////////////////////////////////////////

function ContactsModalClose()
{
	
	Gebi('ContactsModal').style.display='none';
	Gebi('ContactsModalBox').style.display='none';
	
}
//--------------------------------------------------------------------------


//AddsaContact//////////////////////////////////////////////////////////////

function AddContact()
{
	Gebi('ContactsModal').style.display='block';
	Gebi('ContactsModalBox').style.display='block';
	Gebi('ContactDel').style.display='none';
	Gebi('ContactUpdate').style.display='none';
	Gebi('ContactSave').style.display='block';

	Gebi('txtName').value='';
	Gebi('txtAddress').value='';
	Gebi('txtCity').value='';
	Gebi('txtState').value='';
	Gebi('txtZip').value='';
	Gebi('txtPhone1').value='';
	Gebi('txtPhone2').value='';
	Gebi('txtFax').value='';
	Gebi('txtContact1').value='';
	Gebi('txtCphone1').value='';
	Gebi('txtEmail1').value='';
	Gebi('txtContact2').value='';
	Gebi('txtCphone2').value='';
	Gebi('txtEmail2').value='';
	Gebi('txtTax').value='';
	Gebi('txtMU').value='';
	Gebi('txtNotes').value='';
	Gebi('txtWebsite').value='';
	Gebi('txtCustomer').value='';
	Gebi('txtVendor').value='';
	Gebi('chkCustomer').checked=false;
	Gebi('chkVendor').checked=false;
	
}
//-------------------------------------------------------------------------------------------------




//ContactsModalCheckboxes///////////////////////////////////////////////////////////

function CBCust()
{
	if(document.getElementById('chkCustomer').checked==true){document.getElementById('txtCustomer').value='True';}
	else{document.getElementById('txtCustomer').value='False';}
}


function CBVend()
{
	if(document.getElementById('chkVendor').checked==true){document.getElementById('txtVendor').value='True';}
	else{document.getElementById('txtVendor').value='False';}
}
	
//-------------------------------------------------------------------------------------------------




////////////EMPLOYEES/////////////////////////////////////////////////////////////////////////////////////////
////////////EMPLOYEES/////////////////////////////////////////////////////////////////////////////////////////
////////////EMPLOYEES/////////////////////////////////////////////////////////////////////////////////////////





function EmpTabs(Box,Tab)//DynamicTabSelection
{
	Gebi('NewUser').style.display='none';
	var key;
	
	if(document.getElementById('txtEmpID').innerHTML=='')
	{
		alert('ChooseanEmployee')
		return false;
	}
	
	for(key in EmpBoxArray)
	{
	//alert(key+'='+DataBoxArray[key]);
		Gebi(EmpBoxArray[key]).style.display='none';
	}
	Gebi(Box).style.display='block';
	
	
	for(key in EmpTabArray)
	{
	//alert(key+''+EmpTabArray+''+EmpTabArray[key]);
	Gebi(EmpTabArray[key]).style.background='#B689A0';
	}
	if(Tab=='EmpAccessTabBox'&&document.getElementById('UserModal').style.display!='none')
	{
		EmpTabs('EmpUser','EmpUserTabBox')
		return false
	}
	
	Resize();
	
	Gebi(Tab).style.background='#6D4358';
	TabBGcolor='#6D4358';
}




//EmployeeListMouseOver&Out//////////////////////////////////////////////////////////////////////////////
var OldColor;
var OldBColor;
var OldFontWeight;
function EmpmOver(EmpID)
{
	
	OldColor=document.getElementById(EmpID).style.color;
	OldBColor=document.getElementById(EmpID).style.backgroundColor;
	OldFontWeight=document.getElementById(EmpID).style.fontWeight;

	Gebi(EmpID).style.color='#5D3348';
	Gebi(EmpID).style.backgroundColor='#EDE0E7';
	Gebi(EmpID).style.fontWeight='bold';
	
}

function EmpmOut(EmpID)
{

	Gebi(EmpID).style.color=OldColor;
	Gebi(EmpID).style.backgroundColor=OldBColor;
	Gebi(EmpID).style.fontWeight=OldFontWeight;
}

//-------------------------------------------------------------------------------------------------





//Prepares"Form"foraNewEmployeeEntry//////////////////////////////////////////
function NewEmployee()
{
	Gebi('txtEmpID').innerHTML='<big><big><b>NewEmployee</b></big></big>'
	Gebi('txtEmpFName').value='';
	Gebi('txtEmpLName').value='';
	Gebi('txtEmpPosition').value='';
	Gebi('txtEmpWage').value='';
	Gebi('txtEmpAddress').value='';
	Gebi('txtEmpCity').value='';
	Gebi('txtEmpState').value='';
	Gebi('txtEmpZip').value='';
	Gebi('txtEmpPhone').value='';
	Gebi('txtEmpPhone2').value='';
	Gebi('txtEmpDCPhone').value='';
	Gebi('txtEmpEmail').value='';
	Gebi('txtEmpDate').value='';
	Gebi('EmpActive').checked=true;

	Gebi('NewEmp').style.display='none';
	Gebi('UpdateEmp').style.display='none';
	Gebi('DelEmp').style.display='none';
	Gebi('SaveEmp').style.display='block';
	Gebi('CancelEmp').style.display='block';
	Gebi('EmpName').innerHTML='CreateNewEmployee&nbsp;&nbsp;&nbsp;';
	
	EmpTabs('EmpInfo','EmpInfoTabBox');
}
//-------------------------------------------------------------------------------------



//CancelsNewEmployeeEntry/////////////////////////////////////////////////////////
function CancelEmployee()
{
	NewEmployee();
	Gebi('NewEmp').style.display='block';
	Gebi('UpdateEmp').style.display='none';
	Gebi('DelEmp').style.display='none';
	Gebi('SaveEmp').style.display='none';
	Gebi('CancelEmp').style.display='none';
	Gebi('EmpActive').checked=false;
	Gebi('txtEmpID').innerHTML=''
	Gebi('EmpName').innerHTML='Pleasechooseanemployee’!';
	Gebi('EmpInfo').style.display='none';
	Gebi('EmpAccess').style.display='none';
}
//------------------------------------------------------------------------------------

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
function Resize()
{
	document.body.height=Math.abs(document.body.offsetHeight-64)+'px';
	//Nifty("div#EmpName,div#EmpNameShadow,div#EmpNameHighlight","mediumtransparent");
}
///////////////////////////////////////////////////////////////////////////////////////////////////