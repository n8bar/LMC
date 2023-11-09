// JavaScript Document



function Validate(This) {
	if((/[^\d\.]/).test(This.value))	{
		alert('Invalid Character! Only numbers are allowed');
		This.value=This.value.replace(/[^\d\.]/,'');
	}
}
   

function Replace(This)	{
       This.value=This.value.replace(/[^\d\.]/,'');	
}

function getStyle(el,styleProp){//Gets the style element from a div id
	var x = Gebi(el);
	if (x.currentStyle)
		var y = x.currentStyle[styleProp];
	else if (window.getComputedStyle)
		var y = document.defaultView.getComputedStyle(x,null).getPropertyValue(styleProp);
	return y;
}



//--Closes Contacts Modal////////////////////////////////////////////////////////////////////

function ContactsModalClose()	{
	
	Gebi('ContactsModal').style.display = 'none';
	Gebi('ContactsModalBox').style.display = 'none';
	
}
//--------------------------------------------------------------------------


//Adds a Contact//////////////////////////////////////////////////////////////

function AddContact()	{
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
//	Gebi('txtTax').value = '';
//	Gebi('txtMU').value = '';
	Gebi('txtNotes').value = '';
	Gebi('txtWebsite').value = '';
	Gebi('txtCustomer').value = '';
	Gebi('txtVendor').value = '';
	Gebi('chkCustomer').checked = false;
	Gebi('chkVendor').checked = false;
	Gebi('chkHuman').checked = false;
	Gebi('chkBusiness').checked = false;
	 
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
	
function CBHumBiz() {
	if (Gebi('chkHuman').checked) { 
		Gebi('txtHuman').value = 'True'; 
		Gebi('txtBusiness').value = 'False'; 
	}
	else {
		Gebi('txtHuman').value = 'False'; 
		Gebi('txtBusiness').value = 'True'; 
	}
}
	
	
function cTypeSet(ctId) {
	if (Gebi('chkCType'+ctId).checked) {
		WSQL('INSERT INTO ContactsType (ContactID,TypeID) VALUES('+GlobalID+','+ctId+')');
	}
	else {
		WSQL('DELETE FROM ContactsType WHERE TypeID='+ctId+' AND ContactID='+GlobalID)
	}
}
//-------------------------------------------------------------------------------------------------





