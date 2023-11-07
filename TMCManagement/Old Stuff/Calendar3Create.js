// JavaScript Document


// Main Setup for calendars
var ns6=document.getElementById&&!document.all
var ie4=document.all

var Selected_Month;
var Selected_Year;
var Current_Date = new Date();
var Current_Month = Current_Date.getMonth();

var Days_in_Month = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var Month_Label = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

var Current_Year = Current_Date.getYear();
if (Current_Year < 1000) {Current_Year+=1900}





var Today = Current_Date.getDate();

var Current_Week = Current_Date.getYear();

//Setup Todays Date -----------------------------Todays Date----------------- 
    var atoday = new Date;
    var aDay = atoday.getDate();
	var aMonth =(atoday.getMonth()+1);
	var aYear = atoday.getFullYear();
	if(aDay <=9){aDay = '0'+aDay}
	if(aMonth <=9){aMonth = '0'+aMonth}
	
	var TodayAll = (aMonth+'/'+aDay+'/'+aYear);
	
	
	
//--------------------------------------------------------------------------
	
	

//Event Handlers

function DayClickHandler(ThisDay) {  // When a Day is clicked this is the code invoked
	
	var a = (ThisDay);
    alert(a);    
   
}



function WeekClickHandler(ThisWeek) {  // When a Week is clicked this is the code invoked
	
	var a = (ThisWeek);
    alert(a);
	
	var b = WeekDates(ThisWeek);
	alert (b)
	
}

function PopupDayPlaner(inst,sDate,obj) {  // This Code Shows the Day Planer For a given input date
	
	var month = parseInt(sDate.split("/")[0],10);
	var day = parseInt(sDate.split("/")[1],10);
	var year = parseInt(sDate.split("/")[2],10);
	
	Make_Day(1,year,month,day);
}





//Up3 Updates the three left calendars
function UpdateThree(count,Direction)
{
// Updates additional calendars to sync with the main calendar going forward or back<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	

//alert(count);	
	if (count >0)
	{
		
		
		//this calendar stays the same date as the main------------------------------
    if (count == 2) 
	  {
		  	
		    eval('var sYear'+count+' = Selected_Year;');
			eval('var sMonth'+count+' = Selected_Month;');

      }
		
    //this calendar stays behind one month------------------------------
	if (count == 1)
	 {
		 
		if (Direction == '+')
		{
			eval('var sYear'+count+' = Selected_Year;');
			eval('var sMonth'+count+' = Selected_Month -2;');
			
			if(eval('sMonth'+count+' == 10') || eval('sMonth'+count+' == -2'))
			{
				  if (eval('sMonth'+count+' == 10'))
				  {
					 eval('sMonth'+count+' = 0');
					 eval('sYear'+count+'++');
				  }
				  
				  if (eval('sMonth'+count+' == -2'))
				  {
					 eval('sMonth'+count+' = 11');
					 eval('sYear'+count+'--');
				  }

			}

			else
			{
			 eval('sMonth'+count+'++');
			 
			}
					 
		}
			
//		alert(eval('sMonth'+count)+'--0');
 			
			   
		if (Direction == '-')
			{
				eval('var sYear'+count+' = Selected_Year;');
                eval('var sMonth'+count+' = Selected_Month;');
				
				
				
				  if (eval('sMonth'+count+' == 0'))
				  {
					 eval('sMonth'+count+' =11');
					 eval('sYear'+count+'--');
				  }
				  else
				  {
					 eval('sMonth'+count+'--');
				  }
			}
			
		
	}//if (count == 1)	
			







//this calendar stays one month ahead------------------------------

  if (count == 3)
	  {
		  	
		if (Direction == '+')
		{
			
			eval('var sYear'+count+' = Selected_Year;');
			eval('var sMonth'+count+' = Selected_Month;');
		
			if (eval('sMonth'+count+' == 11'))
			{
			 eval('sMonth'+count+' = 0');
			 eval('sYear'+count+'++');
			}
			else
			{
			 eval('sMonth'+count+'++');
			}	 
		}

			
//		alert(eval('sMonth'+count)+'--0');
 			
			   
		if (Direction == '-')
			{
				eval('var sYear'+count+' = Selected_Year;');
                eval('var sMonth'+count+' = Selected_Month +2;');
				
				if (eval('sMonth'+count+' == 13'))
				  {
					 eval('sMonth'+count+' =0');
					 eval('sYear'+count+'++');
				  }
				  else
				  {
					 eval('sMonth'+count+'--');
				  }
			}

			
	}//if (count == 1)	
			
			
			
			var instance = parseInt(count+1);	
			counter =parseInt(count-1);
			
			
//alert(Direction+'   '+count);
//alert(eval('sMonth'+count)+' ^ '+eval('sYear'+count)+' ^ '+instance+' ^ '+counter);
			
			Make_Calendar(eval('sYear'+count),eval('sMonth'+count),instance,counter,Direction);
			

			
	}//if (count >0)
	

}








//WkNames Gets the day Name of the week based on a date entered---------------------------------

function DayOfWeek(day,month,year) {
    var a = Math.floor((14 - month)/12);
    var y = year - a;
    var m = month + 12*a - 2;
    var d = (day + y + Math.floor(y/4) - Math.floor(y/100) + Math.floor(y/400) + Math.floor((31*m)/12)) % 7;
    return d+1;
}

function displayDay(sDate) {

   var daysArray = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");

   var month = parseInt(sDate.split("/")[0],10);
   var day = parseInt(sDate.split("/")[1],10);
   var year = parseInt(sDate.split("/")[2],10);
   
   return daysArray[parseInt((DayOfWeek(day,month,year))-1)];
}
//----------------------------------------------------------------------------------------------------


//WkNum Gets the Week Number based on a date

function getWeekByDate(month,day,year) { 
    var when = new Date(year,month,day);
    var newYear = new Date(year,0,1);
    var offset = 7 + 1 - newYear.getDay();
    if (offset == 8) offset = 1;
    var daynum = ((Date.UTC(y2k(year),when.getMonth(),when.getDate(),0,0,0) - Date.UTC(y2k(year),0,1,0,0,0)) /1000/60/60/24) + 1;
    var weeknum = Math.floor((daynum-offset+7)/7);
    if (weeknum == 0) {
        year--;
        var prevNewYear = new Date(year,0,1);
        var prevOffset = 7 + 1 - prevNewYear.getDay();
        if (prevOffset == 2 || prevOffset == 8) weeknum = 53; else weeknum = 52;
    }
    return weeknum;
}


//WkDates Returns the whole week dates starting with Sunday for any given input date

function WeekDates(sDate){

	dateArray = sDate.split('/');
	jsDate = new Date(dateArray[2],parseInt(dateArray[0])-1,dateArray[1],0,0,0);
	//alert(jsDate)
	jsDay = jsDate.getDay(); // 0 for sunday
	aDay = 24*60*60*1000;
	startDate = new Date(jsDate.getTime()-(jsDay*aDay));
	
	var WeekD = new Array();
	//WeekD[0] = "0";
	var DayNum = 1;
	
	for (i=0;i<7;i++)
	{
	   WeekD[DayNum] = new Date(startDate.getTime()+(i*aDay)).getDate();
	   DayNum ++;
	}
	return WeekD;

}


//WkDates Returns the week dates, Long and short based on a week number input-----------------------------------------

function y2k(number) { return (number < 1000) ? number + 1900 : number; }



function getWeek(year,month,day) { //
    var when = new Date(year,month,day);
    var newYear = new Date(year,0,1);
    var offset = 7 + 1 - newYear.getDay();
    if (offset == 8) offset = 1;
    var daynum = ((Date.UTC(y2k(year),when.getMonth(),when.getDate(  ),0,0,0) - Date.UTC(y2k(year),0,1,0,0,0)) /1000/60/60/24) + 1;
    var weeknum = Math.floor((daynum-offset+7)/7);
    if (weeknum == 0) {
        year--;
		
        var prevNewYear = new Date(year,0,1);
        var prevOffset = 7 + 1 - prevNewYear.getDay();
        if (prevOffset == 2 || prevOffset == 8) weeknum = 53; else weeknum = 52;
    }
	
	
	
	
	return weeknum;
}






function getWeekDates(w,y)
{
	
	if(w == 53){y = y - 1;}
	
	
	var n = new Date();
	
	if(y)n.setYear(y);
	
	n.setMonth(0);n.setDate(1);n.setDate(n.getDate()-n.getDay());
	
	while( w != getWeek(n.getFullYear(),n.getMonth(),n.getDate()) )n.setDate(n.getDate()+7);
	
	
	
	var WeekD = new Array();
	//WeekD[0] = "0";
	var DayNum = 1;
	WeekD[0] = n.getMonth();
	
	for (i=0;i<7;i++)
	{
	   var Month = (parseInt(n.getMonth())+1);
	   
	   WeekD[DayNum] = Month+"/"+n.getDate()+"/"+n.getFullYear();
	   
	   n.setDate(n.getDate()+1);
	   
	   DayNum ++;
	}
	
	
	WeekD[8] = Month-1;
	

return WeekD;


}





