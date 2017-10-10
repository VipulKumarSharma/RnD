
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain	
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for delete the DEPARTMENT in M_DEPARTMENT table of STAR database 
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 09 July 2012
 *Modification			: to resolve connection error coming in jtds connection.
 *******************************************************/
%>
<%@page import="java.net.URLEncoder"%>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="importStatement.jsp" %>
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
// Variables declared and initialized
int errorCode			= 0 ;
String  strMessage		= "";

Connection con			=		null;			    // Object for connection
ResultSet rs			=		null;			  // Object for ResultSet
CallableStatement cstmt	=		null;			// Object for Callable Statement
String Record_type="D";
String strDeptId=request.getParameter("deptId");// Object to store Department ID

con = dbConBean.getConnection();   //Get Connection
//this statement added by manoj chand on 09 july 2012 to resolve connection error coming in jtds connection.
con.setAutoCommit(false);
try {
	cstmt=con.prepareCall("{?=call PROC_DELETEDEPARTMENT(?,?)}");
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.setString(2, strDeptId);
	cstmt.setString(3,Record_type);
	cstmt.execute();
	
	errorCode = cstmt.getInt(1);
	
	if(errorCode == 0) {
		strMessage = dbLabelBean.getLabel("label.department.departmentdeletedsuccessfully",strsesLanguage);
	} else {
		strMessage = dbLabelBean.getLabel("label.department.departmentcouldnotbedeleted",strsesLanguage);
	}
	
	cstmt.close();
	con.commit();
	response.sendRedirect("M_departmentList.jsp?flag=true&message="+URLEncoder.encode(strMessage,"UTF-8"));
 }
 catch(Exception e)
 {
	 System.out.println("Error at DeleteDept"+e);
	 con.rollback();
	 response.sendRedirect("M_departmentList.jsp?flag=false");
 }
 finally
 {
 con.close();
 }

 dbConBean.close();
	
%>

