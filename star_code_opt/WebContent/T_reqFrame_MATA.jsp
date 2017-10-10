<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:5 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the jsp file  for show the the two jsp file in two frames first is T_TravelRequisitionDetails.jsp and  second is T_ApproveReturnRequisitions.jsp
 *Modification 			:  added by shiv shrma on 06-Mar-08  for group travel requsition 
                               : added  a code  for Group travel in case of domestice travel------on 02-Jul-08 by shiv sharma     
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<html>
<head>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%@ include  file="systemStyle.jsp" %>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
</head>
<%
//anctionId=34&sSanctionId=34&expenditureType=2
String strTravellerId               =  "";
String strTravelType		        =  ""; 
String purchaseRequisitionId		=  ""; // Object to store Sanction ID
purchaseRequisitionId	            =	request.getParameter("purchaseRequisitionId");
strTravellerId                      =   request.getParameter("traveller_Id");
strTravelType						=	request.getParameter("travel_type");
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}
%>
<script language="Javascript">
<!--

window.moveTo(0,0)
window.resizeTo(screen.width,screen.height)

//-->
</script>
<frameset framespacing="0" border="false" rows="440,*" frameborder="0">
<%
//Start added by shiv shrma on 06-Mar-08  for group travel requsition 
	   ResultSet rs = null;
	   String strSql = "";	
       String strGroupTravelFlag  = "";
	   String strDetailPageUrl     = "";
	   String strTravelAgencyTypeId = "";
          
	  // strSql = "select Group_Travel_Flag from t_travel_detail_int where status_id=10 and travel_id= "+purchaseRequisitionId+"";	   

if(strTravelType.equals("I"))
{
	strSql = "select Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id from t_travel_detail_int td where status_id=10 and travel_id= "+purchaseRequisitionId+"";	 
	   rs = dbConBean.executeQuery(strSql);
	   if(rs.next()) 
	   {  
			strGroupTravelFlag = rs.getString(1);	
			strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
	   } 
	   rs.close();		
	   if(strGroupTravelFlag != null && (strGroupTravelFlag.trim().equals("Y")))// if(strGroupTravelFlag.equalsIgnoreCase("Y")) 
		{
			strDetailPageUrl = "Group_MATA_Report_INT.jsp";
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
			}
		}
		else
		{
			strDetailPageUrl = "MATA_Report_INT.jsp";
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
			}
		}
}
else{  //added  a code  for Group travel in case of domestice travel------on 02-Jul-08 by shiv sharma   
	   strSql = "select Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id from t_travel_detail_DOM td where status_id=10 and travel_id= "+purchaseRequisitionId+"";	 
	   rs = dbConBean.executeQuery(strSql);
	   if(rs.next()) 
	   {  
			strGroupTravelFlag = rs.getString(1);
			strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
	   } 
	   rs.close();		
	   if(strGroupTravelFlag != null && (strGroupTravelFlag.trim().equals("Y")))// if(strGroupTravelFlag.equalsIgnoreCase("Y")) 
		{
			strDetailPageUrl = "Group_MATA_Report_DOM.jsp";
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
			}
		}
		else
		{
			strDetailPageUrl = "MATA_Report_DOM.jsp";
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
			}
		}
}


//End 

%>

<%
if(strTravelType.equals("I"))
{
	//T_TravelRequisitionDetails.jsp
%>
  <frame name="main_1" src="<%=strDetailPageUrl%>?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travelType=I" scrolling="auto" marginwidth="0" marginheight="0" noresize>
  <frame name="footer_1" scrolling="auto" noresize target="main_1" src="T_ConfirmRequisitions_MATA.jsp?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travel_type=<%=strTravelType%>"
  marginwidth="0" marginheight="0">
<%
}
if(strTravelType.equals("D"))
{
%>
  <frame name="main_1" src="<%=strDetailPageUrl%>?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travelType=D" scrolling="auto" marginwidth="0" marginheight="0" noresize>
  <frame name="footer_1" scrolling="auto" noresize target="main_1" src="T_ConfirmRequisitions_MATA.jsp?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travel_type=<%=strTravelType%>"
  marginwidth="0" marginheight="0">
<%
}
%>

  <noframes>
  <body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>
</frameset>
</html>
