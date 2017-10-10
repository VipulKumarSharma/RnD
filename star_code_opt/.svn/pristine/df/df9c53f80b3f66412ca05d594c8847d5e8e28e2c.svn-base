<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:08 DEC 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<html>
<head>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%-- @ include  file="application.jsp" --%>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />


<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<%
// Variables declared and initialized
Connection conn         =    null;
ResultSet objRs			=		null;			  // Object for ResultSet
String	strSqlStr	=	""; // For sql Statements
String strMessage   =   "";
int iCls = 0;
String strStyleCls = "";
String strNoOfColumn = "";
String strTableName  = "";
strSqlStr			= request.getParameter("inputQuery");
//strTableName		= request.getParameter("inputTableName");

try
{
	int intUpdate	= 	dbConBean.executeUpdate(strSqlStr);
	
	if(intUpdate > 0)
	{
		strMessage = "DATA UPDATED Successfully to "+intUpdate+" rows";
	}
	else
	{
		strMessage = "NOT UPDATED";
	}
}
catch(Exception e)
{
	strMessage = "Error in Query = "+e;
	System.out.println("Error in UpdateQurey_POST.jsp"+e);
}
dbConBean.close();   //Close All Connection

response.sendRedirect("UpdateQuery.jsp?message="+strMessage);

%>



</html>
