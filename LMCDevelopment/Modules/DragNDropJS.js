// JavaScript Document
	


	/************************************************************************************************************
	(C) www.dhtmlgoodies.com, November 2005
	
	Update log:
	
	December 20th, 2005 : Version 1.1: Added support for rectangle indicating where object will be dropped
	January 11th, 2006: Support for cloning, i.e. "copy & paste" items instead of "cut & paste"
	January 18th, 2006: Allowing multiple instances to be dragged to same box(applies to "cloning mode")
	
	This is a script from www.dhtmlgoodies.com. You will find this and a lot of other scripts at our website.	
	
		Terms of use:
	You are free to use this script as long as the copyright message is kept intact. However, you may not
	redistribute, sell or repost it without our permission.
	
	Thank you!
	
	www.dhtmlgoodies.com
	Alf Magne Kalleland
	
	Add the following to your HTML
	<ul id="dragContent"></ul>
    <div id="dragDropIndicator"><img src="../../TMCDevelopment/Arrow20X25R2.gif"></div>
	
	************************************************************************************************************/
		
	/* VARIABLES YOU COULD MODIFY */
	
	boxSizeArray = new Array();
	
	for(var B = 0; B <50; B++ )
	{
	    boxSizeArray[B] = 50; 
	
	}
	
	
	var arrow_offsetX = 0;	// Offset X - position of small arrow
	var arrow_offsetY = 0;	// Offset Y - position of small arrow
	
	var arrow_offsetX_firefox = -6;	// Firefox - offset X small arrow
	var arrow_offsetY_firefox = -13; // Firefox - offset Y small arrow
	
	var verticalSpaceBetweenListItems = 1;	// Pixels space between one <li> and next	
											// Same value or higher as margin bottom in CSS for #dhtmlgoodies_dragDropContainer ul li,#dragContent li
	
											
	var indicateDestionationByUseOfArrow = false;	// Display arrow to indicate where object will be dropped(false = use rectangle)

	var cloneSourceItems = false;	// Items picked from main container will be cloned(i.e. "copy" instead of "cut").	
	var cloneAllowDuplicates = true;	// Allow multiple instances of an item inside a small box(example: drag Student 1 to team A twice
	
	/* END VARIABLES YOU COULD MODIFY */
	
	var dragDropMainContainer = false;
	var dragTimer = -1;
	var dragContentObj = false;
	var contentToBeDragged = false;	// Reference to dragged <li>
	var contentToBeDragged_src = false;	// Reference to parent of <li> before drag started
	var contentToBeDragged_next = false; 	// Reference to next sibling of <li> to be dragged
	var destinationObj = false;	// Reference to <UL> or <LI> where element is dropped.
	var dragDropIndicator = true;	// Reference to small arrow indicating where items will be dropped
	var ulPositionArray = new Array();
	var mouseoverObj = true;	// Reference to highlighted DIV
	
	var indicateDestinationBox = false;
	
	
	var MSIE = navigator.userAgent.indexOf('MSIE')>=0?true:false;
	var navigatorVersion = navigator.appVersion.replace(/.*?MSIE (\d\.\d).*/g,'$1')/1;

    var MainDivContainer = 'CalendarMain';// This is the id of the main overall container which holds the <ul> and <li>
	var SubDivContainer = 'Calendar1';// This is the id of the Sub container which holds the <ul> and <li>


	var offsetX = 0;
	var offsetY = 0;
	
	
	var Initiated = 0;
	var CapturedID = 0;

	
	
function getTopPosition(inputObj)
{		
	  var returnValue = inputObj.offsetTop;
	  while((inputObj = inputObj.offsetParent) != null)
	  {
	  	if(inputObj.tagName!='HTML')returnValue += inputObj.offsetTop;
	  }
	  return returnValue;
}
	
	
	
	
	
	
	
function getLeftPosition(inputObj)
{
	  var returnValue = inputObj.offsetLeft;
	  while((inputObj = inputObj.offsetParent) != null)
	  {
	  	if(inputObj.tagName!='HTML')returnValue += inputObj.offsetLeft;
	  }
	  return returnValue;
}
	
	
	
	
		
