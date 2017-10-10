	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Kaveri Garg
	 *Date of Creation 		:14 August 2012
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is first jsp file  for displaying the workflow details to LA.
	 *Editor				:Editplus			 
	 *******************************************************/ 
	%>
	<%@ page pageEncoding="UTF-8" %>
	<%-- Import Statements  --%>
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
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	<%@page import="src.dao.starDaoImpl"%>
	<%@page import="src.beans.WorkflowApprovalMatrix" %>
	<%
	String strSiteId = request.getParameter("ID");
	
	String strMessg = request.getParameter("strMessg")==null?"":request.getParameter("strMessg");
	String strUserID = (request.getParameter("UINFO")== null) ? "-1" : request.getParameter("UINFO");
	//System.out.println("site id of user=============="+strSiteIdSS);
	String strVal	 = (request.getParameter("VAL")==null)?"0":request.getParameter("VAL");
	String strWKType = request.getParameter("TYPE");
	String strLabel	 = "";
	String strSql ="";
	String strSiteID="";
	String strUserid="";
	
	
	
	
	String strStyleCls = "";
	int iCls = 0;
	ResultSet objRs = null;
	ResultSet objRs1 = null;
	
	String strsmrsiteflag="";
	String strDivName="";
	String strSiteName="";
	String strSiteTravelAgencyID="";
	
	//Added By GURMEET SINGH on 17-Feb-14 for check unit access of user
	String strSiteIdCheckFlag=	"true";
	ArrayList aListSiteId = new ArrayList();
	
	 aListSiteId = dbUtility.findReportSiteAccessListForUser(SuserRole, SuserRoleOther, strSiteIdSS, Suser_id,strsesLanguage);
		
		if(!aListSiteId.contains(strSiteId.trim())){
			strSiteIdCheckFlag = "false";
		}	
			
		if(strSiteIdCheckFlag.equals("false")){
			dbConBean.close();  
			dbConBean1.close();	
			response.sendRedirect("UnauthorizedAccess.jsp");
		} 	
		else{				
	
	//System.out.println("strSiteId================="+strSiteId);
	
	//To Find the SMR SITE Flag from SMR       
	
	
	strSql="select isnull(SMR_SITE_FLAG,'n') as SMR_SITE_FLAG, TRAVEL_AGENCY_ID from m_site where site_id="+strSiteId+" and status_id=10";
	
    objRs = dbConBean.executeQuery(strSql);
	
	  while(objRs.next())
	  {      
		  strsmrsiteflag= objRs.getString("SMR_SITE_FLAG");
		  strSiteTravelAgencyID=objRs.getString("TRAVEL_AGENCY_ID");
	  }
	  
	 //System.out.println("strsmrsiteflage================="+strsmrsiteflag);
	
	if(strWKType.equals("1"))
	{
		//strLabel=dbLabelBean.getLabel("label.administration.production",strsesLanguage);
	}
	
	int iLoop=1;
	%>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<base target="middle"> 
	
	<SCRIPT LANGUAGE="JavaScript">
	 
	function MM_openBrWindow(theURL,winName,features) 
	{
	window.open(theURL,winName,features);
	}
	 </script>
	
	</head>
	
	
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="70%" height="35" class="bodyline-top">  
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.administration.administratorproductionworkflow",strsesLanguage)%>  >
	      <%
		if(strWKType.equals("1"))
		{
	%>
	
		<% 
		objRs = dbConBean.executeQuery("SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,SITE_NAME FROM M_SITE WHERE SITE_ID="+strSiteId+" AND APPLICATION_ID = 1 ORDER BY 1,2");
		while (objRs.next()) {
			strDivName=objRs.getString("DIV");
			strSiteName=objRs.getString("SITE_NAME");
		%>
		<%=strDivName %> \ <%=strSiteName%>  &nbsp;&nbsp;<%=strMessg%>
		<% } %>
	
	<%
		}
	%>
		  </li>
	    </ul>    </td>
	    <td width="30%" align="right" valign="bottom" class="bodyline-top">
		  	  <table align="right" border="0" cellspacing="0" cellpadding="0">
	      <tr align="right">
	      <td>
	      <ul id="list-nav">
	      <!-- export to excel link added by manoj chand on 09 july 2012 -->
				<li><a href="#" onclick="window.open('./ExportWorkflowToExcel?site_id=<%=strSiteId %>&site_name=<%=strSiteName %>&lang=<%=strsesLanguage %>','_self','scrollbars=yes, resizable=yes,top=280,left=350,width=1,height=1');">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.report.exporttoexcel",strsesLanguage)%>&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
				<li><a href="#" onClick="MM_openBrWindow('M_searchInitial.jsp','USER','scrollbars=yes,width=975,height=00,resizable=yes')">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%>&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
				<li><a href="#" onClick="window.print();">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%>&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
		  </ul>
	      </td>
	      </tr>
	    </table>
		</td> 
	  </tr>
	</table>
	<br>
	<form method=post name="frm">
	<input type=hidden name="ID" value="<%=strSiteId%>">
	<input type=hidden name="TYPE" value="<%=strWKType%>">
	
	</form>
	<!--  This only block only shown for those Unit's whose TRAVEL_AGENCY_ID is 2 (Belongs to MATA GmbH...) added by Sandeep Malik on 12/08/2015 --> 
	<% if(strSiteTravelAgencyID != null && "2".equals(strSiteTravelAgencyID.trim())){
	
			Map dataMap = (Map)new starDaoImpl().getMATA_GmbH_WorkflowMatrixData(strSiteId);
			
			WorkflowApprovalMatrix matrixWithFlightDom 		= null;
			WorkflowApprovalMatrix matrixWithoutFlightDom 	= null;
			WorkflowApprovalMatrix matrixWithFlightInt 		= null;
			
			if(dataMap != null && !dataMap.isEmpty()){
				matrixWithFlightDom 		=	dataMap.get("D-1") != null ? (WorkflowApprovalMatrix)dataMap.get("D-1") : null;
				matrixWithoutFlightDom		=	dataMap.get("D-0") != null ? (WorkflowApprovalMatrix)dataMap.get("D-0") : null;
				matrixWithFlightInt			=	dataMap.get("I-1") != null ? (WorkflowApprovalMatrix)dataMap.get("I-1") : null;
			}
			
	%>
	
	<script type="text/javascript">
		var message = '<%=request.getParameter("message")%>';
		if(message != null && message != '' && message != 'null' ){
			alert(message);
		}
	</script>
	<div style="margin:0 auto; margin-bottom:10px;">
		<input type=hidden name="ID" value="<%=strSiteId%>">
		<input type=hidden name="TYPE" value="<%=strWKType%>">
		<input type="hidden" name="actionType" id="actionType" value="enableApproverLevels"/>
		<table width="58%" border="0" align="center" cellpadding="2" cellspacing="1" style="padding-bottom: 15px;margin:0 auto;">
			<tr class="formhead"> 
				<td colspan="7"><%=dbLabelBean.getLabel("label.global.travelworkflowmatrixheading",strsesLanguage)%></td> 
		  </tr>
		  <tr> 
			<td class="formhead" ><b><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%></b></td> 
			<td class="formhead" ><b><%=dbLabelBean.getLabel("label.global.approverlevel1",strsesLanguage)%></b></td>
			<td class="formhead"><%=dbLabelBean.getLabel("label.global.approverlevel2",strsesLanguage)%></td>
			<td class="formhead"><%=dbLabelBean.getLabel("label.user.defaultapprover",strsesLanguage)%></td>
			<%-- <td class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%></td> --%>
		  </tr>
		  <tr> 
			<td class="formtr2" ><b><%=dbLabelBean.getLabel("label.global.domesticwithflight",strsesLanguage)%></b></td> 
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithFlightLevel1" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isApproverLevel_1_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithFlightLevel2" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isApproverLevel_2_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithFlightDefault" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isDefaultApproversEnable()) ? "checked" : ""  %>/></td>
<%-- 			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithFlightBillingApp" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isBillingApproversEnable()) ? "checked" : ""  %>/></td>
 --%>		  </tr>
		  <tr> 
			<td class="formtr2" ><b><%=dbLabelBean.getLabel("label.global.domesticwithoutflight",strsesLanguage)%></b></td> 
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithoutFlightLevel1" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isApproverLevel_1_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithoutFlightLevel2" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isApproverLevel_2_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithoutDefault" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isDefaultApproversEnable()) ? "checked" : ""  %>/></td>
<%-- 			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="domWithoutFlightBillingApp" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isBillingApproversEnable()) ? "checked" : ""  %>/></td>
 --%>		  </tr>
		  <tr> 
			<td class="formtr2" ><b><%=dbLabelBean.getLabel("label.global.internationalwithflight",strsesLanguage)%></b></td> 
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="interLevel1" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isApproverLevel_1_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="interLevel2" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isApproverLevel_2_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="interDefault" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isDefaultApproversEnable()) ? "checked" : ""  %>/></td>
<%-- 			<td class="formtr2" ><input type="checkbox" disabled="disabled" name="interBillingApp" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isBillingApproversEnable()) ? "checked" : ""  %>/></td>
 --%>		  </tr>
		</table>
	</div>
	<%} %>
	<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" style="margin:0 auto;">
	  <tr class="formhead"> 
		<td colspan="7"><%=dbLabelBean.getLabel("label.administration.workflowdetails",strsesLanguage)%></td> 
	  </tr>
	  <tr > 
		<td class="formhead" ><b><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></b></td> 
		<td class="formhead" ><b><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%></b></td>
		<td class="formhead"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
		<td class="formhead"><%=dbLabelBean.getLabel("label.administration.orderofapproval",strsesLanguage)%></td>
		
		<td class="formhead"><%=dbLabelBean.getLabel("label.administration.workflownumber",strsesLanguage) %></td>
		
		<td class="formhead"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%></td>
			  </tr>
	
	<%
	String strListParam="";
	strListParam=" AND M_DEFAULT_APPROVERS.SITE_ID='"+strSiteId.trim()+"' ";
	%>
	
	<% 
	String strMaxOrderId	=	"";
	//Query for find the max order id for setting tha email link of MATA Associate
