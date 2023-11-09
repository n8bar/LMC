// JavaScript Document   AJAX CONTROLS

/*

The following is an OUTDATED list of functions...............................................

	UpdateText(BoxID,BoxType,Table,IDColumn,Column,RowID)
	GetAreaList()
	GetCustomer()
	GetProjects(CustID)
	OpenProject(ProjID)
	NewProject()
	NewSystem()
	GetSystemEdit(SysID)
	ShowEst()
	PartsList(SysID)
	LaborList(SysID)
	ToggleActiveProject(ProjID,Active)
	ToggleActiveSystem(ProjID,Active)
	CheckBoxSysUpdate(SysID)
	UpdateSystemInfo(ObjectName,SQLName,Type)
	UpdateSystemRates(ObjectName,SQLName,Type)
	UpdateAllItemCosting(SysID)
	ListEntryUpdate(RowID,Field,FieldID)
	CalculateItemRow(RowID)
	CalculateEstTotal()
	ItemSelected(ItemID,CBID)  //Sets an item to checked in the database
	UncheckAll()
	DeleteItems(List)  //Deletes An Item Row
	DeleteProject(ProjID)
	DeleteSystem()
	SearchParts(SearchName)
	AddPart(PartID)
	SearchLabor(SearchName)
	AddLabor(LaborID)
	PrintSystemsList()
	LetterHeadSW(CB1,CB2,CB3)   //Switches and saves the  LetterHead Checkboxes

	PresetSystemList   //Opens the list of presets based on a system

*/


var AreaArray = new Array();
var BidArray = new Array();
var PartsMU = "";
var LaborMU = "";
var TaxRate = "";

var ProjectCB = 0;

//var GlobalProjID;
//var GlobalCustName;

//Main HTTPXML Request Code Comes From CommonAJAX.js


var xmlHttp
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  // Firefox, Opera 8.0+, Safari
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  // Internet Explorer
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
  
  	if (xmlHttp==null)
	  {
	  alert ("Your browser does not support AJAX!");
	  return;
	  }
	  
return xmlHttp;
}
//------------------------------------------------------------------------------------------------





//Updates Text from a Textbox onKeyup////////////////////////////////////////////////
function UpdateText(BoxID,BoxType,Table,IDColumn,Column,RowID)
{
	var SysOK = 'No';
	var Text
	
	//alert(BoxType+' '+BoxID);
	if(BoxType == 'List'){Text = CharsEncode(SelI(BoxID).value);}
	if(BoxType == 'ListTxt') {Obj = Gebi(BoxID);Text = (SelI(Obj.id).innerText); }
	if(BoxType == 'Text'){Text = CharsEncode(Gebi(BoxID).value);}
	if(BoxType == 'CheckBox'){Text = Gebi(BoxID).checked;}
	if(Table == 'Projects' || Table == 'ProjectPrint'){RowID = Gebi('HiddenProjID').value;}
	if(Table == 'Systems' && RowID == null){ RowID = SysID; SysOK = 'Yes';}
	
	//alert(Text);
	HttpText = 'OldEstimatesASP.asp?action=UpdateText&Text='+CharsEncode(Text)+'&Table='+Table+'&IDColumn='+IDColumn+'&Column='+Column+'&RowID='+RowID+'&SysOK='+SysOK+'&BoxID='+BoxID
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnUpdateText;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnUpdateText() 
{
   if (xmlHttp.readyState == 4)
	  {
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue.replace('--','');
			var Ok = xmlDoc.getElementsByTagName("Ok")[0].childNodes[0].nodeValue;
			//var Key = xmlDoc.getElementsByTagName("Key")[0].childNodes[0].nodeValue;
			var BoxID = xmlDoc.getElementsByTagName("BoxID")[0].childNodes[0].nodeValue;
			
			if(Ok == 'Yes'){UpdateAllItemCosting(SysID);}
			
			//var Text = Gebi(BoxID).value;
			//if(Key == 'Return'){Text += '<Br>'}
			
			//Gebi(BoxID).value = Text;
			
			//alert(Text);
		}
		else
		{
			AjaxErr('There was a problem with the UpdateText request. Your input might not have been saved.', HTTPText);
		}
	}
}
//-------------------------------------------------------------------------------------------------



//Updates whether or not to print a certain system//////////////////////////////////////////
function UpdateSystemPrint(SysID)
{
		var PrintChecked = Gebi('cb'+SysID).checked;
		//alert(PrintChecked+'  '+SysID);
		xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateSystemPrint;
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=UpdateSystemPrint&SysID='+SysID+'&PrintChecked='+PrintChecked, true);
	  xmlHttp.send(null);
}

function ReturnUpdateSystemPrint()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//var xmlDoc = xmlHttp.responseXML.documentElement;
			//var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
		}
		else
		{
			alert('There was a problem with the UpdateSystemPrint request.');
		}
	}
}
//-------------------------------------------------------------------------------------



function UpdateSqFtAdd(Checked)
{
	if(Checked)
	{
		SendSQL('Write','UPDATE Systems SET SqFootAdd=\'True\' WHERE SystemID='+SelectedSysID);
	}
	else
	{
		SendSQL('Write','UPDATE Systems SET SqFootAdd=\'False\' WHERE SystemID='+SelectedSysID);
	}
	CalculateEstTotal(SelectedSysID);
}

function UpdateRound(Checked)
{
	if(Checked)
	{
		SendSQL('Write','UPDATE Systems SET Round=\'True\' WHERE SystemID='+SelectedSysID);
	}
	else
	{
		SendSQL('Write','UPDATE Systems SET Round=\'False\' WHERE SystemID='+SelectedSysID);
	}
	CalculateEstTotal(SelectedSysID);
}

function UpdateIncludeSys(Checked)
{
	if(Checked)
	{
		SendSQL('Write','UPDATE Systems SET ExcludeSys=\'False\' WHERE SystemID='+SelectedSysID);
	}
	else
	{
		SendSQL('Write','UPDATE Systems SET ExcludeSys=\'True\' WHERE SystemID='+SelectedSysID);
	}
	CalculateEstTotal(SelectedSysID);
}

function ToggleFT(Checked)
{
	var TotalFixed=0;
	
	if(Checked){TotalFixed=1}
	SendSQL('Write','UPDATE Systems SET TotalFixed='+TotalFixed+' WHERE SystemID='+SysID)
		
	Gebi('MU').readOnly=Checked;
	Gebi('SystemTotal').readOnly=!Checked;
	
	if(Checked)
	{
		//Gebi('SystemTotal').focus();
		Gebi('MU').style.fontFamily='Arial, Helvetica, sans-serif';
		Gebi('MU').style.fontWeight='bold';
		Gebi('MU').style.fontSize='12px';
		//Gebi('MU').style.color='#1F300E'; 
		Gebi('SystemTotal').style.fontFamily='Consolas, "Courier New", Courier, monospace';
		Gebi('SystemTotal').style.fontWeight='normal';
		Gebi('SystemTotal').style.fontSize='13px';
		//Gebi('SystemTotal').style.color='#000'; 
	}
	else
	{
		//Gebi('MU').focus();
		Gebi('SystemTotal').style.fontFamily='Arial, Helvetica, sans-serif';
		Gebi('SystemTotal').style.fontWeight='bold';
		Gebi('SystemTotal').style.fontSize='12px';
		//Gebi('SystemTotal').style.color='#1F300E'; 
		Gebi('SystemTotal').style.textShadow='-1px -1px 1px #FFF,-1px -1px 1px #FFF';
		Gebi('MU').style.fontFamily='Consolas, "Courier New", Courier, monospace';
		Gebi('MU').style.fontWeight='normal';
		Gebi('MU').style.fontSize='13px';
		//Gebi('MU').style.color='#000'; 
	}
}



//Gets the Area List--////////////////////////////////////////////////

function GetAreaList()
{
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetAreaList;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=GetAreaList', true);
	xmlHttp.send(null);
}


function ReturnGetAreaList() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var ArrCount = xmlDoc.getElementsByTagName("ArrCount")[0].childNodes[0].nodeValue;
			
			
			for (i = 1; i < ArrCount; i++)
			{
				var sAreaID = 'AreaID'+i;
				var sAreaDescription = 'AreaDescription'+i;
				
				var AreaID = xmlDoc.getElementsByTagName(sAreaID)[0].childNodes[0].nodeValue;
				var AreaDescription = xmlDoc.getElementsByTagName(sAreaDescription)[0].childNodes[0].nodeValue;
				
				AreaArray[i] = new Array('',AreaID,AreaDescription);
			}
			
			
			for (var y = 1; y < ArrCount; y++)
			{
				var newOption = document.createElement("OPTION");
				Gebi('AreaSelect').options.add(newOption);
				newOption.value = AreaArray[y][1];
				newOption.innerText = AreaArray[y][2];
			} 
			
			// alert(EmployeeArray);
		}
		else
		{
			alert('There was a problem with the GetAreaList request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------




//Loads projects for selected area--////////////////////////////////////////////////
function LoadAreaProj()
{
	//Gebi('AreaList').style.display = block;
	var AreaID = SelI('AreaSearch').value;
	//alert(AreaID);
	HttpText='OldEstimatesASP.asp?action=LoadAreaProj&AreaID='+AreaID+'';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLoadAreaProj;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnLoadAreaProj() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			//var Test = xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue;
			//alert(Test);
			
			//var ProjName = xmlDoc.getElementsByTagName('ProjName')[0].childNodes[0].nodeValue;
			//var Area = xmlDoc.getElementsByTagName('Area')[0].childNodes[0].nodeValue;
			try{Gebi('ProjList').innerHTML = CharsDecode(xmlDoc.getElementsByTagName('HTMLList')[0].childNodes[0].nodeValue.replace('--',''));}
			catch(e){DebugBox(a(HttpText)+'<br/>'+e.msg)}
			
			//alert(AreaProjectList);
			onResize();
		}
		else
		{
			AjaxErr('There was a problem with the LoadAreaProj request. Continue?', HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------





//Gets the Customers Based on text input--////////////////////////////////////////////////

function GetCustomer(CustText)
{
	SearchCustID=0;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCustList;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=FindCust&CustText='+CustText+'', true);
	xmlHttp.send(null);
}



function ReturnCustList() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var Test = xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue;
			
			var CusList = xmlDoc.getElementsByTagName('Customers')[0].childNodes[0].nodeValue;
			
			Gebi('CustList').innerHTML = CusList;
			Gebi('CustomersBox').style.display = 'block';
			Gebi('CustList').style.display = 'block';
			//Gebi('ProjectsBox').style.display = 'block';
			
			//onResize();
		}
		else
		{
			alert('There was a problem with the GetCustomer request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------



//Gets the Customers Based on text input-- For the Add Customer-Bid To List//////////////////////////

function GetCustomerForBidTo()
{
		
		var CustText = Gebi('BidToCustomerSearchText').value;
		if (CustText == '') {return false;}
	  //var CustText = 're';
		//alert(CustText);
	  xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnGetCustomerForBidTo;
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=FindCust&CustText='+CustText+'', true);
	  xmlHttp.send(null);
		  
	  	
}



function ReturnGetCustomerForBidTo() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var Test = xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue;
			var CusList = xmlDoc.getElementsByTagName('BidToSearch')[0].childNodes[0].nodeValue;
			Gebi('BidToCustSearchList').innerHTML = CusList;
		}
		else
		{
			alert('There was a problem with the GetCustomerForBidTo request.');
		}
	}  
}
//-------------------------------------------------------------------------------------------------


//Gets the Customer list based on text input-- For the new project customer list//////////////////////////

function GetCustomerForNewProj()
{
		NewProjCustList.style.display='block'; 
		var CustText = Gebi('NewProjCustSearch').value;
		if (CustText == '') {return false;}
	  //var CustText = 're';
		//alert(CustText);
	  xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnGetCustomerForNewProj;
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=FindCust&CustText='+CustText+'', true);
	  xmlHttp.send(null);
}

function ReturnGetCustomerForNewProj()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var Test = xmlDoc.getElementsByTagName('Test')[0].childNodes[0].nodeValue;
			var CusList = xmlDoc.getElementsByTagName('NewProjCusts')[0].childNodes[0].nodeValue;
			Gebi('NewProjCustList').innerHTML = CusList;
		}
		else
		{
			alert('There was a problem with the GetCustomerForNewProj request.');
}	}	}
//-------------------------------------------------------------------------------------------------




