<!-- Header -->
<% 
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Deepali Dhar
*Date			:   15/09/2006
*Description	:	International Travle Requisition List
*Project		: 	STARS
*Modification 			: Add Cancel link .
					   2.Check the  default approver list on new button.
					   3.by Sachin on 15 th Feb 2008: Display the changes regading display the Group Travel Report
					   4.comment  history link in listing on 03-Sep-09 by shiv  sharma 
					   5.//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
*Reason of Modification: change suggested by MATA
*Date of Modification  :07 Nov 2006 ,02/04/2007
*Modified By	       :SACHIN GUPTA,Vijay Singh
					   :By vaibhav on sep 17 2010 stmt1 closed after using. 

*Modified By			:Manoj Chand
*Date of Modification	:10 feb 2011
*Modification			:increases the size of search page.

*Modified By			:Manoj Chand
*Date of Modification	:01 july 2011
*Modification			:Implement delete link for cancelled requests

*Modified By			:Manoj Chand
*Date of Modification	:07 Sept 2011
*Modification			:function childwindowSubmit() added to refresh this page on close button click from attachment page

*Modified By			:Manoj Chand
*Date of Modification	:01 Dec 2011
*Modification			:replace cancelled by: to cancelled by: Admin when request is cancelled by admin

*Modified By			:Manoj Chand
*Date of Modification	:30 Mar 2012
*Modification			:Replacing the position of New and Group/Guest Request Create tab.

*Modified By			:Manoj Chand
*Date of Modification	:29 May 2012
*Modification			:Multilingual implemented in International request list page

*Modified by			:Manoj Chand
*Date of Modification	:01 Feb 2013
*Modification			:showing requested value in comma separated way if multiple currency exist in the request.

*Modified By	        :MANOJ CHAND
*Date of Modification   :12 Feb 2013
*Description			:IE Compatibility Issue resolved.
**********************************************************/
%>

<HTML>
<HEAD>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>

<script language=JavaScript >
function deleteConfirm()
{

if(confirm('<%=dbLabelBean.getLabel("message.createrequest.areyousuretodeletetravelrequisition",strsesLanguage) %>'))
	return true;
else
	return false;
}

//added by manoj on 06 sept refresh page on close button from attachment page.
function childwindowSubmit(){
	document.frm.action='T_TravelRequisitionList.jsp';
	document.frm.submit();
}
function openWaitingProcess() {
		$("body").css("overflow", "hidden");
		var height 	= $(document).height();
		var width 	= $(document).width();
		
	    var bcgDiv 	= document.getElementById("divBackground");
	    var dv = document.getElementById("waitingData");
	    
	    bcgDiv.style.height=height;
	    bcgDiv.style.width=width;
	    bcgDiv.style.display="block";
		
		if(dv != null)
		{
			var xpos = screen.width * 0.47;
			var ypos = screen.height * 0.22;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
}
</script>
<%
String strReqType 	  =  request.getParameter("requestType")==null ?"" :request.getParameter("requestType");
String strTravelType   =  request.getParameter("travel_type"); 
String searchTravelType = strTravelType;

// Variables declared and initialized
Connection con,con1	=	null;			    // Object for connection
Statement stmt,stmt1	=	null;			   // Object for Statement
ResultSet rs,rs1	=	null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
con1=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
int iCls = 0;
String strStyleCls = "";
int intSerialNo=0;
String		sSqlStr				=	""; // For sql Statements
String		strName		=	"";
String		strAddress			=	"";
String	 	strRequisitionId	=	"";                //TRAVEL_ID
String      strTravelReqId      =   "";                //TRAVEL_REQ_ID  
String		strJustification	=	"";
String		strOriginatedBy		=	"";
String		strOriginatedOn		=	"";
String  	strPurchaseValue	=	"";
String		strStatusType		=	"";
String 		strFinalApprovalStatus	=	"";
String 		strOrigReqValue		=	"";
String 		strOrigReqCurrency	=	"";
String		strNewReqNo			=	"";
String		strTitle			=	"";
String		strAmount		    =	"";
String		strCurrency     	=	"";
String		strTravel_From	    =	"";
String		strTravel_To		=	"";
String		strTravellerID	    =   "";
String		strSiteId			=strSiteIdSS;// add by Vijay 02/04/2007
String		strappId="";
String 		strTravelAgencyTypeId = "";

String urlpage="";
String strDetailPageUrl = "";  //for display detail page for eg. Group or simple user detail page
//System.out.println("siteid>>>>>>>>>>>"+strSiteId);
String strPurchaseComments="";
String strImagePrint="";
String strAttachment="";
//NEW 19-02-2007 SACHIN
String strModCommentImage="";

String    strGroupTravelFlag="";
//NEW 19-02-2007 SACHIN

String 		strInterimID	=	"";
%>

</HEAD>
<body onfocus="MM_winParentDisable();" onclick="MM_winParentDisable();"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<div id="divBackground" style="position: absolute; z-index: 99; height: 100%; width: 100%; top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
		<div id="waitingData" style="display: none;">
		<center>
			<img src="images/loader-circle.gif?buildstamp=2_0_0" width="50" height="50"/> 
			<br><br>
			<font color="#ffffff" style="font-size:14px;font-weight:bold;font-family:Verdana, Arial, Helvetica, sans-serif;">   
			<span id="pleaseWait">Please Wait...</span>
			</font>  
		</center>
		</div>
	</div>
	<script type="text/javascript">
		openWaitingProcess();
	</script>
<form name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
	<%if(ssflage.equals("3")){ %>
		<li class="pageHead"><%=dbLabelBean.getLabel("label.global.interconttravelrequisition",strsesLanguage) %></li>
	<%}else{ %>
       <li class="pageHead"><%=dbLabelBean.getLabel("label.createrequest.internationaltravelrequisition",strsesLanguage) %></li>
      <%} %>
    </ul></td>
     <td  align="right" valign="bottom" class="bodyline-top">
	<table border="0"  align="right" cellpadding="0" cellspacing="0">
      <tr align="right">
      <td>
       <ul id="list-nav">
<%
if(SuserRole != null && (SuserRole.trim().equals("HR") || SuserRole.trim().equals("AC")) )
{
%>
       
      <li><a href="#" onClick="MM_openBrWindow('All_Requisitions.jsp?flag=1&travel_type=I','REQUISITIONSAPPROVED','scrollbars=yes,resizable=yes,width=950,height=550');">&nbsp;&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.requestdetails.allrequisitions",strsesLanguage) %>&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
    
       
	  
<%
}
%>
<%
	String travelAgencyId="";
	String isDefaultWorkExists="true";
	sSqlStr ="SELECT TRAVEL_AGENCY_ID FROM M_SITE WHERE SITE_ID="+strSiteId+" AND STATUS_ID=10";
	stmt=con.createStatement();
	rs=stmt.executeQuery(sSqlStr);
	if(rs.next()) {
		travelAgencyId=rs.getString("TRAVEL_AGENCY_ID");
	}
	stmt.close();
	
	if(travelAgencyId != null && !"".equals(travelAgencyId) && "2".equals(travelAgencyId)) {
		sSqlStr ="SELECT 1 FROM M_WORKFLOW_MATRIX WM WHERE WM.SITE_ID="+strSiteId+" AND TRAVEL_TYPE='I' AND WM.DEFAULT_WORKFLOW=1 AND WM.STATUS_ID=10";
		stmt=con.createStatement();
		rs=stmt.executeQuery(sSqlStr);
		if(!rs.next()) {
			isDefaultWorkExists="false";
		}
		stmt.close();
	}
//Vijay 02/04/2007 Check the  default approver list on new button
//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
	sSqlStr="SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND  sp_role="+SSstrSplRole+" and		STATUS_ID=10 AND APPLICATION_ID=1"; 


	stmt=con.createStatement();
	rs=stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strappId=rs.getString(1);
	}
	rs.close();
	stmt.close();
	//rs.close();
