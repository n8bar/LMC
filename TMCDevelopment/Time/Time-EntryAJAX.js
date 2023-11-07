// JavaScript Document   AJAX CONTROLS



//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////
var HttpText;
function GetXmlHttpObject() {
	var xmlHttp=null;
	try { xmlHttp=new XMLHttpRequest(); } // Firefox, Opera 8.0+, Safari
	catch (e) {  // Internet Explorer
		try { xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e) { xmlHttp=new ActiveXObject("Microsoft.XMLHTTP"); }
	}
	if (xmlHttp==null) {
		alert ("Your browser does not support AJAX!");
		return;
	}
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------


var EmpID
function LoadEmployeeInfo() {
	//alert(Gebi('EmpName').value);
	EmpID = Gebi('EmpName').value;

	//Gebi('NewTimeButton').style.display = "none";
	Gebi('TimeEntry').style.display = "none";
	Gebi('EmployeeTimeEditBox').style.display = 'none';

	Gebi('EmployeePhone').innerHTML = "";
	Gebi('EmployeeDCPhone').innerHTML = "";
	Gebi('EmployeeEmail').innerHTML = "";
	Gebi('EmployeeAddress').innerHTML = "";
	Gebi('EmployeePos').innerHTML = "";
	Gebi('EmployeeName').innerHTML = "";
	Gebi('EmployeeTimeBox').innerHTML = "";

	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnEmployeeInfo;
	
	if(EmpID == ''||EmpID == null||EmpID == 0){return false;}
	
	//Gebi('NewTimeButton').style.display = "block";
	
	HttpText='Time_EntryASP.asp?action=LoadEmployeeInfo&EmpID='+EmpID;
	
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnEmployeeInfo() {
	if (xmlHttp.readyState == 4) {
		
		if (xmlHttp.status == 200) {
			
			//alert('Help')
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			var EmpAddress = xmlDoc.getElementsByTagName('EmpAddress')[0].childNodes[0].nodeValue;
			var EmpPhone = xmlDoc.getElementsByTagName('EmpPhone')[0].childNodes[0].nodeValue;
			var EmpDCPhone = xmlDoc.getElementsByTagName('EmpDCPhone')[0].childNodes[0].nodeValue;
			var EmpEmail = xmlDoc.getElementsByTagName('EmpEmail')[0].childNodes[0].nodeValue.replace('--','');
			var EmpPos = xmlDoc.getElementsByTagName('EmpPos')[0].childNodes[0].nodeValue.replace('--','');
			var EmpFName = xmlDoc.getElementsByTagName('EmpFName')[0].childNodes[0].nodeValue;
			var EmpLName = xmlDoc.getElementsByTagName('EmpLName')[0].childNodes[0].nodeValue;
			
			if(EmpID==null){EmpID=0};
			Gebi('EmployeeName').innerHTML = EmpFName + ' ' + EmpLName;
			Gebi('EmployeeNameHidden').value = EmpID;
			Gebi('EmployeePhone').innerHTML = EmpPhone;
			Gebi('EmployeeDCPhone').innerHTML = EmpDCPhone;
			Gebi('EmployeeEmail').innerHTML = EmpEmail;
			Gebi('EmployeeAddress').innerHTML = EmpAddress;
			Gebi('EmployeePos').innerHTML = EmpPos;
			
			LoadEmployeeTime();
			
		}
		else {
			AjaxErr('There was a problem with the LoadEmployeeInfo request.',HttpText);
		}
	}
}

//-------------------------------------------------------------------------------------------------

function LoadEmployeeTime() {
	EmpID = Gebi('EmpName').value;
	showLocked=0;
	if(Gebi('HideLocked').checked) showLocked=0;
	HttpText='Time_EntryASP.asp?action=LoadEmployeeTime&EmpID='+EmpID+'&showLocked='+showLocked;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnEmployeeTime;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	function ReturnEmployeeTime() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				try{var xmlDoc = xmlHttp.responseXML.documentElement;}
				catch(e){AjaxErr('LoadEmployeeTime response is Null.',HttpText); return false;}
				var EmpTimeListLength = xmlDoc.getElementsByTagName('EmpTimeListLength')[0].childNodes[0].nodeValue;
				var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
				var TimeNum = 1;			
				var EmpTimeList = ""
				var ListTotalHrs = 0
				//var accessTime=(xmlDoc.getElementsByTagName('AccessTime')[0].childNodes[0].nodeValue="True");
				
				for (i = 1; i <= EmpTimeListLength; i++) {
					var sEmpTimeID = 'EmpTimeID'+TimeNum;
					var sEmpTimeDate = 'EmpTimeDate'+TimeNum;
					var sEmpTimeInHr = 'EmpTimeInHr'+TimeNum;
					var sEmpTimeInMin = 'EmpTimeInMin'+TimeNum;
					var sEmpTimeOutHr = 'EmpTimeOutHr'+TimeNum;
					var sEmpTimeOutMin = 'EmpTimeOutMin'+TimeNum;
					var sEmpTimeDesc = 'EmpTimeDesc'+TimeNum;
					var sEmpTimeSup = 'EmpTimeSup'+TimeNum;
					var sEmpTimeWage = 'EmpTimeWage'+TimeNum;
					var sSuperName = 'SuperName'+TimeNum;
					var sEmpTimeJobName = 'EmpTimeJobName'+TimeNum;
					var sEmpTimeJobID = 'EmpTimeJobID'+TimeNum;
					var sEmpTimeJobPhase = 'EmpTimeJobPhase'+TimeNum;
					var sEmpTimeJobType = 'EmpTimeJobType'+TimeNum;
					var sEmpTimeArchStat = 'EmpTimeArchStat'+TimeNum;
					
					var EmpTimeID = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeID)[0].childNodes[0].nodeValue);
					var EmpTimeDate = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeDate)[0].childNodes[0].nodeValue);					
					var EmpTimeInHr = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeInHr)[0].childNodes[0].nodeValue);
					var EmpTimeInMin = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeInMin)[0].childNodes[0].nodeValue);
					var EmpTimeOutHr = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeOutHr)[0].childNodes[0].nodeValue);
					var EmpTimeOutMin = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeOutMin)[0].childNodes[0].nodeValue);
					var EmpTimeDesc = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeDesc)[0].childNodes[0].nodeValue.replace('--',''));
					var EmpTimeJobName = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeJobName)[0].childNodes[0].nodeValue.replace('--',''));
					var EmpTimeSup = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeSup)[0].childNodes[0].nodeValue.replace('--',''));
					var EmpTimeWage = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeWage)[0].childNodes[0].nodeValue);
					var SuperName = CharsDecode(xmlDoc.getElementsByTagName(sSuperName)[0].childNodes[0].nodeValue.replace('--',''));
					var EmpTimeJobID = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeJobID)[0].childNodes[0].nodeValue);
					var EmpTimeJobPhase = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeJobPhase)[0].childNodes[0].nodeValue.replace('--',''));
					var EmpTimeJobType = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeJobType)[0].childNodes[0].nodeValue.replace('--',''));
					try {var EmpTimeArchStat = CharsDecode(xmlDoc.getElementsByTagName(sEmpTimeArchStat)[0].childNodes[0].nodeValue.replace('--',''));}
					catch(e){AjaxErr('EmpTimeArchStat Error',HttpText); return false;}
					var EmpTimeJobTypeValue = CharsDecode(EmpTimeJobType);
		
					if(EmpTimeJobType == 1){EmpTimeJobType = "Project"};
					if(EmpTimeJobType == 2){EmpTimeJobType = "Service"};
					if(EmpTimeJobType == 3){EmpTimeJobType = "Test/Maint."};
					if(EmpTimeJobType == 4){EmpTimeJobType = "Other"};
					
					if(EmpTimeInMin <= 9){EmpTimeInMin = '0'+EmpTimeInMin};
					if(EmpTimeOutMin <= 9){EmpTimeOutMin = '0'+EmpTimeOutMin};
					
					var Time_in = (EmpTimeInHr+':'+EmpTimeInMin)
					var Time_out = (EmpTimeOutHr+':'+EmpTimeOutMin)
						
					var DecimalTime_In = ((EmpTimeInHr*1)+(EmpTimeInMin/60));
					var DecimalTime_Out = ((EmpTimeOutHr*1)+(EmpTimeOutMin/60));
					var EmployeeTotalHrs = (DecimalTime_Out - DecimalTime_In);
					ListTotalHrs += EmployeeTotalHrs
					//alert(DecimalTime_In);
					if(EmployeeTotalHrs<0){EmployeeTotalHrs+=24}
					EmployeeTotalHrs = Math.round(EmployeeTotalHrs*100)/100;
					
					
					var onClick='';
					
					var EditBoxShow = "";
					var EditBoxNoShow = "none;";
					
					
					if(EmpTimeArchStat == "False"){EditBoxShow = 'block', EditBoxNoShow = 'none;'};
					if(EmpTimeArchStat == "True"){EditBoxShow = 'none', EditBoxNoShow = 'block;'};
					
					//if(accessTime) 
						{ onClick='"EditEmpTime(^'+EmpTimeID+'^,^'+TimeNum+'^,^'+EmpTimeJobID+'^);"';}
					//else
					//	{onClick='"alert(^Sorry, Time Editing is disabled.  Please notify your supervisor.^);"';}
					
					
					
									
					if((EmpTimeArchStat=="True"&&!Gebi('HideLocked').checked)||(EmpTimeArchStat=="False"&&!Gebi('HideUnlocked').checked)) {
						EmpTimeList +='<div class="EmployeeTimeList" id="EmpTimeList'+TimeNum+'" >';
						EmpTimeList +=	'<div class="EmployeeTimeCheckBox" id="EmpTimeCheckBox'+TimeNum+'">';
						EmpTimeList +=		'<div class="EditTimeButton" value="'+EmpTimeID+'" id="EditTime'+TimeNum+'" style="display:'+EditBoxShow+'" ';
						EmpTimeList +=		' onclick='+onClick;
						EmpTimeList +=		' onmouseover="ListMouseOver('+TimeNum+')" onmouseout="ListMouseOut('+TimeNum+')"'
						EmpTimeList +=		' title="Click to edit this time entry."></div>';
						EmpTimeList +=		'<div class="EditTimeButtonLockout" value="'+EmpTimeID+'" id="EditTimeButtonLockout'+TimeNum+'" style="display:'+EditBoxNoShow+'">';
						EmpTimeList +=	'</div></div>';
						EmpTimeList +=	'<div class="EmployeeTimeDate" id="EmployeeTimeDate'+TimeNum+'">'+EmpTimeDate+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeTimeIn" id="EmployeeTimeTimeIn'+TimeNum+'">'+Time_in+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeTimeOut" id="EmployeeTimeTimeOut'+TimeNum+'">'+Time_out+'</div>';
						//alert(EmployeeTotalHrs);
						EmpTimeList +=	'<div class="EmployeeTimeTotalHrs" id="EmployeeTimeTotalHrs'+TimeNum+'" value="'+EmployeeTotalHrs+'">'+EmployeeTotalHrs+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeWage" id="EmployeeTimeWage'+TimeNum+'" value="'+EmpTimeWage+'">'+EmpTimeWage+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeShift" id="EmployeeTimeShift'+TimeNum+'" value="'+(EmpTimeWage*EmployeeTotalHrs)+'">'+(EmpTimeWage*EmployeeTotalHrs)+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeSup" id="EmployeeTimeSup'+TimeNum+'">'+SuperName+'</div>';
						EmpTimeList +=	'<input id="EmployeeTimeSupHidden'+TimeNum+'" type="hidden" value="'+EmpTimeSup+'" />';
						EmpTimeList +=	'<div class="EmployeeTimeJobName" id="EmployeeTimeJobName'+TimeNum+'" align="left" title="'+EmpTimeJobName+'">'+EmpTimeJobName+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeJobPhase" id="EmployeeTimeJobPhase'+TimeNum+'">'+EmpTimeJobPhase+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeJobType" value="'+EmpTimeJobTypeValue+'" id="EmployeeTimeJobType'+TimeNum+'">'+EmpTimeJobType+'</div>';
						EmpTimeList +=	'<div class="EmployeeTimeDescription" id="EmployeeTimeDescription'+TimeNum+'" title="'+EmpTimeDesc+'" align="left">'+EmpTimeDesc+'</div>';
						EmpTimeList +='</div>';
					}
					
					
					
					
					TimeNum++;
				}
				while(EmpTimeList != EmpTimeList.replace('^','&#39;'))
				{
					EmpTimeList = EmpTimeList.replace('^','&#39;');
				}
				Gebi('EmployeeTimeBox').innerHTML = EmpTimeList;
				
				Gebi('Modal').style.display='none';
				Resizer();
			}
			else {
			}
		}
	}
	}



