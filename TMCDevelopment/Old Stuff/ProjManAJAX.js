// JavaScript Document   AJAX CONTROLS


var xmlHttp;
var HttpText;
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
var OldText = new Array
function UpdateText(Table,Column,Text,IDColumn,RowID)
{
	var SysOK = 'No';
	
	//alert(BoxType+' '+BoxID);
	
	//Text = Text.replace('\r', '--RET--');
	
	HttpText = 'EstimatesASP.asp?action=UpdateText&Text='+CharsEncode(Text)+'&Table='+Table+'&IDColumn='+IDColumn+'&Column='+Column+'&RowID='+RowID+'&SysOK='+SysOK
	//alert(HTTPText);
	
	
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
		}
		else
		{
			AjaxErr('There was a problem with the ProjManAjax UpdateText request. /n/n     Your input may not be saved.',HttpText);
		}
	}
}
//-------------------------------------------------------------------------------------------------


var ProgCHttp
function ProgressClick(ProjID,Phase,DivID,Color,Symbol,ColumnID,TableName,SystemID)
{
	
	ProgCHttp='ProjManASP.asp?action=UpdateProgress&ProjID='+ProjID+'&Phase='+Phase+'&Symbol='+Symbol+'&ColumnID='+ProgColumn+'&TableName='+TableName+'&DivID='+DivID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnProgressClick;
	xmlHttp.open('Get',ProgCHttp, true);
	xmlHttp.send(null);
}
function ReturnProgressClick() 
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
	
			var Phase = xmlDoc.getElementsByTagName("Phase")[0].childNodes[0].nodeValue;
			var Symbol = xmlDoc.getElementsByTagName("Symbol")[0].childNodes[0].nodeValue;
			var Color = xmlDoc.getElementsByTagName("Color")[0].childNodes[0].nodeValue;
			var DivID = xmlDoc.getElementsByTagName("DivID")[0].childNodes[0].nodeValue;

			//Gebi(DivID).style.background='-webkit-gradient(linear,left top,left bottom,color-stop(0,rgba(255,255,255,.5)),color-stop(1,#'+Color+')';
			Gebi(DivID).style.backgroundColor='#'+Color;
			//Gebi(DivID).innerHTML=Symbol.replace(/--AMPERSAND--/g,'&');
			
			CloseProgressMenu();
			
			//alert(GetColumn('Plans'));
			switch(DivID)
			{
				case 'PlanProg':
					if(Phase==5&&GetColumn('PlansAsBuilts')!=2)
					{
						//alert(DivID+','+Phase);
						ProgColumn='PlansAsBuilts';
						ProgressClick(ProjID,5,'PrAsBuilts',Color,Symbol,'PlansAsBuilts','Projects');
					}
					break;
						
				case 'PrAsBuilts':
					if(Phase==5&&GetColumn('PlansApproved')!=2)
					{
						ProgColumn='PlansApproved';
						ProgressClick(ProjID,5,'PrApproved',Color,Symbol,'PlansApproved','Projects');
					}
					break;
						
				case 'PrApproved':
					if(Phase==5&&GetColumn('PlansSubmit')!=2)
					{
						ProgColumn='PlansSubmit';
						ProgressClick(ProjID,5,'PrSubmit',Color,Symbol,'PlansSubmit','Projects');
					}
					break;
						
				case 'PrSubmit':
					if(Phase==5&&GetColumn('PlansReview')!=2)
					{
						ProgColumn='PlansReview';
						ProgressClick(ProjID,5,'PrReview',Color,Symbol,'PlansReview','Projects');
					}
					break;
						
				case 'PrReview':
					if(Phase==5&&GetColumn('PlansPlot')!=2)
					{
						ProgColumn='PlansPlot';
						ProgressClick(ProjID,5,'PrPlot',Color,Symbol,'PlansPlot','Projects');
					}
					break;
						
				case 'PrPlot':
					if(Phase==5&&GetColumn('PlansDraw')!=2)
					{
						ProgColumn='PlansDraw';
						ProgressClick(ProjID,5,'PrDraw',Color,Symbol,'PlansDraw','Projects');
					}
					break;
						
				case 'PrDraw':
					if(Phase==5&&GetColumn('PlansOrig')!=2)
					{
						ProgColumn='PlansOrig';
						ProgressClick(ProjID,5,'PrOrig',Color,Symbol,'PlansOrig','Projects');
					}
					else
					{
					
					}
					break;
						
			}
		}
		else
		{
			alert('There was a problem with the ProgressClick request.');
			window.location=ProgCHttp;
		}
}	}

