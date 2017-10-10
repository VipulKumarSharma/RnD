<%
/*******************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author									:SACHIN GUPTA
 *Date of Creation 				:5 September 2006
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  								:STAR
 *Operating environment	:Tomcat, sql server 2000 
 *Description 						:This is the jsp file  for Report the Travel Requisition Details
 *Modification                      : 1.Code added by shiv for showing unit name in reports  on 16-May-07 
 *Date of Modification      :  Nov 2006, 26-Apr-07 by shiv
                                         :16-May-07 
 *Modified By	            : SACHIN GUPTA
                             	    :shiv sharma 
									
 *Editor					:Editplus
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

strFrom = request.getParameter("from");
strTo = request.getParameter("to");
strTravelType = request.getParameter("travelType");
strRadioSelected = request.getParameter("selectRadioType");
strUnitHidden = request.getParameter("UnitHidden");

//added by shiv on 3/8/2007 
strSelectUnit = request.getParameter("SelectUnit");
strUnitHidden=strSelectUnit;

//code added by shiv on 16-May-07 for showing unit name in reports  open

              if(strUnitHidden.equals("0")) 
				{
				 strSitename="For All Units";
				 }
	else
		        {
	                   strSql="select isnull(dbo.sitename("+strUnitHidden+"),'') as sitename from M_site where status_id=10" ;  
	           
				 	rs = dbConBean.executeQuery(strSql);
		                while (rs.next()) 
		                     {
						     strSitename=rs .getString("sitename");  
					         }
						rs.close();
                        strSitename= " in " + strSitename;   
				 
		       } 
//code added by shiv on 16-May-07 for showing unit name in reports  close


if(strTravelType.equals("I"))
{
	 strtraveltype="International";
	 if(ssflage.equals("3")){
		 strtraveltype = "Intercont";
	 }
 }
 if(strTravelType.equals("D"))
{
	 strtraveltype="Domestic";
	 if(ssflage.equals("3")){
		 strtraveltype = "Domestic/Europe";
	 }
 }





%>

<body>
<script type="text/javascript" language="JavaScript1.2"
	src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
	<td width="77%" height="35" class="bodyline-top">
 	  <ul class="pagebullet"><li class="pageHead"><b><%=dbLabelBean.getLabel("label.report.destinationwisereportfor",strsesLanguage) %> <%=strtraveltype %>  <%=dbLabelBean.getLabel("label.report.travelrequisitions",strsesLanguage) %> <%=strSitename %>  ( <%=dbLabelBean.getLabel("label.report.between",strsesLanguage) %>  <%=strFrom %>  - <%=strTo %>) </b></li></ul>
	</td>
  </tr>
</table>

<%

 

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

// Code if the user selects to display the report manually

if(strRadioSelected.equals("Manual"))
{
%>
  <table width="50%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
    <tr align="left" class="formhead">
	  <td width="3%" class="rep-head"><b><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></b></td>
	  <td width="13%" class="rep-head"><b><%=dbLabelBean.getLabel("label.report.destinations",strsesLanguage) %></b></td>
	  <td width="9%" class="rep-head"><b><%=dbLabelBean.getLabel("label.report.totaltravelrequisitionscreated",strsesLanguage) %></b></td>
	</tr>
<%// Variables declared and initialized
	
	
	//ResultSet rs = null; // Object for result set
	String sqlStr = "";
	int iCls = 0;
	int countflag = 0;
	int sn=1;
	String strStyleCls = "";
	try 
	{		
		//Query for Finding the role of approver
		//change in TS.TRAVEL_STATUS_ID !=  1 to =10 to show approved by all request in destination wise report by manoj chand on 28 feb 2013
		if(strTravelType.equals("I"))
		{
		  sqlStr = " SET DATEFORMAT DMY SELECT UPPER(TD.TRAVEL_TO) AS TRAVEL_TO, COUNT(*) AS REQUISTION_COUNT FROM T_JOURNEY_DETAILS_INT TD INNER JOIN T_TRAVEL_STATUS TS ON TD.TRAVEL_ID = TS.TRAVEL_ID  INNER JOIN T_TRAVEL_DETAIL_INT ON TD.TRAVEL_ID=T_TRAVEL_DETAIL_INT.TRAVEL_ID  INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON T_TRAVEL_DETAIL_INT.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '" +strFrom+"' AND '"+ strTo +  " ' AND TS.TRAVEL_TYPE ='"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10 "+ strAppendQuery+" GROUP BY TRAVEL_TO";

		  // System.out.println(" query--------- i  "+sqlStr);
		}
		else if (strTravelType.equals("D"))
		{
		  sqlStr = " SET DATEFORMAT DMY SELECT UPPER(TD.TRAVEL_TO) AS TRAVEL_TO, COUNT(*) AS REQUISTION_COUNT FROM T_JOURNEY_DETAILS_DOM TD INNER JOIN T_TRAVEL_STATUS TS ON TD.TRAVEL_ID = TS.TRAVEL_ID INNER JOIN T_TRAVEL_DETAIL_DOM ON TD.TRAVEL_ID=T_TRAVEL_DETAIL_DOM.TRAVEL_ID  INNER JOIN (SELECT MAX(ROLE_ID) AS ROLE_ID,USERID,SITE_ID,TES_CUTTOFF_DATE FROM  VW_AUTH_REPORT_SITE_ACCESS(NOLOCK) WHERE USERID="+Suser_id+" GROUP BY USERID,SITE_ID,TES_CUTTOFF_DATE) AUS ON T_TRAVEL_DETAIL_DOM.SITE_ID =AUS.SITE_ID AND AUS.USERID="+Suser_id+" WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '" +strFrom+"' AND '"+ strTo +  " ' AND TS.TRAVEL_TYPE ='"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10 " + strAppendQuery+ "GROUP BY TRAVEL_TO";
		  //System.out.println(" ---------------------query---------d  "+sqlStr);
		}
		//System.out.println("12345678 --> "+sqlStr);
		rs = dbConBean.executeQuery(sqlStr);
		while (rs.next()) 
		{
		  countflag=1;
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
	       <td class="rep-txt"><%=sn++%></td>
		  <td class="rep-txt"><%=strDestination%></td>
		  <td class="rep-txt"><%=strTotalReq%></td>
		</tr>
<%
		}//end of while
		rs.close();
		if(countflag == 0){%>
		<tr class="formtr2">
		<td colspan="3" style="text-align: center;font-weight: bold;color:red;"><%=dbLabelBean.getLabel("label.global.norecordfound",strsesLanguage) %>
		</td>
		</tr>
		<%} 
		dbConBean.close();
	} 
	catch (Exception e) 
	{
		System.out.println("Error in T_DestinationReportPost.jsp------->" + e);
	}
}

// code ends for vieweing the report manually

//Code starts for vieweing the report graphically
else
{
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
  } 
%>

  <table width="50%" align="center" border="0" cellpadding="5"	cellspacing="1" class="formborder">
<%
  String sqlStr = "";
  int iCls = 0;
  String strStyleCls = "";
  String  strsiteid="";

  strsiteid=strUnitHidden;
 
%>
    <tr align="right">
	  <td width="34%" class="formtr1">
	  <td class="formtr1">
	    <A href="HtmlServlet?reportName=TravelDestinationReport&strFrom=<%=strFrom%>&strTo=<%=strTo%>&strTravelType=<%=strTravelType%>&strTableName=<%=strTableName%>&strTableNamenew=<%=strTableNamenew%>&strsiteid=<%=strsiteid%>" target="_self"><%=dbLabelBean.getLabel("label.report.viewreport",strsesLanguage) %>
	    </A>
	  </td>
	</tr>
  </table>
<%	
}
		// Code ends for vieweing the report graphically.
%>

		