function getWeekDays(w,y)
{
	
	var n = new Date();
	
	if(y)n.setYear(y);
	
	n.setMonth(0);n.setDate(1);n.setDate(n.getDate()-n.getDay()); 
	
	while( w != getWeek(n.getFullYear(),n.getMonth(),n.getDate()) )   n.setDate(n.getDate()+7);
	
	var WeekD = new Array();
	//WeekD[0] = "0";
	var DayNum = 1;
	
	for (i=0;i<7;i++)
	{
	   WeekD[DayNum] = (n.getDate()+0);
	   
	   n.setDate(n.getDate()+1);
	   
	   DayNum ++;
	}
	

return WeekD;
}
//---------------------------------------------------------------------------------------------------------------


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









//Header
function Header(Year, Month) {

   if (Month == 1) {//This sets up february
   Days_in_Month[1] = ((Year % 400 == 0) || ((Year % 4 == 0) && (Year % 100 !=0))) ? 29 : 28;
   }
   var Header_String = Month_Label[Month] + ' ' + Year;
   
   return Header_String;
}




// This Creates the HTML For The Calendar////////////////////////////////////////////////////////////////////////////////////
var CalRows=0;
function Make_Calendar(Year,Month,inst,count,Direction) {
   var First_Date = new Date(Year, Month, 1);
   var Heading = Header(Year, Month);
   var First_Day = First_Date.getDay() + 1;
   
	 
   if(inst == 1){MonthShowing = (parseInt(Month)-0);YearShowing = Year;}//Sets the global variable for current month and year
   

   
   if (((Days_in_Month[Month] == 31) && (First_Day >= 6)) ||  ((Days_in_Month[Month] == 30) && (First_Day == 7)))
	 {var Rows = 6;}
   
	 else if ((Days_in_Month[Month] == 28) && (First_Day == 1))
	 {var Rows = 4;}
   
	 else
	 {var Rows=5;}
   
		//if(CalRows==0){
		CalRows=Rows;//}

		var CalendarDays = 'tdCalendarDay'+CalRows+'rows';
		var CalendarRows = 'tdCalendar'+CalRows+'rows';

		if(inst != 0){

		var sFunction = eval('this.defaults'+inst+'.SelectFunction');
		var sObject = eval('this.defaults'+inst+'.SetObject');
		var Format = eval('this.defaults'+inst+'.Format');
		var threeMoControl = eval('this.defaults'+inst+'.threeMoControl');
		
		var sHead = eval('this.defaults'+inst+'.HeadingText');
		var sTopBar = eval('this.defaults'+inst+'.showControlBar');
		var sDateSelect = eval('this.defaults'+inst+'.showDateSelect');
		var sPrevNext = eval('this.defaults'+inst+'.showPrevNext');
		var sToday = eval('this.defaults'+inst+'.showToday');
		var sWeek = eval('this.defaults'+inst+'.showWeekBtn');
		var sMonth = eval('this.defaults'+inst+'.showMonthBtn');
		var sCreateEvent = eval('this.defaults'+inst+'.showCreateBtn');
		var sClose = eval('this.defaults'+inst+'.showClose');
		var sWeekNums = eval('this.defaults'+inst+'.showWeekNumbers');
		var showStatus = eval('this.defaults'+inst+'.showStatus');
		var TodayText = eval('this.defaults'+inst+'.TodayText');
		
		
		var borderMain = eval('this.defaults'+inst+'.borderMain');
		var borderDays = eval('this.defaults'+inst+'.borderDays');
		var borderWeekNames = eval('this.defaults'+inst+'.borderWeekNames');
		
		
		var colorTopBG = eval('this.defaults'+inst+'.colorTopBG');
		var colorTopOffBG = eval('this.defaults'+inst+'.colorTopOffBG');
		var colorLines = eval('this.defaults'+inst+'.colorLines');
		var colorCalendarBG = eval('this.defaults'+inst+'.colorCalendarBG');
		var colorCalDayHeadersBG = eval('this.defaults'+inst+'.colorCalDayHeadersBG');
		var colorCalHeadersHover = eval('this.defaults'+inst+'.colorCalHeadersHover');
		var colorTodayBG = eval('this.defaults'+inst+'.colorTodayBG');
		var colorTodayTopBG = eval('this.defaults'+inst+'.colorTodayTopBG');
		var colorCalOtherBG = eval('this.defaults'+inst+'.colorCalOtherBG');
		var colorCalOtherTopBG = eval('this.defaults'+inst+'.colorCalOtherTopBG');
		var colorDayMouseOver = eval('this.defaults'+inst+'.colorDayMouseOver');
		var colorToDayMouseOver = eval('this.defaults'+inst+'.colorToDayMouseOver');
		
		
				
		var fontHead = eval('this.defaults'+inst+'.fontHead');
		var colorHead = eval('this.defaults'+inst+'.colorHead');
		var sizeHead = eval('this.defaults'+inst+'.sizeHead');
		var fontHead = eval('this.defaults'+inst+'.fontHead');
		var weightHead = eval('this.defaults'+inst+'.weightHead');
		var colorHeadBG = eval('this.defaults'+inst+'.colorHeadBG');
		var TextAlign = eval('this.defaults'+inst+'.TextAlign');
		
		
		var fontMonthYear = eval('this.defaults'+inst+'.fontMonthYear');
		var colorMonthYear = eval('this.defaults'+inst+'.colorMonthYear');
		var hoverMonthYear = eval('this.defaults'+inst+'.hoverMonthYear');
		var sizeMonthYear = eval('this.defaults'+inst+'.sizeMonthYear');
		var weightMonthYear = eval('this.defaults'+inst+'.weightMonthYear');
		
		
		var fontButton = eval('this.defaults'+inst+'.fontButton');
		var colorButton = eval('this.defaults'+inst+'.colorButton');
		var sizeButton = eval('this.defaults'+inst+'.sizeButton');
		var weightButton = eval('this.defaults'+inst+'.weightButton');
		var heightButton = eval('this.defaults'+inst+'.heightButton');
		
		
		var fontPicker = eval('this.defaults'+inst+'.fontPicker');
		var colorPicker = eval('this.defaults'+inst+'.colorPicker');
		var sizePicker = eval('this.defaults'+inst+'.sizePicker');
		var weightPicker = eval('this.defaults'+inst+'.weightPicker');
		var heightPicker = eval('this.defaults'+inst+'.heightPicker');
		
		
		var sizeWeekNames = eval('this.defaults'+inst+'.sizeWeekNames');
		var fontWeekNames = eval('this.defaults'+inst+'.fontWeekNames');
		var colorWeekNames = eval('this.defaults'+inst+'.colorWeekNames');
		var colorWeekNamesBG = eval('this.defaults'+inst+'.colorWeekNamesBG');
		var weightWeekNames = eval('this.defaults'+inst+'.weightWeekNames');
		var typeWeekNames = eval('this.defaults'+inst+'.typeWeekNames');
		
		
		var sizeWeekNums = eval('this.defaults'+inst+'.sizeWeekNums');
		var fontWeekNums = eval('this.defaults'+inst+'.fontWeekNums');
		var colorWeekNums = eval('this.defaults'+inst+'.colorWeekNums');
		var colorWeekNumsBG = eval('this.defaults'+inst+'.colorWeekNumsBG');
		var colorWeekNumsHover = eval('this.defaults'+inst+'.colorWeekNumsHover');
		var weightWeekNums = eval('this.defaults'+inst+'.weightWeekNums');
		

		
		var sizeDayNums = eval('this.defaults'+inst+'.sizeDayNums');
		var fontDayNums = eval('this.defaults'+inst+'.fontDayNums');
		var colorDayNums = eval('this.defaults'+inst+'.colorDayNums');
		var weightDayNums = eval('this.defaults'+inst+'.weightDayNums');
		
    }

	
	
		
		
	    var HTML_String = '<div class="CalendarMainDIV" style="">';
					
					
		if(sHead !='')
		{
			HTML_String += '<div style="background:'+colorHeadBG+'; color:'+colorHead+'; font-family:'+fontHead+'; font-size:'+sizeHead+';';
			HTML_String += 'font-weight:'+weightHead+'; text-align:'+TextAlign+'; "onMouseOver="hideToolTip()" class="Topheader">'+sHead;
			HTML_String += 	'<button id="ReloadFrame" onClick="window.location=window.location"><img src="images/reloadblue24.png" width="100%" height="100%"/></button>';
			HTML_String += '</div>';
		}


		var PopupID = ('Popup'+inst); 

if (sTopBar == true)
 {				
	 
	 	HTML_String += '<div style="background:'+colorTopBG+';"    class ="TopControl"  onMouseOver="hideToolTip()">';
//color:'+colorButton+'; font-family:'+fontButton+'; font-size:'+sizeButton+'; font-weight:'+weightButton+' 					
 
 
			if (sPrevNext == true)
			{	
				HTML_String+='<div class ="PrevDiv">';
				HTML_String+='<button class="buttonPrev" onclick="Skip(&#39-&#39,'+inst+')"';
				HTML_String+='style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
				HTML_String+='&#60&#60</button>';
				HTML_String+='</div>';
		 
				HTML_String+='<div class ="NextDiv">';
				HTML_String+='<button class="buttonNext" onclick="Skip(&#39+&#39,'+inst+')"';
				HTML_String+='style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
				HTML_String+='&#62&#62</button>';
				HTML_String+='</div>';
			}
			 if (sToday == true)
             {
					HTML_String += '<div class ="TodayDiv">';
					HTML_String += '<button class="buttonToday" onclick="GoToToday('+inst+')"';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += TodayText+'</button>';
					HTML_String += '</div>';
			 }
					
							 
					HTML_String += '<div class ="DateHeadDIV">';
					HTML_String += '<div id="DateHead" class="DateHead" onclick="GoToDateMonth(1,'+Year+','+Month+');"';
					HTML_String += 'onMouseover="this.style.color=&#39'+hoverMonthYear+'&#39" onmouseout="this.style.color=&#39'+colorMonthYear+'&#39"'; 
					HTML_String += 'style="color:'+colorMonthYear+'; font-family:'+fontMonthYear+'; font-size:'+sizeMonthYear+'; font-weight:'+weightMonthYear+';">'+Heading+'</div>';
					HTML_String += '</div>';
					
					
			
			 if (sClose == true)
             {
					HTML_String += '<div class ="EventDiv">';
					HTML_String += '<button class="buttonEvent" onclick="hidePopup(&#39'+PopupID+'&#39)"';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += 'X</button>';
					HTML_String += '</div>';
			 }
			
			
			
					
			if (sDateSelect == true){
				
					HTML_String += '<div class ="GetDateBtnDiv">';
					HTML_String += '<button class="GetDateBtn" onclick="DateSelect('+inst+')"';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += ' Go </button>';
					HTML_String += '</div>';
					
					HTML_String += '<div id="SelectDate" class="SelectDate">';
					
					 HTML_String += '<select id="monthSelect'+inst+'" name="monthSelect"';
					 HTML_String += 'style="color:'+colorPicker+';  font-family:'+fontPicker+';  font-size:'+sizePicker+';  font-weight:'+weightPicker+'; height:'+heightPicker+';">';
						HTML_String += '<option value="1">January</option>';
						HTML_String += '<option value="2">February</option>';
						HTML_String += '<option value="3">March</option>';
						HTML_String += '<option value="4">April</option>';
						HTML_String += '<option value="5">May</option>';
						HTML_String += '<option value="6">June</option>';
						HTML_String += '<option value="7">July</option>';
						HTML_String += '<option value="8">August</option>';
						HTML_String += '<option value="9">September</option>';
						HTML_String += '<option value="10">October</option>';
						HTML_String += '<option value="11">November</option>';
						HTML_String += '<option value="12">December</option>';
						HTML_String += '<option value="Month" selected="selected">Month</option>';
					 HTML_String += '</select>';
					 
					 HTML_String += '<select id="yearSelect'+inst+'" name="yearSelect"';
					 HTML_String += 'style="color:'+colorPicker+';  font-family:'+fontPicker+';  font-size:'+sizePicker+';  font-weight:'+weightPicker+'; height:'+heightPicker+';">';
					    HTML_String += '<option value="2000">2000</option>';
						HTML_String += '<option value="2001">2001</option>';
						HTML_String += '<option value="2002">2002</option>';
						HTML_String += '<option value="2003">2003</option>';
						HTML_String += '<option value="2004">2004</option>';
						HTML_String += '<option value="2005">2005</option>';
						HTML_String += '<option value="2006">2006</option>';
						HTML_String += '<option value="2007">2007</option>';
						HTML_String += '<option value="2008">2008</option>';
						HTML_String += '<option value="2009">2009</option>';
						HTML_String += '<option value="2010">2010</option>';
						HTML_String += '<option value="2011">2011</option>';
						HTML_String += '<option value="2012">2012</option>';
						HTML_String += '<option value="2013">2013</option>';
						HTML_String += '<option value="2014">2014</option>';
						HTML_String += '<option value="2015">2015</option>';
						HTML_String += '<option value="2016">2016</option>';
						HTML_String += '<option value="2017">2017</option>';
						HTML_String += '<option value="2018">2018</option>';
						HTML_String += '<option value="Year" selected="selected">Year</option>';
					 HTML_String += '</select>';
					  
					HTML_String += '</div>';
					
				}
				
		if (sCreateEvent == true)
             {
				    HTML_String += '<div class ="EventDiv">';
					/*
					HTML_String += '<button id="btnEvent"  class="buttonEvent" onclick="ShowEventModal(&#39NewEvent&#39,'+inst+',&#39 '+TodayAll+' &#39)" ';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += 'Event</button>';
					*/
					HTML_String += '</div>';
			 }
		if (sMonth == true)
             {
					HTML_String += '<div class ="MonthDiv">';
					HTML_String += '<button class="buttonMonth" onclick=""';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += 'Mo</button>';
					HTML_String += '</div>';
			 }
		if (sWeek== true)
             {			 
					HTML_String += '<div class ="WeekDiv">';
					HTML_String += '<button class="buttonWeek" onclick=""';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += 'Wk</button>';
					HTML_String += '</div>';
			 }
		if (showStatus== true)
             {			 
			 		HTML_String += '<div id="StatusLine" class ="Status">';
					HTML_String += '</div>';
			 }
	HTML_String += ' </div>';

 }
 else
 {
		
	 HTML_String += '<div class="DateHeadSolo"';
	 HTML_String += 'style="background:'+colorTopOffBG+'; color:'+colorMonthYear+'; font-family:'+fontMonthYear+'; font-size:'+sizeMonthYear+'; font-weight:'+weightMonthYear+';">'+Heading+'</div>';
 }
 
 
// Sets up the week numbers down the side   
	var gDay = (1);
	var gMonth = (Month);
	var gYear = (Year);
	var WeekNum = (getWeekByDate(gMonth,gDay,gYear));
	
	
	
// Sets up the previous and next months days, included in this month

    var iYear = parseInt(Year);
	var NextYear = (iYear+1);
	var LastYear = (iYear-1);
		
    if(gMonth !=11){var Next_Month = (gMonth +2);}    else{var Next_Month = (1);}//determines if the next months days are in the next year
    if(gMonth !=11){var Next_Year = (Year);}    else{var Next_Year = (NextYear);}
	
    if(gMonth !=0){var Prev_Month = (gMonth);}    else{var Prev_Month = (12);}//determines if the next months days are int the next year
    if(gMonth !=0){var Last_Year = (Year);}    else{var Last_Year = (LastYear);}
	

	
	if(gMonth !=0){var Prev_DaysInMonth = Days_in_Month[gMonth -1];} else {var Prev_DaysInMonth = 31;}//Tells you how many days are in the Last month
	var Next_DaysInMonth = Days_in_Month[Next_Month];//Tells you how many days are in the Next month
	
	
	var PrevLastDays =(Prev_DaysInMonth - First_Day +2); //Gets the first number of the last mo starting this mos calendar
	
	



	
	if(Format == 'Calendar'){HTML_String += '<table class="tableMain" style="border:'+borderMain+';" border="0" cellpadding="0" cellspacing="0" >';}
	if(Format == 'Popup'){HTML_String += '<table class="tableMainPopup" style="border:'+borderMain+';" border="0" cellpadding="0" cellspacing="0" >';}
	
	
	
	
	


    HTML_String += '<div class="trWeekdayNames" style="height:3%; min-height:3%; border:'+borderWeekNames+'; background:'+colorWeekNamesBG+';';
	HTML_String += 'color:'+colorWeekNames+'; font-family:'+fontWeekNames+'; font-size:'+sizeWeekNames+'; font-weight:bold;">';
	if(sWeekNums == true){HTML_String += '<div class="WeekNumHeader WK" >WK</div>';}
	
	
	if(typeWeekNames == 'short')
	{
	HTML_String += ' <div class="WeekDayHeader">S</div>   <div class="WeekDayHeader">M</div>    <div class="WeekDayHeader">T</div>';
	HTML_String += ' <div class="WeekDayHeader">W</div>   <div class="WeekDayHeader">T</div>   ';
	HTML_String += ' <div class="WeekDayHeader">F</div>   <div class="WeekDayHeader" >S</div>     </div>';
	}


	if(typeWeekNames == 'medium')
	{
	HTML_String += ' <div class="WeekDayHeader">Sun</div>   <div class="WeekDayHeader">Mon</div>    <div class="WeekDayHeader">Tue</div>';
	HTML_String += ' <div class="WeekDayHeader">Wed</div>   <div class="WeekDayHeader">Thu</div>   ';
	HTML_String += ' <div class="WeekDayHeader">Fri</div>     <div class="WeekDayHeader" >Sat</div>     </div>';
	}

	if(typeWeekNames == 'long')
	{
	HTML_String += ' <div class="WeekDayHeader">Sunday</div>   <div class="WeekDayHeader">Monday</div>    <div class="WeekDayHeader">Tuesday</div>';
	HTML_String += ' <div class="WeekDayHeader">Wednesday</div>   <div class="WeekDayHeader">Thursday</div>   ';
	HTML_String += ' <div class="WeekDayHeader">Friday</div>     <div class="WeekDayHeader" >Saturday</div>     </div>';
	}



	var Last_Days = 1;
	var Day_Counter = 1;
	var Loop_Counter = 1;
	var Loop_Week = WeekNum;
    var RowNum = 1;
	var ColNum = 1;
	var DayArrayCount = 1;

    DayArray = new Array();



if (Format == 'Calendar')//Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---
{
	for (var j = 1; j <= Rows; j++)
	{
	  var DateAllWk = (Month+1+'/' +Day_Counter+'/'+Year); // Creates the whole date for each day
   
		HTML_String += '<div valign="top" class="'+CalendarRows+'">';
		
		var WeekFix=0;
		if(Year>2009&&Year<2013){WeekFix=-1;}
		if(sWeekNums == true) // Draws the week Numbers down the side
		{
			HTML_String += '<div class="tdWeek"';
			HTML_String += 'style=" border:'+borderDays+'; border-top:none; background:'+colorWeekNumsBG+'; color:'+colorWeekNums+'; font-family:'+fontWeekNums+';';
			HTML_String += 'font-size:'+sizeWeekNums+'; font-weight:'+weightWeekNums+' " onclick="Make_Week('+inst+','+Year+','+(Loop_Week+WeekFix)+')"';
			HTML_String += 'onMouseover="this.style.backgroundColor=&#39'+colorWeekNumsHover+'&#39" ';
			HTML_String += 'onmouseout="this.style.backgroundColor=&#39'+colorWeekNumsBG+'&#39" >';
			HTML_String += Loop_Week+'</div>';
		}

		for (var i = 1; i < 8; i++)
		{
			// The following sets up all the date variables for this month, next month, and last month
			var DateAll; 
			var lastMonth;
			var nextMonth;
			var lastYear;
			var nextYear;
			var DateAllLast;
			var nextYear;
			
			DateAll = (Month+1+'/' +Day_Counter+'/'+Year);
			Year = (parseInt(Year));
			var thisMonth = parseInt(Month+1)
			
			if(Month == 0){lastMonth = 12;}else{lastMonth = parseInt(Month);}
			if(Month == 11){nextMonth = 1;}else{nextMonth = parseInt(Month+2);}
			if(Month == 0){lastYear = parseInt(Year-1);}else{lastYear = Year;}
			if(Month == 11){nextYear = parseInt(Year+1);}else{nextYear = Year;}
			if(Month == 0){DateAllLast =(lastMonth+'/' +PrevLastDays+'/'+lastYear);}else{DateAllLast = (Month+'/' +PrevLastDays+'/'+Year);}
			if(Month == 11){DateAllNext =(nextMonth+'/' +Last_Days+'/'+nextYear);}else{DateAllNext = (parseInt(Month+2)+'/' +Last_Days+'/'+Year);
		}
		//------------------------------------------------------------------------------------//
		
	  var DayWidth;
		if(IEver==7){/*DayWidth='100%'*/}
		//else{DayWidth=(document.getElementById('CalendarMainContainer').offsetWidth/7.2);}
		/*else{DayWidth=(document.getElementById('CalendarMainContainer').offsetWidth*7.2);}
		if(DayWidth<1){DayWidth=Math.abs(DayWidth)}
		if(DayWidth<1){DayWidth=(1/DayWidth)}
		DayWidth+='px';
		*/
		DayWidth='100%';
		
		//alert(DayWidth);
		if ((Loop_Counter >= First_Day) && (Day_Counter <= Days_in_Month[Month])) {
		
			if ((Day_Counter == Today) && (Year == Current_Year) && (Month == Current_Month)) {// If this is today
		
				 HTML_String += '<div  class="'+CalendarDays+'" style=" max-width:'+DayWidth+';border:'+borderDays+'; border-top:none; border-bottom:none;" >';
		
				 HTML_String += '<div id="TodayHeader" class="DayHeaderTodayDiv" onclick="Make_Day('+inst+','+Year+','+thisMonth+','+Day_Counter+')"';
				 HTML_String += 'onMouseover="this.style.backgroundColor=&#39'+colorCalHeadersHover+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorTodayTopBG+'&#39"';
				 HTML_String += 'style=" max-width:'+DayWidth+';background:'+colorTodayTopBG+';color:'+colorDayNums+'; font-family:'+fontDayNums+';font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+';">';
				 
				 HTML_String += '<div class="DayNumber" >';
				 HTML_String += Day_Counter + '</div>';
				 HTML_String += '</div>';
				 
				 HTML_String += '<div id="MonthDay_'+DateAll+'" class="DayContainerTodayDIV">';
				 
				 var DayContainerDate = DateAll;
				 DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
				 DayContainerDate='Day'+DayContainerDate;
				 
				 
				 HTML_String += '<div id="'+DayContainerDate+'"class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+'; background:'+colorTodayBG+'; color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+'; "';
				 //HTML_String += 'onclick="ShowEventModal(&#39Month&#39,'+inst+',&#39 '+DateAll+' &#39,'+Day_Counter+');"';
				 HTML_String += 'onMouseover="HoverUpdate(&#39 '+DateAll+' &#39);  this.style.backgroundColor=&#39'+colorToDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorTodayBG+'&#39" >';
				 HTML_String += '</div>';
				 
				 HTML_String += '</div></div>';
				 
				 DayArray[DayArrayCount] = DateAll;
				 DayArrayCount ++
				 
			}
			else {// All the other days 
		
				 
				 HTML_String += '<div  class="'+CalendarDays+'" style=" max-width:'+DayWidth+';border:'+borderDays+'; border-top:none; border-bottom:none;" >';
				 
				 HTML_String += '<div id="DayHeader" class="DayHeaderDiv"  onclick="Make_Day('+inst+','+Year+','+thisMonth+','+Day_Counter+')"';
				 HTML_String += 'onMouseover="this.style.backgroundColor=&#39'+colorCalHeadersHover+'&#39;" onmouseout="this.style.backgroundColor=&#39'+colorCalDayHeadersBG+'&#39"';
				 HTML_String += 'style=" max-width:'+DayWidth+';background:'+colorCalDayHeadersBG+';color:'+colorDayNums+'; font-family:'+fontDayNums+';font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+';">';
				 HTML_String += '<div class="DayNumber">';
				 HTML_String += Day_Counter + '</div>';
				 HTML_String += '</div>';
				 
				 HTML_String += '<div id="MonthDay_'+DateAll+'" class="DayContainerDIV">';
		
				 var DayContainerDate = DateAll;
				 DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
				 DayContainerDate='Day'+DayContainerDate;
				 HTML_String += '<div id="'+DayContainerDate+'" class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+'; background:'+colorCalendarBG+'; color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+'; "';
				 //HTML_String += 'onclick="ShowEventModal(&#39Month&#39,'+inst+',&#39 '+DateAll+' &#39,'+Day_Counter+');"';
				 HTML_String += 'onMouseover="HoverUpdate(&#39 '+DateAll+' &#39);  this.style.backgroundColor=&#39'+colorDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalendarBG+'&#39" >';
				 HTML_String += '</div>';
				 HTML_String += '</div></div>';
				 
				 DayArray[DayArrayCount] = DateAll;
				 DayArrayCount ++
		}
					Day_Counter++;
			
			
													                                       //Calendar---Calendar---Calendar---Calendar---Calendar---	
			    
			 }
		 
	 else{
		 
				 if (Loop_Counter < First_Day){// Days not in this month, First of the month
			    

				
				 HTML_String += '<div  class="'+CalendarDays+'" style="border:'+borderDays+'; border-top:none; border-bottom:none;" >';
			   
			   HTML_String += '<div id="DayOtherHeader" class="DayHeaderDiv" onclick="Make_Day('+inst+','+lastYear+','+lastMonth+','+PrevLastDays+')"';
			   HTML_String += 'onMouseover="this.style.backgroundColor=&#39'+colorCalHeadersHover+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalOtherTopBG+'&#39"';
			   HTML_String += 'style=" max-width:'+DayWidth+';background:'+colorCalOtherTopBG+';color:'+colorDayNums+'; font-family:'+fontDayNums+';font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+';">';
			   HTML_String += '<div class="DayNumber" >';
			   HTML_String += PrevLastDays+ '</div>';
			   HTML_String += '</div>';
			   
			   HTML_String += '<div id="MonthDay_'+DateAllLast+'" class="DayContainerOtherDIV">';

			   var DayContainerDate = DateAllLast;
			   DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
			   DayContainerDate='Day'+DayContainerDate;
			   HTML_String += '<div id="'+DayContainerDate+'"  class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+'; background:'+colorCalOtherBG+'; color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+'; "';
			   //HTML_String += 'onclick="ShowEventModal(&#39Month&#39,'+inst+',&#39 '+DateAllLast+' &#39,'+Day_Counter+');"';
			   HTML_String += 'onMouseover="HoverUpdate(&#39 '+DateAllLast+' &#39); this.style.backgroundColor=&#39'+colorDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalOtherBG+'&#39" >';
			   HTML_String += '</div>';
			   HTML_String += '</div></div>';
			   
			   DayArray[DayArrayCount] = DateAllLast;
			   DayArrayCount ++

			   PrevLastDays++;
				
			 }
			 if (Day_Counter >Days_in_Month[Month]) {// Days not in this month Last of the Month
			 
            				
				 HTML_String += '<div  class="'+CalendarDays+'" style="max-width:'+DayWidth+'; border:'+borderDays+'; border-top:none; border-bottom:none;" >';
			   
			   HTML_String += '<div id="DayOtherHeader" class="DayHeaderDiv" onclick="Make_Day('+inst+','+nextYear+','+nextMonth+','+Last_Days+')"';
			   HTML_String += 'onMouseover="this.style.backgroundColor=&#39'+colorCalHeadersHover+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalOtherTopBG+'&#39"';
			   HTML_String += 'style="max-width:'+DayWidth+'; background:'+colorCalOtherTopBG+';color:'+colorDayNums+'; font-family:'+fontDayNums+';font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+';">';
			   HTML_String += '<div class="DayNumber" >';
			   HTML_String += Last_Days+ '</div>';
			   HTML_String += '</div>';
			   
			   HTML_String += '<div id="MonthDay_'+DateAllNext+'" class="DayContainerOtherDIV">';

			   var DayContainerDate = DateAllNext;
			   DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
			   DayContainerDate='Day'+DayContainerDate;
			   HTML_String += '<div id="'+DayContainerDate+'"  class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+';  background:'+colorCalOtherBG+'; color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+'; "';
			   //HTML_String += 'onclick="ShowEventModal(&#39Month&#39,'+inst+',&#39 '+DateAllNext+' &#39,'+Day_Counter+');"';
			   HTML_String += 'onMouseover="HoverUpdate(&#39 '+DateAllNext+' &#39); this.style.backgroundColor=&#39'+colorDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalOtherBG+'&#39" >';
			   HTML_String += '</div>';
			   HTML_String += '</div></div>';
			   
			   DayArray[DayArrayCount] = DateAllNext;
			   DayArrayCount ++
				
			   Last_Days++;
			   
			 }
		 
		 }
		 
		 
		 ColNum++;
         Loop_Counter++;
      }
      HTML_String += '</div>';
	  
	  if(Loop_Week == 52){Loop_Week = 1}else{Loop_Week++;}
	  
	  
	  ColNum = 1;
	  RowNum++;
   }
   
	MonthShowing = Month;
	YearShowing = Year;
	ViewShowing = 'Month';
	
 	
	offsetX = +20;
	offsetY = -20;
	//if(offsetY == 0){offsetY = 20;}else{offsetY = 20}; 
   
	GetTaskList();
	
	if(inst=1){CalCreated=true;}
	CalendarEventsAJAX(DayArray); //Fills out the day events
}









if (Format == 'Popup')//Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---
{
   for (var j = 1; j <= Rows; j++) {
	   
	  var DateAllWk = (Month+1+'/' +Day_Counter+'/'+Year); // Creates the whole date for each day
   
			  HTML_String += '<tr>';
			  
			  if(sWeekNums == true) // Draws the week Numbers down the side
			  {
				  HTML_String += '<div class="tdWeek"';
				  HTML_String += 'style=" border:'+borderDays+'; background:'+colorWeekNumsBG+'; color:'+colorWeekNums+'; font-family:'+fontWeekNums+';';
				  HTML_String += 'font-size:'+sizeWeekNums+'; font-weight:'+weightWeekNums+' " onclick="Make_Week(1,'+Year+','+Loop_Week+')"';
				  HTML_String += 'onMouseover="this.style.backgroundColor=&#39'+colorWeekNumsHover+'&#39" ';
				  HTML_String += 'onmouseout="this.style.backgroundColor=&#39'+colorWeekNumsBG+'&#39" >';
				  HTML_String += Loop_Week+'</div>';
			  }
	  
	  
      for (var i = 1; i < 8; i++) {
		  
		  
	    // The following sets up all the date variables for this month, next month, and last month

		DateAll = (Month+1+'/' +Day_Counter+'/'+Year);
		Year = (parseInt(Year));
		var thisMonth = parseInt(Month+1)
		
		if(Month == 0){lastMonth = 12;}else{lastMonth = parseInt(Month);}
		if(Month == 11){nextMonth = 1;}else{nextMonth = parseInt(Month+2);}
		if(Month == 0){lastYear = parseInt(Year-1);}else{lastYear = Year;}
		if(Month == 11){nextYear = parseInt(Year+1);}else{nextYear = Year;}
		if(Month == 0){DateAllLast =(lastMonth+'/' +PrevLastDays+'/'+lastYear);}else{DateAllLast = (Month+'/' +PrevLastDays+'/'+Year);}
		if(Month == 0){DateAllNext =(nextMonth+'/' +Last_Days+'/'+nextYear);}else{DateAllNext = (parseInt(Month+2)+'/' +Last_Days+'/'+Year);}		 
		 
		 
	  
         if ((Loop_Counter >= First_Day) && (Day_Counter <= Days_in_Month[Month])) {
		 
            if ((Day_Counter == Today) && (Year == Current_Year) && (Month == Current_Month)) {// If this is today
			
               HTML_String += '<td  class="tdCalendarDayPopup" style=" font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+';  border:'+borderDays+';" ';
			   HTML_String += 'id="MonthDay_'+DateAll+'"onclick="'+sFunction+'('+inst+',&#39 '+DateAll+' &#39,&#39'+sObject+'&#39)"';
			   HTML_String += 'onmouseover="this.style.backgroundColor=&#39'+colorToDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorTodayBG+'&#39"';
			   HTML_String += 'style="background:'+colorTodayBG+'; color:'+colorDayNums+';">';
			   HTML_String += Day_Counter + '</td>';
			   
            }
            else {// All the other days 
               HTML_String += '<td  class="tdCalendarDayPopup" style=" font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+'; border:'+borderDays+';"';
			   HTML_String += 'id="MonthDay_'+DateAll+'" onclick="'+sFunction+'('+inst+',&#39 '+DateAll+' &#39,&#39'+sObject+'&#39)"';
			   HTML_String += 'onmouseover="this.style.backgroundColor=&#39'+colorDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalendarBG+'&#39"';
			   HTML_String += 'style="background:'+colorCalendarBG+'; color:'+colorDayNums+';">';
			   HTML_String += Day_Counter + '</td>';
            }
            Day_Counter++;
			
			
																											//Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---
			    
         }
		 
		 else{
		 
			 if (Loop_Counter < First_Day){// Days not in this month First of the month
			    			 
			 
				HTML_String += '<td  class="tdCalendarDayPopup" style=" font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+';  border:'+borderDays+';"';
				HTML_String += 'id="MonthDay_'+DateAllLast+'" onclick="'+sFunction+'('+inst+',&#39 '+DateAllLast+' &#39,&#39'+sObject+'&#39)" class="DayContainerOtherDIV"';
				HTML_String += 'onmouseover="this.style.backgroundColor=&#39'+colorDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalOtherBG+'&#39"';
				HTML_String += 'style="background:'+colorCalOtherBG+'; color:'+colorDayNums+';">';
				HTML_String += PrevLastDays+'</td>';
				
				PrevLastDays++;
				
			 }
			 if (Day_Counter >Days_in_Month[Month]) {// Days not in this month Last of the Month
			 
			 				 	
			    HTML_String += '<td  class="tdCalendarDayPopup" style=" font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+'; border:'+borderDays+';" ';
				HTML_String += 'id="MonthDay_'+DateAllNext+'" onclick="'+sFunction+'('+inst+',&#39 '+DateAllNext+' &#39,&#39'+sObject+'&#39)" class="DayContainerOtherDIV"';
				HTML_String += 'onmouseover="this.style.backgroundColor=&#39'+colorDayMouseOver+'&#39" onmouseout="this.style.backgroundColor=&#39'+colorCalOtherBG+'&#39"';
				HTML_String += 'style="background:'+colorCalOtherBG+'; color:'+colorDayNums+';">';
				HTML_String += Last_Days+'</td>';
				
				Last_Days++;
			 }
		 
		 }
		 
		 
		 
         Loop_Counter++;
      }
      HTML_String += '</tr>';
	  Loop_Week++;
   }
   
}//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   HTML_String += '</table>';
   HTML_String += ' </div>';



//Writes the HTML to the div    
document.getElementById('Calendar'+inst).innerHTML = HTML_String;



// Updates additional calendars to sync with the main calendar going forward or back<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if(threeMoControl == true){UpdateThree(count,Direction);}




// Sets up the Current Month, Year in the Dropdowns
//Year = (Year.substr(3)); 
//document.getElementById('monthSelect').options[Month].selected = true;
//document.getElementById('yearSelect').options[Year].selected = true;

   

   
   
}

