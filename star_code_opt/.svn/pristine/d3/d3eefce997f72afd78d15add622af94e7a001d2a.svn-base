var op;
var checkval=-1;
var other=1;
var donotdisturb=0;
function creatediv() {
	
//Ajax call to check whether to popup or not
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }

	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  //alert("and length is=-->>"+xmlhttp.responseText);
		  if(xmlhttp.responseText.substring(0, 3)=='yes')
			 {  
			 ajaxReponse();
			 }
	    }
	  }
	xmlhttp.open("GET","Mobile_Survey/jsp/MobileAjax.jsp?reportFlag=@@@@",true);
	xmlhttp.send();
}
function makereal()
{	
	//alert("in makereal");
	var newdiv = document.createElement('div');
	newdiv.setAttribute('id', "AdSpeed_AdBody");
	newdiv.style.width = 220;
	newdiv.style.height = 100;           
	newdiv.style.position = "absolute";
	newdiv.style.top="600px";
	setTimeout("",1000);
	newdiv.innerHTML = "<table id='divtable' BORDERCOLOR='000000' border=1px style='border-collapse: collapse' cellspacing=0><tr><td background='Mobile_Survey/images/gradient.gif' colspan=3><div align='justify' style='font-size: 17px;font-weight: bold;font-family: serif,sans-serif;float:left;'>Mobile Info Survey</div><div align=right style='float:right;'><img src='Mobile_Survey/images/close.png?buildstamp=2_0_0' id='close'	style='cursor: hand' alt='Close' onmouseout='changeoc();'onmouseover='changeclose();' onclick='closeAdSpeedFloatingAd();'></img></div></td></tr><tr><td><font size='1'>	<select id='mobile_make' style='font-family:verdana;color:black;font-size:10px' onchange='GetHandset();'>"+op+"</select></font></td><td background='Mobile_Survey/images/gradient.gif'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td id='std'><select id='handset' style='font-family:verdana;color:black;font-size:10px'><option value='0'>Select Your Handset</option></select></td></tr><tr><td colspan=3 style='border-bottom: none;' background='Mobile_Survey/images/gradient.gif'><input type='checkbox' id='checkbox-1' value='checkbox-1' onclick='checkboxevent()' /><label for='checkbox-1' style='font-family:verdana;color:black;font-size:12px'>Don't Show this again</label></td></tr><tr><td colspan=3 background='Mobile_Survey/images/gradient.gif' align='center' style='border-top: none;'><img src='Mobile_Survey/images/next.jpg'  id='go' alt='Submit' style='cursor: hand'	onclick='imgclick();' onmouseout='changegc();'	onmouseover='changegp();'></img></td></tr></table></table>";
	document.body.appendChild(newdiv);
	var bodyID = document.getElementsByTagName("body")[0];
	var newScript = document.createElement('script');
	newScript.type = 'text/javascript';
	newScript.src = 'Mobile_Survey/js/extmain.js';
	bodyID.appendChild(newScript);
}
function changeclose() {
	document.getElementById('close').setAttribute('src', 'Mobile_Survey/images/closec.png?buildstamp=2_0_0');
}
function changeoc() {
	document.getElementById('close').setAttribute('src', 'Mobile_Survey/images/close.png?buildstamp=2_0_0');
}
function changegc() {
	document.getElementById('go').setAttribute('src', 'Mobile_Survey/images/next.jpg');
}
function changegp() {
	document.getElementById('go').setAttribute('src', 'Mobile_Survey/images/nextc.jpg');
}
function ajaxReponse()
{
	//alert('ajaxresponse');
	var opt="";
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }

	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  opt= xmlhttp.responseText;
		  op=opt;
		  makereal();
	    }
	  }
	xmlhttp.open("GET","Mobile_Survey/jsp/MobileAjax.jsp?reportFlag=make",true);
	xmlhttp.send();
}
function GetHandset() 
{
	if(other==0)
		{
		document.getElementById('std').innerHTML="<select id='handset' style='font-family:verdana;color:black;font-size:10px'><option>Select Your Handset</select>";
		}
	checkval=0;
	var siteId =document.getElementById('mobile_make').getAttribute('value');
	if(siteId==0)
		{
		genTextBox();
		}
	else
{
		var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		jQuery("#handset").html(xmlhttp.responseText);
	    }
	  }
	xmlhttp.open("GET","Mobile_Survey/jsp/MobileAjax.jsp?reportFlag=make"+siteId,true);
	xmlhttp.send();
}
}
function imgclick()
{
	var handset="";
	var combined="";
	if(checkval==-1&&donotdisturb==0)
		{
		alert("Please select your handset");
		document.getElementById('mobile_make').focus();
		}
	else
		{
		handset=document.getElementById('handset').value;
		if(donotdisturb==0&&handset.length==0)
			{
			alert("Please type in your handset");
			document.getElementById('handset').focus();
			return false;
			}
		else
		if(donotdisturb==0)
		handset=document.getElementById('handset').value;
		if(handset==-2&&donotdisturb==0)
		{
			alert("Please select your handset");
			document.getElementById('handset').focus();
		}
		else
			{
	var mobile_make=document.getElementById('mobile_make')[document.getElementById('mobile_make').selectedIndex].innerHTML;
	if(donotdisturb==1)
	combined="**";
	else
	combined=mobile_make+"##"+handset;
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }

	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  opt= xmlhttp.responseText;
	    }
	  }
	xmlhttp.open("GET","Mobile_Survey/jsp/MobileAjax.jsp?reportFlag="+combined,true);
	xmlhttp.send();
	closeAdSpeedFloatingAd();
		}
}
}
function genTextBox()
{
	other=0;
	document.getElementById('std').innerHTML="<input type='text' style='font-family:verdana;color:black;font-size:10px' id='handset' size=22>";
}
function checkboxevent()
{
	if(donotdisturb==0)
		{
		document.getElementById('mobile_make').disabled=true;
		document.getElementById('handset').disabled=true;
		donotdisturb=1;
		}
	else
		{
		document.getElementById('mobile_make').disabled=false;
		document.getElementById('handset').disabled=false;
		donotdisturb=0;
		}
}