//JavaScript Document
function printPO()	{
	Gebi('Print').style.display='none';
	Gebi('Back').style.display='none';
	Gebi('Back2').style.display='none';
	window.print();
	Gebi('Print').style.display='block';
	Gebi('Back').style.display='block';
	Gebi('Back2').style.display='block';
}


function CheckAllPOItems(check)	{
	var inputs=document.getElementsByTagName('input')
	for(i=0;i<inputs.length;i++)
	{
		if(inputs[i].type=='checkbox')
		{
			inputs[i].checked=check;
	}	}
}


function PartMenu(posObj)	{
	var ScrollTop = document.body.scrollTop;
	if (!ScrollTop)
	{
		if (window.pageYOffset)	{	ScrollTop = window.pageYOffset;	}
		else
		{
			ScrollTop = (Gebi('Document')) ? Gebi('Document').scrollTop : 0;
			ScrollTop = ScrollTop-Gebi('Document').offsetTop;
		}
	}
	var menuX=posObj.offsetLeft+posObj.offsetWidth;
	var menuY=mY+ScrollTop	//posObj.offsetTop+posObj.offsetHeight;
	
	Gebi('ItemMenu').style.left=menuX+'px';
	Gebi('ItemMenu').style.top=menuY+'px';
	Gebi('ItemMenu').style.display='block';
}



function DeletePOItem()	{
	var inputs=document.getElementsByTagName('input');
	var nothingSelected=true;
	var checks = new Array;
	var c=-1
	for(i=0;i<inputs.length;i++)
	{
		if(inputs[i].type=='checkbox'&&inputs[i].checked)
		{
			nothingSelected=false;
			
			c++;
			checks[c]=inputs[i];
			//alert(checks[c].id);
	}	}
	
	if(nothingSelected){alert('Nothing is selected.'); return false;}
	
	if(!confirm('Deleting P.O. Item(s) \n\n This cannot be undone.')){return false;}
	
	for(c=0;c<checks.length;c++)
	{
		if(checks[c].id.replace('Sel','')!=checks[c].id)
		{
			var POItemsID=checks[c].id.replace('Sel','');
			SendSQL('Write','DELETE FROM POItems WHERE POItemsID='+POItemsID);
			checks[c].parentNode.parentNode.parentNode.removeChild(checks[c].parentNode.parentNode);
			Total();
}	}	}
	


function ChangePO(newPOID)	{
	var inputs=document.getElementsByTagName('input');
	var nothingSelected=true;
	var checks = new Array;
	var c=-1
	for(i=0;i<inputs.length;i++)
	{
		if(inputs[i].type=='checkbox'&&inputs[i].checked)
		{
			nothingSelected=false;
			
			c++;
			checks[c]=inputs[i];
			//alert(checks[c].id);
	}	}
	
	if(nothingSelected){alert('Nothing is selected.'); return false;}
	
	if(!confirm('Moving selected P.O. Item(s)...')){return false;}
	
	for(c=0;c<checks.length;c++)
	{
		if(checks[c].id.replace('Sel','')!=checks[c].id)
		{
			var POItemsID=checks[c].id.replace('Sel','');
			WSQLU('POItems','POID',newPOID,'POItemsID',POItemsID);
			checks[c].parentNode.parentNode.parentNode.removeChild(checks[c].parentNode.parentNode);
			Total();
}	}	}
	


function PlusPOItem(Add)	{
	Add*=1;
	var inputs=document.getElementsByTagName('input')
	var nothingSelected=true
	for(i=0;i<inputs.length;i++)
	{
		if(inputs[i].type=='checkbox'&&inputs[i].checked)
		{
			nothingSelected=false;
	}	}
	
	if(nothingSelected){alert('Nothing is selected.'); return false;}
	
	for(i=0;i<inputs.length;i++)
	{
		if(inputs[i].type=='checkbox'&&inputs[i].checked)
		{
			var qtyBox = Gebi(inputs[i].id.replace('Sel','Qty'));
			var POItemsID=inputs[i].id.replace('Sel','');
			var newQty = (qtyBox.value*1)+Add;
			SendSQL('Write','UPDATE POItems SET Qty='+newQty+' WHERE POItemsID='+POItemsID);
			qtyBox.value=(qtyBox.value*1)+Add;
			Total();
}	}	}

