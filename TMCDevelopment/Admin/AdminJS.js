// JavaScript Document



var DataBoxArray = new Array('TimeBox','SQLBox','GeneralBox','BidPreset','EmployeeBox','InventoryBox');
var DataTabArray = new Array('TimeTabBox','SQLTabBox','BidPresetTabBox','GeneralTabBox','EmployeeTabBox','InventoryTabBox');
var TimeBoxArray = new Array('TimeByEmp','TimeByProj','TimeByServ','TimeByTest','TimeForWorkersComp');
var TimeTabArray = new Array('TimeByEmpTab','TimeByProjTab','TimeByServTab','TimeByTestTab','TimeForWorkersCompTab');
var EmpBoxArray = new Array('EmpInfo','EmpUser','EmpAccess');
var EmpTabArray = new Array('EmpInfoTabBox','EmpUserTabBox','EmpAccessTabBox');
//Man, if only I knew then what I do now....!
var TabBGcolor = "";



var mX=0;
var mY=0;
function MouseMove(event) {
		parent.ResetLogoutTimer();

		if (!event){event = window.event;}
		mX = event.clientX;
		mY = event.clientY;
}



function Validate(This) 
{
	if((/[^\d\.]/).test(This.value)) {
		alert('Invalid Character! Only numbers are allowed');
		This.value=This.value.replace(/[^\d\.]/,'');
	}
}
   

function Replace(This) {
       This.value=This.value.replace(/[^\d\.]/,'');	
}




function numbersonly( e ) //for textboxes
{
	var unicode = e.charCode ? e.charCode : e.keyCode;
	
	//if the key isn't the backspace key or hyphen
	if( unicode != 8 && unicode != 45) {
	//if not a number or a /
		if( unicode < 47 || unicode > 57 ) {return false;} else {return true;}
	}//end if
	else {return true;}
}//end function


function EditFalse( e ) //for textboxes
{
	return false;
}//end function




function getStyle(el,styleProp)//Gets the style element from a div id
{
	var x = Gebi(el);
	if (x.currentStyle)
		var y = x.currentStyle[styleProp];
	else if (window.getComputedStyle)
		var y = document.defaultView.getComputedStyle(x,null).getPropertyValue(styleProp);
	return y;
}








var OldBkg = new Array;
function DataTabs(Box,Tab) {//Dynamic Tab Selection

	var key;
	
	for(key in DataBoxArray) {
	  //alert(key+'='+DataBoxArray[key]);
		Gebi(DataBoxArray[key]).style.display = 'none';
	}
	Gebi(Box).style.display = 'block';
	
	
	for(key in DataTabArray) {
	 //Gebi(DataTabArray[key]).style.background = '#B689A0';
	}
	Gebi('DataTabsBox').style.borderBottomColor = Gebi(Tab).style.backgroundColor;
	//Gebi(Tab).style.background = '#6D4358';
	//TabBGcolor = '#6D4358';
	
	if (Box == 'EmployeeBox'){LoadEmpList();}
	Resize();
}



var OldTimeTabBkg = new Array;
function TimeTabs(Box) { //Dynamic Tab Selection
	var key;
	
	var Tab=Box+'Tab';
	
	for(key in TimeBoxArray) {
	  //alert(key+'='+DataBoxArray[key]);
		Gebi(TimeBoxArray[key]).style.display = 'none';
	}
	Gebi(Box).style.display = 'block';
	
	
	for(key in TimeTabArray) {
	 //Gebi(DataTabArray[key]).style.background = '#B689A0';
	}
	Gebi('TimeTabsBox').style.borderBottomColor = Gebi(Tab).style.backgroundColor;
	//Gebi(Tab).style.background = '#6D4358';
	//TabBGcolor = '#6D4358';
	
	Resize();
} ///////////////////////////////////////////////////////////////////////////////



