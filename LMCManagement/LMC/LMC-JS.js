// JavaScript Document


var TabWidth;
//var TabWidth = 125;


function CreateCalendarTabs()
{
	var TAO=TaskArrayOrdered;
	var HTML = '';

	
	var NextColor ='FF99CC';
	
	var NumTasks=(TaskArrayOrdered.length-1);

	var TabColor = new Array;
	for (i = NumTasks; i >=1 ; i--)	{	TabColor[i]=TaskArrayOrdered[i][3];	}
	TabColor[0]='FF99CC';

	
	var Hilite='-webkit-gradient(linear,0 0,0 100%, from(rgba(0,0,0,0)), color-stop(.25, rgba(0,0,0,0)), color-stop(.85, #ColorGoesHere))';
	//var Hilite=Hilite+',-moz-linear-gradient(center top, rgba(0,0,0,0) 0%, rgba(0,0,0,0) 25%, #ColorGoesHere 85%)';
	var tabHilite;
	
	
	for (i = NumTasks; i >=1 ; i--)
	{
		tabHilite=Hilite.replace('ColorGoesHere',TAO[i][3])
		
		HTML+='<div id="TaskTabs'+i+'" class="SlideTab"';
		HTML+=' onMouseOver="this.style.color=\'#'+TAO[i][3]+'\';"';
		HTML+=' onMouseOut="this.style.color=\'#DDD\'"';
		HTML+=' onclick="';
		HTML+='					var AllDivs=document.getElementsByTagName(\'div\');';
		HTML+='					for(d=0;d<AllDivs.length;d++){';
		HTML+='						if(AllDivs[d].id.replace(\'SlideTabText\',\'\')!=AllDivs[d].id){';
		HTML+='							AllDivs[d].style.background=\'none\';';
		HTML+='					}	}';
		//HTML+='					';
		HTML+='					Gebi(\'SlideTabText'+i+'\').style.background=\''+tabHilite+'\';';
		HTML+='					Gebi(\'UnderTabs\').style.background=\'#'+TAO[i][3]+'\';';
		HTML+='					Gebi(\'UnderTabs\').innerHTML=\''+TAO[i][2]+'\';';
		HTML+='					'+TAO[i][5]+'();"';
		HTML+='					alert(LMC-JS.js:47);';
		HTML+='>';
		HTML+=	'<div style="background:url(images/BlackGradient2TLCorner24x24.gif); width:24px; height:24px; z-index:0; overflow:visible; float:left;"></div>';
		HTML+=	'<div id="SlideTabText'+i+'" class="SlideTabText" onclick="this.parentNode.onclick();">';
		HTML+= 	 	TAO[i][2]+'<br /><br />&nbsp;';
		HTML+=' </div> </div> '//</div>';
	}
	
	
	tabHilite=Hilite.replace('ColorGoesHere','cbf');

	HTML+='<div id="TaskTabs1002" class="SlideTab"';
	HTML+=' onMouseOver="this.style.color=\'#cbf\'"';
	HTML+=' onMouseOut="this.style.color=\'#DDD\'"';
	HTML+=' onclick="'; 
		HTML+='					var AllDivs=document.getElementsByTagName(\'div\');';
		HTML+='					for(d=0;d<AllDivs.length;d++){';
		HTML+='						if(AllDivs[d].id.replace(\'SlideTabText\',\'\')!=AllDivs[d].id){';
		HTML+='							AllDivs[d].style.background=\'none\';';
		HTML+='					}	}';
		HTML+='					Gebi(\'SlideTabText1002\').style.background=\''+tabHilite+'\';';
		HTML+='					Gebi(\'UnderTabs\').style.background=\'#cbf\'; Gebi(\'UnderTabs\').innerHTML=\'Email\'; ShowMail();"';
		HTML+='					';
	HTML+='>';
	HTML+=	'<div style="background:url(images/BlackGradient2TLCorner24x24.gif); width:24px; height:24px; z-index:0; overflow:visible; float:left;"></div>';
	HTML+=	'<div id="SlideTabText1002" class="SlideTabText" >Email<br /><br />&nbsp;';
	HTML+=' </div> </div>';
/**/
	
	tabHilite=Hilite.replace('ColorGoesHere','FF99CC');
	
	HTML+='<div id="TaskTabs1001" class="SlideTab" ';
	HTML+=' onMouseOver="this.style.color=\'#FF99CC\'"';
	HTML+=' onMouseOut="this.style.color=\'#DDD\'"';
	//HTML+=' onclick="Gebi(\'UnderTabs\').style.background=\'#FF99CC;\'; Gebi(\'UnderTabs\').innerHTML=\'Gant Chart\'; ShowGant();"';
	HTML+=' onclick="'; 
		HTML+='					var AllDivs=document.getElementsByTagName(\'div\');';
		HTML+='					for(d=0;d<AllDivs.length;d++){';
		HTML+='						if(AllDivs[d].id.replace(\'SlideTabText\',\'\')!=AllDivs[d].id){';
		HTML+='							AllDivs[d].style.background=\'none\';';
		HTML+='					}	}';
		HTML+='					Gebi(\'SlideTabText1001\').style.background=\''+tabHilite+'\';';
		HTML+='					Gebi(\'UnderTabs\').style.background=\'#FF99CC\'; Gebi(\'UnderTabs\').innerHTML=\'Gant Chart\'; ShowGant();';
	HTML+='					"';
	HTML+='>';
	HTML+=	'<div style="background:url(images/BlackGradient2TLCorner24x24.gif); width:24px; height:24px; z-index:0; overflow:visible; float:left;"></div>';
	HTML+=	'<div id="SlideTabText1001" class="SlideTabText" style="background:'+tabHilite+'">Gant Chart<br /><br />&nbsp;';
	HTML+=' </div> </div>';//</div>';
	
	/*
	HTML +='<div id="MainTabCalendar" style=""';
	HTML +=		' onmouseover="document.getElementById(&#39;TaskTabs1000&#39;).style.color=&#39;#55A9E8&#39;;"';
	HTML +=		' onclick=" ShowCalendar(); document.getElementById(&#39;UnderTabs&#39;).style.background=&#39;#1C80CA&#39; ;';
	HTML +=		' document.getElementById(&#39;UnderTabs&#39;).innerHTML=\'&nbsp;Calendar \';  "';
	HTML +=		' onmouseout="document.getElementById(&#39;TaskTabs1000&#39;).style.color=&#39;#CCC&#39;;">';
	HTML +=	'<li id="TaskTabs1000" class="SlideTab"  style="border-top-left-radius:13px; background:url(images/BlackGradient2-24x24.gif);color:#CCC; height:64px;">';
	HTML +='		<div style="background:url(images/BlackGradient2TLCorner24x24.gif); width:24px; height:24px; z-index:0; overflow:visible; float:left;">';
	HTML +=		'<div id="SlideTabText1" class="SlideTabText"> ';
	HTML +=		'Calendar ';//<button id="Cal2Btn" class="Cal2Btn" onclick="Cal2();" Title="Switch to Calendar 2.0 Beta!">2.0!</button>';
	HTML +=		'<br /><br />&nbsp;';
	HTML	+='</div></li></div></div>';
	/**/
	
	tabHilite=Hilite.replace('ColorGoesHere','1C80CA');
	
	HTML+='<div id="TaskTabs1000" class="SlideTab" style="-moz-border-radius-topleft:16px; border-top-left-radius:16px;"';
	HTML+=' onMouseOver="this.style.color=\'#55A9E8\'"';
	HTML+=' onMouseOut="this.style.color=\'#DDD\'"';
	HTML+=' onclick="'; 
		HTML+='					var AllDivs=document.getElementsByTagName(\'div\');';
		HTML+='					for(d=0;d<AllDivs.length;d++){';
		HTML+='						if(AllDivs[d].id.replace(\'SlideTabText\',\'\')!=AllDivs[d].id){';
		HTML+='							AllDivs[d].style.background=\'none\';';
		HTML+='					}	}';
		HTML+='					Gebi(\'SlideTabText1000\').style.background=\''+tabHilite+'\';';
		HTML+='					Gebi(\'UnderTabs\').style.background=\'#1C80CA\'; Gebi(\'UnderTabs\').innerHTML=\'Calendar\'; ShowCalendar();"';
	HTML+='					';
	HTML+='>';
	HTML+=	'<div style="background:url(images/BlackGradient2TLCorner24x24.gif); width:24px; height:24px; z-index:0; overflow:visible; float:left;"></div>';
	HTML+=	'<div id="SlideTabText1000" class="SlideTabText" >Calendar<br /><br />&nbsp;';
	HTML+=' </div> </div>';


	Gebi('SlideTabs').innerHTML = HTML;
	//slideMenu.build('SlideTabs',TabWidth,2,2,1);
 	ShowCalendar(); Gebi('UnderTabs').style.background='#1C80CA';
  
	if(accessDataEntry!='True'){document.getElementById('TaskTabs3').style.display='none';}
	if(accessEstimates!='True'){document.getElementById('TaskTabs4').style.display='none';}
	if(accessProjects!='True'){document.getElementById('TaskTabs5').style.display='none';}
	if(accessService!='True'){document.getElementById('TaskTabs6').style.display='none';}
	if(accessTest!='True'){document.getElementById('TaskTabs7').style.display='none';}
	if(accessEngineering!='True'){document.getElementById('TaskTabs8').style.display='none';}
	if(accessPurchasing!='True'){document.getElementById('TaskTabs9').style.display='none';}
	if(accessOffice!='True'){document.getElementById('TaskTabs11').style.display='none';}
	if(accessInventory!='True'){document.getElementById('TaskTabs12').style.display='none';}
	if(accessTraining!='True'){document.getElementById('TaskTabs13').style.display='none';}
	if(accessWebsite!='True'){document.getElementById('TaskTabs15').style.display='none';}
	if(accessAdmin!='True'){document.getElementById('TaskTabs16').style.display='none';}
	//if(accessTime!='True'){document.getElementById('TaskTabs16').style.display='none';}
}