var ColumnValue;
function GetColumn(ColumnID)
{
	ColumnValue=null;
	//alert(this.id);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGetColumn;
	xmlHttp.open('Get','ProjManASP.asp?action=GetColumn&ColumnID='+ColumnID+'&ProjID='+ProjID, false);
	xmlHttp.send(null);
	
	while(ColumnValue==null)
	{
		//alert(xmlHttp.readyState+'  '+xmlHttp.status);
		
	}
	return ColumnValue;
}
	
function ReturnGetColumn()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			ColumnValue=xmlDoc.getElementsByTagName('Value')[0].childNodes[0].nodeValue;
			//alert(xmlDoc.getElementsByTagName('ColumnID')[0].childNodes[0].nodeValue.replace('--',''));
		}
		else
		{
			alert('There was a problem with the GetColumn request.');
			ColumnValue=99;
		}
	}
}





var NewInfoBoxTitle = null;
function MakeInfoBox(Title)
{
	if(Title==null||Title=='')
	{
		alert('Title is required.');
		Gebi('iBTitle').focus();
		return false;
	}
	
	NewInfoBoxTitle=Title
	
	HttpText='ProjManASP.asp?action=MakeInfoBox&Title='+Title+'&ProjID='+ProjID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnMakeInfoBox;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}

function ReturnMakeInfoBox()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			
			var xmlDoc = xmlHttp.responseXML.documentElement;
			
			try{
				var InfoBoxID=xmlDoc.getElementsByTagName('InfoBoxID')[0].childNodes[0].nodeValue;
				alert(xmlDoc.getElementsByTagName('Tries')[0].childNodes[0].nodeValue);
			}
			catch(e){AjaxErr('There is a problem with the MakeInfoBox XML Data.',HttpText);}
			
			CloseInfoBoxBox();
			
			iBNum++;
			var HTML='';
			HTML+='<div id="CustomInfoBox'+iBNum+'">';
			HTML+='	<div id="iTitle'+iBNum+'" class="iTitleCustom">';
			HTML+='		<img class="CustomIX" src="../images/closesmall.gif" onClick="DelInfoBox('+InfoBoxID+',this.parentNode.parentNode)"/>';
			HTML+='		<div class="iTitleTextCustom">'+NewInfoBoxTitle+'</div>';
			HTML+='		<div id="UpButton'+iBNum+'" href="javascript:Void();" onClick="RollUp('+iBNum+');" class="CustomIUp">▲</div>';
			HTML+='		<div id="DnButton'+iBNum+'" href="javascript:Void();" onClick="RollDn('+iBNum+');" class="CustomIDn">▼</div>';
			HTML+='	</div>';
			HTML+='	<div id="iRollUp'+iBNum+'" class="iRollup">';
			HTML+='		<div id="iBox'+iBNum+'" class="iBoxCustom">';
			HTML+='		<div id="infoBox'+iBNum+'customData"></div>';
			HTML+='			<button class="iBoxButton" style="color:#080;" title="New Info. Field" onClick="ShowInfoBoxDataBox('+InfoBoxID+','+iBNum+');">+</button>';
			HTML+='			<br/>';
			HTML+='		</div>';
			HTML+='	</div>';
			HTML+='</div>';
			
			Gebi('CustomInfoBoxOverallDiv').innerHTML+=HTML;
			Resize();
		}
		else
		{
			AjaxErr('There was a problem with the MakeInfoBox request.',HttpText);
}	}	}

