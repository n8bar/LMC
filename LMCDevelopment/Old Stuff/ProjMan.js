// JavaScript Document


var DataBoxArray=new Array('ManageBox','ScheduBox','BOfMatBox','DocsBox','PrDocsBox','PlansBox','PicBox','MapBox','ClDocsBox','JobLogBox');
var DataTabArray=new Array('ManageTabBox','ScheduTabBox','BOfMatBox','DocsTabBox','PrDocsTabBox','PlansTabBox','PicTabBox','MapTabBox','ClDocsTabBox','JobLogTabBox');



function Back2List(){parent.document.getElementById('ProjectsIframe').src='Projects.asp';}

function Void(){}

var TimeInterval=3;
var RollTimer;
function RollDn(Suffix)
{
	clearTimeout(RollTimer);
	var ru=Gebi('iBox'+Suffix).offsetHeight+1;
	for(rd=1;rd<Gebi('iBox'+Suffix).offsetHeight+1;rd++)
	{
		RollTimer=setTimeout("Gebi('iRollUp"+Suffix+"').style.height='"+rd+"px';",rd*TimeInterval);
	}
	Gebi('DnButton'+Suffix).style.display='none';
	Gebi('UpButton'+Suffix).style.display='block';
}

function RollUp(Suffix)
{
	clearTimeout(RollTimer);
	var H=Gebi('iBox'+Suffix).offsetHeight+1;
	var ru=Gebi('iBox'+Suffix).offsetHeight+0;
	for(rd=1;rd<H;rd++)
	{
		ru--;
		RollTimer=setTimeout("Gebi('iRollUp"+Suffix+"').style.height='"+ru+"px'; ",rd*TimeInterval);
	}
	//setTimeout("Resize();",(H+1)*TimeInterval);
	Gebi('DnButton'+Suffix).style.display='block';
	Gebi('UpButton'+Suffix).style.display='none';
}








var OldBkg = new Array;
function DataTabs(Prefix,Title)//Dynamic Tab Selection
{
	var Box = Prefix+'Box';
	var Tab = Prefix+'TabBox';
	var Inner= Gebi(Prefix+'Tab');
	
	
	var key;
		
	for(key in DataBoxArray)
	{
	  //alert(key+'='+DataBoxArray[key]);
		document.getElementById(DataBoxArray[key]).style.display = 'none';
		document.getElementById(DataBoxArray[key]).style.visibility = 'hidden';
	}
	
	//document.getElementById('DataTabsBox').style.borderBottomColor = document.getElementById(Tab).style.backgroundColor;
	
	Gebi('TabTitleText').innerHTML=Title;
	document.getElementById(Box).style.visibility = 'visible';
	document.getElementById(Box).style.display = 'block';
	Gebi('DataTabsBox').style.borderBottomColor=Inner.style.backgroundColor;
	Resize();
}





function showPartsBox()
{
	Gebi('Modal').style.display='block';
	Gebi('PartsBox').style.display='block';
}









var OldMarTop = new Array
function MouseOverMarTop(ID)
{
	OldMarTop[ID]=Gebi(ID).style.marginTop;
	document.getElementById(ID).style.marginTop=3;
}

function MouseOutMarTop(ID)
{
	document.getElementById(ID).style.marginTop=OldMarTop[ID];
}



function AngleText(txt,objId,hSp,vSp)
{
	var obj=document.getElementById(objId);
	//alert(obj);

	if(isNaN(hSp)){hSp=0;} //horizontal spacing
	if(isNaN(vSp)){vSp=9;} //vertical spacing in pixels

	var Text= new Array;
	Text= txt.split(',')

	obj.innerHTML=''
	var HTML=''
	for(c=0;c<Text.length;c++)
	{
		//var char=txt.substring(c,c+1);
		HTML+='<div style="height:'+vSp+'px; margin-left:'+c*hSp+'px; overflow:visible;" align="center">';
		
		//for(s=0;s<c*hSp;s++)
		//{HTML+='&nbsp;'}
		
		//HTML+=char+'</div>';
		HTML+=Text[c]+'</div>';
	}
	
	obj.innerHTML=HTML;
}





var ProgDivID;
var ProgColumn;
function showProgressMenu(DivID,ProjID,ColumnID,TableName,SystemID)
{
	ProgDivID=DivID;
	ProgColumn=ColumnID;
	
	var Progarr=parent.ProgressArray;
	
	//alert(SystemID)
	//var TableName = "Projects"
   var MenuItems ='<div class="ProgressItemsHead">Progress</div>';  
     
	
	var MenuH=document.getElementById('PhaseProgressMenu').offsetHeight;
	var MenuW=document.getElementById('PhaseProgressMenu').offsetWidth;
	
	//alert(x1+','+y1);
	if(mY>document.body.offsetHeight-MenuH)
	{mY=mY-MenuH-24;}
	if(mX>document.body.offsetWidth-MenuW)
	{mX-=MenuW-24;}
  
	Gebi('PhaseProgressMenu').style.top=mY+'px';
  Gebi('PhaseProgressMenu').style.left=mX+'px';
  Gebi('PhaseProgressMenu').style.display="block";
  //return false;
}