//Gets the Projects based on a selected Customer--////////////////////////////////////////////////
var SearchCustID=0;
var SearchArea='Select';
function GetProjects()
{
	Gebi('CustList').style.display='none';
	SearchArea=SelI('AreaSearch').innerText;
	
	
	var DateFrom=Gebi('SearchDateFrom').value;
	var DateTo= new Date(Gebi('SearchDateTo').value);
	var Obtained;
	if(Gebi('ckShowObtained').checked){Obtained=1;}
	else{Obtained=0;}
	
	DateTo.setDate(DateTo.getDate()+1);	//This is so the search will include Today's stuff by default.
	DateTo=(DateTo.getMonth()+1)+'/'+DateTo.getDate()+'/'+DateTo.getFullYear();
	
	HttpText=encodeURI('OldEstimatesASP.asp?action=FindProj&CustID='+SearchCustID+'&Area='+SearchArea+'&DateFrom='+DateFrom+'&DateTo='+DateTo+'&Obtained='+Obtained);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnProjList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}


function ReturnProjList() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//Gebi("CostingBox").style.display = 'none';
			//Gebi("InfoBoxLeft").style.display = 'block';
			//Gebi("InfoLeftTab").style.background = '#40631D';
			//Gebi("CostingLeftTab").style.background = '#9FD26C';
			Gebi('EstimateMain').style.display = 'none';
			
			//DebugBox(xmlHttp.responseText,256,256,256,256);
			try{var xmlDoc = xmlHttp.responseXML.documentElement;}
			catch(e){AjaxErr('There was a problem with the GetProjects xml document.',HttpText);}
			
			//var ProjList = CharsDecode(xmlDoc.getElementsByTagName('Projects')[0].childNodes[0].nodeValue);
			var ProjCount = xmlDoc.getElementsByTagName('ProjCount')[0].childNodes[0].nodeValue;
			
			var ProjListHTML='';
			if(ProjCount>0)
			{
				var pID;
				var pName;
				var Color='';
				for(P=1;P<=ProjCount;P++)
				{
					pID=xmlDoc.getElementsByTagName('ProjID'+P)[0].childNodes[0].nodeValue;
					try
					{
						var Use2010Bidder=xmlDoc.getElementsByTagName('Use2010Bidder'+P)[0].childNodes[0].nodeValue.replace('--','');
						pID=xmlDoc.getElementsByTagName('ProjID'+P)[0].childNodes[0].nodeValue;
						pName=CharsDecode(xmlDoc.getElementsByTagName('ProjName'+P)[0].childNodes[0].nodeValue.replace('--',''));
					}
					catch(e)
					{
						AjaxErr('Problem with ReturnProjList Response',HttpText);
						return false;
					}
					
					if(Use2010Bidder!='True')
					{
						ProjListHTML+=	'<a href=javascript:Void(); onclick=OpenProject('+pID+'); class=ProjListItems style="color:'+Color+';" Title="'+pName+'">'+pName+'</a>'
						ProjListHTML+='</div>'
					}
				}
			}
			
			var CustName = xmlDoc.getElementsByTagName('Name')[0].childNodes[0].nodeValue;
			var CustID = xmlDoc.getElementsByTagName('CustomerID')[0].childNodes[0].nodeValue;
			
			//Gebi('ProjList').innerHTML = ProjList;
			Gebi('ProjList').innerHTML = ProjListHTML;
			
			Gebi('EstTopInfo3').innerHTML = CustName;
			
			Gebi('CustNameTag').innerHTML = CustName;
			Gebi('HiddenCustName').value = CustName;
			Gebi("ProjectBox").style.display = 'none';
			Gebi('HiddenCustID').value = CustID;
			Gebi('ProjectsBox').style.display = 'block';
			Gebi("ProjBox").style.display = 'block';
			 
			 
			Gebi('CustList').style.display='none';
			Gebi('CustomersBox').style.display='none';
		   
		}
		else {AjaxErr('There was a problem with the GetProjects request.',HttpText);}
	}
}
//-------------------------------------------------------------------------------------------------
















//Opens The Project--////////////////////////////////////////////////
var HasCust=false;

function OpenProject(ProjID)
{
	PGebi('oldBidderFrame').style.display='block'; 
	
	Gebi("ProjectOverlay").style.display = 'block';
	Gebi('ProjectOverlayTxt').innerHTML = 'Opening Project';
	
	HttpText='OldEstimatesASP.asp?action=OpenProject&ProjID='+ProjID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnOpenProject;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}


