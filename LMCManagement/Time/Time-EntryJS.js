// JavaScript Document

// MouseOver&Out functions/////////////////////////////
var TextOldColor;
var BkgOldColor;

function TextMouseOver(This) {
	TextOldColor = This.style.color;
	This.style.color= '#'+parent.ProgressArray[1][6]+'';
}

function TextMouseOut(This) {
	This.style.color=TextOldColor //'#'+parent.ProgressArray[1][7]+'';	
}

function ListMouseOver(ID) {
	//Gebi('EmpTimeList'+ID+'').style.background='-webkit-gradient(linear, bottom left, top left, (rgba(231, 220, 141, 255)), to(rgba(250, 248, 226, 0))';
	if(IEver>0) {
		Gebi('EmpTimeList'+ID+'').style.background='#FAF8E2';
	}
	else
	{
		Gebi('EmpTimeList'+ID+'').style.background='-webkit-gradient(linear, left top, left bottom, color-stop(0, #FAF8E2), color-stop(1, rgba(231, 220, 141, 0)))';
	}
}

function ListMouseOut(ID) {
	Gebi('EmpTimeList'+ID+'').style.background = 'none';//'#F3EFC5';
}


//----------------------------------------



function LoadTimeEntryBox() {
/*	 Gebi('JobTimeEntryBox').innerHTML = TimeHTML;
/**/
 	alert('Hi I am from the obsolete LoadTimeEntryBox function');
	ShowTimeEntry();
}

function LoadTimeEntryList() {	
//	var EmpArray = parent.EmployeeArray;
//	var EmpLen = parent.EmployeeArray.length;
	//var EmpID = Gebi('EmployeeNameHidden').value

	//Gebi('EmpName').length=null;
	//Gebi('CrewSel').length=null;
	//Gebi('SupName').length=null;
	
	/* I moved these into the asp file directly.
	var newOption = document.createElement("OPTION");
	Gebi('EmpName').options.add(newOption);
	newOption.value = 0;
	newOption.textContent = 'Choose Employee';
	newOption.selected = true
	
	var newOption = document.createElement("OPTION");
	Gebi('CrewSel').options.add(newOption);
	newOption.value = 0;
	newOption.textContent = 'Choose Employee to add.';
	newOption.selected = true
	
	var newOption = document.createElement("OPTION");
	Gebi('SupName').options.add(newOption);
	newOption.value = 0;
	newOption.textContent = 'Approved by Supervisor:';
	newOption.selected = true
	for (var y = 1; y < EmpLen; y++) {
		if(EmpArray[y][4]=='True') {
			//alert(parent.accessTime+'  '+parent.accessEmpID);
			if(parent.accessTime=='True'||EmpArray[y][1]==parent.accessEmpID) {
				var newOption = document.createElement("OPTION");
				Gebi('EmpName').options.add(newOption);
				newOption.value = EmpArray[y][1];
				newOption.textContent = EmpArray[y][2] + ' ' + EmpArray[y][3];
				if(parent.accessEmpID==EmpArray[y][1]){newOption.selected = true; LoadEmployeeInfo();}
				
				var newOption = document.createElement("OPTION");
				Gebi('CrewSel').options.add(newOption);
				newOption.value = EmpArray[y][1];
				newOption.textContent = EmpArray[y][2] + ' ' + EmpArray[y][3];
				if(parent.accessEmpID==EmpArray[y][1]&&Crew.length==0){AddToCrew(EmpArray[y][1],EmpArray[y][2] + ' ' + EmpArray[y][3]);}
			}
	
		 var newOption = document.createElement("OPTION");
		 Gebi('SupName').options.add(newOption);
		 newOption.value = EmpArray[y][1];
		 newOption.textContent = EmpArray[y][2] + ' ' + EmpArray[y][3];
		 if(EmpID==EmpArray[y][1]){newOption.selected = true}
		}
	} 
	*/

}
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Crew=[];
function AddToCrew(EmpID,EmpName) {
	var L = Crew.length;
	Crew[L]=new Array(EmpID,EmpName);
	
	MakeCrewList();
	Gebi('CrewSel').selectedIndex=0;
}
//---------------------------------------------------------------------------

