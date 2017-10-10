<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp list the site.
 *Modification 			: 
 *Reason of Modification:Added new flag for  showing MATA for Ticket is optional on 02 dec-2009 by shiv sharma 
  *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *Modified By			: MANOJ CHAND
 *Modification			: Showing closed unit in skyblue color
 *Date of Modification	: 08 feb 2012
 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :04 Feb 2013
 *Description			:IE Compatibility Issue resolved
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
<script>
document.oncontextmenu = new Function("return false");
</script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<!-- added by manoj chand on 09 feb 2012 to Show closed unit in skyblue color -->
<style type="text/css">
.formtrr1{
font-family:Arial, Helvetica, sans-serif;
font-size:11px;
BACKGROUND:#a2a2a2;
COLOR:#111111;
font-weight:normal; 
line-height:21px;
text-align: left;
}
</style>


<%
// Variables declared and initialized
DbConnectionBean bean = new DbConnectionBean();   // Object for connection
ResultSet objRs			=		null;			  // Object for ResultSet
String flag = request.getParameter("flag");
//System.out.println("flag is :::"+flag);

String	strSqlStr	=	""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strMsg	= 	URLDecoder.decode((request.getParameter("message")==null) ? "" : request.getParameter("message"), "UTF-8");
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
      <li class="pageHead"><%=dbLabelBean.getLabel("label.unit.unit",strsesLanguage)%></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td>
      <ul id="list-nav">
      <li><a href="M_siteAdd.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage)%></a></li>
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
      </ul>
      </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<!-- <div style="color: red;text-align:left;height: 1px;" ><%=dbLabelBean.getLabel("label.unit.note",strsesLanguage)%>: <i><%=dbLabelBean.getLabel("label.unit.unitsshowninskybluecolorareclosedunits",strsesLanguage)%></i></div> -->
<table width="100%" align="center" border="0" cellpadding="1" cellspacing="1" class="formborder">
<tr align="left" class="formhead"> 
    <td width="3%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
<%
//New Check for local administrator
	if(SuserRole.trim().equals("AD"))
	{
%> 
	<td width="5%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.user.unitid",strsesLanguage)%></td>
<%
	}
