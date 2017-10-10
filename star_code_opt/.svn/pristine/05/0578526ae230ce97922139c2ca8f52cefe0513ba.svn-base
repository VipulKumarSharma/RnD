<%
/*******************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author								:Shiv sharma 
 *Date of Creation 				:14 jan 2008 
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  							:STAR
 *Operating environment	    :Tomcat, sql server 2000 
 *Description 						:This is jsp file for Report that shows  Person Wise Destination Report
 *Modification                       :Changed the condition  on 25 / 01 /2008 by Shiv sharma
 *Date of Modification          :  
 *Modified By	                    : 
 *Editor					            :Editplus
 ********************************************************************************************/
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
<%
	boolean reportDataFlag = false;
	ResultSet rs =null;
	String strFrom = "";
	String strTo = "";
	String strTravelType = "";
	String strDestination = "";
	String strTotalReq	  = "";
	String strRadioSelected ="";
	String strTableName	="";
	String strUnitHidden="";
	String strAppendQuery="";
	String strSelectUnit="";
	
	String strtraveltype=""; 
	String strSql	                           =""; 
	String strSitename                     ="";
	String userID							="";
	String strCondition ="";
	strFrom = request.getParameter("from");
	strTo = request.getParameter("to");
	strTravelType = request.getParameter("travelType");
	
	strRadioSelected = "Manual";
	
	strUnitHidden = request.getParameter("UnitHidden");
	userID     = request.getParameter("username");
	strSelectUnit = request.getParameter("SelectUnit");
	strUnitHidden=strSelectUnit;

     if(strUnitHidden.equals("0")) 	{
			 strSitename=dbLabelBean.getLabel("label.report.forallunits",strsesLanguage);
	 }
	else    {
	         strSql="select isnull(dbo.sitename("+strUnitHidden+"),'') as sitename from M_site where status_id=10" ;  
	        
			rs = dbConBean.executeQuery(strSql);
		                while (rs.next()) 
		                     {
						     strSitename=rs .getString("sitename");  
					         }
						rs.close();
                        strSitename= " in " + strSitename;   
				 
		       } 


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

%>

<body>
<script type="text/javascript" language="JavaScript1.2"	src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
	<td width="77%" height="50" class="bodyline-top">
 	  <ul class="pagebullet"><li class="pageHead"><b><%=dbLabelBean.getLabel("label.report.personwisedestinationreportfor",strsesLanguage) %> <%=strtraveltype %>  <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %> <%=strSitename %>  ( <%=dbLabelBean.getLabel("label.report.between",strsesLanguage) %>  <%=strFrom %>  - <%=strTo %>) </b></li></ul>
	</td>
  </tr>
</table>

<%

		if(userID.equals("0"))	{
			strCondition ="";
			}
			else	{
				          ///changed the condition  on 25 / 01 /2008 by Shiv sharma 
							 if(strTravelType.equals("I"))
								{
										strCondition= "AND (T_TRAVEL_DETAIL_INT.TRAVELLER_ID = "+userID+") " ;
										 
								 }
								 else 
								{
									strCondition= "AND (T_TRAVEL_DETAIL_DOM.TRAVELLER_ID = "+userID+") " ;
								 }
			}

		if(strUnitHidden.equals("0"))
			{
			strAppendQuery="";
			}
			else
			{
		  if(strTravelType.equals("I"))
			{
				strAppendQuery = "and TD.TRAVEL_ID in ( select travel_id from t_travel_detail_int td where td.site_id ="+ strUnitHidden +")";
			}
		  else
			{
				strAppendQuery = "and TD.TRAVEL_ID in ( select travel_id from t_travel_detail_dom td where td.site_id ="+ strUnitHidden +")";
			}
		}

