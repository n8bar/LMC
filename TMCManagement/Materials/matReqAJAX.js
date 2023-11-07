// JavaScript Document   AJAX CONTROLS

function BidPartToMR(BidItemsID) {
	HttpText='MaterialsASP.asp?action=BidPartToMR&mrId='+mrId+'&BidItemsID='+BidItemsID;
	xhr = getXHR();
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				
				try {var xml=(xhr.responseXML.documentElement);	}			
				catch(e) { AjaxErr('There was a problem with the BidPartToMR response document.',HttpText);	return false;}
				
				//AjaxErr('Testing adder wagon. \n (n8 forgot to take this msg out)',HttpText);	
				
				xml=xml2json(xml);
				
				if(xml.count*1==0) {
					alert('Part # could not be added because it is not tied to the database.')
				}
			}
			else {
				AjaxErr('There was a problem with the BidPartToMR request.',HttpText);
			}
			loadMRs();
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}

var mrId;
var MRData;
function loadMRs() {
	Gebi('Modal').style.display='block';
	Gebi('modalStatus').innerHTML='Loading Material Request<br/><span id=statusDots></span>';
	HttpText='MaterialsASP.asp?action=loadMRs&projID='+ProjID;
	xhr = getXHR();
	xhr.onreadystatechange = function() {
		Gebi('statusDots').innerHTML+='. ';
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {

				try {var xml=xml2json(xhr.responseXML.documentElement);}
				catch(e) { AjaxErr('There was a problem with the BidPartToMR response document.',HttpText);	return false;}
				
				MRData=xml;
				//AjaxErr('There was a problem with the BidPartToMR response document.',HttpText)
				//alert('done='+xml.MatReq[0].done+'\nnone='+xml.MatReq[0].none);
				
				var HTML='';
				
				var done;
				mrId=false;
				if (xml.mrCount>0) { 
					done=xml.MatReq[0].done; 
					if(!done) mrId=xml.MatReq[0].id;
				}
				else { 
					done=true;
					xml.MatReq=false;
				}
				if(!!xml.MatReq) mr
				
				if (done) {
					var mrStartIndex=0;
					HTML+='	<form id=newMR action="javascript:newMatReq(Gebi(\'newMR\'));" style="height:auto; width:90%; margin:0 0 0 5%;">';
					HTML+='		<h3>New Material Request:</h3>';
				}
				else {
					var mrStartIndex=1;
					HTML+='	<form id=newMR action="javascript:updateMatReq(Gebi(\'newMR\'));" style="height:auto; width:90%; margin:0 0 0 5%; display:none;">';
					HTML+='		<h3>Details:</h3>';
				}
				
				var date=new Date(); //date= new Date((date.getMonth()+1)+'/'+date.getDate()+'/'+date.getFullYear()+' 0:00');
				var later=new Date(Date.parse(date)+(1000*60*60*24*30)-0);
				later=(later.getMonth()+1)+'/'+later.getDate()+'/'+later.getFullYear();
				HTML+='		<h5 style="margin-bottom:0;">Ship To:</h5>';
				HTML+='		<label class="taR w100p fL wsnw">Recipient\'s Name:<input class="w70p fR" name=shipToAttn maxlength=100 value="'+(xml.MatReq?xml.MatReq[0].shipToAttn:'')+'" /></label><big><big><br></big></big>';
				HTML+='		<label class="taR w100p fL wsnw" style=font-family:Condensed; >Company / Facility:<input class="w70p fR" name=shipToName  maxlength=100 value="'+(xml.MatReq?xml.MatReq[0].shipToName:'')+'" /></label><big><big><br></big></big>';
				HTML+='		<label class="taR w100p fL wsnw">Street Address:<input class="w70p fR" name=shipToAddress maxlength=100 value="'+(xml.MatReq?xml.MatReq[0].shipToAddress:'')+'" /></label><big><big><br></big></big>';
				HTML+='		<label class="taR w50p fL wsnw">City:<input class="w80p fR" name=shipToCity maxlength=50 value="'+(xml.MatReq?xml.MatReq[0].shipToCity:'')+'" /></label>';
				HTML+='		<label class="taR w20p fL wsnw">State:<input class="w40p fR" name=shipToState  maxlength=2 value="'+(xml.MatReq?xml.MatReq[0].shipToState:'')+'" /></label>';
				HTML+='		<label class="taR w30p fL wsnw">Zip:<input class="w70p fR" name=shipToZip maxlength=10 value="'+(xml.MatReq?xml.MatReq[0].shipToZip:'')+'" /></label><br>';
				HTML+='		<h5 style="margin-bottom:0;"> Details </h5>';
				HTML+='		<label class="taR w100p fL wsnw">Requested By:<select name=empID id=empID class="w70p fR" value="'+(xml.MatReq?xml.MatReq[0].byEmpId:'')+'">'+Gebi('EmpOptionList').innerHTML+'</select></label><big><big><br></big></big>';
				HTML+='		<label class="taR w90p fL wsnw">';
				HTML+='			<span>Need it delivered by:</span>';
				var newMRDue=((xml.MatReq&&(xml.MatReq[0].dueBy!='1/1/1900'))?xml.MatReq[0].dueBy:later);
				var showCalJS="displayCalendar(\'Due\',\'mm/dd/yyyy\',Gebi(\'cal\'));";
				HTML+='			<input class="w50p fR" id=Due name=Due maxlength=50 value="'+newMRDue+'" onclick="'+showCalJS+'" />';
				HTML+='		</label>';
				HTML+='		<div id=cal onclick="'+showCalJS+' posCal();" onmouseover="calPosUpdate(event,this);" src="../images/cal.gif" width="16" height="16">&nbsp;</div>';
				HTML+='		<h5 style="margin-bottom:0;">Notes:</h5>';
				HTML+='		<textarea id=notes class="w100p h64" style="font-family:Consolas,\'Courier New\', Courier, monospace">'+(xml.MatReq?xml.MatReq[0].notes:'')+'</textarea>';
				HTML+='		<center>';
				HTML+='			<button class="w40p" type="submit" >Save<b><big><i>!</i></big></b></button>';
				if (!(done)) HTML+='			<button class="w40p" onclick="toggleDetails();" >Cancel</button>';
				HTML+='		</center>';
				HTML+='	</form>';
				
				/*
				if (done) {
					Gebi('right').innerHTML=HTML;
					Gebi('Modal').style.display='none';
					return true;
				}*/
				
				if(!done) {
					if (xml.MatReq[0].totalItemCount==0) HTML+='<span id="noParts" style="display:none"><br/>There aren\'t any parts in this Material Request yet.</span>';
					
					HTML+='<div class="row" style="background:none; border:none; text-align:right; height:24px;" >';
					HTML+=	'<div class="taL fL" >'+SelI('Projects').innerHTML+'</div>';
					HTML+=	'<button onclick=submitMR('+xml.MatReq[0].id+')>&nbsp;Submit Request&nbsp;</button>';
					HTML+=	'<span> M.R.# '+xml.MatReq[0].id+' &nbsp; &nbsp; </span>';
					HTML+='</div>';
					
					HTML+='<div id="mrItemsHead" class="ItemsHead" >';
					HTML+='	<div style="width:5%;"><div class="tButton24 rowButton h24" title="Delete the active M.R." style="margin-top:2px;" onclick="deleteMR('+mrId+');" ><div class=delete>&nbsp;</div></div></div>';
					HTML+='	<div style="width:5%;"><div class="tButton24 rowButton h24" title="Edit details for the active M.R." style="margin-top:2px;" onclick="toggleDetails();" >&hellip;</div></div>';
					HTML+='	<div style="width:14%;"><small>Quantity</small></div>';
					HTML+='	<div style="width:14%;">Manufacturer</div>';
					HTML+='	<div style="width:14%;">Part Number</div>';
					HTML+='	<div style="width:23%;">Cost</div>';
					HTML+='	<div style="width:24%;">Total</div>';
					HTML+='</div>';
					
					HTML+='<div id="newRow" style="display:none;">';
					HTML+='	<div id="rowINDEX" >';
					HTML+='		<div></div>';
					HTML+='	</div>';
					HTML+='</div>';
					
					if(!xml.MatReq[0].empty) {
						for(var r=0; r<xml.MatReq[0].itemCount; r++) {
							var mrItem=xml.MatReq[0].mrItems[r]
	
							R=xml.MatReq[0].id+'-'+r;
							HTML+='	<div id="mrRow'+R+'" class="row" value="'+mrItem.partsID+'" style=" <%=opacity%> " >';
							HTML+='		<div class="w5p taC" ><div class="tButton24 rowButton" onclick="mrDelete(\''+R+'\','+mrItem.partsID+');" ><div class=delete>&nbsp;</div></div></div>';
							HTML+='		<div class="w5p taC" ><div class="tButton24 rowButton" onclick="mrEditSave(\''+R+'\');"><div id=mrEditSaveImg'+R+' class=pencil width=100% height=100%>&nbsp;</div></div></div>';
							HTML+='		<input class="w14p mrQty" readOnly=true id=mrQty'+R+' oValue="'+(mrItem.qty*mrItem.unitSize)+'" unitSize="'+mrItem.unitSize+'" value="'+(mrItem.qty*mrItem.unitSize)+'">';
							HTML+='		<div class="w14p" id=mrMfr'+R+'>'+mrItem.mfr+'</div>';
							HTML+='		<div class="w14p" id=mrPN'+R+' >'+mrItem.pn+'</div>';
							HTML+='		<div class="w23p" id=mrCost'+R+' >'+formatCurrency(mrItem.cost)+'</div>';
							HTML+='		<div class="w24p" id=mrTotal'+R+' >'+formatCurrency((mrItem.qty*mrItem.unitSize)*mrItem.cost)+'</div>';
							HTML+='		<div class="rowBottom" id=mrDesc'+R+' >'+mrItem.desc+'</div>';
							//HTML+='		<div class="rowBottom" id=mrDesc'+R+' >'+mrItem.idList+'</div>';
							/**/
							HTML+='		<input id=idList'+R+' type=hidden value="'+mrItem.idList+'" />';
							HTML+='		<input id=mrUnitSize'+R+' type=hidden value="'+mrItem.unitSize+'" />';
							HTML+='		<input id=mrPartsID'+R+' type=hidden value="'+mrItem.partsID+'" />';
							HTML+='	</div>';
						}
					}
					HTML+='<div class="w100p taC"><button onclick=submitMR('+xml.MatReq[0].id+')>&nbsp;Submit Request&nbsp;</button></div>';
				}
					
				Gebi('right').innerHTML=HTML;
			
				var R='';
				
				if(xml.mrCount>mrStartIndex) {
					
					HTML+='<div id=PreviousRequests style="opacity:.5;" >';
					HTML+=	'<h3>Previous Requests</h3>';
					
					
					for (var mr=mrStartIndex; mr<xml.mrCount; mr++) {   										//-██████ Begin Looping through the remaining MR's ██████-\\
						var mrData=xml.MatReq[mr];
						
						HTML+='<div class="row" style="background:none; border:none; text-align:right; height:24px;" >';
						HTML+=	'<div class="taL fL" >'+SelI('Projects').innerHTML+'</div>';
						//HTML+=	'<span> debugMRI:'+mr+' &nbsp; &nbsp; </span>';
						HTML+=	'<span> M.R.# '+mrData.id+' &nbsp; &nbsp; </span>';
						HTML+='</div>';
		
						HTML+='<div class="row" style="background:none; border:none; text-align:right; height:24px;" >';
						HTML+=	'<div class="taL fL" >Requested on'+mrData.d8+'</div>';
						HTML+=	'<span> Requested By '+mrData.empName+' &nbsp; &nbsp; </span>';
						HTML+='</div>';
		
						HTML+='<div class="w100p taC"><button id=delMR'+xml.MatReq[mr].id+' onclick="deleteMR('+xml.MatReq[mr].id+');" ><span style="color:red;"><b><big>x</big></b></span> Delete</button></div>';
						HTML+='<div id="mrItemsHead" class="ItemsHead" style="height:16px !important; overflow:hidden; max-height:16px; " >';
						//HTML+='	<div style="width:5%;"></div>'//<div class="tButton24 rowButton h24" title="Edit details for the active M.R." style="margin-top:8px;" onclick="toggleDetails();" >&hellip;</div></div>';
						HTML+='	<div class="w15p h100p"><small>Quantity</small></div>';
						HTML+='	<div style="width:16%;">Manufacturer</div>';
						HTML+='	<div style="width:16%;">Part Number</div>';
						HTML+='	<div style="width:25%;">Cost</div>';
						HTML+='	<div style="width:28%;">Total</div>';
						HTML+='</div>';
						
						for(var r=0; r<xml.MatReq[mr].itemCount; r++) {
							var mrItem= xml.MatReq[mr].mrItems[r]
	
							R=xml.MatReq[mr].id+'-'+r;
							HTML+='	<div id="mrRow'+R+'" class="row" value="'+mrItem.partsID+'" >';
							//HTML+='		<div class="w5p taC" ><div class="tButton24 rowButton" onclick="mrDelete(\''+R+'\','+mrItem.partsID+');" ><div class=delete>&nbsp;</div></div></div>';
							//HTML+='		<div class="w5p taC" ><div class="tButton24 rowButton" onclick="mrEditSave(\''+R+'\');"><div id=mrEditSaveImg'+R+' class=pencil width=100% height=100%>&nbsp;</div></div></div>';
							HTML+='		<input class="w15p mrQty" readOnly=true id=mrQty'+R+' oValue="'+(mrItem.qty*mrItem.unitSize)+'" unitSize="'+mrItem.unitSize+'" value="'+(mrItem.qty*mrItem.unitSize)+'">';
							HTML+='		<div class="w16p" id=mrMfr'+R+'>'+mrItem.mfr+'</div>';
							HTML+='		<div class="w16p" id=mrPN'+R+' >'+mrItem.pn+'</div>';
							HTML+='		<div class="w24p" id=mrCost'+R+' >'+formatCurrency(mrItem.cost)+'</div>';
							HTML+='		<div class="w27p" id=mrTotal'+R+' >'+formatCurrency((mrItem.qty*mrItem.unitSize)*mrItem.cost)+'</div>';
							HTML+='		<div class="rowBottom" id=mrDesc'+R+' >'+mrItem.desc+'</div>';
							/**/
							HTML+='		<input id=idList'+R+' type=hidden value="'+mrItem.idList+'" />';
							HTML+='		<input id=mrUnitSize'+R+' type=hidden value="'+mrItem.unitSize+'" />';
							HTML+='		<input id=mrPartsID'+R+' type=hidden value="'+mrItem.partsID+'" />';
							HTML+='	</div>';
						}
					}
					HTML+='</div>';
				}
				
				
				Gebi('right').innerHTML=HTML;

				if(!!Gebi('empID')) { 
					Gebi('empID').innerHTML=Gebi('EmpOptionList').innerHTML; 
					var opts=Gebi('empID').childNodes;
					if(!!xml.MatReq) {
						for(var o=0; o<opts.length; o++) { 
							if (opts[o].value*1==(xml.MatReq[0].byEmpId*1)) opts[o].selected='true'; break; 
						} 	
					}
				}
				
				Gebi('Modal').style.display='none';
				Gebi('modalStatus').innerHTML='';
			}
			else {
				AjaxErr('There was a problem with the loadMR request.',HttpText);
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}

function deleteMR(id) {
	if(!confirm('Do you really want to delete this Material Request ?')) return false;
	
	Gebi('Modal').style.display='block';
	Gebi('modalStatus').innerHTML='Deleting Material Request Contents<br/><span id=statusDots></span>';
	HttpText='MaterialsASP.asp?action=deletemr&id='+id;
	xhr = getXHR();
	xhr.onreadystatechange = function() {
		Gebi('statusDots').innerHTML+='&hellip;';
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				try { var xmlDoc=xhr.responseXML.documentElement;	}
				catch(e) { AjaxErr('There was a problem with the BidPartToMR response document.',HttpText);	return false;}
					
				noCacheReload();
			}
		}
	}
	xhr.open('Get',HttpText, true);
	xhr.send(null);
}




