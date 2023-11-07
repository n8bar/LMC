// JavaScript Document

var ManufArray = new Array();
var SystemsArray = new Array();
var CategoryArray = new Array();
var VendorArray = new Array();

var gSearchName ='';
var gSearchTXT ='';
var xmlHttp;

var GlobalCustID = '';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

var HttpText='';
function GetXmlHttpObject() {
	var xmlHttp=false;
	try	{	xmlHttp=new XMLHttpRequest(); }// Firefox, Opera 8.0+, Safari
	catch (e) { // Internet Explorer
		try {	xmlHttp=new ActiveXObject("Msxml2.XMLHTTP"); }
		catch (e) {	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");	}
	}
	if (!xmlHttp)	alert ("Your browser does not support AJAX!");
	  
	return xmlHttp;
}
//------------------------------------------------------------------------------------------------

/** /
function LoadEmployeeTime() {
	var EmpID = document.getElementById('EmpList')[document.getElementById('EmpList').selectedIndex].value;
	var From = new Date;
	From = document.getElementById('FromDate').value;
	var To = new Date;
	To = document.getElementById('ToDate').value.replace(' ','');
	if(From==''||From==null) {alert('Please choose \'From:\' Date'); return false }//From='Earliest'}
	if(To==''||To==null) {document.getElementById('ToDate').value=From; To=From;}//To='Latest'}
	
	
	HttpText='AdminASP.asp?action=LoadEmployeeTime&EmpID='+EmpID+'&From='+From+'&To='+To;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnEmployeeTime;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnEmployeeTime() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) { 
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var EmpTimeListLength = xmlDoc.getElementsByTagName('EmpTimeListLength')[0].childNodes[0].nodeValue;
			var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			var TimeNum = 1;			
			var EmpTimeList = "";
			var ListTotalHrs = 0;
			var TotalHrs = new Array;
			var EmpName = new Array;
			var EmpIDArray = new Array;
			var E = 0;
			var LastEmpID;
			
			
			var ActiveCount=xmlDoc.getElementsByTagName('ActiveCount')[0].childNodes[0].nodeValue;
			for(i=1;i<=ActiveCount;i++) {
				EmpIDArray[i]=xmlDoc.getElementsByTagName('ActiveEmpID'+i)[0].childNodes[0].nodeValue;
				TotalHrs[EmpIDArray[i]]=0;
				EmpName[EmpIDArray[i]]=xmlDoc.getElementsByTagName('ActiveFName'+i)[0].childNodes[0].nodeValue+' '+xmlDoc.getElementsByTagName('ActiveLName'+i)[0].childNodes[0].nodeValue;
			}
			
			for (i = 1; i <= EmpTimeListLength; i++) {
				var sEmpTimeID = 'EmpTimeID'+TimeNum;
				var sEmpID = 'EmpID'+TimeNum;
				var sEmpTimeFName = 'EmpTimeFName'+TimeNum;
				var sEmpTimeLName = 'EmpTimeLName'+TimeNum;
				var sEmpTimeDate = 'EmpTimeDate'+TimeNum;
				var sEmpTimeInHr = 'EmpTimeInHr'+TimeNum;
				var sEmpTimeInMin = 'EmpTimeInMin'+TimeNum;
				var sEmpTimeOutHr = 'EmpTimeOutHr'+TimeNum;
				var sEmpTimeOutMin = 'EmpTimeOutMin'+TimeNum;
				var sEmpTimeDesc = 'EmpTimeDesc'+TimeNum;
				var sEmpTimeSup = 'EmpTimeSup'+TimeNum;
				var sEmpTimeJobName = 'EmpTimeJobName'+TimeNum;
				var sEmpTimeJobID = 'EmpTimeJobID'+TimeNum;
				var sEmpTimeJobPhase = 'EmpTimeJobPhase'+TimeNum;
				var sEmpTimeJobType = 'EmpTimeJobType'+TimeNum;
				var sEmpTimeArchStat = 'EmpTimeArchStat'+TimeNum;
				
				var EmpTimeID = xmlDoc.getElementsByTagName(sEmpTimeID)[0].childNodes[0].nodeValue;
				var ThisEmpID = xmlDoc.getElementsByTagName(sEmpID)[0].childNodes[0].nodeValue;
				var EmpTimeFName = xmlDoc.getElementsByTagName(sEmpTimeFName)[0].childNodes[0].nodeValue;					
				var EmpTimeLName = xmlDoc.getElementsByTagName(sEmpTimeLName)[0].childNodes[0].nodeValue;					
				var EmpTimeDate = xmlDoc.getElementsByTagName(sEmpTimeDate)[0].childNodes[0].nodeValue;					
				var EmpTimeInHr = xmlDoc.getElementsByTagName(sEmpTimeInHr)[0].childNodes[0].nodeValue;
				var EmpTimeInMin = xmlDoc.getElementsByTagName(sEmpTimeInMin)[0].childNodes[0].nodeValue;
				var EmpTimeOutHr = xmlDoc.getElementsByTagName(sEmpTimeOutHr)[0].childNodes[0].nodeValue;
				var EmpTimeOutMin = xmlDoc.getElementsByTagName(sEmpTimeOutMin)[0].childNodes[0].nodeValue;
				var EmpTimeDesc = xmlDoc.getElementsByTagName(sEmpTimeDesc)[0].childNodes[0].nodeValue.replace('--','');
				var EmpTimeJobName = xmlDoc.getElementsByTagName(sEmpTimeJobName)[0].childNodes[0].nodeValue;
				var EmpTimeSup = xmlDoc.getElementsByTagName(sEmpTimeSup)[0].childNodes[0].nodeValue.replace('--','');
				var EmpTimeJobID = xmlDoc.getElementsByTagName(sEmpTimeJobID)[0].childNodes[0].nodeValue;
				var EmpTimeJobPhase = xmlDoc.getElementsByTagName(sEmpTimeJobPhase)[0].childNodes[0].nodeValue.replace('--','');
				var EmpTimeJobType = xmlDoc.getElementsByTagName(sEmpTimeJobType)[0].childNodes[0].nodeValue.replace('--','');
				var EmpTimeArchStat = xmlDoc.getElementsByTagName(sEmpTimeArchStat)[0].childNodes[0].nodeValue.replace('--','');					
				var EmpTimeJobTypeValue = EmpTimeJobType;
				try
				{
				}
				catch(e) {
					AjaxErr('LoadEmployeeTime response error.',HttpText);
				}
				
				if(EmpTimeJobType == 1) {EmpTimeJobType = "Project"};
				if(EmpTimeJobType == 2) {EmpTimeJobType = "Service"};
				if(EmpTimeJobType == 3) {EmpTimeJobType = "Test/Maint."};
				if(EmpTimeJobType == 4) {EmpTimeJobType = "Other"};
				
				if(EmpTimeInMin <= 9) {EmpTimeInMin = '0'+EmpTimeInMin};
				if(EmpTimeOutMin <= 9) {EmpTimeOutMin = '0'+EmpTimeOutMin};
				
				var Time_in = (EmpTimeInHr+':'+EmpTimeInMin)
				var Time_out = (EmpTimeOutHr+':'+EmpTimeOutMin)
					
				var DecimalTime_In = ((EmpTimeInHr*1)+(EmpTimeInMin/60));
				var DecimalTime_Out = ((EmpTimeOutHr*1)+(EmpTimeOutMin/60));
				var EmployeeTotalHrs = (DecimalTime_Out - DecimalTime_In);
				ListTotalHrs += EmployeeTotalHrs
				//alert(DecimalTime_In);
				if(EmployeeTotalHrs<0) {EmployeeTotalHrs+=24}
				EmployeeTotalHrs = EmployeeTotalHrs;
				
				
				var onClick='';
				var SuperName='<b>NONE</b>';
				var Emps = new Array;
				Emps = parent.EmployeeArray;
				var L = Emps.length;
				for(var EID=1; EID<L; EID++) {
					//alert(EID+' '+parent.EmployeeArray[EID][1]);
					if(Emps[EID][1]==EmpTimeSup) {
						//alert(EID+' '+Emps.length);
						SuperName=Emps[EID][2]+' ';
						SuperName+=Emps[EID][3];
					}
				}
				
				var EditBoxShow = "";
				var EditBoxNoShow = "none;";
				
				if(EmpTimeArchStat == "False") {EditBoxShow = 'block', EditBoxNoShow = 'none;'};
				if(EmpTimeArchStat == "True") {EditBoxShow = 'none', EditBoxNoShow = 'block;'};
				
				if(parent.accessTime=='True') {onClick='"EditEmpTime(value,^'+TimeNum+'^,^'+EmpTimeJobID+'^);"';}
				else
					{onClick='"alert(^Sorry, Time Editing is disabled.  Please notify your supervisor.^);"';}
				
				
				if(EmpID != 9999 && EmpID != 1000) {
					EmpTimeList +='<div class="EmployeeTimeList" id="EmpTimeList'+TimeNum+'" >';
					EmpTimeList +='<div class="EmployeeTimeDate" id="EmployeeTimeDate'+TimeNum+'">'+EmpTimeDate+'</div>';
					EmpTimeList +='<div class="EmployeeTimeTimeIn" id="EmployeeTimeTimeIn'+TimeNum+'">'+Time_in+'</div>';
					EmpTimeList +='<div class="EmployeeTimeTimeOut" id="EmployeeTimeTimeOut'+TimeNum+'">'+Time_out+'</div>';
					//alert(EmployeeTotalHrs);
					EmpTimeList +='<div class="EmployeeTimeTotalHrs" id="EmployeeTimeTotalHrs'+TimeNum+'" value="'+EmployeeTotalHrs+'">'+EmployeeTotalHrs+'</div>';
					EmpTimeList +='<div class="EmployeeTimeSup" id="EmployeeTimeSup'+TimeNum+'" value="'+EmpTimeSup+'">'+SuperName+'</div>';
					EmpTimeList +='<div class="EmployeeTimeJobName" id="EmployeeTimeJobName'+TimeNum+' title="'+EmpTimeJobName+'">'+EmpTimeJobName+'</div>';
					EmpTimeList +='<div class="EmployeeTimeJobPhase" id="EmployeeTimeJobPhase'+TimeNum+'">'+EmpTimeJobPhase+'</div>';
					EmpTimeList +='<div class="EmployeeTimeJobType" value="'+EmpTimeJobTypeValue+'" id="EmployeeTimeJobType'+TimeNum+'">'+EmpTimeJobType+'</div>';
					EmpTimeList +='<div class="EmployeeTimeDescription" id="EmployeeTimeDescription'+TimeNum+'" title="'+EmpTimeDesc+'">'+EmpTimeDesc+'</div>';
					EmpTimeList +='</div>';
				}
				
				if(EmpID==9999||EmpID==1000) {
					TotalHrs[ThisEmpID]=TotalHrs[ThisEmpID]+(EmployeeTotalHrs*1);
					EmpName[ThisEmpID]=EmpTimeFName+' '+EmpTimeLName;
					LastEmpID=ThisEmpID;
				}
				
				
				TimeNum++;
			
			
			}
			
			var PeriodFrom=FromDate.value
			var PeriodTo=ToDate.value
			
			EmpTimeList='<big><b>';
				if(FromDate.value=='') {PeriodFrom='Earliest'}
				if(ToDate.value=='') {PeriodTo='Latest'}
				if(EmpID==1000) {
					EmpTimeList+='<div align="left">Time report for: All active employees. </div>';
				}
				if(EmpID==9999) {
					EmpTimeList+='<divalign="left">Time report for: All employees. </div>';
				}
				if(EmpID!=1000&&EmpID!=9999) {
					EmpTimeList+='<div align="left">Time report for: '+EmpName[EmpID]+'. </div>';
				}
			EmpTimeList+='</b></big>';
			EmpTimeList+='<div align="left">  From: '+PeriodFrom+' through '+PeriodTo+'. </div>';
			
			
			var DT= new Date;
			var Mo=DT.getMonth()+1;
			var Hour=DT.getHours();
			var Min=DT.getMinutes();
			if(Min<10) {Min='0'+Min}
			var AMPM='AM';
			if(Hour >12) {Hour -=12; AMPM='PM'}
			EmpTimeList+='<div align="left">Locked and printed on'+(Mo)+'/'+DT.getDate()+'/'+DT.getFullYear()+'  at '+Hour+':'+Min+' '+AMPM+'<br/></div>';
			
			var ThisTotal = Math.round(TotalHrs[EmpIDArray[1]]*100)/100;
			EmpTimeList+='<div class="ReportDiv" style=" font-size:28px; height:36px; width:100%;">'
			EmpTimeList+='	<div class="ReportDiv" style="width:192px; height:100%; float:left; border:1px #000 solid; border-right:none;">';
			EmpTimeList+='		Total Hours For'
			EmpTimeList+='	</div>';
			EmpTimeList+='	<div class="ReportDiv" style="width:224px; height:100%; float:left; border:1px #000 solid; border-right:none; border-left:none;" align="left">';
			EmpTimeList+=			EmpName[EmpIDArray[1]]+':';
			EmpTimeList+='	</div>';
			EmpTimeList+='	<div class="ReportDiv" style="float:left; width:96px; border:1px #000 solid;" align="right">';
			EmpTimeList+='		<b>'+ThisTotal+'</b>';
			EmpTimeList+='	</div>';
			EmpTimeList+='</div>';//<font style="font-size:31px"><br/></font>';
			for(a=2;a<EmpIDArray.length;a++) {
				ThisTotal = Math.round(TotalHrs[EmpIDArray[a]]*100)/100;
				
				EmpTimeList+='<div class="ReportDiv" style="font-size:28px; width:100%; height:36px;">'
				EmpTimeList+='  <div class="ReportDiv" style="white-space:nowrap; height:100%;">';
				EmpTimeList+='    <div class="ReportDiv" style="width:192px; float:left; border-left:1px #000 solid; border-bottom:1px #000 solid; height:100%;">';
				EmpTimeList+='      Total Hours For'
				EmpTimeList+='    </div>';
				EmpTimeList+='    <div class="ReportDiv" style="width:224px; float:left; border-bottom:1px #000 solid; height:100%;" align="left">';
				EmpTimeList+=       EmpName[EmpIDArray[a]]+':';
				EmpTimeList+='    </div>';
				EmpTimeList+='  </div>';
				EmpTimeList+='  <div class="ReportDiv" style="float:left; width:96px; height:100%; border:1px #000 solid; border-top:none; padding-top:1px;" align="right">';
				EmpTimeList+='    <b>'+ThisTotal+'</b></div>';
				EmpTimeList+='</div>';//<font style="font-size:30px"><br/></font>';
				
			}
			EmpTimeList+='</div>';
			
			while(EmpTimeList != EmpTimeList.replace('^','&#39;')) {
				EmpTimeList = EmpTimeList.replace('^','&#39;');
			}
			
			document.getElementById('EmployeeTimeBox').innerHTML = EmpTimeList;
			
			
			Resize();
		}
		else
		{
			AjaxErr('LoadEmployeeTime Failed.',HttpText);
		}
	}
}
//-----------------------------------------------------------------------------------
/**/

/** /
function LoadProjectTime(ProjID) {
	var From = new Date;
	From = document.getElementById('projFromDate').value;
	var To = new Date;
	To = document.getElementById('projToDate').value.replace(' ','');
	if(From==''||From==null) {alert('Please choose \'From:\' Date'); return false }//From='Earliest'}
	if(To==''||To==null) {document.getElementById('ToDate').value=From; To=From;}//To='Latest'}
	HttpText='AdminASP.asp?action=LoadProjectTime&ProjID='+ProjID+'&From='+From+'&To='+To;
	
	//alert(EmpID);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLoadProjectTime;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);
}
function ReturnLoadProjectTime() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) { 
			
			try{var xmlDoc = xmlHttp.responseXML.documentElement;}
			catch(e) {AjaxErr('LoadProject Time Failed.',HttpText);}
			
			var records=xmlDoc.getElementsByTagName('records')[0].childNodes[0].nodeValue;
			var Project=xmlDoc.getElementsByTagName('project')[0].childNodes[0].nodeValue.replace('--','');
			
			var tBox=Gebi('EmployeeTimeBox');
			tBox.innerHTML='<div style="">'+Project+'</div>';
			
			for(r=1;r<=records;r++) {
				
				tBox.innerHTML+='<div id=ReportRow'
				//tBox.innerHTML+=''
				//tBox.innerHTML+=''
				//tBox.innerHTML+=''
				//tBox.innerHTML+=''
				//tBox.innerHTML+=''
				//tBox.innerHTML+=''
				//tBox.innerHTML+=''
				tBox.innerHTML+='</div>'
				
			}
			//alert(EmpID);
		}
		else
		{
			AjaxErr('LoadProject Time Failed.',HttpText);
			HttpText='';
		}
	}
}
/**/


function Archive(Archived) {
	//alert(Archived);
	var EmpID = 1000//document.getElementById('EmpList')[document.getElementById('EmpList').selectedIndex].value;
	var From = document.getElementById('FromDate').value;
	var To = document.getElementById('ToDate').value.replace(' ','');
	if(From==''||From==null) {From='Earliest'}
	if(To==''||To==null) {To='Latest'}
	HttpText='AdminASP.asp?action=Archive&EmpID='+EmpID+'&From='+From+'&To='+To+'&Archived='+Archived;
	
	//alert(EmpID);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnArchive;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);
}

function ReturnArchive() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) { 
			var xmlDoc = xmlHttp.responseXML.documentElement;			
			var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			//alert(EmpID);
		}
		else {
			AjaxErr('There was a problem with the Archive Function. \n The time may or may not have been locked. \n\n Continue?',HttpText);
			HttpText='';
		}
	}
}





