/*
  JSClock v0.1
  Copyright (c) 2003 Bogdan Ionescu (bogdan@febee.ro)
  This script is distributed under the terms of the LGPL (gnu.org)
*/




//using clockHandler so that if there are more instance of JSClock they will
//be synchronized

function clockHandler () {
    var handlers = new Array();
    var time, oldTime;
    this.registerClock = function(clock) {
        handlers.push(clock);
    }
    this.unregisterClock = function(obj) {
        for(var i=handlers.length; --i>=0;)
          if(handlers[i] == obj) handlers.splice(i,1);
    }
  
    setInterval( function() {
        var t = new Date();
    
        for(var i=handlers.length;--i>=0;) {
            if(handlers[i].drawS(t.getSeconds()) == 0) 
                if(handlers[i].drawM(t.getMinutes()) % 10)        
                    handlers[i].drawH(t.getHours(), t.getMinutes() );
        }
    }
                 , 500); //calling two times per second for a smooth transition
}

var CH = new clockHandler();




// JSClock is the main function
// Passing the id parameter you can use style sheets
// Example:
//    <stylesheet type='text/css'>
//      #cl2 {color:blue;
//          text-decoration:underline;}
//    </stylesheet>
// <script>
// var jsc = new JSClock('cl2');
// jsc.start();
// </script>
// The result is that the hours are displayed as blue and underlined

/*
 * Member functions:
 * start()         - the main function, it will start the clock
 * setTime(t)      - used for seting a different time
 * setParent(p)    - draws the clock inside p node (as opposed to document.body)
 * drawC(c)        - draws a circle of colour c, representing the edge of the clock
 * setHours(ha,hp) - changes the default arabic hours displayed. For AM and PM
 */
function JSClock(id) {
    var obj, hline, mline, sline, cline, dline, size = 100;
    var hlines, mlines, slines, mozline;

    var fontSize;
    var hoursTypeAM;
    var hoursTypePM;  
    var parent = document.body;
    var id = id;
    var H = 0;
    var M = 0;
    var S = 0;
	var sizeS = 1.8;
	var sizeM = 2;
	var sizeH = 2.3;
    
    this.init = function() {
        obj = document.createElement('DIV');
        obj.id = id;
        obj.style.width= 2*size +'px';
        obj.style.height = 2*size + 'px';
        parent.appendChild(obj);

        cline = document.createElement('DIV');
        cline.style.position = 'absolute';        
        hline = cline.cloneNode(false);
        mline = cline.cloneNode(false);    
        dline = cline.cloneNode(false);
    
    
        obj.appendChild(cline);
        obj.appendChild(dline);
        obj.appendChild(hline);
        obj.appendChild(mline);
                
        slines = new Array();
        mlines = new Array();
        /*
         * using this array to prevent some memory leaks in mozilla and opera.
         * the memory leak is created on a piece of code like:
         * obj.innerHTML = '<div style=""></div>'     
         * if you do this in a loop, both browser will continuously alloc memory
         * for the style and wont delete it altough it should.
         */
    
    }

    // use this function if you want your JSClock to display starting from a 
    // different time than your computer has.
    // Example: 
    // jsc = new JSClock(50);
    // newTime = new Date(new Date().getTime() - 10*60*1000 + 15000) 
    // jsc.setTime(newTime);
   
    this.setTime = function (t) {
        var tt = t - new Date();
        S = parseInt(tt/1000)%60;
        M = parseInt(tt/60000)%60;
        H = parseInt(tt/1000*3600)%24;    
        this.display();                
    }

    // use this if you want to create the JSClock as child of one of the nodes
    // Example: jsc.setParent(document.getElementById('myObject'));
    // If a parent is not specified the JSClock will be a child of document.body
    this.setParent = function( p ) {    
        p.appendChild(obj);    
    }

    // sets the font size of the'hours' displayed
    // Example: jsc.setFontSize(18)
    this.setFontSize = function( s ) {
        fontSize = s;
        dline.innerHTML = this.drawHours(size,size,size*(9/10),fontSize, this.getHoursType());
    }


    
    // use it if you want to change the default displaying behavior (normal digits)
    // You can also specify a different display for AM/PM
    // Example I:
    // var hrs2 = new Array('','I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII');
    // jsc.setHours(hrs2); The clock will display roman characters
    // Example II:
    // var hrs1 = new Array('','13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24');
    // jsc.setHours('',hrs1); will display the specified hours if its past the noon
    this.setHours = function( ha, hp ) {    
        hoursTypeAM = ha;
        hoursTypePM = hp ? hp : ha;
    }


    
    //the size of the clock
    this.setSize = function ( s ) {
        size = isNaN(s) ? 50 : s;
    }


    
    //not implemented yet
    this.setAlarm = function ( t ) {
    }


    
    this.getHoursType = function() {    
        return ((new Date()).getHours() < 12 ?hoursTypeAM:hoursTypePM);   
    }


  
    // draws a circle of colour c representing the edge of the clock
    // Drawback: In mozilla it slows down the process (for big sized clocks)  
    this.drawC = function (c) {
        var cc = document.createElement('DIV');
        cc.style.position='absolute';
        cc.innerHTML = this.drawCircle(  size, size, size, c?c:'black');    
        cline.appendChild(cc); 
        // workaround for mozilla. it sort of improves the speed
    
    }
  

    // draws the line for seconds. It's more complicated than it should
    // because mozilla and opera generate some memory leaks
    this.drawS = function (s){
        var ss = (s+1)%60;
        var angle= -Math.PI/2+(Math.PI/30)*(S + s);            
        var sangle= -Math.PI/2+(Math.PI/30)*(S + ss);
    
        if(sline == s) {return (s + S)%60;}            
        if(!slines[s]) {      
            slines[s]=document.createElement('DIV');
            slines[s].style.position='absolute';      
            slines[s].innerHTML = this.drawT(size,size,angle,1.2,'Blue');      
            obj.appendChild(slines[s]);
        }    
        else
        obj.appendChild(slines[s]);

        slines[s].style.display='';    
        if(slines[sline]) {obj.removeChild(slines[sline]); }
   
        sline = s;       
        return (s + S)%60;
    }

    this.drawM = function (m){          
        var angle= -Math.PI/2+(Math.PI/30)*(m+M);
        if(!mlines[m]) mlines[m] = this.drawT(size, size, angle, 1.5, '#0C3758',2);
        mline.innerHTML = mlines[m];
        return (m + M) % 60;
    }

    this.drawH = function (h, m){                  
        var angle= -Math.PI/3 + (Math.PI/30) * (h - ((M+m)<30) + H) * 5;    
        hline.innerHTML = this.drawT(size, size, angle,2.5, '#0C3758', 3);
        return (h+H)%24;
    }

 
    this.display = function () {                
        this.setFontSize(fontSize);
        t = new Date();   
        this.drawS(t.getSeconds());
        this.drawM(t.getMinutes());    
        this.drawH(t.getHours(),t.getMinutes());    
    }

    this.start = function() {
        this.display();
        CH.registerClock(this);
    }
    this.init();
}