function AddPart(partsID) { //This ain't really AJAX, its more like Asynchronous Javascript And Javascript, but it accomplishes the same thing.  Kinda interesting.
	var wURL='addPartWorker.asp?partsID='+partsID+'&sysID='+addToSysId+'&dontCache='+uid();
	//alert(wURL);
	var addPart=new Worker(wURL);

	addPart.onError=function(e) {
		console.log("Error at "+e.filename+":"+e.lineno+": "+e.message);
	}
	//addPart.postMessage();
	addPart.onmessage=function(e) {
		var part=e.data;
		if(!part) return false;
		
		//alert(part.biId+':'+part.mfr+':'+part.pn+':'+part.cost+':'+part.desc+':'+part);
		
		biRows+=10000;
		Gebi('left').innerHTML+=Gebi('EmptyRow').innerHTML.replace(/_INDEX_/g,biRows).replace(/_BIID_/g,part.biId).replace(/_PID_/g,part.partsId);
		Gebi('biQty'+biRows).innerHTML=0;
		Gebi('biMfr'+biRows).innerHTML=part.mfr;
		Gebi('biPN'+biRows).innerHTML=part.pn;
		Gebi('biCost'+biRows).innerHTML=formatCurrency(part.cost);
		Gebi('biTotal'+biRows).innerHTML=0;
		Gebi('biDesc'+biRows).innerHTML=part.desc;
	}
}