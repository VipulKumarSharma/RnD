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
 *Modification 			:  function to genrate new password on reset  password Added by  on 17- Oct-2007
 *Reason of Modification: 
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

   
<html>
<body >
<%
// Variables declared and initialized
String strsesLanguage=request.getParameter("lang")==null?"en_US":request.getParameter("lang");
String sUserId						=	"";
String sEmail						=	"";
String strSql						=  "";
String strNewPassword		="";
ResultSet   rsObj						=null;	

sUserId	 	 				=	request.getParameter("userId");		
sEmail						=   request.getParameter("email");
		
		
/// ------ function to genrate new password on reset  password------------------added on 17- Oct-2007 by shiv  
strSql="select dbo.resetPassword(getdate())";
rsObj = dbConBean.executeQuery(strSql);
if(rsObj.next())
{
	strNewPassword			=	rsObj.getString(1);
}
rsObj.close();

 strSql="update m_USERINFO  set PIN=N'"+strNewPassword+"',ENC_FLAG='n' where USERID = "+sUserId+" and status_id=10";	

try
{
	int		rs = dbConBean.executeUpdate(strSql);
%>
<form method=post name=resetpass >
  <table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr> 
      <center><td width="458" class="heading" height="40"><H3><%=dbLabelBean.getLabel("label.master.resetpassword",strsesLanguage)%></td></center>              
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr><HR></tr><tr> <td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td> <td>&nbsp;</td>   </tr>
	<center>
	<tr><center><td><center><H4><%=dbLabelBean.getLabel("label.master.passwordforselectedemphasbeenreset",strsesLanguage)%></td></tr>
	<jsp:include page="T_MailOnResetPassword.jsp">
		<jsp:param name="userId" value="<%=sUserId%>"/>
	    <jsp:param name="pin" value="<%=strNewPassword%>"/> 
	</jsp:include>
  </table>
</form>

<%
}
catch(Exception e)	
{
	System.out.println("Error in reset_password_mail.jsp========"+e);
}
%>
</body>
<html>