JSClock.prototype.drawCircle = function (x,y,r,color) {  
    var HTML = "";
    var txt1= '<div style="position:absolute;background-color:' + color +';';
    var txth='px;width:1px;height:';
    var txtw='px;height:1px;width:';

    var delta=3-(r<<1);
    var xn = r;
    yn = 0,dx=1;

    var xx1,xx2,th,tw
    var x1=x-1;
    do {
        yn++;
        if(delta<0) {
            delta+=(yn<<2)+2;
            dx++;
        }
        else {
            xn--;
            delta+=((yn-xn<<2)+2);
            xx1=x1-xn;
            xx2=x+xn;
            th = txth + dx + 'px;clip:rect(0,1px,' + dx + 'px,0);"></div>';
            tw = txtw+ dx + 'px;clip:rect(0,' + dx + 'px,1px,0);"></div>';
            HTML+=(txt1 + 'left:' + (xx2) + 'px;top:' + (y-yn) + th);
            HTML+=(txt1 + 'left:' + (xx2) + 'px;top:' + (y+yn-dx) + th);
            HTML+=(txt1 + 'left:' + (xx1) + 'px;top:' + (y-yn) + th);
            HTML+=(txt1 + 'left:' + (xx1) + 'px;top:' + (y+yn-dx) + th);

            HTML+=(txt1 + 'left:' + (x+yn-dx+1) + 'px;top:' + (y-xn) + tw);
            HTML+=(txt1 + 'left:' + (x1-yn) + 'px;top:' + (y-xn) + tw);
            HTML+=(txt1 + 'left:' + (x-yn) + 'px;top:' + (y+xn) + tw);
            HTML+=(txt1 + 'left:' + (x + yn-dx) + 'px;top:' + (y+xn) + tw);
            dx=1;
        }
    } while(xn >= yn);
    HTML+=(txt1 + 'left:'+ (x-1) +'px;top:' + (y-r+1) + 'px;height:1px;width:2px;clip:rect(0,2px,1px,0)"></div>');
    return HTML;
}