function MakeInfoBoxData(){
	//SendSQL('Write','INSERT INTO InfoBoxData (InfoBoxID, Name) VALUES ('+InfoBoxID+', \''+Gebi('iBDTitle').value+'\')');
	HttpText='ProjManASP.asp?action=MakeInfoBoxData&Name='+Gebi('iBDTitle').value+'&InfoBoxID='+InfoBoxID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnMakeInfoBoxData;
	xmlHttp.open('Get',HttpText, true);
	xmlHttp.send(null);
}
function ReturnMakeInfoBoxData()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			var xmlDoc = xmlHttp.responseXML.documentElement;
			try{
				var InfoBoxDataID=xmlDoc.getElementsByTagName('InfoBoxDataID')[0].childNodes[0].nodeValue;
				var Name=xmlDoc.getElementsByTagName('Name')[0].childNodes[0].nodeValue;
			}
			catch(e){AjaxErr('There is a problem with the InfoBoxDataID XML object.',HttpText); return false;}
			
			RollUp(InfoBoxNum);
			
			iBDNum++;
			var HTML='';
			
			var TN='CustomData'+InfoBoxNum+"-"+iBDNum;
		
			HTML+='<div id="'+TN+'Div" class="InfoDiv" onClick="try{Gebi(\''+TN+'\').focus();}catch(e){}">';
			HTML+='	<img src="../images/closesmall.gif" style="cursor:pointer;" onClick="DelInfoBoxData('+InfoBoxDataID+',this.parentNode);"/>';
			HTML+='	<label for="'+TN+'" class="InfoLabel">'+Name+'<br/></label>';
			HTML+='	<input id="'+TN+'" type="text" class="InfoText" onKeyUp="UpdateText(\'InfoBoxData\',\'Data\',this.value,\'InfoBoxDataID\','+InfoBoxDataID+');"/>';
			HTML+='</div>';
		
			
			Gebi('infoBox'+InfoBoxNum+'customData').innerHTML+=HTML
			
			Gebi('iBDTitle').value='';
			CloseInfoBoxBox();
			RollDn(InfoBoxNum);
		}
		else
		{
			AjaxErr('There was a problem with the MakeInfoBoxData request.',HttpText);
}	}	}





function DelInfoBox(RowID,RemoveID){
	if(confirm('This will delete the box and all the data inside!')){
		SendSQL('Write','DELETE FROM InfoBoxData WHERE InfoBoxID='+RowID)
		SendSQL('Write','DELETE FROM InfoBoxes WHERE InfoBoxID='+RowID)
		RemoveID.parentNode.removeChild(RemoveID);
	}
}

function DelInfoBoxData(RowID,RemoveID){
	if(confirm('Deleting Data!')){
		SendSQL('Write','DELETE FROM InfoBoxData WHERE InfoBoxDataID='+RowID);
		RemoveID.parentNode.removeChild(RemoveID);
	}
}







var xmlHttp4;
var HttpText4;
function GenerateBOM()
{
	xmlHttp4=null;
	
	HttpText4='ProjManASP.asp?action=GenerateBOM&ProjID='+ProjID;
	xmlHttp4 = GetXmlHttpObject();
	xmlHttp4.onreadystatechange = ReturnGenerateBOM;
	xmlHttp4.open('Get',HttpText4, true);
	DebugBox(a(HttpText4));
	xmlHttp4.send(null);
	
	function ReturnGenerateBOM()
	{
		if (xmlHttp4.readyState == 4)
		{
			if (xmlHttp4.status == 200)
			{
				if(xmlHttp4.responseXML==null){DebugBox(a(HttpText4)); return false;}
				var xmlDoc = xmlHttp4.responseXML.documentElement;
				BomContent(ProjID,'True');
			}
			else
			{
				AjaxErr('There was a problem with the GenerateBOM request.',HttpText4);
				//BomContent(ProjID,'True');
}	}	} }
////////////////////////////////////////////////////////////////////////////////////////////////////////
function GenerateEmptyBOM()
{
	//	SQL6="INSERT INTO BOMItems (SystemID, Manufacturer, ItemName, Description, Qty)"
	
	SendSQL('Write','UPDATE Projects SET BOMIsGenerated=\'True\' WHERE ProjID='+ProjID);
	BomContent(ProjID,'True');
}
///////////////////////////////////////////////////////////////////////////////////////////////////////


