 <%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:
 *Date of Creation 		:
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This page is POST page used for get the password when the user forget his/her password
 *Modification 			: 1. Title changed by shiv on  03-12-2007
 *Reason of Modification: Add the link of forget the password when the user forget there password
 						:2 remove the link of stars presentation for user login page 
 *Date of Modification  : Vijay Singh 
 *Modified By	        :12/04/2007
 *Editor				:Editplus
 *Modification:			:Modified by vaibhav on jul 5 2010 to change the mail address of help desk
 
 *Modified By			:ManojChand
 *Modification			:increase the size of forget password
 *Date of Modification	:27 feb 2011
 
 *Modification Date		:04-August-2011
 *Modification			:fetch path of STAR.properties file from web.xml 
 *Modified By			:Manoj Chand
 
 *Modification Date		:04-Jan-2013
 *Modification			:apply hyperlink on 'New Registration' text in login screen. 
 *Modified By			:Manoj Chand
 
 *Modification Date		:24-Oct-2013
 *Modification			:Captcha implemented in login screen. 
 *Modified By			:Manoj Chand
 *******************************************************/
%> 
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="headerIncl.inc" %>
<%@ include  file="cacheInc.inc" %>
<!-- next line added by vaibhav on jul 5 2010 -->
<%@ page  language="java"  import="java.io.*,java.util.*,java.sql.*,src.connection.PropertiesLoader" %>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>WELCOME TO STARS:  SAMVARDHANA MOTHERSON TRAVEL  APPROVAL SYSTEM Version No:- 1.0  </title>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/RightClickDisable.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/CTRLDisable.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>

<%
String strLanguage= request.getParameter("lang")== null ? "en_US" : request.getParameter("lang");
String strUserId= request.getParameter("userid")== null ? "" : request.getParameter("userid");
HttpSession hs = request.getSession(true);
String cnt	= (String)hs.getValue("loginFailureCount")== null ? "" : (String)hs.getValue("loginFailureCount");
String invalidUserPass	= (String)hs.getValue("invalidUserPass")== null ? "" : (String)hs.getValue("invalidUserPass"); 
%>
<script>
//@ VIJAY SINGH ON 12/04/2007 FUNCTION FOR FORGET PASSWORD
function forget_password() {
	if(document.userFrm.Userid.value=='') {
		alert('<%=dbLabelBean.getLabel("alert.login.enterusername",strLanguage)%>');
		document.userFrm.Userid.focus();
		return false;
	} else {
		var name=document.userFrm.Userid.value;
		var language='<%=strLanguage %>';
		MM_openBrWindow('forgetPassword.jsp?uname='+name+'&lang1='+language,'forget','resizable=yes,status=no,top=272,left=253,width=520%  ,height=215%');
	}
}
//END FUNCTION

function checkData(frm) {
  var uname = frm.Userid.value;
  var passw  = frm.Password.value;
  if(uname == "") {
	  alert('<%=dbLabelBean.getLabel("alert.login.entertheusername",strLanguage)%>');
	  frm.Userid.focus();
	  return false;
  }
  if(passw == "") {
	  alert('<%=dbLabelBean.getLabel("alert.login.enterthepassword",strLanguage)%>');
	  frm.Password.focus();
	  return false;
  }

//   if(passw.length < 8)
//   {
<%-- 	alert('<%=dbLabelBean.getLabel("alert.login.invalidpassword",strLanguage)%>'); --%>
// 	frm.Password.value="";
// 	frm.Password.focus();
// 	return false;
//   }
 
  return encryption();
}

function encryption() {
	if('<%=cnt%>' == '3'){ 
	   if(ValidCaptcha()){
		   var password=document.userFrm.Password.value;
		   var newPassword=encrypt(password);
		   document.userFrm.Password.value = "";
		   document.userFrm.hiddenPassword.value=newPassword;
		   //alert("Encrypted pwd with key is being sent to request "+newPassword);
	   		return true;
	   }else
		   return false;
	}else{
		var password=document.userFrm.Password.value;
		var newPassword=encrypt(password);
		document.userFrm.Password.value = "";
		document.userFrm.hiddenPassword.value=newPassword;
		return true;
	}
}

//Remove the spaces from the entered and generated code
function removeSpaces(string) {
    return string.split(' ').join('');
}

function MM_openBrWindow(theURL,winName,features) { 
window.open(theURL,winName,features);
}