//Updates Text from a Textbox onKeyup////////////////////////////////////////////////

function UpdateText(BoxID,BoxType,Table,IDColumn,Column,RowID) {
	  var SysOK = 'No';	
	  if(BoxType == 'List') {var Text = document.getElementById(BoxID).options.value;}
	  if(BoxType == 'ListTxt') {var Obj = document.getElementById(BoxID); var Text = (Obj.options[Obj.selectedIndex].text ); }
	  if(BoxType == 'Text') {var Text = document.getElementById(BoxID).value;}
	  if(BoxType == 'CheckBox') {var Text = document.getElementById(BoxID).checked;}
	  if(Table == 'BidPresets') {var RowID = document.getElementById('BidPresetID').innerHTML;}
	  
	  Text = CharsEncode(Text);
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateText;
	  xmlHttp.open('Get','DataEntryASP.asp?action=UpdateText&Text='+Text+'&Table='+Table+'&IDColumn='+IDColumn+'&Column='+Column+'&RowID='+RowID+'&SysOK='+SysOK+'&BoxID='+BoxID+'&BoxType='+BoxType, true);
	  xmlHttp.send(null);
}
function ReturnUpdateText() {
   if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var Ok = xmlDoc.getElementsByTagName("Ok")[0].childNodes[0].nodeValue;
			var BoxID = xmlDoc.getElementsByTagName("BoxID")[0].childNodes[0].nodeValue;
			var BoxType = xmlDoc.getElementsByTagName("BoxType")[0].childNodes[0].nodeValue;
			var Table = xmlDoc.getElementsByTagName("Table")[0].childNodes[0].nodeValue;
			var IDColumn = xmlDoc.getElementsByTagName("IDColumn")[0].childNodes[0].nodeValue;
			var Column = xmlDoc.getElementsByTagName("Column")[0].childNodes[0].nodeValue;
			var RowID = xmlDoc.getElementsByTagName("RowID")[0].childNodes[0].nodeValue;
			
			if(BoxID == 'SystemTypes') {UpdateText(BoxID,'ListTxt',Table,IDColumn,'BidPresetSystem',RowID);}

		  }
		 else
		 {
            alert('There was a problem with the request.');
         }
      }
	  
}
//-------------------------------------------------------------------------------------------------