%>		<script language="javascript">
			function approverCheck()
			{}
		</script>
<%
	if((strappId.equals("")||strappId.equals(null))  && "true".equals(isDefaultWorkExists))
	{
%>
		<script language="javascript">
			function approverCheck()
			{
				alert('<%=dbLabelBean.getLabel("alert.global.cannotproceed",strsesLanguage) %>');
				return false;
			}
			
		</script>
<%} %>
     <!--change image name on 2/13/2009 by shiv sharma  -->
     <!-- Replacing position of both new and group/guest request image by manoj chand on 30 mar 2012 -->
<%
	String createRequestUrl 		= "T_QuickTravel_Detail_MATA.jsp";
    String createGroupRequestUrl 	= "T_Group_QuickTravel_Detail_MATA.jsp";
	String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
	if(isMATA_GmbH != null && isMATA_GmbH.equals("true")){
		createRequestUrl = "T_QuickTravel_Detail_GmbH.jsp";
		createGroupRequestUrl 	= "T_Group_QuickTravel_Detail_GmbH.jsp";
	}
%>

<%-- <li><a href="T_IntTrv_Details.jsp?flag=1" onClick="approverCheck();"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></a></li> --%>
<li><a href="<%=createRequestUrl %>?travel_type=I" onClick="approverCheck();"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></a></li>
<%if(ssflage.equals("3")){ %>
		<li><a href="<%=createGroupRequestUrl %>?flag=1&travel_type=I" onClick="approverCheck();"><%=dbLabelBean.getLabel("label.approverequest.guesttravel",strsesLanguage) %></a></li>
	<%}else{ %>
       <li><a href="<%=createGroupRequestUrl %>?flag=1&travel_type=I" onClick="approverCheck();"><%=dbLabelBean.getLabel("label.approverequest.groupguesttravel",strsesLanguage) %></a></li>
      <%} %>

<li><a href="#" onClick="MM_openBrWindow('T_searchTravelRequisitions.jsp?travel_type=I&searchTravelType=<%=searchTravelType%>','SEARCH','scrollbars=yes,resizable=yes,top=110,left=0,width=1017,height=565')"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage) %></a></li>
<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
</ul>
</td>



      
      </tr>
    </table>
	</td>
  </tr>
</table>


<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" class="formborder">
<tr class="formhead"> 
    <td align="center" width="5%"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
    <td align="center" width="12%"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
	<td align="center" width="12%"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
    <td align="center" width="10%"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage) %></td>
	<td align="center" width="10%"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage) %></td>
	<td align="center" width="15%"><%=dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage) %></td>
	<td align="center" width="10%"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage) %></td>
	<td align="center" width="10%"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
	<td align="center" width="16%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></td>
  </tr>
<%
/*if(SuserRole != null && (SuserRole.trim().equals("HR") || SuserRole.trim().equals("AC")) )
{*/
%>
	<!--<tr> 
       <td colspan="10" class="formhead" >Request (s) Originated By Users</td>
     </tr>-->
 
<%