var openWindow;
var WindowContents;
function PrintTime() {
	//openWindow=
	window.open('TimeReport.asp?EmpID=1000&From='+Gebi('FromDate').value+'&To='+Gebi('ToDate').value,'TimeReport', true);
/*	
	var WindowOptions = 'scrollbars=yes, height=704, width=980, toolbar=no, location=no, directories=no, status=no, menubar=no, resizable=yes';
	//openWindow=window.open('https://www.rcstri.com/Website/TMCdevelopment/blank.html','TimeReport', WindowOptions,false);
	openWindow=window.open('TimeReport.asp?EmpID=1000&From='+Gebi('FromDate').value+'&To'+Gebi('ToDate').value,'TimeReport', WindowOptions,false);
	//WindowContents =Gebi('EmployeeTimeBox').innerHTML;
	//alert(WindowContents);

	var nonExistence = true
	while(nonExistence) {
		if(openWindow.Gebi("insideTheNewWindow")!=null){nonExistence=false;}
	}
	
	//openWindow.Gebi("insideTheNewWindow").innerHTML = WindowContents;
	//openWindow.print();
	//openWindow.focus;
*/
}


function LoadEmployeeTime(){
	Gebi('ReportFrame').src='TimeReport.asp?EmpID='+SelI('EmpList').value+'&From='+Gebi('FromDate').value+'&To='+Gebi('ToDate').value+'&SkipPrint=1';
}

function LoadWorkersCompTime(){
	Gebi('ReportFrame').src='WorkersComp.asp?EmpID=1000&From='+Gebi('wcFromDate').value+'&To='+Gebi('wcToDate').value+'&SkipPrint=1';
}

function LoadJobTime(ProjID,JobType) {
	Gebi('ProjID').value=ProjID;
	Gebi('ReportFrame').src='JobTimeReport.asp?JobType='+JobType+'&JobID='+ProjID+'&From='+Gebi('projFromDate').value+'&To='+Gebi('projToDate').value+'&SkipPrint=1';
}


//--Gets Employee List--////////////////////////////////////////////////

function LoadEmpList() {
	return true;
	var EmpArray = parent.EmployeeArray;
	var EmpLen = parent.EmployeeArray.length;
	//var EmpID = Gebi('EmployeeName').value

	Gebi('EmpList').length=null;
	
	var newOption = document.createElement("OPTION");
	Gebi('EmpList').options.add(newOption);
	newOption.value = 0;
	newOption.innerText = 'Choose Employee';
	newOption.selected = true;
	
	var newOption = document.createElement("OPTION");
	Gebi('EmpList').options.add(newOption);
	newOption.title = 'Time for Active Employees';
	newOption.value = '1000';
	newOption.innerHTML = '<b>Active Employees</b>';
	
	var newOption = document.createElement("OPTION");
	Gebi('EmpList').options.add(newOption);
	newOption.title = '9999 All Employees';
	newOption.value = '9999';
	newOption.innerText = 'All Employees';
	newOption.style.fontWeight='bold';
	
	
	var MouseEvents;
	var onclick;
	var title;
	var FName;
	var LName;
	var EmployeeList='<div style="width:100%; height:24px; float:left; clear:both;"><button id="NewEmp" style="float:left; height:22px; margin-top:4px;" onclick="NewEmployee();">Create New</button></div>';
	
	for(y=1;y< EmpLen;y++) {
		EmpID = EmpArray[y][1]; 
		FName = EmpArray[y][2];
		LName = EmpArray[y][3];
		
		MouseEvents =' onmouseover="EmpmOver(&#39;'+EmpID+'&#39;);" onmouseout="EmpmOut(&#39;'+EmpID+'&#39;); "';
		onclick = ' onclick="OpenEmployee(&#39;'+EmpID+'&#39;);" ';
		title = 'title="'+EmpID+' '+FName+' '+LName+'" '
		//alert(title);
		EmployeeList = EmployeeList + '<div id="'+EmpID+'" class="EmpListItem" '+MouseEvents+onclick+'>'+FName+' '+LName+'</div>';
		//if(parent.accessTime=='True'||EmpArray[y][1]==parent.accessEmpID)
		//{
			var newOption = document.createElement("OPTION");
			Gebi('EmpList').options.add(newOption);
			newOption.title = EmpID + ' ' + FName + ' ' + LName
			newOption.value = EmpID;
			newOption.innerText = (FName + ' ' + LName);
			//if(parent.accessEmpID==EmpArray[y][1]){newOption.selected = true;}
		//}
	} 
	
	Gebi('EmployeeDR').innerHTML = EmployeeList;

}
//-------------------------------------------------------------------------------------------------





