<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author								:Shiv Sharma 
 *Date of Creation 				:26-Feb-08
 *Copyright Notice 				: Copyright(C)2000 MIND.All rights reserved
 *Project	  							: STARS
 *Operating environment		:Tomcat, sql server 2000 
 *Description 						:This page is used for get the password when the user forget his/her password
 *Modification 						:
 *Reason of Modification		: 
 *Date of Modification			:
 *Modified By						:
 *Editor								:Editplus
 
 *Modification Date		:04-August-2011
 *Modification			:fetch path of STAR.properties file from web.xml 
 *Modified By			:Manoj Chand
 
 *Modified By			: Manoj Chand
 *Modification 			: Create Database connection from stars.properties located outside STARS application.
 *Modification Date		: 02 Jan 2013
 *******************************************************/
%>
<%@ page language="java" import="src.connection.PropertiesLoader" %>
<%@ include  file="importStatement.jsp" %>

<html>
<!--HEAD BLOCK START-->
<head>
	<title>User  Password Retrival Screen</title>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<%@ include file="M_InsertProfile.jsp"  %>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
	 
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
<%
Connection conn								=	null;		 // Object for connection
Statement stmt								=	null;		 // Object for Statement
ResultSet rs								=	null;		 // Object for ResultSet
String strSqlStr							=	"";			// string for sql query
String strSecretQues						=	"";		// add for getting secret question form database
String strUserId							=	"";	//to get the userid from the database
String strButtonDisble						=	"enabled";

 

//String contextdbDriver= application.getInitParameter("dbDriver");
//String contextdbUrl= application.getInitParameter("dbUrl");
//String contextdbUser=application.getInitParameter("dbUser");
//String contextdbPwd=application.getInitParameter("dbPwd");

//End of code

//added by manoj on 05 august 2011 to fetch STAR.properties path from xml
String contextdbDriver= "";
String contextdbUrl= "";
String contextdbUser= "";
String contextdbPwd= "";
//Changed by manoj chand on 03 jan 2013 to fetch serverPath variable value from external properties file.
 contextdbDriver    = PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
 contextdbUrl 	    = PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
 contextdbUser		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
 contextdbPwd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd");
 
%>
<script language="JavaScript">
 
 // end of encryption() function
function test1(obj1, length, str)
  {	
	var obj;
	
	if(obj1=='eMail')
	{
		obj = document.frm.uEmail;
	}
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
  }

function checkData()
{
	if(document.frm.uEmail.value=='')
	{
		alert("Please Fill the Email Address of User.");
		document.frm.uEmail.focus();
		return false;
	}
	var flag = echeck(window.document.frm.uEmail.value);
			if (flag == false)
			{
				frm.uEmail.focus();
				return flag;
			}
	 
	return true;
}

//forgetPassword_post.jsp

</script>

</head>
<%

Class.forName(contextdbDriver);
              conn = DriverManager.getConnection(contextdbUrl,contextdbUser,contextdbPwd);
%>

<body ><CENTER>
<form method="post" name="frm" action="userRestpasswordmailpost.jsp">  
<BR><BR><BR>
<table  >
<tr>
        <td width="500" class="bodyline-top"><ul class="pagebullet">
            <li class="pageHead">Reset Password Info  Screen</li>
        </ul></td>
		<td width="0" class="bodyline-top"></td>
</tr>
<tr><td>

</td></tr>
</table>
<BR><BR>

<table >
<tr align="left">
  	<td width="110" class="formtr1"><B>Enter User Email ID</B> </td>
	<td width="300" class="formtr1"><input type="text" name="uEmail" class="textBoxCss" width="30" size="50"   onKeyUp="return test1('eMail', 50, 'an')" ></td>
	 


</tr>
<tr align="center"  colspan="2" ><td class="formtr1"  >
	
	</td> 
</tr>
 
</table><BR>
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <INPUT TYPE="submit" value="Submit" onclick="return checkData();" />&nbsp;&nbsp;  <input type="button"   value=" Close "  onClick="window.close();">
</form>
</body></CENTER>
</html>