function SelectVendor(VendorObj)
{
	WSQLU('PurchaseOrders','VendorID',VendorObj.value,'POID',POID)
	window.location.reload();
}

var mX=0
var mY=0
var mDown= new Array(false,false,false,false,false,false,false);
var BoxX;
var BoxY;
var OldBoxTop;
var OldBoxLeft;
var InnerMX;
var InnerMY;
var iMX;
var iMY;
function PartsMouseMove(event,boxID)	{
	if (!event){event = window.event;}
	mX = event.clientX;
	mY = event.clientY;
	iMX = event.clientX-Gebi(boxID).offsetLeft;
	iMY = event.clientY-Gebi(boxID).offsetTop;
	
	if(!!InnerMX&&!!InnerMY)	{
		if(mX>=0&&mY>=0&&mX<Gebi(boxID).offsetWidth)//&&mY<Gebi(boxID).offsetHeight-64
		{
			//window.top.document.getElementById('UnderTabs').innerHTML='mX:'+mX+', mY:'+mY+', ix:'+InnerMX+', iy:'+InnerMY+'  -  Buttons:'+mDown;
			if(mDown[0])//left mouse button
			{
				Gebi(boxID).style.left = (mX-InnerMX)+'px';
				Gebi(boxID).style.top = (mY-InnerMY)+'px';
			}
		}
	}
}

function pMouseMove(event,boxID)	{
	if (!event){event = window.event;}
	mX = event.clientX+Gebi(boxID).offsetLeft;
	mY = event.clientY+Gebi(boxID).offsetTop;
	iMX = event.clientX;
	iMY = event.clientY;
	
	if(!!InnerMX&&!!InnerMY)	{
		if(mX>=0&&mY>=0&&mX<Gebi(boxID).offsetWidth)//&&mY<Gebi(boxID).offsetHeight-64
		{
			//window.top.document.getElementById('UnderTabs').innerHTML='mX:'+mX+', mY:'+mY+', ix:'+InnerMX+', iy:'+InnerMY+'  -  Buttons:'+mDown;
			if(mDown[0])//left mouse button
			{
				Gebi(boxID).style.left = (mX-InnerMX)+'px';
				Gebi(boxID).style.top = (mY+InnerMY)+'px';
			}
		}
	}
}

function PartsMouseDown(event)	{
	//BoxX=mX; BoxY=mY;
	//window.top.document.getElementById('UnderTabs').innerHTML=event;
	InnerMX=iMX; InnerMY=iMY;
	mDown[event.button]=true;
}

function PartsMouseUp(event)	{
	mDown[event.button]=false;
}
////////////////////////////////////////////

var totalPrice=0;
function Total()	{
	var totals=Gebc('RowTotal');
	var nothingSelected=true;
	
	var subTotal=0;
	for(t=0;t<totals.length;t++)
	{
		//Gebi('Document').innerHTML+=(totals[t].innerHTML+'<br/>');
		subTotal+=(unCurrency(totals[t].innerHTML));
	}
	
	Gebi('subTotal').innerHTML=subTotal;
	var SH=Gebi('SH').value;
	if(isNaN(SH*1)	||	SH=='')		{	Gebi('SH').value='0';	SH=0;}
	var taxR=(Gebi('taxRate').value/100);
	if(isNaN(taxR)	||	taxR=='')		{	Gebi('taxRate').value='7.75';	taxR=.0775;}
	Gebi('taxesBox').innerHTML=formatCurrency(taxR*subTotal);
	var taxes=unCurrency(Gebi('taxesBox').innerHTML);
	//alert('subTotal:'+subTotal+'   taxes:'+taxes+'   taxes:'+taxes);
	totalPrice=subTotal+taxes+unCurrency(Gebi('SH').innerHTML*1);
	Gebi('totalBox').innerHTML=formatCurrency(totalPrice);
	//Gebi('totalBox').innerHTML=totalPrice;
}