function test1(obj1, length, str) {	
	var obj;
	if(obj1=='password')
	{
		obj = document.userFrm.Password;
	}
	if(obj1=='Userid'){
		obj = document.userFrm.Userid;
		upToTwoHyphen(obj);
	}
	if(obj1=='txtInput'){
		obj = document.userFrm.txtInput;
	}
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
}

function callfun() {
window.location.href="sessionExpired.jsp?userid="+userid;   
}

//added by manoj chand on 22 may 2012
function getLanguaeID(){
var lang = document.getElementById("lang").value;
var uid = document.getElementById("Userid").value;
window.location.href='invalidUser.jsp?lang='+lang+'&userid='+uid;
}
//added by manoj chand on 23 oct 2013
function DrawCaptcha() {
    var a = Math.ceil(Math.random() * 10)+ '';
    var b = Math.ceil(Math.random() * 10)+ '';       
    var c = Math.ceil(Math.random() * 10)+ '';  
    var d = Math.ceil(Math.random() * 10)+ '';  
    var e = Math.ceil(Math.random() * 10)+ '';  
    var f = Math.ceil(Math.random() * 10)+ '';  
    var g = Math.ceil(Math.random() * 10)+ '';  
    var code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e ;
    setCapchaCodeToServer(removeSpaces(code));
    if('<%=cnt%>' == '3'){
    	document.getElementById("txtCaptcha").value = code;
    }
}
//added by manoj chand on 03 dec 2013 to implement server side captcha.
function setCapchaCodeToServer(val) // Ajax function to set Captcha Code To Server Session
{
	var XMLHttpRequestObject = null;
	if(window.XMLHttpRequest) {
		XMLHttpRequestObject=new XMLHttpRequest();  
	} else {
			XMLHttpRequestObject=new ActiveXObject("Microsoft.XMLHTTP");
	}
	 var url="AjaxMaster.jsp?strFlag=capchaCodeToServer&code="+val;
	 XMLHttpRequestObject.open("Get",url, true);
	 XMLHttpRequestObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	 XMLHttpRequestObject.send(null);
}
//Validate the Entered input aganist the generated security code function   
function ValidCaptcha(){
    var str1 = removeSpaces(document.getElementById('txtCaptcha').value);
    var str2 = removeSpaces(document.getElementById('txtInput').value);
    if (str1 == str2) return true;
    else{
        alert('<%=dbLabelBean.getLabel("alert.login.verificationcodenot",strLanguage)%>');     
        document.getElementById('txtInput').focus();           
    	return false;
    }
}
</script>


</head>

<%
String strSql          =  null;              
ResultSet rs           =  null;             
String strIPAddress = "127.1.1.1";   
strIPAddress = request.getRemoteAddr();   
strIPAddress = " ["+strIPAddress+"]";
//help_desk_mail added by vaibhav on jul 5 2010
String help_desk_mail="";
String strErrorcodesso =request.getParameter("error_code")==null?"":request.getParameter("error_code");

String strmsg="";
String strReleaseVersion="";

	if (strErrorcodesso.equals("1")) {
		 strmsg ="\n "+dbLabelBean.getLabel("alert.login.windowsuseriddomainnamenotupdated",strLanguage);  
		 
	} else if(strErrorcodesso.equals("2")) {
		 strmsg ="\n "+dbLabelBean.getLabel("alert.login.sessionisalreadyrunning",strLanguage);
	} else if(strErrorcodesso.equals("3")) {
		strmsg ="";
	} else if(strErrorcodesso.equals("4")) { 
		strmsg =""; 
	} else{
		strmsg="";
	}
	
	strSql="SELECT TOP 1 VER_REL_LOG_ID,ISNULL(RELEASE_VERSION,'') AS  RELEASE_VERSION FROM VERSION_RELEASE_LOG ORDER BY VER_REL_LOG_ID DESC";
	rs = dbConBean.executeQuery(strSql);  
	while(rs.next()) {
		strReleaseVersion=rs.getString("RELEASE_VERSION"); 

	}
	rs.close();
	
	 
     help_desk_mail 	    = PropertiesLoader.config.getProperty("help_desk_mail");
     

%>