function MouseOverTab(ID) {
    TabBGcolor = (getStyle(ID,'backgroundColor'));
	Gebi(ID).style.background= '#895671';
}
function MouseOutTab(ID) {
	Gebi(ID).style.background= TabBGcolor;
}





var OldMarTop = new Array
function MouseOverMarTop(ID) {
	return false;
	Gebi(ID).style.height=(Gebi(ID).offsetHeight-3+Gebi(ID).style.marginTop)+'px';
	OldMarTop[ID]=Gebi(ID).style.marginTop;
	Gebi(ID).style.marginTop='2px';

	//TabBGcolor = (getStyle(ID,'backgroundColor'));
	//Gebi(ID).style.background= '#895671';
}
function MouseOutMarTop(ID) {
	return false;
	Gebi(ID).style.marginTop=OldMarTop[ID];
	Gebi(ID).style.height=(Gebi(ID).offsetHeight-3-Gebi(ID).style.marginTop)+'px';
}



function MouseOverPartsAdd(This) {
	Gebi(This).style.background = '#D2FFD2';
}
function MouseOutPartsAdd(This) {
	Gebi(This).style.background = '#FFF';
}





function ShowPartEditModal() {
	Gebi('PartEditModal').style.display = 'block';
	Gebi('PartEditBox').style.display = 'block';
}

function HidePartEditModal() {
	Gebi('PartEditModal').style.display = 'none';
	Gebi('PartEditBox').style.display = 'none';
}




function ClearPartEdit() {
	Gebi('SaveExisting').style.visibility = 'hidden';
	
	Gebi('PartsEntryFoot').innerHTML = '';
	Gebi('HiddenPartID').value = '';
	Gebi('Manufacturer').options.value = '';
	Gebi('Model').value = '';
	Gebi('PartNumber').value = '';
	Gebi('Description').value = '';
	Gebi('Cost').value = '';
	Gebi('LaborValue').value = '';
	Gebi('System').options.value = '';
	Gebi('Category1').options.value = '';
	Gebi('Category2').options.value = '';
	Gebi('Cost1').value = '';
	Gebi('Cost2').value = '';
	Gebi('Cost3').value = '';
	Gebi('Cost4').value = '';
	Gebi('Cost5').value = '';
	Gebi('Cost6').value = '';
	Gebi('Vendor1').options.value = '';
	Gebi('Vendor2').options.value = '';
	Gebi('Vendor3').options.value = '';
	Gebi('Vendor4').options.value = '';
	Gebi('Vendor5').options.value = '';
	Gebi('Vendor6').options.value = '';
	Gebi('Date1').value = '';
	Gebi('Date2').value = '';
	Gebi('Date3').value = '';
	Gebi('Date4').value = '';
	Gebi('Date5').value = '';
	Gebi('Date6').value = '';
	
	Gebi('PartEditBoxHead').innerHTML = 'Edit Part';
}