function DeleteBOM() //----------------------Deletes the whole thing-----------------------------------------
{
	if(!confirm('           - A T T E N T I O N -   \n\n Delete list(s)!? -This applies to all systems in the project.'))
	{return false}
	HttpText='ProjManASP.asp?action=DeleteBOM&ProjID='+ProjID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnGenerateBOM;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);
	return true;
}
function ReturnGenerateBOM()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			if(xmlHttp.responseXML==null){DebugBox(a(HttpText)); return false;}
			var xmlDoc = xmlHttp.responseXML.documentElement;
			BomContent(ProjID,'False');
		}
		else
		{
			AjaxErr('There was a problem with the DeleteBOM request.',HttpText);
			BomContent(ProjID,'True');
}	}	}

/////////////////////////////////

function delParts()
{
	if(!confirm('Are you sure you want to delete the selected parts from the B.O.M. ?')){return false}
	inputs=document.getElementsByTagName('input')
	pCount=0
	for(i in inputs)
	{
		if(inputs[i].type=='checkbox'&&inputs[i].checked)
		{
			if(inputs[i].id.indexOf('SelItem')!=-1)
			{
				var BOMItemsID=inputs[i].id.replace('SelItem','');
				SendSQL('Write','DELETE FROM BOMItems WHERE BOMItemsID='+BOMItemsID);
				pCount++;
			}
		}
	}
	BomContent(ProjID,'True');
	alert(pCount+' lines have been delted.');
}

//////////////////////////////////////////////////////////////////////////////////////
function searchParts()
{
	HttpText='ProjManASP.asp?action=searchParts&PN='+encodeURI(Gebi('searchPartNum').value);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnSearchParts;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);
}
function ReturnSearchParts()
{
	if (xmlHttp.readyState == 4)
	{
		if (xmlHttp.status == 200)
		{
			function xmlData(tagName)
			{
				try{return xmlHttp.responseXML.documentElement.getElementsByTagName(tagName)[0].childNodes[0].nodeValue;}
				catch(e)
				{
					Gebi('PartsResults').innerHTML+='<br/>Cannot Find XML tag:<font face="consolas">'+tagName+'</font>   <a href="../'+HttpText+'" target="_blank">?</a>';
				}
			}
			var pCount= xmlData('pCount');
			if(pCount>0)
			{
				var results='';
				for(r=1;r<=pCount;r++)
				{
					//var sqlValues= ,'"+xmlData('Vendor1.'+r)+"','"+xmlData('Mfr'+r)+"','"+xmlData('PN'+r)+"','"+xmlData('Desc'+r)+"',1";
					//var SQL='INSERT INTO BOMItems () VALUES ('+sqlValues+')';
					var sqlValues= ProjID+',\\\''+xmlData('Vendor2.'+r)+'\\\', \\\''+xmlData('Vendor1.'+r)+'\\\', \\\''+xmlData('Mfr'+r)+'\\\', \\\''+xmlData('PN'+r)+'\\\', \\\''+xmlData('Desc'+r)+'\\\', 1';
					var SQL='INSERT INTO BOMItems (ProjID, Vendor2, Vendor1, Manufacturer, ItemName, Description, Qty) VALUES ('+sqlValues+')';
					results+='<div class="PartsResult" onclick="SendSQL(\'Write\',\''+SQL+'\'); BomContent('+ProjID+',\'True\');" style="">';
					results+='	<div style="width:50%; height:18px; float:left; height:18px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">';
					results+= 		xmlData('PN'+r);
					results+='	</div>';
					results+='	<div style="width:50%; height:18px; float:left; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">';
					results+='		<div style="width:1px; height:100%; background:#000; float:left;"></div>';
					results+='		'+xmlData('Mfr'+r);
					results+='	</div>';
					results+='</div>';
				}
				Gebi('PartsResults').innerHTML=results; 
			}
		}
		else
		{
			AjaxErr('There was a problem with the searchParts request.',HttpText);
}	}	}
////////////////////////////////////////////////////////////////////////////////////////


