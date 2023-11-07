
function Resize()
{
	Gebi('Right').style.width=Gebi('Overall').offsetWidth-Gebi('Left').offsetWidth+'px';
}


function toggleCal(key,color,chk)
{
	var thisBit = chk.checked;
	var label=Gebi(chk.id.replace('chk','Toggle'));
	
	var src=Gebi('CalFrame').src;
	var calString='&src=tricomlv.com_'+key+'%40group.calendar.google.com&color=%23'+color;
	
	//alert(src+'; '+calString+'; '+src.indexOf(calString));
	
	if(thisBit)
	{
		src=src+calString;	
		label.style.backgroundColor='#'+color;
		label.style.color='#FFF';
	}
	else
	{
		while(src.indexOf(calString)!=-1){src=src.replace(calString,'')}
		label.style.color='#000';//+color;
		label.style.backgroundColor='#FFF';
	}
	
	if(Gebi('CalFrame').src!=src)
	{
		//alert(Gebi('CalFrame').src+', '+src);
		Gebi('CalFrame').src=src;
	}
}

function load1x1()
{
	inputs=document.getElementsByTagName('input')
	for(i=0;i<inputs.length;i++)
	{
		if(inputs[i].type=='checkbox'&&inputs[i].className=='chkCalToggle'&&inputs[i].value=='1')
		{
			inputs[i].checked=true;
			inputs[i].onchange();
}	}	}