function cancelEvent()
{
	return false;
}
	
	
	
	
	
	
	
	
function initDrag(e)	// Mouse button is pressed down on a <li>
{
	//CapturedID = EventClickID;
	//ViewsTab.innerHTML=this.id;
	CapturedID=this.id.replace('li','');
	   
	    EventDragToggle = 1;
	
		if(document.all)e = event;
		var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
		var sl = Math.max(document.body.scrollLeft,document.documentElement.scrollLeft);
		
		
		
		dragTimer = 0;
		dragContentObj.style.left = e.clientX + sl - offsetX + 'px';
		dragContentObj.style.top = e.clientY + st + offsetY + 'px';
		contentToBeDragged = this;
		contentToBeDragged_src = this.parentNode;
		contentToBeDragged_next = false;
		
		if(this.nextSibling)
		{
			contentToBeDragged_next = this.nextSibling;
			if(!this.tagName && contentToBeDragged_next.nextSibling)contentToBeDragged_next = contentToBeDragged_next.nextSibling;
		}
		
		timerDrag();
		return false;
}
	
	
	
	
	
	
	
	
	
function timerDrag()
{
		if(dragTimer>=0 && dragTimer<15)
		{
			dragTimer++;
			setTimeout('timerDrag()',15);
			
			return;
		}
		
		if(dragTimer==15)
		{
			
			//if(cloneSourceItems && contentToBeDragged.parentNode.id=='allItems')
			//{
				//newItem = contentToBeDragged.cloneNode(true);
				//newItem.onmousedown = contentToBeDragged.onmousedown;
				//contentToBeDragged = newItem;
			//}
			
			dragContentObj.style.display='block';
			dragContentObj.appendChild(contentToBeDragged);
		}
}
	
	
	
	
	
	
	
	
	