function ReturnOpenProject() 
{
	Gebi('ProjectOverlayTxt').innerHTML+='.';
	if (xmlHttp.readyState == 4)
	{
		Gebi('ProjectOverlayTxt').innerHTML+='...';
		if (xmlHttp.status == 200)
		{
			LoadEstimateLists();
			Gebi('ProjectBox').style.display = 'block';
			
			if (!xmlHttp.responseXML)
			{
				AjaxErr('Error: OpenProject ',HttpText);
				return false;
			}
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var ProjName = CharsDecode(xmlDoc.getElementsByTagName('Name')[0].childNodes[0].nodeValue.replace('-NotNull-',''));
			if (ProjName == ''){ProjName = 'Unamed Project';}
			Gebi('ProjectOverlayTxt').innerHTML = ProjName;
			var Systems = xmlDoc.getElementsByTagName('Systems')[0].childNodes[0].nodeValue;
			var IDarray = xmlDoc.getElementsByTagName('IDarray')[0].childNodes[0].nodeValue.replace('-NotNull-','');
			var NiftyIDarray = xmlDoc.getElementsByTagName('NiftyIDarray')[0].childNodes[0].nodeValue.replace('-NotNull-','');
			var ProjID = xmlDoc.getElementsByTagName('ProjID')[0].childNodes[0].nodeValue;
			var CustID = xmlDoc.getElementsByTagName('CustID')[0].childNodes[0].nodeValue.replace('-NotNull-','');
			Gebi('HiddenProjID').value = ProjID;
			Gebi('HiddenCustID').value = CustID;
			
			var Obtained = xmlDoc.getElementsByTagName('Obtained')[0].childNodes[0].nodeValue.replace('HasTheJob','')
			var Contract = xmlDoc.getElementsByTagName('Contract')[0].childNodes[0].nodeValue.replace('HasTheJob','')
			
			var BidToListHTML = xmlDoc.getElementsByTagName('BidToList')[0].childNodes[0].nodeValue;
			var ObtainWith = xmlDoc.getElementsByTagName('ObtainWith')[0].childNodes[0].nodeValue.replace('-NotNull-','');
			//alert(Obtained);
			
			HasCust=false;
			if(BidToListHTML!=null&&BidToListHTML!=''&&BidToListHTML!='-No Data-'){HasCust=true;}
			
			Gebi('EstTopInfo3').innerHTML=ObtainWith;
			if (Obtained == 1)
			{
				BidToListHTML = 'Job Obtained With: '+ObtainWith+'<br /> <div style="color:#888;">'+BidToListHTML+'</div>';
			}
			Gebi('BidToList').innerHTML = BidToListHTML;
			//alert(Obtained);
			if (Obtained == 1)
			{
				Gebi('HiddenJobObtained').checked = true; 
				//Gebi('ContractSigned').style.display = 'none';
				//Gebi('NewSysLink').style.display = 'none';
				Gebi('AddCustLink').style.display = 'none';
				Gebi('UnBidAllLink').style.display = 'none';
				//Gebi('UnContract').style.display = 'block';
				/** /
				Gebi('ProjectLock1').style.display = 'block';
				Gebi('ProjectLock2').style.display = 'block';
				Gebi('ProjectLock3').style.display = 'block';
				//Gebi('ProjectLock4').style.display = 'block';
				/**/
				Gebi('SystemLock').style.display = 'block';
				//disableALLtext();
				//Gebi('ProjectArea').readonly = true;
				//Gebi('ProjectFranchise').readonly = true;
				//Gebi('txt').readonly = true;
			}
			
			else
			{
				Gebi('HiddenJobObtained').checked = false;
				//Gebi('ContractSigned').style.display = 'block';
				Gebi('NewSysLink').style.display = 'block';
				//Gebi('UnContract').style.display = 'none';
				Gebi('UnBidAllLink').style.display = 'block';
				Gebi('AddCustLink').style.display = 'block';
				/** /
				Gebi('ProjectLock1').style.display = 'none';
				Gebi('ProjectLock2').style.display = 'none';
				Gebi('ProjectLock3').style.display = 'none';
				//Gebi('ProjectLock4').style.display = 'none';
				/**/
				Gebi('SystemLock').style.display = 'none';
				//enableALLtext();
				//Gebi('ProjectArea').readonly = false;
				//Gebi('ProjectFranchise').readonly = false;
				//Gebi('txt').readonly = false;
			}
			
			
			
			var ProjAddress = xmlDoc.getElementsByTagName('ProjAddress')[0].childNodes[0].nodeValue;
			var ProjCity = xmlDoc.getElementsByTagName('ProjCity')[0].childNodes[0].nodeValue;
			var ProjState = xmlDoc.getElementsByTagName('ProjState')[0].childNodes[0].nodeValue;
			var ProjZip = xmlDoc.getElementsByTagName('ProjZip')[0].childNodes[0].nodeValue;
			var DateEnt = xmlDoc.getElementsByTagName('DateEnt')[0].childNodes[0].nodeValue;
			var Area = xmlDoc.getElementsByTagName('Area')[0].childNodes[0].nodeValue;
			var Franchise = xmlDoc.getElementsByTagName('Franchise')[0].childNodes[0].nodeValue;
			var SubOf = xmlDoc.getElementsByTagName('SubOf')[0].childNodes[0].nodeValue;
			var OwnName = xmlDoc.getElementsByTagName('OwnName')[0].childNodes[0].nodeValue;
			var OwnContact = xmlDoc.getElementsByTagName('OwnContact')[0].childNodes[0].nodeValue;
			var OwnPhone1 = xmlDoc.getElementsByTagName('OwnPhone1')[0].childNodes[0].nodeValue;
			var OwnFax = xmlDoc.getElementsByTagName('OwnFax')[0].childNodes[0].nodeValue;
			var OwnEmail = xmlDoc.getElementsByTagName('OwnEmail')[0].childNodes[0].nodeValue;
			var Floors = xmlDoc.getElementsByTagName('Floors')[0].childNodes[0].nodeValue;
			var Rooms = xmlDoc.getElementsByTagName('Rooms')[0].childNodes[0].nodeValue;
			var ADArooms = xmlDoc.getElementsByTagName('ADArooms')[0].childNodes[0].nodeValue;
			var CeilingHeight = xmlDoc.getElementsByTagName('CeilingHeight')[0].childNodes[0].nodeValue;
			var ConstrType = xmlDoc.getElementsByTagName('ConstrType')[0].childNodes[0].nodeValue;
			var OccRating = xmlDoc.getElementsByTagName('OccRating')[0].childNodes[0].nodeValue;
			var OccLoad = xmlDoc.getElementsByTagName('OccLoad')[0].childNodes[0].nodeValue;
			var Wiring = xmlDoc.getElementsByTagName('Wiring')[0].childNodes[0].nodeValue;
			var Codes = xmlDoc.getElementsByTagName('Codes')[0].childNodes[0].nodeValue.replace('--','');
			var RCSNotes = CharsDecode(xmlDoc.getElementsByTagName('RCSNotes')[0].childNodes[0].nodeValue.replace('--',''));
			
			var LetterTitle = xmlDoc.getElementsByTagName('LetterTitle')[0].childNodes[0].nodeValue;
			var ScopeTitle = xmlDoc.getElementsByTagName('ScopeTitle')[0].childNodes[0].nodeValue;
			var PartsTitle = xmlDoc.getElementsByTagName('PartsTitle')[0].childNodes[0].nodeValue;
			var LaborTitle = xmlDoc.getElementsByTagName('LaborTitle')[0].childNodes[0].nodeValue;
			var SignedTCS = xmlDoc.getElementsByTagName('SignedTCS')[0].childNodes[0].nodeValue;
			var SignedCust = xmlDoc.getElementsByTagName('SignedCust')[0].childNodes[0].nodeValue;
			var PrintDate = xmlDoc.getElementsByTagName('PrintDate')[0].childNodes[0].nodeValue;
			var Addressing = xmlDoc.getElementsByTagName('Addressing')[0].childNodes[0].nodeValue;
			var Body = xmlDoc.getElementsByTagName('Body')[0].childNodes[0].nodeValue;
			while(Body != Body.replace('--RET--', '\r').replace('-COMMA-',',')){Body = Body.replace('--RET--', '\r').replace('-COMMA-',',');}
			var LegalNotes = xmlDoc.getElementsByTagName('LegalNotes')[0].childNodes[0].nodeValue;
			var PartsNotes = xmlDoc.getElementsByTagName('PartsNotes')[0].childNodes[0].nodeValue;
			var LaborNotes = xmlDoc.getElementsByTagName('LaborNotes')[0].childNodes[0].nodeValue;
			var TFP_TCS = xmlDoc.getElementsByTagName('TFP_TCS')[0].childNodes[0].nodeValue;
			var TFP = xmlDoc.getElementsByTagName('TFP')[0].childNodes[0].nodeValue;
			var TCS = xmlDoc.getElementsByTagName('TCS')[0].childNodes[0].nodeValue;
			var SystemTotals = xmlDoc.getElementsByTagName('SystemTotals')[0].childNodes[0].nodeValue;
			var LetterBody = xmlDoc.getElementsByTagName('LetterBody')[0].childNodes[0].nodeValue;
			var Includes = xmlDoc.getElementsByTagName('Includes')[0].childNodes[0].nodeValue;
			var Excludes = xmlDoc.getElementsByTagName('Excludes')[0].childNodes[0].nodeValue;
			var Notes = xmlDoc.getElementsByTagName('Notes')[0].childNodes[0].nodeValue;
			var Subtotal = xmlDoc.getElementsByTagName('Subtotal')[0].childNodes[0].nodeValue;
			var Tax = xmlDoc.getElementsByTagName('Tax')[0].childNodes[0].nodeValue;
			var Total = xmlDoc.getElementsByTagName('Total')[0].childNodes[0].nodeValue;
			var PartsDesc = xmlDoc.getElementsByTagName('PartsDesc')[0].childNodes[0].nodeValue;
			var PartsQty = xmlDoc.getElementsByTagName('PartsQty')[0].childNodes[0].nodeValue;
			var PartsPricing = xmlDoc.getElementsByTagName('PartsPricing')[0].childNodes[0].nodeValue;
			var PartsTotal = xmlDoc.getElementsByTagName('PartsTotal')[0].childNodes[0].nodeValue;
			var LaborDesc = xmlDoc.getElementsByTagName('LaborDesc')[0].childNodes[0].nodeValue;
			var LaborQty = xmlDoc.getElementsByTagName('LaborQty')[0].childNodes[0].nodeValue;
			var LaborPricing = xmlDoc.getElementsByTagName('LaborPricing')[0].childNodes[0].nodeValue;
			var LaborTotal = xmlDoc.getElementsByTagName('LaborTotal')[0].childNodes[0].nodeValue;
			
			Gebi('EstTopInfo1').innerHTML = '';
			Gebi('EstTopInfo2').innerHTML = ProjName;
			Gebi('ProjIDTxt').innerHTML = 'Project ID &nbsp; &nbsp;'+ProjID;
			Gebi('ProjSysTabs').innerHTML = CharsDecode(Systems);
			
			//alert(NiftyIDarray);
			var IDs = new Array;
			IDs = IDarray.split(',')
			for(W=1;W<IDs.length-1;W++)
			{
				//Gebi(IDs[W]).style.width = Gebi(IDs[W]).offsetWidth+'px';
				Gebi(IDs[W]).style.height = '24px';
			}
			//Nifty(NiftyIDarray,"medium transparent top");
			
			//Nifty('div#ProjBidToTitle,div#ProjMainTab,div#ProjPrintTab','large transparent top');
			Gebi('ProjMainTab').style.height='33px';
			Gebi('ProjMainTab').style.width='96px';
			Gebi('ProjPrintTab').style.height='33px';
			Gebi('ProjPrintTab').style.width='96px';
			//Nifty('div#InfoTab,div#PartsTab,div#LaborTab','large transparent top');

			//if(ProjectName == '0'){ProjectName = ''}
			if(ProjAddress == '0'){ProjAddress = ''}
			if(ProjCity == '0'){ProjCity = ''}
			if(ProjState == '0'){ProjState = ''}
			if(ProjZip == '0'){ProjZip = ''}
			if(DateEnt == '0'){DateEnt = ''}
			if(Area == '0'){Area = ''}
			if(Franchise == '0'){Franchise = ''}
			if(SubOf == '0'){SubOf = ''}
			if(OwnName == '0'){OwnName = ''}
			if(OwnContact == '0'){OwnContact = ''}
			if(OwnPhone1 == '0'){OwnPhone1 = ''}
			if(OwnFax == '0'){OwnFax = ''}
			if(OwnEmail == '0'){OwnEmail = ''}
			if(SqFoot == '0'){SqFoot = '0'}
			if(Floors == '0'){Floors = ''}
			if(Rooms == '0'){Rooms = ''}
			if(ADArooms == '0'){ADArooms = ''}
			if(CeilingHeight == '0'){CeilingHeight = ''}
			if(ConstrType == '0'){ConstrType = ''}
			if(OccRating == '0'){OccRating = ''}
			if(OccLoad == '0'){OccLoad = ''}
			if(Wiring == '0'){Wiring = ''}
			if(Codes == '0'){Codes = ''}
			
			var ObjArea = Gebi('ProjectArea');
			var ObjFran = Gebi('ProjectFranchise');
			ObjArea[ObjArea.selectedIndex].text = Area;
			ObjFran[ObjFran.selectedIndex].text = Franchise;
			
			Gebi('ProjectName').value = ProjName;
			Gebi('ProjAddress').value = ProjAddress;
			Gebi('ProjCity').value = ProjCity;
			Gebi('ProjState').value = ProjState;
			Gebi('ProjZip').value = ProjZip;
			Gebi('DateEnt').value = DateEnt;
			Gebi('SubOf').value = SubOf;
			Gebi('OwnName').value = OwnName;
			Gebi('OwnContact').value = OwnContact;
			Gebi('OwnPhone1').value = OwnPhone1;
			Gebi('OwnFax').value = OwnFax;
			Gebi('OwnEmail').value = OwnEmail;
			Gebi('Floors').value = Floors;
			Gebi('Rooms').value = Rooms;
			Gebi('ADArooms').value = ADArooms;
			Gebi('CeilingHeight').value = CeilingHeight;
			Gebi('ConstrType').value = ConstrType;
			Gebi('OccRating').value = OccRating;
			Gebi('OccLoad').value = OccLoad;
			Gebi('Wiring').value = Wiring;
			Gebi('Codes').value = Codes;
			Gebi('ProjNotes').value=RCSNotes;
			
			Gebi('HiddenProjName').value = ProjName;
			Gebi('HiddenProjID').value = ProjID;
			Gebi('HiddenCustID').value = CustID;
			
			if(LetterTitle == '0'){LetterTitle = ''}
			if(ScopeTitle == '0'){ScopeTitle = ''}
			if(PartsTitle == '0'){PartsTitle = ''}
			if(LaborTitle == '0'){LaborTitle = ''}
			if(SignedTCS == '0'){SignedTCS = ''}
			if(SignedCust == '0'){SignedCust = ''}
			if(PrintDate == '0'){PrintDate = ''}
			if(Addressing == '0'){Addressing = ''}
			if(Body == '0'){Body = ''}
			if(LegalNotes == '0'){LegalNotes = ''}
			if(PartsNotes == '0'){PartsNotes = ''}
			if(LaborNotes == '0'){LaborNotes = ''}
			
			Gebi('LetterTitle').value = LetterTitle;
			Gebi('ScopeTitle').value = ScopeTitle;
			Gebi('PartsTitle').value = PartsTitle;
			Gebi('LaborTitle').value = LaborTitle;
			Gebi('SignedTCS').value = SignedTCS;
			Gebi('SignedCust').value = SignedCust;
			Gebi('PrintDate').value = PrintDate;
			//Gebi('Addressing').value = Addressing;
			Gebi('Body').value = Body;
			Gebi('LegalNotes').value = LegalNotes;
			//Gebi('PartsNotes').value = PartsNotes;
			//Gebi('LaborNotes').value = LaborNotes;
			if(TFP_TCS == 'True'){Gebi('TFP_TCS').checked = true;}
			if(TFP_TCS == 'False'){Gebi('TFP_TCS').checked = false;}
			if(TFP == 'True'){Gebi('TFP').checked = true;}
			if(TFP == 'False'){Gebi('TFP').checked = false;}
			if(TCS == 'True'){Gebi('TCS').checked = true;}
			if(TCS == 'False'){Gebi('TCS').checked = false;}
			if(SystemTotals == 'True'){Gebi('SystemTotals').checked = true;}
			if(SystemTotals == 'False'){Gebi('SystemTotals').checked = false;}
			if(LetterBody == 'True'){Gebi('LetterBody').checked = true;}
			if(LetterBody == 'False'){Gebi('LetterBody').checked = false;}
			if(Includes == 'True'){Gebi('Includes').checked = true;}
			if(Includes == 'False'){Gebi('Includes').checked = false;}
			if(Excludes == 'True'){Gebi('Excludes').checked = true;}
			if(Excludes == 'False'){Gebi('Excludes').checked = false;}
			if(Notes == 'True'){Gebi('pNotes').checked = true;}
			if(Notes == 'False'){Gebi('pNotes').checked = false;}
			if(Subtotal == 'True'){Gebi('pSubtotal').checked = true;}
			if(Subtotal == 'False'){Gebi('pSubtotal').checked = false;}
			if(Tax == 'True'){Gebi('pTax').checked = true;}
			if(Tax == 'False'){Gebi('pTax').checked = false;}
			if(Total == 'True'){Gebi('pTotal').checked = true;}
			if(Total == 'False'){Gebi('pTotal').checked = false;}
/*			if(PartsDesc == 'True'){Gebi('PartsDesc').checked = true;}
			if(PartsDesc == 'False'){Gebi('PartsDesc').checked = false;}
			if(PartsQty == 'True'){Gebi('PartsQty').checked = true;}
			if(PartsQty == 'False'){Gebi('PartsQty').checked = false;}
			if(PartsPricing == 'True'){Gebi('PartsPricing').checked = true;}
			if(PartsPricing == 'False'){Gebi('PartsPricing').checked = false;}
			if(PartsTotal == 'True'){Gebi('PartsTotal').checked = true;}
			if(PartsTotal == 'False'){Gebi('PartsTotal').checked = false;}
			if(LaborDesc == 'True'){Gebi('LaborDesc').checked = true;}
			if(LaborDesc == 'False'){Gebi('LaborDesc').checked = false;}
			if(LaborQty == 'True'){Gebi('LaborQty').checked = true;}
			if(LaborQty == 'False'){Gebi('LaborQty').checked = false;}
			if(LaborPricing == 'True'){Gebi('LaborPricing').checked = true;}
			if(LaborPricing == 'False'){Gebi('LaborPricing').checked = false;}
			if(LaborTotal == 'True'){Gebi('LaborTotal').checked = true;}
			if(LaborTotal == 'False'){Gebi('LaborTotal').checked = false;}
/**/	
			ProjTabArray.length=0;
				 
			IDarray=IDarray.substr(0,IDarray.length-1); //Removes the extra comma on the end
			IDarray=IDarray.replace(/\"/g,"")
				 
			var divArray = IDarray.split(','); //Splits up comma separated values into an array
				
			for(var i=0; i<divArray.length; i++)
			{
				ProjTabArray[i] = (divArray[i]);
			}
			
			//Nifty("div#ProjMainTab,div#ProjPrintTab,div#ProjBidToTitle","medium transparent top");
		
			ProjTabs('ProjectMainBox','ProjMainTab');
			
			Gebi('ProjInfoBox').style.display='none';                                                     //This is a workaround for a bug that
			setTimeout("Gebi('ProjInfoBox').style.display='block'; ShowProj(); CalcProjTotals();",1000);  // hides all of the Proj. Info on the
																																																		// very 1st time a project is loaded.
			
			
			onResize();
			/**/
			//ShowTabBids();
		
		}
		else
		{
			AjaxErr('There was a problem with the OpenProject request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////
	function ShowProj() {	Gebi("ProjectOverlay").style.display = 'none';	}
	//----------------------------------------------------------------------------------------
	
	
	
//Creates a new Project--////////////////////////////////////////////////

function NewProject()
{
	var ProjName = Gebi("ProjName").value;
	var CustID = Gebi("HiddenCustID").value;
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewProject;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=NewProject&ProjName='+ProjName+'&CustID='+CustID+'', true);
	xmlHttp.send(null);
}

function ReturnNewProject() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var Event = xmlDoc.getElementsByTagName('Event')[0].childNodes[0].nodeValue;
			var CustID = xmlDoc.getElementsByTagName('CustID')[0].childNodes[0].nodeValue;
			
			CloseProjNewBox();
			GetProjects(CustID);
		}
		else
		{
			alert('There was a problem with the NewProject request.');
}	}	}

//-------------------------------------------------------------------------------------------------



//Saves a new project////////////////////////////////////////////////

function NewProjSave()
{
	HttpText='';
	var ProjName = CharsEncode(Gebi('NewProjName').value);
	//alert(ProjName);
//	var ProjCust = CharsEncode(Gebi('NewProjCustomer').value);
//	var ProjCustID = Gebi('NewProjCustID').value;
	var ProjAddress = CharsEncode(Gebi('NewProjAddress').value);
	var ProjCity = CharsEncode(Gebi('NewProjCity').value);
	var ProjState = CharsEncode(Gebi('NewProjState').value);
	var ProjZip = CharsEncode(Gebi('NewProjZip').value);
	var SqFoot = CharsEncode(Gebi('NewProjSqFoot').value);
	var Floors = CharsEncode(Gebi('NewProjFloors').value);
	var Area = CharsEncode(Gebi('NewProjArea')[Gebi('NewProjArea').selectedIndex].innerText);
	var Franchise = CharsEncode(Gebi('NewProjFran')[Gebi('NewProjFran').selectedIndex].innerText);
	var SubOf = CharsEncode(Gebi('NewProjSubOf').value);
	//alert(Area);	return false;
	
	
	

	if(ProjName == ''){alert('A project name is required.'); return false;}
	//if(ProjCust == ''){alert('Customer is required.'); return false;}
	//if(ProjCustID== '')
	//{
	//	//alert('-Error- Please Re-select Customer');
	//	//return false;
	//	ProjCustID=0;
	//}
	/*
	if(ProjAddress == ''){alert('Address is required.'); return false;}
	if(ProjCity == ''){alert('City is required.'); return false;}
	*/
	if(ProjState==''){alert('State is required.'); return false;}
	if(toString(ProjState)=='undefined'){alert('State is required.'); return false;}
	/*
	if(ProjZip == ''){alert('Zip is required.'); return false;}
	if(SqFoot == ''){alert('Square Footage is required.'); return false;}
	*/
	if(Area == ''){alert('Area is required.'); return false;}
	if(isNaN(Floors*1)||Floors==''){alert('Number of Floors is required and must be a number.'); return false;}
	if(Franchise == ''){alert('Franchise is required.'); return false;}
		
		
	//alert('Hi');
	  
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnNewProjSave;
	HttpText = HttpText +'OldEstimatesASP.asp?action=NewProjSave&ProjName=' + ProjName;
//	HttpText = HttpText +'&ProjCust='+ProjCust;
//	HttpText = HttpText +'&ProjCustID='+ProjCustID;
	HttpText = HttpText +'&ProjAddress='+ProjAddress;
	HttpText = HttpText +'&ProjCity='+ProjCity;
	HttpText = HttpText +'&ProjState='+ProjState;
	HttpText = HttpText +'&ProjZip='+ProjZip;
	HttpText = HttpText +'&SqFoot='+SqFoot.replace(/,/g, '');
	HttpText = HttpText +'&Floors='+Floors;
	HttpText = HttpText +'&Area='+Area;
	HttpText = HttpText +'&Franchise='+Franchise;
	HttpText = HttpText +'&SubOf='+SubOf;
	
/**/
	//alert(HttpText);
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);

	//DebugBox(a(HttpText),400,400);
}


function ReturnNewProjSave() 
{
	
	
	if (xmlHttp.readyState == 4)
	{
	
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var CustID = xmlDoc.getElementsByTagName('CustID')[0].childNodes[0].nodeValue;
			//var CustName = CharsDecode(xmlDoc.getElementsByTagName('CustName')[0].childNodes[0].nodeValue.replace('--',''));
			var DidWrite = xmlDoc.getElementsByTagName('DidWrite')[0].childNodes[0].nodeValue;
						
			CloseNewProjBox();
			try{LoadAreaProj();}catch(e){}
			if (DidWrite == 1)
			{
				//AddBidToCust(CustID, CustName);	
				OpenProject(xmlDoc.getElementsByTagName('LastProjID')[0].childNodes[0].nodeValue);

				Gebi('NewProjName').value = '';
				//Gebi('NewProjCustomer').value = '';
				//Gebi('NewProjCustID').value = '';
				Gebi('NewProjAddress').value = '';
				Gebi('NewProjCity').value = '';
				Gebi('NewProjState').value = '';
				Gebi('NewProjZip').value = '';
				Gebi('NewProjSqFoot').value = '';
				Gebi('NewProjFloors').value = '';
				Gebi('NewProjArea').selectedIndex = 0;
				Gebi('NewProjFran').selectedIndex = 0;
				Gebi('NewProjSubOf').value = '';
				
				
				DebugBox(xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue);
			}
			else
			{
				alert('Error - New Project not saved')
			}
		}
		else
		{
			CloseNewProjBox();
			AjaxErr('There was a problem with the NewProjSave request. \n The project may or may not have been created. \n\n OK to continue',HttpText)
			LoadAreaProj();
		}
	}
}
//-------------------------------------------------------------------------------------------------