//Gets the Manufactures List  ////////////////////////////////////////////////

//-------------------------------------------------------------------------------------------------

//Gets the Systems List  ////////////////////////////////////////////////

//-------------------------------------------------------------------------------------------------

//Gets the Systems List  ////////////////////////////////////////////////

//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------

//Opens Employee--//////////////////////////////////////////////////////////////////////////////////

function OpenEmployee(EmpID) {
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnOpenEmployee;
	xmlHttp.open('Get','DataEntryASP.asp?action=OpenEmployee&EmpID='+EmpID, true);
	xmlHttp.send(null);
}
function ReturnOpenEmployee() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var EmpID = xmlDoc.getElementsByTagName('EmpID')[0].childNodes[0].nodeValue;
			var FName = xmlDoc.getElementsByTagName('FName')[0].childNodes[0].nodeValue.replace('--','');
			var LName = xmlDoc.getElementsByTagName('LName')[0].childNodes[0].nodeValue.replace('--','');
			var Position = xmlDoc.getElementsByTagName('Position')[0].childNodes[0].nodeValue.replace('--','');
			var Wage = xmlDoc.getElementsByTagName('Wage')[0].childNodes[0].nodeValue.replace('--','');
			var Address = xmlDoc.getElementsByTagName('Address')[0].childNodes[0].nodeValue.replace('--','');
			var City = xmlDoc.getElementsByTagName('City')[0].childNodes[0].nodeValue.replace('--','');
			var State = xmlDoc.getElementsByTagName('State')[0].childNodes[0].nodeValue.replace('--','');
			var Zip = xmlDoc.getElementsByTagName('Zip')[0].childNodes[0].nodeValue.replace('--','');
			var Phone = xmlDoc.getElementsByTagName('Phone')[0].childNodes[0].nodeValue.replace('--','');
			var Phone2 = xmlDoc.getElementsByTagName('Phone2')[0].childNodes[0].nodeValue.replace('--','');
			var DCPhone = xmlDoc.getElementsByTagName('DCPhone')[0].childNodes[0].nodeValue.replace('--','');
			var Email = xmlDoc.getElementsByTagName('Email')[0].childNodes[0].nodeValue.replace('--','');
			var HiredDate = (xmlDoc.getElementsByTagName('HiredDate')[0].childNodes[0].nodeValue);			 
			var Active =(xmlDoc.getElementsByTagName('Active')[0].childNodes[0].nodeValue);
			
			document.getElementById('txtEmpID').innerHTML = EmpID;
			document.getElementById('txtEmpFName').value = FName;
			document.getElementById('txtEmpLName').value = LName;
			document.getElementById('EmpName').innerHTML = FName+'  '+LName;
			document.getElementById('txtEmpPosition').value = Position;
			document.getElementById('txtEmpWage').value = Wage;
			document.getElementById('txtEmpAddress').value = Address;
			document.getElementById('txtEmpCity').value = City;
			document.getElementById('txtEmpState').value = State;
			document.getElementById('txtEmpZip').value = Zip;
			document.getElementById('txtEmpPhone').value = Phone;
			document.getElementById('txtEmpPhone2').value = Phone2;
			document.getElementById('txtEmpDCPhone').value = DCPhone;
			document.getElementById('txtEmpEmail').value = Email;
			document.getElementById('txtEmpDate').value = HiredDate;
			
			document.getElementById('UpdateEmp').style.display ='block';
			document.getElementById('DelEmp').style.display ='block';
			document.getElementById('CancelEmp').style.display ='block';
			
			if(Active=='True') {document.getElementById('EmpActive').checked = true;}
			else
				{document.getElementById('EmpActive').checked = false;}
			
			var HasAccess =(xmlDoc.getElementsByTagName('HasAccess')[0].childNodes[0].nodeValue);

			if(Active=='True'&&HasAccess=='1') {
				var DataEntry =(xmlDoc.getElementsByTagName('DataEntry')[0].childNodes[0].nodeValue);
				var Estimates=(xmlDoc.getElementsByTagName('Estimates')[0].childNodes[0].nodeValue);
				var Projects=(xmlDoc.getElementsByTagName('Projects')[0].childNodes[0].nodeValue);
				var Service=(xmlDoc.getElementsByTagName('Service')[0].childNodes[0].nodeValue);
				var Test=(xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue);
				var Engineering=(xmlDoc.getElementsByTagName('Engineering')[0].childNodes[0].nodeValue);
				var Purchasing=(xmlDoc.getElementsByTagName('Purchasing')[0].childNodes[0].nodeValue);
				var Time=(xmlDoc.getElementsByTagName('Time')[0].childNodes[0].nodeValue);
				var Office=(xmlDoc.getElementsByTagName('Office')[0].childNodes[0].nodeValue);
				var Inventory=(xmlDoc.getElementsByTagName('Inventory')[0].childNodes[0].nodeValue);
				var Training=(xmlDoc.getElementsByTagName('Training')[0].childNodes[0].nodeValue);
				var Website=(xmlDoc.getElementsByTagName('Website')[0].childNodes[0].nodeValue);
				var Admin=(xmlDoc.getElementsByTagName('Admin')[0].childNodes[0].nodeValue);
				var SelectedUser=(xmlDoc.getElementsByTagName('User')[0].childNodes[0].nodeValue);
					
				if(DataEntry=='True') {Gebi('CBDataEntry').checked=true;} else {Gebi('CBDataEntry').checked=false;}
				if(Estimates=='True') {Gebi('CBEstimates').checked=true;} else {Gebi('CBEstimates').checked=false;}
				if(Projects=='True') {Gebi('CBProjects').checked=true;} else {Gebi('CBProjects').checked=false;}
				if(Service=='True') {Gebi('CBService').checked=true;} else {Gebi('CBService').checked=false;}
				if(Test=='True') {Gebi('CBTest').checked=true;} else {Gebi('CBTest').checked=false;}
				if(Engineering=='True') {Gebi('CBEngineering').checked=true;} else {Gebi('CBEngineering').checked=false;}
				if(Purchasing=='True') {Gebi('CBPurchasing').checked=true;} else {Gebi('CBPurchasing').checked=false;}
				if(Time=='True') {Gebi('CBTime').checked=true;} else {Gebi('CBTime').checked=false;}
				if(Office=='True') {Gebi('CBOffice').checked=true;} else {Gebi('CBOffice').checked=false;}
				if(Inventory=='True') {Gebi('CBInventory').checked=true;} else {Gebi('CBInventory').checked=false;}
				if(Training=='True') {Gebi('CBTraining').checked=true;} else {Gebi('CBTraining').checked=false;}
				if(Website=='True') {Gebi('CBWebsite').checked=true;} else {Gebi('CBWebsite').checked=false;}
				if(Admin=='True') {Gebi('CBAdmin').checked=true;} else {Gebi('CBAdmin').checked=false;}
				
				document.getElementById('AccessModal').style.display='none';
				document.getElementById('UserModal').style.display='none';
				document.getElementById('txtUserName').value=SelectedUser;
				document.getElementById('EmpUserName').value=SelectedUser;
			}
			else
			{
				document.getElementById('AccessModal').style.display='block';
				document.getElementById('UserModal').style.display='block';
				Gebi('CBDataEntry').checked=false;
				Gebi('CBEstimates').checked=false;
				Gebi('CBProjects').checked=false;
				Gebi('CBService').checked=false;
				Gebi('CBTest').checked=false;
				Gebi('CBEngineering').checked=false;
				Gebi('CBPurchasing').checked=false;
				Gebi('CBTime').checked=false;
				Gebi('CBOffice').checked=false;
				Gebi('CBInventory').checked=false;
				Gebi('CBTraining').checked=false;
				Gebi('CBWebsite').checked=false;
				Gebi('CBAdmin').checked=false;
			}
			
			if(document.getElementById('EmpInfo').style.display!='block'&&document.getElementById('EmpAccess').style.display!='block') {EmpTabs('EmpInfo','EmpInfoTabBox');}
			
		}
		else
		{
			alert('There was a problem with the request.');
		}//-----------------------------------------------------------------------------------------
	}//---------------------------------------------------------------------------------------------
}//-------------------------------------------------------------------------------------------------