function moveDragContent(e)
{
		if(dragTimer<15)
		{
			if(contentToBeDragged)
			{
				if(contentToBeDragged_next)
				{
					try
					{
						contentToBeDragged_src.insertBefore(contentToBeDragged,contentToBeDragged_next);
					}
					catch(e){}
				}
				else
				{
					contentToBeDragged_src.appendChild(contentToBeDragged);
				}	
			}
			return;
		}
		
		
		if(document.all)e = event;
		
		var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
		var sl = Math.max(document.body.scrollLeft,document.documentElement.scrollLeft);
		
		
		dragContentObj.style.left = e.clientX + sl - offsetX  + 'px';//Position of dragged object
		dragContentObj.style.top = e.clientY + st + offsetY  + 'px';
		
		if(mouseoverObj)mouseoverObj.className='';
		destinationObj = false;
		dragDropIndicator.style.display='none';
		if(indicateDestinationBox)indicateDestinationBox.style.display='none';
		
		
		Initiated = 1;
		
		
		var x = e.clientX + sl;
		var y = e.clientY + st;
		var width = dragContentObj.offsetWidth;
		var height = dragContentObj.offsetHeight;
		
		
		
		
		var tmpOffsetX = arrow_offsetX;
		var tmpOffsetY = arrow_offsetY;
		
		
		
		
		if(!document.all)
		{
			tmpOffsetX = arrow_offsetX_firefox;
			tmpOffsetY = arrow_offsetY_firefox;
		}
		
		
		
		

		for(var no=0;no<ulPositionArray.length;no++)
		{
			var ul_leftPos = ulPositionArray[no]['left'];	
			var ul_topPos = ulPositionArray[no]['top'];	
			var ul_height = ulPositionArray[no]['height'];
			var ul_width = ulPositionArray[no]['width'];
			
			if((x+width) > ul_leftPos && x<(ul_leftPos + ul_width) && (y+height)> ul_topPos && y<(ul_topPos + ul_height))
			{
				var noExisting = ulPositionArray[no]['obj'].getElementsByTagName('LI').length;
				if(indicateDestinationBox && indicateDestinationBox.parentNode==ulPositionArray[no]['obj'])noExisting--;
				if(noExisting<boxSizeArray[no-1] || no==0)
				{
					dragDropIndicator.style.left = ul_leftPos + tmpOffsetX + 'px';
					var subLi = ulPositionArray[no]['obj'].getElementsByTagName('LI');
					
					var clonedItemAllreadyAdded = false;
					if(cloneSourceItems && !cloneAllowDuplicates){
						for(var liIndex=0;liIndex<subLi.length;liIndex++)
						{
							if(contentToBeDragged.id == subLi[liIndex].id)clonedItemAllreadyAdded = true;
						}
						if(clonedItemAllreadyAdded)continue;
					}
					
					for(var liIndex=0;liIndex<subLi.length;liIndex++)
					{
						var tmpTop = getTopPosition(subLi[liIndex]);
						if(!indicateDestionationByUseOfArrow)
						{
							if(y<tmpTop)
							{
								destinationObj = subLi[liIndex];
								indicateDestinationBox.style.display='block';
								subLi[liIndex].parentNode.insertBefore(indicateDestinationBox,subLi[liIndex]);
								break;
							}
						}else{							
							if(y<tmpTop
							){
								destinationObj = subLi[liIndex];
								dragDropIndicator.style.top = tmpTop + tmpOffsetY - Math.round(dragDropIndicator.clientHeight/2) + 'px';
								dragDropIndicator.style.display='block';
								break;
							}	
						}					
					}
					
					if(!indicateDestionationByUseOfArrow){
						if(indicateDestinationBox.style.display=='none')
						{
							indicateDestinationBox.style.display='inline';
							ulPositionArray[no]['obj'].appendChild(indicateDestinationBox);
						}
						
					}
					else
					{
						if(subLi.length>0 && dragDropIndicator.style.display=='none')
						{
							dragDropIndicator.style.top = getTopPosition(subLi[subLi.length-1]) + subLi[subLi.length-1].offsetHeight + tmpOffsetY + 'px';
							dragDropIndicator.style.display='inline';
						}
						if(subLi.length==0){
							dragDropIndicator.style.top = ul_topPos + arrow_offsetY + 'px'
							dragDropIndicator.style.display='inline';
						}
					}
					
					if(!destinationObj)destinationObj = ulPositionArray[no]['obj'];
					mouseoverObj = ulPositionArray[no]['obj'].parentNode;
					mouseoverObj.className='mouseover';
					return;
				}
			}
		}
}
	
	/* End dragging 
	Put <LI> into a destination or back to where it came from.
	*/	
	
	
	
	
	
	
	
	
	
function dragDropEnd(e)
{
	
	
	
		if(dragTimer==-1)return;
		if(dragTimer<15)
		{
			dragTimer = -1;
			return;
		}
		
		dragTimer = -1;
		if(document.all)e = event;
		
			EventDragToggle = 0;
			//alert(DateOnHover+' ^ '+EventClickID);
			
			Initiated = 0;
			UpdateDragDrop(contentToBeDragged);
		
		if(cloneSourceItems && (!destinationObj || (destinationObj)))
		{
			contentToBeDragged.parentNode.removeChild(contentToBeDragged);
			
		}
		else
		{	
			
			if(destinationObj)
			{
				if(destinationObj.tagName=='UL'||destinationObj.tagName=='DIV')
				{
					destinationObj.appendChild(contentToBeDragged);
				}
				else
				{
					destinationObj.parentNode.insertBefore(contentToBeDragged,destinationObj);
				}
				mouseoverObj.className='';
				destinationObj = false;
				dragDropIndicator.style.display='none';
				if(indicateDestinationBox)
				{
					indicateDestinationBox.style.display='none';
					document.body.appendChild(indicateDestinationBox);
				}
				contentToBeDragged = false;
				return;
			}		
			if(contentToBeDragged_next)
			{
				contentToBeDragged_src.insertBefore(contentToBeDragged,contentToBeDragged_next);
			}
			else
			{
				contentToBeDragged_src.appendChild(contentToBeDragged);
			}
			
			
		}
		
		
		contentToBeDragged = false;
		dragDropIndicator.style.display='none';
		
		
		if(indicateDestinationBox)
		{
			indicateDestinationBox.style.display='none';
			document.body.appendChild(indicateDestinationBox);
			
		}
		
		
		mouseoverObj = false;
		
		
		
}
	
	
	
	
	
	
	
	
	
	
	
	/* 
	Preparing data to be saved 
	*/