//Removes a customer from Bid To//////////////////////////////////
function UnBidTo(CustName)
{
	if (confirm('Removing  '+CustName+'  from "Bid To" List - Are you sure?') == false) {return false}

	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnUnBidTo;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=UnBidTo&CustName='+CustName+'&ProjID='+HiddenProjID.value, true);
	xmlHttp.send(null);
}


function ReturnUnBidTo() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var Removed = xmlDoc.getElementsByTagName("Removed")[0].childNodes[0].nodeValue;
			alert('Removed: ' & Removed);
			OpenProject(HiddenProjID.value);
		}
		else
		{
			alert('There was a problem with the UnBidTo request.');
}	}	}
//------------------------------------------------------

//Removes a customer from Bid To//////////////////////////////////
function UnBidToAll()
{
	if (confirm('This will remove all entries in the Bid To List. Are you sure?') == false) {return false}

	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnUnBidTo;
	xmlHttp.open("Get","OldEstimatesASP.asp?action=UnBidTo&CustName=--ALL--&ProjID="+HiddenProjID.value, true);
	xmlHttp.send(null);
}


function ReturnUnBidTo() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var Removed = xmlDoc.getElementsByTagName("Removed")[0].childNodes[0].nodeValue;
			//alert('Removed: ' & Removed);
			OpenProject(HiddenProjID.value);
		}
		else
		{
			alert('There was a problem with the UnBidToAll request.');
}	}	}
//------------------------------------------------------

//Add a Customer to the Bid To List/////////////////////////////////////////////////////

function AddBidToCust(CustomerID,CustName,Contact)
{
	var ProjName = Gebi('ProjectName').value;
	//alert(CustomerID);
	HttpText =encodeURI('OldEstimatesASP.asp?action=AddBidToCust&ProjID='+HiddenProjID.value+'&Contact='+Contact+'&ProjName='+CharsEncode(ProjName)+'&CustID='+CustomerID+'&CustName='+CustName);
	//DebugBox(a(Http));
	//alert(CustID+','+CustName);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnAddBidToCust;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);

}
function ReturnAddBidToCust()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//alert('Howdy');
			BidToAddClose();
			OpenProject(HiddenProjID.value);
			
			//DebugBox(xmlHttp.responseXML,100,200,0,0);

			//var xmlDoc = xmlHttp.responseXML.documentElement;
			//var Removed = xmlDoc.getElementsByTagName("Removed")[0].childNodes[0].nodeValue;
			//alert('Removed: ' & Removed);
		}
		else
		{
			AjaxErr('There was a problem with the AddBidToCust request.',HttpText);
}	}	}
//--------------------------------------------------------------------------------------



//Obtains a Bid--////////////////////////////////////////////////

function ObtainBid()
{
	//var ObtainedWithDropDown = Gebi('ObtainWith')
	var CustName = SelI('ObtainWith').innerText;
	var CustID = SelI('ObtainWith').value;
	//alert(CustID+' '+CustName); return false;
	var ProjName = Gebi('ProjectName').value;
	var ProjID = Gebi('HiddenProjID').value;
		
		//if(NewSysTax == ''){alert('Please Fill out the Tax Box'); return false;}
		
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnObtainBid;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=ObtainBid&ProjID='+ProjID+'&ProjName='+ProjName+'&CustName='+CustName+'&CustID='+CustID, true);
	xmlHttp.send(null);
}


function ReturnObtainBid() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			//var xmlDoc = xmlHttp.responseXML.documentElement;
			
			//var CustID = xmlDoc.getElementsByTagName('CustID')[0].childNodes[0].nodeValue;
			//var ProjID = xmlDoc.getElementsByTagName('ProjID')[0].childNodes[0].nodeValue;
			
			CloseObtainBidModal();
			OpenProject(HiddenProjID.value);
		}
		else
		{
		alert('There was a problem with the ObtainBid request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------




//Puts a system into a contract//////////////////////////////
function Contract(isSigned)
{
	var SysID=Gebi('SysInfoFrame').contentWindow.SysID;
	
	if(isSigned)
	{
		if(confirm('Locking this system'))
		{
			
			if(!HasCust)
			{
				if(confirm('At least 1 Bid-To customer is needed in order to contract a system. \n\n Would you like to choose one now?'))
				{
					ProjTabs('ProjectMainBox','ProjMainTab');
					BidToAdd();
				}
				else
				{
					Gebi('ckContract').checked=false;
				}
			}
			else
			{
				var SQL='UPDATE Systems SET Obtained=1 WHERE SystemID='+SysID
				SendSQL('Write',SQL)
				
				if(!Gebi('HiddenJobObtained').checked){ObtainBidModal();}
				else{GetSystemEdit(SysID);}
			}
		}
		else
		{
			Gebi('ckContract').checked=false;
		}
	}
	else
	{
		if(!confirm('Under normal circumstances you shouldn\'t edit a contracted system! \n\n Press cancel to leave it alone. Press ok to edit it anyway. \n\n Note:If you choose to make this system editable and there are no contracted systems left, the entire project will be de-activated.'))
		{
			Gebi('ckContract').checked=true;
			return false;
		}
		
		HttpText='EstimatesASP.asp?action=Contract&ProjID='+parent.ProjID+'&SysID='+SysID
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnContract;
		xmlHttp.open('Get',HttpText, true);
		xmlHttp.send(null);
	}
}

function ReturnContract()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			try{var xmlDoc = xmlHttp.responseXML.documentElement;}
			catch(e){AjaxErr('Contract Response Error: Null XML Document',HttpText)}
			
			var WasOnlySys = xmlDoc.getElementsByTagName('IsOnlySys')[0].childNodes[0].nodeValue.replace('--','');
			var SysID = xmlDoc.getElementsByTagName('SysID')[0].childNodes[0].nodeValue.replace('--','');
			
			if(WasOnlySys==1)
			{
				//alert('The only contracted system has been uncontracted, so the entire project is no longer active.');
				SendSQL('Write','UPDATE Systems SET Obtained=\'False\' WHERE SystemID='+SysID);
				UnContract();
			}
			GetSystemEdit(SysID);
		}
		else
		{
			AjaxErr('There was a problem with the Contract request.',HttpText);
		}
	}
}
//------------------------------



//Obtains a Bid--////////////////////////////////////////////////

function UnContract()
{
	var ProjName = Gebi('ProjectName').value;
	var ProjID = Gebi('HiddenProjID').value;
		
		//if(NewSysTax == ''){alert('Please Fill out the Tax Box'); return false;}
		
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnUnContract;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=UnContract&ProjID='+ProjID, true);
	xmlHttp.send(null);
}


function ReturnUnContract() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{	//var xmlDoc = xmlHttp.responseXML.documentElement;
			//var CustID = xmlDoc.getElementsByTagName('CustID')[0].childNodes[0].nodeValue;
			//var ProjID = xmlDoc.getElementsByTagName('ProjID')[0].childNodes[0].nodeValue;
			OpenProject(Gebi('HiddenProjID').value);
		}
		else
		{alert('There was a problem with the UnContract request.');}
	}
}
//-------------------------------------------------------------------------------------------------


//Gets the BidTo List--////////////////////////////////////////////////

function GetBidTo()
{
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetBidTo;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=GetBidTo&ProjID='+HiddenProjID.value, true);
	xmlHttp.send(null);
}


