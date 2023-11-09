<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Color Generator</title>

<style>
body,html {margin:0; padding:0; width:100%; height:100%;}
div {overflow:hidden; white-space:normal;}

.sBox { float:left; height:100%; width:100%; margin:0; padding:0; }
.lBox { float:left; height:100%; width:100%; margin:0; padding:0; }
.cBox { float:left; height:100%; width:7%; margin:0; padding:0; text-align:right; font-family:Calibri; font-weight:bold;}
.w3 {width:3%;}
.dBox { float:left; height:100%; width:14%; margin:0; padding:0; text-align:center; font-family:Calibri; font-weight:bold;}
.row { height:4.75%; width:99%; font-size:14px; padding-left:.5%; }
.titles div { border-top-left-radius:50% 25%; border-top-right-radius:50% 25%; line-height:12px; }
.dRow { height:10%; width:100%; font-size:14px; padding-left:.5%; }
.shadeBox { float:left; height:144px; width:1024px; font-size:14px; }
.shadeRow { height:144px; width:576px; font-size:14px; }
</style>

<script type="text/javascript">

function dec2hex(dec) {
	var hex='';
	var hDigit=new Array('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f');
	if(dec>65535) return false;
	var digit;
	digit=(dec / 16)+'';
	digit=digit.split('.')[0];
	hex=hex+hDigit[digit]
	/** /
	dec=(dec-digit)/16;
	
	//digit= dec / 16;
	digit=(dec / 16)+'';
	digit=digit.split('.')[0];
	hex=hex+hDigit[digit]
	dec-=digit;
	/**/	
	return hex+hex;
}


function cc(c) { //Calculates r g or b value
	var result=(c*128)-1;
	if (result<0) result=0;
	return result;
}

var r255=1/255;
var R=0;
var G=0;
var B=0;
var L=2;
var S=0;

/** /	
/** /
for(R=0; R<=4; R=R+2) {
	for(G=0; G<=4; G=G+2) {
		document.write('<div class=shadeRow >');
		for(B=0; B<=4; B=B+2) {
			document.write('<div class=shadeBox>');
			for(S=0; S<=4; S++) {
				document.write('<div class=row>');
				for(L=4; L>=0; L--) {
					document.write('<div class=cBox style="background:rgb('+cc(R)+','+cc(G)+','+cc(B)+');">');
					document.write('	<div class=lBox style="background:rgba(0,0,0,'+cc(L)*r255+');">');
					document.write('		<div class=sBox style="background:rgba(255,255,255,'+cc(S)*r255+');">&nbsp;</div>');
					document.write('	</div>');
					document.write('</div>');
				}
				document.write('</div>');
			}
			document.write('</div>');
		}
		document.write('</div>');
	}
}
/** /
/**/

function rgbsl(r,b,g,s,l) {
	return Array(r,g,b);
}

var color= new Array();
var cI=0;
////document.write('<div class=shadeRow >');
////document.write('<div class=shadeBox>');
//document.write('<div class=row>');
for(R=0; R<=2; R++) {
	for(G=0; G<=2; G++) {
		for(B=0; B<=2; B++) {
			color[cI]=rgbsl(cc(R),cc(G),cc(B),0,0)
			//document.write('<div class=cBox style="background:rgb('+color[cI][0]+','+color[cI][1]+','+color[cI][2]+');">'+cI+'</div>');
			cI++;
		}
	}
}
//document.write('</div>');
////document.write('</div>');
////document.write('</div>');

var cOrder=new Array();

// Unused #'s 0, 1, 3, 4, 9, 10, 12, 14, 16, 17, 22, 23, 25, 26

cOrder[0]=color[18];
cOrder[1]=color[19];
cOrder[2]=color[20];
cOrder[3]=color[11];
cOrder[4]=color[2];
cOrder[5]=color[5];
cOrder[6]=color[8];
cOrder[7]=color[7];
cOrder[8]=color[6];
cOrder[9]=color[15];
cOrder[10]=color[24];
cOrder[11]=color[21];
cOrder[12]=color[13];
cOrder[13]=color[13];
/** /
cOrder[14]=color[];
cOrder[15]=color[];
cOrder[16]=color[];
cOrder[17]=color[];
cOrder[18]=color[];
cOrder[19]=color[];
cOrder[20]=color[];
cOrder[21]=color[];
cOrder[22]=color[];
cOrder[23]=color[];
cOrder[24]=color[];
cOrder[25]=color[];
cOrder[26]=color[];
/**/
document.write('<h1>&nbsp; &nbsp; &nbsp;<a href="colorscondense.asp">Click here for a condensed version.</a></h1>');

document.write('<br/>');