var ProgressWindows=0;
var ProgressWindow=new Array;
function PrintProgressReport()
{
	ProgressWindows++;
	var WindowOptions = 'scrollbars=yes,height=704,width=980, resizable=yes';
	ProgressWindow[ProgressWindows]=window.open('ProgressPrint.asp?ProjID='+ProjID+'&ProgWindow='+ProgressWindows,'ProgWindow'+ProgressWindows, WindowOptions,false);
}

function CloseProgressMenu()
{
  document.getElementById('PhaseProgressMenu').style.display = "none";
  return false;
}




function ShowInfoBoxBox()
{
	Gebi('LeftModal').style.display='block';
	Gebi('InfoBoxBox').style.display='block';
	Gebi('iBTitle').focus();
}

var InfoBoxID;
var InfoBoxNum;
function ShowInfoBoxDataBox(ID,Num)
{
	InfoBoxID=ID;
	InfoBoxNum=Num;
	alert(ID+','+Num);
	Gebi('LeftModal').style.display='block';
	Gebi('InfoBoxDataBox').style.display='block';
	Gebi('iBTitle').focus();
}

function CloseInfoBoxBox()
{
	Gebi('LeftModal').style.display='none';
	Gebi('InfoBoxBox').style.display='none';
	Gebi('InfoBoxDataBox').style.display='none';
}







var SizeTimer;
function Resize()
{
	clearTimeout(SizeTimer)	//Wait 'till window resizing stops before changing everything.
	SizeTimer=setTimeout('DoTheResize();',50);
}
	
function DoTheResize()
{

	var H= (typeof window.innerHeight != 'undefined' ? window.innerHeight : document.body.offsetHeight);
	var W=(typeof window.innerWidth != 'undefined' ? window.innerWidth : document.body.offsetWidth);
	
	Gebi('OverAllContainer').style.height=Math.abs((H*1)-24)+'px';
	
	Gebi('Right').style.height=Math.abs(H-48)+'px';
	//Nifty('div#Right','medium transparent bottom')
	//Gebi('Right').style.width=(W-Gebi('Left').offsetWidth-(W*.05))+'px';
	
	var RW=Math.round(W-Gebi('Left').offsetWidth-(W*.02));
	var RMinW=640;//Gebi('Right').currentStyle['minWidth'].replace('px','')
	
	//alert(RW+'  Min:'+RMinW);
	if(RW<RMinW){RW=RMinW;}
	Gebi('Right').style.width=RW+'px';
	//alert(Gebi('Right').style.width);

	Gebi('RightTitle').style.width=(Gebi('Right').offsetWidth+0)+'px';
	
	Gebi('SchList').style.height=(Gebi('ScheduBox').offsetHeight-80)+'px';
	
	var Divs= document.getElementsByTagName('div');
	/*
	var BoxId;
	var TitleId;
	for(D=0;D<Divs.length;D++)
	{
		if(Divs[D].id.indexOf('iBox')!= -1)
		{
			BoxId=Divs[D].id;
			TitleId=Divs[D].id.replace('iBox','iTitle');
			
			try{
				Gebi(TitleId).style.maxWidth=((.95*Gebi('Left').offsetWidth)-18)+'px';
				Gebi(TitleId).style.minWidth=((.95*Gebi('Left').offsetWidth)-18)+'px';
				Gebi(TitleId).style.width=((.95*Gebi('Left').offsetWidth)-18)+'px';
				
				Gebi(BoxId).style.maxWidth=Math.abs(Gebi(TitleId).offsetWidth-8)+'px';
				Gebi(BoxId).style.minWidth=Math.abs(Gebi(TitleId).offsetWidth-8)+'px';
				Gebi(BoxId).style.width=Math.abs(Gebi(TitleId).offsetWidth-8)+'px';
				//Gebi(TitleId).innerHTML=Gebi(TitleId).offsetLeft;
				Gebi(BoxId).style.left=(Gebi(TitleId).offsetLeft-8)+'px';
			}
			catch(e){
				alert(BoxId+'-'+TitleId+'  '+e.description);
			}
		}
		
		if(Divs[D].className=='Box'||Divs[D].className=='BoxHidden')
		{
			Divs[D].style.height=Math.abs(Gebi('Right').offsetHeight-46)+'px';
		}
	}
	/**/
		
	for(D=0;D<Divs.length;D++)
	{
		if(Divs[D].id.indexOf('TabBox')!= -1)
		{
			var InnerID=Divs[D].id.replace('Box','');
			Divs[D].style.width=((.125*Gebi('Right').offsetWidth)-2)+'px';
			
			var OldBk=Divs[D].parentNode.style.backgroundColor;
			Divs[D].parentNode.style.backgroundColor='#ebebeb';
			Divs[D].style.backgroundColor='#ebebeb';
			//Nifty('div#'+InnerID+',div#'+Divs[D].id,'big transparent top');
			Divs[D].parentNode.style.backgroundColor=OldBk;
		}
	}
}




