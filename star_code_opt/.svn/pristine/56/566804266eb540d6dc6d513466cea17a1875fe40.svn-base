<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:31 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:User Validation for STAR
 *Modification 			: 
 *Reason of Modification:code change in whole file for enabling single signon for mind user by shiv sharma on 4/14/2009 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<%@ include  file="cacheInc.inc" %>
<%@ include  file="headerIncl.inc" %>


<!--Create Conneciton by useBean-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<%
//---------------------Validate Session

String user			=null;
String oldPassword	=null;
String newPassword	=null;
String encFlag		=null;
String strLang		=null;


user=request.getParameter("Userid").trim();
oldPassword=request.getParameter("hiddenPassword").trim();
encFlag=request.getParameter("encFlag").trim();
strLang=request.getParameter("lang")==null?"en_US":request.getParameter("lang");
%>
<HTML>
<head>
 <script>
  var flag = true ;
 function checkfield()
 {
	var strOldPassword	=document.user.oldPass.value;
	var strPassword		=document.user.newPass.value;
	var strCpassword	=document.user.confirmPass.value;
	
	
	
	
	if(strPassword=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.enternewpassword",strLang)%>');
		document.user.newPass.value="";
		document.user.newPass.focus();
		flag=true;
		return false;
	}	
	
	if(strCpassword=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.retypenewpassword",strLang)%>');
		document.user.confirmPass.value="";
		document.user.confirmPass.focus();
		flag=true;
		return false;
	}


	if (strPassword.length < 8)
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.lengthofpassword",strLang)%>');
		document.user.newPass.focus();
		flag=true;
		return false;
	}
	if (strCpassword.length < 8)
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.lengthforconfirmpassword",strLang)%>');
		document.user.newPass.focus();
		flag=true;
		return false;
	}
	
	if(strPassword!=strCpassword)
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.passwordmismatchretypepassword",strLang)%>');
		document.user.confirmPass.value="";
		document.user.confirmPass.focus();
		flag=true;
		return false;
	}
	
	if(strPassword==strOldPassword)
	{ 
		alert('<%=dbLabelBean.getLabel("alert.mylinks.oldandnewpasswordaresame",strLang)%>');
		document.user.newPass.value="";
		document.user.confirmPass.value="";
		document.user.newPass.focus();
		flag=true;
		return false;
	}
	if(document.user.user.value == document.user.newPass.value)
    {
		alert('<%=dbLabelBean.getLabel("alert.mylinks.usernameandpasswordnotsame",strLang)%>');
		document.user.newPass.value="";
		document.user.confirmPass.value="";
		flag=true;
		document.user.newPass.focus();
		return false;
	 }

	
	
 }
function chkValue()
{
	var strPassword		=document.user.newPass.value;
	var strConfirmPass  =document.user.confirmPass.value;
	

}
 function test1(obj1, length, str)
 {	
			var obj;
			if(obj1=='newPass')
			{
				 obj = document.user.newPass;
			}	

			if(obj1=='confirmPass')
			{
				 obj = document.user.confirmPass;
			}	

			if(obj1=='oldPass')
			{
				 obj = document.user.oldPass;
			}	

			charactercheck(obj,str);
			limitlength(obj, length);
			spaceChecking(obj);
 }
 
 
function clearfield(){
 
document.user.newPass.value="";
document.user.confirmPass.value="";   
flag=true;
}
 
function buttonPressed()
{
flag = false;
}

function tranferToHistory()
{

  userid=document.user.useridofouser.value;
 	if(flag)
	{
	// alert("inside=="+userid);
	 window.location.href="sessionExpired.jsp?userid="+userid;  

	}
}

 </script>
<head>


<%
String str1="SELECT   userid from m_userinfo  where username=N'"+user+"' and status_id=10";

// System.out.println("str1:::>>>>."+str1); 

ResultSet rs1=dbConBean.executeQuery(str1);

String useridofouser="";  
if(rs1.next())
{	
	useridofouser=rs1.getString(1); 
}

rs1.close();
dbConBean.close();


%>

 <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<body onLoad="document.user.newPass.focus();"  onunload="tranferToHistory();">
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="2" align=center>
<tr>
    <td width="77%" height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("submenu.mylinks.changepassword",strLang)%></li>
    </ul></td>	
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align=center>
<tr> 
<td bgcolor="#666666"><img src="images/spacer.gif?buildstamp=2_0_0" width="1" height="1"></td>
</tr>
</table>
<form method="post" name="user" action="password_change_post_new.jsp" onSubmit="return checkfield();" >
<input type="hidden" name="useridofouser" value=<%=useridofouser%> />
      <input type="hidden" name="user" value="<%=user%>">
	  
	  <table width="100%" border="0" align=center>
                <tr align=center> 
                  <td class=bodyline-top align=center><li class="pageHead"><%=dbLabelBean.getLabel("label.login.youarekindlyrequestedtochangepassword",strLang)%></li></td>
                  
                </tr>
				</table>
				<br>
				<br>
	  <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<tr> 
	<td width="47%" class="formtr2"><%=dbLabelBean.getLabel("label.mylinks.enteroldpassword",strLang)%></td>
	<td width="53%" class="formtr1"><input type=password name="oldPass"  class="textBoxCss" size=30 onKeyUp="return test1('oldPass', 15, 'pwd')" maxlength="15" value="<%=oldPassword%>" readonly></td>
	</tr>
	<tr> 
	<td width="47%" class="formtr2"><%=dbLabelBean.getLabel("label.login.enteryournewpassword",strLang)%></td>
	<td width="53%" class="formtr1"><input type=password name="newPass" class="textBoxCss" size=30 onKeyUp="return test1('newPass', 15, 'pwd')" maxlength="15" ><FONT SIZE="1" COLOR="red"><%=dbLabelBean.getLabel("label.login.mineightcharacters",strLang)%></FONT></td>
	</tr>
		<tr> 
	<td width="47%" class="formtr2"><%=dbLabelBean.getLabel("label.login.confirmyournewpassword",strLang)%></td>
	<td width="53%" class="formtr1"><input type=password name="confirmPass" class="textBoxCss" size=30 onKeyUp="return test1('confirmPass', 15, 'pwd')" maxlength="15"></td>
	</tr>

	<tr class="formbottom" align=center> 
	<td width="47%" colspan=2>
		<input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("button.approverequest.submit",strLang)%>" class="formButton" onclick="buttonPressed();" onkeypress="buttonPressed();">
	<input type="button"  value="<%=dbLabelBean.getLabel("button.global.reset",strLang)%>" class="formButton" onclick="clearfield()"> 
	</td>
	</tr>
	</table>

	
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
</tr>
</table>

</form>
            <p align="center">&nbsp;</p>
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</HTML>