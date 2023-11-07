

//setup Event Extender D&D///
var EvExID=null;           //
var EvExDir=0;             //
var EvExD8From=new Date(); //
var EvExD8To=new Date();   //
/////////////////////////////


var mX=0; var mY=0;
var EventChanged=false;
function EventExtend(event, weekDiv)	{
	
	if(!EvExID||EvExDir==0)	{	return false	}
	
	var d8From= new Date(Gebi('Event'+EvExID).getAttribute('d8From')); //strToDate
	var d8To= new Date(Gebi('Event'+EvExID).getAttribute('d8To'));
	
	var preDays=0;
	var preMs=0
	var postDays=0;
	if (d8From<Sunday)	{
		preMs = (Sunday-d8From);	//milliseconds
		preDays = preMs/1000; 	
		preDays /= 60; 
		preDays /= 60; 
		preDays /= 24; 
	}
	if (d8To>Sunday2)	{
		postDays= Sunday2-d8To;
	}
	
	
	if (!event){event = window.event;}
	mX = event.clientX-weekDiv.offsetLeft;
	mY = event.clientY;
	
		
	var weekW=weekDiv.offsetWidth;
	var dayW=weekW/8;
	
	//var EvStart=d8From;
	//if (EvStart<Sunday)	{	EvStart=Sunday;	}
	//var EvEnd=d8To;
	//if (EvEnd>Sunday2)	{	EvEnd=Sunday2;	}
	
	switch(EvExDir)	{
		case -1: //left end ----------------------------------------------------------------------------
			var newLeft=mX+8;
			
			var numDaysLeft=Math.round(newLeft/dayW);
			
			d8From=new Date((Sunday*1)+daysToMs(numDaysLeft));
			
			var numDays=msToDays(d8To-d8From);
			
			if(Math.abs(Gebi('Event'+EvExID).offsetLeft-(numDaysLeft*dayW)) >	dayW/4)	{
				if(d8From>d8To)	{ d8From=d8To	}
				SendSQL('Write','UPDATE Calendar SET DateFrom=\''+mdyyyy(d8From+daysToMs(1))+'\' WHERE CalID='+EvExID);
				
				var percentL=20+(numDaysLeft*10);
				var percentW=(numDays+1)*10;
			
				Gebi('Event'+EvExID).style.left=percentL+'%';
				Gebi('Event'+EvExID).style.width=percentW+'%';
				Gebi('Event'+EvExID).style.maxWidth=100-percentL+'%';
			}
			
			Gebi('Event'+EvExID).setAttribute('d8From',d8From);
		break;
		
		case 1: //right end -----------------------------------------------------------------------------
			var newWidth=mX+8-(Gebi('Event'+EvExID).offsetLeft-weekDiv.offsetLeft);
			
			var numDays=Math.round(newWidth/dayW);
		
			newWidth=(newWidth/weekW)*100;
			
			d8To=new Date(((d8From*1)+daysToMs(numDays-1)));
			
			if(d8To<d8From)	{ d8To=d8From	}
			SendSQL('Write','UPDATE Calendar SET DateTo=\''+mdyyyy(d8To)+'\' WHERE CalID='+EvExID);
			var percentW=numDays*10;		
			Gebi('Event'+EvExID).style.width=percentW+'%';
			Gebi('Event'+EvExID).style.maxWidth='100%';
			Gebi('Event'+EvExID).setAttribute('d8To',d8To);
		break;
		
		case 2: // whole event ----------------------------------------------------------------------------
			//----Horizontal Movements----//
			var newLeft=mX-evGrabPosX;
			
			var numDaysLeft=Math.round(newLeft/dayW);
			var numDays=Math.round(Gebi('Event'+EvExID).offsetWidth/dayW);
		
			newLeft=((Sunday-(d8From-preMs))/1);
			
			if(Math.abs(Gebi('Event'+EvExID).offsetLeft-(numDaysLeft*dayW)) >	dayW/4)	{
				//d8From=new Date((Sunday*1)+daysToMs(numDaysLeft));
				//d8To=new Date(((d8From*1)+daysToMs(numDays)));
				d8From=new Date(dayAdd(LastSaturday,numDaysLeft+1));
				d8To=new Date(dayAdd(d8From,numDays-2));
				
				if(d8To<d8From)	{ d8To=d8From	}
				
				SendSQL('Write','UPDATE Calendar SET DateFrom=\''+mdyyyy(d8From)+'\', DateTo=\''+mdyyyy(d8To)+'\' WHERE CalID='+EvExID); 
				for(eID=1;eID<evCalID.length;eID++)	{
					Gebi('Event'+evCalID[eID]).style.zIndex=9999;
					if(evCalID[eID]==EvExID) 	{	Gebi('Event'+EvExID).style.zIndex=10000;	} //Put this one on top.
				}
				var percentL=20+(numDaysLeft*10);
				Gebi('Event'+EvExID).style.left=percentL+'%'; 
				Gebi('Event'+EvExID).style.maxWidth=100-percentL+'%';
				Gebi('Event'+EvExID).setAttribute('d8From',d8From);
				Gebi('Event'+EvExID).setAttribute('d8To',d8To);
			}
			
			//----Vertical Movements----//
			var newTop=mY-evGrabPosY;
			var oldNewTop=newTop;
			for(r=1;r<RowAttn.length;r++)	{	
				var rT=Gebi('Row'+RowAttn[r]).offsetTop;
				var rB=rT+Gebi('Row'+RowAttn[r]).offsetHeight;
				if(rT<mY&&rB>mY)	{
					newTop=rT;
					
					var DoneYet=false;
					var evOffset=0;
					while(!DoneYet)	{
						DoneYet=true;
						for(eID=1;eID<evCalID.length;eID++)	{
							var nT=Math.round((newTop+evOffset)/4);
							var evTop=Math.round(Gebi('Event'+evCalID[eID]).offsetTop/4);
							var EvExLeft=Gebi('Event'+EvExID).offsetLeft;
							var EvExRight=EvExLeft+Gebi('Event'+EvExID).offsetWidth;				
							var evLeft=Gebi('Event'+evCalID[eID]).offsetLeft;
							var evRight=evLeft+Gebi('Event'+evCalID[eID]).offsetWidth;
							
							if(nT==evTop)	{ //vertical collision
								if(EvExLeft<evRight && EvExRight>evLeft) {	//? Horizontal collision
									DoneYet=false;
									evOffset+=16;
					}	}	}	}
					
					var nowTop=Gebi('Event'+EvExID).offsetTop;
					var setTop=newTop+evOffset
					
					if(attnByCalID[EvExID]!=RowAttn[r])	{
						SendSQL('Write','UPDATE Calendar SET AttentionID='+RowAttn[r]+' WHERE CalID='+EvExID);
						attnByCalID[EvExID]=RowAttn[r]
						Gebi('Event'+EvExID).style.top=setTop+'px';
					}
				}
			}
		break;
		
		default:
			return false;
		break;
	}
}

var eventMX=0;
var eventMY=0;
function evMPos(event,eventDiv)	{
	eventMX = event.clientX-eventDiv.offsetLeft;
	eventMY = event.clientY-eventDiv.offsetTop;
}

var evGrabPosX=0;
var evGrabPosY=0;
function evMDown()	{
	evGrabPosX=eventMX;
	evGrabPosY=eventMY;
}

function update()	{	}