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
Connection con,con_1,con_new	=		null;			    // Object for connection
Statement stmt,stmt_1,stmt_new	=		null;			   // Object for Statement
ResultSet rs,rs_1,rs_new			=		null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
con_1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
con_new=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

String	sSqlStr=""; // For sql Statements
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

<body class="body">

<table width="95%" border="0" cellspacing="0" cellpadding="8" align="center">
  <tr> 
    <td class="formhead" width="50%"> Grant Access To Reports</td>
  </tr>
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td bgcolor="#000000"><img src="images/spacer.gif?buildstamp=2_0_0" width="1" height="1"></td>
  </tr>
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="20" align="right" class="date2"><a href="M_userList.jsp" class="rtlinks">BACK</a> | <a href="#" onClick="window.print();">PRINT</a></td> 
  </tr>
</table>
<form name=frm method=post action="M_reportListGrantAccess.jsp">
<table width="100%" align="center" cellspacing="0" border=0 cellpadding="2" class="formborder">
<tr><td class="rep-head" colspan=7>Grant Access to <b><%=request.getParameter("name")%></b></td></tr>
  <tr align="center"> 
    <td width="5%" class="rep-head">S.No</td>
    <td width="9%" class="rep-head">Report Type</td>
    <td width="9%" class="rep-head">Report Name</td>
    <td width="9%" class="rep-head">Access</td>
    <td width="9%" class="rep-head">Division</td>
    <td width="9%" class="rep-head">Site</td>
	<td width="9%" class="rep-head">Department</td>
  </tr>
  <%

				
	int iSno=1;
	String sReportId				 = "";
	String sReportGrpName		 = "";
	String sReportName			 = "";
	String sDivId					 = "";
	String sDivName				 = "";
	String sSiteId					 = "";
	String sSiteName				 = "";
	String sDeptId					 = "";
	String sDeptName				 = "";

	String strReportId				 = "";
	String strReportGrpName	 = "";
	String strReportName		 = "";
	String strDivId					 = "";
	String strDivName				 = "";
	String strSiteId				 = "";
	String strSiteName			 = "";
	String strDeptId				 = "";
	String strDeptName			 = "";
	String strAccess				="";
	String new_user				=	request.getParameter("usId");
	sSqlStr="SELECT  * FROM REPORT_LIST WHERE STATUS_ID=10 ORDER BY 1,2";
	stmt = con.createStatement(); 
	rs = stmt.executeQuery(sSqlStr);

				while(rs.next())
				{
					sReportId 			= rs.getString(1);
					sReportGrpName	= rs.getString(2);
					sReportName		= rs.getString(3);
					
				sSqlStr="SELECT    ISNULL(ACCESS,'N') AS ACCESS,ISNULL(DIV,'') AS DIV,ISNULL(SITE,'') AS SITE,ISNULL(DEPT,'') AS DEPT FROM    REPORT_USER_ACCESS WHERE REPORT_ID='"+sReportId+"' AND USERID='"+new_user+"'";
//out.println("sSqlStr="+sSqlStr);
				stmt_new = con_new.createStatement(); 
				rs_new = stmt_new.executeQuery(sSqlStr);
				while(rs_new.next())
					{
						strAccess=	rs_new.getString("ACCESS");

						strDivId=	rs_new.getString("DIV");

						strSiteId=	rs_new.getString("SITE");

						strDeptId=	rs_new.getString("DEPT");

					}


				%>
  <tr> 
    <td width="5%" class="rep-txt"><%=iSno%></td>
    <td width="9%" class="rep-txt"><%=sReportGrpName%></td>
    <td width="9%" class="rep-txt"><%=sReportName%></td>
    <td width="9%" class="rep-txt">
		<SELECT NAME="access<%=iSno%>" class=dropdown>
		<option value="Y">Y</option>
		<option value="N" SELECTED>N</option>
		</select>
		<%
if(!(strAccess.equals(""))||(strAccess==null))
{
%>
<script language="javascript">
document.frm.access<%=iSno%>.value="<%=strAccess%>";
</script>
<%}%>
	</td>
    <td width="9%" class="rep-txt">
		<SELECT NAME="div<%=iSno%>" class=dropdown>
		<option value="ALL">All</option>
<%
	sSqlStr="SELECT DIV_ID, DIV_NAME FROM DIVISION WHERE STATUS_ID=10 ORDER BY 2";
	stmt_1 = con_1.createStatement(); 
	rs_1 = stmt_1.executeQuery(sSqlStr);

				while(rs_1.next())
				{
					sDivId	 			= rs_1.getString(1);
					sDivName			= rs_1.getString(2);
%>
			<option value="<%=sDivId%>"><%=sDivName%></option>
<%
				}
rs_1.close();
stmt_1.close();
%>
	</select>
<%
if(!(strAccess.equals(""))||(strAccess==null))
{
%>
<script language="javascript">
document.frm.div<%=iSno%>.value="<%=strDivId%>";
</script>
<%}%>
	</td>
    <td width="9%" class="rep-txt">		
		<SELECT NAME="site<%=iSno%>" class=dropdown>
		<option value="ALL">All</option>
<%
	sSqlStr="SELECT SITE_ID, SERS.DBO.DIVISIONNAME(DIV_ID),SITE_NAME FROM SITE WHERE STATUS_ID=10 ORDER BY 2";
	stmt_1 = con_1.createStatement(); 
	rs_1 = stmt_1.executeQuery(sSqlStr);

				while(rs_1.next())
				{
					sSiteId	 			= rs_1.getString(1);
					sDivName			= rs_1.getString(2);
					sSiteName			= rs_1.getString(3);

%>
			<option value="<%=sSiteId%>"><%=sDivName%>/<%=sSiteName%></option>
<%
				}
rs_1.close();
stmt_1.close();
%>
		</select>
		<%
if(!(strAccess.equals(""))||(strAccess==null))
{
%>
<script language="javascript">
document.frm.site<%=iSno%>.value="<%=strSiteId%>";
</script>
<%}%>
</td>
    <td width="9%" class="rep-txt">
		<SELECT NAME="dept<%=iSno%>" class=dropdown>
		<option value="ALL">All</option>
<%
	sSqlStr="SELECT DEPT_ID,SERS.DBO.DIVISIONNAME(DIV_ID),SERS.DBO.SITENAME(SITE_ID),DEPT_NAME FROM DEPARTMENT WHERE STATUS_ID=10 AND DEPT_NAME !='ALL' AND SERS.DBO.SITENAME(SITE_ID) IS NOT NULL ORDER BY 2,3,4";
	stmt_1 = con_1.createStatement(); 
	rs_1 = stmt_1.executeQuery(sSqlStr);

				while(rs_1.next())
				{
					sDeptId	 			= rs_1.getString(1);
					sDivName			= rs_1.getString(2);
					sSiteName			= rs_1.getString(3);
					sDeptName			= rs_1.getString(4);

%>
			<option value="<%=sDeptId%>"><%=sDivName%>/<%=sSiteName%>/<%=sDeptName%></option>
<%
				}
rs_1.close();
stmt_1.close();
%>
		</select>
				<%
if(!(strAccess.equals(""))||(strAccess==null))
{
%>
<script language="javascript">
document.frm.dept<%=iSno%>.value="<%=strDeptId%>";
</script>
<%}%>
	
</td>

					<input type=hidden name="id<%=iSno%>" value="<%=sReportId%>">
  </tr>
  <%
				iSno++;				
				}
				rs.close();
				stmt.close();
				con.close();
				con_1.close();

%>
					<input type=hidden name=rows value="<%=iSno-1%>">
					<input type=hidden name=usId value="<%=request.getParameter("usId")%>">
					<input type=hidden name="name" value="<%=request.getParameter("name")%>">
<tr align="center"><td class="rep-head" colspan=7 align="center"><INPUT TYPE=SUBMIT VALUE="GRANT / DENY ACCESS" CLASS="bttn"></td></tr>

</table>
</form>
<br>
</body>
</html>
