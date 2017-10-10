<%
/***************************************************
**** The information contained here in is confidential and ******
**** proprietary to MIND and forms the part of the MIND ****** 
*Author			  :Deepali Dhar
*Date of Creation : 01 June 2004

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : SERS ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is first jsp file  for listing all the  USERS from the SERS database ******
**** Modification : ******
**** Reason of Modification : ******
**** Date of Modification   : ******
**** Revision History		: none******
**** Editor					:Editplus ******

**********************************************************/
%>


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
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
CallableStatement cstmt		=		null;			// Object for Callable Statement
Statement stmt					=		null;			   // Object for Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String strRows=request.getParameter("rows");
//String strId=request.getParameter("id");
String strUid=request.getParameter("usId");
String strUName=request.getParameter("name");

int iRows=Integer.parseInt(strRows);
String	sSqlStr=""; // For sql Statements
sSqlStr="DELETE FROM REPORT_USER_ACCESS WHERE USERID='"+strUid+"'";
stmt = con.createStatement(); 
stmt.executeUpdate(sSqlStr);
stmt.close();

for(int i=1;i<=iRows;i++)
{
	//Procedure for Customer Add
	/**

@USER_ID	VARCHAR(60),
	@REPORT_ID	VARCHAR(60),
	@ACCESS	VARCHAR(20),
	@DIV		VARCHAR(60),	
	@SITE		VARCHAR(60),
	@DEPT		VARCHAR(50),
	@C_USER_ID	VARCHAR(20)
	**/
	cstmt=con.prepareCall("{?=call PROC_GRANT_REPORT_ACCESS(?,?,?,?,?,?,?)}");//PROC_SECTION_2_LEASEDASSES_DELETEITEM
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.setString(2, strUid);
	cstmt.setString(3, request.getParameter("id"+i));
	cstmt.setString(4, request.getParameter("access"+i));
	cstmt.setString(5, request.getParameter("div"+i));
	cstmt.setString(6, request.getParameter("site"+i));
	cstmt.setString(7, request.getParameter("dept"+i));
	cstmt.setString(8, Suser_id);	
	cstmt.execute();
	//cstmt.close();

}
			response.sendRedirect("M_reportList.jsp?usId="+strUid+"&name="+strUName+"");


%>