<body onLoad="document.userFrm.Userid.focus();DrawCaptcha();"   >

	<div class="starstooltip" style="display: none;">
		Samvardhana Motherson Travel AppRoval System (STARS)
	</div>
  	<div class="versiontooltip" style="display: none; width: 200px;">
		<%=dbLabelBean.getLabel("label.global.applicationversion",strLanguage) %>: <%=strReleaseVersion %>
	</div>
	<div class="proudtobetooltip" style="display: none; width: 310px;">
		<%=dbLabelBean.getLabel("label.global.smgslogan",strLanguage) %>
	</div>
	<div class="browserstooltip" style="display: none; width: 340px;">
		<%=dbLabelBean.getLabel("label.global.bestviewon",strLanguage) %>
	</div>
	<div class="mindtooltip" style="display: none; width: 260px;">
		<%=dbLabelBean.getLabel("label.global.visitmindurl",strLanguage) %>
	</div>
				
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="60" valign="top" background="images/header_bg.gif?buildstamp=2_0_0"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50%" height="60" nowrap="nowrap">
           	<table width="95%" border="0" cellspacing="0" cellpadding="0">
           		<tr>
           			<td class="headerTxt2" nowrap="nowrap">
           				<span class="homeLink">
           					&nbsp;<%=dbLabelBean.getLabel("label.header.samvardhanamothersontravelapprovalsystem",strLanguage)%> (<%=dbLabelBean.getLabel("label.header.stars",strLanguage)%>)
           				</span>
           			</td>
           		</tr>
           	</table>
       	</td>
        <td width="3%">&nbsp;</td>
	  	<td width="22%"></td>
      </tr>
      <tr>
        <td height="37" colspan="3">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="100%" height="65%" border="0" cellpadding="10" cellspacing="0">
  <tr>
    <td class="bodyline-top">&nbsp;</td>
  </tr>  
  <form name=userFrm method=post action="userAuthentication1.jsp">    
    <input type="hidden" name="hiddenPassword"/>  
  <tr align="center">   
    <td ><font color="red"><b><%//=strmsg %> </b></font> </td> 
  </tr>
    <td align="center">
	    <table width="565px" border="0" cellpadding="0" cellspacing="0">
	      <tr valign="top">
	        <td width="353px" height="176px" align="center" background="images/form_login.gif?buildstamp=2_0_0" style="background-repeat: no-repeat;">
	       		<table width="353px" border="0" cellpadding="0" cellspacing="0">
	       			<tr><td height="30px" colspan="2"></td></tr>
	       			<tr>
	       				<%if(!invalidUserPass.equals("") && invalidUserPass.equals("Y")){%>
       						<td align="center" height="15px" class="dataLabel" colspan="2">						            
				           		<font color="red"><%=dbLabelBean.getLabel("alert.login.invaliduser",strLanguage)%></font>						           
				            </td>
			            <%} else {%>
			            	<td class="dataLabel" height="15px" colspan="2">&nbsp;</td>
			            <%} %>
	       			</tr>
	       			<tr><td height="10px" colspan="2"></td></tr>
	       			<tr>
			            <td width="120px" align="right" class="dataLabel" nowrap="nowrap"><%=dbLabelBean.getLabel("label.login.username",strLanguage)%>:</td>
			            <td align="left"><input name="Userid" type="text" class="textBoxCss" size="25" onKeyUp="return test1('Userid', 30, 'all');" tabindex="1" style="width:170px;"/>
				         <script>
						 		document.getElementById('Userid').value='<%=strUserId%>';
						 </script>
			            </td>
		          </tr>
		          <tr><td height="15px" colspan="2"></td></tr>
		          <tr>
		            <td width="120px" align="right" class="dataLabel" nowrap="nowrap"><%=dbLabelBean.getLabel("label.login.password",strLanguage)%>:</td>
		            <td align="left"><input name="Password" type="password" class="textBoxCss" size="25" onKeyUp="return test1('password', 15, 'pwd')" maxlength=15 tabindex="2" style="width:170px;" /></td>
				 </tr>
				 <tr><td height="15px" colspan="2"></td></tr>	
				  <%
					 if("3".equals(cnt)){
					 %>
					 <tr>
						 <td width="120px" align="right">
						 	<input type="text" size="12" id="txtCaptcha" readonly style="margin-left:3px; background-image:url(images/captcha.JPG);text-align:center; font-weight:bolder;height: 17px;font-size: 11px; vertical-align: top; line-height: 12px;" class="textBoxCss" onfocus="document.getElementById('txtInput').focus();"/>&nbsp;
						 </td>
						 <td align="left">
						 	<div style="clear: both; float: left; width:170px;">
						 		<div style="float:left;">
						 			<input type="text" id="txtInput" name="txtInput" class="textBoxCss" size="12" tabindex="4" onKeyUp="return test1('txtInput', 15, 'n')"/>
						 		</div>
						 		<div style="float:right;">
								<input type="submit" class="formButton" tabindex="4" value="&nbsp;<%=dbLabelBean.getLabel("button.login.login",strLanguage)%>&nbsp;" onClick="return checkData(this.form);" />
							</div>
						 	</div>
							
						 </td>
						 </tr>
					 <%}else{ %>
			        <tr> 
			          <td width="120px" align="left">&nbsp;</td>
			          <td align="left">
			          	<div style="clear: both; float: left; width:170px;">
			          		<div style="float:right;"><input type="submit" class="formButton" tabindex="4" value="&nbsp;<%=dbLabelBean.getLabel("button.login.login",strLanguage)%>&nbsp;" onClick="return checkData(this.form);" /></div>
			          	</div>			          	
			          </td>
			        </tr>
			        <%} %>
	       		</table>
	       </td>
	       <td width="10px">&nbsp;</td> 
	       <td width="200px">
	       	 	<table width="200px" height="176" border="0" cellpadding="0" cellspacing="0">
	       	 	<tr>
	       	 		<td align="center" class="btnBlockTd1 btnBlockLink">
	       	 			<a href="#" onClick="MM_openBrWindow('M_UserRegister.jsp?lang1=<%=strLanguage %>','Register','left=30,top=30,scrollbars=no,resizable=no,width=950,height=680')" title="<%=dbLabelBean.getLabel("label.login.newregistration",strLanguage) %>">
		       	 			<div class="linkTabLogin">
							    <img src="images/new-registration.png?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel("label.login.newregistration",strLanguage) %>" />
							    <label><%=dbLabelBean.getLabel("label.login.newregistration",strLanguage) %></label>
							</div>
						</a>
	       	 		</td>
	       	 		<td width="5px">&nbsp;</td>
	       	 		<td align="center" class="btnBlockTd2 btnBlockLink">
	       	 			<a href="#" onClick="return mailTo();" title="<%=dbLabelBean.getLabel("label.login.helpdesk",strLanguage)%>">
		       	 			<div class="linkTabLogin">
							    <img src="images/helpdesk.png?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel("label.login.helpdesk",strLanguage)%>" />
							    <label><%=dbLabelBean.getLabel("label.login.helpdesk",strLanguage)%></label>
							</div>
						</a>
	       	 		</td>
	       	 	</tr>
	       	 	<tr><td height="4px"></td></tr>	       	 	
	       	 	<tr>     	 		
	       	 		<td align="center" class="btnBlockTd3 btnBlockLink">
	       	 			<a href="#" onClick="MM_openBrWindow('helplogin.html','HELP','scrollbars=yes,resizable=yes,width=730,height=290')" title="<%=dbLabelBean.getLabel("label.login.helpdocument",strLanguage)%>">
		       	 			<div class="linkTabLogin">
							    <img src="images/help-document.png?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel("label.login.helpdocument",strLanguage)%>" />
							    <label><%=dbLabelBean.getLabel("label.login.helpdocument",strLanguage)%></label>
							</div>
						</a>
	       	 		</td>
	       	 		<td width="5px">&nbsp;</td>
	       	 		<td align="center" class="btnBlockTd4 btnBlockLink">
	       	 			<a href="#" onClick="return forget_password();" title="<%=dbLabelBean.getLabel("label.login.forgotpassword",strLanguage)%>">
		       	 			<div class="linkTabLogin">
							    <img src="images/forgot-password.png?buildstamp=2_0_0" alt="<%=dbLabelBean.getLabel("label.login.forgotpassword",strLanguage)%>" />
							    <label><%=dbLabelBean.getLabel("label.login.forgotpassword",strLanguage)%></label>
							</div>
						</a>
	       	 		</td>
	       	 	</tr>
	       	 </table>
	       </td>
	      </tr>	  
	    </table>
    </td>  
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="position: absolute; left: 0; bottom: 0;">
	<tr>
		<td>
			<div class="loginPageFooter">
			   	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size: 11px;"> 
			      	<tr> 
			          	<td width="30%" align="left" nowrap="nowrap" class="loginPageFooterText">
			          		<span id="version">
			          			&nbsp;<%=dbLabelBean.getLabel("label.global.applicationversion",strLanguage) %>: <%=strReleaseVersion %>
			          		</span>
			          	</td>
			          	
			          	<td width="40%" align="center" nowrap="nowrap">
			          		<img id="smgSlogan" src="images/smg-tagline.png?buildstamp=2_0_0">
			          	</td>
			          	
			          	<td width="30%" align="right" nowrap="nowrap" class="loginPageFooterText">
			          		<span id="browsers">
			          			Best view on
								<img src="images/ie11.png?buildstamp=2_0_0" style="vertical-align: middle;"> 8+
							</span>
							| © 2017 
							<a id="mindUrl" href="http://www.mind-infotech.com/" target="_blank" class="loginPageFooterText" style="text-decoration: none;">MIND</a>
			          	</td>
			      	</tr>
			  	</table>
			</div>
		</td>
	</tr>