function ChangeTab(Container)
{
	try	{
		Gebi('CalendarContainer').style.display = 'none';
		Gebi('GantContainer').style.display = 'none';
		Gebi('MailContainer').style.display = 'none';
		Gebi('DataEntryContainer').style.display = 'none';
		Gebi('ContactsContainer').style.display = 'none';
		Gebi('GeneralContainer').style.display = 'none';
		Gebi('EstimatesContainer').style.display = 'none';
		try	{	Gebi('oldBidderFrame').style.visibility = 'hidden';	}	 catch(e)	{	}	
		Gebi('ProjectsContainer').style.display = 'none';
		Gebi('ServiceContainer').style.display = 'none';
		Gebi('TestMaintContainer').style.display = 'none';
		Gebi('EngineeringPlansContainer').style.display = 'none';
		Gebi('PurchasingContainer').style.display = 'none';
		Gebi('TimeEntryContainer').style.display = 'none';
		Gebi('WebsiteContainer').style.display = 'none';
		Gebi('AdminContainer').style.display = 'none';
		Gebi('EnvironContainer').style.display = 'none';
		Gebi('OfficeContainer').style.display = 'none';
		Gebi('TrainingContainer').style.display = 'none';
		Gebi('PersonalContainer').style.display = 'none';
		Gebi('WebsiteContainer').style.display = 'none';
		Gebi('InventoryContainer').style.display = 'none';
	}
	catch(e)	{
		parent.document.getElementById('CalendarContainer').style.display = 'none';
		parent.document.getElementById('GantContainer').style.display = 'none';
		parent.document.getElementById('MailContainer').style.display = 'none';
		parent.document.getElementById('DataEntryContainer').style.display = 'none';
		parent.document.getElementById('ContactsContainer').style.display = 'none';
		parent.document.getElementById('GeneralContainer').style.display = 'none';
		parent.document.getElementById('EstimatesContainer').style.display = 'none';
		try {parent.document.getElementById('oldBidderFrame').style.visibility = 'hidden';} catch(e){}
		parent.document.getElementById('ProjectsContainer').style.display = 'none';
		parent.document.getElementById('ServiceContainer').style.display = 'none';
		parent.document.getElementById('TestMaintContainer').style.display = 'none';
		parent.document.getElementById('EngineeringPlansContainer').style.display = 'none';
		parent.document.getElementById('PurchasingContainer').style.display = 'none';
		parent.document.getElementById('TimeEntryContainer').style.display = 'none';
		parent.document.getElementById('WebsiteContainer').style.display = 'none';
		parent.document.getElementById('AdminContainer').style.display = 'none';
		parent.document.getElementById('EnvironContainer').style.display = 'none';
		parent.document.getElementById('OfficeContainer').style.display = 'none';
		parent.document.getElementById('TrainingContainer').style.display = 'none';
		parent.document.getElementById('PersonalContainer').style.display = 'none';
		parent.document.getElementById('WebsiteContainer').style.display = 'none';
		parent.document.getElementById('InventoryContainer').style.display = 'none';
	}
	Container.style.display = 'block';
}