function NewPart() {
	Gebi('SaveExisting').style.visibility = 'hidden';
	
	Gebi('PartsEntryFoot').innerHTML = '';
	Gebi('HiddenPartID').value = '';
	Gebi('Manufacturer').options.value = '';
	Gebi('Model').value = '';
	Gebi('PartNumber').value = '';
	Gebi('Description').value = '';
	Gebi('Cost').value = '';
	Gebi('LaborValue').value = '';
	Gebi('System').options.value = '';
	Gebi('Category1').options.value = '';
	Gebi('Category2').options.value = '';
	Gebi('Cost1').value = '';
	Gebi('Cost2').value = '';
	Gebi('Cost3').value = '';
	Gebi('Cost4').value = '';
	Gebi('Cost5').value = '';
	Gebi('Cost6').value = '';
	Gebi('Vendor1').options.value = '';
	Gebi('Vendor2').options.value = '';
	Gebi('Vendor3').options.value = '';
	Gebi('Vendor4').options.value = '';
	Gebi('Vendor5').options.value = '';
	Gebi('Vendor6').options.value = '';
	Gebi('Date1').value = '';
	Gebi('Date2').value = '';
	Gebi('Date3').value = '';
	Gebi('Date4').value = '';
	Gebi('Date5').value = '';
	Gebi('Date6').value = '';
	
	
	Gebi('Manufacturer').options.style.background = '#F3EFC5';
	Gebi('Model').style.background = '#F3EFC5';
	Gebi('PartNumber').style.background = '#F3EFC5';
	Gebi('Description').style.background = '#F3EFC5';
	Gebi('LaborValue').style.background = '#F3EFC5';
	Gebi('System').options.style.background = '#F3EFC5';
	Gebi('Category1').options.style.background = '#F3EFC5';
	Gebi('Cost').style.background = '#F3EFC5';
	Gebi('Cost1').style.background = '#F3EFC5';
	Gebi('Vendor1').options.style.background = '#F3EFC5';
	Gebi('Date1').style.background = '#F3EFC5';
	
	Gebi('PartEditBoxHead').innerHTML = 'Create A New Part';
	
	Gebi('SaveNew').style.display = 'block';
	Gebi('SaveNew').style.visibility = 'visible';
	Gebi('PartEditModal').style.display = 'block';
	Gebi('PartEditBox').style.display = 'block';
}


function SetDateToday(ID) {
	var datenow = new Date();
	var TheDate = (datenow.getMonth()+ 1 + "/" + datenow.getDate() + "/" + datenow.getFullYear());
	Gebi(ID).value = TheDate;
	Gebi(ID).style.background = '#FFF';
}

function BGColorReset(ID,Type) {
  if(Type == 'Text'){Gebi(ID).style.background = '#FFF';}
  if(Type == 'List'){Gebi(ID).options.style.background = '#FFF';}
  	
}

function ClearPartsList() { Gebi('AddPartBoxScroll').innerHTML = ''; }


function ShowPresetParts() {
	Gebi('BidPresetTimeBox').style.display = 'block';
	Gebi('BidPresetLaborBox').style.display = 'none';
	Gebi('BidPresetTextBox').style.display = 'none';
	Gebi('PreTimeTabBox').style.backgroundColor = '#6D4358';
	Gebi('PreLaborTabBox').style.backgroundColor = '#B689A0';
	Gebi('PreTextTabBox').style.backgroundColor = '#B689A0';
}

function ShowPresetLabor() {
	Gebi('BidPresetTimeBox').style.display = 'none';
	Gebi('BidPresetLaborBox').style.display = 'block';
	Gebi('BidPresetTextBox').style.display = 'none';
	Gebi('PreTimeTabBox').style.backgroundColor = '#B689A0';
	Gebi('PreLaborTabBox').style.backgroundColor = '#6D4358';
	Gebi('PreTextTabBox').style.backgroundColor = '#B689A0';
}

