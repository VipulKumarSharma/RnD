<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Gurmeet Singh
 *Date of Creation 		:21 Aug 2015
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2008 
 *Description 			:This is jsp file for showing Workflow Approvers List of the MATA-GmbH sites
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus 
 *******************************************************/
%>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- Import starDaoImpl  --%>
<%@ page import="src.beans.*" %>
<%@ page import="src.dao.starDaoImpl" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbUtilBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<link href="style/quick-travel-style_gmbh.css?buildstamp=2_0_0" rel="stylesheet" media="all" type="text/css"/>

<%
starDaoImpl dao = new starDaoImpl();
List approverList = null;

String strSql 		= "";
ResultSet rs 		= null;

int iCls = 0;
String strStyleCls 	= "";
String strSiteName 	= "";
String strMsg 		= "";
String strSiteId 		= (request.getParameter("siteId")==null)?"-1":request.getParameter("siteId"); 
String strTravellerId 	= (request.getParameter("travellerId")==null)?"":request.getParameter("travellerId");
String strTravelType 	= (request.getParameter("traveltype")==null)?"":request.getParameter("traveltype");
String strWorkFlowCode	= (request.getParameter("workFlowCode")==null)?"":request.getParameter("workFlowCode");

if(strTravellerId.trim().equalsIgnoreCase("")){
	strTravellerId=Suser_id;
}
if(strSiteId != null && !"0".equals(strSiteId) && !"-1".equals(strTravellerId)) {
 	approverList = dao.getApproverList(strSiteId, strTravellerId, strTravelType, strWorkFlowCode);
}

//CODE ADDED BY MANOJ CHAND ON 17 APRIL 2012 TO FETCH WORKFLOW NAME OF TRAVELLER
strSql="SELECT SITE_ID,DBO.SITENAME(SITE_ID) AS SITE_NAME FROM M_SITE WHERE SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
rs = dbConBean.executeQuery(strSql);
	if(rs.next()){  
		strSiteName= rs.getString("SITE_NAME");	 		
	 }
rs.close();

if(!"".equals(strSiteName) && !"-1".equals(strTravellerId)){
	strMsg = "Can’t proceed further due to following reasons:-<br />A) Report To(Approver Level1)/Department Head(Approver Level2) is not defined in your profile.<br />B) Default workflow is applicable, but not defined.<br />Please contact to Local Administrator of your unit.";
} else {
	strMsg = "Approver(s) not Exists.";
}
%>
</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="approverList">
	   <tr>
			<td>
				<%
					if(approverList == null || approverList.size() == 0) {
				%>
					<table width="100%" align="center" border="0" cellpadding="1" cellspacing="1"  class="formborder">
					   <tr>
					     <td align="left" class="approverNotExists"><%=strMsg %></td>
					   </tr>
					</table>
				<% 
					} else {
				%>
					<table width="100%" align="center" border="0" cellpadding="1" cellspacing="1"  class="formborder">
					 	<tr class="defaultAppTr">
			                <td width="2%" align=center></td>
			                <td width="35%" align=left class="defaultAppTrTxt"><b><%=dbLabelBean.getLabel("label.createrequest.approvers",strsesLanguage) %></b></td>
			                <td width="38%" align=left class="defaultAppTrTxt"><b><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></b></td>
			                <td width="25%" align=left class="defaultAppTrTxt"><b><%=dbLabelBean.getLabel("label.master.approverlevel",strsesLanguage) %></b></td>
			             </tr>
			              <%
								for(int i = 0; i < approverList.size(); i++) {
									Approver approver = (Approver) approverList.get(i);
									if (iCls%2 == 0) { 
										strStyleCls="evenTr2";
								    } else { 
										strStyleCls="oddTr1";
								    }									
									iCls++;
						  %>	
						 <tr class="<%=strStyleCls%>">
			                <td width="2%" align=center><img src="images/arrow_3red_hl.gif?buildstamp=2_0_0" width="9" height="9"></td>
			                <td width="35%" align=left class="defaultAppTrTxt"><%=approver.getName()%></td>
			                <td width="38%" align=left class="defaultAppTrTxt"><%=approver.getDesignationName()%></td>
			                <td width="25%" align=left class="defaultAppTrTxt"><%=approver.getApproverLevel()%></td>
			             </tr>
			             <% 
			             		}
			             %>			             
					</table>
				<%
					}
				%> 	
			</td>
		</tr>
	</table>
</body>
</html>