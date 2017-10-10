<%
/***************************************************
**** The information contained here in is confidential and ******
**** proprietary to MIND and forms the part of the MIND ****** 
*Author				:Himanshu Jain
*Date of Creation	: 20 Sept 2006

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project		  : STARS ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description	: This is first jsp file  for listing all the  USERS from the STARS database ******
**** Modification	: ******
**** Reason of Modification : ******
**** Date of Modification   : ******
**** Revision History		: none******
**** Editor					:Editplus ******
*Modified By			: Manoj Chand
*Modification 			: Create Database connection from stars.properties located outside STARS application.
*Modification Date		: 02 Jan 2013
**********************************************************/
%>

<%@ page language="java"  import="src.connection.PropertiesLoader" %>
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
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
String dbdriver		=null;
String dburl		=null;
String dbuser		=null;
String dbpswd		=null;

Connection con	=		null;			    // Object for connection
Statement stmt	=		null;			   // Object for Statement
ResultSet rs	=		null;			  // Object for ResultSet
//Create Connection

//changed by manoj chand on 02 jan 2013 to fetch db connection parameters from outside STARS application.
	 dbdriver 	    = PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
	 dburl 		    = PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
	 dbuser 		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
	 dbpswd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd"); 




/*Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
con=DriverManager.getConnection("jdbc:odbc:star","sa","");*/
//added by manoj chand on 30 may 2012
Class.forName(dbdriver);
con=DriverManager.getConnection(dburl,dbuser,dbpswd);

int iLoop	=	1;
String	sSqlStr=""; // For sql Statements
String strusname			= request.getParameter("name");	
String strUsId				= request.getParameter("usId");	
int iCls = 0;
String strStyleCls = "";
//Object to store sanction id
%>
<script language=JavaScript >


function deleteConfirm()
{

if(confirm('Are you sure you want to delete the record !'))
	return true;
else
	return false;
}
</script>

<script language="JavaScript">
<!--
 
function MM_openBrWindow(theURL,winName,features) 
{ 
window.open(theURL,winName,features);
}
 </script>
 <base target="middle"> 
</head>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="77%" height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead">Grant Access To Reports</li>
    </ul></td>	
	<td width="23%" align="right" class="bodyline-top">
	<table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
		<td width="52%" height="20" align="right" class="date2"><a href="M_userList.jsp" class="rtlinks"><img src="images/IconBack.gif?buildstamp=2_0_0" width="57" height="24" border="0" /></a>
	</td>
	<td width="48%" align="right"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a>
	</td>    
      </tr>
    </table>
	</td>
  </tr>
  </table>

<table width="95%" align="center" cellspacing="2" cellpadding="2">
<tr><td class="formtr2" colspan=7>Grant Access to <b><%=strusname%></b></td></tr>
  <tr align="center"> 
    <td width="5%" class="formhead">S.No</td>
    <td width="13%" class="formhead">Report Group</td>
    <td width="13%" class="formhead">Report Name</td>
    <td width="13%" class="formhead">Access</td>
  </tr>
  <%

				
	int iSno=1;
	String strReportId		 = "";
	String strReportGrpName	 = "";
	String strReportName	 = "";
	String strReportAccess	 = "";	
	
	sSqlStr="SELECT REPORT_GROUP, REPORT_NAME,ISNULL(RTRIM(dbo.FN_GETREPACCES('"+strUsId+"',REPORT_ID)),'ORIG') AS X,REPORT_ID FROM M_REPORT_LIST WHERE STATUS_ID=10 ORDER BY 1";
	stmt = con.createStatement(); 
	rs = stmt.executeQuery(sSqlStr);
%>

	<form name="frm" action="M_reportListGrantAccessNew.jsp" method=post>
<%
				while(rs.next())
				{
					
					strReportGrpName	= rs.getString(1);
					strReportName		= rs.getString(2);
					strReportAccess		= rs.getString(3);
					strReportId			= rs.getString(4);
	%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 


	  iCls++;
%>

	<tr> 
		<td width="5%" class="<%=strStyleCls%>"><%=iSno%></td>
		<td width="13%" class="<%=strStyleCls%>"><%=strReportGrpName%></td>
		<td width="13%" class="<%=strStyleCls%>"><%=strReportName%></td>
		<td width="13%" class="<%=strStyleCls%>">
			<select name="access<%=iSno%>" class=textBoxCss>
			<option value="SYS"> System Access	</option>
			<option value="ORIG"> Originator Access	</option>
			<option value="SITE"> Site Access	</option>
			</select>
			<SCRIPT LANGUAGE="JavaScript">
			document.frm.access<%=iSno%>.value="<%=strReportAccess%>"
			</SCRIPT>
		</td>
		<input type=hidden name="repId<%=iSno%>" value="<%=strReportId%>">
		<input type=hidden name="usId" value="<%=strUsId%>">
		<input type=hidden name="usname" value="<%=strusname%>">

	</tr>
	<%iSno++;%>
<% 
				}
	%>
	<tr>
	<td width="13%" class="formbottom" colspan=4 align="center">
		<input type=hidden name="row" value="<%=iSno-1%>">
		<input type=submit value="ADD/UPDATE" class="formButton">	
	</td>
	</tr>

		</form>
<%
rs.close();
stmt.close();
con.close();
%>
<tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
</tr>
</table>
        
<p>&nbsp;</p>
</body>
</html>