//Updates Employee Data////////////////////////////////////////////////////////////////////////////
function UpdateEmployee() {
		var EmpID = document.getElementById('txtEmpID').innerHTML;
		var FName = document.getElementById('txtEmpFName').value;				if(FName == '') {alert('Please Fill in the First Name Box'); return false;}
		var LName = document.getElementById('txtEmpLName').value;				if(LName == '') {alert('Please Fill in the Last Name Box'); return false;}
		var Position = document.getElementById('txtEmpPosition').value;
		var Wage = document.getElementById('txtEmpWage').value;
		var Address = document.getElementById('txtEmpAddress').value;
		var City = document.getElementById('txtEmpCity').value;
		var State = document.getElementById('txtEmpState').value;
		var Zip = document.getElementById('txtEmpZip').value;
		var Phone = document.getElementById('txtEmpPhone').value;
		var Phone2 = document.getElementById('txtEmpPhone2').value;
		var DCPhone = document.getElementById('txtEmpDCPhone').value;
		var Email = document.getElementById('txtEmpEmail').value;
		var Hired = document.getElementById('txtEmpDate').value;
		
		if(document.getElementById('EmpActive').checked==true) {var Active='True'}
		else
			{var Active='False'}
		
    HttpText ='';
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateEmployee;
	  HttpText = 'DataEntryASP.asp?action=UpdateEmployee&EmpID='+EmpID+'&FName='+FName+'&LName='+LName+'&Position='+Position+'&Hired='+Hired+'&Wage='+Wage+'&Address='+Address+'&City='+City+'&State='+State+'&Zip='+Zip+'&Phone='+Phone+'&Phone2='+Phone2+'&DCPhone='+DCPhone+'&Email='+Email+'&Active='+Active;
	  xmlHttp.open('Get',HttpText, true);
	  xmlHttp.send(null);
	  
}


