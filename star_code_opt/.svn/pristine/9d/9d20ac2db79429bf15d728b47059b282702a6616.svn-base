<%/***************************************************
			 *The information contained here in is confidential and 
			 * proprietary to MIND and forms the part of the MIND 
			 *Author				:Abhinav Ratnawat
			 *Date of Creation 		:09 September 2006
			 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
			 *Project	  			:STAR
			 *Operating environment :Tomcat, sql server 2000 
			 *Description 			:This is first jsp file  for updating the SITE in the STAR Database
			 *Modification 			:// code added for Domestice Group travel byshv sharma on 02-Jul-08  
			 *Reason of Modification: 
			 *Date of Modification  : 
			 *Revision History		:
			 *Editor				:Editplus
			 *Modified By			:Manoj Chand
			 *Modification			:Increase popup window width
			 *Date of Modification  :04 jan 2013
			 
			 *Modified by			:Manoj Chand
			 *Date of Modification	:01 Feb 2013
			 *Modification			:showing requested value in comma separated way if multiple currency exist in the request.
*******************************************************/
%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
</head>
<body>

<% 
int iLoop=1;
// Variables declared and initialized
ResultSet rs			=		null;			   // Object for result set

//Create Connection
String strId		=	"";
String strFrom		=	"";
String strTo		=	"";
String strSiteId	=	"";
String strTravelType=   "";
String strReqNo		=	"";
String strTravellerName	=	"";
String strTravelId		=	"";
String strHeader	=	"";
String strForex		=	"";
String strCurrency	= "";
String strTravellerId	 =	 "";
String strDetailPageUrl ="";
String strGroupTravelFlag="";
String strTravelAgencyTypeId="";

strId				=	request.getParameter("id");
strFrom				=	request.getParameter("from");
strTo				=	request.getParameter("to");
strSiteId			=	request.getParameter("siteId");
strTravelType		=   request.getParameter("travelType");

String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");

String sqlStr		=	"";
int iCls = 0;
String strStyleCls = "";
	try
	{

		//System.out.println("strid is"+strId+"5"+strTravelType);
		if(strId.equals("1"))
		{
			//CASE Total
			if (strTravelType != null && strTravelType.equals("I")) {
				//System.out.println("inside condition 1");
				//sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),TOTAL_AMOUNT,TA_CURRENCY,TD.TRAVEL_ID,TD.TRAVELLER_ID, td.GROUP_TRAVEL_FLAG FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS,T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID != 1";
				//query changed by manoj chand on 01 feb 2013 to get forex breakup
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'I') AS Expenditure,TD.TRAVEL_ID,TD.TRAVELLER_ID, td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS,T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID != 1";
				//System.out.println("sqlstr"+sqlStr);
			} else { 
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'D') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM  T_TRAVEL_DETAIL_DOM TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID  !=1";
			}
			strHeader=dbLabelBean.getLabel("label.report.totalrequisitions",strsesLanguage);

		}
		else if(strId.equals("2"))
		{
			if (strTravelType != null && strTravelType.equals("I")) {
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'I') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10";
			} else { 
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'D') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM  T_TRAVEL_DETAIL_DOM TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 10";
			}
			strHeader=dbLabelBean.getLabel("label.report.totalrequisitionsapproved",strsesLanguage);
		}
		else if(strId.equals("3"))
		{
			if (strTravelType != null && strTravelType.equals("I")) {
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'I') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS,  T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 4";
			} else { 
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'D') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM  T_TRAVEL_DETAIL_DOM TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND  TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID  AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 4";
			}

			strHeader=dbLabelBean.getLabel("label.report.totalrequisitionsrejected",strsesLanguage);
		}
		else if(strId.equals("4"))
		{
			if (strTravelType != null && strTravelType.equals("I")) {
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'I') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND  TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 3";

			} else { 
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'D') AS Expenditure,TD.TRAVEL_ID ,TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM  T_TRAVEL_DETAIL_DOM TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 3";
			}

			strHeader=dbLabelBean.getLabel("label.report.totalrequisitionsreturned",strsesLanguage);
		}
		else if(strId.equals("5"))
		{
			if (strTravelType != null && strTravelType.equals("I")) {
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'I') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND  TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 6";

			} else { 
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'D') AS Expenditure,TD.TRAVEL_ID ,TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM  T_TRAVEL_DETAIL_DOM TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 6";
			}

			strHeader=dbLabelBean.getLabel("label.report.totalrequisitionscancelled",strsesLanguage);
		}
		else if(strId.equals("6"))
		{
			if (strTravelType != null && strTravelType.equals("I")) {
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'I') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 2 AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO )";
			} else { 
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'D') AS Expenditure,TD.TRAVEL_ID,TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM  T_TRAVEL_DETAIL_DOM TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM  WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 2 AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO )";
			}
			strHeader=dbLabelBean.getLabel("label.report.totalrequisitionspending",strsesLanguage);
		}
		else if(strId.equals("7"))
		{
			if (strTravelType != null && strTravelType.equals("I")) {
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'I') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM  T_TRAVEL_DETAIL_INT TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND  TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 2 AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO WHERE ROLE_ID = 'CHAIRMAN')";	
				
			} else { 
				sqlStr="SET DATEFORMAT DMY SELECT TRAVEL_REQ_NO,.DBO.USER_NAME(TRAVELLER_ID),dbo.FN_GET_EXPENDITURE(TD.TRAVEL_ID,'D') AS Expenditure,TD.TRAVEL_ID, TD.TRAVELLER_ID,td.GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id  FROM  T_TRAVEL_DETAIL_DOM TD ,T_TRAVEL_STATUS TS, T_TRAVEL_MST TM WHERE CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' AND TM.SITE_ID = '"+strSiteId+"' AND TD.APPLICATION_ID =1 AND TD.STATUS_ID = 10 AND TM.TRAVEL_REQ_ID = TD.TRAVEL_REQ_ID AND TD.TRAVEL_ID = TS.TRAVEL_ID AND TS.TRAVEL_TYPE = '"+strTravelType+"' AND TS.TRAVEL_STATUS_ID = 2 AND DBO.PRESENTAPPROVERID(TS.TRAVEL_ID,TS.TRAVEL_TYPE,TD.TRAVELLER_ID) IN (SELECT USERID FROM M_USERINFO WHERE ROLE_ID = 'CHAIRMAN')";
			}
			strHeader=dbLabelBean.getLabel("alert.report.totalrequisitionspendingwithchairman",strsesLanguage) ;
		}
		//out.println(sqlStr);
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.report.reportonsummarytravelrequisitions",strsesLanguage) %></b> >><b> <%=strHeader%> </b></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table  align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
       <td>
     <ul id="list-nav">
     
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left" class="formhead">
<td width="5%"><b>#</b></td>
<td width="30%"><b><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage) %></b></td>
<td width="40%"><b><%=dbLabelBean.getLabel("label.global.travelername",strsesLanguage) %></b></td>
<td width="25%"><b><%=dbLabelBean.getLabel("label.global.totalforex",strsesLanguage) %></b></td>
</tr>



