<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file  is used to insert  DEPARTMENT in M_DEPARTMENT table of STAR database
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 July 2012
 *Modification			: to resolve connection error coming in jtds connection.
*******************************************************/%>

<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLEncoder"%>
<%@ include  file="importStatement.jsp" %>
<html>
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
int index							= 0 ;
Connection objCon					=		null;			    // Object for connection
CallableStatement objCstmt			=		null;			// Object for Callable Statement
String	sSqlStr=""; // For sql Statements
String	strDeptName		=	request.getParameter("departmentname");
String  strDeptId		=	request.getParameter("deptId");
String	strSiteId		=	request.getParameter("hiddenSiteId");  //HIDDEN SITE ID
String  strDeptDesc		=   request.getParameter("departmentDescr");
String  strMessage		=   "";

String Record_type="U"; 

objCon = dbConBean.getConnection();  //Get Connection
//this statement added by manoj chand on 09 july 2012 to resolve connection error coming in jtds connection.
objCon.setAutoCommit(false);
	try
	{
	objCstmt=objCon.prepareCall("{?=call PROC_UPDATEDEPARTMENT(?,?,?,?,?,?)}");
	objCstmt.registerOutParameter(++index,java.sql.Types.INTEGER);
	objCstmt.setString(++index, strDeptName.trim());
	objCstmt.setString(++index, strDeptDesc.trim());
	objCstmt.setString(++index, Suser_id);
	objCstmt.setString(++index, strSiteId);
	objCstmt.setString(++index, strDeptId);
	objCstmt.setString(++index,Record_type);
	objCstmt.execute();
	objCstmt.close();
	objCon.commit();
	strMessage = dbLabelBean.getLabel("label.department.departmentdataupdatedsuccessfully",strsesLanguage);
	response.sendRedirect("M_departmentList.jsp?flag=true&message="+URLEncoder.encode(strMessage,"UTF-8"));
	}
	catch(Exception e)
	{
	System.out.println("Error occured at M_departmentEditPost.jsp"+ e);
	objCon.rollback();
	response.sendRedirect("M_departmentList.jsp?flag=false");
	}
	
	finally
	{
		objCon.close();
	}
dbConBean.close();
%>
</html>
