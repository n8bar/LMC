// JavaScript Document

////////////////////
var IEver=0;
function getInternetExplorerVersion()
// Returns the version of Internet Explorer or a -1
// (indicating the use of another browser).
{
  var rv = 0; // Return value assumes failure.
  if (navigator.appName == 'Microsoft Internet Explorer')
  {
    var ua = navigator.userAgent;
    var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if (re.exec(ua) != null)
      rv = parseFloat( RegExp.$1 );
  }
  return rv;
}
function checkVersion()
{
  var msg = "You're not using Internet Explorer.";
  IEver = getInternetExplorerVersion();

  if ( IEver > -1 )
  {
  //  if ( IEver >= 8.0 ) 
  //    msg = "You're using a recent copy of Internet Explorer."
  //  else
  //    msg = "Version:"+IEver+"  You should upgrade your copy of Internet Explorer.";
  }
 //alert( msg );
}

checkVersion();




function NiftyAll()
{
	var AllDivs = document.getElementsByTagName("li");
	//alert(AllDivs.length);
	for (var i=0;i<AllDivs.length;i++)
	{
		//alert(AllDivs[i].offsetWidth);
		//AllDivs[i].style.width=(AllDivs[i].offsetWidth)+'px';
		Nifty("li#"+AllDivs[i].id,"medium transparent left");
	}
		//alert('MainTab'+(AllDivs.length-1));
		document.getElementById('MainTab'+(AllDivs.length-2)).style.background = '#6CBDE2';
		Nifty("li#"+AllDivs[AllDivs.length-1].id,"medium transparent right");
}
//////////////////////////////////////