function ListEntryUpdate(RowID,Field,FieldID)
{
	var TextString = Gebi(FieldID).value;
	//alert(TextString); 
	if (TextString==''||TextString==null) {TextString = '0'}
	
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = function()
	{
		if (xmlHttp.readyState == 4)
		{
			if (xmlHttp.status == 200)
			{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				var RowID = xmlDoc.getElementsByTagName("RowID")[0].childNodes[0].nodeValue;
				//alert(RowID);
				//alert(xmlDoc.getElementsByTagName("SQL")[0].childNodes[0].nodeValue);
				//CalculateItemRow(RowID);
			}
			else
			{
				Gebi(FieldID).value=OldValues[FieldID];
				alert('There was a problem with the ListEntryUpdate request.');
			}
		}
	}
	xmlHttp.open('Get','ProjManASP.ASP?action=ListEntryUpdate&RowID='+RowID+'&FieldName='+Field+'&TextString='+TextString, true);
	xmlHttp.send(null);
}
//-------------------------------------------------------------------------------------------------




function BomContent(ProjID,BomIsGenerated)
{
	HttpText='ProjManASP.asp?action=BomContent&ProjID='+ProjID+'&BomIsGenerated='+BomIsGenerated;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnBomContent;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);
}

function ReturnBomContent()
{
	if(xmlHttp.readyState==4)
	{
		if (xmlHttp.status==200)
		{
			try{var xmlDoc = xmlHttp.responseXML.documentElement;}
			catch(e)
			{
				AjaxErr('There was a problem with the BomContent response.',HttpText);
				return false
			}
			
			var BomHtml=xmlDoc.getElementsByTagName('BOM')[0].childNodes[0].nodeValue;
			//alert(BomHtml);
			Gebi('BOMBox').innerHTML=BomHtml;
			
			Gebi('PartsBox').style.display='none';
			Gebi('Modal').style.display='none';
		}
		else
		{
			AjaxErr('There was a problem with the BomContent request.',HttpText);
		}
	}
}





function BomRemove(RowID)
{
	if(!confirm('Delete this Item?')){return false;}
	
	HttpText='ProjManASP.ASP?action=BomRemove&RowID='+RowID;
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnBOMRemove;
	xmlHttp.open('Get', HttpText, true);
	xmlHttp.send(null);

	function ReturnBOMRemove(ItemID)
	{
		if (xmlHttp.readyState == 4)
		{
			if (xmlHttp.status == 200)
			{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				BomContent(ProjID,'True');
			}
			else
			{
				AjaxErr('There was a BomRemove Error.  The item may or may not have been deleted.',HttpText);
				BomContent(ProjID,'True');
			}
		}
	}
}