function ReturnUpdateEmployee() {

	
  if (xmlHttp.readyState == 4) {
		  
		if (xmlHttp.status == 200) {
		  var xmlDoc = xmlHttp.responseXML.documentElement;
			var FName = xmlDoc.getElementsByTagName('FName')[0].childNodes[0].nodeValue;
			
			OpenEmployee(document.getElementById('txtEmpID').innerHTML);
			alert(FName +'\'s data is updated.');
			LoadEmpList();			
		}
		else
		{
      alert('There was a problem with the request.');
    }
  }
	  
}

//-------------------------------------------------------------------------------------------------



//Saves a new Employee///////////////////////////////////////////////////////////////

function SaveEmployee() {
	var EmpID = document.getElementById('txtEmpID').innerHTML;
	var FName = document.getElementById('txtEmpFName').value;				if(FName == '') {alert('Please Fill in the First Name Box'); return false;}
	var LName = document.getElementById('txtEmpLName').value;				if(LName == '') {alert('Please Fill in the Last Name Box'); return false;}
	var Position = document.getElementById('txtEmpPosition').value;
	var Wage = document.getElementById('txtEmpWage').value;
	var Address = document.getElementById('txtEmpAddress').value;
	var City = document.getElementById('txtEmpCity').value;
	var State = document.getElementById('txtEmpState').value;
	var Zip = document.getElementById('txtEmpZip').value;
	var Phone = document.getElementById('txtEmpPhone').value;
	var Phone2 = document.getElementById('txtEmpPhone2').value;
	var DCPhone = document.getElementById('txtEmpDCPhone').value;
	var Email = document.getElementById('txtEmpEmail').value;
	var Hired = document.getElementById('txtEmpDate').value;
	
  HttpText ='';
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSaveEmployee;
	HttpText = 'DataEntryASP.asp?action=SaveEmployee&EmpID='+EmpID+'&FName='+FName+'&LName='+LName+'&Position='+Position+'&Hired='+Hired+'&Wage='+Wage+'&Address='+Address+'&City='+City+'&State='+State+'&Zip='+Zip+'&Phone='+Phone+'&Phone2='+Phone2+'&DCPhone='+DCPhone+'&Email='+Email;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);

}


