var xmlHttp
var HttpText ='';
//Creates the main XMLHttpRequest object////////////////////////////////////////////////////////

//window.top.accessUser='n8';

function GetXmlHttpObject()	{
	var xmlHttp=null;
	try	{
		xmlHttp=new XMLHttpRequest(); // Firefox, Opera 8.0+, Safari
	}
	catch (e)  {
		// Internet Explorer
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e)	{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	if (xmlHttp==null)	{
		alert ("Your browser does not support AJAX!");
		return;
	}
	return xmlHttp;
}

//------------------------------------------------------------------------------------------------

var evLeftPos = new Array();
var evTopPos = new Array();
var evWidth = new Array();
var evTitle = new Array();
var evCalID = new Array();
var dayEvNum=new Array();
var attnByCalID= new Array();
var RowAttn=new Array();
var RowI;
function LoadEvents(week)	{	
	HttpText=encodeURI('GantChartMainASP.asp?action=LoadEvents&week='+week);
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=returnLoadEvents;
	xmlHttp.open('Get',HttpText,false);
	xmlHttp.send(null);
	
	function returnLoadEvents()	{
		if(xmlHttp.readyState==4)	{
			if(xmlHttp.status==200)	{
				
				try	{	var xmlDoc=xmlHttp.responseXML.documentElement;	}
				catch(e)	{	AjaxErr('There was a problem with the LoadEvents Response.',HttpText)	}
				
				var today = new Date()
				
				var Sunday= new Date(xmlTag('Sunday'));
				var Sunday2=new Date(xmlTag('Sunday2'));
				
				var WDStyle=new Array();
								
				var RB='None';
				RowI=0;
				var evCount=xmlTag('evCount');
				for(e=1;e<=evCount;e++)	{
					var attn= xmlTag('AttnID'+e);
					var empName= xmlTag('empName'+e);
					var from= xmlTag('From'+e);
					var vehicle= xmlTag('Vehicle'+e);
					var GantRowID=xmlTag('GantRowID'+e);
					
					if(!Gebi('Row'+attn))	{
						
						RowI++
						
						RowAttn[RowI]=attn;
						
						//if (xmlTag('userEmpID')==attn)	{	//if The new Row is for the logged in user, put it at the top.
						//	Gebi('Rows').innerHTML='<div id="Row'+attn+'" class=Row style="background:none;"></div>'+Gebi('Rows').innerHTML;
						//}
						//else	{
							if (RB=="None")	{ RB="rgba(0,0,0,.0625)";	} else	{	RB="None";	}
							Gebi('Rows').innerHTML+='<div id="Row'+attn+'" class=Row style="background:'+RB+';"></div>';
						//}
						
						var RowHtml='';
						RowHtml+='<div id=Vehicle'+attn+'Div class="RowDiv">';
						RowHtml+='	<input id=Vehicle'+attn+' value="'+vehicle+'" style="border:none; float:left; height:99%; margin:0 auto; text-align:center; width:99%;"';
						RowHtml+='	 onchange="SendSQL(\'Write\',\'UPDATE GantRows SET Vehicle=\\\'\'+this.value+\'\\\' WHERE GantRowID='+GantRowID+'\');"';
						RowHtml+='	/>';
						RowHtml+='	<span class="BorderR"></span>';
						RowHtml+='</div>';
						RowHtml+='<div id=AttnCrew'+attn+' class="RowDiv">';
						RowHtml+='	<span class="BorderR"></span>';
						RowHtml+='	<span class="BorderR"></span>';
						RowHtml+='	<select id="Attn'+attn+'" class="AttnSelect" >';
						RowHtml+='		<option id=Emp0 value="'+attn+'">'+empName+'</option>';
						
						for(emp=1; emp<AllEmps.length;emp++)	{
							if(AllEmps[emp].active)	{
								RowHtml+='	<option id="Emp'+AllEmps[emp].ID+'" value="'+AllEmps[emp].ID+'">'+AllEmps[emp].name+'</option>';
							}
						}
						
						RowHtml+='	</select>';
						RowHtml+='	<textarea id=Crew'+attn+' style="width:99%; height:28px; margin:0 auto; padding:0;" ';
						RowHtml+='	 onChange="SendSQL(\'Write\',\'UPDATE GantRows SET Crew=\\\'\'+this.value+\'\\\' WHERE GantRowID='+GantRowID+'\');">';
						RowHtml+=			xmlTag('weekCrew'+e);
						RowHtml+='	</textarea>';
						RowHtml+='</div>';
						
						for(d=0;d<=8;d++)	{
							WDStyle[d]='';
							if(today==(Sunday+daysToMs(d)))	{
								WDStyle[d]='style="background:rgba(255,255,0,.5);"';
							}
						}
						
						//Gebi('monDate').innerHTML='';
						
						RowHtml+='<div id="Week'+attn+'" class=RowWeek onMouseMove="EventExtend(event,this);">'; 
						RowHtml+='	<div id="Sun'+attn+'" class=wkDay '+WDStyle[0]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='	<div id="Mon'+attn+'" class=wkDay '+WDStyle[1]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='	<div id="Tue'+attn+'" class=wkDay '+WDStyle[2]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='	<div id="Wed'+attn+'" class=wkDay '+WDStyle[3]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='	<div id="Thur'+attn+'"class=wkDay '+WDStyle[4]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='	<div id="Fri'+attn+'" class=wkDay '+WDStyle[5]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='	<div id="Sat'+attn+'" class=wkDay '+WDStyle[6]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='	<div id="Sun2'+attn+'"class=wkDay '+WDStyle[7]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
						RowHtml+='</div>';
						
						Gebi('Row'+attn).innerHTML=RowHtml;
					}
				}
				Gebi('Rows').innerHTML+='<button id=addRowBtn onclick="newRow();"></button>';
				
				//   Breaking the for loop into two steps, the first (above) is for generating rows
				// The second (below) for generating the events.
				
				for(e=1;e<=evCount;e++)	{
					var attn= xmlTag('AttnID'+e);
					var empName= xmlTag('empName'+e);
					var from= xmlTag('From'+e);
					var vehicle= xmlTag('Vehicle'+e);
					var GantRowID=xmlTag('GantRowID'+e);
					
					var to=xmlTag('To'+e);
					var ID=xmlTag('ID'+e);
					var taskID=xmlTag('TaskID'+e);
					var title=xmlTag('Event'+e);
					var note=xmlTag('Note'+e);
					var jobID=xmlTag('JobID'+e);
					var evCrew=xmlTag('Crew'+e);
					var done=strToBool(xmlTag('Done'+e));
					
					var d8From=new Date(from);
					var d8To=new Date(to);
					
					var EvClass='class="Event';
					if(d8From>=Sunday) EvClass+=' EvStart';
					if(d8To<=Sunday2) EvClass+=' EvEnd';
					EvClass+='"'
					
					var BgColor=xmlTag('BgColor'+e);
					var BorderStyle='outset';	
					var Color='000';//xmlTag('TextColor'+e);
					var lineThru='';
					var checkboxchecked='';
					if(done)	{	
						BgColor=xmlTag('AltBgColor'+e);
						BorderStyle='inset';
						Color='555';
						lineThru='style="text-decoration:line-through;"';
						var checkboxchecked=' checked';
					}
					
					var DragLeft='';
					var DragRight='';
					
					var evStart=d8From;
					if (evStart<Sunday)	{	evStart=Sunday;	}
					else	{	DragLeft='<span id=DragLeft'+ID+' class=DragLeft onselectstart="return false" onMouseDown="EvExID='+ID+'; EvExDir=-1; ">◄</span>';	}
					
					var evStop=d8To;
					if (evStop>Sunday2)	{	evStop=Sunday2;	}
					else	{	DragRight='<span id=DragRight'+ID+' class=DragRight onselectstart="return false" onMouseDown="EvExID='+ID+'; EvExDir=1; ">►</span>';	}
					
					var DayWidth=10;
					
					var leftPos=DayWidth*2;
					leftPos+=Math.round((msToDays(evStart-Sunday)*DayWidth)/10)*10;
					var topPos=Gebi('Row'+attn).offsetTop;
					
					var numDays=msToDays(evStop)-msToDays(evStart)+1;
					var width=(numDays)*DayWidth;
					
					dayEvCount=2;
					checkAgain=true;
					while(checkAgain)	{	//Make sure the new event won't cover up already generated events
						checkAgain=false;
						for(eI=1;eI<e;eI++)	{
							if(evTopPos[eI]==topPos && leftPos>=evLeftPos[eI] && leftPos<=evLeftPos[eI]+evWidth[eI]-1 )	{
								//alert(title+' overlaps '+evTitle[eI]);
								topPos+=16;
								dayEvCount++;
								if(dayEvCount>3)	{	
									var newH=dayEvCount*16
									
									if (newH>Gebi('Row'+attn).offsetHeight)	{	
										Gebi('Row'+attn).style.height=newH+'px';		
									}
								}
								checkAgain=true; 
					}	} }
					evLeftPos[e]=leftPos;
					evTopPos[e]=topPos;
					evWidth[e]=width;
					evTitle[e]=title;
					evCalID[e]=ID;
					dayEvNum[e]=dayEvCount;
					attnByCalID[ID]=attn;
					
					var	Style=' style="Background:#'+BgColor+'; border:1px '+BorderStyle+'; color:#'+Color+'; left:'+leftPos+'%; top:'+topPos+'px; width:'+width+'%; " ';
					var evEvents='onMouseMove="evMPos(event,this); EventExtend(event,Gebi(\'Week'+attn+'\'));" onMouseDown="evMDown();" ';
					
					var eHTML='';
					eHTML+='<div id=Event'+ID+' '+EvClass+' '+Style+' '+evEvents+' d8From="'+from+'" d8To="'+to+'" title="'+title+'">';
					eHTML+= 	DragLeft;
					eHTML+='	<div id=EventName'+ID+' class=EventName '+lineThru+' onselectstart="return false" onMouseDown="EvExID='+ID+'; EvExDir=2">&nbsp;'+title+'&nbsp;</div>';
					eHTML+= 	DragRight;
					eHTML+='</div>';
					
					Gebi('Rows').innerHTML+=eHTML
				}
			}
				
			else	{
				AjaxErr('There was a problem with the LoadEvents Request',HttpText);
			}
		}
	}
}


//////////////////////////////////////////////////////////////////////
function newRow()	{
	HttpText=encodeURI('GantChartMainASP.asp?action=NewRow&week='+week);
	xmlHttp=GetXmlHttpObject();
	xmlHttp.onreadystatechange=returnLoadEvents;
	xmlHttp.open('Get',HttpText,false);
	xmlHttp.send(null);

	function returnNewRow()	{
		if(xmlHttp.readyState==4)	{
			if(xmlHttp.status==200)	{
			
				var attn= xmlTag('AttnID');
				var empName= xmlTag('empName');
				var from= xmlTag('From');
				var vehicle= xmlTag('Vehicle');
				var GantRowID=xmlTag('GantRowID');
				
				if(!Gebi('Row'+attn))	{
					
					RowI++
					
					RowAttn[RowI]=attn;
					
					//if (xmlTag('userEmpID')==attn)	{	//if The new Row is for the logged in user, put it at the top.
					//	Gebi('Rows').innerHTML='<div id="Row'+attn+'" class=Row style="background:none;"></div>'+Gebi('Rows').innerHTML;
					//}
					//else	{
						if (RB=="None")	{ RB="rgba(0,0,0,.0625)";	} else	{	RB="None";	}
						Gebi('Rows').innerHTML+='<div id="Row'+attn+'" class=Row style="background:'+RB+';"></div>';
					//}
					
					var RowHtml='';
					RowHtml+='<div id=Vehicle'+attn+'Div class="RowDiv">';
					RowHtml+='	<input id=Vehicle'+attn+' value="'+vehicle+'" style="border:none; float:left; height:99%; margin:0 auto; text-align:center; width:99%;"';
					RowHtml+='	 onchange="SendSQL(\'Write\',\'UPDATE GantRows SET Vehicle=\\\'\'+this.value+\'\\\' WHERE GantRowID='+GantRowID+'\');"';
					RowHtml+='	/>';
					RowHtml+='	<span class="BorderR"></span>';
					RowHtml+='</div>';
					RowHtml+='<div id=AttnCrew'+attn+' class="RowDiv">';
					RowHtml+='	<span class="BorderR"></span>';
					RowHtml+='	<select id=Attn'+attn+' style=" cursor:pointer; height:20px; margin:0 auto; padding:0; width:99%;" >';
					RowHtml+='		<option id=Emp0 value="'+attn+'">'+empName+'</option>';
					
					for(emp=1; emp<AllEmps.length;emp++)	{
						if(AllEmps[emp].active)	{
							RowHtml+='	<option id="Emp'+AllEmps[emp].ID+'" value="'+AllEmps[emp].ID+'">'+AllEmps[emp].name+'</option>';
						}
					}
					
					RowHtml+='	</select>';
					RowHtml+='	<textarea id=Crew'+attn+' style="width:99%; height:28px; margin:0 auto; padding:0;" ';
					RowHtml+='	 onChange="SendSQL(\'Write\',\'UPDATE GantRows SET Crew=\\\'\'+this.value+\'\\\' WHERE GantRowID='+GantRowID+'\');">';
					RowHtml+=			xmlTag('weekCrew'+e);
					RowHtml+='	</textarea>';
					RowHtml+='</div>';
					
					for(d=0;d<=8;d++)	{
						WDStyle[d]='';
						if(today==(Sunday+daysToMs(d)))	{
							WDStyle[d]='style="background:rgba(255,255,0,.5);"';
						}
					}
					
					RowHtml+='<div id="Week'+attn+'" class=RowWeek onMouseMove="EventExtend(event,this);">';
					RowHtml+='	<span class="BorderL"></span>';
					RowHtml+='	<div id="Sun'+attn+'" class=wkDay '+WDStyle[0]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='	<div id="Mon'+attn+'" class=wkDay '+WDStyle[1]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='	<div id="Tue'+attn+'" class=wkDay '+WDStyle[2]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='	<div id="Wed'+attn+'" class=wkDay '+WDStyle[3]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='	<div id="Thur'+attn+'"class=wkDay '+WDStyle[4]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='	<div id="Fri'+attn+'" class=wkDay '+WDStyle[5]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='	<div id="Sat'+attn+'" class=wkDay '+WDStyle[6]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='	<div id="Sun2'+attn+'"class=wkDay '+WDStyle[7]+'>+<img style="border:none; height:100%; width:1px;"/></div>';
					RowHtml+='</div>';
					
					Gebi('Row'+attn).innerHTML=RowHtml;
				}
			}
			else	{
				AjaxErr('There was a problem with the LoadEvents Request',HttpText);
			}
		}
	}
}
/**********************************************************************/