<%
	rs=dbConBean.executeQuery(sqlStr);
	while(rs.next())
	{
		strReqNo=rs.getString(1);
		strTravellerName=rs.getString(2);
		strForex=rs.getString(3);
		//strCurrency	= rs.getString(4);
		strTravelId	=	rs.getString(4);
		strTravellerId	 =	 rs.getString(5);
		if (iCls%2 == 0) 
		{ 
			strStyleCls="formtr2";
	    } else { 
			strStyleCls="formtr1";
	    } 
		///code added for showing grop travel incase of gropu travel inspite of traveller name 06-Mar-08  by Shiv Sharma 
	if (strTravelType != null && strTravelType.equals("I")) 
			{
			 strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
			 strTravelAgencyTypeId			=	rs.getString("travel_agency_id");

			     if(strGroupTravelFlag==null) 
						{
					     strGroupTravelFlag="N";
					     }
                   	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
						{
				
						strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
						strTravellerName ="Group/Guest Travel";
						if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		                	  strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
		                		strTravellerName ="Guest Travel";
							}
					
			           }
	                else
		                      {
		                  
			                  strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
			                  if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			                	  strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
								}
	                           }  


		}else // code added for Domestice Group travel byshv sharma on 02-Jul-08 
		{
			 strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
			 strTravelAgencyTypeId			=	rs.getString("travel_agency_id");

			     if(strGroupTravelFlag==null) 
						{
					     strGroupTravelFlag="N";
					     }
                   	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
						{
				
						strDetailPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
						strTravellerName ="Group/Guest Travel";
						if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		                	  strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
		                		strTravellerName ="Guest Travel";
							}
			           }
	                else
		                      {
		                  
			                  strDetailPageUrl = "T_TravelRequisitionDetails_D.jsp";
			                  if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			                	  strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
								}
	                           }  


		}

		iCls++;
%>
	        <tr align="left" class="<%=strStyleCls%>">
			<td class="rep-txt"><%=iLoop%></td>
			<td class="rep-txt">
<% 
		if (strTravelType != null && strTravelType.equals("I")) 
		{
%>
			<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId %>&traveller_Id=<%=strTravellerId %>&travelType=<%=strTravelType %>','SEARCHDETAILS','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strReqNo%></a>
<% 
		} 
		else if (strTravelType != null && strTravelType.equals("D")) 
		{ 
%>
			<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId %>&traveller_Id=<%=strTravellerId %>&travelType=<%=strTravelType %>','SEARCHDETAILS','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strReqNo%></a>
<%		
		}
%>
			</td>
			<td class="rep-txt"><%=strTravellerName%></td>			
			<td class="rep-txt"><%=strForex%></td>			
		</tr>
<%
		
		iLoop++;
	}
	rs.close();
	dbConBean.close();
}
catch(Exception e)
{
	System.out.println("Error in RequisitionSummaryReportDetails.jsp-------"+e);
}

%>

</table>