function ReturnSaveEmployee() {

	
	if (xmlHttp.readyState == 4) {
		  
		if (xmlHttp.status == 200) {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var FName = xmlDoc.getElementsByTagName("FName")[0].childNodes[0].nodeValue;
			alert('Hired: ' + FName);
			LoadEmpList();
			CancelEmployee();
		}
		else
		{
			AjaxErr('There was a problem with the request.',HttpText);
} } }
  
//-------------------------------------------------------------------------------------------------




//Deletes An Employee//////////////////////////////////////////////////////////

function DelEmployee() {
	var ConfirmTxt ='Delete '+document.getElementById('txtEmpFName').value+' '+document.getElementById('txtEmpLName').value +'? This cannot be undone.'
	if (confirm(ConfirmTxt) == false) {return false}
		
	
	var EmpID = document.getElementById("txtEmpID").innerHTML;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnDelEmployee;
	xmlHttp.open('Get','DataEntryASP.asp?action=DelEmployee&EmpID=' + EmpID, true);
	xmlHttp.send(null);
}


function ReturnDelEmployee() {

	
     if (xmlHttp.readyState == 4) {
		  
		if (xmlHttp.status == 200) {
		    var xmlDoc = xmlHttp.responseXML.documentElement;
			//var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
		 	//var List = xmlDoc.getElementsByTagName("List")[0].childNodes[0].nodeValue;
			//var Name = document.getElementById("txtName").value;
			//var CustID = xmlDoc.getElementsByTagName("CustID")[0].childNodes[0].nodeValue;
		 	//alert(CustID);

			LoadEmpList();	
			NewEmployee(); CancelEmployee();		//Clear the "Form"
			
      }
		 else
		 {
            alert('There was a problem with the request.');
         }
     }
	  
}
//-------------------------------------------------------------------------------------------------



