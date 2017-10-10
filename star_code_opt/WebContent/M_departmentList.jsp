<%@ include  file="importStatement.jsp" %>
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file is for showing  the detail of Department from M_Department in the STAR Database
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :01 Feb 2013
 *Description			:IE Compatibility Issue resolved
 *******************************************************/
%>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<%
// Variables declared and initialized
Connection con		=		null;			    // Object for connection
ResultSet rs		=		null;			  // Object for ResultSet
ResultSet rs1		=		null;	
String	sSqlStr=""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strMessage = URLDecoder.decode((request.getParameter("message") == null) ?"" : request.getParameter("message"), "UTF-8");

%>
<script language=JavaScript >
function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	return true;
else
	return false;
}
function updateConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.unit.areyousureyouwantotupdatetherecord",strsesLanguage)%>'))
	return true;
else
	return false;
}

</script>
<base target="middle">
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr style="border-bottom:#A9A9A9 1px solid; ">
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.unit.department",strsesLanguage)%></li>
      <font color='green'><%=strMessage%></font>
    </ul>
    </td>
    <td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
      <li><a href="M_departmentAddDept.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
      </ul>
      </td>
      </tr>
    </table>
	</td>
  </tr>
</table>


<br>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left" class="formhead"> 
		<td width="2%" class="rep-head" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
		<td width="7%" class="rep-head"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>
		<td width="10%" class="rep-head"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
		<td width="10%" class="rep-head"><%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%></td>
		<td width="10%" class="rep-head"><%=dbLabelBean.getLabel("label.department.departmentdescription",strsesLanguage)%></td>
		<td width="5%" class="rep-head"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
		<td width="5%" class="rep-head"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>
<%
	int intSno=0;
	String strDivision			=	"";
	String strSiteName			=	"";
	String strDeptName			=	"";
	String strCreatedOn			=	"";
	String strDeptId			=	"";
	String strsiteid			=	""; 
	String strDeptDesc			=	"";	

	sSqlStr="SELECT DBO.DIVISIONNAME(DIV_ID), DBO.SITENAME(SITE_ID), ISNULL(DEPT_NAME,''), DBO.CONVERTDATE(C_DATE), DEPT_ID, DEPT_DESC FROM M_DEPARTMENT WHERE DBO.SITESTATUS(SITE_ID)='10'AND STATUS_ID=10 ORDER BY 1,2,3";
	rs = dbConBean.executeQuery(sSqlStr);

//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")))
	{
          
                sSqlStr="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
                rs = dbConBean.executeQuery(sSqlStr);
		   
				if(!rs.next())
				{
					   
						sSqlStr="SELECT dbo.DIVISIONNAME(DIV_ID), DBO.SITENAME(SITE_ID), ISNULL(DEPT_NAME,''), DBO.CONVERTDATE(C_DATE), DEPT_ID, DEPT_DESC FROM M_DEPARTMENT WHERE DBO.SITESTATUS(SITE_ID)='10' AND SITE_ID="+strSiteIdSS+" AND STATUS_ID=10 ORDER BY 1,2,3";
						rs = dbConBean.executeQuery(sSqlStr);
				}	
				else
				{       
					    sSqlStr="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
                         rs = dbConBean.executeQuery(sSqlStr);
					  while(rs.next()) 
					  {
                   
                       strsiteid= rs.getString("SITE_ID");
					 sSqlStr="SELECT DBO.DIVISIONNAME(DIV_ID), DBO.SITENAME(SITE_ID), ISNULL(DEPT_NAME,''), DBO.CONVERTDATE(C_DATE), DEPT_ID, DEPT_DESC FROM M_DEPARTMENT WHERE DBO.SITESTATUS(SITE_ID)='10' AND SITE_ID="+strsiteid+" AND STATUS_ID=10 ORDER BY 1,2,3";
					 

					 rs1 = dbConBean1.executeQuery(sSqlStr);

 					 //System.out.println("hi-------------123456-------- "+sSqlStr);
					 
						while(rs1.next())
						{     
							  
                          //System.out.println("    site are------ "+rs1.getString(2));		
						  strDivision		= rs1.getString(1);
							strSiteName		= rs1.getString(2);
							strDeptName		= rs1.getString(3);
							strCreatedOn	= rs1.getString(4);
							strDeptId		= rs1.getString(5);
							strDeptDesc		= rs1.getString("DEPT_DESC");
									if (iCls%2 == 0) { 
										strStyleCls="formtr2";
									} else { 
										strStyleCls="formtr1";
									} 
	  iCls++;
%>
  <tr class="<%=strStyleCls%>"> 
		<td width="2%" class="rep-head"><%=++intSno%></td>
		<td width="7%" class="rep-txt"><%=strDivision%></td>
		<td width="10%" class="rep-txt"><%=strSiteName%></td>
		<td width="10%" class="rep-txt"><%=strDeptName%></td>
		<td width="10%" class="rep-txt"><%=strDeptDesc%></td>
		<td width="5%" class="rep-txt"><%=strCreatedOn%></td>
		<td width="5%" class="rep-txt" align="left"><a href="M_departmentEditDept.jsp?deptId=<%=strDeptId%>&strsitename1=<%=strSiteName%>" ><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="M_departmentDeleteDept.jsp?deptId=<%=strDeptId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
	<%
						}
						rs1.close();
					  }
                            
				 }
			}


		 
/*		sSqlStr="SELECT DBO.DIVISIONNAME(DIV_ID), DBO.SITENAME(SITE_ID), ISNULL(DEPT_NAME,''), DBO.CONVERTDATE(C_DATE), DEPT_ID FROM M_DEPARTMENT WHERE DBO.SITESTATUS(SITE_ID)='10' AND SITE_ID="+strSiteIdSS+" AND STATUS_ID=10 ORDER BY 1,2,3";
*/
	
//
	//rs = dbConBean.executeQuery(sSqlStr);
	while(rs.next())
	{
		strDivision		= rs.getString(1);
		strSiteName		= rs.getString(2);
		strDeptName		= rs.getString(3);
		strCreatedOn	= rs.getString(4);
		strDeptId		= rs.getString(5);
		strDeptDesc		= rs.getString("DEPT_DESC");
 
		if (iCls%2 == 0) { 
			strStyleCls="formtr2";
	    } else { 
			strStyleCls="formtr1";
	    } 
	  iCls++;
%>
  <tr class="<%=strStyleCls%>"> 
		<td width="2%" class="rep-head"><%=++intSno%></td>
		<td width="7%" class="rep-txt"><%=strDivision%></td>
		<td width="10%" class="rep-txt"><%=strSiteName%></td>
		<td width="10%" class="rep-txt"><%=strDeptName%></td>
		<td width="10%" class="rep-txt"><%=strDeptDesc%></td>
		<td width="5%" class="rep-txt"><%=strCreatedOn%></td>
		<td width="5%" class="rep-txt" align="left"><a href="M_departmentEditDept.jsp?deptId=<%=strDeptId%>" ><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="M_departmentDeleteDept.jsp?deptId=<%=strDeptId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
	<%
		}
		rs.close();
		dbConBean.close();
	%>
	<tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
    </tr>
</table>
<br>
</body>
</html>