function MakeCrewList() {
	Gebi('CrewNames').innerHTML='';
	var HTML='';
	for(c=0;c<Crew.length;c++) {
		HTML+='<div style="width:100%;">'
		HTML+=	'&nbsp;<a href="javascript:Void(); XFromCrew('+c+');" class="CrewMember" title="Remove '+Crew[c][1]+'">X</a>&nbsp;&nbsp;'+Crew[c][1];
		HTML+='</div>';
	}
	Gebi('CrewNames').innerHTML=HTML;
}

function XFromCrew(Index) {
	Crew.splice(Index,1);
	MakeCrewList();
	//alert(Crew);
}


function SaveCrewTime() {
	if(Crew.length==0) {
		if(confirm('Crew box is empty. Save entry for '+SelI('EmpName').textContent+'?')) {
			if(!SaveTimeEntry(SelI('EmpName').value)) { return false; }
		}
		else {return false;}
	}
	
	for(e=0;e<Crew.length;e++) {
		var saved=SaveTimeEntry(Crew[e][0]);
		if(saved) {
		}
		else { return false; }
	}
	CancelTimeEntry(); //close the box.
	LoadEmployeeInfo(SelI('EmpName').value);
}




var mX=0;
var mY=0;
var mDownY;
var CrewOldHeight;
var BoxX;
var BoxY;
var OldBoxTop;
var OldBoxLeft;
var InnerMX;
var InnerMY;
function MouseMove(event) {
	if (!event){event = window.event;}
	mX = event.clientX;
	mY = event.clientY;
	
	if(mDownY!=null&&mY<document.body.offsetHeight-128) {
		var H=CrewOldHeight;
		H=mY-mDownY+H
		if(H<0){H=0}
		CrewNames.style.height=(H)+'px';
		//Gebi('TimeEntryHeader').innerHTML=(H);
	}
	if(BoxX!=null&&BoxY!=null&&mX>=0&&mY>=0&&mX<document.body.offsetWidth&&mY<document.body.offsetHeight-64) {
		//InnerMX = BoxX-OldBoxLeft - (Gebi('TimeEntry').offsetWidth/1);
		//InnerMY = BoxY-OldBoxTop - (Gebi('TimeEntry').offsetHeight/1);
		
		//Gebi('TimeEntryTitleBar').innerHTML=(mX+'  '+InnerMX+'  '+BoxX)
		
		Gebi('TimeEntry').style.left = (mX-InnerMX)+'px';
		Gebi('TimeEntry').style.top = (mY+InnerMY)+'px';
	}
	
	parent.ResetLogoutTimer();
}

document.onmouseup=function(){mDownY=null; BoxX=null; BoxY=null;}




function Void(){}



var SelectedJobType='Other';
function JobSelect(Type) {
	if(!accessTime){
		alert('I\'m Sorry, Time entry is disabled.  Please notify your supervisor.');
		return false;
	}
	
	if(Gebi('EmpName').selectedIndex==0) {
		alert('Please Choose an Employee.');
		return false;
	}
	Gebi('TimeEntry').style.width='576px';
	Gebi('CrewEntryList').style.display='block';
	Gebi('SaveTimeButton').style.display = 'block';
	Gebi('UpdateButton').style.display = 'none';
	Gebi('DelButton').style.display = 'none';

	Gebi('OtherName').style.display='none';
	Gebi('OtherName').style.visibility='hidden';
	Gebi('ProjectName').style.display='block';
	Gebi('ProjectName').style.visibility='visible';
	Gebi('ProjectName').focus();
	switch(Type) {
		case 'Project':
			Gebi('TimeEntryPhase').style.visibility='visible';
			Gebi('ProjectName').innerHTML=Gebi('ProjectList').innerHTML;
			Gebi('JobTimeEntryBox').style.background = '#FFAC62';
		break;

		case 'Service':
			Gebi('TimeEntryPhase').style.visibility='hidden';
			Gebi('ProjectName').innerHTML=Gebi('ServiceList').innerHTML;
			Gebi('JobTimeEntryBox').style.background = '#9393FF';
		break;

		case 'Test':
			Gebi('TimeEntryPhase').style.visibility='hidden';
			Gebi('ProjectName').innerHTML=Gebi('TestMaintList').innerHTML;
			Gebi('JobTimeEntryBox').style.background = '#FF9090';
		break;

		case 'Other':
			Gebi('OtherName').style.display='block';
			Gebi('OtherName').style.visibility='visible';
			Gebi('OtherName').focus();
			Gebi('TimeEntryPhase').style.visibility='hidden';
			Gebi('ProjectName').style.display='none';
			Gebi('ProjectName').style.visibility='hidden';
			Gebi('JobTimeEntryBox').style.background = '#FFFF9F';
		break;
	}
	
	/*		
	Gebi('JobTimeEntryBox').style.display = 'block';
	
	Gebi('JobTimeEntryBox').value = Type;
	SelectedJobType=Type;
	
	Gebi('ProjectName').selectedIndex=0;
	Gebi('OtherName').value='';
	Gebi('SupName').selectedIndex=0;
	Gebi('TimeEntryPhase').selectedIndex=0;
	*/
	//Gebi('JobDate').value='';
	Gebi('JobTimeIn').value='';
	Gebi('JobTimeOut').value='';
	Gebi('JobTotalHrs').value='';
	Gebi('JobDescriptionText').textContent='';
	OldTxt.length = null;
	
	ShowTimeEntry();
	SelectedJobType=Type;
}

