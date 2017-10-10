<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:16 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for active the USERS from the STAR database ******
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>

<%@page import="java.net.URLEncoder"%><html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon					=		null;			  // Object for connection
ResultSet rs						=       null;
CallableStatement cstmt  			=		null;		      // Object for Callable Statement
objCon                              =       dbConBean.getConnection(); 
String strSql                       =       "";
String strMessage                   =       "";  
String strUrl                       =       "";
String strUserId	    			=       "";
strUserId	 	 		    		=       request.getParameter("userId");

String strDeactiveUserName          =       "";
String strDeactiveUserEmail         =       "";
String strDeactiveUserEmpCode       =       "";
String strSiteId					=       "";
String strIpAddress = request.getRemoteAddr();

boolean bEmaiFlag                   =       false;
boolean bUserNameFlag               =       false; 
String  strEmpCodeFlag				=       "";
strSql = "SELECT RTRIM(LTRIM(USERNAME)) AS USERNAME, RTRIM(LTRIM(EMAIL)) AS EMAIL, ISNULL(EMP_CODE,'') AS EMP_CODE, SITE_ID  FROM M_USERINFO WHERE USERID="+strUserId;
rs = dbConBean.executeQuery(strSql);
if(rs.next())
{
	strDeactiveUserName  =  rs.getString("USERNAME");
	strDeactiveUserEmail =  rs.getString("EMAIL");
	strDeactiveUserEmpCode = rs.getString("EMP_CODE");
	strSiteId			   = rs.getString("SITE_ID");	
}
rs.close();
		

// validate the username and email of the deactivate user before activating (both thing checked in active user list)
bUserNameFlag = dbUtility.validateUserName(strDeactiveUserName);
//bEmaiFlag     = dbUtility.validateEmailID(strDeactiveUserEmail); //commented  for remove email meandatory condition on 3/23/2007 by shiv

strEmpCodeFlag  = dbUtility.validateEmpcode(strDeactiveUserEmpCode,strSiteId); 

//if(bUserNameFlag == true && bEmaiFlag == true && strEmpCodeFlag.equals("true")) 

if(bUserNameFlag == true && strEmpCodeFlag.equals("true")) //added for remove email meandatory condition on 3/23/2007  by shiv
{ 

	//Procedure for Activating User from Deactivating state
	try
	{
	   cstmt=objCon.prepareCall("{?=call PROC_USER_ADMIN_ACTIVE(?,?,?)}");//PROCEDURE FOR ACTIVE THE USER
	   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	   cstmt.setString(2,strUserId);
	   cstmt.setString(3,Suser_id); //getting from session
	   cstmt.setString(4,strIpAddress); 
	   cstmt.execute();
	   cstmt.close();
	   strMessage = " ("+dbLabelBean.getLabel("message.user.usersuccessfullyactivated",strsesLanguage)+")";
%>
       <!-- Mail goes to the User which acount has been activated -->
	   <jsp:include page="T_MailOnActivationOfUser.jsp"  >
			<jsp:param name="registerUserId" value="<%=strUserId%>"/>			   
	   </jsp:include>	
<%
		strUrl = "M_ApproverLevelSelection.jsp?userId="+strUserId+"&message="+URLEncoder.encode(strMessage,"UTF-8");
	}
	catch(Exception e)
	{
		System.out.println("Error in M_userActive.jsp ==="+e);
	}
}
else
{
	if(bUserNameFlag == false && bEmaiFlag == false)
	if(bUserNameFlag == false)
	{
		strMessage = " ("+dbLabelBean.getLabel("message.user.usernamealreadyexistinactiveuserlist",strsesLanguage)+")";
	}
	else if(bUserNameFlag == false)
    {
		strMessage = " ("+dbLabelBean.getLabel("message.user.usernamealreadyexistinactiveuserlist",strsesLanguage)+")";
	}
	/*else if(bEmaiFlag == false)
	{
		strMessage = " (Email-Id Already Exist in Active User List)";
	}
	*/

//
	if(strEmpCodeFlag.equals("blank"))
	{
		strMessage = " ("+dbLabelBean.getLabel("message.user.employeecodecannotbeblank",strsesLanguage)+")";
	}
	else if(strEmpCodeFlag.equals("exist"))
	{
		strMessage = " ("+dbLabelBean.getLabel("message.user.employeecodealreadyexistinactiveuserlist",strsesLanguage)+")";
	}
//



	strUrl = "M_deactiveUserList.jsp?message="+URLEncoder.encode(strMessage,"UTF-8");
}
//Connection Close
dbConBean.close();

//strUrl = "M_deactiveUserList.jsp?message="+strMessage;

response.sendRedirect(strUrl);

%>

