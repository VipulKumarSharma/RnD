<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Sachin Gupta
 *Date of Creation 		:28 Nov 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp list the designation.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

<%@ include  file="importStatement.jsp" %>
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
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<%
// Variables declared and initialized
ResultSet objRs			=		null;			  // Object for ResultSet
ResultSet rs 			=		null;	
String	strSqlStr	=	""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strsiteid	 ="";
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
</script>
<base target="middle">
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="77%" height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.designation.designation",strsesLanguage)%>   </li><font color='red'><%=strMessage%></font>
    </ul></td>
    <td width="23%" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
		<li><a href="M_desigAdd.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
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
    <td width="8%"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
	<td width="8%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.mail.designationname",strsesLanguage)%></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.designation.designationdesc",strsesLanguage)%></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>

  </tr>
  <%
		
	int		intSno		=	1;
	String strSiteName  =   ""; 
	String strDesigName =   "";
	String strDesigDesc =   "";
	String strCreatedDate = "";
	String strDesigId	=	"";
	
	//Sql to get the the site list  from site table

	strSqlStr="SELECT  DESIG_ID,DBO.SITEDETAILS(SITE_ID) AS SITE, DESIG_NAME,DESIG_DESC, DBO.CONVERTDATE(C_DATE) AS CREATEDDATE FROM M_DESIGNATION WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY C_DATE DESC";
      objRs				= dbConBean.executeQuery(strSqlStr);
	  
//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")))
	{
 		
		  strSqlStr="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
                objRs = dbConBean.executeQuery(strSqlStr);
				if(!objRs.next())
		           {
		
					strSqlStr="SELECT  DESIG_ID,DBO.SITEDETAILS(SITE_ID) AS SITE, DESIG_NAME,DESIG_DESC, DBO.CONVERTDATE(C_DATE) AS CREATEDDATE FROM M_DESIGNATION WHERE SITE_ID="+strSiteIdSS+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY C_DATE DESC";
					objRs = dbConBean.executeQuery(strSqlStr);
		           }
				   else 
		          {
				   strSqlStr="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
                   objRs = dbConBean.executeQuery(strSqlStr);

				   while(objRs.next())
					    {
					     strsiteid=objRs.getString("SITE_ID");
					      
					 
                           strSqlStr="SELECT  DESIG_ID,DBO.SITEDETAILS(SITE_ID) AS SITE, DESIG_NAME,DESIG_DESC, DBO.CONVERTDATE(C_DATE) AS CREATEDDATE FROM M_DESIGNATION WHERE SITE_ID="+strsiteid+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY C_DATE DESC";
						   rs = dbConBean1.executeQuery(strSqlStr);
						   while (rs.next())
							{
												strDesigId				= rs.getString("DESIG_ID");
												strSiteName             = rs.getString("SITE"); 
												strDesigName			= rs.getString("DESIG_NAME");
												strDesigDesc			= rs.getString("DESIG_DESC");
												strCreatedDate   		= rs.getString("CREATEDDATE");

												if (iCls%2 == 0) { 
												strStyleCls="formtr2";
												} else { 
												strStyleCls="formtr1";
												} 
												iCls++;
										%>
											<tr class="<%=strStyleCls%>"> 
											<td width="8%"><%=intSno%></td>
											<td width="8%"><%=strSiteName%></td>
											<td width="16%"><%=strDesigName%></td>
											<td width="16%"><%=strDesigDesc%></td>
											<td width="16%" ><%=strCreatedDate%></td>
											<td width="16%" align="left" class="rep-txt"><a href="M_desigEdit.jsp?desigId=<%=strDesigId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="M_desigDelete.jsp?desigId=<%=strDesigId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
										  </tr>
										  <%
														intSno++;				
							}rs.close();
 
						   
				      }   
				   
				   }
				   //  close of else 
	}  //  close of if
//

	//objRs				= dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{
		strDesigId				= objRs.getString("DESIG_ID");
		strSiteName             = objRs.getString("SITE"); 
		strDesigName			= objRs.getString("DESIG_NAME");
		strDesigDesc			= objRs.getString("DESIG_DESC");
		strCreatedDate   		= objRs.getString("CREATEDDATE");

		if (iCls%2 == 0) { 
		strStyleCls="formtr2";
	    } else { 
		strStyleCls="formtr1";
		} 
	    iCls++;
%>
    <tr class="<%=strStyleCls%>"> 
    <td width="8%"><%=intSno%></td>
	<td width="8%"><%=strSiteName%></td>
    <td width="16%"><%=strDesigName%></td>
	<td width="16%"><%=strDesigDesc%></td>
	<td width="16%" ><%=strCreatedDate%></td>
    <td width="16%" align="left" class="rep-txt"><a href="M_desigEdit.jsp?desigId=<%=strDesigId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="M_desigDelete.jsp?desigId=<%=strDesigId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
  <%
				intSno++;				
	}
	objRs.close();
	dbConBean.close();   //Close All Connection


%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
<br>
</body>
</html>