/*	  sSqlStr = "SELECT DISTINCT TA.TRAVEL_ID, TD.TRAVEL_REQ_NO,ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER ,ISNULL(CONVERT(decimal(20,0),TD.TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT,ISNULL(TD.TA_CURRENCY,'-') AS TA_CURRENCY,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA')AS CREATED_BY, ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE, ISNULL(DBO.TRAVEL_FROM(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_FROM, ISNULL(DBO.TRAVEL_TO(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_TO, DBO.TRAVEL_COMMENT(TD.travel_id,'I') AS COMMENT, DBO.REQUISITIONATTACHMENT(TD.travel_id,'I') AS ATTACHMENT, RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(TD.TRAVELLER_ID,'I',TD.TRAVELLER_ID)) AS FINAL_STATUS, TA.TRAVELLER_ID, ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND (TS.TRAVEL_STATUS_ID=2 OR TS.TRAVEL_STATUS_ID=10 ) AND TS.TRAVEL_TYPE='I' AND TA.SITE_ID="+strSiteIdSS+" AND TA.TRAVEL_TYPE='I' AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I' AND STATUS_ID=10) ORDER BY TD.C_DATE DESC";
	  stmt = con.createStatement(); 
      rs = stmt.executeQuery(sSqlStr);
      if(rs.next())
      {
    	do
        {	  
         	strRequisitionId				=	rs.getString("TRAVEL_ID");
         	strNewReqNo						= 	rs.getString("TRAVEL_REQ_NO");
         	strName							=	rs.getString("TRAVELLER");
          	strAmount						=	rs.getString("TOTAL_AMOUNT");
          	strCurrency						=	rs.getString("TA_CURRENCY");
          	strOriginatedBy					=	rs.getString("CREATED_BY");
         	strOriginatedOn					=	rs.getString("C_DATE");	
         	strTravel_From					=	rs.getString("TRAVEL_FROM");
         	strTravel_To					=	rs.getString("TRAVEL_TO");
          	strPurchaseComments		    	=	rs.getString("COMMENT");

	        if(strAmount != null && strAmount.equals("0"))
	        {
        		strAmount = "-";
         	}
         	if(!strPurchaseComments.trim().equals("0"))
        	{
           		strImagePrint="<img src=images/group1.gif border=0>";
         	}
          	else
          	{
          		strImagePrint="";
         	}
         	strAttachment					=	rs.getString("ATTACHMENT");
          	if(strAttachment.equals("0"))
           	{
          		strAttachment="";
          	}
           	else
           	{
          		strAttachment="<img src=images/clip123.gif border=0>";
           	}

        	if (iCls%2 == 0) { 
            	strStyleCls="formtr2";
            } else { 
        		strStyleCls="formtr1";
               } 
		   strFinalApprovalStatus			=	rs.getString("FINAL_STATUS");
		   strTravellerID					=	rs.getString("TRAVELLER_ID");
            iCls++;

			*/
%>
 <!-- <tr valign="top" class="<%=strStyleCls%>"> 
    <td align="center"><%=++intSerialNo%><br><a href="#" title="Comments" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a><a href="#" title="Attachments" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&travel_type=I&err=0&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strAttachment%></a> </td>
    <td class="listdata" align="center"><a href="#" onClick="MM_openBrWindow('T_TravelRequisitionDetails.jsp?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>','SEARCH','scrollbars=yes,resizable=no,width=830,height=625')"><%=strNewReqNo%></a></td>
	<td class="listdata" align="center"><%=strName%></td>
	<td class="listdata" align="center"><%=strTravel_From%></td>
	<td class="listdata" align="center"><%=strTravel_To%></td>
	<td class="listdata" align="center"><%=strAmount%></td>
	<td class="listdata" align="center"><%=strCurrency%></td>
  	<td class="listdata" align="center"><%=strOriginatedBy%></td>
	<td class="listdata" align="center"><%=strOriginatedOn%></td>
	<td class="listhead" align="center">
	   <a  href="T_IntForex_Details_HR.jsp?travelId=<%=strRequisitionId%>&travelReqNo=<%=strNewReqNo%>">Approve</a> |
	   <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&err=0&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="Add Attachments">Attach |<a href="#" onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=strRequisitionId%>&strTravellerId=<%=strTravellerID%>&strTravelRequestNo=<%=strNewReqNo%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')">Work Flow Status</a> | 
		<a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')">Comments 
      </a>
	  <br><a TITLE="History" href="#" onClick="MM_openBrWindow('UnderConstruction.html','History','scrollbars=yes,resizable=no,width=600,height=316')">History</a>

    </TD>-->
<%
/*	}while(rs.next());
}
else
{*/
%>
  <!--<tr> 
    <td colspan="10" class="formtr1">No Records Found</td>
  </tr>-->
<%
/*}
rs.close();
stmt.close();
}*/
%>

  <tr> 
  	<td class="formhead toggle" style="text-align: center;"><img src="images/expand.png?buildstamp=2_0_0" width="15" height="15" border="0" title="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" alt="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" onclick="showHide('tem-rows', this);"/></td>
    <td colspan="8" class="formhead"  id="tem-header"><%=dbLabelBean.getLabel("label.createrequest.temporaryrequest",strsesLanguage) %></td>
  </tr>
  <%
//sql to get the Purchase requisition list
intSerialNo=0;
sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'I') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE, j.travel_from,j.travel_to, DBO.TRAVEL_COMMENT(t.travel_id,'I'), DBO.REQUISITIONATTACHMENT(t.travel_id,'I'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)),t.TRAVELLER_ID,t.travel_req_id,GROUP_TRAVEL_FLAG ,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id   FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID AND t.C_USERID="+Suser_id+" and  s.TRAVEL_STATUS_ID=1 AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";
//System.out.println("sSqlStr===06-Mar-08======Temporary Request ====="+sSqlStr);

stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
	do
	{
	strRequisitionId					=	rs.getString(1);
	strNewReqNo					    	= 	rs.getString(2);
	strName								=	rs.getString(3);
	strAmount							=	rs.getString("Expenditure");
	//strCurrency							=	rs.getString(5);
	strOriginatedBy			    		=	rs.getString("ORIGINATOR");
	strOriginatedOn				    	=	rs.getString("C_DATE");	
	strTravel_From						=	rs.getString("travel_from");
	strTravel_To				    	=	rs.getString("travel_to");
	if(strAmount != null && strAmount.equals("0"))
	{
		strAmount = "-";
		strCurrency="-";
	}

	strPurchaseComments			=	rs.getString(9);
	if(!strPurchaseComments.trim().equals("0"))
	{
		strImagePrint="<img src=images/group1.gif border=0 alt="+dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)+" >";
	}
	else
	{
		strImagePrint="";
	}
	strAttachment					=	rs.getString(10);
	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0 alt="+dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)+" >";
	}

	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 

	strFinalApprovalStatus			=	rs.getString(11);
	strTravellerID					=	rs.getString(12);
	strTravelReqId                  =   rs.getString(13); 

	strGroupTravelFlag                  =   rs.getString("GROUP_TRAVEL_FLAG");
	strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
								
	//System.out.println("strGroupTravelFlag=123===="+strGroupTravelFlag);