//-----------------------------------------------------------------------------------
function SaveTimeEntry(EmpID) {
	//var EmpID = Gebi('EmpName').value
	var ProjectName_ID = Gebi('ProjectName').value;
	var ProjectName_IDsplit = ProjectName_ID.split(",");
	var ProjectID = CharsEncode(ProjectName_IDsplit[0]);
	var OtherNam = CharsEncode(Gebi('OtherName').value);
	var JobName = CharsEncode(Gebi('OtherName').value);
	var TimeEntryDate = CharsEncode(Gebi('JobDate').value);
	var TimeIn = CharsEncode(Gebi('JobTimeIn').value);
	var TimeInSplit = TimeIn.split(":");
	var TimeInHr = CharsEncode(TimeInSplit[0]);
	var TimeInMin = CharsEncode(TimeInSplit[1]);
	var TimeOut = CharsEncode(Gebi('JobTimeOut').value);
	var TimeOutSplit = TimeOut.split(":");
	var TimeOutHr = CharsEncode(TimeOutSplit[0]);
	var TimeOutMin = CharsEncode(TimeOutSplit[1]);
	var TotalTime = CharsEncode(Gebi('JobTotalHrs').value);
	var TimeDesc = CharsEncode(Gebi('JobDescriptionText').value);
	var SupID = CharsEncode(SelI('SupName').value);
	var JobPhase = CharsEncode(SelI('TimeEntryPhase').value);
	var JobType = SelectedJobType;//CharsEncode(Gebi('JobTimeEntryBox').value);
	
	if(JobType=='Other') {
		if(OtherNam==""){alert("Please enter project"); return false;}	
		ProjectID="30003";
		JobName = OtherNam;					
	}

	if(JobName==""){alert("Please choose project"); return false;}
	if(Gebi('TimeEntryPhase').selectedIndex==0&&JobType=='Project'){alert("Please choose project phase"); return false;}
	if(Gebi('SupName').selectedIndex==0){alert("Please choose Supervisor"); return false;}
		
	if(TimeEntryDate==""){alert("Please Choose Date"); return false;}
	if(TimeIn==""){alert("Please Enter Time In"); return false;}
	if(TimeOut==""){alert("Please Enter Time Out"); return false;}
//	if(TimeDesc==""){alert("Please "); return false;}
	
	if ((JobPhase == null)||(JobPhase=='')){JobPhase='N/A'}
	
	JobName=JobName.replace(/'/g,'^');	
	TimeDesc=TimeDesc.replace(/'/g,'^');	
	
	var HTTP='Time_EntryASP.asp?action=SaveNewTime&EmpID='+EmpID+'&ProjectID='+ProjectID+'&ProjectName='+JobName+'&TimeEntryDate='+TimeEntryDate;
	HTTP+='&TimeInHr='+TimeInHr+'&TimeInMin='+TimeInMin+'&TimeOutHr='+TimeOutHr+'&TimeOutMin='+TimeOutMin+'&SupID=';
	HTTP+=SupID+'&JobType='+JobType+'&JobPhase='+JobPhase+'&TimeDesc='+TimeDesc+'';
	
	//alert(HTTP);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSaveTimeEntry;
	xmlHttp.open('Get', HTTP, true);
	xmlHttp.send(null);
	
	return true;
}

function ReturnSaveTimeEntry() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			
			
			Gebi('TimeEntry').style.display = 'none';
			//Gebi('NewTimeButton').style.display = 'block';
			Gebi('EmployeeTimeEditBox').style.display = 'none';
			
			//LoadEmployeeTime(EmpID);
			//CancelTimeEntry();
			
		}
		else {
			alert('There was a problem with the SaveTimeEntry request.');
		}
	}
	
}	
////////////////////////////////////////////////////////////////////




