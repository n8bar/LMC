// JavaScript Document

var ManufArray = new Array();
var SystemsArray = new Array();
var CategoryArray = new Array();
var VendorArray = new Array();

var gSearchName ='';
var gSearchTXT ='';
var xmlHttp;

var GlobalID = '';
var HttpText='';
function GetXmlHttpObject() {//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////
	var xmlHttp=null;
	try {		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e) {
		// Internet Explorer
		try {			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");		}
		catch (e) {			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");		}
	}
		
	if (xmlHttp==null) {
		alert ("Your browser does not support AJAX!");
		return;
	}
	return xmlHttp;
}//------------------------------------------------------------------------------------------------

function UpdateText(BoxID,BoxType,Table,IDColumn,Column,RowID) {//Updates Text from a Textbox onKeyup////////////////////////////////////////////////
	var SysOK = 'No';	
	if(BoxType == 'List'){var Text = Gebi(BoxID).options.value;}
	if(BoxType == 'ListTxt') {var Obj = Gebi(BoxID); var Text = (Obj.options[Obj.selectedIndex].text ); }
	if(BoxType == 'Text'){var Text = Gebi(BoxID).value;}
	if(BoxType == 'CheckBox'){var Text = Gebi(BoxID).checked;}
	if(Table == 'BidPresets'){var RowID = Gebi('BidPresetID').innerHTML;}
	
	Text = Text.replace(/\r/g,'');
	Text = Text.replace(/\n/g,'--RET--');
	
	//Text = Text.replace(/--RET--/g,'\n'); //On the other end
 
	// alert(Ret);
	HttpText='Contacts_ASP.asp?action=UpdateText&Text='+Text+'&Table='+Table+'&IDColumn='+IDColumn+'&Column='+Column+'&RowID='+RowID+'&SysOK='+SysOK+'&BoxID='+BoxID+'&BoxType='+BoxType
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnUpdateText;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnUpdateText()	{
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
			
			if(BoxID=='SystemTypes'){UpdateText(BoxID,'ListTxt',Table,IDColumn,'BidPresetSystem',RowID);}
		}
		else {  AjaxErr('There was a problem with the UpdateText request.',HttpText);     }
	}  
}//-------------------------------------------------------------------------------------------------

function LoadList(ArrayName,DivID,Count) {//Loads Combo box lists
	for (var y = 0; y < Count; y++)	 {
		var Div = eval('Gebi("'+DivID+'")');
		var newOption = document.createElement("OPTION");
		Div.options.add(newOption);
		newOption.value = ArrayName[y][2];
		newOption.innerText = ArrayName[y][2];
	}	
}


function SearchContacts() {
	var SearchTxt = CharsEncode(Gebi("SearchContactsTxt").value);
	var SearchType = SelI('ContactTypeSelect').value;
	
	HttpText='Contacts_ASP.asp?action=SearchContacts&SearchTxt='+SearchTxt+'&SearchType='+SearchType		
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				try	{	var xmlDoc = xmlHttp.responseXML.documentElement;	}
				catch(e)	{AjaxErr('There was a problem with the SearchContacts response.',HttpText)	; return false;	}	
				//AjaxErr('Wanna see?',HttpText)	;
				var rC=xmlDoc.getElementsByTagName('recordCount')[0].childNodes[0].nodeValue;
				
				var Id; var Name; var Address; var Address2; var Phone; var Fax; var Contact; var Website; var cards='';
				
				for (r=1;r<=rC;r++)	{
					Id=xmlDoc.getElementsByTagName('ID'+r)[0].childNodes[0].nodeValue.replace('--','');
					Name=CharsDecode(xmlDoc.getElementsByTagName('Name'+r)[0].childNodes[0].nodeValue).replace('--','');
					Address=CharsDecode(xmlDoc.getElementsByTagName('Address'+r)[0].childNodes[0].nodeValue.replace('--',''));
					Address2=CharsDecode(xmlDoc.getElementsByTagName('Address2'+r)[0].childNodes[0].nodeValue.replace('--',''));
					Phone=xmlDoc.getElementsByTagName('Phone'+r)[0].childNodes[0].nodeValue.replace('--','');
					Fax=xmlDoc.getElementsByTagName('Fax'+r)[0].childNodes[0].nodeValue.replace('--','');
					Contact=xmlDoc.getElementsByTagName('Contact'+r)[0].childNodes[0].nodeValue.replace('--','');
					CPhone=xmlDoc.getElementsByTagName('CPhone'+r)[0].childNodes[0].nodeValue.replace('--','');
					if(Phone==0) Phone='';
					if(Fax==0) Fax='';
					if(CPhone==0) CPhone='';
					
					var tip=Name+'    '+Address+' '+Address2+'   Ph#:'+Phone+'   Fax:'+Fax+'    '+Contact+' '+CPhone;
					
					cards+='<div Class="ContactsCard" title="'+tip+'">';
					cards+='	<div style="cursor:pointer; width:2.5%;"> ';
					cards+='		<img src="../../Images/pencil_16.png" height="20px" width="20px" onclick="ContactEdit('+Id+');">';
					cards+='	</div>';
					cards+='	<div style="font-family:inherit;  font-size:16px; font-weight:bold; width:22.5%;"> '+Name+'</div>';
					cards+='	<div style="font-family:inherit;  font-size:12px; width:30%"> '+Address+' '+Address2+'</div>';
					cards+='	<div style="font-family:consolas; font-size:12px; width:11%;"> '+Phone+'</div>';
					cards+='	<div style="font-family:consolas; font-size:12px; width:11%;"> '+Fax+'</div>';
					cards+='	<div style="font-family:inherit;  font-size:14px; width:12%;"> '+Contact+'</div>';
					cards+='	<div style="font-family:consolas; font-size:12px; width:11%;"> '+CPhone+'</div>';
					cards+='	<div class=TextBottom > "'+Id+'</div>';
					cards+='</div>';
				}
	
				Gebi('List').innerHTML = cards;
			}
			else{ AjaxErr('There was a problem with the SearchContacts request.',HttpText);}
		}
	}
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnSearchContacts()	{
}//-------------------------------------------------------------------------------------------------