%>
    <td width="16%"><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage)%></td>  
    <td width="16%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
    <td width="16%"><%=dbLabelBean.getLabel("label.unit.unitdescription",strsesLanguage)%></td>  
    <td width="7%" align="center"><%=dbLabelBean.getLabel("label.sitemaster.travelsiteagency",strsesLanguage)%></td>
    <td width="7%" align="center"><%=dbLabelBean.getLabel("label.unit.partycode",strsesLanguage)%></td>
    <td width="7%" align="center"><%=dbLabelBean.getLabel("label.unit.smrunit",strsesLanguage)%></td>   
    <td width="9%" align="center"><%=dbLabelBean.getLabel("label.unit.mataoptionalforinternationalticket",strsesLanguage)%></td>     
    <td width="10%" align="center"><%=dbLabelBean.getLabel("label.unit.mataoptionalfordomesticticket",strsesLanguage)%></td>   
    <td width="13%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
    <td width="15%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.unit.implementedon",strsesLanguage)%></td>
    <td width="16%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td> 

  </tr>
  <tr> 
    <td colspan="13" class="formhead" ><%=dbLabelBean.getLabel("label.master.starsactiveunits",strsesLanguage)%></td>
  </tr>
  <%
  
	int		intSno=1;
  	String strTravelAgencyId = "";
	String strDivName = "";
	String strSiteName = "";
	String strSiteDesc = "";
	String strCreatedDate = "";
	String strSiteId	=	"";
	String strSmrSite	="";
	String strPriceForInt ="";
	String strPriceForDom ="";
	//added by manoj chand on 08 feb 2012 to get closed unit flag
	String strClosedUnitFlag = "";
	String strBgcolor		 = "";
	String strImplDate="";
	String strPartyCode="";
	//Sql to get the the site list  from site table

	//query updated by manoj chand on 09 feb 2012 to get CLOSED_UNIT_FLAG
	strSqlStr="SELECT  dbo.DIVISIONNAME(DIV_ID) AS DIV,SITE_NAME,SITE_DESC,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,"+
	" SITE_ID,ISNULL(SITE_CODE,'-'),isnuLL(SMR_SITE_FLAG,'N') as SMR_SITE_FLAG, "+
	" isnull(INT_LOCAL_AGENT,'N') as INT_LOCAL_AGENT,isnull(DOM_LOCAL_AGENT,'N') as DOM_LOCAL_AGENT, ISNULL(CLOSED_UNIT_FLAG,'') AS CLOSED_UNIT_FLAG,dbo.CONVERTDATE(Impl_Date) AS Impl_Date, ISNULL(PARTY_CODE,'') AS PARTY_CODE,TRAVEL_AGENCY_ID "+
	" FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1  AND (CLOSED_UNIT_FLAG is null or CLOSED_UNIT_FLAG='') ORDER BY C_DATE DESC";

	
	objRs				= bean.executeQuery(strSqlStr);
	String strSiteCode	=	null;

				while(objRs.next())
				{
					strDivName			= objRs.getString(1);
					strSiteName			= objRs.getString(2);
					strSiteDesc			= objRs.getString(3);
					strCreatedDate		= objRs.getString(4);
					strSiteId			= objRs.getString(5);
					strSiteCode			= objRs.getString(6);
					strSmrSite			= objRs.getString(7).toUpperCase();	
					strPriceForInt		= objRs.getString(8).toUpperCase();	
					strPriceForDom		= objRs.getString(9).toUpperCase(); 	
					//added by  manoj chand on 08 feb 2012 to get closed unit flag
					strClosedUnitFlag	= objRs.getString("CLOSED_UNIT_FLAG");
					strImplDate			=	objRs.getString("Impl_Date");
					strPartyCode		=	objRs.getString("PARTY_CODE");
					if(strImplDate==null ||  strImplDate.equals("Jan  1 1900 12:00AM"))
						strImplDate="-";
					
					strTravelAgencyId	= (objRs.getString("TRAVEL_AGENCY_ID")==null) || ("".equals(objRs.getString("TRAVEL_AGENCY_ID"))) ? "0" : objRs.getString("TRAVEL_AGENCY_ID");
					if ("1".equals(strTravelAgencyId)) {
						strTravelAgencyId = "MATA India";
					}
					else if ("2".equals(strTravelAgencyId)) {
						strTravelAgencyId = "MATA GmbH";
					} else {
						strTravelAgencyId = "Other";
					}
				%>
				
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
	  iCls++;
	  
	  if(strClosedUnitFlag.equalsIgnoreCase("y")){
		  strStyleCls="formtrr1";
		  //strBgcolor="red";
	  }
%>
    <tr class="<%=strStyleCls%>" height="10px"> 
    <td width="3%"><%=intSno%></td>
<%
//New Check for local administrator
	if(SuserRole.trim().equals("AD")) 
	{
%>
	<td width="5%"><%=strSiteId%></td>
<%
	}
%>
    <td width="16%"><%=strDivName%></td>
    <td width="16%"><%=strSiteName%></td>
	<td width="16%"><%=strSiteDesc%></td>
	<td width="7%" align="center"><%=strTravelAgencyId%></td>
	<td width="7%" align="center"><%=strPartyCode%></td>
	
	<td width="7%" align="center"><%=strSmrSite%></td>
	<td align="center"><%=strPriceForInt%></td>
	<td align="center"><%=strPriceForDom%></td>
					
    <td width="13%" ><%=strCreatedDate%></td>
    <td width="15%" align="center"><%=strImplDate%></td> 
    <td width="16%" align="center" nowrap="nowrap" class="rep-txt"><a href="M_siteEdit.jsp?stId=<%=strSiteId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> |<br/><a href="M_siteDelete.jsp?stId=<%=strSiteId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
  <%
	intSno++;				
}
	objRs.close();
	bean.close();
%>
 <tr> 
    <td colspan="13" class="formhead" ><%=dbLabelBean.getLabel("label.master.starsclosedunits",strsesLanguage)%></td>
  </tr>