function ReturnGetBidTo() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var BidCount = xmlDoc.getElementsByTagName("BidCount")[0].childNodes[0].nodeValue;
			
			
			for (i = 1; i < BidCount; i++)
			{
				//var sCustID = 'CustID'+i;
				//var sCustName = 'CustName'+i;
				
				var CustID = xmlDoc.getElementsByTagName('CustID'+i)[0].childNodes[0].nodeValue;
				var CustName = xmlDoc.getElementsByTagName('CustName'+i)[0].childNodes[0].nodeValue;
				//alert(getElementsByTagName('root')[0].childNodes[0].nodeValue;)
				BidArray[i] = new Array('',CustID,CustName);
			}
			
			Gebi('ObtainWithContainer').innerHTML = '<select style="width:100%; float:left; clear:both;" id="ObtainWith" onChange=""></select>';
			for (var y = 1; y < BidCount; y++)
			{
				var newOption = document.createElement("OPTION");
				ObtainWith.options.add(newOption);
				newOption.value = BidArray[y][1];
				newOption.innerText = BidArray[y][2];
			} 
			
		}
		else
		{
			alert('There was a problem with the GetBidTo request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------






//Creates a new Bid--////////////////////////////////////////////////

function NewSystem()
{
		var NewSysEnteredBy = Gebi("NewSysEnteredBy")[Gebi("NewSysEnteredBy").selectedIndex].value;
		var NewSysName = Gebi("NewSysName").value;
		var NewSysDate = Gebi("NewSysDate").value;
		var NewSysMU = Gebi("NewSysMU").value;
		var NewSysTax = Gebi("NewSysTax").value;
		var CustID = Gebi("HiddenCustID").value; if ((CustID == null)||(CustID == '')){CustID=0}
		var ProjID = Gebi("HiddenProjID").value;
		
		if(NewSysEnteredBy == ''){alert('Please Fill out the Entered By Box'); return false;}
		if(NewSysName == ''){alert('Please Fill out the System Name Box'); return false;}
		if(NewSysDate == ''){alert('Please Fill out the Date Box'); return false;}
		if(NewSysMU == ''){alert('Please Fill out the Margin Box'); return false;}
		if(NewSysTax == ''){alert('Please Fill out the Tax Box'); return false;}
		
		//alert('NewSysEnteredBy='+NewSysEnteredBy+'&NewSysName='+NewSysName+'&NewSysDate='+NewSysDate+'&NewSysMU='+NewSysMU+'&NewSysTax='+NewSysTax+'&ProjID='+ProjID+'&CustID='+CustID);
		
		HttpText='OldEstimatesASP.asp?action=NewSystem&NewSysEnteredBy='+NewSysEnteredBy+'&NewSysName='+NewSysName+'&NewSysDate='+NewSysDate+'&NewSysMU='+NewSysMU+'&NewSysTax='+NewSysTax+'&ProjID='+ProjID+'&CustID='+CustID+'';
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnNewBid;
		xmlHttp.open('Get',HttpText, true);
		xmlHttp.send(null);
}


function ReturnNewBid() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var Event = xmlDoc.getElementsByTagName('Event')[0].childNodes[0].nodeValue;
			var ProjID = xmlDoc.getElementsByTagName('ProjID')[0].childNodes[0].nodeValue;
			
			CloseNewSystemModal();
			OpenProject(ProjID);
		}
		else
		{
			AjaxErr('There was a problem with the NewSystem request. The system might or might not have been created. \n\n Continue?',HttpText);
			OpenProject(ProjID);
		}
	}
}
//-------------------------------------------------------------------------------------------------













//Gets the System based on a selected BID--////////////////////////////////////////////////
var SelectedSysID=0;
function GetSystemEdit(SysID)
{
	SelectedSysID=SysID;
	HttpText='OldEstimatesASP.asp?action=OpenSystem&SysID='+SysID;
	Gebi("SystemOverlay").style.display = 'block';
	Gebi('SystemOverlayTxt').innerHTML = 'Just A Moment Please';
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetSystem;
	xmlHttp.open('Get',HttpText,false);
	xmlHttp.send(null);
}
function ReturnGetSystem() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			if(xmlHttp.responseXML==null)
			{
				AjaxErr('Error: GetSystemEdit',HttpText);
				return false;
			}
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var SysID = xmlDoc.getElementsByTagName('SysID')[0].childNodes[0].nodeValue;
			Gebi('HiddenEstID').value = SysID;
			SelectedSysID=SysID;
			
			if(InsideFrame)
			{
				var System = CharsDecode(xmlDoc.getElementsByTagName('System')[0].childNodes[0].nodeValue);
				var DateEntered = xmlDoc.getElementsByTagName('DateEntered')[0].childNodes[0].nodeValue.replace('--Null--','');
				var DateBid = xmlDoc.getElementsByTagName('DateBid')[0].childNodes[0].nodeValue.replace('--','');
				var DateWon = xmlDoc.getElementsByTagName('DateWon')[0].childNodes[0].nodeValue.replace('--','');
				var EnteredBy = xmlDoc.getElementsByTagName('EnteredBy')[0].childNodes[0].nodeValue.replace('--EntBy--','');
				var EnteredByID = xmlDoc.getElementsByTagName('EnteredByID')[0].childNodes[0].nodeValue;
				try{var Notes = CharsDecode(xmlDoc.getElementsByTagName('Notes')[0].childNodes[0].nodeValue).replace('--','');}
				catch(e){var Notes = e.description}
				var RCSNotes = CharsDecode(xmlDoc.getElementsByTagName('RCSNotes')[0].childNodes[0].nodeValue).replace('--','');
				var IncludesText = CharsDecode(xmlDoc.getElementsByTagName('Includes')[0].childNodes[0].nodeValue).replace('--','');
				var ExcludesText = CharsDecode(xmlDoc.getElementsByTagName('Excludes')[0].childNodes[0].nodeValue).replace('--','');
				var TaxR = CharsDecode(xmlDoc.getElementsByTagName('TaxRate')[0].childNodes[0].nodeValue);
				var MU = xmlDoc.getElementsByTagName('MU')[0].childNodes[0].nodeValue;
				
				var Obtained=xmlDoc.getElementsByTagName('Obtained')[0].childNodes[0].nodeValue;
				
				Gebi('EstTopInfo1').innerHTML = System;
				Gebi('SystemOverlayTxt').innerHTML = System;
				
				Gebi('SystemTxt').value = System;
				Gebi('DateCreatedTxt').value = DateEntered;
				Gebi('DateBid').value = DateBid;
				Gebi('DateWon').value = DateWon;
				Gebi('BidText').value = Notes;
				Gebi('RCSBidText').value = RCSNotes;
				Gebi('IncludesText').value = IncludesText;
				Gebi('ExcludesText').value = ExcludesText;
				
				Gebi('TaxRate').value = TaxR;
				Gebi('MU').value = MU;
				
				var NoEntBy=true;
				for(i=0;i<Gebi('EnteredBy').length;i++)
				{	if(Gebi('EnteredBy')[i].value==EnteredByID){Gebi('EnteredBy').selectedIndex=i;	NoEntBy=false;}}
				if(NoEntBy){	Gebi('EnteredBy').selectedIndex=0;	SelI('EnteredBy').innerText='Anonymous';}
				return false;
			}
			
			PartsList(SysID); 
			setTimeout("LaborList("+SysID+");",1000);
			setTimeout("UncheckAll();",1500);
			
			Gebi("EstimateMain").style.display = 'block';
			
			setTimeout("ShowEst();",750);
			
			ShowSysTab('InfoTab');

			Gebi('SysInfoFrame').src='OldEstimatesSysInfo.asp?SysID='+SysID
			Gebi('SysExpFrame').src='OldEstimatesSysExpenses.asp?SysID='+SysID
			Gebi('SysAltsFrame').src='OldEstSysAlts.asp?SysID='+SysID
		}
		else
		{
			AjaxErr('There was a problem with the GetSystemEdit request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------

function ShowEst()
{
	Gebi("SystemOverlay").style.display = 'none';	
}







//Gets the list of parts associated with an Estimate--////////////////////////////////////////////////

function PartsList(SysID)
{
	HttpText='OldEstimatesASP.asp?action=PartsList&SysID='+SysID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnPartsList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnPartsList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			if(xmlHttp.responseXML==null)
			{
				AjaxErr('Error: GetSystemEdit',HttpText);
				return false;
			}
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			try{var Parts = xmlDoc.getElementsByTagName('Parts')[0].childNodes[0].nodeValue.replace('--','');}
			catch(e)	{	AjaxErr('There was an issue with the PartsList request.',HttpText);		return false;}
			
			try{Gebi('PartsTabMain').innerHTML = Parts;}
			catch(e){parent.Gebi('PartsTabMain').innerHTML = Parts;}
			
			CalculateEstTotal();
		}
		else
		{
			AjaxErr('There was a problem with the PartsList request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------











//Gets the list of parts associated with an Estimate--////////////////////////////////////////////////

function LaborList(SysID)
{
	HttpText='OldEstimatesASP.asp?action=LaborList&SysID='+SysID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLaborList;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnLaborList()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			if(!xmlHttp.responseXML)
			{
				AjaxErr('Error: GetSystemEdit',HttpText);
				return false;
			}
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var Labor = xmlDoc.getElementsByTagName('Labor')[0].childNodes[0].nodeValue.replace('--NotNull--','');
			try{Gebi('LaborTabMain').innerHTML = Labor;}
			catch(e){parent.Gebi('LaborTabMain').innerHTML = Labor;}
			CalculateEstTotal();
		}
		else
		{
			AjaxErr('There was a problem with the LaborList request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------












//Updates the Project Active Status--////////////////////////////////////////////////

function ToggleActiveProject(ProjID,Active)
{
	if(Active == 0){var answer = confirm('You have chosen to Place this Project into INACTIVE status, press ok to continue')}
	if(Active == 1){var answer = confirm('You have chosen to Place this Project into OBTAINED and ACTIVE status, press ok to continue')}


	if (answer)
	{
		//alert(ProjID);
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnToggleActiveProject;
		xmlHttp.open('Get','OldEstimatesASP.asp?action=ToggleActiveProject&ProjID='+ProjID+'&Active='+Active, true);
		xmlHttp.send(null);
	}
	else
	{
		return;
	}
}




function ReturnToggleActiveProject() 
{
	if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	    {
		  var xmlDoc = xmlHttp.responseXML.documentElement;
		  
		  parent.ProjectsIframe.ProjectList(); // Updates the project list in the Projects Iframe
		  
		  var CustID = Gebi("HiddenCustID").value;
		  
		  GetProjects(CustID);
		  
			
         }
		 else
		 {
            alert('There was a problem with the ToggleActiveProject request.');
         }
      }
}

//-------------------------------------------------------------------------------------------------





//Updates the System Active Status--////////////////////////////////////////////////

function ToggleActiveSystem(ProjID,Active)
{
	if(Active == 0){var answer = confirm('Put System in ACTIVE Status')}
	if(Active == 1){var answer = confirm('DEACTIVATE System')}


	if (answer)
	{
		//alert(ProjID);
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnToggleActiveSystem;
		xmlHttp.open('Get','OldEstimatesASP.asp?action=ToggleActiveProject&ProjID='+ProjID+'&Active='+Active, true);
		xmlHttp.send(null);
	}
	else
	{
		return;
	}
}




function ReturnToggleActiveSystem() 
{
	if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	    {
		  var xmlDoc = xmlHttp.responseXML.documentElement;
		  
		  parent.ProjectsIframe.ProjectList();
		  
		  var CustID = Gebi("HiddenCustID").value;
		  GetProjects(CustID);
		  
			
         }
		 else
		 {
            alert('There was a problem with the ToggleActiveSystem request.');
         }
      }
}

//-------------------------------------------------------------------------------------------------












//Updates the Project Active Status--////////////////////////////////////////////////

function CheckBoxSysUpdate(SysID)
{
	  var CBID = 'CB'+SysID;
	
      var CheckedOrNot = Gebi(CBID).checked;
	  
	  if (CheckedOrNot == true){Checked = 1; var Text = 'You have chosen to Place this System into OBTAINED status, press ok to continue';}
	  if (CheckedOrNot == false){Checked = 0; var Text = 'You have chosen to Place this Project into INACTIVE status, press ok to continue';}
	  
	 
	  
	    var answer = confirm(Text)
		
		if (answer)
		{
			xmlHttp = GetXmlHttpObject();
			xmlHttp.open('Get','OldEstimatesASP.asp?action=CheckBoxSysUpdate&SysID='+SysID+'&Checked='+Checked, true);
			xmlHttp.send(null);
		}
		else
		{
			
		   if(CheckedOrNot == true){Gebi(CBID).checked = false;}
		   if(CheckedOrNot == false){Gebi(CBID).checked = true;}
		
		}



}

//-------------------------------------------------------------------------------------------------
















//Updates the Estimating Info Screen on keyup--////////////////////////////////////////////////

function UpdateSystemInfo(ObjectName,SQLName,Type)
{
	
      var ObjValue = Gebi(ObjectName).value;
      var SysID = Gebi("HiddenEstID").value;
	  
	  if (Type == 'List'){var DropObj = Gebi(ObjectName);    var ObjValue = (DropObj[DropObj.selectedIndex].value);}
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=UpdateSystem&SysID='+SysID+'&SQLName='+SQLName+'&ObjValue='+ObjValue+'', true);
	  xmlHttp.send(null);
}


//-------------------------------------------------------------------------------------------------











//Updates the Estimating Info Screen on keyup--////////////////////////////////////////////////

function UpdateSystemRates(ObjectName,SQLName,Type)
{
	
      var ObjValue = Gebi(ObjectName).value;
      var SysID = Gebi("HiddenEstID").value;
	  
	  if (Type == 'List'){var DropObj = Gebi(ObjectName);    var ObjValue = (DropObj[DropObj.selectedIndex].value);}
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateSystemRates;
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=UpdateSystem&SysID='+SysID+'&SQLName='+SQLName+'&ObjValue='+ObjValue+'', true);
	  xmlHttp.send(null);
}


function ReturnUpdateSystemRates() 
{

	
      if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	    {
		  var xmlDoc = xmlHttp.responseXML.documentElement;
		  var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
		  
		  UpdateAllItemCosting(SysID);
			
         }
		 else
		 {
            alert('There was a problem with the UpdateSystemRates request.');
         }
      }
	  
}
//-------------------------------------------------------------------------------------------------












//Updates Pricing of all items--////////////////////////////////////////////////

function UpdateAllItemCosting(SysID)
{
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnUpdateAllItemCosting;
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=UpdateAllItemCosting&SysID='+SysID, true);
	  xmlHttp.send(null);
}

function ReturnUpdateAllItemCosting() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			PartsList(SysID); 
			setTimeout("LaborList("+SysID+");",3000);
			//setTimeout("CalculateEstTotal();",5000);
		}
		else
		{
			alert('There was a problem with the UpdateAllItemCosting request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------






//Saves the Text entered into parts and labor fields--////////////////////////////////////////////////

function ListEntryUpdate(RowID,Field,FieldID)
{
/*	  
	var TextString = Gebi(FieldID).value;
	 
	if (TextString==''||TextString==null) {TextString = '0'}
	//alert(TextString.length);
		
	//alert(Field);
	
	HttpText='OldEstimatesASP.asp?action=ListEntryUpdate&RowID='+RowID+'&FieldName='+Field+'&TextString='+TextString;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnListEntryUpdate;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}


function ReturnListEntryUpdate() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var RowID = xmlDoc.getElementsByTagName("RowID")[0].childNodes[0].nodeValue;
*/			
			//alert(RowID);
			SendSQL('Write','UPDATE BidItems SET '+Field+'=\''+Gebi(FieldID).value+'\' WHERE BidItemsID='+RowID);
			CalculateItemRow(RowID);
/*		}
		else
		{
			AjaxErr('There was a problem with the ListEntryUpdate request.',HttpText);
		}
	}
*/}
//-------------------------------------------------------------------------------------------------














//Updates the Calculations in parts and labor Rows--////////////////////////////////////////////////

function CalculateItemRow(RowID)
{
	
	var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById('MU').value;
	
	var Qty      = 'Qty'+RowID;
	var Manuf    = 'Manuf'+RowID;
	var Name     = 'Name'+RowID;
	var Desc     = 'Desc'+RowID;
	var CostEa   = 'CostEa'+RowID;
	var CostSub  = 'CostSub'+RowID;
	var SellEa   = 'SellEa'+RowID;
	var SellSub  = 'SellSub'+RowID;
	
	
	var sQty = eval(Gebi(Qty).value);
	if (isNaN(sQty*1)){sQty=0;}
	var sCostEa = eval(Gebi(CostEa).value);
	
	
	var sCostSub = (sQty * sCostEa);
	var sSellEa = (((sCostEa*MU)/100)+sCostEa);
	var sSellSub = (sQty * sSellEa);
	
	//alert(sCostSub+'   '+sSellEa+'   '+sSellSub);
	
	sCostSub = Math.round(sCostSub*Math.pow(10,2))/Math.pow(10,2);//rounds the decimal to 2 places
	sSellEa = Math.round(sSellEa*Math.pow(10,2))/Math.pow(10,2);//rounds the decimal to 2 places
	sSellSub = Math.round(sSellSub*Math.pow(10,2))/Math.pow(10,2);//rounds the decimal to 2 places
	
	Gebi(CostSub).value = sCostSub;
	Gebi(SellEa).value = sSellEa;
	Gebi(SellSub).value = sSellSub;
	
	//alert(MU);
	
	HttpText='OldEstimatesASP.asp?action=ListSubItemsUpdate&CostSub='+sCostSub+'&SellEa='+sSellEa+'&SellSub='+sSellSub+'&RowID='+RowID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCalculateItemRow;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);
}


function ReturnCalculateItemRow() 
{
 if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var RowID = xmlDoc.getElementsByTagName("RowID")[0].childNodes[0].nodeValue;
			
			//alert(RowID);
			
			Gebi('SysInfoFrame').contentWindow.CalculateEstTotal();
		}
		else
		{
			AjaxErr('There was a problem with the CalculateItemRow request.',HttpText); 
		}
	}
}
//-------------------------------------------------------------------------------------------------





function CalcProjTotals()
{
	HttpText='OldEstimatesASP.asp?action=CalcProjTotals&ProjID='+Gebi('HiddenProjID').value;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCalcProjTotals;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnCalcProjTotals()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			if(!xmlHttp.responseXML){AjaxErr('There\'s an issue with Estimates-CalcProjTotals.',HttpText)}
			
			var xmlDoc= xmlHttp.responseXML.documentElement;

			var SqFoot = xmlDoc.getElementsByTagName('SqFoot')[0].childNodes[0].nodeValue;
			SqFoot=SqFoot.replace(/-COMMA-/g,',');

			Gebi('SqFoot').value = SqFoot;
			
			var PartsCost= xmlDoc.getElementsByTagName('PartsCost')[0].childNodes[0].nodeValue*1;
			var LaborCost= xmlDoc.getElementsByTagName('LaborCost')[0].childNodes[0].nodeValue*1;
			var Travel= xmlDoc.getElementsByTagName('Travel')[0].childNodes[0].nodeValue*1;
			var Equipment= xmlDoc.getElementsByTagName('Equipment')[0].childNodes[0].nodeValue*1;
			var SalesTax= xmlDoc.getElementsByTagName('SalesTax')[0].childNodes[0].nodeValue*1;
			var Overhead= xmlDoc.getElementsByTagName('Overhead')[0].childNodes[0].nodeValue*1;
			var TotalPrice= xmlDoc.getElementsByTagName('TotalPrice')[0].childNodes[0].nodeValue*1;
			
			if(TotalPrice==0)
			{
				Gebi('ProjInfoTotal').innerHTML='0'
				Gebi('ProjInfoParts').innerHTML='0'
				Gebi('ProjInfoLabor').innerHTML='0'
				Gebi('ProjInfoTravel').innerHTML='0'
				Gebi('ProjInfoEquipment').innerHTML='0'
				Gebi('ProjInfoOverhead').innerHTML='0'
				Gebi('ProjInfoTax').innerHTML='0'
				Gebi('ProjInfoProfit').innerHTML='0'
				return false;
			}
			
			var PartsCostPercent=(Math.round(PartsCost/TotalPrice*10000)/100);
			PartsCost=(Math.round(PartsCost*100)/100);
			
			var LaborCostPercent=(Math.round(LaborCost/TotalPrice*10000)/100);
			LaborCost=(Math.round(LaborCost*100)/100);
			
			var TravelPercent=(Math.round(Travel/TotalPrice*10000)/100);
			Travel=(Math.round(Travel*100)/100);
			
			var EquipmentPercent=(Math.round(Equipment/TotalPrice*10000)/100);
			Equipment=(Math.round(Equipment*100)/100);
			
			var OverheadPercent=(Math.round(Overhead/TotalPrice*10000)/100);
			Overhead=(Math.round(Overhead*100)/100);
			
			var SalesTaxPercent=(Math.round(SalesTax/TotalPrice*10000)/100);
			SalesTax=(Math.round(SalesTax*100)/100);
			
			var Profit=TotalPrice-(PartsCost+LaborCost+Travel+Equipment+Overhead+SalesTax);
			var ProfitPercent=(Math.round(Profit/TotalPrice*10000)/100);
			Profit=(Math.round(Profit*100/100));
			
			//TotalPrice=(Math.round(TotalPrice*100)/100);
			
			
			Gebi('ProjInfoTotal').innerHTML='$'+TotalPrice+' <div style="float:right;">100% </div>';			
			Gebi('ProjInfoParts').innerHTML='$'+PartsCost+' <div style="float:right;">'+PartsCostPercent+'% </div>';			
			Gebi('ProjInfoLabor').innerHTML='$'+LaborCost+' <div style="float:right;">'+LaborCostPercent+'% </div>';			
			Gebi('ProjInfoTravel').innerHTML='$'+Travel+' <div style="float:right;">'+TravelPercent+'% </div>';			
			Gebi('ProjInfoEquipment').innerHTML='$'+Equipment+' <div style="float:right;">'+EquipmentPercent+'% </div>';			
			Gebi('ProjInfoOverhead').innerHTML='$'+Overhead+' <div style="float:right;">'+OverheadPercent+'% </div>';			
			Gebi('ProjInfoTax').innerHTML='$'+SalesTax+' <div style="float:right;">'+SalesTaxPercent+'% </div>';			
			Gebi('ProjInfoProfit').innerHTML='$'+Profit+' <div style="float:right;">'+ProfitPercent+'% </div>';		
		}
		else
		{
			AjaxErr('There was a problem with CalcProjTotals.',HttpText);
		}
	}
}