function Resize()	{
	Gebi('Document').style.height='100%';
	Gebi('Document').style.height=(Gebi('Document').offsetHeight-Gebi('Toolbar').offsetHeight)+'px';
	Gebi('ChangePOMenu').style.left=Gebi('ChangePO').offsetLeft+'px';
	Gebi('ChangePOMenu').style.top=(Gebi('ChangePO').offsetTop+Gebi('ChangePO').offsetHeight)+'px';
}


     /////////////////////////////////////////////////////////////////////////
   //                                                                       //
  //                                  AJAX	                               //
 //                                                                       //
 /////////////////////////////////////////////////////////////////////////

//Create the main XMLHttpRequest object///////////////////////////////////////////////////
var xmlHttp;
var HttpText;
function GetXmlHttpObject()	{
	var xmlHttp=null;
	try  {  xmlHttp=new XMLHttpRequest(); /* Firefox, Opera 8.0+, Safari*/  }
	catch (e)
	{ /* Internet Explorer */
		try	{	xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");	}
		catch (e)	{	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");	}
	}
	if (xmlHttp==null)
	{
		alert ("Your browser does not support AJAX!");
		return false;
	}
	return xmlHttp;
}
//-----------------------------


function AddPart(PartID)	{
	HttpText='PO-AddPart.asp?ID='+PartID+'&POID='+POID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnAddPart;
	xmlHttp.open('Get',HttpText, false);
	xmlHttp.send(null);
}

function ReturnAddPart()	{
	if (xmlHttp.readyState == 4)	{
		if (xmlHttp.status == 200)	{
			var xmlDoc=xmlHttp.responseXML.documentElement;
			function xmlTag(tagName) {return xmlDoc.getElementsByTagName(tagName)[0].childNodes[0].nodeValue;}
			
			var pID= xmlTag('pID');
			var PN= xmlTag('PN');
			var Desc= xmlTag('Desc');
			var Cost= xmlTag('Cost');
			var POItemsID= xmlTag('POItemsID');
			
			PartsI++;
			var NewRow = '<div id="partRow'+PartsI+'" class="Row"> ';
			
			NewRow+='<label class="RowItem" style="width:5%; padding-top:2px;" align=center>';
			NewRow+='	<input id="Sel'+pID+'" type="checkbox"/>';
			NewRow+='</label>';
			NewRow+='	<input id="Qty'+pID+'" class="ItemQty RowItem" style="width:5%; color:inherit;" value="1"';
			NewRow+='	 onKeyUp="';
			NewRow+='	 	var Q= this.value;';
			NewRow+='	 	if(Q==\'\'){Q=0;}';
			NewRow+='	 	this.style.backgroundColor=\'rgba(255,0,0,.25)\';';
			NewRow+='	 	SendSQL(\'Write\',\'UPDATE POItems SET Qty=\'+Q+\' WHERE POITemsID='+POItemsID+'\');';
			NewRow+='	 	Gebi(\'RowTotal'+POItemsID+'\').innerHTML=(Q*'+Cost+');';
			NewRow+='	 	Total();';
			NewRow+='	 	this.style.backgroundColor=\'rgba(128,128,128,.25)\';	';
			NewRow+='	 "	';
			NewRow+='/>';
			NewRow+='	<span class="RowItem" style="width:18%;" >'+PN+' </span>';
			NewRow+='	<span class="RowItem" style="width:48%;" >'+Desc+' </span>';
			NewRow+='	<span class="RowItem" style="width:12%;" >'+Cost+' </span>';
			NewRow+='	<span class="RowItem" id="RowTotal'+POItemsID+'" style="width:12%; border-right:none;" >'+Cost+' </span>';
			NewRow+='</div>';
			
			Gebi('POItemsList'+Page).innerHTML+=NewRow;
		}
		else{AjaxErr('Request:AddPart failed.',HttpText);}
	}
}
///////////////////////////////////////////////////////////////////////////////