//Creates a user for an employee
var NewUserAlert='';

function NewUser() {
	var EmpID = document.getElementById("txtEmpID").innerHTML;
	var User = document.getElementById('User').value;
	var Pass = document.getElementById('Pass').value;
	var Conf = document.getElementById('Conf').value;
	
	//alert(CheckUser(User));
	NewUserAlert = '';
	if(User==''||User==null) {NewUserAlert+='Username cannot be blank. \n';}
	else {if(CheckUser(User)==false) {NewUserAlert+='Username already taken, please choose another.\n'}}
	if(Pass==''||Pass==null) {NewUserAlert+='Password cannot be blank. \n';}
	if(Pass!=Conf) {NewUserAlert+='Password and Confirmation do not match. \n';}

	if(NewUserAlert!='') {
		alert(NewUserAlert);
		return false
	}
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewUser;
	xmlHttp.open('Get','DataEntryASP.asp?action=NewUser&EmpID=' + EmpID+"&User="+User+"&Pass="+Pass, true);
	xmlHttp.send(null);
}

function ReturnNewUser() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var EmpID = xmlDoc.getElementsByTagName("EmpID")[0].childNodes[0].nodeValue;
			OpenEmployee(EmpID);
		}
		else
		{
			alert('There was a problem with the User Creation request.');
		}
	}
}
//------------
//Checks to see if username is in use.
var UserNameAvailable='Underfined';