if(strRadioSelected.equals("Manual"))
{
%><br/>
  <table width="60%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
    <tr align="left" class="formhead">
	  <td width="5%" class="rep-head"  ><b><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></b></td>
	   <td width="25%" class="rep-head"><b><%=dbLabelBean.getLabel("label.report.personname",strsesLanguage) %></b></td>
	  <td width="20%" class="rep-head"><b><%=dbLabelBean.getLabel("label.report.destinations",strsesLanguage) %></b></td>
	  <td width="15%" class="rep-head"><b><%=dbLabelBean.getLabel("label.report.totalrequisitionscreated",strsesLanguage) %></b></td>
	</tr>
<%
	// Variables declared and initialized
	
	//ResultSet rs = null; // Object for result set
	String sqlStr = "";
	int iCls = 0;
	int sn=1;
	String strStyleCls = "";
	String strEmployee="";
	
	try 
	{		
		//Query for Finding the role of approver
		if(strTravelType.equals("I"))
		{
		   
            sqlStr="SET DATEFORMAT DMY SELECT     UPPER(dbo.user_name(T_TRAVEL_DETAIL_INT.TRAVELLER_ID)) AS USERNAME, UPPER(TD.TRAVEL_TO) AS TRAVEL_TO, COUNT(*)     AS REQUISTION_COUNT, T_TRAVEL_DETAIL_INT.TRAVELLER_ID FROM         T_JOURNEY_DETAILS_INT TD INNER JOIN     T_TRAVEL_STATUS TS ON TD.TRAVEL_ID = TS.TRAVEL_ID INNER JOIN    T_TRAVEL_DETAIL_INT ON TD.TRAVEL_ID = T_TRAVEL_DETAIL_INT.TRAVEL_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON T_TRAVEL_DETAIL_INT.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE     (CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT)) AS DATETIME) BETWEEN '" +strFrom+"' AND '"+ strTo +  "') AND (TS.TRAVEL_TYPE ='"+strTravelType+"') AND    (TS.TRAVEL_STATUS_ID =10) "+ strAppendQuery+"   "+strCondition+"   GROUP BY T_TRAVEL_DETAIL_INT.TRAVELLER_ID, TD.TRAVEL_TO ORDER BY  1,COUNT(dbo.user_name(T_TRAVEL_DETAIL_INT.TRAVELLER_ID))"; 
         
		// System.out.println("INT =======>> "+sqlStr);
  		}
		else if (strTravelType.equals("D"))
		{
		  sqlStr="SET DATEFORMAT DMY SELECT     UPPER(dbo.user_name(T_TRAVEL_DETAIL_DOM.TRAVELLER_ID)) AS USERNAME, UPPER(TD.TRAVEL_TO) AS TRAVEL_TO, COUNT(*)     AS REQUISTION_COUNT, T_TRAVEL_DETAIL_DOM.TRAVELLER_ID FROM         T_JOURNEY_DETAILS_DOM TD INNER JOIN     T_TRAVEL_STATUS TS ON TD.TRAVEL_ID = TS.TRAVEL_ID INNER JOIN    T_TRAVEL_DETAIL_DOM ON TD.TRAVEL_ID = T_TRAVEL_DETAIL_DOM.TRAVEL_ID INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON T_TRAVEL_DETAIL_DOM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+"  WHERE     (CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT)) AS DATETIME) BETWEEN '" +strFrom+"' AND '"+ strTo +  "') AND (TS.TRAVEL_TYPE ='"+strTravelType+"') AND  (TS.TRAVEL_STATUS_ID = 10) "+ strAppendQuery+"   "+strCondition+"   GROUP BY T_TRAVEL_DETAIL_DOM.TRAVELLER_ID, TD.TRAVEL_TO ORDER BY 1, COUNT(dbo.user_name(T_TRAVEL_DETAIL_DOM.TRAVELLER_ID))"; 
		  //  System.out.println("DOM =======>> "+sqlStr);
		}
		//System.out.println("12345678 --> "+sqlStr);

		rs = dbConBean.executeQuery(sqlStr);
		while (rs.next()) 
		{	  reportDataFlag 	= true;
	          strEmployee      	= rs.getString("USERNAME");
			  strDestination	= rs.getString("TRAVEL_TO");
			  strTotalReq		= rs.getString("REQUISTION_COUNT");
		 	  if (iCls % 2 == 0) 
			  {
				strStyleCls = "formtr1";
	          } 
			  else 
			  {
				strStyleCls = "formtr2";
			  }
			  iCls++;
%>
	 	<tr align="left" class="<%=strStyleCls%>">
	       <td class="rep-txt" align="center">&nbsp; &nbsp;<%=sn++%>&nbsp;&nbsp;</td>
	       <td class="rep-txt"><%=strEmployee%></td>
		   <td class="rep-txt"><%=strDestination%></td>
		   <td class="rep-txt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%=strTotalReq%></td>
		</tr>
<%
		}
		rs.close();
		dbConBean.close();
		
		if(!reportDataFlag) {
%>		<tr class="formtr1">
			<td colspan="7" style="text-align: center;font-weight: bold;color:red;">
				<%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage)%>
			</td>							
		</tr>
<%		} 
		
	} 
	catch (Exception e) 
	{
		System.out.println("Error in T_DestinationReportPost.jsp------->" + e);
	}
}
// code ends for vieweing the report manually
//Code starts for vieweing the report graphically  for future inhancement  
else
{  /*
	String strTableNamenew=""; 
  if(strTravelType.equals("I"))
  {
     strTableName="T_JOURNEY_DETAILS_INT";
	 strTableNamenew="T_TRAVEL_DETAIL_INT";//added new on 26-Apr-07 by shiv 

  }
  else
  {
	 strTableName="T_JOURNEY_DETAILS_DOM";
	 strTableNamenew="T_TRAVEL_DETAIL_DOM";//added new on 26-Apr-07 by shiv 
  } */
%>

  <table width="50%" align="center" border="0" cellpadding="5"	cellspacing="1" class="formborder">
<%/*
  String sqlStr = "";
  int iCls = 0;
  String strStyleCls = "";
  String  strsiteid="";

  strsiteid=strUnitHidden;
 */
%>
		<tr align="right">
		  <td width="34%" class="formtr1">
		  <td class="formtr1">
			<A href="HtmlServlet?reportName=TravelDestinationReport&strFrom=<%//=strFrom%>&strTo=<%//=strTo%>&strTravelType=<%//=strTravelType%>&strTableName=<%=strTableName%>&strTableNamenew=<%//=strTableNamenew%>&strsiteid=<%//=strsiteid%>" target="_self"><%=dbLabelBean.getLabel("label.report.viewreport",strsesLanguage) %>
			</A>
		  </td>
		</tr>
		<tr>
		</tr>

  </table>
<%	
}
		// Code ends for vieweing the report graphically.>
		%> 

<%
%>
		


		