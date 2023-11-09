/* 
Usage:
var p = new pie();
p.add("title1",value1);
p.add("title2",value2);

p.render("canvas_name", "graph title");

//where canvas_name is a div defined INSIDE body tag
<body>
<div id="canvas_name" style="overflow: auto; position:relative;height:400px;width:400px;"></div>
*/


hD="0123456789ABCDEF";

function d2h(d) 
{
 var h = hD.substr(d&15,1);
 while(d>15) {d>>=4;h=hD.substr(d&15,1)+h;}
 return h;
}


function h2d(h) 
{
 return parseInt(h,16);
}


function pie() {
 this.ct = 0;
 this.ctA = 0;
 
 this.data      = new Array();
 this.x_name    = new Array();
 this.max       = 0;
 
 this.c_array = new Array();
 this.cAlpha_array = new Array();
 
 var opacity=.25;
 /**/
 this.c_array[0] = 'rgb(255, 192, 95)';
 this.cAlpha_array[0] = 'rgba(255, 192, 95,'+opacity+')';
 this.c_array[1] = 'rgb(198, 136, 213)';
 this.cAlpha_array[1] = 'rgba(198, 136, 213,'+opacity+')';
 this.c_array[2] = 'rgb(255, 128, 0)';
 this.cAlpha_array[2] = 'rgba(255, 128, 0,'+opacity+')';
 this.c_array[3] = 'rgb(28, 128, 202)';
 this.cAlpha_array[3] = 'rgba(28, 128, 202,'+opacity+')';
 this.c_array[4] = 'rgb(0, 213, 213)';
 this.cAlpha_array[4] = 'rgba(0, 213, 213,'+opacity+')';
 this.c_array[5] = 'rgb(121, 77, 13)';
 this.cAlpha_array[5] = 'rgba(121, 77, 13,'+opacity+')';
	
	var aIndex=5;
 /** /
	
	var aIndex= -1;
/**/
	var r,g,b;
	for(ir=0;ir<=2;ir++)
	{
		r=Math.abs((ir*128)-1);
		for(ig=0;ig<=2;ig++)
		{
			g=Math.abs((ig*128)-1);
			for(ib=0;ib<=2;ib++)
			{
				b=Math.abs((ib*128)-1);
				if(r==g&&g==b){}
				else
				{
					///alert(r+','+g+','+b);
					aIndex++;
					this.c_array[aIndex] = 'rgb('+r+', '+g+', '+b+')';
					this.cAlpha_array[aIndex] = 'rgba('+r+', '+g+', '+b+','+opacity+')';
				}
			}
		}
	}
 /** /
 this.c_array = new Array();
 this.c_array[0]='#FFC05F';
 this.c_array[1]='#C6882D';
 this.c_array[2]='#FF8000';
 this.c_array[3]='#1C80CA';
 this.c_array[4]='#00D5D5';
 this.c_array[5]='#794DD5';
 this.c_array[6]='#00ff00';
 this.c_array[7]='#0000ff';
 this.c_array[8]='#00ff00';
 this.c_array[9]='#00ffff';
 this.c_array[10]='#ff0000';
 /** /
 this.c_array[0] = new Array(255, 192, 95);
 this.c_array[1] = new Array(0, 213, 213);
 this.c_array[2] = new Array(159, 87, 112);
 this.c_array[3] = new Array(111, 120, 96);
 this.c_array[4] = new Array(224, 119, 96);
 this.c_array[5] = new Array(80, 159, 144);
 this.c_array[6] = new Array(207, 88, 95);
 this.c_array[7] = new Array(64, 135, 96);
 this.c_array[8] = new Array(239, 160, 95);
 this.c_array[9] = new Array(144, 151, 80);
 this.c_array[10] = new Array(255, 136, 80);
 /**/

 this.getColor = function()
  {
   if(this.ct >= (this.c_array.length-1))
      this.ct = 0;
   else
      this.ct++;

   return this.c_array[this.ct];
   //return "#" + d2h(this.c_array[this.ct][0]) + d2h(this.c_array[this.ct][1]) + d2h(this.c_array[this.ct][2]);
  }

 this.getAlphaColor = function()
  {
   if(this.ctA >= (this.cAlpha_array.length-1))
      this.ctA = 0;
   else
      this.ctA++;

   return this.cAlpha_array[this.ctA];
  }

 this.add = function(x_name, value, Colr)
  {
   this.x_name.push(x_name);  
   this.data.push(parseInt(value,10));
   this.Colr=Colr;
	 
   this.max += parseInt(value,10);
  }

 this.fillArc = function(x, y, r, st_a, en_a, jg)  {
    //var number_of_steps = Math.round(2.1 * Math.PI * r );
    var number_of_steps = (en_a - st_a)*100 ;
    var angle_increment = 2 * Math.PI / number_of_steps;

    var xc = new Array();
    var yc = new Array();

    st_r = st_a*Math.PI / 180;
    en_r = en_a*Math.PI / 180;

   
    for (angle = st_r; angle <= en_r; angle += angle_increment) {
			if(en_r < angle + angle_increment) angle = en_r;
			var y2 = Math.sin(angle) * r ;
			var x2 = Math.cos(angle) * r ;
			
			xc.push(x+x2);
			yc.push(y-y2);
			//jg.drawLine(x+x2, y-y2, x+x2, y-y2);
		}
    xc.push(x);
    yc.push(y);
    jg.fillPolygon(xc, yc);
    //jg.setColor("black");
    //jg.drawLine(x, y, x+ln_x, y-ln_y);
  }

 this.render = function(canvas, title)
  {
	 var canvasObj=document.getElementById(canvas)
   var jg = new jsGraphics(canvas);
	 
	 var smallDim=canvasObj.offsetHeight;
	 if(canvasObj.offsetHeight>canvasObj.offsetWidth) smallDim=canvasObj.offsetWidth;
	 
	 var r  = Math.round(smallDim/2.25);

	 var sx = Math.round(canvasObj.offsetWidth/2);//200;
   var sy = Math.round(canvasObj.offsetHeight/2)-12;//75;
   var hyp = Math.round(r*.8);
   var fnt = 14;
	 var txtSh='none';
   var bkg = 'none';//rgba(255,255,255,.5)';

	// shadow
   jg.setColor("gray");
   //this.fillArc(sx+5, sy+5, r, 0, 360, jg);
   jg.fillEllipse(sx+3-r, sy+5-r, 2*r, 2*r);

		var st_angle = 0;
		for(i = 0; i<this.data.length; i++) {
			var angle = Math.round(this.data[i]/this.max*360);
			
			var pc    = Math.round(this.data[i]/this.max*10000)/100;
			var dollars=formatCurrency(this.data[i]);
		
			jg.setColor(this.getColor());
			jg.setAlphaColor(this.getAlphaColor());
			
			//jg.setColor('#'+this.Colr);
			this.fillArc(sx, sy, r, st_angle, st_angle+angle, jg);

			var ang_rads = (st_angle+(angle/2))*2*Math.PI/360;
			var my  = (Math.sin(ang_rads) * hyp)+48;
			var mx  = Math.cos(ang_rads) * hyp-32;
			
			st_angle += angle;
			
			mxa = (mx < 0 ? 50 : 0);
			//mxa+=8;
			//jg.setColor("black");
			jg.ftSz=fnt+'px';
			jg.txtSh=txtSh;
			jg.ftFam='Calibri';
			jg.bkg=bkg;
			var dsX=Math.round(sx+mx-mxa);
			var dsY=Math.round(sy-my+12);
			jg.drawString(this.x_name[i]+"&nbsp;"+pc+"%<br/>"+dollars,dsX,dsY);
			//jg.drawString(this.x_name[i],sx+mx-mxa,sy-my);
		}
		jg.setColor("none");
		jg.drawEllipse(sx-r, sy-r, 2*r, 2*r);
		jg.paint();
	}
}
