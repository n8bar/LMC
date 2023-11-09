// JavaScript Document

//var ClosedWidth = 40;
//var ExpandedWidth = 180;
//var MainHeight = 140;


var slideMenu=function()
{


	var TimeS,Ewidth,TimeM,Obj,ObjLI,ObjLI_length,OAwidth,SectionWidth,ot,OBJselected,LIobject;
	return{

	
		build:function(ObjID,ExpWidth,mTime,sTime,Selected,h)
		{
		
			TimeS = sTime;
			Ewidth = ExpWidth;
			TimeM  = mTime;
			
			Obj = document.getElementById(ObjID);
			
			
			ObjLI = Obj.getElementsByTagName('li');
			
			ObjLI_length = ObjLI.length;
			
			var MainWidth = ((ObjLI_length*ClosedWidth) + ExpWidth);
			Obj.style.width = Math.abs(MainWidth)+'px';
			//Obj.style.height = MainHeight+'px';
			
			OAwidth = (Obj.offsetWidth - (ClosedWidth*2));
			
			SectionWidth = ClosedWidth;// OAwidth/ObjLI_length; 
			 
			ot = Math.floor((OAwidth-ExpWidth)/(ObjLI_length-1)); //
			
			var i=0;
			
			
			
			for(i;i<ObjLI_length;i++)
			{
				LIobject=ObjLI[i];
				LIobject.style.width=Math.abs(SectionWidth)+'px';
				this.timer(LIobject)
			}
			
			
			
			if(Selected!=null)
			{
				Obj.timer=setInterval(function(){slideMenu.slide(ObjLI[Selected-1])},TimeM)
			}
			
			//
			
			//alert(MainWidth);
			
			// 
		},
		
		
		
		
		
		
		
		
		
		
		timer:function(LIobject)
		{
		
			LIobject.onmouseover=function()
			{
				clearInterval(Obj.htimer);
				clearInterval(Obj.timer);
				
				
				
				Obj.timer=setInterval(function(){slideMenu.slide(LIobject)},TimeM)
			}
			
			
			
			LIobject.onmouseout=function()
			{
				clearInterval(Obj.timer);
				clearInterval(Obj.htimer);
				
				//Obj.htimer=setInterval(function(){slideMenu.slide(Obj.timer,true)},TimeM) //Obj.htimer=setInterval(function(){slideMenu.slide(ObjTime,true)},TimeM)
			}
			
		},
		
		
		
		
		
		
		slide:function(OBJselected,TimeM)
		{
			if (OBJselected == null)	{return false;}
	
			var OBJselectedWidth=parseInt(OBJselected.style.width);
			
			
			if((OBJselectedWidth<Ewidth && !TimeM) || (OBJselectedWidth>SectionWidth && TimeM))
			{
				var owt=0;
				var i=0;
				
				
				
				for(i; i < ObjLI_length; i++)
				{
					
					if(ObjLI[i] != OBJselected)
					{
						var ObjLIX,LIXWidth;
						
						var oi = 0;
						
						ObjLIX = ObjLI[i];
						
						LIXWidth = parseInt(ObjLIX.style.width);
						
						
						
						if(LIXWidth<ClosedWidth && TimeM) //sets the width of the li hovered over
						{
							
							oi =   Math.floor((ClosedWidth-LIXWidth)/TimeS);
							
							oi=( oi > 0 ) ? oi:1 ;
							
							ObjLIX.style.width=(LIXWidth + oi)+'px';
							
						}
						else if(LIXWidth > ot && ! TimeM)//Sets the widths of the lis not hovered over
						{
							
							oi =  Math.floor((LIXWidth - ot) / TimeS);
							
							oi=( oi > 0 ) ? oi:1 ;
							
							ObjLIX.style.width=(LIXWidth - oi)+'px'
							
						}
						
						
						
						
						
						if(TimeM)
						{
							owt=owt+(LIXWidth+oi)
						}
						else
						{
							owt=owt+(LIXWidth-oi)
						}
						}
						}
				OBJselected.style.width=(OAwidth-owt)+'px';
			}
			else
			{
			clearInterval(Obj.timer);clearInterval(Obj.htimer)
			}
			
			
			
			//alert(ObjLI_length);
		}
		
		
		
		
		
	};
}
();