// END Main Calendar //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//WkCal This Creates the HTML For The Calendar Week///////////////////////////////////////////////////////////////////////////////////////////////

function Make_Week(inst,Year,Week) {
	
//Setup Todays Date   
	var today = new Date;
	var Day = today.getDate();
	var Month =(today.getMonth()+1);
	var nYear = today.getFullYear();
	var todayAll = (Month+'/'+Day+'/'+Year);

		    
//Date Header Setup---------------------------------------------------------------
	Week = (parseInt(Week)+1);
	var WeekFullDates = getWeekDates(Week,Year);
	var WeekDayNumbers = getWeekDays(Week,Year);	 
	//alert(Week+''+WeekFullDates[0]+''+Year+' '+WeekFullDates+WeekDayNumbers);
	
	
	//alert(Week);
	//alert(WeekDayNumbers);
	//alert(WeekFullDates);
	
	var Month1 = parseInt(WeekFullDates[0]);
	var Month2 = parseInt(WeekFullDates[8]);
	var CurrentMonth = (parseInt(WeekFullDates[0])+1);
	
	
	
	HeaderDate = Month_Label[Month1]+'  '+Year;
	if(Month1 != Month2){HeaderDate += ' / '+Month_Label[Month2];}
//---------


	var sFunction = eval('this.defaults'+inst+'.SelectFunction');
	var sObject = eval('this.defaults'+inst+'.SetObject');
	var Format = eval('this.defaults'+inst+'.Format');
	var threeMoControl = eval('this.defaults'+inst+'.threeMoControl');
	
	var sHead = eval('this.defaults'+inst+'.HeadingText');
	var sTopBar = eval('this.defaults'+inst+'.showControlBar');
	var sDateSelect = eval('this.defaults'+inst+'.showDateSelect');
	var sPrevNext = eval('this.defaults'+inst+'.showPrevNext');
	var sToday = eval('this.defaults'+inst+'.showToday');
	var sWeek = eval('this.defaults'+inst+'.showWeekBtn');
	var sMonth = eval('this.defaults'+inst+'.showMonthBtn');
	var sCreateEvent = eval('this.defaults'+inst+'.showCreateBtn');
	var sClose = eval('this.defaults'+inst+'.showClose');
	var sWeekNums = eval('this.defaults'+inst+'.showWeekNumbers');
	var TodayText = eval('this.defaults'+inst+'.TodayText');
	
	
	var borderMain = eval('this.defaults'+inst+'.borderMain');
	var borderDays = eval('this.defaults'+inst+'.borderDays');
	var borderWeekNames = eval('this.defaults'+inst+'.borderWeekNames');
	
	
	var colorTopBG = eval('this.defaults'+inst+'.colorTopBG');
	var colorTopOffBG = eval('this.defaults'+inst+'.colorTopOffBG');
	var colorLines = eval('this.defaults'+inst+'.colorLines');
	var colorCalendarBG = eval('this.defaults'+inst+'.colorCalendarBG');
	var colorCalDayHeadersBG = eval('this.defaults'+inst+'.colorCalDayHeadersBG');
	var colorTodayBG = eval('this.defaults'+inst+'.colorTodayBG');
	var colorTodayTopBG = eval('this.defaults'+inst+'.colorTodayTopBG');
	var colorCalOtherBG = eval('this.defaults'+inst+'.colorCalOtherBG');
	var colorCalOtherTopBG = eval('this.defaults'+inst+'.colorCalOtherTopBG');
	var colorDayMouseOver = eval('this.defaults'+inst+'.colorDayMouseOver');
	var colorToDayMouseOver = eval('this.defaults'+inst+'.colorToDayMouseOver');
	
	
			
	var fontHead = eval('this.defaults'+inst+'.fontHead');
	var colorHead = eval('this.defaults'+inst+'.colorHead');
	var sizeHead = eval('this.defaults'+inst+'.sizeHead');
	var fontHead = eval('this.defaults'+inst+'.fontHead');
	var weightHead = eval('this.defaults'+inst+'.weightHead');
	var colorHeadBG = eval('this.defaults'+inst+'.colorHeadBG');
	var TextAlign = eval('this.defaults'+inst+'.TextAlign');
	
	
	var fontMonthYear = eval('this.defaults'+inst+'.fontMonthYear');
	var colorMonthYear = eval('this.defaults'+inst+'.colorMonthYear');
	var sizeMonthYear = eval('this.defaults'+inst+'.sizeMonthYear');
	var weightMonthYear = eval('this.defaults'+inst+'.weightMonthYear');
	
	
	var fontButton = eval('this.defaults'+inst+'.fontButton');
	var colorButton = eval('this.defaults'+inst+'.colorButton');
	var sizeButton = eval('this.defaults'+inst+'.sizeButton');
	var weightButton = eval('this.defaults'+inst+'.weightButton');
	var heightButton = eval('this.defaults'+inst+'.heightButton');
	
	
	var fontPicker = eval('this.defaults'+inst+'.fontPicker');
	var colorPicker = eval('this.defaults'+inst+'.colorPicker');
	var sizePicker = eval('this.defaults'+inst+'.sizePicker');
	var weightPicker = eval('this.defaults'+inst+'.weightPicker');
	var heightPicker = eval('this.defaults'+inst+'.heightPicker');
	
	
	var sizeWeekNames = eval('this.defaults'+inst+'.sizeWeekNames');
	var fontWeekNames = eval('this.defaults'+inst+'.fontWeekNames');
	var colorWeekNames = eval('this.defaults'+inst+'.colorWeekNames');
	var colorWeekNamesBG = eval('this.defaults'+inst+'.colorWeekNamesBG');
	var weightWeekNames = eval('this.defaults'+inst+'.weightWeekNames');
	var typeWeekNames = eval('this.defaults'+inst+'.typeWeekNames');
	
	
	var sizeWeekNums = eval('this.defaults'+inst+'.sizeWeekNums');
	var fontWeekNums = eval('this.defaults'+inst+'.fontWeekNums');
	var colorWeekNums = eval('this.defaults'+inst+'.colorWeekNums');
	var colorWeekNumsBG = eval('this.defaults'+inst+'.colorWeekNumsBG');
	var weightWeekNums = eval('this.defaults'+inst+'.weightWeekNums');
	

	
	var sizeDayNums = eval('this.defaults'+inst+'.sizeDayNums');
	var fontDayNums = eval('this.defaults'+inst+'.fontDayNums');
	var colorDayNums = eval('this.defaults'+inst+'.colorDayNums');
	var weightDayNums = eval('this.defaults'+inst+'.weightWeekNames');
	
	
	Week = (parseInt(Week)-1);
	
 
	var HTML_String = '<div class="CalendarMainDIV" style="">';
				
	HTML_String +='<div style="" class ="Topheader">Weekly Planner';
	HTML_String +=	'<button id="ReloadFrame" onClick="window.location=window.location"><img src="images/reloadblue24.png" width="100%" height="100%"/></button>';
	HTML_String +='</div>';
	
	HTML_String += '<div style="" class ="TopControl" onMouseOver="">';
				
			
	HTML_String += '<div class ="PrevDiv">';
	HTML_String += '<button class="buttonPrev" onclick="WeekSkip('+inst+','+Year+','+Week+', &#39-&#39)"';
	HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
	HTML_String += '&#60&#60</button>';
	HTML_String += '</div>';
	
	HTML_String += '<div class ="NextDiv">';
	HTML_String += '<button class="buttonNext" onclick="WeekSkip('+inst+','+Year+','+Week+', &#39+&#39)"';
	HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
	HTML_String += '&#62&#62</button>';
	HTML_String += '</div>';
	
	HTML_String += '<div class ="TodayDiv">';
	HTML_String += '<button class="buttonToday" onclick="WeekToday('+inst+')"';
	HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
	HTML_String += 'Today</button>';
	HTML_String += '</div>';
	
	HTML_String += '<div class ="MonthDiv">';
	HTML_String += '<button class="buttonMonth" onclick="GoToDateMonth('+inst+','+Year+','+Month1+');"';
	HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
	HTML_String += 'Month View</button>';
	HTML_String += '</div>';
						
	HTML_String += '<div class ="DateHeadDIV">';
	HTML_String += '<div class="DateHead">'+HeaderDate+'</div>';
	HTML_String += '</div>';
	
	HTML_String += '<div class ="EventDiv">';
	HTML_String += '<button id="btnEvent"  class="buttonEvent" onclick=""';
	HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
	HTML_String += 'Create Event</button>';
	HTML_String += '</div>';
			

			
	HTML_String += ' </div>';




//HTML_String += '<table class="tableMain" style="border:'+borderDays+';" border="0" cellpadding="0" cellspacing="0" >';

	HTML_String += '<div class="trWeekdayNames" style=" border:'+borderWeekNames+'; background:'+colorWeekNamesBG+';';
	HTML_String += 'color:'+colorWeekNames+'; font-family:'+fontWeekNames+'; font-size:'+sizeWeekNames+'; font-weight:bold;">';
	
	
	if(typeWeekNames == 'short')
	{
		HTML_String += ' <div class="WeekDayHeader">S</div>   <div class="WeekDayHeader">M</div>    <div class="WeekDayHeader">T</div>';
		HTML_String += ' <div class="WeekDayHeader">W</div>   <div class="WeekDayHeader">T</div>   ';
		HTML_String += ' <div class="WeekDayHeader">F</div>   <div class="WeekDayHeader" >S</div>     </div>';
	}


	if(typeWeekNames == 'medium')
	{
		HTML_String += ' <div class="WeekDayHeader">Sun</div>   <div class="WeekDayHeader">Mon</div>    <div class="WeekDayHeader">Tue</div>';
		HTML_String += ' <div class="WeekDayHeader">Wed</div>   <div class="WeekDayHeader">Thu</div>   ';
		HTML_String += ' <div class="WeekDayHeader">Fri</div>     <div class="WeekDayHeader" >Sat</div>     </div>';
	}

	if(typeWeekNames == 'long')
	{
		HTML_String += ' <div class="WeekDayHeader">Sunday</div>   <div class="WeekDayHeader">Monday</div>    <div class="WeekDayHeader">Tuesday</div>';
		HTML_String += ' <div class="WeekDayHeader">Wednesday</div>   <div class="WeekDayHeader">Thursday</div>   ';
		HTML_String += ' <div class="WeekDayHeader">Friday</div>     <div class="WeekDayHeader" >Saturday</div>     </div>';
	}
   
   
   
  var Column = 1;
  var WeekLoopNum = 1;
  var WeekArrayCount = 1;
  WeekArray = new Array();
  
   
  HTML_String += '<tr class="WeekContainer" valign="top">';
			  
  for (var i = 1; i < 8; i++) {
		  
		  
		     if(WeekFullDates[WeekLoopNum] == todayAll){
				 
			   HTML_String += '<div   style="border:'+borderDays+'; background:#ff0; height:100%; min-height:100%; Width:13%; float:left; ">';
			   HTML_String += '<div id="TodayHeader" onclick="Make_Day('+inst+','+Year+','+CurrentMonth+','+WeekDayNumbers[WeekLoopNum]+')" class="DayHeaderTodayDiv" style="background:'+colorTodayTopBG+';';
			   HTML_String += 'color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+';">' +WeekDayNumbers[WeekLoopNum]+ '</div>';
			   HTML_String += '<div id="" class="DayContainerDIV"';
			   //HTML_String += 'onclick="ShowEventModal(&#39Week&#39,'+inst+',&#39 '+WeekFullDates[WeekLoopNum]+' &#39,'+WeekDayNumbers[WeekLoopNum]+');"';
			   HTML_String += 'onmouseover="  HoverUpdate(&#39 '+WeekFullDates[WeekLoopNum]+' &#39);  this.style.backgroundColor=&#39'+colorToDayMouseOver+'&#39;" onmouseout="this.style.backgroundColor=&#39'+colorTodayBG+'&#39"';
			   HTML_String += 'style="background:'+colorTodayBG+'; color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+' ">';
			   HTML_String += '<div class="DayBox" id="Day'+WeekFullDates[WeekLoopNum]+'" style="height:100%; width:100%;"></div></div></div>';
			   
			   WeekArray[WeekArrayCount] = WeekFullDates[WeekLoopNum];
			   WeekArrayCount ++
			 }
			 else
			 {
				 
			   HTML_String += '<div  style="border:'+borderDays+'; height:100%; min-height:100%; Width:13%; float:left;">';
			   HTML_String += '<div id="DayHeader" onclick="Make_Day('+inst+','+Year+','+CurrentMonth+','+WeekDayNumbers[WeekLoopNum]+')" class="DayHeaderDiv" style="background:'+colorCalDayHeadersBG+';';
			   HTML_String += 'color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+';">' +WeekDayNumbers[WeekLoopNum]+ '</div>';
			   HTML_String += '<div id=""  class="DayContainerDIV"';
			   //HTML_String += 'onclick="ShowEventModal(&#39Week&#39,'+inst+',&#39 '+WeekFullDates[WeekLoopNum]+' &#39,'+WeekDayNumbers[WeekLoopNum]+');"';
			   HTML_String += 'onmouseover="  HoverUpdate(&#39 '+WeekFullDates[WeekLoopNum]+' &#39); this.style.backgroundColor=&#39'+colorDayMouseOver+'&#39;" onmouseout="this.style.backgroundColor=&#39'+colorCalendarBG+'&#39"';
			   HTML_String += 'style="background:'+colorCalendarBG+'; color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+' ">';
			   HTML_String += '<div class="DayBox" id="Day'+WeekFullDates[WeekLoopNum]+'" style="height:100%; width:100%;"></div></div></div>';
			   
			   WeekArray[WeekArrayCount] = WeekFullDates[WeekLoopNum];
			   WeekArrayCount ++
			  
			 }
         
		       WeekLoopNum ++;
			   Column++;
			   
		 
      }
	  
    HTML_String += '</tr>';
	//HTML_String += '</table>';
    HTML_String += ' </div>';

	YearShowing = Year;
	WeekShowing = Week;	
	ViewShowing = 'Week';
	
	 	
	offsetX = +30;
	offsetY = -25;
	//if(offsetY == 0){offsetY = 0;}else{offsetY = 0}; 
	
	WeekEventsAJAX(WeekArray); //Fills out the Week events
   
    document.getElementById('Calendar'+inst).innerHTML = HTML_String;
    

}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






