<%
	bean = new DbConnectionBean();
	intSno=1;
	strSqlStr="SELECT  dbo.DIVISIONNAME(DIV_ID) AS DIV,SITE_NAME,SITE_DESC,dbo.CONVERTDATE(C_DATE) AS CREATEDDATE,"+
			" SITE_ID,ISNULL(SITE_CODE,'-'),isnuLL(SMR_SITE_FLAG,'N') as SMR_SITE_FLAG, "+
			" isnull(INT_LOCAL_AGENT,'N') as INT_LOCAL_AGENT,isnull(DOM_LOCAL_AGENT,'N') as DOM_LOCAL_AGENT, ISNULL(CLOSED_UNIT_FLAG,'') AS CLOSED_UNIT_FLAG,dbo.CONVERTDATE(Impl_Date) AS Impl_Date, ISNULL(PARTY_CODE,'') AS PARTY_CODE,TRAVEL_AGENCY_ID "+
			" FROM M_SITE WHERE STATUS_ID=10 AND APPLICATION_ID=1 AND CLOSED_UNIT_FLAG = 'y' ORDER BY C_DATE DESC";

		
	objRs				= bean.executeQuery(strSqlStr);
	strSiteCode	=	null;
	
				while(objRs.next())
				{
					strDivName			= objRs.getString(1);
					strSiteName			= objRs.getString(2);
					strSiteDesc			= objRs.getString(3);
					strCreatedDate		= objRs.getString(4);
					strSiteId			= objRs.getString(5);
					strSiteCode			= objRs.getString(6);
					strSmrSite			= objRs.getString(7).toUpperCase();	
					strPriceForInt		= objRs.getString(8).toUpperCase();	
					strPriceForDom		= objRs.getString(9).toUpperCase(); 	
					//added by manoj chand on 08 feb 2012 to get closed unit flag
					strClosedUnitFlag	= objRs.getString("CLOSED_UNIT_FLAG");
					strImplDate			=	objRs.getString("Impl_Date");
					strPartyCode		=	objRs.getString("PARTY_CODE");
					if(strImplDate==null ||  strImplDate.equals("Jan  1 1900 12:00AM"))
						strImplDate="-";
			  
	  				if(strClosedUnitFlag.equalsIgnoreCase("y")){
		  				strStyleCls="formtrr1";
		  				//strBgcolor="red";
	  				}
	  				strTravelAgencyId	= (objRs.getString("TRAVEL_AGENCY_ID")==null) || ("".equals(objRs.getString("TRAVEL_AGENCY_ID"))) ? "0" : objRs.getString("TRAVEL_AGENCY_ID");
					if ("1".equals(strTravelAgencyId)) {
						strTravelAgencyId = "MATA India";
					}
					else if ("2".equals(strTravelAgencyId)) {
						strTravelAgencyId = "MATA GmbH";
					} else {
						strTravelAgencyId = "Other";
					}
	%>
	    <tr class="<%=strStyleCls%>" height="10px"> 
	    <td width="3%"><%=intSno%></td>
	<%
	//New Check for local administrator
		if(SuserRole.trim().equals("AD")) 
		{
	%>
		<td width="5%"><%=strSiteId%></td>
	<%
		}
	%>
	    <td width="16%"><%=strDivName%></td>
	    <td width="16%"><%=strSiteName%></td>
		<td width="16%"><%=strSiteDesc%></td>
		<td width="7%" align="center"><%=strTravelAgencyId%></td>
		<td width="7%" align="center"><%=strPartyCode%></td>
		
		<td width="7%" align="center"><%=strSmrSite%></td>
		<td align="center"><%=strPriceForInt%></td>
		<td align="center"><%=strPriceForDom%></td>
						
	    <td width="13%" ><%=strCreatedDate%></td>
	    <td width="15%" align="center"><%=strImplDate%></td> 
	    <td width="16%" align="center" nowrap="nowrap" class="rep-txt"><a href="M_siteEdit.jsp?stId=<%=strSiteId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> |<br/><a href="M_siteDelete.jsp?stId=<%=strSiteId%>" onClick="return  deleteConfirm();"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
	  </tr>
	  <%
		intSno++;				
		}
	objRs.close();
	bean.close();

//close all the connections
%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
<br>
</body>
</html>