function ShowPresetText() {
	Gebi('BidPresetTimeBox').style.display = 'none';
	Gebi('BidPresetLaborBox').style.display = 'none';
	Gebi('BidPresetTextBox').style.display = 'block';
	Gebi('PreTimeTabBox').style.backgroundColor = '#B689A0';
	Gebi('PreLaborTabBox').style.backgroundColor = '#B689A0';
	Gebi('PreTextTabBox').style.backgroundColor = '#6D4358';
}

function BidPresetsNew() {
	Gebi('BidPresetLBottom').style.display = 'none';
	Gebi('BidPresetLTop').style.display = 'none';
	Gebi('BidPresetModal').style.display = 'block';
	Gebi('BidPresetNewBox').style.display = 'block';
	Gebi('PresetNameTxtNew').value = '';

}

function BidPresetsNewCancel() {
	
	Gebi('BidPresetModal').style.display = 'none';
	Gebi('BidPresetNewBox').style.display = 'none';

}

function BidPresetAddParts() {
	//Gebi('AddPartContainer').style.display = 'block';
	Gebi('AddPartContainer').style.display = 'block';
	Gebi('BidPresetModal').style.display = 'block';

}



function BidPresetsPartsCancel() {
	
	Gebi('BidPresetModal').style.display = 'none';
	Gebi('AddPartContainer').style.display = 'none';

}




function BidPresetAddLabor() {
	
	//Gebi('AddPartContainer').style.display = 'block';
	Gebi('AddLaborContainer').style.display = 'block';
	Gebi('BidPresetModal').style.display = 'block';

}



function BidPresetsLaborCancel() {
	
	Gebi('BidPresetModal').style.display = 'none';
	Gebi('AddLaborContainer').style.display = 'none';

}












////////////CONTACTS////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////CONTACTS////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////CONTACTS////////////////////////////////////////////////////////////////////////////////////////////////////////////


//--Closes Contacts Modal////////////////////////////////////////////////////////////////////

function ContactsModalClose() {
	
	Gebi('ContactsModal').style.display = 'none';
	Gebi('ContactsModalBox').style.display = 'none';
	
}
//--------------------------------------------------------------------------


//Adds a Contact//////////////////////////////////////////////////////////////

function AddContact() {
	Gebi('ContactsModal').style.display = 'block';
	Gebi('ContactsModalBox').style.display = 'block';
	Gebi('ContactDel').style.display = 'none';
	Gebi('ContactUpdate').style.display = 'none';
	Gebi('ContactSave').style.display = 'block';

	Gebi('txtName').value = '';
	Gebi('txtAddress').value = '';
	Gebi('txtCity').value = '';
	Gebi('txtState').value = '';
	Gebi('txtZip').value = '';
	Gebi('txtPhone1').value = '';
	Gebi('txtPhone2').value = '';
	Gebi('txtFax').value = '';
	Gebi('txtContact1').value = '';
	Gebi('txtCphone1').value = '';
	Gebi('txtEmail1').value = '';
	Gebi('txtContact2').value = '';
	Gebi('txtCphone2').value = '';
	Gebi('txtEmail2').value = '';
	Gebi('txtTax').value = '';
	Gebi('txtMU').value = '';
	Gebi('txtNotes').value = '';
	Gebi('txtWebsite').value = '';
	Gebi('txtCustomer').value = '';
	Gebi('txtVendor').value = '';
	Gebi('chkCustomer').checked = false;
	Gebi('chkVendor').checked = false;
	 
}
//-------------------------------------------------------------------------------------------------




//Contacts Modal Checkboxes///////////////////////////////////////////////////////////

function CBCust() 
{
	if (Gebi('chkCustomer').checked == true) { Gebi('txtCustomer').value = 'True'; }
	else { Gebi('txtCustomer').value = 'False'; }
}


function CBVend() 
{
	if (Gebi('chkVendor').checked == true) { Gebi('txtVendor').value = 'True'; }
	else { Gebi('txtVendor').value = 'False'; }
}
	
//-------------------------------------------------------------------------------------------------