/*	strSql="SELECT max(ORDER_ID) AS MAX_ORDER_ID  FROM M_DEFAULT_APPROVERS WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+"";
	//System.out.println("strSql---dom--->"+strSql);
	objRs = dbConBean.executeQuery(strSql); 
	if(objRs.next()){
			strMaxOrderId=objRs.getString("MAX_ORDER_ID");
			//System.out.println("strMaxorderid--dom--->"+strMaxOrderId);
	}
	objRs.close();
	*/
		//change by manoj remove  && SuserRole.equals("AD")
	
	//strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME, .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID,sp_role ,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE FROM M_DEFAULT_APPROVERS WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='d' ORDER BY sp_role,ORDER_ID";
	/*strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME,"+ 
		" .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID,sp_role ,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE"+ 
		" ,case when order_id = (select max(order_id) from M_DEFAULT_APPROVERS MDA"+
		" where MDA.APPLICATION_ID =M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID  AND MDA.SITE_ID=M_DEFAULT_APPROVERS.SITE_ID"+
		" and MDA.TRV_TYPE=M_DEFAULT_APPROVERS.TRV_TYPE and MDA.sp_role= M_DEFAULT_APPROVERS.sp_role) then 'y' else 'n' end AS FLAG"+
		" FROM M_DEFAULT_APPROVERS"+ 
		" WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='d' ORDER BY sp_role,ORDER_ID";*/
	
		//change in queries by manoj chand on 01 mar 2012 to resolve issue of showing old designation in domestic workflow	
	strSql="SELECT  DA_ID , .DBO.USER_NAME(APPROVER_ID) AS APP , .DBO.DESIGNATIONNAME(MU.DESIG_ID) AS DESIGNAME ,"+ 
		" .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE , ORDER_ID , M_DEFAULT_APPROVERS.sp_role , RTRIM(TRV_TYPE) AS TRV_TYPE ,"+
		" CASE WHEN order_id= ( SELECT  max(order_id) FROM    M_DEFAULT_APPROVERS MDA"+
		" WHERE   MDA.APPLICATION_ID = M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID"+
		" AND MDA.SITE_ID = M_DEFAULT_APPROVERS.SITE_ID AND MDA.TRV_TYPE = M_DEFAULT_APPROVERS.TRV_TYPE AND MDA.sp_role = M_DEFAULT_APPROVERS.sp_role )"+
		" THEN 'y' ELSE 'n' END AS FLAG"+
		" FROM    M_DEFAULT_APPROVERS INNER JOIN M_USERINFO MU ON M_DEFAULT_APPROVERS.APPROVER_ID=MU.USERID"+
		" WHERE   M_DEFAULT_APPROVERS.APPLICATION_ID= 1 AND M_DEFAULT_APPROVERS.STATUS_ID= 10 AND MU.STATUS_ID=10 "+strListParam+" AND TRV_TYPE= 'd'"+
		" ORDER BY sp_role , ORDER_ID";	
	
		//System.out.println("strSql---dm if smr--->"+strSql);
	
		//strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME, .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE FROM M_DEFAULT_APPROVERS WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='d' ORDER BY ORDER_ID";
		/*strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME,"+ 
		". DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID ,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE"+ 
		" ,case when order_id = (select max(order_id) from M_DEFAULT_APPROVERS MDA"+
		" where MDA.APPLICATION_ID =M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID  AND MDA.SITE_ID=M_DEFAULT_APPROVERS.SITE_ID"+
		" and MDA.TRV_TYPE=M_DEFAULT_APPROVERS.TRV_TYPE ) then 'y' else 'n' end AS FLAG"+
		" FROM M_DEFAULT_APPROVERS"+ 
		" WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='d' ORDER BY ORDER_ID";*/
		
		//change in queries by manoj chand on 01 mar 2012 to resolve issue of showing old designation in domestic workflow	
		
		//System.out.println("strSql---dm->"+strSql);	

	
		
	// code changed by shiv on 26-Sep-07  
	String strtextforCC ="";
	String strApprovername="";
	String strApproverDesgName="";
	String strApproverRole="";
	String strOrderId="";
	String strSprole="0";
	String strremarks = "";
	String strremarksflag = "";
	objRs = dbConBean.executeQuery(strSql); 
	
	while (objRs.next()) {
		String strID = 	objRs.getString(1);  
	    strApprovername=objRs.getString("APP");
		strApproverDesgName=objRs.getString("DESIGNAME").trim();
		strApproverRole	= objRs.getString("APPROVER_ROLE");
		strOrderId	= objRs.getString("ORDER_ID");
		//change by manoj remove  && SuserRole.equals("AD")
		if(strsmrsiteflag.equalsIgnoreCase("y"))
		{
		strSprole	=objRs.getString("sp_role");
		}
		String strTrvID = objRs.getString("TRV_TYPE");
		String strMaxorder=objRs.getString("FLAG");
		if(strOrderId!=null && strMaxorder.trim().equals("y")){ 
			strtextforCC=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage);
		}else{
			strtextforCC="";
		}
		
		%>
	
		<tr>
			<td class="formtr2"><%=iLoop++%></td>
	        <td class="formtr2"><%= strApprovername%></td> 
			<td class="formtr2"><%= strApproverDesgName%></td> 
			<td class="formtr2"><%= strOrderId %></td>	
	    	<td class="formtr2"><%= strSprole %></td>
			<%if (strTrvID.equals("I")){ %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%></td>
			<% } else if(strTrvID.equals("D")){  %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage)%></td>
			<% } %>		
		</tr>
	<%  } %>
		<tr>	
			<td colspan="8" align="center" class="formhead">  
			<br>
			<br>
			</td>
		</tr>
		
		<% 
		iLoop=1;
	//Query for find the max order id for setting tha email link of MATA Associate
	/*strSql="SELECT max(ORDER_ID) AS MAX_ORDER_ID  FROM M_DEFAULT_APPROVERS WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+"";
	
	//System.out.println("strsql----int--->"+strSql);
	objRs = dbConBean.executeQuery(strSql); 
	if(objRs.next()){
			strMaxOrderId=objRs.getString("MAX_ORDER_ID");
			//System.out.println("strMaxOrderId--int--->"+strMaxOrderId);
	}
	objRs.close(); 
	*/
	//change by manoj remove  && SuserRole.equals("AD")
	
	//strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME, .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID,sp_role ,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE  FROM M_DEFAULT_APPROVERS WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='i' ORDER BY sp_role,ORDER_ID";
	
		/*strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME,"+ 
		" .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID,sp_role ,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE"+ 
		" ,case when order_id = (select max(order_id) from M_DEFAULT_APPROVERS MDA"+
		" where MDA.APPLICATION_ID =M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID  AND MDA.SITE_ID=M_DEFAULT_APPROVERS.SITE_ID"+
		" and MDA.TRV_TYPE=M_DEFAULT_APPROVERS.TRV_TYPE and MDA.sp_role= M_DEFAULT_APPROVERS.sp_role) then 'y' else 'n' end AS FLAG"+
		" FROM M_DEFAULT_APPROVERS"+ 
		" WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='i' ORDER BY sp_role,ORDER_ID";*/
		
		//change in queries by manoj chand on 01 mar 2012 to resolve issue of showing old designation in international workflow	
		strSql="SELECT  DA_ID , .DBO.USER_NAME(APPROVER_ID) AS APP , .DBO.DESIGNATIONNAME(MU.DESIG_ID) AS DESIGNAME , "+
			" .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE , ORDER_ID , M_DEFAULT_APPROVERS.sp_role ,  RTRIM(TRV_TYPE) AS TRV_TYPE ,"+
			" CASE  WHEN order_id = ( SELECT  max(order_id) FROM    M_DEFAULT_APPROVERS MDA"+
			" WHERE   MDA.APPLICATION_ID = M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID"+
			" AND MDA.SITE_ID = M_DEFAULT_APPROVERS.SITE_ID AND MDA.TRV_TYPE = M_DEFAULT_APPROVERS.TRV_TYPE"+
			" AND MDA.sp_role = M_DEFAULT_APPROVERS.sp_role ) THEN 'y' ELSE 'n' END AS FLAG"+
			" FROM    M_DEFAULT_APPROVERS INNER JOIN M_USERINFO MU ON M_DEFAULT_APPROVERS.APPROVER_ID=MU.USERID"+
			" WHERE   M_DEFAULT_APPROVERS.APPLICATION_ID= 1 AND M_DEFAULT_APPROVERS.STATUS_ID= 10 AND MU.STATUS_ID=10 "+strListParam+" AND TRV_TYPE= 'i'"+
			" ORDER BY sp_role , ORDER_ID";
		//System.out.println("strSql==========i===SMR====="+strSql);
	
	//strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME, .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID  ,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE  FROM M_DEFAULT_APPROVERS WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='i' ORDER BY ORDER_ID";
	
		/*strSql="SELECT  DA_ID,.DBO.USER_NAME(APPROVER_ID) AS APP,.DBO.DESIGNATIONNAME(DESIG_ID) AS DESIGNAME,"+ 
		" .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE, ORDER_ID,DA_ID,RTRIM(TRV_TYPE) AS TRV_TYPE"+ 
		" ,case when order_id = (select max(order_id) from M_DEFAULT_APPROVERS MDA"+
		" where MDA.APPLICATION_ID =M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID  AND MDA.SITE_ID=M_DEFAULT_APPROVERS.SITE_ID"+
		" and MDA.TRV_TYPE=M_DEFAULT_APPROVERS.TRV_TYPE ) then 'y' else 'n' end AS FLAG"+
		" FROM M_DEFAULT_APPROVERS"+ 
		" WHERE APPLICATION_ID =1 AND STATUS_ID = 10"+strListParam+" and TRV_TYPE='i' ORDER BY ORDER_ID";*/
	
		//change in queries by manoj chand on 01 mar 2012 to resolve issue of showing old designation in international workflow
		
		//System.out.println("strSql==========i========"+strSql);

	
	
	
	// code changed by shiv on 26-Sep-07  
	 
	objRs = dbConBean.executeQuery(strSql); 
	while (objRs.next()) {
		String strID = 	objRs.getString(1);  
	    strApprovername=objRs.getString("APP");
		strApproverDesgName=objRs.getString("DESIGNAME").trim();
		strApproverRole	= objRs.getString("APPROVER_ROLE");
		strOrderId	= objRs.getString("ORDER_ID");
		
		//change by manoj remove  && SuserRole.equals("AD")
		if(strsmrsiteflag.equalsIgnoreCase("y"))
	    {
		strSprole    = objRs.getString("sp_role");
	    }
		String strTrvID = objRs.getString("TRV_TYPE");
		String strMaxorder=objRs.getString("FLAG");
		if(strOrderId!=null && strMaxorder.trim().equals("y")){ 
			strtextforCC=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage);; 
		}else{
			strtextforCC="";
		}
%>
		<tr> 
			<td class="formtr2"><%=iLoop++%></td>
	        <td class="formtr2"><%= strApprovername%></td> 
			<td class="formtr2"><%= strApproverDesgName%></td> 
			<td class="formtr2"><%= strOrderId %></td>
			<td class="formtr2"><%= strSprole %></td>
			<%if (strTrvID.equals("I")){ %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%></td>
			<% } else if(strTrvID.equals("D")){  %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage)%></td>
			<% } %> 
	 		
		</tr>
	<%  } 
	}%>
		<tr>	
			<td colspan="8" align="center" class="formhead"> 
			<br>
			<br>
			</td>
		</tr>
	
	</table>
	
	</body>
	</html>