function ContactEdit(ID)	{//--Edits Contacts////////////////////////////////////////////////////////////////////
	GlobalID = ID;
	
	Gebi('ContactsModal').style.display = 'block';
	Gebi('ContactsModalBox').style.display = 'block';
	Gebi('ContactDel').style.display = 'block';
	Gebi('ContactUpdate').style.display = 'block';
	Gebi('ContactSave').style.display = 'none';
	
	Gebi('txtName').value='';
	Gebi('txtAddress').value='';
	Gebi('txtCity').value='';
	Gebi('txtState').value='';
	Gebi('txtZip').value='';
	Gebi('txtPhone1').value='';
	Gebi('txtPhone2').value='';
	Gebi('txtFax').value='';
	Gebi('txtEmail').value='';
	Gebi('txtContact1').value='';
	Gebi('txtCphone1').value='';
	Gebi('txtEmail1').value='';
	Gebi('txtContact2').value = '';
	Gebi('txtCphone2').value = '';
	Gebi('txtEmail2').value = '';
	//Gebi('txtTax').value = '';
	//Gebi('txtMU').value = '';
	Gebi('txtNotes').value = '';
	Gebi('txtWebsite').value = '';
	Gebi('txtCustomer').value = '';
	Gebi('txtVendor').value = '';
	Gebi('chkCustomer').checked = false;
	Gebi('chkVendor').checked = false;
	
	var ctbNodes =Gebi('cTypeBox').childNodes;
	var ctbI;
	for(ctbI=0;ctbI<ctbNodes.length;ctbI++) {
		if(ctbNodes[ctbI].toString() == '[object HTMLLabelElement]') {
			var labelChildren=ctbNodes[ctbI].childNodes
			var lcI
			for(lcI=0;lcI<labelChildren.length;lcI++) {
				if(labelChildren[lcI].toString() == '[object HTMLInputElement]') {
					if(labelChildren[lcI].type=='checkbox') {
						labelChildren[lcI].checked=false;
					}
				}
			}
		}
	}
	
	HttpText='Contacts_ASP.asp?action=ContactEdit&ID='+ID
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnContactEdit;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);

	function ReturnContactEdit()	{
		if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				
				try { var xmlDoc = xmlHttp.responseXML.documentElement; }
				catch(e) {
					AjaxErr('There was a problem with the ContactEdit response xml.',HttpText)
					return false;
				}
				
				var ID = xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;
				
				//alert(ID);
				//var ID = xmlDoc.getElementsByTagName('ID')[0].childNodes[0].nodeValue;
				//alert(xmlDoc.getElementsByTagName('Name')[0].childNodes[0].nodeValue);
				
				var X = ''
				var Name = xmlDoc.getElementsByTagName('Name')[0].childNodes[0].nodeValue;			
				Name = Name.replace('-CannotBeNull-', '');
				if (Name == '--') {Name = X}
				Gebi('txtName').value = CharsDecode(Name);
				
				var Address = xmlDoc.getElementsByTagName('Address')[0].childNodes[0].nodeValue;			
				 Address= Address.replace('-CannotBeNull-', '');
				if (Address == '--') {Address = X}
				Gebi('txtAddress').value = CharsDecode(Address);
				
				var City = xmlDoc.getElementsByTagName('City')[0].childNodes[0].nodeValue;
				City = City.replace('-CannotBeNull-', '');
				if (City == '--') {City = X}
				Gebi('txtCity').value = CharsDecode(City);
				
				var State = xmlDoc.getElementsByTagName('State')[0].childNodes[0].nodeValue;
				State = State.replace('-CannotBeNull-', '');
				if (State == '--') {State = X}
				Gebi('txtState').value = State;
				
				var Zip = xmlDoc.getElementsByTagName('Zip')[0].childNodes[0].nodeValue;
				Zip = Zip.replace('-CannotBeNull-', '');
				if (Zip == '--') {Zip = X}
				Gebi('txtZip').value = Zip;
				
				var Phone1 = xmlDoc.getElementsByTagName('Phone1')[0].childNodes[0].nodeValue;
				Phone1 = Phone1.replace('-CannotBeNull-', '');
				if (Phone1 == '--') {Phone1 = X}
				Gebi('txtPhone1').value = formatPhone(Phone1);
				
				var Phone2 = xmlDoc.getElementsByTagName('Phone2')[0].childNodes[0].nodeValue;
				Phone2 = Phone2.replace('-CannotBeNull-', '');
				if (Phone2 == '--') {Phone2 = X}
				Gebi('txtPhone2').value = formatPhone(Phone2);
				
				var Fax = xmlDoc.getElementsByTagName('Fax')[0].childNodes[0].nodeValue;
				Fax = Fax.replace('-CannotBeNull-', '');
				if (Fax == '--') {Fax = X}
				Gebi('txtFax').value = formatPhone(Fax);
				
				var Email = xmlDoc.getElementsByTagName('Email')[0].childNodes[0].nodeValue;
				Email = Email.replace('-CannotBeNull-', '');
				if (Email == '--') {Email = X}
				Gebi('txtEmail').value = Email;
				
				var Contact1 = xmlDoc.getElementsByTagName('Contact1')[0].childNodes[0].nodeValue;
				Contact1 = Contact1.replace('-CannotBeNull-', '');
				if (Contact1 == '--') {Contact1 = X}
				Gebi('txtContact1').value = CharsDecode(Contact1);
				
				var Cphone1 = xmlDoc.getElementsByTagName('Cphone1')[0].childNodes[0].nodeValue;
				Cphone1 = Cphone1.replace('-CannotBeNull-', '');
				if (Cphone1 == '--') {Cphone1 = X}
				Gebi('txtCphone1').value = formatPhone(Cphone1);
				
				var Email1 = xmlDoc.getElementsByTagName('Email1')[0].childNodes[0].nodeValue;
				Email1 = Email1.replace('-CannotBeNull-', '');
				if (Email1 == '--') {Email1 = X}
				Gebi('txtEmail1').value = CharsDecode(Email1);
				
				var Contact2 = xmlDoc.getElementsByTagName('Contact2')[0].childNodes[0].nodeValue;
				Contact2 = Contact2.replace('-CannotBeNull-', '');
				if (Contact2 == '--') {Contact2 = X}
				Gebi('txtContact2').value = CharsDecode(Contact2);
				
				var Cphone2 = xmlDoc.getElementsByTagName('Cphone2')[0].childNodes[0].nodeValue;
				Cphone2 = Cphone2.replace('-CannotBeNull-', '');
				if (Cphone2 == '--') {Cphone2 = X}
				Gebi('txtCphone2').value = formatPhone(Cphone2);
				
				var Email2 = xmlDoc.getElementsByTagName('Email2')[0].childNodes[0].nodeValue;
				Email2 = Email2.replace('-CannotBeNull-', '');
				if (Email2 == '--') {Email2 = X}
				Gebi('txtEmail2').value = CharsDecode(Email2);
				
				//var Tax = xmlDoc.getElementsByTagName('Tax')[0].childNodes[0].nodeValue;
				//Tax = Tax.replace('-CannotBeNull-', '');
				//if (Tax == '--') {Tax = X}
				//Gebi('txtTax').value = Tax;
				
				//var MU = xmlDoc.getElementsByTagName('MU')[0].childNodes[0].nodeValue;
				//MU = MU.replace('-CannotBeNull-', '');
				//if (MU == '--') {MU = X}
				//Gebi('txtMU').value = MU;
				
				var Notes = xmlDoc.getElementsByTagName('Notes')[0].childNodes[0].nodeValue;
				Notes = Notes.replace('-CannotBeNull-', '');
				if (Notes == '--') {Notes = X}
				Gebi('txtNotes').value = CharsDecode(Notes);
				
				var Website = xmlDoc.getElementsByTagName('Website')[0].childNodes[0].nodeValue;
				Website = Website.replace('-CannotBeNull-', '');
				if (Website == '--') {Website = X}
				Gebi('txtWebsite').value = Website;
				
				var Customer = xmlDoc.getElementsByTagName('Customer')[0].childNodes[0].nodeValue;
				Customer = Customer.replace('-CannotBeNull-', '');
				if (Customer == '--') {Customer = 'False'}
				Gebi('txtCustomer').value = Customer;
				if (Customer == 'True') {Gebi('chkCustomer').checked = true;} else {Gebi('chkCustomer').checked = false;}
				
				var Vendor = xmlDoc.getElementsByTagName('Vendor')[0].childNodes[0].nodeValue;
				Vendor = Vendor.replace('-CannotBeNull-', '');
				if (Vendor == '--') {Vendor = 'False'}
				Gebi('txtVendor').value = Vendor;
				if (Vendor == 'True') {Gebi('chkVendor').checked = true;} else {Gebi('chkVendor').checked = false;}
				
				var ctList = xmlDoc.getElementsByTagName('ctList')[0].childNodes[0].nodeValue;
				ctList = ctList.replace('-CannotBeNull-', '').split(',');
				
				var cti;
				for(cti=0; cti<ctList.length; cti++) {
					Gebi('chkCType'+ctList[cti]).checked=true;
				}
				
				//var Human = xmlDoc.getElementsByTagName('Human')[0].childNodes[0].nodeValue;
				//Gebi('txtHuman').value = Human;
				//if (Human=='True') {	
				//	Gebi('chkHuman').checked = true;
				//	Gebi('chkBusiness').checked = false;
				//} else {
				//	Gebi('chkHuman').checked = false;
				//	if(Human=='False') { Gebi('chkBusiness').checked = true; }
				//}
					
			}
			else	{	AjaxErr('There was a problem with the ContactEdit request.',HttpText); }
		}
	}
}//-------------------------------------------------------------------------------------------------