function CheckUser(User) {
	//alert('Hi, I am the CheckUser function   '+UserNameAvailable);
	
	function Checker() {
		//alert('Hi, I am the Checker function   '+UserNameAvailable);
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange=ReturnChecker;
		xmlHttp.open('Get','DataEntryASP.asp?action=CheckUser&User='+User, false);
		xmlHttp.send(null);
	}
	
	function ReturnChecker() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				//alert('Hi I am the RETURNchecker function!   '+UserNameAvailable);
				var xmlDoc = xmlHttp.responseXML.documentElement;
				UserNameAvailable = xmlDoc.getElementsByTagName("Available")[0].childNodes[0].nodeValue;
				//alert('ReturnChecker Now:'+UserNameAvailable);
			}
			else
			{
				alert('There was a problem with the Username Availability request');
				UserNameAvailable='problem with Username Availability request';
				return false;
			}
		}
	}
	
	Checker();
	
	//alert('CheckUser  Now:'+UserNameAvailable);
	if(UserNameAvailable==1) {return true}else{return false}
}////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////


//Sets individual access control bits
function UpdateAccess(obj, Value,Field) {
		var User=document.getElementById('EmpUserName').value;
		
		//alert(Field+' = '+Value+'   '+User);
		
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange=ReturnUpdateAccess;
		xmlHttp.open('Get','DataEntryASP.asp?action=UpdateAccess&Value='+Value+'&Field='+Field+'&User='+User, true);
		xmlHttp.send(null);
}

function ReturnUpdateAccess() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			//alert('Hi I am the RETURNchecker function!   '+UserNameAvailable);
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//UserNameAvailable = xmlDoc.getElementsByTagName("Available")[0].childNodes[0].nodeValue;
			//alert('ReturnChecker Now:'+UserNameAvailable);
		}
		else
		{
			alert('There was a problem with the request while trying to set User Access');
		}
	}
}////////////////////////////////////////////////////////////////////////////////////////////

//Update Username
function UpdateUser() {
		var OldUser=document.getElementById('EmpUserName').value;
		var Value=document.getElementById('txtUserName').value;
		
		if(!CheckUser(Value)) {
			alert('The Username:'+Value+' has been taken.');
			return false
		}
		
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange=ReturnUpdateUser;
		xmlHttp.open('Get','DataEntryASP.asp?action=UpdateAccess&Value='+Value+'&Field=Username&User='+OldUser, true);
		xmlHttp.send(null);
}
function ReturnUpdateUser() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			//alert('Hi I am the RETURNchecker function!   '+UserNameAvailable);
			var xmlDoc = xmlHttp.responseXML.documentElement;
			OpenEmployee(document.getElementById('txtEmpID').innerHTML);
			//UserNameAvailable = xmlDoc.getElementsByTagName("Available")[0].childNodes[0].nodeValue;
			//alert('ReturnChecker Now:'+UserNameAvailable);
		}
		else
		{
			alert('There was a problem with the request while trying to set User Access');
		}
	}
}////////////////////////////////////////////////////////////////////////////////////////////

//Update Password
function UpdatePass() {
		var User=document.getElementById('EmpUserName').value;
		var Value=document.getElementById('txtPassword').value;
		var Conf=document.getElementById('txtConfirm').value;
		
		if(Value==''||Value==null) {
			alert('Password cannot be blank!');
			return false;
		}
		
		if(Value!=Conf) {
			alert('Password and confirmation do not match!');
			return false;
		}
		
		if(Value=='1234'||Value.toLowerCase==User.toLowerCase) {
			if(!confirm('The password you have chosen is not secure. click ok to use it anyway.')) {return false}
		}
		
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange=ReturnUpdatePass;
		xmlHttp.open('Get','DataEntryASP.asp?action=UpdateAccess&Value='+Value+'&Field=Password&User='+User, true);
		xmlHttp.send(null);
}
function ReturnUpdatePass() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			//alert('Hi I am the RETURNchecker function!   '+UserNameAvailable);
			var xmlDoc = xmlHttp.responseXML.documentElement;
			OpenEmployee(document.getElementById('txtEmpID').innerHTML);
			//UserNameAvailable = xmlDoc.getElementsByTagName("Available")[0].childNodes[0].nodeValue;
			//alert('ReturnChecker Now:'+UserNameAvailable);
		}
		else
		{
			alert('There was a problem with the request while setting password');
		}
	}
}////////////////////////////////////////////////////////////////////////////////////////////