//DayCal This Creates the HTML For The Calendar Day///////////////////////////////////////////////////////////////////////////////////////////////

function Make_Day(inst,sYear,sMonth,sDay,count,Direction) {
	
//Setup Todays Date
//alert(sYear+' - '+sMonth+' - '+sDay);
    var today = new Date;
    var Day = today.getDate();
	var Month =(today.getMonth()+1);
	var Year = today.getFullYear();
	var todayAll = (Month+'/'+Day+'/'+Year);
	
//Setup the selected date

	var dateAll = (sMonth+'/'+sDay+'/'+sYear); //Builds the full date 
	var DayName = displayDay(dateAll); //Returns the Day Name of the week
	var MonthName = Month_Label[sMonth-1]; //Gets the proper Month name for the selected day/month
	var MonthNow= sMonth-1;
//Date Header Setup---------------------------------------------------------------	 

    var DateHead = (DayName+' '+MonthName+' '+sDay+', '+sYear);
//--------------------------------------------------------------------------------	

        hideToolTip();
			
        var sFunction = eval('this.defaults'+inst+'.SelectFunction');
		var sObject = eval('this.defaults'+inst+'.SetObject');
		var Format = eval('this.defaults'+inst+'.Format');
		var threeMoControl = eval('this.defaults'+inst+'.threeMoControl');
		
		var sHead = eval('this.defaults'+inst+'.HeadingText');
		var sTopBar = eval('this.defaults'+inst+'.showControlBar');
		var sDateSelect = eval('this.defaults'+inst+'.showDateSelect');
		var sPrevNext = eval('this.defaults'+inst+'.showPrevNext');
		var sToday = eval('this.defaults'+inst+'.showToday');
		var sWeek = eval('this.defaults'+inst+'.showWeekBtn');
		//var aMonth = eval('this.defaults'+inst+'.showMonthBtn');
		var sCreateEvent = eval('this.defaults'+inst+'.showCreateBtn');
		var sClose = eval('this.defaults'+inst+'.showClose');
		var sWeekNums = eval('this.defaults'+inst+'.showWeekNumbers');
		var TodayText = eval('this.defaults'+inst+'.TodayText');
		
		
		var borderMain = eval('this.defaults'+inst+'.borderMain');
		var borderDays = eval('this.defaults'+inst+'.borderDays');
		var borderWeekNames = eval('this.defaults'+inst+'.borderWeekNames');
		
		
		var colorTopBG = eval('this.defaults'+inst+'.colorTopBG');
		var colorTopOffBG = eval('this.defaults'+inst+'.colorTopOffBG');
		var colorLines = eval('this.defaults'+inst+'.colorLines');
		var colorCalendarBG = eval('this.defaults'+inst+'.colorCalendarBG');
		var colorCalDayHeadersBG = eval('this.defaults'+inst+'.colorCalDayHeadersBG');
		var colorTodayBG = eval('this.defaults'+inst+'.colorTodayBG');
		var colorTodayTopBG = eval('this.defaults'+inst+'.colorTodayTopBG');

		var colorCalOtherBG = eval('this.defaults'+inst+'.colorCalOtherBG');
		var colorCalOtherTopBG = eval('this.defaults'+inst+'.colorCalOtherTopBG');
		var colorDayMouseOver = eval('this.defaults'+inst+'.colorDayMouseOver');
		var colorToDayMouseOver = eval('this.defaults'+inst+'.colorToDayMouseOver');
		
		
				
		var fontHead = eval('this.defaults'+inst+'.fontHead');
		var colorHead = eval('this.defaults'+inst+'.colorHead');
		var sizeHead = eval('this.defaults'+inst+'.sizeHead');
		var fontHead = eval('this.defaults'+inst+'.fontHead');
		var weightHead = eval('this.defaults'+inst+'.weightHead');
		var colorHeadBG = eval('this.defaults'+inst+'.colorHeadBG');
		var TextAlign = eval('this.defaults'+inst+'.TextAlign');
		
		
		var fontMonthYear = eval('this.defaults'+inst+'.fontMonthYear');
		var colorMonthYear = eval('this.defaults'+inst+'.colorMonthYear');
		var sizeMonthYear = eval('this.defaults'+inst+'.sizeMonthYear');
		var weightMonthYear = eval('this.defaults'+inst+'.weightMonthYear');
		
		
		var fontButton = eval('this.defaults'+inst+'.fontButton');
		var colorButton = eval('this.defaults'+inst+'.colorButton');
		var sizeButton = eval('this.defaults'+inst+'.sizeButton');
		var weightButton = eval('this.defaults'+inst+'.weightButton');
		var heightButton = eval('this.defaults'+inst+'.heightButton');
		
		
		var fontPicker = eval('this.defaults'+inst+'.fontPicker');
		var colorPicker = eval('this.defaults'+inst+'.colorPicker');
		var sizePicker = eval('this.defaults'+inst+'.sizePicker');
		var weightPicker = eval('this.defaults'+inst+'.weightPicker');
		var heightPicker = eval('this.defaults'+inst+'.heightPicker');
		
		
		var sizeWeekNames = eval('this.defaults'+inst+'.sizeWeekNames');
		var fontWeekNames = eval('this.defaults'+inst+'.fontWeekNames');
		var colorWeekNames = eval('this.defaults'+inst+'.colorWeekNames');
		var colorWeekNamesBG = eval('this.defaults'+inst+'.colorWeekNamesBG');
		var weightWeekNames = eval('this.defaults'+inst+'.weightWeekNames');
		var typeWeekNames = eval('this.defaults'+inst+'.typeWeekNames');
		
		
		var sizeWeekNums = eval('this.defaults'+inst+'.sizeWeekNums');
		var fontWeekNums = eval('this.defaults'+inst+'.fontWeekNums');
		var colorWeekNums = eval('this.defaults'+inst+'.colorWeekNums');
		var colorWeekNumsBG = eval('this.defaults'+inst+'.colorWeekNumsBG');
		var weightWeekNums = eval('this.defaults'+inst+'.weightWeekNums');
		

		
		var sizeDayNums = eval('this.defaults'+inst+'.sizeDayNums');
		var fontDayNums = eval('this.defaults'+inst+'.fontDayNums');
		var colorDayNums = eval('this.defaults'+inst+'.colorDayNums');
		var weightDayNums = eval('this.defaults'+inst+'.weightWeekNames');
		
		
	
		
	 
        var HTML_String = '<div class="CalendarMainDIV" style="">';
					
		HTML_String += '<div style="" class ="Topheader">Day Planer';
		HTML_String +=	 '<button id="ReloadFrame" onClick="window.location=window.location"><img src="images/reloadblue24.png" width="100%" height="100%"/></button>';
		HTML_String += '</div>';
		
		HTML_String += '<div style=""    class ="TopControl"  onMouseOver="">';
					
				
					HTML_String += '<div class ="PrevDiv">';
					HTML_String += '<button class="buttonPrev" onclick="DaySkip('+inst+',&#39-&#39,'+sYear+','+sMonth+','+sDay+')"';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += '&#60&#60</button>';
					HTML_String += '</div>';
					
					HTML_String += '<div class ="NextDiv">';
					HTML_String += '<button class="buttonNext" onclick="DaySkip('+inst+',&#39+&#39,'+sYear+','+sMonth+','+sDay+')"';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += '&#62&#62</button>';
					HTML_String += '</div>';
					
					HTML_String += '<div class ="TodayDiv">';
					HTML_String += '<button class="buttonToday" onclick="DayToday('+inst+')"';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += 'Today</button>';
					HTML_String += '</div>';
										
					HTML_String += '<div class ="DateHeadDIV">';
					HTML_String += '<div class="DateHead">'+DateHead+'</div>';
					HTML_String += '</div>';
					
					HTML_String += '<div class ="EventDiv">';
					HTML_String += '<button id="btnEvent"  class="buttonEvent" onclick=""';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += 'Create Event</button>';
					HTML_String += '</div>';
					
					HTML_String += '<div class ="MonthDiv">';
					HTML_String += '<button class="buttonMonth" onclick="GoToDateMonth('+inst+','+sYear+','+MonthNow+');"';
					HTML_String += 'style="color:'+colorButton+';  font-family:'+fontButton+';  font-size:'+sizeButton+';  font-weight:'+weightButton+'; height:'+heightButton+';">';
					HTML_String += 'Mo</button>';
					HTML_String += '</div>';

					
	HTML_String += ' </div>';


//HTML_String += '<table class="tableMain" style="" border="0" cellpadding="0" cellspacing="0" >';

    HTML_String += '<tr class="trWeekdayNames" style=" border:'+borderWeekNames+'; background:'+colorWeekNamesBG+';';
	HTML_String += 'color:'+colorWeekNames+'; font-family:'+fontWeekNames+'; font-size:'+sizeWeekNames+'; font-weight:bold;">';
	

   

  HTML_String += '<tr>';
			  
			   HTML_String += '<td   style="border:'+borderDays+'; background:#ff0; height:100%; Width:100%; ">';
			   HTML_String += '<div id="sDayEvents" class="DayContainerDIV"';
			   HTML_String += 'style="background:'+colorCalendarBG+'; color:'+colorDayNums+'; font-family:'+fontDayNums+'; font-size:'+sizeDayNums+'; font-weight:'+weightDayNums+' ">';
			   HTML_String += '<div id="TodayHeader" class="DayHeaderTodayDiv" style="background:'+colorCalDayHeadersBG+';';
			   HTML_String += 'color:'+colorDayNums+'; font-family:'+fontDayNums+';">    </div>';
			   HTML_String += '</div></td>';
			 

         

	  
    HTML_String += '</tr>';
	//HTML_String += '</table>';
    HTML_String += ' </div>';
	
	MonthShowing = sMonth;
	DayShowing = sDay;
	YearShowing = sYear;	
	ViewShowing = 'Day';
	DayEventsAJAX(dateAll);
   
    document.getElementById('Calendar'+inst).innerHTML = HTML_String;
	

	if(threeMoControl == true)
	{
		
		UpdateThree(count,Direction);
		
		
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Sets the default calendar (today)
function Calendar(inst,dir,Num) {

  if (dir == 'plus'){Selected_Month = (parseInt(Current_Month+Num));}
  if (dir == 'minus'){Selected_Month = (parseInt(Current_Month-Num));}
  
  Selected_Year = Current_Year;
   
  Make_Calendar(Selected_Year, Selected_Month, inst);
   
}


//CalToday  Main calendar, go to today
function GoToToday(inst) {

   Selected_Month = Current_Month;
   Selected_Year = Current_Year;
   
   var count = 3; //number of additional calendars to update
   var Direction = '-';
   
   Make_Calendar(Current_Year, Current_Month,inst,count,Direction);
}


//CalGo  Main calendar, go to this date
function GoToDateMonth(inst,sYear,sMonth) 
{
   Selected_Month = parseInt(sMonth);
   Selected_Year = (sYear);
   
   var count = 3; //number of additional calendars to update
   var Direction = '-';
   
   Make_Calendar(Selected_Year,Selected_Month,inst,count,Direction);
}


//dropdown select boxes
function DateSelect(inst) {
	
   	
	var sYear = document.getElementsByName("yearSelect"+inst);
	var sMonth = document.getElementsByName("monthSelect"+inst);
	
	//var aYear = sYear[0].options[sYear[0].selectedIndex].value;
	//var aMonth = sMonth[0].options[sMonth[0].selectedIndex].value;
	var aYear=Gebi('yearSelect1')[Gebi('yearSelect1').selectedIndex].value;
	var aMonth=Gebi('monthSelect1')[Gebi('monthSelect1').selectedIndex].value;
	
	
	if (aYear !='Year' || aMonth !='Month')
	{
		//alert(aYear+', '+aMonth);
		Selected_Year = aYear;
		Selected_Month = (aMonth-1);//because the index of Month is one ahead of the month number
		
		var count = 3; //number of additional calendars to update
		var Direction = '-';
		
		Make_Calendar(Selected_Year, Selected_Month,inst,count,Direction); 
	}
	else
	{
	    alert('Please Select A Month And Year');	
	}
    
}


//Cal>> Moves the calendar Fwd or Back
function Skip(Direction,inst)
{
	if (Direction == '+')
	{
		if (Selected_Month == 11)
		{
			Selected_Month = 0;
			Selected_Year++;
		}
		else{Selected_Month++;}
	}
 
	if (Direction == '-')
	{
		if (Selected_Month == 0)
		{
			Selected_Month = 11;
			Selected_Year--;
		}
		else{Selected_Month--;}
	}
	var count = 3; //number of additional calendars to update
	Make_Calendar(Selected_Year, Selected_Month,inst,count,Direction);
}


//WkToday Sets the week View to Today
function WeekToday(inst) { 

	var today = new Date();
    
	var Day = today.getDate();
	var Month =(today.getMonth());
	var Year = today.getFullYear();
	
	var NewWeek = getWeekByDate(Month,Day,Year);
	
  Make_Week(inst,Year,NewWeek);
}


//Wk>> Moves the week View Back or Forward
function WeekSkip(inst,Year,Week,Direction) {
	
   if (Direction == '-'){var NewWeek = (parseInt(Week)-1);}
   if (Direction == '+'){var NewWeek = (parseInt(Week)+1);}
   
   
   Make_Week(inst,Year,NewWeek);
   
}


//DayToday Sets the Day View to Today
function DayToday(inst) { 

	var today = new Date();
    
	var Day = today.getDate();
	var Month =(today.getMonth()+1);
	var Year = today.getFullYear();
	
	var NewWeek = getWeekByDate(Month,Day,Year);

    Make_Day(inst,Year,Month,Day);
   
}


//Day>> Moves the Day View Back or Forward--------------------------------------------------------------------------------

function DaySkip(inst,Direction,Year,Month,Day) {

    var NewDay;
	var NewMonth;
	var NewYear;
	
   //This sets up February LeapYear
   if (Month == 2) {Days_in_Month[1] = ((Year % 400 == 0) || ((Year % 4 == 0) && (Year % 100 !=0))) ? 29 : 28;}
   //Get # days in current month   
   var CurMonthLastDay = (Days_in_Month[parseInt(Month)-1]);
   var LastMonthLastDay = (Days_in_Month[parseInt(Month)-2]);
   if(Month == 1){var LastMonthLastDay = (31);}
	
	if (Direction == '+')
	{
		if(Day == CurMonthLastDay)
		{
			NewDay = (1);
			
			if(Month == 12)
			{
				NewMonth = (1);
				NewYear = (parseInt(Year)+1);
			}
			else
		    {
				NewMonth = (parseInt(Month)+1);
				NewYear = Year;
	        }
		}
		else
		{
			NewDay = (parseInt(Day)+1);
			NewMonth = Month;
			NewYear = Year;
		}
	}

	if (Direction == '-')
	{
		if(Day == 1)
		{
			NewDay = (LastMonthLastDay);
			
			if(Month == 1)
			{
				NewMonth = (12);
				NewYear = (parseInt(Year)-1);
			}
			else
		    {
				NewMonth = (parseInt(Month)-1);
				NewYear = Year;
	        }
		}
		else
		{
			NewDay = (parseInt(Day)-1);
			NewMonth = Month;
			NewYear = Year;			
		}
	}
	
   Make_Day(inst,NewYear,NewMonth,NewDay);
   
}


//DayGo Go to this date
function GoToDateDay(inst,sYear,sMonth) 
{

   Make_Day(inst,sYear,sMonth,sDay);
}


//Events For Days--------------------------------------------------------------------------