</table>
</body>
</html>

<script type="text/javascript">

var reqErrorCode='<%=strErrorcodesso%>';  

if(reqErrorCode != '' && reqErrorCode != '0'){        
  alert('<%=dbLabelBean.getLabel("alert.login.singlesignfailed",strLanguage)%>');
} 

function mailTo() {
	var helpDeskMail = '<%=help_desk_mail %>';
	var ipAddress = '<%=strIPAddress%>';
	window.location = "mailto:"+helpDeskMail+"?subject=STARS"+ipAddress;	
}


$(document).ready(function() {	
	
	$('td.btnBlockLink').mouseover(function() {
		bg = $(this).css('background-color');
		$(this).css("background-color", "#cccccc"); 	
		$(this).find("div.linkTabLogin").find("label").css({"color" : "#000000"});
     }).mouseout(function(){
		$(this).css("background-color", bg); 	
		$(this).find("div.linkTabLogin").find("label").css({"color" : "#ffffff"});
     });	

	$('.homeLink').hover(function () {
 	   var elm = $(this);
		   var offset = elm.offset();	
		   var bottom = $(window).height() - elm.height();
		   bottom = offset.top - bottom;
 	   $('div.starstooltip').css({"top" : parseInt(17),"left" : parseInt(offset.left+430), "display" : "block"});
    }, 
    function () {
 	   $('div.starstooltip').css("display","none");
 	});
	
	$('span#version').hover(function () {
 	   var elm = $(this);
	   var offset = elm.offset();	
	   var bottom = $(window).height() - elm.height();
	   bottom = offset.top - bottom;
   	   var right = $(window).width() - elm.width();
   	   right = offset.left - right;
 	   $('div.versiontooltip').css({"bottom" : parseInt(bottom+50),"left" : parseInt(offset.left-15), "display" : "block"});
    }, 
    function () {
 	   $('div.versiontooltip').css("display","none");
 	});
	
	$('#smgSlogan').hover(function () {
 	   var elm = $(this);
	   var offset = elm.offset();	
	   var bottom = $(window).height() - elm.height();
	   bottom = offset.top - bottom;
   	   var right = $(window).width() - elm.width();
   	   right = offset.left - right;
 	   $('div.proudtobetooltip').css({"bottom" : parseInt(bottom+48),"left" : parseInt(offset.left-50), "display" : "block"});
    }, 
    function () {
 	   $('div.proudtobetooltip').css("display","none");
 	});
	
	$('#browsers').hover(function () {
 	   var elm = $(this);
	   var offset = elm.offset();	
	   var bottom = $(window).height() - elm.height();
	   bottom = offset.top - bottom;
   	   var right = $(window).width() - elm.width();
   	   right = offset.left - right;
 	   $('div.browserstooltip').css({"bottom" : parseInt(bottom+50), "right" : parseInt(bottom+80), "display" : "block"});
    }, 
    function () {
 	   $('div.browserstooltip').css("display","none");
	});
	
	$('#mindUrl').hover(function () {
 	   var elm = $(this);
	   var offset = elm.offset();	
	   var bottom = $(window).height() - elm.height();
	   bottom = offset.top - bottom;
   	   var right = $(window).width() - elm.width();
   	   right = offset.left - right;
 	   $('div.mindtooltip').css({"bottom" : parseInt(bottom+50), "right" : parseInt(bottom+20), "display" : "block"});
    }, 
    function () {
 	   $('div.mindtooltip').css("display","none");
 	});
});

	
</script>