//  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 20-Feb-08 ;  

if(strGroupTravelFlag==null) 
		{
	strGroupTravelFlag="N";
 	}
          
	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
		{
		  urlpage ="T_Group_QuickTravel_Detail_MATA.jsp";		 
		  strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
		strName="Group/Guest Travel ";  
		 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			 urlpage="T_Group_QuickTravel_Detail_GmbH.jsp";
			 strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
			 strName="Guest Travel "; 
				}

	}
	else
		{
		
		urlpage ="T_QuickTravel_Detail_MATA.jsp";
		strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			urlpage = "T_QuickTravel_Detail_GmbH.jsp";
			strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
		}
	}

	  iCls++;
%>

<% 
	
	sSqlStr = "SELECT DISTINCT PARENT_ID AS PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strRequisitionId;
	stmt1 = con1.createStatement(); 
	rs1 = stmt1.executeQuery(sSqlStr);
		if (rs1.next()) {
			strInterimID = rs1.getString("PARENT_ID");
		}
	rs1.close();	
	stmt1.close();
%>
  
<tr valign="top" class="<%=strStyleCls%> tem-rows"> 
    <td align="center"><%=++intSerialNo%><br><a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a><a href="#" title="<%=dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&travel_type=I&err=0&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a></td>
    <td class="listdata" align="center"><a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strNewReqNo%></a></td>
	<td class="listdata" align="center"><%=strName%></td>
	<td class="listdata" align="center"><%=strTravel_From%></td>
	<td class="listdata" align="center"><%=strTravel_To%></td>
	<td class="listdata" align="center"><%=strAmount%></td>
  	<td class="listdata" align="center"><%=strOriginatedBy%></td>
	<td class="listdata" align="center"><%=strOriginatedOn%></td>
	<td class="listhead" align="center">

	  <a  href="<%=urlpage%>?travelId=<%=strRequisitionId%>&travelReqId=<%=strTravelReqId %>&travelReqNo=<%=strNewReqNo%>&interimId=<%= strInterimID %>&travel_type=I" title="<%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage) %></a>
	  <%-- <a  href="<%=urlpage%>?travelId=<%=strRequisitionId%>&travelReqNo=<%=strNewReqNo%>&interimId=<%= strInterimID %>" title="<%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage) %> </a> --%>
	  &nbsp;|&nbsp;<a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&err=0&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage) %></a>
	  <!-- &nbsp;|&nbsp;<a href="#" onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%//=strRequisitionId%>&strTravellerId=<%//=strTravellerID%>&strTravelRequestNo=<%//=strNewReqNo%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=250')">Work Flow Status</a> -->
	  <br><a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550,titlebar=0')" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></a>
	  <!--  &nbsp;|&nbsp;<a TITLE="History" href="#" onClick="MM_openBrWindow('UnderConstruction.html','HELP','scrollbars=yes,resizable=no,width=600,height=316')" >History</a> -->
	  &nbsp;|&nbsp;<a href="T_TravelRequisitionDelete.jsp?travelId=<%=strRequisitionId%>&travelReqId=<%=strTravelReqId%>&travelType=I" onClick="return  deleteConfirm();" title="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
	</TD>
	  <%
	}
	  while(rs.next());

}

rs.close();
stmt.close();

%>
 <tr> 
 	<td class="formhead toggle" style="text-align: center;"><img src="images/expand.png?buildstamp=2_0_0" width="15" height="15" border="0" title="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" alt="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" onclick="showHide('wor-rows', this);" /></td>
    <td colspan="8" class="formhead" id="wor-header"> <%=dbLabelBean.getLabel("label.createrequest.requestsinworkflow",strsesLanguage) %></td>
  </tr>
<%
    intSerialNo=0;
    sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'I') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE ,j.travel_from,j.travel_to,DBO.TRAVEL_COMMENT(t.travel_id,'I'),DBO.REQUISITIONATTACHMENT(t.travel_id,'I'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)), t.TRAVELLER_ID, GROUP_TRAVEL_FLAG  ,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id           FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID AND t.C_USERID="+Suser_id+" and  s.TRAVEL_STATUS_ID in (2,5) AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";

//System.out.println("sSqlStr========Request (s) In Work Flow====="+sSqlStr);
  
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
	do
	{
	strRequisitionId				=	rs.getString(1);
	strNewReqNo						= 	rs.getString(2);
	strName							=	rs.getString(3);
	strAmount						=	rs.getString("Expenditure");
	//strCurrency						=	rs.getString(5);
	strOriginatedBy					=	rs.getString("ORIGINATOR");
	strOriginatedOn					=	rs.getString("C_DATE");	
	strTravel_From					=	rs.getString("travel_from");
	strTravel_To					=	rs.getString("travel_to");
	strPurchaseComments		    	=	rs.getString(9);
	//out.print(strPurchaseComments);
	if(strAmount != null && strAmount.equals("0"))
	{
		strAmount = "-";
		strCurrency="-";
	}
	if(!strPurchaseComments.trim().equals("0"))
	{
		strImagePrint="<img src=images/group1.gif border=0 alt="+dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)+" >";
	}
	else
	{
		strImagePrint="";
	}
	strAttachment					=	rs.getString(10);
	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0 alt="+dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)+" >";
	}

	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 

	strFinalApprovalStatus			=	rs.getString(11);
	strTravellerID					=	rs.getString(12);

	//  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 20-Feb-08 ;   strName="Group Travel ";  
	
	strGroupTravelFlag                  =   rs.getString("GROUP_TRAVEL_FLAG"); 
	strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
	if(strGroupTravelFlag==null) 
	{
		strGroupTravelFlag="N";
 	}
	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))// if(strGroupTravelFlag.equalsIgnoreCase("Y")) 
	{		
		strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
		strName="Group/Guest Travel ";  
		 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			 strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
			 strName="Guest Travel "; 
				}
	}
	else
	{			
		strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
		}
		//strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
	}

	//NEW 19-02-2007 SACHIN
	
	iCls++;

   //get interim id
   sSqlStr = "SELECT DISTINCT PARENT_ID AS PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strRequisitionId;
	stmt1 = con1.createStatement(); 
	rs1 = stmt1.executeQuery(sSqlStr);
		if (rs1.next()) {
			strInterimID = rs1.getString("PARENT_ID");
		}
	rs1.close();
	stmt1.close();
