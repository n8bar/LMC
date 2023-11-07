// Main Setup for calendars
var ns6=document.getElementById&&!document.all;
var ie4=document.all;

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
	
function PopupDayPlaner(inst,sDate,obj) {  // This Code Shows the Day Planer For a given input date
	var month = parseInt(sDate.split("/")[0],10);
	var day = parseInt(sDate.split("/")[1],10);
	var year = parseInt(sDate.split("/")[2],10);
	Make_Day(1,year,month,day);
}

//Up3 Updates the three left calendars
function UpdateThree(count,Direction) {
// Updates additional calendars to sync with the main calendar going forward or back<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	if (count >0) {
		//this calendar stays the same date as the main------------------------------
    if (count == 2)  {
			eval('var sYear'+count+' = Selected_Year;');
			eval('var sMonth'+count+' = Selected_Month;');
		}
    //this calendar stays behind one month------------------------------
		if (count == 1) {
			if (Direction == '+') {
				eval('var sYear'+count+' = Selected_Year;');
				eval('var sMonth'+count+' = Selected_Month -2;');
			
				if(eval('sMonth'+count+' == 10') || eval('sMonth'+count+' == -2')) {
				  if (eval('sMonth'+count+' == 10')) {
					 eval('sMonth'+count+' = 0');
					 eval('sYear'+count+'++');
				  }
				  if (eval('sMonth'+count+' == -2')) {
					 eval('sMonth'+count+' = 11');
					 eval('sYear'+count+'--');
				  }
				}
				else { eval('sMonth'+count+'++'); }
			}
 			
			if (Direction == '-') {
				eval('var sYear'+count+' = Selected_Year;');
				eval('var sMonth'+count+' = Selected_Month;');
				if (eval('sMonth'+count+' == 0')) {
				 eval('sMonth'+count+' =11');
				 eval('sYear'+count+'--');
				}
				else {
				 eval('sMonth'+count+'--');
				}
			}
		}//if (count == 1)	
			
//this calendar stays one month ahead------------------------------
		if (count == 3) {
			if (Direction == '+') {
				eval('var sYear'+count+' = Selected_Year;');
				eval('var sMonth'+count+' = Selected_Month;');
			
				if (eval('sMonth'+count+' == 11')) {
				 eval('sMonth'+count+' = 0');
				 eval('sYear'+count+'++');
				}
				else {
				 eval('sMonth'+count+'++');
				}	 
			}

		if (Direction == '-') {
			eval('var sYear'+count+' = Selected_Year;');
			eval('var sMonth'+count+' = Selected_Month +2;');
				
			if (eval('sMonth'+count+' == 13')) {
				eval('sMonth'+count+' =0');
				eval('sYear'+count+'++');
			}
			else {
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
	
	for (i=0;i<7;i++) {
	   WeekD[DayNum] = new Date(startDate.getTime()+(i*aDay)).getDate();
	   DayNum ++;
	}
	return WeekD;

}


//WkDates Returns the week dates, Long and short based on a week number input-----------------------------------------

function y2k(number) { return (number < 1000) ? number + 1900 : number; }

function getWeek(year,month,day) { 
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

function getWeekDates(w,y) {
	if(w == 53){y--;}
	var n = new Date();
	if(y)n.setYear(y);
	//window.top.document.title=n.getFullYear();
	n.setMonth(0); n.setDate(1); n.setDate(n.getDate()-n.getDay());
	while( w != getWeek(n.getFullYear(),n.getMonth(),n.getDate()) ) n.setDate(n.getDate()+7);
	var WeekD = new Array();
	//WeekD[0] = "0";
	var DayNum = 1;
	WeekD[0] = n.getMonth();
	
	for (i=1;i<=10;i++) {
		var Month = (parseInt(n.getMonth())+1);
		WeekD[i] = Month+"/"+n.getDate()+"/"+n.getFullYear();
		n.setDate(n.getDate()+1);
	}
	WeekD[10] = Month-1;
	return WeekD;
	/**/
}

function getWeekDays(w,y) {
	var n = new Date();
	if(y)n.setYear(y);
	n.setMonth(0);n.setDate(1);n.setDate(n.getDate()-n.getDay()); 
	while( w != getWeek(n.getFullYear(),n.getMonth(),n.getDate()) )   n.setDate(n.getDate()+7);
	var WeekD = new Array();
	//WeekD[0] = "0";
	var DayNum = 1;
	
	for (i=0;i<8;i++) {
		WeekD[DayNum] = (n.getDate()+0);
		n.setDate(n.getDate()+1);
		DayNum ++;
	}
	return WeekD;
}

//Header
function Header(Year, Month) {
	//february
	if (Month == 1) { Days_in_Month[1] = (Year % 400 == 0) || ((Year % 4 == 0) && (Year % 100 !=0)) ? 29 : 28; }
	var Header_String = Month_Label[Month] + ' ' + Year;
	return Header_String;
}

// This Creates the HTML For The Calendar////////////////////////////////////
var CalRows=0;
function Make_Calendar(Year,Month,inst,count,Direction) {
	var First_Date = new Date(Year, Month, 1);
	var Heading = Header(Year, Month);
	var First_Day = First_Date.getDay() + 1;
	
	if(inst == 1){MonthShowing = (parseInt(Month)-0);YearShowing = Year;}//Sets the global variable for current month and year
	
	
	if (((Days_in_Month[Month] == 31) && (First_Day >= 6)) ||  ((Days_in_Month[Month] == 30) && (First_Day == 7))) {var Rows = 6;}
	
	else if ((Days_in_Month[Month] == 28) && (First_Day == 1)) {var Rows = 4;}
	
	else {var Rows=5;}
	
	//if(CalRows==0){
	CalRows=Rows;//}
	
	var CalendarDays = 'tdCalendarDay'+CalRows+'rows';
	var CalendarRows = 'tdCalendar'+CalRows+'rows';
	
	var Cal = eval('this.defaults'+inst+'');
	
	if(inst != 0){
		Cal.sFunction = Cal.SelectFunction
		Cal.sObject = Cal.SetObject
		
		Cal.sHead = Cal.HeadingText;
		Cal.sTopBar = Cal.showControlBar;
		Cal.sDateSelect = Cal.showDateSelect;
		Cal.sPrevNext = Cal.showPrevNext;
		Cal.sToday = Cal.showToday;
		Cal.sWeek = Cal.showWeekBtn;
		Cal.sMonth = Cal.showMonthBtn;
		Cal.sCreateEvent = Cal.showCreateBtn;
		Cal.sClose = Cal.showClose;
		Cal.sWeekNums = Cal.showWeekNumbers;
		Cal.TodayText = Cal.TodayText;
		
		Cal.sizeDayNums ='12px';// eval('this.defaults'+inst+'.sizeDayNums');
	}

	var calHTML = '<div class="CalendarMainDIV" style="">';
	if(inst==1) calHTML +='<div id="ReloadFrame" onClick="window.location=window.location"><img src="../../images/reloadblue24.png" width="100%" height="100%"/></div>';
	
	if(Cal.sHead !='' && !! Cal.sHead ) {
		calHTML+='<div style="background:'+Cal.colorHeadBG+'; color:'+Cal.colorHead+'; font-family:'+Cal.fontHead+'; font-size:'+Cal.sizeHead+';';
		if(inst!=1) { calHTML+='height:10%;'; }
		calHTML+='font-weight:'+Cal.weightHead+'; text-align:'+Cal.TextAlign+'; " onMouseOver="hideToolTip()" class="Topheader">'+Cal.sHead;
		calHTML+='</div>';
	}

	var PopupID = ('Popup'+inst); 

	if (Cal.sTopBar) {				
 
		calHTML+='<div style="background:'+Cal.colorTopBG+';  ';
		if(inst!=1) calHTML+=' height:10%; ';
		calHTML+='" class=TopControl onMouseOver="hideToolTip();">';
		//color:'+Cal.colorButton+'; font-family:'+Cal.fontButton+'; font-size:'+Cal.sizeButton+'; font-weight:'+Cal.weightButton+' 					
	 
		if (Cal.sPrevNext) {	
			calHTML+='<div class ="PrevDiv">';
			calHTML+='<button class="buttonPrev" onclick="Skip(\'-\','+inst+')"';
			calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
			calHTML+='<<</button>';
			calHTML+='</div>';
		
			calHTML+='<div class ="NextDiv">';
			calHTML+='<button class="buttonNext" onclick="Skip(\'+\','+inst+')"';
			calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
			calHTML+='>></button>';
			calHTML+='</div>';
		}
		if (Cal.sToday) {
			calHTML+='<div class ="TodayDiv">';
			calHTML+='<button class="buttonToday" onclick="GoToToday('+inst+')"';
			calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
			calHTML += Cal.TodayText+'</button>';
			calHTML+='</div>';
		}
					
		calHTML+='<div class ="DateHeadDIV">';
		calHTML+='<div id="DateHead" class="DateHead" onclick="GoToDateMonth(1,'+Year+','+Month+');"';
		calHTML+='onMouseover="this.style.color=\''+Cal.hoverMonthYear+'\'" onmouseout="this.style.color=\''+Cal.colorMonthYear+'\'"'; 
		calHTML+='style="color:'+Cal.colorMonthYear+'; font-family:'+Cal.fontMonthYear+'; font-size:'+Cal.sizeMonthYear+'; font-weight:'+Cal.weightMonthYear+';">'+Heading+'</div>';
		calHTML+='</div>';
			
		if (Cal.sClose) {
			calHTML+='<div class ="EventDiv">';
			calHTML+='<button class="buttonEvent" onclick="hidePopup(\''+PopupID+'\')"';
			calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
			calHTML+='X</button>';
			calHTML+='</div>';
		}
			
		if (Cal.sDateSelect){
			calHTML+='<div class ="GetDateBtnDiv">';
			calHTML+='	<button class="GetDateBtn" onclick="DateSelect('+inst+')"';
			calHTML+=		'style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';"> Go </button>';
			calHTML+='</div>';
			
			calHTML+='<div id="SelectDate" class="SelectDate">';
			
			calHTML+='	<select id="monthSelect'+inst+'" name="monthSelect"';
			calHTML+=		'style="color:'+Cal.colorPicker+';  font-family:'+Cal.fontPicker+';  font-size:'+Cal.sizePicker+';  font-weight:'+Cal.weightPicker+'; height:'+Cal.heightPicker+';">';
			calHTML+='		<option value="1">January</option>';
			calHTML+='		<option value="2">February</option>';
			calHTML+='		<option value="3">March</option>';
			calHTML+='		<option value="4">April</option>';
			calHTML+='		<option value="5">May</option>';
			calHTML+='		<option value="6">June</option>';
			calHTML+='		<option value="7">July</option>';
			calHTML+='		<option value="8">August</option>';
			calHTML+='		<option value="9">September</option>';
			calHTML+='		<option value="10">October</option>';
			calHTML+='		<option value="11">November</option>';
			calHTML+='		<option value="12">December</option>';
			calHTML+='		<option value="Month" selected="selected">Month</option>';
			calHTML+='	</select>';
					 
			calHTML+='	<select id="yearSelect'+inst+'" name="yearSelect" style="color:'+Cal.colorPicker+';  font-family:'+Cal.fontPicker+';  font-size:'+Cal.sizePicker+';  font-weight:'+Cal.weightPicker+'; height:'+Cal.heightPicker+';">';
			calHTML+='		<option value="2008">2008</option>';
			calHTML+='		<option value="2009">2009</option>';
			calHTML+='		<option value="2010">2010</option>';
			calHTML+='		<option value="2011">2011</option>';
			calHTML+='		<option value="2012">2012</option>';
			calHTML+='		<option value="2013">2013</option>';
			calHTML+='		<option value="2014">2014</option>';
			calHTML+='		<option value="2015">2015</option>';
			calHTML+='		<option value="2016">2016</option>';
			calHTML+='		<option value="2017">2017</option>';
			calHTML+='		<option value="2018">2018</option>';
			calHTML+='		<option value="Year" selected="selected">Year</option>';
			calHTML+='	</select>';
			calHTML+='</div>';
		}
		
		
		if (Cal.sCreateEvent) {
			calHTML+='<div class ="EventDiv">';
			/*
			calHTML+='<button id="btnEvent"  class="buttonEvent" onclick="ShowEventModal(\'NewEvent\','+inst+',\' '+TodayAll+' \')" ';
			calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
			calHTML+='Event</button>';
			*/
			calHTML+='</div>';
		}
		if (Cal.sMonth) {
			calHTML+='<div class ="MonthDiv">';
			calHTML+='	<button class="buttonMonth" onclick=""';
			calHTML+=		'style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">Month</button>';
			calHTML+='</div>';
		}
		if (Cal.sWeek) {			 
			calHTML+='<div class ="WeekDiv">';
			calHTML+='	<button class="buttonWeek" onclick=""';
			calHTML+=		'style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">Week</button>';
			calHTML+='</div>';
		}
		if (Cal.showStatus) {			 
			calHTML+='<div id="StatusLine" class ="Status">';
			calHTML+='</div>';
		}
		calHTML+='</div>';
	}
	else {
		calHTML+='<div class="DateHeadSolo"';
		calHTML+=		'style="background:'+Cal.colorTopOffBG+'; color:'+Cal.colorMonthYear+'; font-family:'+Cal.fontMonthYear+'; font-size:'+Cal.sizeMonthYear+'; font-weight:'+Cal.weightMonthYear+';">'+Heading+'</div>';
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
	
	
	//if(Format == 'Calendar'){calHTML+='<div class="divMain" style="border:'+Cal.borderMain+';" border="0" cellpadding="0" cellspacing="0" >';}
	//alert(Cal);
	if(Cal.Format == 'Popup'){
		calHTML+='<div class="divMainPopup" style="border:'+Cal.borderMain+'; width:100%;';
		if(inst!=1) calHTML+=' height:80%; '; 
		calHTML+='" border=0 cellpadding=0 cellspacing=0 >';
	}
	
  calHTML+='<div class="trWeekdayNames" style="height:3%; min-height:12px; width:100%; border:'+Cal.borderWeekNames+'; background:'+Cal.colorWeekNamesBG+';';
	calHTML+='color:'+Cal.colorWeekNames+'; font-family:'+Cal.fontWeekNames+'; font-size:'+Cal.sizeWeekNames+'; font-weight:bold;">';
	if(Cal.sWeekNums){calHTML+='<div class="WeekNumHeader WK" >WK</div>';}
	
	if(Cal.typeWeekNames == 'short') {
	calHTML+=' <div class=WeekDayHeader style="width:12.5%;">S</div><div class=WeekDayHeader style="width:12.5%;">M</div><div class=WeekDayHeader style="width:12.5%;">T</div><div class=WeekDayHeader style="width:12.5%;">W</div><div class=WeekDayHeader style="width:12.5%;">T</div><div class=WeekDayHeader style="width:12.5%;">F</div><div class=WeekDayHeader style="width:12.5%;" >S</div>     </div>';
	}

	if(Cal.typeWeekNames == 'medium') {
	calHTML+=' <div class="WeekDayHeader">Sun</div>   <div class="WeekDayHeader">Mon</div>    <div class="WeekDayHeader">Tue</div>';
	calHTML+=' <div class="WeekDayHeader">Wed</div>   <div class="WeekDayHeader">Thu</div>   ';
	calHTML+=' <div class="WeekDayHeader">Fri</div>     <div class="WeekDayHeader" >Sat</div>     </div>';
	}

	if(Cal.typeWeekNames == 'long') {
	calHTML+=' <div class="WeekDayHeader">Sunday</div>   <div class="WeekDayHeader">Monday</div>    <div class="WeekDayHeader">Tuesday</div>';
	calHTML+=' <div class="WeekDayHeader">Wednesday</div>   <div class="WeekDayHeader">Thursday</div>   ';
	calHTML+=' <div class="WeekDayHeader">Friday</div>     <div class="WeekDayHeader" >Saturday</div>     </div>';
	}

	var Last_Days = 1;
	var Day_Counter = 1;
	var Loop_Counter = 1;
	var Loop_Week = WeekNum;
	var RowNum = 1;
	var ColNum = 1;
	var DayArrayCount = 1;

	DayArray = new Array();

	if (Cal.Format == 'Calendar') {//Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---Calendar---
		for (var j = 1; j <= Rows; j++) {
			var DateAllWk = (Month+1+'/' +Day_Counter+'/'+Year); // Creates the whole date for each day
			calHTML+='<div valign="top" class="'+CalendarRows+'" style="width:100%;">';
			
			if(Cal.sWeekNums) {// Draws the week Numbers down the side
				calHTML+='<div class="tdWeek"';
				calHTML+='style="float:left; border:'+Cal.borderDays+'; border-top:none; background:'+Cal.colorWeekNumsBG+'; color:'+Cal.colorWeekNums+'; font-family:'+Cal.fontWeekNums+';';
				if(inst==1) { calHTML+=' height:100%; '; }
				calHTML+='font-size:'+Cal.sizeWeekNums+'; font-weight:'+Cal.weightWeekNums+' " onclick="Make_Week('+inst+','+Year+','+(Loop_Week)+')"';
				calHTML+='onMouseover="this.style.backgroundColor=\''+Cal.colorWeekNumsHover+'\'" ';
				calHTML+='onmouseout="this.style.backgroundColor=\''+Cal.colorWeekNumsBG+'\'" >';
				calHTML += Loop_Week+'</div>';
			}

			for (var i = 1; i < 8; i++)	{
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
			
			var DayWidth='100%';
			if ((Loop_Counter >= First_Day) && (Day_Counter <= Days_in_Month[Month])) {
				if ((Day_Counter == Today) && (Year == Current_Year) && (Month == Current_Month)) {// If this is today
					calHTML+='<div class="'+CalendarDays+'" style=" max-width:'+DayWidth+';border:'+Cal.borderDays+'; border-top:none; border-bottom:none;" >';
					
					calHTML+='<div id="TodayHeader" class="DayHeaderTodayDiv" onclick="Make_Day('+inst+','+Year+','+thisMonth+','+Day_Counter+')"';
					calHTML+='onMouseover="this.style.backgroundColor=\''+Cal.colorCalHeadersHover+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorTodayTopBG+'\'"';
					calHTML+='style=" max-width:'+DayWidth+';background:'+Cal.colorTodayTopBG+';color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+';font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+';">';
					
					calHTML+='<div class="DayNumber" >';
					calHTML += Day_Counter + '</div>';
					calHTML+='</div>';
					
					calHTML+='<div id="MonthDay_'+DateAll+'" class="DayContainerTodayDIV">';
					
					var DayContainerDate = DateAll;
					DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
					DayContainerDate='Day'+DayContainerDate;
					
					calHTML+='<div id="'+DayContainerDate+'"class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+'; background:'+Cal.colorTodayBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+'; "';
					calHTML+='onclick="ShowEventModal(\'Month\','+inst+',\' '+DateAll+' \','+Day_Counter+');"';
					calHTML+='onMouseover="HoverUpdate(\' '+DateAll+' \');  this.style.backgroundColor=\''+Cal.colorToDayMouseOver+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorTodayBG+'\'" >';
					calHTML+='</div>';
					
					calHTML+='</div></div>';
					
					DayArray[DayArrayCount] = DateAll;
					DayArrayCount ++
				}
				else {// All the other days 
					calHTML+='<div  class="'+CalendarDays+'" style=" max-width:'+DayWidth+';border:'+Cal.borderDays+'; border-top:none; border-bottom:none;" >';
					
					calHTML+='<div id="DayHeader" class="DayHeaderDiv"  onclick="Make_Day('+inst+','+Year+','+thisMonth+','+Day_Counter+')"';
					calHTML+='onMouseover="this.style.backgroundColor=\''+Cal.colorCalHeadersHover+'\';" onmouseout="this.style.backgroundColor=\''+Cal.colorCalDayHeadersBG+'\'"';
					calHTML+='style=" max-width:'+DayWidth+';background:'+Cal.colorCalDayHeadersBG+';color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+';font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+';">';
					calHTML+='<div class="DayNumber">';
					calHTML += Day_Counter + '</div>';
					calHTML+='</div>';
					
					calHTML+='<div id="MonthDay_'+DateAll+'" class="DayContainerDIV">';
					
					var DayContainerDate = DateAll;
					DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
					DayContainerDate='Day'+DayContainerDate;
					calHTML+='<div id="'+DayContainerDate+'" class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+'; background:'+Cal.colorCalendarBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+'; "';
					calHTML+='onclick="ShowEventModal(\'Month\','+inst+',\' '+DateAll+' \','+Day_Counter+');"';
					calHTML+='onMouseover="HoverUpdate(\' '+DateAll+' \');  this.style.backgroundColor=\''+Cal.colorDayMouseOver+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorCalendarBG+'\'" >';
					calHTML+='</div>';
					calHTML+='</div></div>';
					
					DayArray[DayArrayCount] = DateAll;
					DayArrayCount ++
					}
					Day_Counter++;
				}
				else{
					if (Loop_Counter < First_Day){// Days not in this month, First of the month
						calHTML+='<div  class="'+CalendarDays+'" style="border:'+Cal.borderDays+'; border-top:none; border-bottom:none;" >';
						
						calHTML+='<div id="DayOtherHeader" class="DayHeaderDiv" onclick="Make_Day('+inst+','+lastYear+','+lastMonth+','+PrevLastDays+')"';
						calHTML+='onMouseover="this.style.backgroundColor=\''+Cal.colorCalHeadersHover+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorCalOtherTopBG+'\'"';
						calHTML+='style=" max-width:'+DayWidth+';background:'+Cal.colorCalOtherTopBG+';color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+';font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+';">';
						calHTML+='<div class="DayNumber" >';
						calHTML += PrevLastDays+ '</div>';
						calHTML+='</div>';
						
						calHTML+='<div id="MonthDay_'+DateAllLast+'" class="DayContainerOtherDIV">';
						
						var DayContainerDate = DateAllLast;
						DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
						DayContainerDate='Day'+DayContainerDate;
						calHTML+='<div id="'+DayContainerDate+'"  class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+'; background:'+Cal.colorCalOtherBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+'; "';
						calHTML+='onclick="ShowEventModal(\'Month\','+inst+',\' '+DateAllLast+' \','+Day_Counter+');"';
						calHTML+='onMouseover="HoverUpdate(\' '+DateAllLast+' \'); this.style.backgroundColor=\''+Cal.colorDayMouseOver+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorCalOtherBG+'\'" >';
						calHTML+='</div>';
						calHTML+='</div></div>';
						
						DayArray[DayArrayCount] = DateAllLast;
						DayArrayCount ++
						
						PrevLastDays++;
					}
					if (Day_Counter >Days_in_Month[Month]) {// Days not in this month Last of the Month
						calHTML+='<div  class="'+CalendarDays+'" style="max-width:'+DayWidth+'; border:'+Cal.borderDays+'; border-top:none; border-bottom:none;" >';
						
						calHTML+='<div id="DayOtherHeader" class="DayHeaderDiv" onclick="Make_Day('+inst+','+nextYear+','+nextMonth+','+Last_Days+')"';
						calHTML+='onMouseover="this.style.backgroundColor=\''+Cal.colorCalHeadersHover+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorCalOtherTopBG+'\'"';
						calHTML+='style="max-width:'+DayWidth+'; background:'+Cal.colorCalOtherTopBG+';color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+';font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+';">';
						calHTML+='<div class="DayNumber" >';
						calHTML += Last_Days+ '</div>';
						calHTML+='</div>';
						
						calHTML+='<div id="MonthDay_'+DateAllNext+'" class="DayContainerOtherDIV">';
						
						var DayContainerDate = DateAllNext;
						DayContainerDate=DayContainerDate.replace(/\s+/g, " ").replace(/^\s|\s$/g, "");
						DayContainerDate='Day'+DayContainerDate;
						calHTML+='<div id="'+DayContainerDate+'"  class="DayBox" style=" min-width:'+DayWidth+'; width:'+DayWidth+';  background:'+Cal.colorCalOtherBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+'; "';
						calHTML+='onclick="ShowEventModal(\'Month\','+inst+',\' '+DateAllNext+' \','+Day_Counter+');"';
						calHTML+='onMouseover="HoverUpdate(\' '+DateAllNext+' \'); this.style.backgroundColor=\''+Cal.colorDayMouseOver+'\';" onmouseout="this.style.backgroundColor=\''+Cal.colorCalOtherBG+'\'" >';
						calHTML+='</div>';
						calHTML+='</div></div>';
						
						DayArray[DayArrayCount] = DateAllNext;
						DayArrayCount ++
						
						Last_Days++;
					}
				}
				ColNum++;
				Loop_Counter++;
      }
      calHTML+='</div>';
			
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
		CalCreated=(inst==1);
		CalendarEventsAJAX(DayArray); //Fills out the day events
	}
	if (Cal.Format == 'Popup') {//Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---
		//calHTML+='<div>';
		for (var j = 1; j <= Rows; j++) {
			var DateAllWk = (Month+1+'/' +Day_Counter+'/'+Year); // Creates the whole date for each day
			calHTML+='<div style="width:100%; height:'+((100/Rows)-1)+'%;">';
			if(Cal.sWeekNums) { // Draws the week Numbers down the side
				calHTML+='<div class="tdWeek"';
				calHTML+='style=" border:'+Cal.borderDays+'; background:'+Cal.colorWeekNumsBG+'; color:'+Cal.colorWeekNums+'; font-family:'+Cal.fontWeekNums+';';
				calHTML+='font-size:'+Cal.sizeWeekNums+'; font-weight:'+Cal.weightWeekNums+' " onclick="Make_Week(1,'+Year+','+Loop_Week+')"';
				calHTML+='onMouseover="this.style.backgroundColor=\''+Cal.colorWeekNumsHover+'\'" ';
				calHTML+='onmouseout="this.style.backgroundColor=\''+Cal.colorWeekNumsBG+'\'" >';
				calHTML += Loop_Week+'</div>';
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
					
					
					if ((Day_Counter == Today) && (Year == Current_Year) && (Month == Current_Month)) {	// If this is today
						calHTML+='<div  class="tdCalendarDayPopup" style=" font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+';  border:'+Cal.borderDays+';" ';
						calHTML+='id="MonthDay_'+DateAll+'"onclick="'+Cal.sFunction+'('+inst+',\' '+DateAll+' \',\''+Cal.sObject+'\')"';
						calHTML+='onmouseover="this.style.backgroundColor=\''+Cal.colorToDayMouseOver+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorTodayBG+'\'"';
						calHTML+='style="background:'+Cal.colorTodayBG+'; color:'+Cal.colorDayNums+';">';
						calHTML += Day_Counter + '</div>';
					}
					else { // All the other days 
						calHTML+='<div  class="tdCalendarDayPopup" style=" font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+'; border:'+Cal.borderDays+';"';
						calHTML+='id="MonthDay_'+DateAll+'" onclick="'+Cal.sFunction+'('+inst+',\' '+DateAll+' \',\''+Cal.sObject+'\')"';
						calHTML+='onmouseover="this.style.backgroundColor=\''+Cal.colorDayMouseOver+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorCalendarBG+'\'"';
						calHTML+='style="background:'+Cal.colorCalendarBG+'; color:'+Cal.colorDayNums+';">';
						calHTML += Day_Counter + '</div>';
					}
					Day_Counter++;
	//Popup---Popup---Popup---Popup---Popup---Popup---Popup---Popup---
				}
				else{
					if (Loop_Counter < First_Day){// Days not in this month First of the month
						calHTML+='<div  class="tdCalendarDayPopup" style=" font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+';  border:'+Cal.borderDays+';"';
						calHTML+='id="MonthDay_'+DateAllLast+'" onclick="'+Cal.sFunction+'('+inst+',\' '+DateAllLast+' \',\''+Cal.sObject+'\')" class="DayContainerOtherDIV"';
						calHTML+='onmouseover="this.style.backgroundColor=\''+Cal.colorDayMouseOver+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorCalOtherBG+'\'"';
						calHTML+='style="background:'+Cal.colorCalOtherBG+'; color:'+Cal.colorDayNums+';">';
						calHTML += PrevLastDays+'</div>';
						
						PrevLastDays++;
					}
					if (Day_Counter >Days_in_Month[Month]) {// Days not in this month Last of the Month
						calHTML+='<div  class="tdCalendarDayPopup" style=" font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+'; border:'+Cal.borderDays+';" ';
						calHTML+='id="MonthDay_'+DateAllNext+'" onclick="'+Cal.sFunction+'('+inst+',\' '+DateAllNext+' \',\''+Cal.sObject+'\')" class="DayContainerOtherDIV"';
						calHTML+='onmouseover="this.style.backgroundColor=\''+Cal.colorDayMouseOver+'\'" onmouseout="this.style.backgroundColor=\''+Cal.colorCalOtherBG+'\'"';
						calHTML+='style="background:'+Cal.colorCalOtherBG+'; color:'+Cal.colorDayNums+';">';
						calHTML += Last_Days+'</div>';
						
						Last_Days++;
					}
				}
				Loop_Counter++;
			}
		calHTML+='</div>';
		Loop_Week++;
		}
	}//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	calHTML+='</div>';
	calHTML+=' </div>';
	
	//Writes the HTML to the div    
	try{	Gebi('Calendar'+inst).innerHTML = calHTML;	}
	catch(e)	{document.title='error: Calendar'+inst+' does not exist.';}
	
	// Updates additional calendars to sync with the main calendar going forward or back<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	if(Cal.threeMoControl){UpdateThree(count,Direction);}
	
	// Sets up the Current Month, Year in the Dropdowns
	//Year = (Year.substr(3)); 
	//Gebi('monthSelect').options[Month].selected = true;
	//Gebi('yearSelect').options[Year].selected = true;
	
}
// END Main Calendar ////////////////////////////////////////////////////

//WkCal This Creates the HTML For The Calendar Week////////////////////////////////////
function Make_Week(inst,Year,Week) {
	//Setup Todays Date   
	var today = new Date;
	var Day = today.getDate();
	var Month =(today.getMonth()+1);
	var nYear = today.getFullYear();
	var todayAll = (Month+'/'+Day+'/'+Year);

	//Date Header Setup---------------------------------------------------------------
	Week = (parseInt(Week)-1);
	window.top.document.title=Week+' - '+Year;
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
	
	var Cal=eval('this.defaults'+inst);
	
	var calHTML = '<div class="CalendarMainDIV" style="width:100%;">';
	calHTML +=	'<div id="ReloadFrame" onClick="window.location=window.location"><img src="../../images/reloadblue24.png" width="100%" height="100%"/></div>';
				
	calHTML+='<div style="" class ="Topheader">Weekly Planner</div>';
	
	calHTML+='<div style="" class ="TopControl" onMouseOver="">';
			
	calHTML+='	<div class ="PrevDiv">';
	calHTML+='		<button class="buttonPrev" onclick="WeekSkip('+inst+','+Year+','+(Week+1)+', \'-\')" style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';"><<</button>';
	calHTML+='	</div>';
	
	calHTML+='	<div class ="NextDiv">';
	calHTML+='		<button class="buttonNext" onclick="WeekSkip('+inst+','+Year+','+(Week+1)+', \'+\')" style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">>></button>';
	calHTML+='	</div>';
	
	calHTML+='	<div class ="TodayDiv">';
	calHTML+='		<button class="buttonToday" onclick="WeekToday('+inst+')" style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">Today</button>';
	calHTML+='	</div>';
	
	calHTML+='	<div class ="MonthDiv">';
	calHTML+='		<button class="buttonMonth" onclick="GoToDateMonth('+inst+','+Year+','+Month1+');" style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">Month View</button>';
	calHTML+='	</div>';
						
	calHTML+='	<div class ="DateHeadDIV">';
	calHTML+='		<div class="DateHead">'+HeaderDate+'</div>';
	calHTML+='	</div>';
	
	calHTML+='	<div class ="EventDiv">';
	calHTML+='		<button id="btnEvent"  class="buttonEvent" onclick="" style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">Create Event</button>';
	calHTML+='	</div>';
			
	calHTML+='</div>';

	//calHTML+='<div class="divMain" style="border:'+Cal.borderDays+';" border="0" cellpadding="0" cellspacing="0" >';
	calHTML+='<div id="trWeekdayNames" style=" border:'+Cal.borderWeekNames+'; background:'+Cal.colorWeekNamesBG+'; height:3%; min-Height:10px; width:100%;';
	calHTML+='color:'+Cal.colorWeekNames+'; font-family:'+Cal.fontWeekNames+'; font-size:'+Cal.sizeWeekNames+'; font-weight:bold;">';
	
	var sty=(Cal.show8dayWeek) ? ' style="width:12.5%;"' : '';
	var Class=' class=WeekDayHeader';

	if(Cal.typeWeekNames == 'short') {
		var sty='style="width:12.5%;"';
		calHTML+=' <div >S</div><div'+Class+sty+'>M</div><div'+Class+sty+'>T</div>';
		calHTML+=' <div'+Class+sty+' >W</div>   <div'+Class+sty+' >T</div>   ';
		calHTML+=' <div'+Class+sty+' >F</div>   <div'+Class+sty+' >S</div>';
		if(Cal.show8dayWeek) calHTML+='<div'+Class+sty+'  >S</div>';
	}

	if(Cal.typeWeekNames == 'medium') {
		calHTML+='<div'+Class+sty+'>Sun</div><div'+Class+sty+'>Mon</div><div'+Class+sty+'>Tue</div>';
		calHTML+='<div'+Class+sty+'>Wed</div><div'+Class+sty+'>Thu</div>';
		calHTML+='<div'+Class+sty+'>Fri</div><div'+Class+sty+'>Sat</div>';
		if(Cal.show8dayWeek) calHTML+='<div'+Class+sty+'>Sun</div>';
	}

	if(Cal.typeWeekNames == 'long') {
		calHTML+='<div'+Class+sty+'>Sunday</div><div'+Class+sty+'>Monday</div><div'+Class+sty+'>Tuesday</div>';
		calHTML+='<div'+Class+sty+'>Wednesday</div><div'+Class+sty+'>Thursday</div>   ';
		calHTML+='<div'+Class+sty+'>Friday</div><div'+Class+sty+'>Saturday</div>';
		if(Cal.show8dayWeek) calHTML+='<div'+Class+sty+'>Sunday</div>';
	}
  calHTML+='</div> '
	 
  var Column = 1;
  WeekArray = new Array();
  
  //calHTML+='</div>';
  calHTML+='<div id=WeekContainer class=WeekContainer valign=top >';
	
	var dayW=(Cal.show8dayWeek) ? '12.5%' : '13%';
	var lastDay=(Cal.show8dayWeek) ? 8 : 7;
  for (var dayI = 1; dayI<=lastDay; dayI++) {
		var dayNum=WeekDayNumbers[dayI];
		
		if(WeekFullDates[dayI]==todayAll) {
			calHTML+='<div style="border:'+Cal.borderDays+'; background:#ff0; height:87%; Width:'+dayW+'; float:left; ">';
			calHTML+='	<div id="TodayHeader" onclick="Make_Day('+inst+','+Year+','+CurrentMonth+','+dayNum+')" class="DayHeaderTodayDiv" onmouseover="Gebi(\'HoverNotes\').style.visibility=\'hidden\';" style="background:'+Cal.colorTodayTopBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+';">' +dayNum+ '</div>';
			calHTML+='	<div id="" class=DayContainerDIV onclick="ShowEventModal(\'Week\','+inst+',\' '+WeekFullDates[dayI]+' \','+dayNum+');" onmouseover="  HoverUpdate(\' '+WeekFullDates[dayI]+' \');  this.style.backgroundColor=\''+Cal.colorToDayMouseOver+'\';" onmouseout="this.style.backgroundColor=\''+Cal.colorTodayBG+'\'" style="background:'+Cal.colorTodayBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+' ">';
			calHTML+='		<div class=DayBox id="Day'+WeekFullDates[dayI]+'" style="width:100%;"></div>';
			calHTML+='	</div>';
			calHTML+='</div>';
			
			WeekArray[dayI] = WeekFullDates[dayI];
		}
		else { 
			calHTML+='<div  style="border:'+Cal.borderDays+'; height:87%; Width:'+dayW+'; float:left;">';
			calHTML+='	<div id="DayHeader" onclick="Make_Day('+inst+','+Year+','+CurrentMonth+','+dayNum+')" class=DayHeaderDiv style="background:'+Cal.colorCalDayHeadersBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+';" onMouseOver="Gebi(\'HoverNotes\').style.visibility=\'hidden\';" >' +dayNum+ '</div>';
			calHTML+='	<div id=""  class=DayContainerDIV onclick="ShowEventModal(\'Week\','+inst+',\' '+WeekFullDates[dayI]+' \','+dayNum+');" onmouseover="  HoverUpdate(\' '+WeekFullDates[dayI]+' \'); this.style.backgroundColor=\''+Cal.colorDayMouseOver+'\';" onmouseout="this.style.backgroundColor=\''+Cal.colorCalendarBG+'\'" style="background:'+Cal.colorCalendarBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+' ">';
			calHTML+='	<div class=DayBox id="Day'+WeekFullDates[dayI]+'" style="width:100%;"></div>';
			calHTML+='	</div>';
			calHTML+='</div>';
			
			WeekArray[dayI] = WeekFullDates[dayI];
		}
		Column++;
	}
	calHTML+='	</div>';//calHTML+='</div>';
	//calHTML+='</div>';
	calHTML+='</div>';

	YearShowing = Year;
	WeekShowing = Week;	
	ViewShowing = 'Week';
	
	offsetX = +30;
	offsetY = -25;
	//if(offsetY == 0){offsetY = 0;}else{offsetY = 0}; 
	
	WeekEventsAJAX(WeekArray); //Fills out the Week events
   
	Gebi('Calendar'+inst).innerHTML=calHTML;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

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
		
		var Cal=eval('this.defaults'+inst);
		
		var calHTML = '<div class="CalendarMainDIV" style="">';
		
		calHTML +=	 '<button id="ReloadFrame" onClick="window.location=window.location"><img src="../../images/reloadblue24.png" width="100%" height="100%"/></button>';
					
		calHTML+='<div style="" class ="Topheader">Day Planner';
		calHTML+='</div>';
		
		calHTML+='<div style="" class ="TopControl"  onMouseOver="">';
					
				
		calHTML+='<div class ="PrevDiv">';
		calHTML+='<button class="buttonPrev" onclick="DaySkip('+inst+',\'-\','+sYear+','+sMonth+','+sDay+')"';
		calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
		calHTML+='<<</button>';
		calHTML+='</div>';
		
		calHTML+='<div class ="NextDiv">';
		calHTML+='<button class="buttonNext" onclick="DaySkip('+inst+',\'+\','+sYear+','+sMonth+','+sDay+')"';
		calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
		calHTML+='>></button>';
		calHTML+='</div>';
		
		calHTML+='<div class ="TodayDiv">';
		calHTML+='<button class="buttonToday" onclick="DayToday('+inst+')"';
		calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
		calHTML+='Today</button>';
		calHTML+='</div>';
							
		calHTML+='<div class ="DateHeadDIV">';
		calHTML+='<div class="DateHead">'+DateHead+'</div>';
		calHTML+='</div>';
		
		calHTML+='<div class ="EventDiv">';
		calHTML+='<button id="btnEvent"  class="buttonEvent" onclick=""';
		calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
		calHTML+='Create Event</button>';
		calHTML+='</div>';
		
		calHTML+='<div class ="MonthDiv">';
		calHTML+='<button class="buttonMonth" onclick="GoToDateMonth('+inst+','+sYear+','+MonthNow+');"';
		calHTML+='style="color:'+Cal.colorButton+';  font-family:'+Cal.fontButton+';  font-size:'+Cal.sizeButton+';  font-weight:'+Cal.weightButton+'; height:'+Cal.heightButton+';">';
		calHTML+='Month</button>';
		calHTML+='</div>';
	
		calHTML+=' </div>';

//calHTML+='<div class="divMain" style="" border="0" cellpadding="0" cellspacing="0" >';
		
		calHTML+='<div class="trWeekdayNames" style=" border:'+Cal.borderWeekNames+'; background:'+Cal.colorWeekNamesBG+'; color:'+Cal.colorWeekNames+'; font-family:'+Cal.fontWeekNames+'; font-size:'+Cal.sizeWeekNames+'; font-weight:bold;">';
		//calHTML+='<div>';
						
		calHTML+='<div style="border:'+Cal.borderDays+'; background:#ff0; height:100%; Width:100%; ">';
		calHTML+='	<div id="sDayEvents" class="DayContainerDIV" style="background:'+Cal.colorCalendarBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+'; font-size:'+Cal.sizeDayNums+'; font-weight:'+Cal.weightDayNums+' ">';
		calHTML+='		<div id="TodayHeader" class="DayHeaderTodayDiv" style="background:'+Cal.colorCalDayHeadersBG+'; color:'+Cal.colorDayNums+'; font-family:'+Cal.fontDayNums+';" onmouseover="Gebi(\'HoverNotes\').style.visibility=\'hidden\';" ></div>';
		calHTML+='	</div>';
		calHTML+='</div>';

    calHTML+='</div>';
	//calHTML+='</div>';
    calHTML+=' </div>';
	
	MonthShowing = sMonth;
	DayShowing = sDay;
	YearShowing = sYear;	
	ViewShowing = 'Day';
	DayEventsAJAX(dateAll);
   
	Gebi('Calendar'+inst).innerHTML = calHTML;
	
	if(Cal.threeMoControl) {
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
function GoToDateMonth(inst,sYear,sMonth)  {
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
	
	
	if (aYear !='Year' || aMonth !='Month') {
		//alert(aYear+', '+aMonth);
		Selected_Year = aYear;
		Selected_Month = (aMonth-1);//because the index of Month is one ahead of the month number
		
		var count = 3; //number of additional calendars to update
		var Direction = '-';
		
		Make_Calendar(Selected_Year, Selected_Month,inst,count,Direction); 
	}
	else {
	    alert('Please Select A Month And Year');	
	}
    
}


//Cal>> Moves the calendar Fwd or Back
function Skip(Direction,inst) {
	if (Direction == '+') {
		if (Selected_Month == 11) {
			Selected_Month = 0;
			Selected_Year++;
		}
		else{Selected_Month++;}
	}
 
	if (Direction == '-') {
		if (Selected_Month == 0) {
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
   
   if (NewWeek >= 51) {
		 NewWeek-=52;
		 Year++;
		 Year++;
	 }
   if (NewWeek < 1) {
		 NewWeek+=52;
		 Year--;
		 Year--;
	 }
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
	
	if (Direction == '+') {
		if(Day == CurMonthLastDay) {
			NewDay = (1);
			
			if(Month == 12) {
				NewMonth = (1);
				NewYear = (parseInt(Year)+1);
			}
			else {
				NewMonth = (parseInt(Month)+1);
				NewYear = Year;
	        }
		}
		else {
			NewDay = (parseInt(Day)+1);
			NewMonth = Month;
			NewYear = Year;
		}
	}

	if (Direction == '-') {
		if(Day == 1) {
			NewDay = (LastMonthLastDay);
			
			if(Month == 1) {
				NewMonth = (12);
				NewYear = (parseInt(Year)-1);
			}
			else {
				NewMonth = (parseInt(Month)-1);
				NewYear = Year;
	        }
		}
		else {
			NewDay = (parseInt(Day)-1);
			NewMonth = Month;
			NewYear = Year;			
		}
	}
	
	Make_Day(inst,NewYear,NewMonth,NewDay);
}

//DayGo Go to this date
function GoToDateDay(inst,sYear,sMonth)  {
   Make_Day(inst,sYear,sMonth,sDay);
}

//Events For Days--------------------------------------------------------------------------