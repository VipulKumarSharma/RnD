<%/***************************************************
			 *The information contained here in is confidential and 
			 * proprietary to MIND and forms the part of the MIND 
			 *Author				:Abhinav Ratnawat
			 *Date of Creation 		:09 September 2006
			 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
			 *Project	  			:STAR
			 *Operating environment :Tomcat, sql server 2000 
			 *Description 			:This is first jsp file  for updating the SITE in the STAR Database
			 *Modification 			:      1.Added A New Code For Showing Duration And Travel Type For Reports
			 *Reason of Modification:  
			 *Date of Modification  : 1. 15-May-07
			 *Revision History		: 1.   by Shiv Sharma on 15-May-07
 
			 *Editor				:Editplus
			 
			 *Modified By			:Manoj Chand
			 *Date of Modification	:09 March 2012
			 *Modification			:For all site data is not coming when user who have role corp is viewing reports
*******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include file="importStatement.jsp"%>
<html>
<head>
<%-- include remove cache  --%>
<%@ include file="cacheInc.inc"%>
<%-- include header  --%>
<%@ include file="headerIncl.inc"%>
<%-- include page with all application session variables --%>
<%@ include file="application.jsp"%>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
</head>
<body>

<%
ResultSet rs = null;
String strFrom = "";
String strSql="";
			String strTo = "";
			String strTravelType = "";
			String strDivision = "";
			String strSiteId = "";
			String strSiteName = "";
			String strTotalReq = "";
			String strTotalApp = "";
			String strTotalRej = "";
			String strTotalRet = "";
			String strTotalCan = "";
			String strTotalPend = "";
			String strTotalPendChair = "";
			String strApproverRole 	 =  "";
			// new code added 

			String strUnitHidden="";
			String strAppendQuery="";
			String strSelectUnit ="";
			String strtraveltype	 ="";
			String strSitenamefordisplay="";

			int intTotalReq = 0;
			int intTotalApp = 0;
			int intTotalRej = 0;
			int intTotalRet = 0;
			int intTotalCan = 0;
			int intTotalPend = 0;
			int intTotalPendChair = 0;


			strFrom = request.getParameter("from");
			strTo = request.getParameter("to");
			strTravelType = request.getParameter("travelType");
			strUnitHidden = request.getParameter("UnitHidden");
			 
     		strSelectUnit = request.getParameter("SelectUnit"); 
            
			// System.out.println("SelectUnit=======.......====>>"+strSelectUnit); 

//// by shiv on 15-May-07 open
			if(strTravelType.equals("I"))
				{
					 strtraveltype=dbLabelBean.getLabel("label.report.international",strsesLanguage);
					 if(ssflage.equals("3")){
						 strtraveltype = "Intercont";
					 }
				 }
		 if(strTravelType.equals("D"))
				{
					 strtraveltype=dbLabelBean.getLabel("label.report.domestic",strsesLanguage);
					 if(ssflage.equals("3")){
						 strtraveltype = "Domestic/Europe";
					 }
				 }
//// by shiv on 15-May-07 close

   if(strSelectUnit.equals("0")) 
				{
				 strSitenamefordisplay=dbLabelBean.getLabel("label.report.forallunits",strsesLanguage);
				 }
	else
		        {
	                   strSql="select isnull(dbo.sitename("+strSelectUnit+"),'') as sitename from M_site where status_id=10" ;  
	           
				 	rs = dbConBean.executeQuery(strSql);
		                while (rs.next()) 
		                     {
						     strSitenamefordisplay=rs .getString("sitename");  
					         }
						rs.close();
						//System.out.println("strSitenamefordisplay>>>"+strSitenamefordisplay);
                        strSitenamefordisplay= " in " + strSitenamefordisplay;   
			       } 

%>
<script type="text/javascript" language="JavaScript1.2"
	src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<!-- Code  modified  on 15-May-07  by shiv open    -->
<table width="100%" border="0" cellspacing="0" cellpadding="10">
	<tr>
		<td width="77%" height="40" class="bodyline-top">
		<ul class="pagebullet">
			<li class="pageHead"><b> <%=dbLabelBean.getLabel("label.report.analysisreportfor",strsesLanguage) %>  <%=strtraveltype %> <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %>  <%=strSitenamefordisplay %>  (<%=dbLabelBean.getLabel("label.report.between",strsesLanguage) %>  <%=strFrom %>  - <%=strTo %>)</b></li>
		</ul>
		</td>
	</tr>
</table>
<!-- modified on 15-May-07  by shiv Close    -->
<table width="95%" align="center" border="0" cellpadding="5"
	cellspacing="1" class="formborder">
	<tr align="left" class="formhead">
	     <td width="3%" class="rep-head" nowrap="nowrap"><b>&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></b></td>
		<td width="15%" class="rep-head"><b><%=dbLabelBean.getLabel("label.requestdetails.division",strsesLanguage) %></b></td>
		<td width="17%" class="rep-head"><b><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></b></td>
		<td width="8%" class="rep-head"><b><%=dbLabelBean.getLabel("label.report.totalcreated",strsesLanguage) %></b></td>
		<td width="5%" class="rep-head"><b><%=dbLabelBean.getLabel("label.reports.approved",strsesLanguage) %></b></td>
		<td width="5%" class="rep-head"><b><%=dbLabelBean.getLabel("label.requestdetails.rejected",strsesLanguage) %></b></td>
		<td width="5%" class="rep-head"><b><%=dbLabelBean.getLabel("label.requestdetails.returned",strsesLanguage) %></b></td>
		<td width="10%" class="rep-head"><b><%=dbLabelBean.getLabel("label.requestdetails.cancelled",strsesLanguage) %></b></td>
		<td width="7%" class="rep-head"><b><%=dbLabelBean.getLabel("label.search.pending",strsesLanguage) %></b></td>
		<td width="15%" class="rep-head"><b><%=dbLabelBean.getLabel("label.report.pendingwithgroupchairman",strsesLanguage) %></b></td>
	</tr>
	<%// Variables declared and initialized
			Connection con = null; // Object for connection
			Statement stmt = null; // Object for Statement
			 // Object for result set

			//Create Connection

             strUnitHidden=strSelectUnit;
			if(strUnitHidden.equals("0"))
			{
			strAppendQuery="";
			}
			else
			{
			strAppendQuery="AND M_SITE.SITE_ID ="+ strUnitHidden;
			}
			// Code if the user selects to display the report manually

			//Class.forName(Sdbdriver);
			String sqlStr = "";
			int iCls = 0;
			int sn=1;
			String strStyleCls = "";
			try {
				//Query for Finding the role of approver
				 strSql = "SELECT ROLE_ID FROM M_USERINFO WHERE USERID = "+ Suser_id+ " AND APPLICATION_ID =1 AND STATUS_ID=10";
				//System.out.println("strSql ------------->"+strSql);
				rs = dbConBean.executeQuery(strSql); //get the result set
				if (rs.next()) {
					strApproverRole = rs.getString(1);
				}
				rs.close();
				//changed by manoj chand on 09 march 2012 add condition for role "CORP" to display report to corp role user.
             if ((strApproverRole !=null && ( strApproverRole.trim().equals("CHAIRMAN") || strApproverRole.trim().equals("AD") || strApproverRole.trim().equals("OR") || strApproverRole.trim().equals("CORP") || strApproverRole.trim().equals("SM")) )  && strUnitHidden.equals("0"))
				{
					if (strTravelType != null && strTravelType.equals("I")) 
					{
					    sqlStr = "SET DATEFORMAT DMY SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,M_SITE.SITE_ID,M_SITE.SITE_NAME,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID =  M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQAPP,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 4 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQREJ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 3 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQRET,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 6 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALCANREQ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'  AND TM.SITE_ID =  M_SITE.SITE_ID AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO )) AS TOTALPENDING,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'  AND TM.SITE_ID =  M_SITE.SITE_ID AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO WHERE ROLE_ID = 'CHAIRMAN')) AS TOTALPENDING_CHAIR FROM M_SITE INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON M_SITE.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE  STATUS_ID=10    AND     APPLICATION_ID=1 ORDER BY 1,3";
				//System.out.println("sqlStr------1---->"+sqlStr);		 
					 } 
					 else 
					 {	
					    sqlStr = "SET DATEFORMAT DMY SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,M_SITE.SITE_ID,M_SITE.SITE_NAME,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID =  M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQAPP,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 4 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQREJ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 3 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQRET,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = M_SITE.SITE_ID AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 6 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALCANREQ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'  AND TM.SITE_ID =  M_SITE.SITE_ID AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO )) AS TOTALPENDING,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'   AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO WHERE ROLE_ID = 'CHAIRMAN')) AS TOTALPENDING_CHAIR FROM M_SITE INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON M_SITE.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE  STATUS_ID=10   AND   APPLICATION_ID=1 ORDER BY 1,3";
			//System.out.println("sqlStr------2---->"+sqlStr);
					}
				}
                else 
				{

					if (strTravelType != null && strTravelType.equals("I")) 
					{
						 
						sqlStr = "SET DATEFORMAT DMY SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,M_SITE.SITE_ID,M_SITE.SITE_NAME,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+ " AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID !=1  AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQAPP,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 4 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQREJ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 3 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQRET,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 6 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALCANREQ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'  AND TM.SITE_ID =  "+strUnitHidden+" AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO )) AS TOTALPENDING,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'  AND TM.SITE_ID =  "+strUnitHidden+" AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO WHERE ROLE_ID = 'CHAIRMAN')) AS TOTALPENDING_CHAIR FROM M_SITE WHERE M_SITE.SITE_ID IN(select site_id from m_site where site_id = '"
						+ strUnitHidden
						+ "') AND STATUS_ID=10 AND APPLICATION_ID=1 "+strAppendQuery +" ORDER BY 1,3";
				//System.out.println("sqlStr------2---->"+sqlStr);
					} 
					else 
					{	
						 
					    sqlStr = "SET DATEFORMAT DMY SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,M_SITE.SITE_ID,M_SITE.SITE_NAME,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+ "AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID != 1 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQAPP,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 4 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQREJ,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 3 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALREQRET,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND '"
						+ strTo
						+ "' AND TM.SITE_ID = "+strUnitHidden+" AND TM.TRAVEL_REQ_ID = TS.TRAVEL_REQ_ID AND TM.TRAVEL_TYPE = '"+strTravelType+"'AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 6 AND TM.STATUS_ID = 10 AND TM.APPLICATION_ID = 1) AS TOTALCANREQ, (SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'  AND TM.SITE_ID =  "+strUnitHidden+" AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO )) AS TOTALPENDING,(SELECT COUNT(*) FROM T_TRAVEL_MST TM,T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE CAST(FLOOR(CAST(TM.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"
						+ strFrom
						+ "' AND'"
						+ strTo
						+ "' AND   TS.TRAVEL_STATUS_ID = 2 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND  TM.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_TYPE = '"+strTravelType+"'  AND TM.SITE_ID =  "+strUnitHidden+" AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO WHERE ROLE_ID = 'CHAIRMAN')) AS TOTALPENDING_CHAIR FROM M_SITE WHERE M_SITE.SITE_ID IN(select site_id from m_site where site_id = '"
						+ strUnitHidden
						+ "') AND STATUS_ID=10 AND APPLICATION_ID=1"+strAppendQuery +" ORDER BY 1,3";
				//System.out.println("sqlStr------4---->"+sqlStr);
					}
				}
				
				rs = dbConBean.executeQuery(sqlStr);
				while (rs.next()) {
					strDivision = rs.getString("DIV");
					strSiteId = rs.getString("SITE_ID");
					strSiteName = rs.getString("SITE_NAME");
					strTotalReq = rs.getString("TOTALREQ");
					strTotalApp = rs.getString("TOTALREQAPP");
					strTotalRej = rs.getString("TOTALREQREJ");
					strTotalRet = rs.getString("TOTALREQRET");
					strTotalCan = rs.getString("TOTALCANREQ");
					strTotalPend = rs.getString("TOTALPENDING");
					strTotalPendChair = rs.getString("TOTALPENDING_CHAIR");
					intTotalReq = intTotalReq + Integer.parseInt(strTotalReq);
					intTotalApp = intTotalApp + Integer.parseInt(strTotalApp);
					intTotalRej = intTotalRej + Integer.parseInt(strTotalRej);
					intTotalRet = intTotalRet + Integer.parseInt(strTotalRet);
					intTotalCan = intTotalCan + Integer.parseInt(strTotalCan);
					intTotalPend = intTotalPend	+ Integer.parseInt(strTotalPend);
					intTotalPendChair = intTotalPendChair+ Integer.parseInt(strTotalPendChair);
					
					%>
	<%if (iCls % 2 == 0) {
						strStyleCls = "formtr1";
					} else {
						strStyleCls = "formtr2";
					}

					iCls++;
%>
	<tr align="left" class="<%=strStyleCls%>">
	     <td class="rep-txt">&nbsp;&nbsp;&nbsp;&nbsp;<%=sn++%></td>
		<td class="rep-txt"><%=strDivision%></td>
		<td class="rep-txt"><%=strSiteName%></td>
		<td class="rep-txt"><a href="#"
			onClick="MM_openBrWindow('RequistionSummaryReportDetails.jsp?id=1&from=<%=strFrom%>&to=<%=strTo%>&siteId=<%=strSiteId%>&travelType=<%= strTravelType %>','c','scrollbars=YES,width=800,height=500,resizable=yes')"><%=strTotalReq%></a></td>
		<td class="rep-txt"><a href="#"
			onClick="MM_openBrWindow('RequistionSummaryReportDetails.jsp?id=2&from=<%=strFrom%>&to=<%=strTo%>&siteId=<%=strSiteId%>&travelType=<%= strTravelType %>','c','scrollbars=YES,width=800,height=500,resizable=yes')"><%=strTotalApp%></a></td>
		<td class="rep-txt"><a href="#"
			onClick="MM_openBrWindow('RequistionSummaryReportDetails.jsp?id=3&from=<%=strFrom%>&to=<%=strTo%>&siteId=<%=strSiteId%>&travelType=<%= strTravelType %>','c','scrollbars=YES,width=800,height=500,resizable=yes')"><%=strTotalRej%></a></td>
		<td class="rep-txt"><a href="#"
		onClick="MM_openBrWindow('RequistionSummaryReportDetails.jsp?id=4&from=<%=strFrom%>&to=<%=strTo%>&siteId=<%=strSiteId%>&travelType=<%= strTravelType %>','c','scrollbars=YES,width=800,height=500,resizable=yes')"><%=strTotalRet%></a></td>

		<td class="rep-txt"><a href="#" 
	onClick="MM_openBrWindow('RequistionSummaryReportDetails.jsp?id=5&from=<%=strFrom%>&to=<%=strTo%>&siteId=<%=strSiteId%>&travelType=<%= strTravelType %>','c','scrollbars=YES,width=800,height=500,resizable=yes')"><%=strTotalCan%></a></td>


				<td class="rep-txt"><a href="#"
			onClick="MM_openBrWindow('RequistionSummaryReportDetails.jsp?id=6&from=<%=strFrom%>&to=<%=strTo%>&siteId=<%=strSiteId%>&travelType=<%= strTravelType %>','c','scrollbars=YES,width=800,height=500,resizable=yes')"><%=strTotalPend%></a></td>
		  <td class="rep-txt"><a href="#"
			onClick="MM_openBrWindow('RequistionSummaryReportDetails.jsp?id=7&from=<%=strFrom%>&to=<%=strTo%>&siteId=<%=strSiteId%>&travelType=<%= strTravelType %>','c','scrollbars=YES,width=800,height=500,resizable=yes')"><%=strTotalPendChair%></a></td> 
	</tr>
	<%
		}
		rs.close();
%>
	<tr align="left" class="formbottom">
	     
		<td  colspan="3" align="center" class="pageHead"><%=dbLabelBean.getLabel("label.global.total",strsesLanguage) %></td>
		<td class="rep-txt" align="left"><%=intTotalReq%></td>
		<td class="rep-txt" align="left"><%=intTotalApp%></td>
		<td class="rep-head" align="left"><%=intTotalRej%></td>
		<td class="rep-head" align="left"><%=intTotalRet%></td>		
		<td class="rep-head" align="left"><%=intTotalCan%></td>		
		<td class="rep-head" align="left"><%=intTotalPend%></td>
		<td class="rep-head" align="left"><%=intTotalPendChair%></td>
	   
	</tr>
	<%				

			} catch (Exception e) {
				System.out.println("Error in RequisitionSummaryReportPost.jsp------->" + e);
			}
dbConBean.close();  //Close all Connection

		%>