JSClock.prototype.drawHours = function(x, y, r, fs, hrs) {  
    var HTML = "";      
    var txt='<div style="position:absolute;font-size:' + (fs?fs:(parseInt(r/7) + 'px'));
  
    var pi = Math.PI/30;  
    var angle=-Math.PI/3;
    var xx=r;
    var yy=r;  
    for(var l = 60; l>0; l--) {        
        var xx=Math.cos(angle)*r;
        var yy=Math.sin(angle)*r;
        angle+=pi;
        if(!(l%5)) {
            var h = (13-l/5);
            if(hrs) h=hrs[h];
            HTML+=txt+';left:' + (x + xx-r/25) + 'px; top:' + (y + yy-r/13) + 'px;">' + h + '</div>';    
        }            
    } 
    return HTML;
}

JSClock.prototype.drawT = function( x, y, angle, length, color, t) {
  
    var fx=Math.cos(angle)*(x/length);
    var fy=Math.sin(angle)*(x/length);
    var HTML = this.drawLine(x,y,Math.round(x+fx),Math.round(y+fy), color, t)  
    return HTML;
}

JSClock.prototype.drawLine = function ( Ax,  Ay,  Bx,  By, color, t)
{  
    if(!t) var t = 1;
    var dX, dY, fbXincr, fbYincr, dPr, dPru, P;
    var x0=Ax, x1=Bx, y0=Ay,y1=By;
  
    var HTML =new String();      
    dX=Math.abs(Bx-Ax);
    dY=Math.abs(By-Ay);   
    fbYincr=By<y0?-1:1;
    if (dY <= dX) {            
        if(Ax > Bx) {
            x0 = Bx;
            y0 = By;      
            fbYincr=y0<Ay?1:-1;

        }      
        dPr = dY+1;                         
        P = -dX;                             
        dPru = P;                              
        dY = dX;                          
        var ddx=1;    
        var txt='<div style="position:absolute;height:' + t + 'px;background:'+ color+';clip:rect(0,' ;
        var X;
        var a;
 
        for(var i=dX;i; i--) {
            if ((P+=dPr) <= 0) {             
                               
                if ((dY=dY-1) > 0) {ddx++;;continue;}        
                HTML= HTML.concat(txt +  ddx + 'px,' + t + 'px,0);left:' + (x0)+ 'px;top:' + y0 + 'px;width:'+ ddx + 'px;"></div>');
                return HTML;
            }                     
            HTML= HTML.concat(txt + ddx + 'px,' + t + 'px,0); left:' + (x0) + 'px;top:' + y0 + 'px;width:'+ ddx + 'px;"></div>');
            x0+=ddx;
            y0+=fbYincr;            
            P+=dPru;                    
            if ((dY=dY-1) > 0) {ddx=1;continue; }               
            
            return HTML.concat(txt + ddx + 'px,' + t + 'px,0);left:' + (x0) + 'px;top:' + y0 + 'px;width:'+ ddx + 'px;"></div>');;
        }
    }
    else {  
        fbXincr=Bx<x0?-1:1;    
        if(Ay > By) {      
            x0 = Bx;
            y0 = By;           
            fbXincr=x0<Ax?1:-1;            
        }

        var txt='<div style="position:absolute;width:' + t + 'px;background:'+ color+';clip:rect(0px,' + t + 'px, ';
        dPr = dX+1;
        P = -dY;    
        dPru = P; 
        dX = dY;     
        var ddy=1;
        for(var i=dY;i;i--) {                        
            if ((P+=dPr) <= 0){                        
                if ((dX=dX-1) > 0) {ddy++;continue;}         
                return HTML.concat(txt + ddy + 'px,0px); left:' + x0 + 'px;top:' + (y0) + 'px;height:' + ddy + 'px;"></div>');
            }
            HTML=HTML.concat(txt + ddy + 'px,0px); left:' + x0 + 'px;top:' + (y0) + 'px;height:' + ddy + 'px;"></div>');
            y0+=ddy;
            x0+=fbXincr;   
            P+=dPru;
            if ((dX=dX-1) > 0) {ddy=1;continue;}      
            return HTML.concat(txt + ddy + 'px, 0px); left:' + x0 + 'px;top:' + (y0) + 'px;height:' + ddy + 'px;"></div>');
        }
    }
    return HTML;
}