function LoadSchList()
{
	HttpText='ProjManASP.ASP?action=LoadSchList&ProjID='+ProjID;
	//AjaxErr('Sending ProjMan AJAX: LoadSchList \n'+HttpText,HttpText);
	xmlHttp = GetXmlHttpObject();
	xmlHttp.onreadystatechange = ReturnLoadSchList;
	xmlHttp.open('Get', HttpText, false);
	xmlHttp.send(null);

	function ReturnLoadSchList()
	{
		//alert(xmlHttp.readyState);
		if (xmlHttp.readyState == 4)
		{
			//alert(xmlHttp.status);
			if (xmlHttp.status == 200)
			{
				var xmlDoc = xmlHttp.responseXML.documentElement;
				
				var RecordCount=xmlDoc.getElementsByTagName('RecordCount')[0].childNodes[0].nodeValue;
				if(isNaN(RecordCount*1)){AjaxErr('Number of Schedules:'+RecordCount,HttpText); return false;}
				
				var CalID;
				var Title;
				var DateFrom;
				var DateTo;
				var Time;
				var Repeat;
				var RepeatID;
				var Note;
				var AttentionID;
				var Phase;
				var CrewNames;
				var Done;
				
				var L='<br/>';
				
				var labelStyle='float:left; display:inline;';
				var inputStyle='float:left; display:inline;';
				
				for(i=1;i<=RecordCount;i++)
				{
					CalID=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('CalID')[0].childNodes[0].nodeValue;
					Title=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('Title')[0].childNodes[0].nodeValue.replace('--','');
					DateFrom=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('DateFrom')[0].childNodes[0].nodeValue;
					DateTo=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('DateTo')[0].childNodes[0].nodeValue;
					Time=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('Time')[0].childNodes[0].nodeValue;
					Repeat=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('Repeat')[0].childNodes[0].nodeValue;
					RepeatID=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('RepeatID')[0].childNodes[0].nodeValue;
					Note=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('Note')[0].childNodes[0].nodeValue;
					AttentionID=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('AttentionID')[0].childNodes[0].nodeValue;
					Phase=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('Phase')[0].childNodes[0].nodeValue;
					CrewNames=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('CrewNames')[0].childNodes[0].nodeValue;
					Done=xmlDoc.getElementsByTagName('Row'+i)[0].getElementsByTagName('Done')[0].childNodes[0].nodeValue;
					
					L+='<div id="Row'+i+'" style=width:100%;">';
						L+='<div style="float:Left">';
							L+='<label for="SchTitle" style="'+labelStyle+'"><b> Title:</b></label>';	
							L+='<input id="SchTitle" style="'+inputStyle+'" value="'+Title+'" onchange="UpdateCal(\'Title\', this.value,'+CalID+')"/>';
						L+='</div>';
						
					L+='</div>';
				}
				
				Gebi('SchList').innerHTML=L;
			}
			else
			{
				AjaxErr('ProjMan AJAX Error: LoadSchList \n'+HttpText,HttpText);
			}
		}
	}
}

function UpdateCal(Field, Value, CalID){SendSQL('Write',"UPDATE Calendar SET "+Field+"='"+Value+"' WHERE CalID="+CalID);}



function NewSched(TheDate)
{
	if(TheDate==null||TheDate==undefined)
	{
		TheDate = new Date;
		TheDate=(TheDate.getMonth()+1)+'/'+TheDate.getDate()+'/'+TheDate.getFullYear();
	}
	var SQL="INSERT INTO Calendar ";
	 SQL+="(";
	 SQL+="Title, ";
	 SQL+="DateFrom, ";
	 SQL+="DateTo, ";
	 SQL+="Attention, ";
	 SQL+="AttentionID, ";
	 SQL+="Task, ";
	 SQL+="TaskID, ";
	 SQL+="CrewNames, ";
	 SQL+="Done, ";
	 SQL+="TaskEventTable, ";
	 SQL+="TaskEventID) ";
	 SQL+="VALUES (";
	 SQL+="'"+CharsEncode(parent.document.getElementById('ProjName').value)+"', ";
	 SQL+="'"+TheDate+"', ";
	 SQL+="'"+TheDate+"', ";
	 SQL+="'"+parent.parent.accessEmpName+"', ";
	 SQL+="'"+parent.parent.accessEmpID+"', ";
	 SQL+="'Project / Jobs', ";
	 SQL+="1, ";
	 SQL+="'"+parent.parent.accessEmpName+"', ";
	 SQL+="'False', ";
	 SQL+="'Projects', ";
	 SQL+="'"+ProjID+"'";
	 
	SQL+=")";
	
	SendSQL('Write', SQL);
	var Sch=parent.document.getElementById('SchFrame');
	Sch.src=Sch.src;
}

function DelSched(ID)
{
	if(!confirm('\n Are You absolutely positively certain you want to DELETE this Schedule Item? \n')){return false}
	SQL='DELETE FROM Calendar WHERE CalID='+ID;
	SendSQL('Write', SQL);
	var Sch=parent.document.getElementById('SchFrame');
	Sch.src=Sch.src;
}