%>
  <tr valign="top" class="<%=strStyleCls%> wor-rows"> 
    <td align="center"><%=++intSerialNo%><br><a href="#" title="Modification Comments" onClick="MM_openBrWindow('T_Modification_Comments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strModCommentImage%></a> <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a><a href="#" title="<%=dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&travel_type=I&err=0&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a></td>
    <td class="listdata" align="center"><a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strNewReqNo%></a></td>
	<td class="listdata" align="center"><%=strName%></td>
	<td class="listdata" align="center"><%=strTravel_From%></td>
	<td class="listdata" align="center"><%=strTravel_To%></td>
	<td class="listdata" align="center"><%=strAmount%></td>
  	<td class="listdata" align="center"><%=strOriginatedBy%></td>
	<td class="listdata" align="center"><%=strOriginatedOn%></td>
	<td class="listhead" align="center">
       <!-- <a  href="T_IntTrv_Details_Edit.jsp?travelId=<%=strRequisitionId%>&travelReqNo=<%=strNewReqNo%>&interimId=<%= strInterimID %>">Edit</a>
       &nbsp;|&nbsp; -->   
	   <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&err=0&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage) %></a>
	   &nbsp;|&nbsp;<a href="#" onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=strRequisitionId%>&strTravellerId=<%=strTravellerID%>&strTravelRequestNo=<%=strNewReqNo%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("link.createeditlist.workflowstatus",strsesLanguage) %>"><%=dbLabelBean.getLabel("link.createeditlist.workflowstatus",strsesLanguage) %></a>
	   <br>
	   <a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></a>
	   &nbsp;|&nbsp;<a href="#" onClick="MM_openBrWindow('T_Travel_Requisition_Cancel.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=900,height=260')" title="<%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage) %></a>
	   <!--  &nbsp;|&nbsp;<a TITLE="History" href="#" onClick="MM_openBrWindow('UnderConstruction.html','HELP','scrollbars=yes,resizable=no,width=600,height=316')" >History</a> -->
	</TD>
	  <%
	}
	  while(rs.next());

}

rs.close();
stmt.close();

%>



<tr> 
	<td class="formhead toggle" style="text-align: center;"><img src="images/expand.png?buildstamp=2_0_0" width="15" height="15" border="0" title="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" alt="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" onclick="showHide('ret-rows', this);" /></td>
    <td colspan="8" class="formhead" id="ret-header"><%=dbLabelBean.getLabel("label.createrequest.returnedrequest",strsesLanguage) %></td>
  </tr>
<%
    intSerialNo=0;
    sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'I') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE ,j.travel_from,j.travel_to,DBO.TRAVEL_COMMENT(t.travel_id,'I'),DBO.REQUISITIONATTACHMENT(t.travel_id,'I'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)),t.TRAVELLER_ID,GROUP_TRAVEL_FLAG ,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID AND t.C_USERID="+Suser_id+" and  s.TRAVEL_STATUS_ID=3 AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";

	// System.out.println("sSqlStr========Returned Request (s)====="+sSqlStr);
  
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
	do
	{
	strRequisitionId				=	rs.getString(1);
	strNewReqNo						= 	rs.getString(2);
	strName							=	rs.getString(3);
	strAmount						=	rs.getString("Expenditure");
	//strCurrency						=	rs.getString(5);
	strOriginatedBy					=	rs.getString("ORIGINATOR");
	strOriginatedOn					=	rs.getString("C_DATE");	
	strTravel_From					=	rs.getString("travel_from");
	strTravel_To					=	rs.getString("travel_to");
	strPurchaseComments		    	=	rs.getString(9);
	//out.print(strPurchaseComments);
	if(strAmount != null && strAmount.equals("0"))
	{
		strAmount = "-";
		strCurrency="-";
	}
	if(!strPurchaseComments.trim().equals("0"))
	{
		strImagePrint="<img src=images/group1.gif border=0 alt="+dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)+" >";
	}
	else
	{
		strImagePrint="";
	}
	strAttachment					=	rs.getString(10);
	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0 alt="+dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)+" >";
	}

	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 

	strFinalApprovalStatus			=	rs.getString(11);
	strTravellerID					=	rs.getString(12);
	strGroupTravelFlag                  =   rs.getString("GROUP_TRAVEL_FLAG"); 
	strTravelAgencyTypeId			=	rs.getString("travel_agency_id");

//  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 20-Feb-08 ;   strName="Group Travel ";  
	if(strGroupTravelFlag==null) 
	{
		strGroupTravelFlag="N";
 	}
	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) 
	{	
		urlpage ="T_Group_QuickTravel_Detail_MATA.jsp";	
		strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
		strName="Group/Guest Travel"; 
		 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			 urlpage="T_Group_QuickTravel_Detail_GmbH.jsp";
			 strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
			 strName="Guest Travel "; 
				}
		
	}
	else
	{		
		urlpage ="T_QuickTravel_Detail_MATA.jsp";
		strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			urlpage = "T_QuickTravel_Detail_GmbH.jsp";
			strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
		}
		//urlpage ="T_IntTrv_Details.jsp";
	}
	  iCls++;

	
	sSqlStr = "SELECT DISTINCT PARENT_ID AS PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strRequisitionId;
	stmt1 = con1.createStatement(); 
	rs1 = stmt1.executeQuery(sSqlStr);
		if (rs1.next()) {
			strInterimID = rs1.getString("PARENT_ID");
		}
	rs1.close();
	stmt1.close();
%>
  
