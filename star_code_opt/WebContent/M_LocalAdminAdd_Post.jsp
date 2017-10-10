<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta	
 *Date of Creation 		:23 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for adding a new Local Admin in M_UserRole Table
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>

<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods" pageEncoding="UTF-8" %>

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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>


<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon					=		null;			    // Object for connection
Statement objStmt					=		null;			   // Object for Statement
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

objCon = dbConBean1.getConnection();  //Get the Conneciton
String	strSqlStr	 =	""; // For sql Statements
String  strMessage   =  "";
String  strUrl       =  "";  
String  strStatusId  =  "";

String strUserId            = "";
String strSiteId			= ""; //object to store Site Name
String strRoleId			= ""; //object to store Description
String strAction            = ""; 
String strIpAddress = request.getRemoteAddr();

strSiteId					= request.getParameter("sitedivId")==null ?"-1" :request.getParameter("sitedivId");
strUserId 					= request.getParameter("userId")==null ?"-1" :request.getParameter("userId");
strRoleId					= request.getParameter("roleId")==null ?"-1" :request.getParameter("roleId");
strAction					= request.getParameter("action")==null ?"-1" :request.getParameter("action");

strSqlStr =  "SELECT USERID, STATUS_ID FROM M_USERROLE WHERE USERID="+strUserId;
//System.out.println("strSqlStr==="+strSqlStr);
objRs		= dbConBean.executeQuery(strSqlStr);
if(objRs.next())
{
	strStatusId  = objRs.getString("STATUS_ID");
	if(strStatusId != null && strStatusId.equals("10"))
	{
		strMessage   = dbLabelBean.getLabel("label.user.localadminalreadyexistforthatsite",strsesLanguage);
	}
	if(strStatusId != null && strStatusId.equals("30"))
	{
		strMessage   = dbLabelBean.getLabel("label.user.localadminalreadyexistforthatsiteinadmindeactivelist",strsesLanguage);
	}
	strUrl       = "M_LocalAdminAdd.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&sitedivId="+strSiteId+"&userId="+strUserId;

	if(strAction.equals("edit"))
	{
		//Procedure for Add New Local Admin 
		objCstmt=objCon.prepareCall("{?=call PROC_LOCAL_ADMIN_EDIT(?,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN DESIG TABLE
		objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		objCstmt.setString(2, strUserId);	
		objCstmt.setString(3, strSiteId);
		objCstmt.setString(4, strRoleId.trim());
		objCstmt.setString(5, Suser_id);
		objCstmt.setString(6, strIpAddress);
		objCstmt.execute();
		objCstmt.close();
		strMessage   = dbLabelBean.getLabel("label.user.localadminupdatedsuccessfully",strsesLanguage);
		strUrl       = "M_LocalAdminEdit.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&sitedivId="+strSiteId+"&userId="+strUserId;

	}
	
}
else
{
	//Procedure for Add New Local Admin 
	objCstmt=objCon.prepareCall("{?=call PROC_LOCAL_ADMIN_ADD(?,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN DESIG TABLE
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, strUserId);	
	objCstmt.setString(3, strSiteId);
	objCstmt.setString(4, strRoleId);
	objCstmt.setString(5, Suser_id);
	objCstmt.setString(6, strIpAddress);
	objCstmt.execute();
	objCstmt.close();
	strMessage = dbLabelBean.getLabel("message.master.localadminaddedsuccessfully",strsesLanguage);
	strUrl       = "M_LocalAdminAdd.jsp?message="+URLEncoder.encode(strMessage,"UTF-8")+"&sitedivId="+strSiteId+"&userId="+strUserId;
}

objRs.close();
dbConBean.close();       //CLOSE ALL CONNECTIONS
dbConBean1.close();       //CLOSE ALL CONNECTIONS


response.sendRedirect(strUrl);

%>