function saveDragDropNodes()
{
	var saveString = "";
	var uls = dragDropMainContainer.getElementsByTagName('UL');
	
	for(var no=0;no<uls.length;no++)
	{	// LOoping through all <ul>
		var lis = uls[no].getElementsByTagName('LI');
		
		for(var no2=0;no2<lis.length;no2++)
		{
			if(saveString.length>0)saveString = saveString + ";";
			saveString = saveString + uls[no].id + '|' + lis[no2].id;
		}	
    }
		
	document.getElementById('saveContent').innerHTML = '<h1>Ready to save these nodes:</h1> ' + saveString.replace(/;/g,';<br>') + '<p>Format: ID of ul |(pipe) ID of li;(semicolon)</p><p>You can put these values into a hidden form fields, post it to the server and explode the submitted value there</p>';
		
}
	









	
	
	
	
	
function initDragDropScript()
	{
		dragContentObj = document.getElementById('dragContent');// The empty Div that will contain the object being moved
		dragDropIndicator = document.getElementById('dragDropIndicator');// The Div that contains the drop indicator image
		dragDropMainContainer = document.getElementById(MainDivContainer);// This is the overal div that contains all objects
		
		document.documentElement.onselectstart = cancelEvent; //function cancelEvent(){ return false;}
		
				
		var listItems = dragDropMainContainer.getElementsByTagName('li');	// Get array containing all <li> in entire div
		var itemHeight = false;
		
		for(var no = 0; no <listItems.length; no++ )//Set Each <li> to be able to drag
		{
			listItems[no].onmousedown = initDrag;
			listItems[no].onselectstart = cancelEvent; //function cancelEvent(){ return false;}
			if(!itemHeight)itemHeight = listItems[no].offsetHeight;
			if(MSIE && navigatorVersion/1<6)
			{
				listItems[no].style.cursor='hand';
			}			
		}
		
		
		

		var mainContainer = document.getElementById(SubDivContainer);// the container with all Right  boxes in it
		var uls = mainContainer.getElementsByTagName('ul');// Get array containing all <ul> in entire mainContainer
		
		itemHeight = itemHeight + verticalSpaceBetweenListItems;
		
		
//vary height of container box
		//for(var no=0;no<uls.length;no++)
		//{
		//	uls[no].style.height = itemHeight * boxSizeArray[no]  + 'px';//var boxSizeArray = [8,8,8,8,8];
		//}
		
		
		
		//var leftContainer = document.getElementById('dhtmlgoodies_listOfItems');
		//var itemBox = leftContainer.getElementsByTagName('UL')[0];
		
		
		
		document.documentElement.onmousemove = moveDragContent;	// Mouse move event - moving draggable div
		document.documentElement.onmouseup = dragDropEnd;	// Mouse move event - moving draggable div
		
		
		
		var ulArray = dragDropMainContainer.getElementsByTagName('UL'); //Get array containing all <ul> in entire Div
		
		for(var no=0; no <ulArray.length; no++) // gets the position of the ul (container)
		{
			ulPositionArray[no] = new Array();
			ulPositionArray[no]['left'] = getLeftPosition(ulArray[no]);	
			ulPositionArray[no]['top'] = getTopPosition(ulArray[no]);	
			ulPositionArray[no]['width'] = ulArray[no].offsetWidth;
			ulPositionArray[no]['height'] = ulArray[no].clientHeight;
			ulPositionArray[no]['obj'] = ulArray[no];
		}
		
		
		if(!indicateDestionationByUseOfArrow)
		{
			indicateDestinationBox = document.createElement('li');
			indicateDestinationBox.id = 'indicateDestination';
			indicateDestinationBox.style.display='none';
			document.body.appendChild(indicateDestinationBox);

		}
}
	
	
	
	
	//window.onload = initDragDropScript;
	
	
