/********************************************************************************** 
SideScrollMenu 
* Copyright (C) 2001 Thomas Brattli
* This script was released at DHTMLCentral.com
* Visit for more great scripts!
* This may be used and changed freely as long as this msg is intact!
* We will also appreciate any links you could give us.
*
* Made by Thomas Brattliand modified byMichael van Ouwerkerk
*
* Script date: 09/07/2001 (keep this date to check versions) 
*********************************************************************************/
function lib_bwcheck(){ //Browsercheck (needed)
this.ver=navigator.appVersion
this.agent=navigator.userAgent
this.dom=document.getElementById?1:0
this.opera5=(navigator.userAgent.indexOf("Opera")>-1 && document.getElementById)?1:0
this.ie5=(this.ver.indexOf("MSIE 5")>-1 && this.dom && !this.opera5)?1:0; 
this.ie6=(this.ver.indexOf("MSIE 6")>-1 && this.dom && !this.opera5)?1:0;
this.ie4=(document.all && !this.dom && !this.opera5)?1:0;
this.ie=this.ie4||this.ie5||this.ie6
this.mac=this.agent.indexOf("Mac")>-1
this.ns6=(this.dom && parseInt(this.ver) >= 5) ?1:0; 
this.ns4=(document.layers && !this.dom)?1:0;
this.bw=(this.ie6 || this.ie5 || this.ie4 || this.ns4 || this.ns6 || this.opera5)
return this
}
var bw=lib_bwcheck()
/**************************************************************************
Variables to set.
***************************************************************************/
sLeft = 0 //The left placement of the menu
sTop = 120 //The top placement of the menu
sMenuheight = 30 //The height of the menu
sArrowwidth = 11 //Width of the arrows
sScrollspeed = 20 //Scroll speed: (in milliseconds, change this one and the next variable to change the speed)
sScrollPx = 8 //Pixels to scroll per timeout.
sScrollExtra = 15 //Extra speed to scroll onmousedown (pixels)

/**************************************************************************
Scrolling functions
***************************************************************************/
var tim = 0
var noScroll = true
function mLeft(){
if (!noScroll && oMenu.x<sArrowwidth){
oMenu.moveBy(sScrollPx,0)
tim = setTimeout("mLeft()",sScrollspeed)
}
}
function mRight(){
if (!noScroll && oMenu.x>-(oMenu.scrollWidth-(pageWidth))-sArrowwidth){
oMenu.moveBy(-sScrollPx,0)
tim = setTimeout("mRight()",sScrollspeed)
}
}
function noMove(){
clearTimeout(tim);
noScroll = true;
sScrollPx = sScrollPxOriginal;
}
/**************************************************************************
Object part
***************************************************************************/
function makeObj(obj,nest,menu){
nest = (!nest) ? "":'document.'+nest+'.';
this.elm = bw.ns4?eval(nest+"document.layers." +obj):bw.ie4?document.all[obj]:document.getElementById(obj);
this.css = bw.ns4?this.elm:this.elm.style;
this.scrollWidth = bw.ns4?this.css.document.width:this.elm.offsetWidth;
this.x = bw.ns4?this.css.left:this.elm.offsetLeft;
this.y = bw.ns4?this.css.top:this.elm.offsetTop;
this.moveBy = b_moveBy;
this.moveIt = b_moveIt;
this.clipTo = b_clipTo;
return this;
}
var px = bw.ns4||window.opera?"":"px";
function b_moveIt(x,y){
if (x!=null){this.x=x; this.css.left=this.x+px;}
if (y!=null){this.y=y; this.css.top=this.y+px;}
}
function b_moveBy(x,y){this.x=this.x+x; this.y=this.y+y; this.css.left=this.x+px; this.css.top=this.y+px;}
function b_clipTo(t,r,b,l){
if(bw.ns4){this.css.clip.top=t; this.css.clip.right=r; this.css.clip.bottom=b; this.css.clip.left=l;}
else this.css.clip="rect("+t+"px "+r+"px "+b+"px "+l+"px)";
}
/**************************************************************************
Object part end
***************************************************************************/

/**************************************************************************
Init function. Set the placements of the objects here.
***************************************************************************/
var sScrollPxOriginal = sScrollPx;




function sideInit(){
//Width of the menu, Currently set to the width of the document.
//If you want the menu to be 500px wide for instance, just 
//set the pageWidth=500 in stead.
pageWidth = (bw.ns4 || bw.ns6 || window.opera)?innerWidth:document.body.clientWidth;

//Making the objects...
oBg = new makeObj('divBg')
oMenu = new makeObj('divMenu','divBg',1)
oArrowRight = new makeObj('divArrowRight','divBg')

//Placing the menucontainer, the layer with links, and the right arrow.
//oBg.moveIt(sLeft,sTop) //Main div, holds all the other divs.
//oMenu.moveIt(sArrowwidth,null)
//oArrowRight.css.width = sArrowwidth;
//oArrowRight.moveIt(pageWidth-sArrowwidth,null)





//Setting the width and the visible area of the links.
if (!bw.ns4) oBg.css.overflow = "hidden";
if (bw.ns6) oMenu.css.position = "relative";

oBg.css.width = pageWidth - 280 +px;
oMenu.css.width = '5000px';
oBg.clipTo(0,pageWidth,sMenuheight,0)
oBg.css.visibility = "visible";
}








//executing the init function on pageload if the browser is ok.
if (bw.bw) onload = sideInit;

window.onresize = sideInit;