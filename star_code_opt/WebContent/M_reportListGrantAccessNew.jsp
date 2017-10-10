<%
/***************************************************
**** The information contained here in is confidential and ******
**** proprietary to MIND and forms the part of the MIND ****** 
*Author			  :Nitin Mehra
*Date of Creation : 06 Jan 2006

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
<%
String strUsId		= "";
String strRepId		= "";
String strAccess	= "";
strRepId			= request.getParameter("repId");	
strUsId				= request.getParameter("usId");	
strAccess			= request.getParameter("access");	
String strusname	= "";
strusname			= request.getParameter("usname");	
String strRow	= "";
strRow			= request.getParameter("row");	
int row=Integer.parseInt(strRow);

%>
<%
// Variables declared and initialized
Connection con	= null;// Object for connection
CallableStatement cstmt = null;// Object for Callable Statement
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
for(int i=1;i<=row;i++)
{
	try
	{
		cstmt=con.prepareCall("{?=call PROC_GRANT_REPORTACCESS(?,?,?)}");//PROCEDURE TO ENTER DATA IN M_REPORT_ACCESS TABLE
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strUsId);
		cstmt.setString(3, request.getParameter("repId"+i));	
		cstmt.setString(4, request.getParameter("access"+i));	
		cstmt.execute();
		cstmt.close();
	}
	catch(Exception e)
	{
	out.println("e"+e);
	}

}
con.close();
%>

 <form name="frm" method=post action="M_reportListNew.jsp">
		<input type=hidden name="usId" value="<%=strUsId%>">
		<input type=hidden name="name" value="<%=strusname%>">
</form>
 <SCRIPT LANGUAGE="JavaScript">
document.frm.submit();
</SCRIPT> 