function LoadJobList() {	
	
	var ProjArray = parent.ProjectArray;
	var ProjLen = parent.ProjectArray.length;

	Gebi('ProjectName').length=null;
	
	 
	 var newOption = document.createElement("OPTION");
	 Gebi('ProjectName').options.add(newOption);
	 newOption.value = '';
	 newOption.textContent = 'Please choose a project:';
	for (var y = 1; y < ProjLen; y++) {
	   var newOption = document.createElement("OPTION");
	   Gebi('ProjectName').options.add(newOption);
	   newOption.value = ProjArray[y][1];
	   newOption.textContent = ProjArray[y][2];
	 } 
	 Gebi('ProjectName').options.add(newOption);
	 newOption.value = '';
	 newOption.textContent = '---I Can\'t find my project.---';
	 newOption.id='NoProject'
	 
}

function LoadServiceList() {
	var ServeArray = parent.ServiceArray;
	var ServeLen = parent.ServiceArray.length;

	Gebi('ProjectName').length=null;
	
	 var newOption = document.createElement("OPTION");
	 Gebi('ProjectName').options.add(newOption);
	 newOption.value = '';
	 newOption.textContent = 'Please choose a service task:';
	for (var y = 1; y < ServeLen; y++) {
	   var newOption = document.createElement("OPTION");
	   Gebi('ProjectName').options.add(newOption);
	   newOption.value = ServeArray[y][1]+','+ServeArray[y][2];
	   newOption.textContent = ServeArray[y][2];
	 }
	 var newOption = document.createElement("OPTION");
	 Gebi('ProjectName').options.add(newOption);
	 newOption.value = '';
	 newOption.textContent = '---It hasn\'t been created---';
	 newOption.id='LinkToService'
}

function LoadTestMaintList() {
	var TestArray = parent.TestMaintArray;
	var TestLen = parent.TestMaintArray.length;

	Gebi('ProjectName').length=null;
	
	 var newOption = document.createElement("OPTION");
	 Gebi('ProjectName').options.add(newOption);
	 newOption.value = '';
	 newOption.textContent = 'Please choose a Testing/Maintenance task:';
	for (var y = 1; y < TestLen; y++) {
	   var newOption = document.createElement("OPTION");
	   Gebi('ProjectName').options.add(newOption);
	   newOption.value = TestArray[y][1]+','+TestArray[y][2];
	   newOption.textContent = TestArray[y][2];	   	  
	 } 
	 var newOption = document.createElement("OPTION");
	 Gebi('ProjectName').options.add(newOption);
	 newOption.value = '';
	 newOption.textContent = '---It hasn\'t been created---';
	 newOption.id='LinkToTestMaint'
}

function ShowTimeEntry() {
	Gebi('Modal').style.display='block';
	Gebi('TimeEntry').style.display = 'block';
}