var ColorPalette=new Array();
function spitEmOut(start,end) {
	var r, b, g;
	var rI, gI, bI;
	var cpI=9;
	for(s=1; s>=.25; s-=.25) {
		document.write('<div class=row>');
		cpI--;
		ColorPalette[cpI]=new Array();
		for(cOI=start; cOI<=end; cOI++) {
			r=cOrder[cOI][0]; rI=255-r;
			g=cOrder[cOI][1]; gI=255-g;
			b=cOrder[cOI][2]; bI=255-b;
			r+=Math.round(rI*s); rI=255-r;
			g+=Math.round(gI*s); gI=255-g;
			b+=Math.round(bI*s); bI=255-b;
			ColorPalette[cpI][cOI]=new Array(r,g,b)
			document.write('<div class=cBox style="">'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'<br/>rgb('+ColorPalette[cpI][cOI]+')</div>');
			document.write('<div class="cBox" style="background:rgb('+ColorPalette[cpI][cOI]+'); border:1px solid rgb('+rI+','+gI+','+bI+'); color:rgb('+rI+','+gI+','+bI+');"></div>');
			//document.write('<div class=cBox style="background:#'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'; border:1px solid rgb('+rI+','+gI+','+bI+');">'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'</div>');
			//document.write('<div class=cBox style="background:rgb('+r+','+g+','+b+');"></div>');
		}
		document.write('</div>');
	}
	
	document.write('<div class=row>');
	ColorPalette[0]=new Array();
	for(cOI=start; cOI<=end; cOI++) {
		ColorPalette[0][cOI]=cOrder[cOI]
		r=cOrder[cOI][0]; rI=255-r;
		g=cOrder[cOI][1]; gI=255-g;
		b=cOrder[cOI][2]; bI=255-b;
		document.write('<div class=cBox style="">'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'<br/>rgb('+cOrder[cOI]+')</div>');
		document.write('<div class=cBox style="background:rgb('+cOrder[cOI]+'); border:1px solid rgb('+rI+','+gI+','+bI+'); color:rgb('+rI+','+gI+','+bI+');"></div>');
		//document.write('<div class=cBox style="background:#'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'; border:1px solid rgb('+rI+','+gI+','+bI+'); color:#'+dec2hex(rI)+dec2hex(gI)+dec2hex(bI)+';">'+cOI+'<br/>'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'</div>');
	}
	document.write('</div>');
	
	cpI=0;
	for(l=.75; l>=0; l-=.25) {
		document.write('<div class=row>');
		cpI--;
		ColorPalette[cpI]=new Array();
		for(cOI=start; cOI<=end; cOI++) {
			r=Math.round(cOrder[cOI][0]*l); rI=255-r;
			g=Math.round(cOrder[cOI][1]*l); gI=255-g;
			b=Math.round(cOrder[cOI][2]*l); bI=255-b;
			ColorPalette[cpI][cOI]=new Array(r,g,b)
			document.write('<div class=cBox style="">'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'<br/>rgb('+r+','+g+','+b+')</div>');
			document.write('<div class=cBox style="background:rgb('+r+','+g+','+b+'); border:1px solid rgb('+rI+','+gI+','+bI+'); color:rgb('+rI+','+gI+','+bI+');"></div>');
			
			//document.write('<div class=cBox style="background:#'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'; border:1px solid rgb('+rI+','+gI+','+bI+'); color:#fff;">'+dec2hex(r)+dec2hex(g)+dec2hex(b)+'</div>');
		}
		document.write('</div>');
	}
}

/** /
spitEmOut();

document.write('<h4> &nbsp; &nbsp; Now lets make some adjustments to our colors for the sake of our eyeballs! </h4>');
document.write(' &nbsp; Notice how 3, 4, 5, &amp; 6 are very close together in color while 0, 1, & 2 are almost too far apart.  ');
document.write('<br/> In reality these colors are exactly the same far apart, but for the sake of the human eyeball...');
document.write('<br/><br/>Let\'s take out 5 which is Cyan-Green because it too closely resembles Green.');
document.write('<br/>Also let\'s add a Red-Orange and Yellow-Orange');
/**/

cOrder[13]=cOrder[12];
cOrder[12]=cOrder[11];
cOrder[11]=cOrder[10];

cOrder[10]=new Array(192,0,255);//cOrder[9];
//cOrder[9]=cOrder[8];
//cOrder[8]=cOrder[7];
cOrder[7]=new Array(0,160,255);//cOrder[6];
//cOrder[6]=;
cOrder[5]=cOrder[4];
cOrder[4]=new Array(192,255,0);//cOrder[3];
cOrder[3]=cOrder[2];
cOrder[2]=new Array(255,192,0);//cOrder[1];
//cOrder[1]=new Array(255,96,0);

document.write('<div class="row titles" style="max-height:32px;">');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[0]+') solid;">Test/Maint</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[1]+') solid;">Projects/Jobs</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[2]+') solid;">IT / Software&nbsp;Dev</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[3]+') solid;">General Notes</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[4]+') solid;">Estimating / Sales</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[5]+') solid;">Training</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[6]+') solid;">Products/Materials</div>');
document.write('</div>');
spitEmOut(0,6);
document.write('<br/>');
document.write('<div class="row titles" style="max-height:32px;">');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[7]+') solid;">Calendar & TMC Main</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[8]+') solid;">Service</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[9]+') solid;">Engineering</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[10]+') solid;">Office Management</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[11]+') solid;">Private</div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[12]+') solid;"><big><big>☺</big></big></div>');
document.write('	<div class=dBox style="color:#000; background:#fff; border:1px rgb('+cOrder[13]+') solid;" >Administration</div>');
document.write('</div>');
spitEmOut(7,13);
</script>

</head>

<body>

</body>
</html>
