<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:06 March 2013
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0, sql server 2008 
 *Description 			:This jsp is used to list the companies.
 *Modified By			:Manoj Chand
 *Date of Modification	:23-Aug-2013
 *Modification			:add textarea to add xml parameter string for ERP web service
*******************************************************/%>

<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

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

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script>
document.oncontextmenu = new Function("return false");
</script>
<%
// Variables declared and initialized
DbConnectionBean bean = new DbConnectionBean();   // Object for connection
ResultSet objRs			=		null;			  // Object for ResultSet

String	strSqlStr	=	""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strMsg = URLDecoder.decode((request.getParameter("message")==null) ? "" : request.getParameter("message"), "UTF-8");
%>
<script language=JavaScript >
function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	return true;
else
	return false;
}

function showMsg(msg){
	if(msg!=''){
		alert(msg);
	}
}
</script>
<base target="middle">
</head>
<body onload="showMsg('<%=strMsg %>');"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.company.company",strsesLanguage)%></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
      <li><a href="M_companyAdd.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
      </ul>
      </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<table width="100%" align="center" border="0" cellpadding="1" cellspacing="1" class="formborder">
<tr align="left" class="formhead"> 
    <td width="3%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
<%
	if(SuserRole.trim().equals("AD"))
	{
%> 
	<td width="5%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.company.companyid",strsesLanguage)%></td>
<%
	}
%>
    <td width="16%"><%=dbLabelBean.getLabel("submenu.master.company",strsesLanguage)%></td>  
    <td width="29%"><%=dbLabelBean.getLabel("label.master.webserviceurl",strsesLanguage)%></td>
    <td width="29%"><%=dbLabelBean.getLabel("label.master.erpwebserviceurl",strsesLanguage)%></td>  
    <td width="8%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
    <td width="10%" nowrap="nowrap" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td> 

  </tr>
  <%
	int		intSno=1;
	int cid;
	String strCompanyName = "";
	String strMATAWSURL = "";
	String strCreatedDate = "";
	String strERPWSURL	=	"";
	String strRecFlag	="No";

	strSqlStr="SELECT CID,COMPANY_NAME,MATA_WS_URL,ERP_WS_URL,dbo.CONVERTDATE(C_DATE) AS C_DATE from dbo.M_COMPANY mc WHERE mc.STATUS_ID=10 ORDER BY mc.C_DATE";	
	objRs				= bean.executeQuery(strSqlStr);
	String strSiteCode	=	null;

				while(objRs.next())
				{
					strRecFlag="Yes";
					cid=objRs.getInt("CID");
					strCompanyName=objRs.getString("COMPANY_NAME");
					strMATAWSURL=objRs.getString("MATA_WS_URL");
					strERPWSURL=objRs.getString("ERP_WS_URL");
					strCreatedDate			=	objRs.getString("C_DATE");
					if(strCreatedDate==null ||  strCreatedDate.equals("Jan  1 1900 12:00AM"))
						strCreatedDate="-";
				%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
	  iCls++;
%>
    <tr class="<%=strStyleCls%>" height="10px"> 
    <td width="3%"><%=intSno%></td>
<%
	if(SuserRole.trim().equals("AD")) 
	{
%>
	<td width="5%" align="center"><%=cid%></td>
<%
	}
%>
    <td width="16%"><%=strCompanyName%></td>
    <td width="28%"><%=strMATAWSURL%></td>
	<td width="28%"><%=strERPWSURL%></td>			
    <td width="12%" ><%=strCreatedDate%></td>
    <td width="10%" align="center" nowrap="nowrap" class="rep-txt"><a href="M_companyEdit.jsp?cmpId=<%=cid%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="M_companyDelete.jsp?cmpId=<%=cid%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
  <%
	intSno++;				
	}
objRs.close();
bean.close();
 if(strRecFlag.equals("No")){%>
  <tr height="10px" class="formtr2">
  <td colspan="7"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage) %></td>
  </tr>
	  
 <% }%>
</table>
<br>
</body>
</html>
