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
*Rivision History : by Sachin on 15 th Feb 2008: Display the changes regading display the Group Travel Report
                            : added  a code  for Group travel in case of domestice travel------on 02-Jul-08 by shiv sharma      
 *Editor				:Editplus
 
 *Modified By			: Manoj Chand
 *Date of Modification	: 04-May-2012
 *Modification			: change to show pass option to reviewer
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
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
</head>
<%
//anctionId=34&sSanctionId=34&expenditureType=2
String strTravellerId               =  "";
String strTravelType		        =  ""; 
String purchaseRequisitionId		=  ""; // Object to store Sanction ID
purchaseRequisitionId	            =	request.getParameter("purchaseRequisitionId");
strTravellerId                      =   request.getParameter("traveller_Id");
strTravelType						=	request.getParameter("travel_type");

String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
//this one parameter added by manoj chand on 04 may 2012 to get flag to view reviewer page
String strspFlag = request.getParameter("spFlag")==null?"n":request.getParameter("spFlag");
//System.out.println("strspFlag -->"+strspFlag);
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";
strUserAccessCheckFlag = securityUtilityBean.validateAuthTravelApprovalAction(purchaseRequisitionId, strTravelType, Suser_id);
if(!strUserAccessCheckFlag.equals("420")){
	strUserAccessCheckFlag = securityUtilityBean.validateAuthCancelTravelReq(purchaseRequisitionId, strTravelType, strTravellerId);	
}

if(strUserAccessCheckFlag.equals("420")){
	dbConBean.close();  
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_reqFrame.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");
	return;
} else {

//Added by sachin on 7 th March 2007
String strFlag = request.getParameter("AllTravelPageFlag")==null ?"no" : request.getParameter("AllTravelPageFlag");


//Start added by sachin 14 Feb
	   ResultSet rs = null;
	   String strSql = "";	
       String strGroupTravelFlag  = "";
       String strTravelAgencyTypeId  = "";
	   String strDetailPageUrl     = "";
    
	 if(strTravelType.equals("I")){

	   strSql = "select Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id from t_travel_detail_int t where status_id=10 and travel_id= "+purchaseRequisitionId+"";	       
	   rs = dbConBean.executeQuery(strSql);
	   if(rs.next()) 
	   {  
			strGroupTravelFlag = rs.getString(1);	
			strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
	   } 
	   rs.close();		
	   if(strGroupTravelFlag != null && (strGroupTravelFlag.trim().equals("Y")))// if(strGroupTravelFlag.equalsIgnoreCase("Y")) 
		{
			strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
			}
		}
		else
		{
			strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
			}
		}
	 }else{  //added  a code  for Group travel in case of domestice travel------on 02-Jul-08 by shiv sharma   
		    strSql = "select Group_Travel_Flag, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id from t_travel_detail_DOM t where status_id=10 and travel_id= "+purchaseRequisitionId+"";	       
	   rs = dbConBean.executeQuery(strSql);
	   if(rs.next()) 
	   {  
			strGroupTravelFlag = rs.getString(1);	
			strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
	   } 
	   rs.close();		
	   if(strGroupTravelFlag != null && (strGroupTravelFlag.trim().equals("Y")))// if(strGroupTravelFlag.equalsIgnoreCase("Y")) 
		{
			strDetailPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
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

//End added by sachin 14 Feb

%>
<script language="Javascript">
	window.moveTo(0,0);
	window.resizeTo(screen.width,screen.height-50);
</script>

<frameset framespacing="0" border="false" rows="440,*" frameborder="no">
<%
if(strTravelType.equals("I"))
{
	//System.out.println("strDetailPageUrl----i-->"+strDetailPageUrl);
%>
  <frame name="main_1" src="<%=strDetailPageUrl%>?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travelType=<%=strTravelType %>" scrolling="auto" marginwidth="0" marginheight="0" noresize>
  <frame name="footer_1" scrolling="no" noresize target="main_1" src="T_ApproveReturnRequisitions.jsp?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travel_type=<%=strTravelType%>&AllTravelPageFlag=<%=strFlag%>&spflag=<%=strspFlag.trim() %>"
  marginwidth="0" marginheight="0">
<%
}
if(strTravelType.equals("D"))
{
	//System.out.println("strDetailPageUrl----d-->"+strDetailPageUrl);
%>
  <frame name="main_1" src="<%=strDetailPageUrl%>?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travelType=<%=strTravelType %>" scrolling="auto" marginwidth="0" marginheight="0" noresize>
  <frame name="footer_1" scrolling="no" noresize target="main_1" src="T_ApproveReturnRequisitions.jsp?purchaseRequisitionId=<%=purchaseRequisitionId%>&traveller_Id=<%=strTravellerId%>&travel_type=<%=strTravelType%>&AllTravelPageFlag=<%=strFlag%>&spflag=<%=strspFlag.trim()%>"
  marginwidth="0" marginheight="0">
<%
}
}%>

  <noframes>
  <body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>
</frameset>
</html>