<tr valign="top" class="<%=strStyleCls%> ret-rows"> 
    <td align="center"><%=++intSerialNo%><br><a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a><a href="#" title="<%=dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&travel_type=I&err=0&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a> </td>
    <td class="listdata" align="center"><a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strNewReqNo%></a></td>
	<td class="listdata" align="center"><%=strName%></td>
			<td class="listdata" align="center"><%=strTravel_From%></td> 
	<td class="listdata" align="center"><%=strTravel_To%></td>
	<td class="listdata" align="center"><%=strAmount%></td>
  	<td class="listdata" align="center"><%=strOriginatedBy%></td>
	<td class="listdata" align="center"><%=strOriginatedOn%></td>
	<td class="listhead" align="center">
	
		<a href="<%=urlpage%>?travelId=<%=strRequisitionId%>&travelReqId=<%=strTravelReqId %>&travelReqNo=<%=strNewReqNo%>&interimId=<%= strInterimID %>&travel_type=I" title="<%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage) %></a>
		<%-- <a  href="<%=urlpage%>?travelId=<%=strRequisitionId%>&travelReqNo=<%=strNewReqNo%>&interimId=<%= strInterimID %>" title="<%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage) %>" ><%=dbLabelBean.getLabel("link.createeditlist.edit",strsesLanguage) %></a>  --%>
		&nbsp;|&nbsp;<a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&err=0&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage) %></a>
		&nbsp;|&nbsp;<a href="#" onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=strRequisitionId%>&strTravellerId=<%=strTravellerID%>&strTravelRequestNo=<%=strNewReqNo%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("link.createeditlist.workflowstatus",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.createeditlist.workflowstatus",strsesLanguage) %></a>
		<br><a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></a>
		&nbsp;|&nbsp;<a href="#"  onClick="MM_openBrWindow('T_Travel_Requisition_Cancel.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=900,height=260')" title="<%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage) %></a> 
	  <!-- &nbsp;|&nbsp;<a TITLE="History" href="#" onClick="MM_openBrWindow('UnderConstruction.html','HELP','scrollbars=yes,resizable=no,width=600,height=316')" >History</a> -->
   </TD>
	  <%
	}
	  while(rs.next());

}

rs.close();
stmt.close();

%>





<tr> 
    <td class="formhead toggle" style="text-align: center;"><img src="images/expand.png?buildstamp=2_0_0" width="15" height="15" border="0" title="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" alt="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" onclick="showHide('rej-rows', this);" /></td>
    <td colspan="8" class="formhead" id="rej-header"><%=dbLabelBean.getLabel("label.createrequest.rejectedrequest",strsesLanguage) %></td>
  </tr>
<%
    intSerialNo=0;
    sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'I') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE ,j.travel_from,j.travel_to,DBO.TRAVEL_COMMENT(t.travel_id,'I'),DBO.REQUISITIONATTACHMENT(t.travel_id,'I'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)),t.TRAVELLER_ID, GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as travel_agency_id  FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID AND t.C_USERID="+Suser_id+" and  s.TRAVEL_STATUS_ID=4 AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";
  
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
	do
	{
	strRequisitionId				=	rs.getString(1);
	strNewReqNo						= 	rs.getString(2);
	strName							=	rs.getString(3);
	strAmount						=	rs.getString("Expenditure");
	//strCurrency						=	rs.getString(5);
	strOriginatedBy					=	rs.getString("ORIGINATOR");
	strOriginatedOn					=	rs.getString("C_DATE");	
	strTravel_From					=	rs.getString("travel_from");
	strTravel_To					=	rs.getString("travel_to");
	strPurchaseComments		    	=	rs.getString(9);
	//out.print(strPurchaseComments);
	if(strAmount != null && strAmount.equals("0"))
	{
		strAmount = "-";
		strCurrency="-";
	}
	if(!strPurchaseComments.trim().equals("0"))
	{
		strImagePrint="<img src=images/group1.gif border=0 alt="+dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)+" >";
	}
	else
	{
		strImagePrint="";
	}
	strAttachment					=	rs.getString(10);
	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0 alt="+dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)+" >";
	}
%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 

	strFinalApprovalStatus			=	rs.getString(11);
	strTravellerID					=	rs.getString(12);
	strGroupTravelFlag                  =   rs.getString("GROUP_TRAVEL_FLAG"); 
	strTravelAgencyTypeId			=	rs.getString("travel_agency_id");

	//  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 20-Feb-08 ;   strName="Group Travel ";  
	if(strGroupTravelFlag==null) 
	{
	  strGroupTravelFlag="N";
 	}
	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))// if(strGroupTravelFlag.equalsIgnoreCase("Y")) 
	{		
		strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
		 strName="Group/Guest Travel ";  
		 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			 strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
			 strName="Guest Travel ";  
		}
	}
	else
	{			
		strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
		}
	}

	  iCls++;
%>
  <tr valign="top" class="<%=strStyleCls%> rej-rows"> 
    <td align="center"><%=++intSerialNo%><br><a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a><a href="#" title="<%=dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&travel_type=I&err=0&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a> </td>
    <td class="listdata" align="center"><a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strNewReqNo%></a></td>
	<td class="listdata" align="center"><%=strName%></td>
			<td class="listdata" align="center"><%=strTravel_From%></td>
	<td class="listdata" align="center"><%=strTravel_To%></td>
	<td class="listdata" align="center"><%=strAmount%></td>
  	<td class="listdata" align="center"><%=strOriginatedBy%></td>
	<td class="listdata" align="center"><%=strOriginatedOn%></td>
	<td class="listhead" align="center">
	  <!--  <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&err=0&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="Add Attachments">Attach</a>
	  &nbsp;|&nbsp;  -->
	  <a href="#" onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=strRequisitionId%>&strTravellerId=<%=strTravellerID%>&strTravelRequestNo=<%=strNewReqNo%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("link.createeditlist.workflowstatus",strsesLanguage)%>" ><%=dbLabelBean.getLabel("link.createeditlist.workflowstatus",strsesLanguage)%></a>
	  &nbsp;|&nbsp;<a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a>
	  <!-- <br><a TITLE="History" href="#" onClick="MM_openBrWindow('UnderConstruction.html','HELP','scrollbars=yes,resizable=no,width=600,height=316')" >History</a> -->
	  </TD>
	  <%
	}
	  while(rs.next());

}

