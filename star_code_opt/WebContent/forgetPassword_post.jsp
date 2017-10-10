 <%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:VIJAY SINGH
 *Date of Creation 		:11/04/2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This page is POST page used for get the password when the user forget his/her password
                            
 *Modification 			:1.  Text change  by shiv on 05-Jul-07

 *Reason of Modification:
 *Date of Modification  :
 *Modified By	        :
 *Editor				:Editplus
 
 *Modification			:add a query to get username or password based on email		
 *Modified By			:ManojChand	
 *Date of Modification	:28 feb 2011
 
 *Modification Date		:18-Jan-2013
 *Modification			:remove inclusion of application.jsp from this file 
 *Modified By			:Manoj Chand
 *******************************************************/
%> 
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.Date,java.text.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,java.util.*" pageEncoding="UTF-8" %>


<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
 <jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

 <%@ include  file="importStatement.jsp" %>
 	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
<%
request.setCharacterEncoding("UTF-8");
String strsesLanguage=request.getParameter("lang")== null ? "en_US" : request.getParameter("lang");
//System.out.println("strsesLanguage in post-->"+strsesLanguage);
%>
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script> 
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></SCRIPT><!-- added on 07-Jun-07 by shiv -->
	<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->

	<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
    <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" /><BASE>
    
<%
			Date currentDate				=	new Date();
			SimpleDateFormat sdf			=	new SimpleDateFormat("dd/MM/yyyy");
			String strCurrentDate			=	(sdf.format(currentDate)).trim();
			Connection conn					=	null;		 // Object for connection
			Statement stmt					=	null;		 // Object for Statement
			ResultSet rs					=	null;		 // Object for ResultSet
			String strSqlStr				=	"";			 // string for SQL query
			String strSecretQues			=	"";			 // use for getting value from database
			String strSecretAns				=	"";		     // use for getting value from database
			String strEmail					=	"";		     // use for getting value from database
			String information				=	dbLabelBean.getLabel("label.forgetpassword.wronginformation",strsesLanguage); // check for right user
			StringBuffer	sb				=	new StringBuffer();	//for mailing
			String	report					=	"";//for mailing
			String	email_to				=	""; // for mailing
			String strFirstName				=	"";	// first name of the user
			String strLastName				=	"";	// last name of the user
			String strname					=	""; // name of the user
			String sPswd					=	"";	// password before encryption
			

			String strUserName				=	request.getParameter("uName");
			String strQuest_secret			=	request.getParameter("quest_secret").replaceFirst("'","''");
			String strAns_secret			=	request.getParameter("ans_secret");
			//ADDED BY MANOJ ON 24 FEB 2011
			String strRegis_email			=	request.getParameter("regis_email");
			String strflag					=	request.getParameter("flag");
			String struName				=	"";
			/*System.out.println("strflag on post--->"+strflag);
			System.out.println("strUserName on post--->"+strUserName);
			System.out.println("strQuest_secret on post--->"+strQuest_secret);
			System.out.println("strAns_secret on post--->"+strAns_secret);
			System.out.println("strRegis_email on post--->"+strRegis_email);*/
			//strAns_secret = dbUtility.decryptInDecimal(strAns_secret);
				 
			//Create Connection
			
			
				strSqlStr="SELECT USERNAME,FIRSTNAME,LASTNAME,SECRET_QUESTION,SECRET_ANSWER,EMAIL,PIN FROM M_USERINFO WHERE (EMAIL=N'"+strRegis_email+"' or username=N'"+strUserName+"') and secret_question=N'"+strQuest_secret+"' and secret_answer=N'"+strAns_secret+"' AND STATUS_ID=10";
				//System.out.println("strSqlStr----in post---->"+strSqlStr);
				rs		=	dbConBean.executeQuery(strSqlStr);
				while(rs.next()){
				struName				= rs.getString("USERNAME");
				strFirstName			= rs.getString("FIRSTNAME");
				strLastName				= rs.getString("LASTNAME");
				strSecretQues			= rs.getString("SECRET_QUESTION");
				strSecretAns			= rs.getString("SECRET_ANSWER");
				strEmail				= rs.getString("EMAIL");
				sPswd					= rs.getString("PIN");
				}
				sPswd					= dbUtility.decryptFromDecimalToString(sPswd); // password before encryption
				email_to				=strEmail;
				strname					=strFirstName+" "+strLastName;
				
				//System.out.println("---------------------0----------------------");
				
			
			
			
			//strSqlStr="SELECT FIRSTNAME,LASTNAME,SECRET_QUESTION,SECRET_ANSWER,EMAIL,PIN FROM M_USERINFO WHERE USERNAME='"+strUserName+"' AND STATUS_ID=10";

		//	rs		=	dbConBean.executeQuery(strSqlStr);
	
		/*	System.out.println("---------------------1----------------------");
				while(rs.next())
				{
					strFirstName			= rs.getString(1);
					strLastName				= rs.getString(2);
					strSecretQues			= rs.getString(3);
					strSecretAns			= rs.getString(4);
					strEmail				= rs.getString(5);
					sPswd					= rs.getString(6);
				}
					sPswd					= dbUtility.decryptFromDecimalToString(sPswd); // password before encryption
					email_to				=strEmail;
					strname					=strFirstName+" "+strLastName;
			
			System.out.println("---------------------2----------------------");*/
%>
<html>
<title><%=dbLabelBean.getLabel("label.forgetpassword.stars",strsesLanguage)%></title>
<body >

<%
if(strAns_secret.equals(strSecretAns))//if username is a valid name
{
	
%>

<form>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr> 
       <center><td width="458" class="heading" height="40"><H3><%=dbLabelBean.getLabel("label.forgetpassword.passwordrecall",strsesLanguage)%>
       </td></center>
     </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr><HR><td>
	<jsp:include page="forgetPassword_mail.jsp" flush="true">
		<jsp:param name="uName" value="<%=struName%>"/>
	</jsp:include><HR></td></tr>
	<tr><!-- text change  by shiv on 05-Jul-07  -->
		<td><H4><%=dbLabelBean.getLabel("label.forgetpassword.passwordfor",strsesLanguage)%> <font color="red"><%=struName%></font> <%=dbLabelBean.getLabel("label.forgetpassword.hasbeensentthroughmail",strsesLanguage)%></td>
	</tr>

</table>
<%}
else
{
%>
<jsp:forward page="forgetPassword.jsp" >
 <jsp:param name="lang1" value="<%=strsesLanguage%>" />
 <jsp:param name="info" value="<%=information%>" />
</jsp:forward>
<%
}
	rs.close();
	dbConBean.close();
%>
</form>

</body>
</html>
