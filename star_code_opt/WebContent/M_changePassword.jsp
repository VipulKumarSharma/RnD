<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:25 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp is used to input new Password from the User.
 *Modification 			: 
 *Reason of Modification:changes password criteria for Special character  on 29 july 2009
 *Date of Modification  :  
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 June 2012
 *Modifictation			: multilingual functionality implemeted in Change password 
*******************************************************/%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbConnectionBean" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%@ include file="application.jsp" %>
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<% DbConnectionBean bean = new DbConnectionBean(); %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<!-- right click and ctrl+v is disabled by manoj chand on 08 june 2012 in change password page -->
<script language="JavaScript" src="scripts/RightClickDisable.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/CTRLDisable.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript >
function trim(strText) { 
    // this will get rid of leading spaces 
    while (strText.substring(0,1) == ' ') 
        strText = strText.substring(1, strText.length);

    // this will get rid of trailing spaces 
    while (strText.substring(strText.length-1,strText.length) == ' ')
        strText = strText.substring(0, strText.length-1);
   return strText;
} 
//--></script>


<script language="JavaScript">



function isSpecialcharacter(str) { 
 	var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?_";
 	for (var i = 0; i < str.length; i++) {
  	if (iChars.indexOf(str.charAt(i)) != -1) {  	
  	return false;
  	}
  }
 } 

// function to check text fields



function checkfield(db_pwd)
{
	var strOldPassword	=document.user.oldPass.value;
	var strPassword		=document.user.newPass.value;
	var strCpassword	=document.user.confirmPass.value;
	if(trim(strOldPassword)=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.enteroldpassword",strsesLanguage)%>');
		document.user.oldPass.value="";
		document.user.oldPass.focus();
		return false;
	}
	
	/*if(isSpecialcharacter(strOldPassword)==false){
		alert ('Please insert Alphanumeric Values');
		document.user.oldPass.value="";
		document.user.oldPass.focus();
		return false;	
	}
	*/
	
	if(trim(strPassword)=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.enternewpassword",strsesLanguage)%>');
		document.user.newPass.value="";
		document.user.newPass.focus();
		return false;
	}
	
	/*	if(isSpecialcharacter(strPassword)==false){
		alert ('Please insert Alphanumeric Values');
		document.user.newPass.value="";
		document.user.newPass.focus();
		return false;	
	}
	
	*/
	
	if(trim(strCpassword)=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.retypenewpassword",strsesLanguage)%>');
		document.user.confirmPass.value="";
		document.user.confirmPass.focus();
		return false;
	}
	
	/*	if(isSpecialcharacter(strCpassword)==false){   
		alert ('Please insert Alphanumeric Values');
		document.user.confirmPass.value="";
		document.user.confirmPass.focus();
		return false;	
	}
	*/
	
	if(strPassword!=strCpassword)
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.passwordmismatchretypepassword",strsesLanguage)%>');
		document.user.confirmPass.value="";
		document.user.confirmPass.focus();
		return false;
	}
	if(strOldPassword!=db_pwd)
	{ 
		alert('<%=dbLabelBean.getLabel("alert.mylinks.passwordmismatchretypeoldpassword",strsesLanguage)%>');
		document.user.oldPass.value="";
		document.user.oldPass.focus();
		return false;
	}
	if(strPassword==db_pwd)
	{ 
		alert('<%=dbLabelBean.getLabel("alert.mylinks.oldandnewpasswordaresame",strsesLanguage)%>');
		document.user.newPass.value="";
		document.user.confirmPass.value="";
		document.user.newPass.focus();
		return false;
	}

//New
    if(strPassword.length < 8)
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.lengthofpassword",strsesLanguage)%>');
		document.user.newPass.focus();
		return false;		
	}
	if(strCpassword.length < 8)
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.lengthforconfirmpassword",strsesLanguage)%>');
		document.user.confirmPass.focus();
		return false;		
	}
	 if(document.user.uname.value == document.user.newPass.value)
     {
		alert('<%=dbLabelBean.getLabel("alert.mylinks.usernameandpasswordnotsame",strsesLanguage)%>');
		document.user.newPass.value="";
		document.user.confirmPass.value="";
		document.user.newPass.focus();
		return false;
	 }
//
	
	
}
// function closed


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
</script>
<html>
<head>
</head>
<%
	String db_password=""; // variable to hold old password 
	HttpSession htsession	= request.getSession(); //getting session
	String flag = request.getParameter("flag");
	String user = (String)htsession.getValue("user"); 
	String loginName = "";
	//System.out.println("user ****** "+user);
	// getting old password from database
	ResultSet rs = bean.executeQuery("select pin,username from M_USERINFO where  username=N'"+ user.trim()+"'"); 
	if(rs.next())
	{
		db_password = rs.getString(1);
		loginName   = rs.getString(2);
		//System.out.println("db_password **** "+db_password);
	}
	rs.close();

	db_password = dbUtility.decryptFromDecimalToString(db_password);
	//System.out.println("db_password after decrypt===="+db_password);
%>


<body onLoad="document.user.oldPass.focus();"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1">
  <tr>
    <td width="77%" height="32" class="bodyline-top">
	<ul class="pagebullet">
    <% if(flag!=null) { %>
	   <li class="pageHead"><%=dbLabelBean.getLabel("label.mylinks.passwordchangesuccessfully",strsesLanguage)%></li>
	<% } %>
	<% 	if(flag==null) { %>
		<li class="pageHead"><%=dbLabelBean.getLabel("submenu.mylinks.changepassword",strsesLanguage)%></li>
	<% } %>	
		</ul></td>	
  </tr>
</table>

<table width="70%" align="center" border="0" cellpadding="5" cellspacing="1"> 
  <form action="T_changePasswordPost.jsp" name="user" method="post" onSubmit="return checkfield('<%=db_password%>');">
    <input type='hidden' name="uname" value="<%=loginName%>">
	<tr>
		<td>
			<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
			<tr> 
				<td width="47%" class="formtr2"><%=dbLabelBean.getLabel("label.mylinks.enteroldpassword",strsesLanguage)%></td>
				<td width="53%" class="formtr1"><input type=password name="oldPass" size="30" onKeyUp="return test1('oldPass', 15, 'pwd')" maxlength="15" class="textBoxCss"></td>
			</tr>
			<tr> 
				<td width="47%" class="formtr2"><%=dbLabelBean.getLabel("label.mylinks.enternewpassword",strsesLanguage)%></td>
				<td width="53%" class="formtr1"><input type=password name="newPass" size=30 onKeyUp="return test1('newPass', 15, 'pwd')" maxlength="15" class="textBoxCss"></td>
			</tr>
			<tr> 
				<td width="47%" class="formtr2"><%=dbLabelBean.getLabel("label.mylinks.confirmnewpassword",strsesLanguage)%></td>
				<td width="53%" class="formtr1"><input type=password name="confirmPass" size=30 onKeyUp="return test1('confirmPass', 15, 'pwd')" maxlength="15" class="textBoxCss"></td>
			</tr>
			<tr class="formbottom" align=center> 
				<td width="47%" colspan=2>	<input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("button.approverequest.submit",strsesLanguage)%>" class="formButton">
											<input type="reset" name="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton">
				</td> 
			</tr>
		</table>
	</td>
	</tr>
	<tr>
		<td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
	</tr>
</table>
</form>
</body>
</html>
