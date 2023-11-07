// JavaScript Document


function CreateCalendarTabs()
{
	
	var HTML = '';

	
	var NextColor ='FF99CC';

	var TabColor = new Array;
	for (i =1 ; i <=NumTasks ; i++)
	{
		TabColor[i]=TaskArrayOrdered[i][3];
	}
	TabColor[0]='FF99CC';

   HTML +='<div id="MainTabCalender" style="background-color:#6CBDE2; float:left;">';
	 HTML +=	'<li id="TaskTabs1000" style="padding:0px 0px 0px 0px; background:#1C80CA; color:#FFF; height:64px;" >';
	 HTML +=		'<div id="SlideTabText1000" class="SlideTabText" onclick=" ShowCalendar(); UnderTabs.style.background=&#39;#1C80CA&#39; ">';
	 HTML +=			'Cal<br /><br />&nbsp;</div></li></div>'; 
   HTML +='<div style="background-color:#1C80CA; float:left;">';
	 HTML +=	'<li id="TaskTabs1001" style="background:#FF99CC; height:64px;">';
	 HTML +=		'<div id="SlideTabText1001" class="SlideTabText" onclick=" ShowGantChart(); UnderTabs.style.background=&#39;#FF99CC&#39;">';
	 HTML +=			'GC<br /><br />&nbsp;</div></li></div>';

for (i =1 ; i <=NumTasks ; i++)
	{
     //alert('MainTab'+i);
		 //HTML +='<li style="background:#CC99CC; text-align:center;"><div id="SlideTabText'+i+'" class="SlideTabText" >Task'+i+'</div></li>';
		HTML +='<div id="MainTab'+i+'" style="background-color:#'+TabColor[i-1]+'; float:left;">';
		HTML +=	'<li id="'+i+'" '+/*onMouseUp="showViews();"*/' style="background:#'+TaskArrayOrdered[i][3]+';color:#'+TaskArrayOrdered[i][4]+'; height:64px;">';
		HTML +=		'<div id="SlideTabText1" class="SlideTabText"';
		HTML +=		 'onclick="UnderTabs.style.background=&#39;#'+TaskArrayOrdered[i][3]+'&#39;;'+TaskArrayOrdered[i][5]+'();">';
		HTML +=			TaskArrayOrdered[i][2]+'<br /><br />&nbsp;</div></li>';
		//alert(i);
		 
	}		 //alert(TaskArrayOrdered);
	

	
	

	//Nifty('li#TaskTabs'+i,'medium transparent top');

   
	document.getElementById('SlideTabs').innerHTML = HTML;
	setTimeout('NiftyAll();',1000);

	//alert(TabWidth);  
	//slideMenu.build('SlideTabs',125,2,2,1);
  
	//if(accessDataEntry!='True'){document.getElementById('MainTab3').style.display='none';}

}

function Resize()
{
	//document.getElementById('LogOut').style.left=(document.body.offsetWidth);
	TabWidth = 128//(document.body.offsetWidth) / 10;
}


function ChangeTab(Container)
{
	document.getElementById('CalendarContainer').style.display = 'none';
	document.getElementById('GantChartContainer').style.display = 'none';
	document.getElementById('GeneralContainer').style.display = 'none';
	document.getElementById('ContactsContainer').style.display = 'none';
	document.getElementById('DataEntryContainer').style.display = 'none';
	document.getElementById('EstimatesContainer').style.display = 'none';
	document.getElementById('ProjectsContainer').style.display = 'none';
	document.getElementById('ServiceContainer').style.display = 'none';
	document.getElementById('TestMaintContainer').style.display = 'none';
	document.getElementById('EngineeringPlansContainer').style.display = 'none';
	document.getElementById('PurchasingContainer').style.display = 'none';
	document.getElementById('TimeEntryContainer').style.display = 'none';
	document.getElementById('OfficeManagementContainer').style.display = 'none';
	document.getElementById('InventoryContainer').style.display = 'none';
	document.getElementById('TrainingContainer').style.display = 'none';
	document.getElementById('PersonalContainer').style.display = 'none';
	document.getElementById('WebsiteContainer').style.display = 'none';
	document.getElementById('AdminContainer').style.display = 'none';

	Container.style.display = 'block';
}



function ShowCalendar()
{
	ChangeTab(document.getElementById('CalendarContainer'));
}


function ShowGantChart()
{
	ChangeTab(document.getElementById('GantChartContainer'));
}


function ShowGeneral()
{
	//document.getElementById('GeneralIframe').contentWindow.document.getElementById('OverAllContainerWhite').innerHTML = ' &nbsp; Loading Notes';
	ChangeTab(document.getElementById('GeneralContainer'));
}


function ShowContacts()
{
	ChangeTab(document.getElementById('ContactsContainer'));
}


function ShowDataEntry()
{
	ChangeTab(document.getElementById('DataEntryContainer'));
}


function ShowEstimates()
{
	ChangeTab(document.getElementById('EstimatesContainer'));
}


function ShowProjects()
{
	ChangeTab(document.getElementById('ProjectsContainer'));
}


function ShowService()
{
	ChangeTab(document.getElementById('ServiceContainer'));
}


function ShowTestMaint()
{
	ChangeTab(document.getElementById('TestMaintContainer'));
}


function ShowEngineering_Plans()
{
	ChangeTab(document.getElementById('EngineeringPlansContainer'));
}


function ShowPurchasing()
{
	ChangeTab(document.getElementById('PurchasingContainer'));
}


function ShowTimeEntry()
{
	ChangeTab(document.getElementById('TimeEntryContainer'));
}


function ShowOffice()
{
	ChangeTab(document.getElementById('OfficeManagementContainer'));
}

function ShowShipping()
{
	ChangeTab(document.getElementById('InventoryContainer'));
}
function ShowTraining()
{
	ChangeTab(document.getElementById('TrainingContainer'));
}
function ShowPersonal()
{
	ChangeTab(document.getElementById('PersonalContainer'));
}
function ShowWebsite()
{
	ChangeTab(document.getElementById('WebsiteContainer'));
}


function ShowAdmin()
{
	ChangeTab(document.getElementById('AdminContainer'));
	//setTimeout("document.getElementById('AdminIframe').contentWindow.LoadEmpList;",1000);
}