rs.close();
stmt.close();

%>

<tr> 
    <td class="formhead toggle" style="text-align: center;"><img src="images/expand.png?buildstamp=2_0_0" width="15" height="15" border="0" title="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" alt="<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>" onclick="showHide('can-rows', this);" /></td>
    <td colspan="8" class="formhead" id="can-header"><%=dbLabelBean.getLabel("label.createrequest.cancelledrequest",strsesLanguage) %></td>
  </tr>
<%
    String strOriginatorId    = "";
	String strCancelationUser = "";
    intSerialNo=0;
    //sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,ISNULL(CONVERT(decimal(20,0),t.TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT,ISNULL(t.TA_CURRENCY,'-') AS TA_CURRENCY,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE ,j.travel_from,j.travel_to,DBO.TRAVEL_COMMENT(t.travel_id,'I'),DBO.REQUISITIONATTACHMENT(t.travel_id,'I'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)),t.TRAVELLER_ID, t.C_USERID AS ORIGINATOR_ID, GROUP_TRAVEL_FLAG  FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID AND t.C_USERID="+Suser_id+" and  s.TRAVEL_STATUS_ID=6 AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";
    
    //change in query to get t.travel_Req_id column on 01 july 2011
    sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER,dbo.FN_GET_EXPENDITURE(t.travel_id,'I') AS Expenditure,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,ISNULL(DBO.CONVERTDATEDMY1(t.C_DATETIME),'-') AS C_DATE ,j.travel_from,j.travel_to,DBO.TRAVEL_COMMENT(t.travel_id,'I'),DBO.REQUISITIONATTACHMENT(t.travel_id,'I'),RTRIM(DBO.TRAVEL_FINAL_APPROVAL_STATUS(t.TRAVELLER_ID,'I',t.TRAVELLER_ID)),t.TRAVELLER_ID, t.C_USERID AS ORIGINATOR_ID, GROUP_TRAVEL_FLAG, t.travel_req_id as travel_req_id FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID AND t.C_USERID="+Suser_id+" and  s.TRAVEL_STATUS_ID=6 AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10  ORDER BY T.C_DATETIME DESC";
  //System.out.println("sSqlStr-----cancelled request------>"+sSqlStr);
stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
	do
	{
	strRequisitionId				=	rs.getString(1);
	strNewReqNo						= 	rs.getString(2);
	strName							=	rs.getString(3);
	strAmount						=	rs.getString("Expenditure");
	//strCurrency						=	rs.getString(5);
	strOriginatedBy					=	rs.getString("ORIGINATOR");
	strOriginatedOn					=	rs.getString("C_DATE");	
	strTravel_From					=	rs.getString("travel_from");
	strTravel_To					=	rs.getString("travel_to");
	strPurchaseComments		    	=	rs.getString(9);
	//System.out.println("String Purchase Comments"+strPurchaseComments);
	if(strAmount != null && strAmount.equals("0"))
	{
		strAmount = "-";
		strCurrency="-";
	}
	if(!strPurchaseComments.trim().equals("0"))
	{
		strImagePrint="<img src=images/group1.gif border=0 alt="+dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)+" >";
	}
	else
	{
		strImagePrint="";
	}
	strAttachment					=	rs.getString(10);
	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0 alt="+dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)+" >";
	}
%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 

	strFinalApprovalStatus			=	rs.getString(11);
	strTravellerID					=	rs.getString(12);
	strOriginatorId                 =   rs.getString(13);
	strGroupTravelFlag              =   rs.getString("GROUP_TRAVEL_FLAG");
	//added by manoj chand on 01 july 2011 to get travel_req_id
	strTravelReqId					=	rs.getString("travel_req_id");
	//  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 20-Feb-08 ;   strName="Group Travel "; 
	if(strGroupTravelFlag==null) 
	{
	   strGroupTravelFlag="N";
 	}
	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))// if(strGroupTravelFlag.equalsIgnoreCase("Y")) 
	{		
		strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
		 strName="Group/Guest Travel "; 
		 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			 strName="Guest Travel "; 
				}
	}
	else
	{			
		strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
		}
		//strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
	}

	iCls++;
%>
<% 
	sSqlStr = "SELECT DISTINCT PARENT_ID AS PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strRequisitionId;
	stmt1 = con1.createStatement(); 
	rs1 = stmt1.executeQuery(sSqlStr);
		if (rs1.next()) {
			strInterimID = rs1.getString("PARENT_ID");
		}
	rs1.close();
	stmt1.close();
	
	String strPostedUserId = "";
	String strPostedUserRole = "";
	sSqlStr = "SELECT POSTED_BY, DBO.USER_ROLE(POSTED_BY) AS USER_ROLE  FROM TRAVEL_REQ_CANCEL WHERE TRAVEL_ID = "+strRequisitionId+" AND APPLICATION_ID=1";
	stmt1 = con1.createStatement(); 
	rs1 = stmt1.executeQuery(sSqlStr);
		if (rs1.next()) {
			strPostedUserId     = rs1.getString("POSTED_BY");
			strPostedUserRole   = rs1.getString("USER_ROLE"); 
		}
	rs1.close();
	stmt1.close();

	if(strPostedUserId != null && strPostedUserId.equalsIgnoreCase(strOriginatorId))
	{
		strCancelationUser = dbLabelBean.getLabel("label.createrequest.self",strsesLanguage);
         
	}
	else if(strPostedUserRole!=null && strPostedUserRole.equalsIgnoreCase("MATA"))
	{
		strCancelationUser = dbLabelBean.getLabel("label.createrequest.mata",strsesLanguage);
	}//else block added by manoj to show cancelled by admin in cancelled request
	else{
		strCancelationUser = dbLabelBean.getLabel("label.createrequest.admin",strsesLanguage);
	}
%>
  