//Calculates the Estimate totals--////////////////////////////////////////////////
function CalculateEstTotal()
{
	if(!InsideFrame)
	{
		//Gebi('SysInfoFrame').contentWindow.CalculateEstTotal();
		return false;
	}
	var FixedTotal=1;
	if(!Gebi('ckFixedTotal').checked){FixedTotal=0;}
	
	HttpText='OldEstimatesASP.asp?action=CalculateEstTotal&SysID='+SelectedSysID+'&FixedTotal='+FixedTotal;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnCalculateEstTotal;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
			//AjaxErr('Click Cancel for CalculateEstTotal XML.',HttpText);
	/**/
}

function ReturnCalculateEstTotal() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			if(!xmlHttp.responseXML){AjaxErr('There\'s an issue with Estimates-CalculateEstTotal.',HttpText)}
			
			//return false;
			
			var xmlDoc     = xmlHttp.responseXML.documentElement;
			var Calc       = xmlDoc.getElementsByTagName("Calc")[0].childNodes[0].nodeValue.replace('--','');
			var PartsCost  = xmlDoc.getElementsByTagName("PartsCost")[0].childNodes[0].nodeValue;
			var PartsSell  = xmlDoc.getElementsByTagName("PartsSell")[0].childNodes[0].nodeValue;
			var LaborCost  = xmlDoc.getElementsByTagName("LaborCost")[0].childNodes[0].nodeValue;
			var LaborSell  = xmlDoc.getElementsByTagName("LaborSell")[0].childNodes[0].nodeValue;
			var Travel     = xmlDoc.getElementsByTagName("Travel")[0].childNodes[0].nodeValue;
			var Equipment  = xmlDoc.getElementsByTagName("Equipment")[0].childNodes[0].nodeValue;
			var Overhead   = xmlDoc.getElementsByTagName("Overhead")[0].childNodes[0].nodeValue;
			var Expenses   = xmlDoc.getElementsByTagName("Expenses")[0].childNodes[0].nodeValue;
			var SubTotal   = xmlDoc.getElementsByTagName("SubTotal")[0].childNodes[0].nodeValue;
			var Tax        = xmlDoc.getElementsByTagName("Tax")[0].childNodes[0].nodeValue;
			var TotalSell  = xmlDoc.getElementsByTagName("TotalSell")[0].childNodes[0].nodeValue;
			var Markup     = xmlDoc.getElementsByTagName("Markup")[0].childNodes[0].nodeValue;
			var PartsPL    = xmlDoc.getElementsByTagName("PartsPL")[0].childNodes[0].nodeValue;
			var LaborPL    = xmlDoc.getElementsByTagName("LaborPL")[0].childNodes[0].nodeValue;
			var TotalCost  = xmlDoc.getElementsByTagName("TotalCost")[0].childNodes[0].nodeValue;
			var TotalMargin= xmlDoc.getElementsByTagName("TotalMargin")[0].childNodes[0].nodeValue;
			var SqFt       = xmlDoc.getElementsByTagName("SqFt")[0].childNodes[0].nodeValue.replace('--','');
			var SqFtAdd    = xmlDoc.getElementsByTagName("SqFtAdd")[0].childNodes[0].nodeValue.replace('--','');
			var Round      = xmlDoc.getElementsByTagName("Round")[0].childNodes[0].nodeValue.replace('--','');
			var ExcludeSys = xmlDoc.getElementsByTagName("ExcludeSys")[0].childNodes[0].nodeValue.replace('--','');
			var TotalFixed = xmlDoc.getElementsByTagName("TotalFixed")[0].childNodes[0].nodeValue.replace('--','');
			
			var Obtained = xmlDoc.getElementsByTagName("Obtained")[0].childNodes[0].nodeValue.replace('--','');
			
			if(Obtained=='True')
			{
				PGebi('ckContract').checked=true;
				PGebi('SystemLock').style.display='block';
			}
			else
			{
				PGebi('ckContract').checked=false;
				PGebi('SystemLock').style.display='none';
			}
			
			//alert('(SubTotal:'+SubTotal+' - Expenses:'+Expenses+') / Cost:'+TotalCost);
			//alert('Margin:'+TotalMargin);
			if(TotalFixed=='True')
			{
				TotalFixed=true;
				
				if(Markup < 0)
					{Gebi('MU').style.color='red';}
				else
					{Gebi('MU').style.color='black';}
				
				OldMUReadOnly=Gebi('MU').readOnly;
				Gebi('MU').readonly=false;
				Gebi('MU').value=Math.round(Markup*100)/100;
				Gebi('MU').readOnly=OldMUReadOnly;
			}
			else
			{
				TotalFixed=false;
	
				if(SubTotal < 0)
					{Gebi('SystemTotal').style.color='red';}
				else
					{Gebi('SystemTotal').style.color='black';}
				
				OldSystemTotalReadOnly=Gebi('SystemTotal').readOnly;
				Gebi('SystemTotal').readonly=false;
				Gebi('SystemTotal').value='$'+(Math.round(SubTotal*100)/100);
				Gebi('SystemTotal').readOnly=OldSystemTotalReadOnly;
			}
			
			Gebi('PartsCost').innerHTML='&nbsp;$'+Math.round(PartsCost*100)/100;
			Gebi('PartsSell').innerHTML='&nbsp;$'+Math.round(PartsSell*100)/100;
			Gebi('LaborCost').innerHTML='&nbsp;$'+Math.round(LaborCost*100)/100;
			Gebi('LaborSell').innerHTML='&nbsp;$'+Math.round(LaborSell*100)/100;
			Gebi('SubTotal').innerHTML ='&nbsp;$'+Math.round(SubTotal*100)/100;
			Gebi('Tax').innerHTML = '&nbsp;$'+Math.round(Tax*100)/100;
			Gebi('Travel').innerHTML = '&nbsp;$'+Math.round(Travel*100)/100;
			Gebi('Equipment').innerHTML = '&nbsp;$'+Math.round(Equipment*100)/100;
			Gebi('OH').innerHTML = '&nbsp;$'+Math.round(Overhead*100)/100;
			
			if(PartsSell<0){Gebi('PartsSell').style.color='#C00';} else {Gebi('PartsSell').style.color='#000';}
			if(LaborSell<0){Gebi('LaborSell').style.color='#C00';} else {Gebi('LaborSell').style.color='#000';}

			
			Gebi('TotalSell').innerHTML = '$'+Math.round(TotalSell*100)/100;
			
			parent.document.getElementById('SysTotal').innerHTML=Gebi('TotalSell').innerHTML;

			Gebi('PartsPL').innerHTML = '&nbsp;$'+Math.round(PartsPL*100)/100;
			Gebi('LaborPL').innerHTML = '&nbsp;$'+Math.round(LaborPL*100)/100;
			Gebi('TotalCost').innerHTML = '&nbsp;$'+Math.round(TotalCost*100)/100;
			Gebi('TotalMargin').innerHTML = '&nbsp;$'+Math.round(TotalMargin*100)/100;

			if(PartsPL<0){Gebi('PartsPL').style.color='#C00';} else {Gebi('PartsPL').style.color='#000';}
			if(LaborPL<0){Gebi('LaborPL').style.color='#C00';} else {Gebi('LaborPL').style.color='#000';}
			if(TotalMargin<0){Gebi('TotalMargin').style.color='#C00';} else {Gebi('TotalMargin').style.color='#000';}

			if(SqFtAdd=='True'){Gebi('ckIncludeSqFt').checked=true;}
			else{Gebi('ckIncludeSqFt').checked=false;}

			if(Round=='True'){Gebi('ckRound').checked=true;}
			else{Gebi('ckRound').checked=false;}

			if(ExcludeSys=='True'){Gebi('ckIncludeSys').checked=false;}
			else{Gebi('ckIncludeSys').checked=true;}

			Gebi('SysSqFt').value = SqFt;
			if(SqFt==null||SqFt==''||SqFt==0||isNaN(SqFt))
			{
				Gebi('SysSqFt').value = 0;
				SqFt=1;
			}
			
			var SqFtPrice=formatCurrency((TotalSell.replace('$',''))/SqFt);
			var MatPrice=(PartsCost.replace('$',''))/(TotalSell.replace('$',''));
			
			MatPrice=MatPrice*100;
			MatPrice=formatCurrency(MatPrice);
			MatPrice=MatPrice.replace('$','')+'%';
			
			//alert(SqFt+'  '+TotalSell+'  '+PartsCost);

			Gebi('SysSqFtPrice').innerHTML = '&nbsp;'+SqFtPrice;
			Gebi('SysMatPrice').innerHTML = '&nbsp;'+MatPrice;
			
			//alert('PC'+PartsCost+'  PS '+PartsSell+'  LC '+LaborCost+' LS '+LaborSell+'  ST '+SubTotal+'  T '+Tax+'  T '+TotalSell+'  P '+PartsPL+'  L '+LaborPL+'  C '+TotalCost);
			
			
			Gebi('SysInfoParts').innerHTML='&nbsp;'+parseInt((PartsCost/TotalSell)*10000)/100+('%');
			Gebi('SysInfoTax').innerHTML='&nbsp;'+parseInt((Tax/TotalSell)*10000)/100+('%');
			Gebi('SysInfoLabor').innerHTML='&nbsp;'+parseInt((LaborCost/TotalSell)*10000)/100+('%');
			Gebi('SysInfoTravel').innerHTML='&nbsp;'+parseInt((Travel/TotalSell)*10000)/100+('%');
			Gebi('SysInfoEquipment').innerHTML='&nbsp;'+parseInt((Equipment/TotalSell)*10000)/100+('%');
			Gebi('SysInfoOverhead').innerHTML='&nbsp;'+parseInt((Overhead/TotalSell)*10000)/100+('%');
			
			var Profit=(TotalSell-Expenses)/TotalSell;
			Gebi('SysInfoProfit').innerHTML='&nbsp;'+parseInt((Profit)*10000)/100+('%');
			
			if(Profit<0){Gebi('SysInfoProfit').style.color='#C00';} else {Gebi('SysInfoProfit').style.color='#000';}
			
			//Gebi('SysStatsProfit').innerHTML=(T)///TotalSell)*100;
			//Gebi('SysStatsProfit').innerHTML=((TotalSell-(PartsSell+LaborSell+0+Tax+Travel+Gebi('SysStatsOverH').value))/TotalSell)*100;
			
			//AjaxErr('CalculateEstTotal -Rem out or delete when done',HttpText);
			/**/	
			
			Gebi('ckFixedTotal').checked=TotalFixed;
			ToggleFT(TotalFixed);			
			
		}
		else
		{
			AjaxErr('There was a problem with the CalculateEstTotal request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------












//Sets an item to checked in the database--////////////////////////////////////////////////

function ItemSelected(ItemID,CBID)
{
	//alert(ItemID);
	  var CBobj = Gebi(CBID);
	
	  if(CBobj.checked == true){var ItemChecked = 1}
	  if(CBobj.checked == false){var ItemChecked = 0}
      
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=ItemSelected&ItemID='+ItemID+'&ItemChecked='+ItemChecked, true);
	  xmlHttp.send(null);
}
//-------------------------------------------------------------------------------------------------







//Sets all items to unchecked--////////////////////////////////////////////////

function UncheckAll()
{
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=UncheckAll', true);
	  xmlHttp.send(null);
}


//-------------------------------------------------------------------------------------------------








//Deletes An Item Row////////////////////////////////////////////////

function DeleteItems(List)
{
	  var SysID = Gebi("HiddenEstID").value;
	 
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnDeleteItems;
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=DeleteItems&SysID='+SysID+'&List='+List, true);
	  xmlHttp.send(null);
}


function ReturnDeleteItems() 
{

	
      if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	    {
		  var xmlDoc = xmlHttp.responseXML.documentElement;
		  var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
		  var List = xmlDoc.getElementsByTagName("List")[0].childNodes[0].nodeValue;
		  
		  if(List == 'PartsList'){PartsList(SysID);}
		  if(List == 'LaborList'){LaborList(SysID);}
		  
		  setTimeout("CalculateEstTotal();",3000);
			
         }
		 else
		 {
            alert('There was a problem with the DeleteItems request.');
         }
      }
	  
}
//-------------------------------------------------------------------------------------------------





//Deletes A Project From the Project list////////////////////////////////////////////////

function DeleteProject(ProjID)
{
	var ProjID = Gebi("HiddenProjID").value;
	var AreaIndex=Gebi('AreaSearch').selectedIndex;
	
	if(!confirm('Are You SURE You Want To DELETE This Project?')){return false}
	
	if(confirm('REALLY!!!!?????'))
	{
		xmlHttp = GetXmlHttpObject();
		xmlHttp.onreadystatechange = ReturnDeleteProject;
		xmlHttp.open('Get','OldEstimatesASP.asp?action=DeleteProject&ProjID='+ProjID+'&AreaIndex='+AreaIndex, true);
		xmlHttp.send(null);
	}
}


function ReturnDeleteProject() 
{

	
	if (xmlHttp.readyState == 4)
	{
		
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var AreaIndex=xmlDoc.getElementsByTagName('AreaIndex');
			var CustID = Gebi("HiddenCustID").value;
			Gebi('ProjectBox').style.display = 'none';
			
			GetProjects(CustID);
			LoadAreaProj();
		}
		else
		{
			alert('There was a problem with the DeleteProject request.');
		}
	}
	  
}
//-------------------------------------------------------------------------------------------------