////////////EMPLOYEES/////////////////////////////////////////////////////////////////////////////////////////
////////////EMPLOYEES/////////////////////////////////////////////////////////////////////////////////////////
////////////EMPLOYEES/////////////////////////////////////////////////////////////////////////////////////////





function EmpTabs(Box,Tab)//Dynamic Tab Selection
{
	Gebi('NewUser').style.display='none';
	var key;
	
	if(Gebi('txtEmpID').innerHTML=='') {
		alert('Choose an Employee')
		return false;
	}
	
	for(key in EmpBoxArray) {
	  //alert(key+'='+DataBoxArray[key]);
		Gebi(EmpBoxArray[key]).style.display = 'none';
	}
	Gebi(Box).style.display = 'block';
	
	
	for(key in EmpTabArray) {
	 //alert(key+'  '+EmpTabArray+'   '+EmpTabArray[key]);
	 Gebi(EmpTabArray[key]).style.background = '#B689A0';
	}
	if(Tab=='EmpAccessTabBox' && Gebi('UserModal').style.display!='none') {
		EmpTabs('EmpUser','EmpUserTabBox')
		return false
	}
	
	Resize();
	
	Gebi(Tab).style.background = '#6D4358';
	TabBGcolor = '#6D4358';
}




//Employee List Mouse Over & Out//////////////////////////////////////////////////////////////////////////////
var OldColor;
var OldBColor;
var OldFontWeight;
function EmpmOver(EmpID) {
	
	OldColor = Gebi(EmpID).style.color;
	OldBColor = Gebi(EmpID).style.backgroundColor;
	OldFontWeight = Gebi(EmpID).style.fontWeight;

	Gebi(EmpID).style.color = '#5D3348';
	Gebi(EmpID).style.backgroundColor = '#EDE0E7';
	Gebi(EmpID).style.fontWeight = 'bold';
	
}

function EmpmOut(EmpID) {

	Gebi(EmpID).style.color = OldColor;
	Gebi(EmpID).style.backgroundColor = OldBColor;
	Gebi(EmpID).style.fontWeight = OldFontWeight;
}

//-------------------------------------------------------------------------------------------------





//Prepares "Form" for a New Employee Entry //////////////////////////////////////////
function NewEmployee() {
	Gebi('txtEmpID').innerHTML = '<big><big><b> New Employee </b></big></big>'
	Gebi('txtEmpFName').value = '';
	Gebi('txtEmpLName').value = '';
	Gebi('txtEmpPosition').value = '';
	Gebi('txtEmpWage').value = '';
	Gebi('txtEmpAddress').value = '';
	Gebi('txtEmpCity').value = '';
	Gebi('txtEmpState').value = '';
	Gebi('txtEmpZip').value = '';
	Gebi('txtEmpPhone').value = '';
	Gebi('txtEmpPhone2').value = '';
	Gebi('txtEmpDCPhone').value = '';
	Gebi('txtEmpEmail').value = '';
	Gebi('txtEmpDate').value = '';
	Gebi('EmpActive').checked = true;

	//Gebi('NewEmp').style.display = 'none';
	Gebi('UpdateEmp').style.display = 'none';
	Gebi('DelEmp').style.display = 'none';
	Gebi('SaveEmp').style.display = 'block';
	Gebi('CancelEmp').style.display = 'block';
	Gebi('EmpName').innerHTML = 'Create New Employee &nbsp; &nbsp; &nbsp; ';
	
	EmpTabs('EmpInfo','EmpInfoTabBox');
}
//-------------------------------------------------------------------------------------