<tr valign="top" class="<%=strStyleCls%> can-rows"> 
    <td align="center"><%=++intSerialNo%><br><a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a><a href="#" title="<%=dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strRequisitionId%>&travel_type=I&err=0&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a> </td>
    <td class="listdata" align="center"><a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strRequisitionId%>&traveller_Id=<%=strTravellerID%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strNewReqNo%></a></td>
	<td class="listdata" align="center"><%=strName%></td>
			<td class="listdata" align="center"><%=strTravel_From%></td>
	<td class="listdata" align="center"><%=strTravel_To%></td>
	<td class="listdata" align="center"><%=strAmount%></td>
  	<td class="listdata" align="center"><%=strOriginatedBy%></td>
	<td class="listdata" align="center"><%=strOriginatedOn%></td>
	<td class="listhead" align="center"><b><%=dbLabelBean.getLabel("label.createrequest.cancelledby",strsesLanguage) %> <%=strCancelationUser%></b> <br>
	  <!-- Change the @Vijay Singh 26/Mar/2007  jsp file-->
	  <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strRequisitionId%>&travel_type=I&whichPage=T_TravelRequisitionList.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %></a>
	  &nbsp;|&nbsp;<a href="T_TravelRequisitionDelete.jsp?travelId=<%=strRequisitionId%>&travelReqId=<%=strTravelReqId%>&travelType=I" onClick="return  deleteConfirm();" title="<%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %></a>
	  <!-- <br>
	  <a TITLE="History" href="#" onClick="MM_openBrWindow('UnderConstruction.html','HELP','scrollbars=yes,resizable=no,width=600,height=316')" >History</a> -->
	  </TD>
	  <%
	}
	  while(rs.next());

}

rs.close();
stmt.close();

%>



<tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
 </tr>
</table>
<br></form>
	<script type="text/javascript">
		 document.getElementById("divBackground").style.display="none";
		 document.getElementById("divBackground").style.visibility="hidden";
		 $("body").css("overflow", "auto");
	</script>
</body>
</HTML>
<script type="text/javascript"> 

	function showHide(clsName, obj){
		var omitElemId = $(obj).closest('td').next().attr('id');
		$(document).find('.tem-rows, .wor-rows, .ret-rows, .rej-rows, .can-rows').not('.'+clsName).each(function(){
			$(this).hide();
		});
		
		$(document).find('#tem-header, #wor-header, #ret-header, #rej-header, #can-header').not('#'+omitElemId).each(function(){
			$(this).closest('tr').find('img').attr('src', 'images/expand.png?buildstamp=2_0_0');	
			$(this).closest('tr').find('img').attr('title', '<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>');	
			$(this).closest('tr').find('img').attr('alt', '<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>');	
		});
		
		if($(obj).attr('src') == 'images/collapse.png?buildstamp=2_0_0'){
			$(obj).attr('src', 'images/expand.png?buildstamp=2_0_0');
			$(obj).attr('title', '<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>');	
			$(obj).attr('alt', '<%=dbLabelBean.getLabel("label.global.expand",strsesLanguage) %>');	
		} else if($(obj).attr('src') == 'images/expand.png?buildstamp=2_0_0'){
			$(obj).attr('src', 'images/collapse.png?buildstamp=2_0_0');
			$(obj).attr('title', '<%=dbLabelBean.getLabel("label.global.collapse",strsesLanguage) %>');	
			$(obj).attr('alt', '<%=dbLabelBean.getLabel("label.global.collapse",strsesLanguage) %>');	
		}
		
		$(document).find('.'+clsName).each(function(){
			$(this).toggle();
		});
	}
	
	
	$(document).ready(function(){
		$('#tem-header').append('<label style="position:absolute;left:218px;"><span class="blueBgCount">' + $('.tem-rows').length + '</span></label>');
		$('#wor-header').append('<label style="position:absolute;left:218px;"><span class="blueBgCount">' + $('.wor-rows').length + '</span></label>');
		$('#ret-header').append('<label style="position:absolute;left:218px;"><span class="blueBgCount">' + $('.ret-rows').length + '</span></label>');
		$('#rej-header').append('<label style="position:absolute;left:218px;"><span class="blueBgCount">' + $('.rej-rows').length + '</span></label>');
		$('#can-header').append('<label style="position:absolute;left:218px;"><span class="blueBgCount">' + $('.can-rows').length + '</span></label>');
		
		if($('.tem-rows').length==0){
			$('#tem-header').closest('tr').find('img').hide();
			$('#tem-header').closest('tr').find('label').hide();
			$('#tem-header').closest('tr').find('td.toggle').append('&nbsp;');
		}
		if($('.wor-rows').length==0){
			$('#wor-header').closest('tr').find('img').hide();
			$('#wor-header').closest('tr').find('label').hide();
			$('#wor-header').closest('tr').find('td.toggle').append('&nbsp;');
		}
		if($('.ret-rows').length==0){
			$('#ret-header').closest('tr').find('img').hide();
			$('#ret-header').closest('tr').find('label').hide();
			$('#ret-header').closest('tr').find('td.toggle').append('&nbsp;');
		}
		if($('.rej-rows').length==0){
			$('#rej-header').closest('tr').find('img').hide();
			$('#rej-header').closest('tr').find('label').hide();
			$('#rej-header').closest('tr').find('td.toggle').append('&nbsp;');
		}
		if($('.can-rows').length==0){
			$('#can-header').closest('tr').find('img').hide();
			$('#can-header').closest('tr').find('label').hide();
			$('#can-header').closest('tr').find('td.toggle').append('&nbsp;');
		}
		
		
		$('#tem-header').closest('tr').find('img').click();
		$('#wor-header').closest('tr').find('img').click();
		$('#ret-header').closest('tr').find('img').click();
		$('#rej-header').closest('tr').find('img').click();
		$('#can-header').closest('tr').find('img').click();
		
		var requisitionType = '<%=strReqType%>';
		if(requisitionType!= ""){
			$('#'+requisitionType).closest('tr').find('img').click();
			
		}else{
			$('#tem-header').closest('tr').find('img').click();
		}
	});
    </script>        