function ContactUpdate() {//--Updates Contacts////////////////////////////////////////////////////////////////////
	var Name = CharsEncode(Gebi('txtName').value);
	var Address = CharsEncode(Gebi('txtAddress').value);
	var City = CharsEncode(Gebi('txtCity').value);
	var State = Gebi('txtState').value;
	var Zip = Gebi('txtZip').value;
	var Phone1 = unPhone(Gebi('txtPhone1').value);
	var Phone2 = unPhone(Gebi('txtPhone2').value);
	var Fax = unPhone(Gebi('txtFax').value);
	var Email = Gebi('txtEmail').value;
	var Contact1 = Gebi('txtContact1').value;
	var Cphone1 = unPhone(Gebi('txtCphone1').value);
	var Email1 = Gebi('txtEmail1').value;
	var Contact2 = Gebi('txtContact2').value;
	var Cphone2 = unPhone(Gebi('txtCphone2').value);
	var Email2 = Gebi('txtEmail2').value;
	//var Tax = Gebi('txtTax').value;
	//var MU = Gebi('txtMU').value;
	var Notes = CharsEncode(Gebi('txtNotes')).value;
	var Website = Gebi('txtWebsite').value;
	var Customer = Gebi('txtCustomer').value;
	var Vendor = Gebi('txtVendor').value;

	if(Name == ''){alert('Please Fill out the Name Box'); return false;}
	//if(Address == ''){alert('Please Fill out the Address Box'); return false;}
	//if(City == ''){alert('Please Fill out the City Box'); return false;}
	//if(State == ''){alert('Please Fill out the State Box'); return false;}
	//if(Phone1 == ''){alert('Please Fill out the Phone Number Box'); return false;}
	//if(Customer || Vendor) {} else {alert('Please specify Customer and/or Vendor'); return false;}
	
	var HttpText ='';
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnContactUpdate;
	HttpText = HttpText +('Contacts_ASP.asp?action=ContactUpdate&ID='+GlobalID+'&Name='+Name +'&Address='+Address);
	HttpText = HttpText +('&City='+City+'&State='+State+'&Zip='+Zip+'&Phone1='+Phone1);
	HttpText = HttpText +('&Phone2='+Phone2+'&Fax='+Fax+'&Contact1='+Contact1+'&Cphone1='+Cphone1);
	HttpText = HttpText +('&Email1='+Email1+'&Contact2='+Contact2+'&Cphone2='+Cphone2+'&Email2='+Email2);
	HttpText = HttpText +(/*'&Tax='+Tax+'&MU='+MU+*/'&Notes='+Notes+'&Website='+Website+'&Customer='+Customer+'&Vendor='+Vendor);
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
	
	function ReturnContactUpdate()	{
		if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				//AjaxErr('✓out the ContactUpdate request.', HttpText);
				var xmlDoc = xmlHttp.responseXML.documentElement;
				var Name = xmlDoc.getElementsByTagName('Name')[0].childNodes[0].nodeValue;
				var SQL = xmlDoc.getElementsByTagName('SQL')[0].childNodes[0].nodeValue;
				ContactsModalClose();
				Gebi('SearchContactsTxt').value = Name;
				SearchContacts();
				//alert(SQL);
			}
			else	{
				AjaxErr('There was a problem with the ContactUpdate request.', HttpText);
			}
		}
	}
}//-------------------------------------------------------------------------------------------------