function EditEmpTime(TimeID,TimeNum,JobID) {
	var JobSel = '';
	var SelIndex = 0;
	var PhaseIndex = 0;
	var SupIndex = 0;
	var JobType = Gebi('EmployeeTimeJobType'+TimeNum).textContent;
	SelectedJobType=JobType;

	if(JobType=='Other') {
		JobSel='Other';
		Gebi('ProjectName').style.display='none';
		Gebi('OtherName').style.display='block';
	}
		
	if(JobType=='Project') {
		//LoadJobList();
		JobSel=('Project');
		Gebi('ProjectName').innerHTML=Gebi('ProjectList').innerHTML;
		Gebi('ProjectName').style.display='block';
		Gebi('OtherName').style.display='none';
		for(var i=1;i<Gebi('ProjectName').length-1;i++) {
			//alert('hmmm does "'+Gebi('ProjectName')[i].value*1+'" = "'+JobID*1+'"');
			if(Gebi('ProjectName')[i].value*1==JobID*1)	{
				ShowTimeEntry();
				SelIndex = i;
				Gebi('ProjectName').selectedIndex = i;
				break;
			}
		}
		
		if(SelIndex==0) {
			alert(Gebi('EmployeeTimeJobName'+TimeNum).textContent+' is no longer an active project.  Please check with Job-Costing before modifying!');
			JobType='Project';
			Gebi('ProjectName').innerHTML+='<option value="'+JobID+'" selected >'+Gebi('EmployeeTimeJobName'+TimeNum).textContent;+'</option>';
		}
		
		populatePhases();//	alert('popeewwlaated!');
		
		for(var i=1;i<Gebi('TimeEntryPhase').length;i++) {
			if( Gebi('TimeEntryPhase')[i].value.toUpperCase()==Gebi('EmployeeTimeJobPhase'+TimeNum).textContent.toUpperCase() ) { PhaseIndex = i; break; }
		}
	}
		
	if(JobType=='Service') {
		JobSel=('Service');
		Gebi('ProjectName').innerHTML=Gebi('ServiceList').innerHTML;
		Gebi('ProjectName').style.display='block';
		Gebi('OtherName').style.display='none';
		for(var i=1;i<Gebi('ProjectName').length;i++) {
			if( Gebi('ProjectName')[i].textContent==Gebi('EmployeeTimeJobName'+TimeNum).textContent) { SelIndex = i; break; }
		}
		if(SelIndex==0) {
			alert(Gebi('EmployeeTimeJobName'+TimeNum).textContent+' is no longer in the service list.');
			JobType='Other';
		}
	}
	
	
	if(JobType=='Test') {
		JobSel=('Test');
		Gebi('ProjectName').innerHTML=Gebi('TestMaintList').innerHTML;
		Gebi('ProjectName').style.display='block';
		Gebi('OtherName').style.display='none';
		for(var i=1;i<Gebi('ProjectName').length;i++) {
			if( Gebi('ProjectName')[i].textContent==Gebi('EmployeeTimeJobName'+TimeNum).textContent) { SelIndex = i; break; }
		}
		if(SelIndex==0) {
			alert(Gebi('EmployeeTimeJobName'+TimeNum).textContent+' is no longer in the Testing / Maintenance list.');
			JobType='Other';
		}
	}
	
	for(var i=1; i< Gebi('SupName').length; i++) {
		if(Gebi('SupName')[i].value==Gebi('EmployeeTimeSupHidden'+TimeNum).value) { SupIndex=i; break; }
	}
	
	
	JobSelect(JobSel);
	Gebi('ProjectName').selectedIndex = SelIndex;
	CancelTimeEntry();
	
	Gebi('TimeEntryPhase').selectedIndex = PhaseIndex;
	//SelI('TimeEntryPhase').innerHTML=Gebi('EmployeeTimeJobPhase'+TimeNum).textContent;;
	Gebi('SupName').selectedIndex = SupIndex;
	var d8=Gebi('EmployeeTimeDate'+TimeNum).textContent;
	Gebi('JobDate').value = d8;
	Gebi('JobTimeIn').value = Gebi('EmployeeTimeTimeIn'+TimeNum).textContent;
	Gebi('JobTimeOut').value = Gebi('EmployeeTimeTimeOut'+TimeNum).textContent;
	Gebi('JobTotalHrs').value = Gebi('EmployeeTimeTotalHrs'+TimeNum).textContent;
	Gebi('JobDescriptionText').textContent = Gebi('EmployeeTimeDescription'+TimeNum).textContent;
	Gebi('OtherName').value = Gebi('EmployeeTimeJobName'+TimeNum).textContent;
	
	Gebi('TimeEntry').style.width='352px';
	Gebi('CrewEntryList').style.display='none';
	Gebi('TimeEntry').value = TimeID;
	Gebi('SaveTimeButton').style.display = 'none';
	Gebi('DelButton').style.display = 'block';
	Gebi('UpdateButton').style.display = 'block';
	Gebi('TimeEntryJobStyle').style.display = 'block';
	
	ShowTimeEntry();
}