function ActivateProj(ProjID)
{
	if(!confirm('WARNING: You are activating this Project before the contract has been signed!!!'))
	{return false}
	
	var SQL='UPDATE Projects SET Active=1 WHERE ProjID='+ProjID;
	SendSQL('Write',SQL)
}





//Deletes A System From the System list////////////////////////////////////////////////
function DeleteSystem()
{
	HttpText='';
	var answer = confirm('Are You SURE You Want To DELETE This System?');
	if (answer)
	{ 
		var answer2 = confirm('REALLY!!!!?????');
		if (answer2)
		{
			HttpText='OldEstimatesASP.asp?action=DeleteSystem&SysID='+SysID;
			xmlHttp = GetXmlHttpObject();
			xmlHttp.onreadystatechange = ReturnDeleteSystem;
			xmlHttp.open('Get',HttpText , true);
			xmlHttp.send(null);
		}
	}
	else
	{
		return;
	}	  
}

function ReturnDeleteSystem() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			try
			{var xmlDoc = xmlHttp.responseXML.documentElement;}
			catch(e)
			{
				if(parent.accessUser=='n8'){window.open(HttpText,HttpText); return false;}
				alert('There was a \'Delete System\' error, but it is possible that the system is deleted.')
			}
			
			parent.OpenProject(parent.document.getElementById("HiddenProjID").value);
		}
		else
		{
			AjaxErr('There was a problem with the DeleteSystem request.',HttpText);
			OpenProject(parent.document.getElementByID("HiddenProjID").value);
		}
	}
}
//-------------------------------------------------------------------------------------------------
















//Pulls a list of parts based on the search text////////////////////////////////////////////////