//Cancels New Employee Entry/////////////////////////////////////////////////////////
function CancelEmployee() {
	NewEmployee();
	Gebi('NewEmp').style.display = 'block';
	Gebi('UpdateEmp').style.display = 'none';
	Gebi('DelEmp').style.display = 'none';
	Gebi('SaveEmp').style.display = 'none';
	Gebi('CancelEmp').style.display = 'none';
	Gebi('EmpActive').checked = false;
	Gebi('txtEmpID').innerHTML = ''
	Gebi('EmpName').innerHTML = 'Please choose an employee→';
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
function Resize() {
	Gebi('TimeEmpRight').style.width=Math.abs(document.body.offsetWidth-204)+'px';
	//Gebi('TimeEmpRight').style.height=Math.abs(document.body.offsetHeight-176)+'px';
	//Gebi('TimeByEmp').style.height=Math.abs(document.body.offsetHeight-179)+'px';
	
	Gebi('ProjList').style.height=Gebi('TimeEmpRight').offsetHeight-128+'px';
	
	var H= Math.abs(document.body.offsetHeight-144+(document.body.offsetHeight*.12));
	Gebi('EmployeeBox').style.height=H+'px';
	
	H =Math.abs(H-Gebi('EmployeeHead').offsetHeight);
	Gebi('EmployeeData').style.height=H+'px';
	
	Gebi('EmpButtons1').style.width = Math.abs(Gebi('EmployeeDL').offsetWidth-28)+'px';
	
	H = Gebi('EmployeeDL').offsetHeight-32;
	Gebi('EmpInfo').style.height = Math.abs(H)+'px';
	Gebi('EmpUser').style.height = Math.abs(H)+'px';
	Gebi('EmpAccess').style.height = Math.abs(H)+'px';
	
	Gebi('EmpName').style.width = '100%';
	Gebi('EmpName').style.width = Math.abs(Gebi('EmpName').offsetWidth-320)+'px'
	//Nifty("div#EmpName,div#EmpNameShadow,div#EmpNameHighlight","medium transparent ");
	
	
	
	
	
	Gebi('EmployeeTimeBox').style.height=(Gebi('TimeEmpRight').offsetHeight/*-Gebi('ListHead').offsetHeight*/)+'px';
	
	var HeadWidth = Gebi('TimeEmpRight').offsetWidth;
	var LeftOver = HeadWidth-document.body.offsetWidth;//Gebi('TimeEmpLeft').offsetWidth;
	//Gebi('TimeEmpRight').style.width=LeftOver +'px';
	
	LeftOver = Gebi('TimeEmpRight').offsetWidth;
	/** /
	LeftOver -= Gebi('HeaderDate').offsetWidth;
	LeftOver -= Gebi('HeaderTimeIn').offsetWidth;
	LeftOver -= Gebi('HeaderTimeOut').offsetWidth;
	LeftOver -= Gebi('HeaderTotalHrs').offsetWidth;
	LeftOver -= Gebi('HeaderJobType').offsetWidth;
	LeftOver -= Gebi('HeaderSup').offsetWidth;
	LeftOver -= Gebi('HeaderJobPhase').offsetWidth;
	/**/
	LeftOver -= 17;
	//Gebi('TimeEntryHeader').innerHTML=LeftOver;
	/** /
	Gebi('HeaderJobName').style.width=Math.abs(LeftOver*.4) +'px';
	Gebi('HeaderDescription').style.width=Math.abs((LeftOver*.58)+11) +'px';
	/**/



	var TheDivs = new Array;
	TheDivs = document.getElementsByTagName('div');
	
	for(var i=1;i<TheDivs.length;i++) {
		if(TheDivs[i].id.replace('JobName','')!=TheDivs[i].id) {
			//alert(TheDivs[i].id);
			TheDivs[i].style.width = Math.abs(Gebi('HeaderJobName').offsetWidth-6);
		}
		if(TheDivs[i].id.replace('EmployeeTimeDescription','') != TheDivs[i].id) {
			//alert(TheDivs[i].id);
			TheDivs[i].style.width = Math.abs(Gebi('HeaderDescription').offsetWidth-24);
		}
	}




	
}
///////////////////////////////////////////////////////////////////////////////////////////////////