function SaveContact() { //Saves a new contact////////////////////////////////////////////////
	var Name = CharsEncode(Gebi('txtName').value);
	var Address = CharsEncode(Gebi('txtAddress').value);
	var City = CharsEncode(Gebi('txtCity').value);
	var State = Gebi('txtState').value;
	var Zip = Gebi('txtZip').value;
	var Phone1 = (Gebi('txtPhone1').value.replace(/\./g,'').replace(/-/g,''));
	var Phone2 = (Gebi('txtPhone2').value.replace(/\./g,'').replace(/-/g,''));
	var Fax = (Gebi('txtFax').value.replace(/\./g,''));
	var Email = Gebi('txtEmail').value;
	var Contact1 = Gebi('txtContact1').value;
	var Cphone1 = (Gebi('txtCphone1').value.replace(/\./g,'').replace(/-/g,''));
	var Email1 = Gebi('txtEmail1').value;
	var Contact2 = Gebi('txtContact2').value;
	var Cphone2 = (Gebi('txtCphone2').value.replace(/\./g,'').replace(/-/g,''));
	var Email2 = Gebi('txtEmail2').value;
	//var Tax = Gebi('txtTax').value;
	//var MU = Gebi('txtMU').value;
	var Notes = CharsEncode(Gebi('txtNotes')).value;
	var Website = Gebi('txtWebsite').value;
	var Customer="False";
	if(Gebi('chkCustomer').checked)	{	Customer="True";	}
	var Vendor="False"
	if(Gebi('chkVendor').checked)	{	Vendor="True";	}
	
	if(Name == ''){alert('Company Name cannot be blank'); return false;}
	//if(Address == ''){alert('Please Fill out the Address Box'); return false;}
	//if(City == ''){alert('Please Fill out the City Box'); return false;}
	//if(State == ''){alert('Please Fill out the State Box'); return false;}
	//if(Phone1 == ''){alert('Please Fill out the Phone Number Box'); return false;}
	//if(Customer || Vendor) {} else {alert('Please specify Customer and/or Vendor'); return false;}

	HttpText='Contacts_ASP.asp?action=SaveContact&Name='+Name+'&Address='+Address+'&City='+City+'&State='+State+'&Zip='+Zip+'&Phone1='+Phone1+'&Phone2='+Phone2+'&Fax='+Fax+'&Contact1='+Contact1+'&Cphone1='+Cphone1+'&Email1='+Email1+'&Contact2='+Contact2+'&Cphone2='+Cphone2+'&Email2='+Email2+'&Notes='+Notes+'&Website='+Website+'&Customer='+Customer+'&Vendor='+Vendor;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				var Name = xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
				
				ContactsModalClose();
				Gebi('SearchContactsTxt').value = Name;
				SearchContacts();
			}
			else	{
				AjaxErr('There was a problem with the SaveContact request.',HttpText);
			}
		}
	}
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ContactDel() {//Deletes A Contact//////////////////////////////////////////////////////////
	var ConfirmTxt = 'Are you sure you want to delete ' + Gebi('txtName').value +'? This cannot be undone.'
	if (confirm(ConfirmTxt) == false) {return false}
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnContactDel;
	xmlHttp.open('Get','Contacts_ASP.asp?action=ContactDel&ID=' + GlobalID, true);
	xmlHttp.send(null);

	function ReturnContactDel() {
		if (xmlHttp.readyState == 4)	{
			if (xmlHttp.status == 200)	{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				ContactsModalClose();
				SearchContacts();
			}
			else	{
				AjaxErr('There was a problem with the ContactDel request.',HttpText);
			}
		}
	}
}