function SearchParts(SearchName)
{
	var SearchTxt = Gebi("SearchPartsTxt").value;
	
	HttpText='OldEstimatesASP.asp?action=SearchParts&SearchTxt='+SearchTxt+'&SearchName='+SearchName;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSearchParts;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnSearchParts() 
{
	if (xmlHttp.readyState == 4)
	{
		
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var Parts = xmlDoc.getElementsByTagName("Parts")[0].childNodes[0].nodeValue;
			
			Gebi('AddPartBoxScroll').innerHTML = Parts;
		}
		else
		{
			AjaxErr('There was a problem with the SearchParts request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------












//Adds parts to the bid////////////////////////////////////////////////

function AddPart(PartID)
{
	var SysID = Gebi("HiddenEstID").value;
	var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;
	
	//alert(PartID);
	HttpText='OldEstimatesASP.asp?action=AddPart&PartID='+PartID+'&SysID='+SysID+'&MU='+MU;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnAddPart;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function AddBlankPart()
{
	var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;

	HttpText='OldEstimatesASP.asp?action=AddPart&PartID=0&MU='+MU+'&SysID='+Gebi('HiddenEstID').value;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnAddPart;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnAddPart() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			//var ProjID = xmlDoc.getElementsByTagName("ProjID")[0].childNodes[0].nodeValue;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			//Gebi('PartsTabMain').innerHTML += ProjID;
			PartsList(SysID);
		}
		else
		{
			AjaxErr('There was a problem with the AddPart request. Continue?',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------












//Pulls a list of Labor based on the search text////////////////////////////////////////////////

function SearchLabor(SearchName)
{
	var SearchTxt = Gebi("SearchLaborTxt").value;
	
	HttpText='OldEstimatesASP.asp?action=SearchLabor&SearchTxt='+SearchTxt+'&SearchName='+SearchName;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSearchLabor;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}


function ReturnSearchLabor() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
    {
	    var xmlDoc = xmlHttp.responseXML.documentElement;
			var Labor = xmlDoc.getElementsByTagName("Labor")[0].childNodes[0].nodeValue;
			
			Gebi('AddLaborBoxScroll').innerHTML = Labor;
		}
		else
		{
			AjaxErr('There was a problem with the SearchLabor request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------















//Adds Labor to the bid////////////////////////////////////////////////

function AddLabor(LaborID)
{
	var SysID = Gebi("HiddenEstID").value;
	var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnAddLabor;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=AddLabor&LaborID='+LaborID+'&SysID='+SysID+'&MU='+MU, true);
	xmlHttp.send(null);
}
function AddBlankLabor()
{
	var MU = Gebi('SysInfoFrame').contentWindow.document.getElementById("MU").value;

	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnAddLabor;
	xmlHttp.open('Get','OldEstimatesASP.asp?action=AddLabor&LaborID=0&MU='+MU+'&SysID='+Gebi('HiddenEstID').value, true);
	xmlHttp.send(null);
}
function ReturnAddLabor() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var SysID = xmlDoc.getElementsByTagName("SysID")[0].childNodes[0].nodeValue;
			
			LaborList(SysID);
		}
		else
		{
			alert('There was a problem with the AddLabor request.');
		}
	}
}
//-------------------------------------------------------------------------------------------------







//Adds A list of systems & BidTo Customers to the print setup////////////////////////////////////////////////

function PrintSystemsList()
{
	var ProjID = Gebi("HiddenProjID").value;
	Gebi('PrintForList').innerHTML = '';
	Gebi('PrintSystemList').innerHTML = '';
	Gebi('PrintLicenseList').innerHTML = '';
	Gebi('AddressingBox').innerHTML = '';
	
	HttpText='OldEstimatesASP.asp?action=SystemsList&ProjID='+ProjID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnPrintSystemsList;
	xmlHttp.open('Get', HttpText, false);
	xmlHttp.send(null);
	
}

function ReturnPrintSystemsList() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			var PrintForList = xmlDoc.getElementsByTagName('PrintForList')[0].childNodes[0].nodeValue;
			
			Gebi('PrintForList').innerHTML = PrintForList;
			
			var AddressingList = xmlDoc.getElementsByTagName('AddressingList')[0].childNodes[0].nodeValue.replace('--','');
			Gebi('AddressingBox').innerHTML = AddressingList;

			var LicList = xmlDoc.getElementsByTagName('LicList')[0].childNodes[0].nodeValue.replace('--','');
			Gebi('PrintLicenseList').innerHTML = LicList;
			//alert(LicList);

			var SysCount = xmlDoc.getElementsByTagName('SysCount')[0].childNodes[0].nodeValue;
			var SysHTML = '';
			
			Gebi('PrintSystemList').innerHTML = 'No systems found';
			if (SysCount>0)
			{
				var SysID 
				var SysName 
				var PrintCheck
				for(i=1;i<=SysCount;i++)
				{
					//alert('SystemID'+i);
					SysID = xmlDoc.getElementsByTagName('SystemID'+i)[0].childNodes[0].nodeValue;
					SysName = xmlDoc.getElementsByTagName('SysName'+i)[0].childNodes[0].nodeValue;
					PrintCheck = String(xmlDoc.getElementsByTagName('PrintChecked'+i)[0].childNodes[0].nodeValue);
					
					if (PrintCheck == 'False'){PrintCheck = '';}else{PrintCheck='checked';}
					SysHTML = SysHTML + '<div><input type="checkbox" id="cb'+SysID+'" name="cb'+SysID+'" '+PrintCheck
					SysHTML = SysHTML +' onclick="UpdateSystemPrint('+SysID+');"'
					SysHTML = SysHTML + ' /><label for="cb'+SysID+'">'+SysName+'</label></div>';
					
				}
				Gebi('PrintSystemList').innerHTML = SysHTML;
			}
			
			//var Systems = xmlDoc.getElementsByTagName("Systems")[0].childNodes[0].nodeValue.;
			//Gebi('PrintSystemList').innerHTML = Systems;
			
			onResize();
		}
		else
		{
			AjaxErr('There was a problem with the PrintSystemsList request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------


function PrintChecked(cb)
{
	switch(cb.id)
	{	
		case 'pNotes':
			//UpdateText('pNotes','CheckBox','ProjectPrint','ProjectID','Notes');
			var TF= 'False';
			if(cb.checked){TF='True';}			
			SendSQL('Write','UPDATE ProjectPrint SET Notes =\''+TF+'\' WHERE ProjectID='+Gebi('HiddenProjID').value);
			break;
		case 'pSubtotal':
			//UpdateText('pSubtotal','CheckBox','ProjectPrint','ProjectID','Subtotal');
			var TF= 'False';
			if(cb.checked){TF='True';}			
			SendSQL('Write','UPDATE ProjectPrint SET Subtotal =\''+TF+'\' WHERE ProjectID='+Gebi('HiddenProjID').value);
			break;
		case 'pTax':
			//UpdateText('pTax','CheckBox','ProjectPrint','ProjectID','Tax');
			var TF= 'False';
			if(cb.checked){TF='True';}			
			SendSQL('Write','UPDATE ProjectPrint SET Tax =\''+TF+'\' WHERE ProjectID='+Gebi('HiddenProjID').value);
			break;
		case 'pTotal':
			//UpdateText('pTotal','CheckBox','ProjectPrint','ProjectID','Total');
			var TF= 'False';
			if(cb.checked){TF='True';}			
			SendSQL('Write','UPDATE ProjectPrint SET Total =\''+TF+'\' WHERE ProjectID='+Gebi('HiddenProjID').value);
			break;
		default:
			//UpdateText(cb.id,'CheckBox','ProjectPrint','ProjectID',cb.id);	
			var TF= 'False';
			if(cb.checked){TF='True';}			
			SendSQL('Write','UPDATE ProjectPrint SET '+cb.id+' =\''+TF+'\' WHERE ProjectID='+Gebi('HiddenProjID').value);
	}
	//AjaxErr('Hit Cancel to view some XML!!',HttpText);
}



//Switches and saves the  LetterHead Checkboxes////////////////////////////////////////////////

function LetterHeadSW(CB1,CB2,CB3)
{
	  
	if(Gebi(CB1).checked = true)
	{
		Gebi(CB2).checked = false;
		Gebi(CB3).checked = false;
	}
	
	var ProjID = Gebi("HiddenProjID").value;
	var TFP_TCS = Gebi('TFP_TCS').checked;
	var TFP = Gebi('TFP').checked;
	var TCS = Gebi('TCS').checked;
	
	//alert(TFP_TCS);
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.open('Get','OldEstimatesASP.asp?action=LetterHeadSW&ProjID='+ProjID+'&TFP_TCS='+TFP_TCS+'&TFP='+TFP+'&TCS='+TCS, true);
	xmlHttp.send(null);
	  
}

//-------------------------------------------------------------------------------------------------
//function 

function MakeLicenseFooters()
{
	var FooterHTML='';
	for(i=0;i<Gebi('LicenseList').childNodes.length;i++)
	{
		var cb=Gebi('LicenseList').childNodes[i]
		if(cb.id.indexOf('cbLic')!=-1)
		{
			//alert(cb.checked)
			if(cb.checked)
			{
				var LFID=cb.id.replace('cbLic','LicenseFooter');
				
				FooterHTML+=Gebi(LFID).innerHTML;
				//alert(CharsEncode(FooterHTML));
			}
		}
	}
	
	if(FooterHTML==''){FooterHTML='-ERASE-'}
	HttpText='OldEstimatesASP.asp?action=MakeLicenseFooters&HTML='+CharsEncode(FooterHTML)+'&ProjID='+Gebi('HiddenProjID').value;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnMakeLicenseFooters;
	xmlHttp.open('Get',HttpText,true);
	xmlHttp.send(null);
}
function ReturnMakeLicenseFooters()
{
	//alert(xmlHttp.readyState);
	if(xmlHttp.readyState==4)
	{
		if(xmlHttp.status==200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var LF=CharsDecode(xmlDoc.getElementsByTagName('LF')[0].childNodes[0].nodeValue.replace('--',''));
			//alert('Coming back:'+LF);
		}
		else{AjaxErr('There was a problem with the MakeLicenseFooter request.',HttpText);}
	}
}
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------









//NEXT -- Opens the list of presets based on a system////////////////////////////////////////////////

function BidPresetList()
{
	  var SystemID = SelI('PresetSystemsList').value;
	  
	  xmlHttp = GetXmlHttpObject();
	  xmlHttp.onreadystatechange = ReturnBidPresetList;
	  xmlHttp.open('Get','OldEstimatesASP.asp?action=BidPresetList&SystemID='+SystemID, true);
	  xmlHttp.send(null);
	  
}


function ReturnBidPresetList() 
{

	
      if (xmlHttp.readyState == 4)
	  {
		  
		if (xmlHttp.status == 200)
	    {
			
		    var xmlDoc = xmlHttp.responseXML.documentElement;
			var Presets = xmlDoc.getElementsByTagName("Presets")[0].childNodes[0].nodeValue;
			
			Gebi('PresetList').innerHTML = Presets;
			
			if(Presets == 'Blank'){alert('No Presets Found'); return;}
			
			Gebi('PresetPage1').style.display = 'none';
			Gebi('PresetPage2').style.display = 'block';
			Gebi('PresetPage2').style.visibility = 'visible';
			
			//alert(Presets);
			
         }
		 else
		 {
            alert('There was a problem with the BidPresetList request.');
         }
      }
	  
}
//-------------------------------------------------------------------------------------------------







// -- Creates the Bid From the Preset////////////////////////////////////////////////

function BidPresetCreate()
{
	var PresetID = Gebi("PreHiddenTxt").innerHTML;
	var MU = Gebi('MU').value;
	
	HttpText='OldEstimatesASP.asp?action=BidPresetCreate&PresetID='+PresetID+'&SystemID='+SysID+'&MU='+MU;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnBidPresetCreate;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);
}


function ReturnBidPresetCreate() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			var SystemID = xmlDoc.getElementsByTagName("SystemID")[0].childNodes[0].nodeValue;
			parent.GetSystemEdit(SystemID);
			//setTimeout("ClosePresets();",1000);
			window.location=window.location;
		}
		else
		{
			AjaxErr('There was a problem with the BidPresetCreate request.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------
 





function AddExpense(Type, SubType, Origin, Destination, Units, UnitCost)
{
	SendSQL("Write","INSERT INTO Expenses (SysID, Type, SubType, Origin, Destination, Units, UnitCost) VALUES ("+parent.SelectedSysID+", '"+Type+"', '"+SubType+"', '"+Origin+"', '"+Destination+"', '"+Units+"', '"+UnitCost+"')");
	window.location=window.location;
}


var ExpenseID;
function SaveExpense(Type, SubType, Origin, Destination, Units, UnitCost)
{
	//Units=parseInt(Units);
	SendSQL("Write","UPDATE Expenses SET SysID="+parent.SelectedSysID+", Type='"+Type+"', SubType='"+SubType+"', Origin='"+Origin+"', Destination='"+Destination+"', Units='"+Units+"', UnitCost='"+UnitCost+"' WHERE ExpenseID="+ExpenseID);
	window.location=window.location;

}

function DeleteExpense(ExpenseID)
{
	if(confirm('Deleting Item'))
	{
		SendSQL("Write","DELETE FROM Expenses WHERE ExpenseID="+ExpenseID);
		window.location=window.location;
	}
}


function DeleteExpenseAll(Type)
{
	if(confirm('-WARNING- you are about to delete all the '+Type+' Expenses for this system.'))
	{
		if(confirm('Just making sure.'))
		{
			SendSQL("Write","DELETE FROM Expenses WHERE Type='"+Type+"' AND SysID="+SelectedSysID);
			window.location=window.location;
		}
	}
}


function DeleteAllExpenses(SysID)
{
	if(confirm('-WARNING- you are about to delete EVERY LAST EXPENSE ITEM for this system.'))
	{
		if(confirm('Just making sure.'))
		{
			SendSQL('Write','DELETE FROM Expenses WHERE SysID='+SysID)
			window.location=window.location;
		}
	}
}