function HideTime(cb) {
	if(cb.id=='HideUnlocked'&&cb.checked) {Gebi('HideLocked').checked=false;}
	else if(cb.id=='HideLocked'&&cb.checked) {Gebi('HideUnlocked').checked=false;}
	
	LoadEmployeeTime();
}




function ShowDropDownMenu(id) {
	//Gebi('TimeEditProjectName').style.display = 'block';
	Gebi(id).style.display = 'none';
}

//Right Click Menu//////////////////////////////////////////////////////////////////////////////////////////////////////

var x,y;
var sMenuID = ''; 

//if(!document.all){document.captureEvents(Event.MOUSEMOVE);}
document.onmousemove=getMousePos;

function getMousePos(e) {
  if(document.all){x=event.x+document.body.scrollLeft;y=event.y+document.body.scrollTop;}
  else{x=e.pageX;y=e.pageY;}
}




function RcMenu(e,MenuID,SelectedID) {
	if (e.button==2 || e.button==3) 
	{
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function InsertTimeIn(DivID,TimeValue) {	
	var menu = Gebi('TimeDropDownList1').style;
	var menu1 = Gebi('TimeEntryTimeInSelect').style;

	var TimeValue1 = TimeValue.replace(',',':')
	Gebi(DivID).textContent = TimeValue1;
	Gebi(DivID).value = TimeValue1;
	
	menu.display="none";
	menu1.display="block";
	
	GetTotalHrs();
}

function InsertTimeOut(DivID,TimeValue) {	
	var menu1 = Gebi('TimeDropDownList2').style;
	var menu2 = Gebi('TimeEntryTimeOutSelect').style;

	var TimeValue1 = TimeValue.replace(',',':')
	Gebi(DivID).textContent = TimeValue1;
	Gebi(DivID).value = TimeValue1;
	
	menu2.display="block";
	menu1.display="none";
	
	GetTotalHrs();
}

function EditTimeIn(DivID,TimeValue,DivNum) {

	var menu = Gebi('TimeEditDropDownList1').style;
	var menu1 = Gebi('TimeEditTimeInSelect').style;

	var TimeValue1 = TimeValue.replace(',',':')
	Gebi(DivID).textContent = TimeValue1;
	Gebi(DivID).value = TimeValue1;
	
	menu.display="none";
	menu1.display="block";
	
	GetTotalEditHrs(DivNum);
}

function EditTimeOut(DivID,TimeValue,DivNum) {	
	var menu1 = Gebi('TimeEditDropDownList2').style;
	var menu2 = Gebi('TimeEditTimeOutSelect').style;

	var TimeValue1 = TimeValue.replace(',',':')
		
	Gebi(DivID).textContent = TimeValue1;
	Gebi(DivID).value = TimeValue1;
	
	menu2.display="block";
	menu1.display="none";
	
	GetTotalEditHrs(DivNum);

}


function GetTotalHrs() {
	if(Gebi('JobTimeIn').value.length!=5||Gebi('JobTimeOut').value.length!=5){return false;}
	
	var InValue = Gebi('JobTimeIn').value;
	var OutValue = Gebi('JobTimeOut').value;
	var InValueHr = InValue.replace(':','').substr(0,2);
	var InValueMin = InValue.replace(':','').substr(2,2);
	var OutValueHr = OutValue.replace(':','').substr(0,2);
	var OutValueMin = OutValue.replace(':','').substr(2,2);
	
	var	InDecimalMins = InValueMin/60;
	var InDecimalHrs = InValueHr*1;
	var InDecimalValue =  InDecimalHrs + InDecimalMins;
	
	
	var OutDecimalMins =  OutValueMin/60;
	var OutDecimalHrs = OutValueHr*1;
	var OutDecimalValue =  OutDecimalHrs + OutDecimalMins;
	
	//alert(OutDecimalValue+'-'+InDecimalValue);
	var TotalTimeValue = OutDecimalValue - InDecimalValue;

	//var Debug=OutDecimalHrs+':'+OutDecimalMins+' '+InDecimalHrs+':'+InDecimalMins;
	var Debug=OutDecimalHrs+':'+OutDecimalMins+' '+InDecimalHrs+':'+InDecimalMins;
	//Gebi('TimeEntryTitleBar').innerHTML=Debug;
	//alert(InDecimalMins+" "+OutDecimalMins);

	if(OutValue=="") {
		Gebi('JobTotalHrs').textContent = '0';
	}
	
	if(TotalTimeValue<0) {
		TotalTimeValue+=24;
		alert('Time out is after midnight: '+OutValue+'. For a total shift of '+Math.round(TotalTimeValue*100)/100+' hours!');
	}
	TotalTimeValue = Math.round(TotalTimeValue*100)/100;
	
	if( ( (TotalTimeValue*1)!=TotalTimeValue) ||  (TotalTimeValue==0)  ) {
		TotalTimeValue=0;
		//JobTimeOut.focus();
		//JobTimeOut.select();
	}
	
	//Gebi('JobTotalHrs').textContent = TotalTimeValue;
	Gebi('JobTotalHrs').value = TotalTimeValue;
}



function DropDownTimeClose() {
//	Gebi('TimeDropDownList1').style.display="none";
//	Gebi('TimeDropDownList2').style.display="none";
	
//	Gebi('TimeEntryTimeInSelect').style.display="block";
//	Gebi('TimeEntryTimeOutSelect').style.display="block";

	
}

function EditDropDownClose() {
//	Gebi('TimeEditDropDownList1').style.display="none";
//	Gebi('TimeEditDropDownList2').style.display="none";
	
//	Gebi('TimeEditTimeInSelect').style.display="block";
//	Gebi('TimeEditTimeOutSelect').style.display="block";

}


function SelectProject() {
	/*
	var PN = Gebi('ProjectName');
	if(PN[PN.selectedIndex].id=='LinkToService') {
		var ServiceTab=parent.Gebi('ServiceIframe').contentWindow.document
		ServiceTab.getElementById('NewTaskButton').onclick();
		PN.selectedIndex=0;
		return false;
	}
	if(PN[PN.selectedIndex].id=='LinkToTestMaint') {
		PN.selectedIndex=0;
		return false;
	}
	if(PN[PN.selectedIndex].id=='NoProject'	) {
		var UNam=parent.accessUser;
		if(UNam=='Alice' || UNam=='Joni' || UNam=='Faith'){UNam='Aunt '+UNam;} else {UNam='Uncle '+UNam;}
		alert('Projects must be active before clocking time.\nPlease check with Sales to be sure the project is activated.\n\nThanks, '+UNam+'. We sure appreciate you.');

		PN.selectedIndex=0;
		return false;
	}
	*/
	Gebi('OtherName').value=SelI('ProjectName').textContent;
	Gebi('SaveTimeButton').disabled=(Gebi('ProjectName').selectedIndex==0);
	
	populatePhases();
/*	*/
}


function CancelTimeEntry() {		
	//Gebi('JobTimeEntryBox').innerHTML = "";
	//Gebi('EmployeeTimeEditBox').innerHTML = "";
	Gebi('TimeEntry').style.display = 'none';
	//Gebi('NewTimeButton').style.display = 'block';
	//Gebi('EmployeeTimeEditBox').style.display = 'none';
	
	/*Gebi('JobTimeEntryBox').style.background = '#FFF';
	Gebi('JobTab').style.background = '#FFF';
	Gebi('ServiceTab').style.background = '#FFF';
	Gebi('OtherTab').style.background = '#FFF';
	/**/	
	Gebi('Modal').style.display = 'none';
}



var OldTxt = new Array;
function CheckTime(e,TxtObj) {
	var key = ( document.all ) ? window.event.keyCode : e.keyCode;
	var i = TxtObj.value; if(i.length==null){return false}
	var n = i*1;
	var o = TxtObj.value;
	if (OldTxt[TxtObj.id]==null){OldTxt[TxtObj.id]=''}
	if (OldTxt[TxtObj.id]==undefined){OldTxt[TxtObj.id]=''}
	
	if(key==13) {//Enter Key
		if(TxtObj.id=='JobTimeIn') {
			Gebi('JobTimeOut').focus();
			return false;
		}
		if(TxtObj.id=='JobTimeOut') {
			Gebi('JobDescriptionText').focus();
			return false;
		}/**/
	}
	
	
	if ((key<=46) && (key>=35 )) { //home, end, etc..
		OldTxt[TxtObj.id] = TxtObj.value;
		return false;
	}
	
	if (( (key>47)&&(key<58) ) || ( (key>=96)&&(key<=105) )){ //numbers
		if(i.length<=2) {
			if((i=='00')||(i=='01')||(i=='02')){o=i+':'}
			if(n>=3 && n<=9){o='0'+n+':';}
			if(n>=10){o=i+':';}
			if(n>=24 && n<=25){o='02:'+(n-20);}
			if(n>=26){o='2';}
		}
	
		if(i.length>=4) {
			var h = i.split(':')[0];
			var m = i.split(':')[1];
			if(m!=null) {
				if(m.length==1&&m>=6){o=h+':'}
			}
		}
	
		OldTxt[TxtObj.id] = o;
		TxtObj.value = o;
		return false;
	}
	else {
		if (key==8) { //backspace
			if(OldTxt[TxtObj.id].substr(OldTxt[TxtObj.id].length-1)==':') {
				//if the last char was a semicolon, backspace the previous char as well.
				o = OldTxt[TxtObj.id].substr(0,OldTxt[TxtObj.id].length-2);
			}
		}
		else {
			if (key!=9){o = OldTxt[TxtObj.id];}
		}
	}

	TxtObj.value = o;
	OldTxt[TxtObj.id] = TxtObj.value;
}


function Resizer() {
	Gebi('EmployeeTimeBox').style.height=(Gebi('RightBox').offsetHeight-Gebi('ListHead').offsetHeight)+'px';
	
	Gebi('TimeEntryHeader').style.width =Math.abs(document.body.offsetWidth-37)+'px';
	Gebi('TimeEntryHeader').style.fontSize =(Math.abs(Gebi('TimeEntryHeader').offsetHeight*.8))+'px';

	var HeadWidth = Gebi('TimeEntryHeader').offsetWidth;
	var LeftOver = HeadWidth-Gebi('LeftBox').offsetWidth;
	Gebi('RightBox').style.width=LeftOver +'px';
	
	LeftOver = Gebi('RightBox').offsetWidth;
	LeftOver -= Gebi('HeaderDate').offsetWidth;
	LeftOver -= Gebi('HeaderTimeIn').offsetWidth;
	LeftOver -= Gebi('HeaderTimeOut').offsetWidth;
	LeftOver -= Gebi('HeaderTotalHrs').offsetWidth;
	LeftOver -= Gebi('HeaderJobType').offsetWidth;
	LeftOver -= Gebi('HeaderSup').offsetWidth;
	LeftOver -= Gebi('HeaderJobPhase').offsetWidth;
	LeftOver -= 17;
	//Gebi('TimeEntryHeader').innerHTML=LeftOver;
	//Gebi('HeaderJobName').style.width=Math.abs(LeftOver*.4) +'px';
	//Gebi('HeaderDescription').style.width=Math.abs((LeftOver*.58)-24) +'px';
	
	
	var Rows=document.getElementsByClassName('EmployeeTimeList');
	for(r=0;r<Rows.length;r++) { Rows[r].style.width=Gebi('ListHead').offsetWidth+('px'); }
	

	var Divs = new Array;
	Divs = document.getElementsByTagName('div');
	
	/** /
	for(var i=1;i<Divs.length;i++) {
		if(Divs[i].id.indexOf('JobName','')!=-1) { Divs[i].style.width = Math.abs(Gebi('HeaderJobName').offsetWidth-6); }
		if(Divs[i].id.replace('EmployeeTimeDescription','') != Divs[i].id) { Divs[i].style.width = Math.abs(Gebi('HeaderDescription').offsetWidth-6);}
	}
	/**/


}

function Gebi(ID){return document.getElementById(ID)}