function ShowCalendar()
{
	if(document.getElementById('CalendarContainer'))
	{
		ChangeTab(document.getElementById('CalendarContainer'));
		return false;
	}
	if(parent.document.getElementById('CalendarContainer'))
	{
		ChangeTab(parent.document.getElementById('CalendarContainer'));
		return false;
	}
}
function Cal2(){Gebi('CalendarIframe').location='Cal2.asp'; Gebi('Cal2Btn').innerHTML='Old'; Gebi('Cal2Btn').style.display='none';}


function ShowGant()
{
	if(document.getElementById('GantContainer'))
	{
		ChangeTab(document.getElementById('GantContainer'));
		return false;
	}
	if(parent.document.getElementById('GantContainer'))
	{
		ChangeTab(parent.document.getElementById('GantContainer'));
		return false;
	}
}

var GenLoaded=false;
function ShowGeneral(){
	ChangeTab(document.getElementById('GeneralContainer'));
	//setTimeout("Gebi('GeneralIframe').contentWindow.LoadCommonData();",1500);
	//if(!GenLoaded){Gebi('GeneralIframe').src='Jobs.asp?Type=1&Active=True'; GenLoaded=true;}
	
	if(Gebi('GeneralIframe').src==''||Gebi('GeneralIframe').src==window.location)
	{
		Gebi('GeneralContainer').innerHTML='<iframe id=GeneralIframe src="Jobs.asp?Type=2&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowMail(){
	ChangeTab(document.getElementById('MailContainer'));
	if(Gebi('MailIframe').src==''||Gebi('MailIframe').src==window.location)
	{
		Gebi('MailContainer').innerHTML='<iframe id=MailIframe src="https://mail.google.com/a/tricomlv.com" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}


function ShowContacts(){
	ChangeTab(document.getElementById('ContactsContainer'));
	//if(Gebi('ContactsIframe').src==''){Gebi('ContactsIframe').src='Contacts.html'}
	if(Gebi('ContactsIframe').src==''||Gebi('ContactsIframe').src==window.location)
	{
		Gebi('ContactsContainer').innerHTML='<iframe id=ContactsIframe src="Contacts.html" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}


function ShowDataEntry(){
	ChangeTab(document.getElementById('DataEntryContainer'));
	//document.getElementById('DataEntryIframe').contentWindow.GetManufList();
	//if(Gebi('DataEntryIframe').src==''){Gebi('DataEntryIframe').src='DataEntry.html'}
	if(Gebi('DataEntryIframe').src==''||Gebi('DataEntryIframe').src==window.location)
	{
		Gebi('DataEntryContainer').innerHTML='<iframe id="DataEntryIframe" src="DataEntry.html" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}


function ShowEstimates(){
	if(Gebi('EstimatesIframe').contentWindow)	{var BidIFrame = Gebi('EstimatesIframe').contentWindow.document;}
	else if(Gebi('EstimatesIframe').contentDocument)	{var BidIFrame = Gebi('EstimatesIframe').contentDocument;}
	//BidIFrame.LoadMainLists();	
	//document.getElementById('EstimatesIframe').contentWindow.LoadMainLists();
	ChangeTab(document.getElementById('EstimatesContainer'));
	try {document.getElementById('oldBidderFrame').style.visibility='visible';} catch(e){}
	
	////if(Gebi('EstimatesIframe').src==''){Gebi('EstimatesIframe').src='Estimates.html'}
	//if(Gebi('EstimatesIframe').src==''||Gebi('EstimatesIframe').src==window.location)
	{
		if(	!BidIFrame.body.innerHTML	||	BidIFrame.body.innerHTML==''	)		{
			Gebi('EstimatesContainer').innerHTML='<iframe id="EstimatesIframe" src="Estimates.html" style="height:100%; width:100%;" frameborder=0></iframe>';
		}
	}
	////if(Gebi('oldBidderFrame').src==''){Gebi('oldBidderFrame').src='OldEstimates.html'}
	//if(Gebi('oldBidderFrame').src==''||Gebi('oldBidderFrame').src==window.location)
	//{
	//	document.body.removeChild(Gebi('oldBidderFrame'));
	//	//document.body.innerHTML+='<iframe id=oldBidderFrame frameborder=0 src="OldEstimates.html"></iframe>';
	//}

}


function ShowProjects(){
	ChangeTab(document.getElementById('ProjectsContainer'));
	//setTimeout('document.getElementById(\'ProjectsIframe\').contentWindow.Resize();',300);
	//setTimeout('document.getElementById(\'ProjectsIframe\').contentWindow.LoadCommonData();',1500);
	//if(Gebi('ProjectsIframe').src==''){Gebi('ProjectsIframe').src='Projects.asp'}
	if(Gebi('ProjectsIframe').src==''||Gebi('ProjectsIframe').src==window.location)
	{
		Gebi('ProjectsContainer').innerHTML='<iframe id="ProjectsIframe" src="Projects.asp" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}


function ShowService(){
	ChangeTab(document.getElementById('ServiceContainer'));
	if(Gebi('ServiceIframe').src==''){Gebi('ServiceIframe').src='Jobs.asp?Type=3&Active=True'}
	if(Gebi('ServiceIframe').src==''||Gebi('ServiceIframe').src==window.location)
	{
		Gebi('ServiceContainer').innerHTML='<iframe id="ServiceIframe" src="Jobs.asp?Type=3&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}


function ShowTestMaint(){
	ChangeTab(document.getElementById('TestMaintContainer'));
	//if(Gebi('TestMaintIframe').src==''){Gebi('TestMaintIframe').src='Jobs.asp?Type=4&Active=True'}
	if(Gebi('TestMaintIframe').src==''||Gebi('TestMaintIframe').src==window.location)
	{
		Gebi('TestMaintContainer').innerHTML='<iframe id=TestMaintIframe src="Jobs.asp?Type=4&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}


function ShowEngineering_Plans(){
	ChangeTab(document.getElementById('EngineeringPlansContainer'));
	//setTimeout('document.getElementById(\'PlansIframe\').contentWindow.LoadCommonData();',1500);
	//if(Gebi('PlansIframe').src==''){Gebi('PlansIframe').src='Plans.html'}
	if(Gebi('PlansIframe').src==''||Gebi('PlansIframe').src==window.location)
	{
		Gebi('EngineeringPlansContainer').innerHTML='<iframe id="PlansIframe" src="Plans.html" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}


function ShowPurchasing(){
	ChangeTab(document.getElementById('PurchasingContainer'));
	//setTimeout('document.getElementById(\'PurchasingIframe\').contentWindow.LoadCommonData();',1500);
	//if(Gebi('PurchasingIframe').src==''){Gebi('PurchasingIframe').src='Purchase.html'}
	if(Gebi('PurchasingIframe').src==''||Gebi('PurchasingIframe').src==window.location)
	{
		Gebi('PurchasingContainer').innerHTML='<iframe id=PurchasingIframe src="Purchase.html" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowTimeEntry(){
	//TimeEntryIframe.LoadTimeEntryList();
	ChangeTab(document.getElementById('TimeEntryContainer'));
	//if(Gebi('TimeEntryIframe').src==''){Gebi('TimeEntryIframe').src='Time_Entry.asp'}
	if(Gebi('TimeEntryIframe').src==''||Gebi('TimeEntryIframe').src==window.location)
	{
		Gebi('TimeEntryContainer').innerHTML='<iframe id="TimeEntryIframe" src="Time_Entry.asp" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowOffice(){
	ChangeTab(document.getElementById('OfficeContainer'));
	//if(Gebi('OfficeIframe').src==''){Gebi('OfficeIframe').src='SimpleJobs.asp?Type=9&Active=True'}
	if(Gebi('OfficeIframe').src==''||Gebi('OfficeIframe').src==window.location)
	{
		Gebi('OfficeContainer').innerHTML='<iframe id=OfficeIframe src="SimpleJobs.asp?Type=9&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowInventory(){
	ChangeTab(document.getElementById('InventoryContainer'));
	//if(Gebi('InventoryIframe').src==''){Gebi('InventoryIframe').src='SimpleJobs.asp?Type=8&Active=True'}
	if(Gebi('InventoryIframe').src==''||Gebi('InventoryIframe').src==window.location)
	{
		Gebi('InventoryContainer').innerHTML='<iframe id="InventoryIframe" src="SimpleJobs.asp?Type=8&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowTraining(){
	ChangeTab(document.getElementById('TrainingContainer'));
	//if(Gebi('TrainingIframe').src==''){Gebi('TrainingIframe').src='SimpleJobs.asp?Type=10&Active=True'}
	if(Gebi('TrainingIframe').src==''||Gebi('TrainingIframe').src==window.location)
	{
		Gebi('TrainingContainer').innerHTML='<iframe id="TrainingIframe" src="SimpleJobs.asp?Type=10&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowPersonal(){
	ChangeTab(document.getElementById('PersonalContainer'));
	//if(Gebi('PersonalIframe').src==''){Gebi('PersonalIframe').src='SimpleJobs.asp?Type=11&Active=True'}
	if(Gebi('PersonalIframe').src==''||Gebi('PersonalIframe').src==window.location)
	{
		Gebi('PersonalContainer').innerHTML='<iframe id="PersonalIframe" src="SimpleJobs.asp?Type=11&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowWebsite(){
	ChangeTab(document.getElementById('WebsiteContainer'));
	//if(Gebi('WebsiteIframe').src==''){Gebi('WebsiteIframe').src='SimpleJobs.asp?Type=12&Active=True'}
	if(Gebi('WebsiteIframe').src==''||Gebi('WebsiteIframe').src==window.location)
	{
		Gebi('WebsiteContainer').innerHTML='<iframe id="WebsiteIframe" src="SimpleJobs.asp?Type=12&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowAdmin(){
	ChangeTab(document.getElementById('AdminContainer'));
	//setTimeout("document.getElementById('AdminIframe').contentWindow.LoadEmpList;",1000);
	//if(Gebi('AdminIframe').src==''){Gebi('AdminIframe').src='Admin.asp'}
	if(Gebi('AdminIframe').src==''||Gebi('AdminIframe').src==window.location)
	{
		Gebi('AdminContainer').innerHTML='<iframe id="AdminIframe" src="Admin.asp" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}

function ShowEnviron(){
	ChangeTab(document.getElementById('EnvironContainer'));
	//if(Gebi('EnvironIframe').src==''){Gebi('EnvironIframe').src='SimpleJobs.asp?Type=17&Active=True'}
	if(Gebi('EnvironIframe').src==''||Gebi('EnvironIframe').src==window.location)
	{
		Gebi('EnvironContainer').innerHTML='<iframe id="EnvironIframe" src="SimpleJobs.asp?Type=17&Active=True" style="height:100%; width:100%;" frameborder=0></iframe>';
	}
}






function Resize()
{
	//document.getElementById('LogOut').style.left=(document.body.offsetWidth);
	TabWidth = (document.body.offsetWidth) / 10;
	
	var LMCH=66;
	
	if(window.innerHeight)	{document.body.style.height=window.innerHeight+'px';}
	
	//alert(Gebi('Iframes').offsetHeight);
	Gebi('Iframes').style.height=(document.body.offsetHeight-LMCH)+'px';
	Gebi('Iframes').style.maxHeight=(document.body.offsetHeight-LMCH)+'px';
	Gebi('Iframes').style.minHeight=(document.body.offsetHeight-LMCH)+'px';
	//alert(Gebi('Iframes').offsetHeight);
	/*
	*/
	
	
	//document.body.style.width='100%';
	//document.body.style.width=(document.body.offsetWidth-24)+'px';
}