//----------------------------------------------------------------------------------
function UpdateEntry() {
	var TimeID = Gebi('TimeEntry').value
	var ProjectName_ID = Gebi('ProjectName').value
	var ProjectName_IDsplit = ProjectName_ID.split(",");
	var ProjectID = ProjectName_IDsplit[0];
	var OtherNam = Gebi('OtherName').value
	var JobName = Gebi('OtherName').value;
	var TimeEntryDate = Gebi('JobDate').value
	var TimeIn = Gebi('JobTimeIn').value
	var TimeInSplit = TimeIn.split(":");
	var TimeInHr = TimeInSplit[0];
	var TimeInMin = TimeInSplit[1];
	var TimeOut = Gebi('JobTimeOut').value
	var TimeOutSplit = TimeOut.split(":");
	var TimeOutHr = TimeOutSplit[0];
	var TimeOutMin = TimeOutSplit[1];
	var TotalTime = Gebi('JobTotalHrs').value
	var TimeDesc = Gebi('JobDescriptionText').value
	var SupID = SelI('SupName').value;
	var JobPhase = SelI('TimeEntryPhase').value;
	var JobType = SelectedJobType;//Gebi('JobTimeEntryBox').value
	
			
	if(JobName==""){alert("Please choose project"); return false;}
	if(Gebi('TimeEntryPhase').selectedIndex==0&&JobType=='Project'){alert("Please choose project phase"); return false;}
		
	if(TimeEntryDate==""){alert("Please Choose Date"); return false;}
	if(TimeIn==""){alert("Please Fill In Time In"); return false;}
	if(TimeOut==""){alert("Please Fill In Time Out"); return false;}
//			if(TimeDesc==""){alert("Please "); return false;}
	
	if ((JobPhase == null)||(JobPhase=='')){JobPhase='N/A'}
	
	JobName=JobName.replace(/'/g,'^');	
	TimeDesc=TimeDesc.replace(/'/g,'^');	
	
	var HTTP='Time_EntryASP.asp?action=UpdateTime&TimeID='+TimeID+'&ProjID='+ProjectID+'&ProjName='+JobName+'&EditDate='+TimeEntryDate+'&SupID='+SupID+'&TimeInHr=';
	HTTP+=TimeInHr+'&TimeInMin='+TimeInMin+'&TimeOutHr='+TimeOutHr+'&TimeOutMin='+TimeOutMin+'&JobType='+JobType+'&JobPhase='+JobPhase+'&EditTimeDesc='+TimeDesc+'';
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnUpdateEntry;
		xmlHttp.open('Get', HTTP, true);
			xmlHttp.send(null);
}

function ReturnUpdateEntry() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var Test = xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue;
			
			Gebi('TimeEntry').style.display = 'none';
			//Gebi('NewTimeButton').style.display = 'block';
			//Gebi('EmployeeTimeEditBox').style.display = 'none';
			
			LoadEmployeeTime();
			CancelTimeEntry();
		}
		else {
			alert('There was a problem with the UpdateEntry request.');
		}
	}
	
}	
/////////////////////////////////
function DeleteTime() {
	if(!confirm('Are you sure you want to delete this entry?')) { return false; }
	var TimeID= Gebi('TimeEntry').value;
	var EmpID = Gebi('EmpName').value
	
	HttpText='Time_EntryASP.asp?action=DeleteTimeEntry&TimeID='+TimeID+'&EmpID='+EmpID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {;
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				
				try { var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue; }
				
				catch(e) { 'There was a problem with the DeleteTime response datum:EmpID.',HttpText }
				
				LoadEmployeeTime();
				
				CancelTimeEntry();
			}
			else {
				AjaxErr('There was a problem with the DeleteTime request.',HttpText);
			}
		}
	}
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);	
}
//////////////////////////////////////////////////////
var Phases;
function populatePhases() {
	Gebi('TimeEntryPhase').innerHTML='<option value="">Please choose project phase / labor type:</option>';
	
	function defaultPhases() {
		Gebi('TimeEntryPhase').innerHTML+='<option value="Plan">Engineering</option>';
		Gebi('TimeEntryPhase').innerHTML+='<option value="UG">Underground</option>';
		Gebi('TimeEntryPhase').innerHTML+='<option value="Rough in">Rough in</option>';
		Gebi('TimeEntryPhase').innerHTML+='<option value="Trim">Trim</option>';
		Gebi('TimeEntryPhase').innerHTML+='<option value="Finish">Finish</option>';
		Gebi('TimeEntryPhase').innerHTML+='<option value="N/A">Not Applicable</option>';
	}
	
	if (Gebi('ProjectName').selectedIndex==0) {
		defaultPhases();
		return true;
	}
	
	HttpText='Time_EntryASP.asp?action=populatePhases&projID='+SelI('ProjectName').value;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {;
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				var xmlDoc = xmlHttp.responseXML.documentElement;
				
				var phaseCount = xmlDoc.getElementsByTagName('phaseCount')[0].childNodes[0].nodeValue;
				
				if(phaseCount<1) defaultPhases();
				
				Phases=new Array;
				for(var p=0;p<phaseCount;p++) {
					var thisPhase = xmlDoc.getElementsByTagName('phase'+p)[0].childNodes[0].nodeValue;
					Phases[p]=thisPhase;
					Gebi('TimeEntryPhase').innerHTML+='<option value="'+thisPhase+'">'+thisPhase+'</option>';
				}
			}
			else {
				AjaxErr('There was a problem with the populatePhases request.',HttpText);
			}
		}
	}
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);	
}
