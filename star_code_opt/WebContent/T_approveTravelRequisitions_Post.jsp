<%@page import="org.apache.log4j.Level"%>
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:30 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is second(post) jsp file  for approve the Travel Requisition in the STAR Database
 *Modification 			:Now Mail will go to MATA for tentative booking when unit head approve the requisition
						:Change the mail message 
 *Reason of Modification:Suggested by MATA
 *Date of Modification  : 20-02-2007,09 -April-2007 
 *Revision History		: by sachin Gupta
                          by shiv sharma  
 *Modified By			:Vijay Singh
 *Editor				:Editplus
 
 *Modified By			: MANOJ CHAND
 *Date of Modification  : 09 May 2012
 *Modification			: Comments changed according to request approved by reviewer or original approver. 
 						: Change in query getting unit head flag.
 						
*Modified By			: MANOJ CHAND
*Date of Modification   : 26 Sept 2012
*Modification			: Changes done in this page for getting travel type from the selected checkbox value.
						  and to provide feature to approve both kind of request in one approve button click.
						  
*Modified By			: MANOJ CHAND
*Date of Modification   : 10 Jan 2013
*Modification			: Web Service Calling added to push data to mata when request is approve by all

*Modified By			: MANOJ CHAND
*Date of Modification   : 03 Apr 2013
*Modification			: prevent approval and ws calling in case request is already approved. and ws will call when user role is mata and he/she is the last approver.

*Modified By			: MANOJ CHAND
*Date of Modification   : 09 May 2013
*Modification			: send empid='' to erp webservice when request is group/guest travel request.

*Modified By			: MANOJ CHAND
*Date of Modification   : 22 May 2013
*Modification			: send total amount with Curreny to erp webservice.

*Modified By			: MANOJ CHAND
*Date of Modification   : 29 July 2013
*Modification			: send empid='STAR' to erp webservice when request is group/guest travel request.

*Modified By			: MANOJ CHAND
*Date of Modification   : 14 August 2013
*Modification			: Implement a check whether approver already has approved the request.

*Modified By			: MANOJ CHAND
*Date of Modification   : 26 August 2013
*Modification			: add condition to check for pap approver approving request.

*Modified By 			:Manoj Chand
*Modification Date		:27 Aug 2013
*Modification			:pass one parameter xmlparam string to erp webservice method.

*Modified By 			:Manoj Chand
*Modification Date		:04 Oct 2013
*Modification			:pass one parameter company name to erp webservice method.
*******************************************************/
%>
<%@ page  pageEncoding="UTF-8" language="java" import="src.connection.PropertiesLoader,java.math.BigDecimal" %>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.log4j.Logger"%>
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
<%@ include  file="systemStyle.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="wsClientObj" scope="page" class="wsclient.WSClient" />
<jsp:useBean id="wsErrormailObj" scope="page" class="wsclient.errormail.WSerrormail" />
<jsp:useBean id="mailDaoImpl" scope="page" class="src.dao.MailDaoImpl"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Calendar cal = Calendar.getInstance();

request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
ResultSet rs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement
Statement stmt					=		null;
con=dbConBean1.getConnection();   //get Connection // Change  from 'dbConBean' to dbConBean1 on 09-april '07 by shiv 
String	sSqlStr				=	""; // For sql Statements
String strNewReqId			=	"";
String strStatus			=	"Approve";
String strComments			=	"";
int	   intCount				=	0;
String strCount				=	""; //object to store no of rows selected
String	strReq	=	"";
strCount	 				=	request.getParameter("count");	// GET COUNT
intCount					=	Integer.valueOf(strCount).intValue();	//get int value for count
String	strSql	=	"";
String strCheckValue        = "";
String strTravelId          = "";
String strTravellerId       = "";
StringTokenizer token       = null;  
String strOrderId	=	"";
String strTravelType      =  "";
String strTravelTypeFlag  =  "";
String strApproverName	 =	"";
String strReveiwFlag="N";
strTravelType   =  request.getParameter("travel_type")==null?"":request.getParameter("travel_type");
//System.out.println("strTravelType--->"+strTravelType);
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

/*if(strTravelType.equalsIgnoreCase("I"))
	{
strReq	=	"International Travel";
	}
	else
	{
strReq	=	"Domestic Travel";
	}*/


	  Logger logger=Logger.getLogger(this.getClass().getName()); 		
	  logger.setLevel(Level.ALL);
		
	  logger.info("Approve Travel Request Start " +dateFormat.format(cal.getTime()));	
	  
	
String strTrvType="";
String strAlreadyApprove = null;
String strTravelStatus = null;
//System.out.println("intCount--->"+intCount);
for (int j=0;j<=intCount;j++)
{
	strCheckValue = request.getParameter("chk"+j);
	strReveiwFlag="N";
    
	if(strCheckValue!=null)
	{
      token = new StringTokenizer(strCheckValue,";"); 
	  while(token.hasMoreTokens())
	  {
		  strTravelId     =  token.nextToken();
		  strTravellerId  =  token.nextToken();
		  //travel type is get from checkbox value, done by manoj chand on 25 sept 2012
		  strTrvType	=	token.nextToken();
	  }
	  //added by manoj chand on 25 sept 2012 to set message based on travel type of request approved.
	  if(strTrvType.equalsIgnoreCase("I"))
		{
			strReq	=	"International Travel";
		}
		else
		{
			strReq	=	"Domestic Travel";
		}
	//added by manoj chand on 09 may 2012 to check whether reviewer is approving request or either original approver.	
	  sSqlStr="SELECT DBO.[user_name](APPROVER_ID) AS APPROVER FROM T_APPROVERS WHERE T_APPROVERS.PAP_APPROVER='"+Suser_id+"' AND T_APPROVERS.TRAVEL_ID='"+strTravelId+"' AND T_APPROVERS.TRAVEL_TYPE='"+strTrvType+"' AND TRAVELLER_ID='"+strTravellerId+"' AND APPROVE_STATUS=0";
	  //System.out.println("sSqlStr-----app out post"+j+"--->"+sSqlStr);
	  stmt = con.createStatement(); 
	  rs = stmt.executeQuery(sSqlStr);
	  if(rs.next())
	  {
	  	strApproverName	 =	rs.getString("APPROVER");
	  	strReveiwFlag="Y";
	  }
	  rs.close();
	  stmt.close();
	  //end here
	  if(strReveiwFlag.equalsIgnoreCase("Y"))
		  strComments=dbLabelBean.getLabel("message.approverequest.approvedby",strsesLanguage)+" "+strApproverName;
	  else	  
	  	  strComments=dbLabelBean.getLabel("message.approverequest.approvedby",strsesLanguage)+" "+sUserFirstName+" "+sUserLastName+" ";
	  //System.out.println("strComments---"+j+"-->"+strComments);
	  
	  //added by manoj chand on 03 April 2013 to check whether request is already approved before approving request.
	  strAlreadyApprove="no";
	  sSqlStr="select ltrim(rtrim(Travel_status_id)) as Travel_status_id from dbo.T_TRAVEL_STATUS tts where travel_id='"+strTravelId+"' and tts.TRAVEL_TYPE='"+strTrvType+"' AND tts.STATUS_ID=10";
	  rs = dbConBean.executeQuery(sSqlStr);
	  if(rs.next()){
	    	strTravelStatus=rs.getString("Travel_status_id");
	    	if(strTravelStatus!=null && !strTravelStatus.equals("") && strTravelStatus.equals("10")){
	    		strAlreadyApprove="yes";
	    	}
	  }
	  rs.close();
	  
	if(strAlreadyApprove.equals("no")){
	  
		//QUERY ADDED BY MANOJ CHAND ON 14 AUGUST 2013 TO CHECK WHETHER APPROVER ALREADY HAS APPROVED THE REQUEST
		// adding a case to check for pap approver on 26 august 2013
		sSqlStr ="SELECT CASE WHEN EXISTS(SELECT  1 from dbo.T_APPROVERS ta WHERE TRAVEL_ID = '"+strTravelId+"'"+
				" AND CASE WHEN PAP_APPROVER<>0 THEN PAP_APPROVER ELSE APPROVER_ID END = "+Suser_id+" AND TRAVEL_TYPE = '"+strTrvType+"'"+
				" AND (RECEIVED_DATE IS NOT NULL OR YEAR(RECEIVED_DATE)<>1900) AND APPROVE_STATUS=0"+
				" AND STATUS_ID=10) THEN 'Y' ELSE 'N' END AS APP_FLAG";
		rs = null;
		String strAlreadyApprovebyuser="N";
		rs = dbConBean.executeQuery(sSqlStr);
		  if(rs.next()){
			  strAlreadyApprovebyuser=rs.getString("APP_FLAG");
		  }
		rs.close();
		
   if(strAlreadyApprovebyuser.equals("Y")){ 
		
	try
	  {
         //Procedure for Approve the Requisitions
	 	 cstmt=con.prepareCall("{?=call PROC_APPROVE_REQ(?,?,?,?,?,?)}");
		 cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		 cstmt.setString(2, strTravelId);
		 cstmt.setString(3, Suser_id);
		 cstmt.setString(4, strStatus);
		 cstmt.setString(5, strComments);
		 cstmt.setString(6, strTravellerId);
		 cstmt.setString(7, strTrvType);
		 cstmt.execute();
		 cstmt.close();


		 //Procedure for checking that all approver approve this requisition or not. If all approve then this procedure update the requisition travel_status_id 10 in T_Travel_Status table 

 	 	 cstmt=con.prepareCall("{?=call PROC_CHECK_APPROVE_STATUS(?,?)}");
		 cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		 cstmt.setString(2, strTravelId);
		 cstmt.setString(3, strTrvType);
		 cstmt.execute();
		 cstmt.close();

           
	  }
	  catch(Exception e)
	  {
		  System.out.println("Error in T_approveTravelRequisitions_Post.jsp==========="+e);
	  }
	  
      strNewReqId=request.getParameter("chk"+j).trim();
%>
	<!-- includes the jsp that inserts data into REQ_MAILBOX -->
<%
	strSql	=	"select  max(order_id) AS ORDER_ID from t_approvers where approve_status=10 and approver_id="+Suser_id+" and travel_type='"+strTrvType+"'  and  travel_id="+strTravelId;

  

	rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		strOrderId							=	rs.getString(1);			//order id
		if(strOrderId == null)
			strOrderId = "-1";
	}
	rs.close();

String strTravellerSiteId = "";
String strIsUnitHead = "0";               // '0' for no and '1' for yes

//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
//strSql  = "SELECT SITE_ID FROM M_USERINFO WHERE USERID="+strTravellerId;
if(strTrvType != null && strTrvType.equals("D"))
{
	strSql = "SELECT SITE_ID FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strTravelId+" AND STATUS_ID=10";
}
else if(strTrvType != null && strTrvType.equals("I"))
{
	strSql = "SELECT SITE_ID FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strTravelId+" AND STATUS_ID=10";
}
rs = dbConBean.executeQuery(strSql);
if(rs.next())
{
	strTravellerSiteId			=	rs.getString(1).trim();			
}
rs.close();

/*if(strTravellerSiteId != null && strTravellerSiteId.equals(strSiteIdSS))
{
	strSql  = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD FROM M_USERINFO WHERE USERID="+Suser_id+" AND SITE_ID="+strSiteIdSS;
	rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		strIsUnitHead			=	rs.getString(1).trim();			
	}
	rs.close();
}*/
if(strTravellerSiteId != null)
{
   //strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS where userid="+Suser_id+" and site_id="+strTravellerSiteId+" and status_id=10 and unit_head=1";
 //query changed by manoj chand on 09 may 2012 to check for unit head flag of approver corresponding to reviewer and approver itself. 
   strSql= " SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS"+
		   " where userid= (SELECT  APPROVER_ID FROM T_APPROVERS TA WHERE TA.TRAVEL_ID='"+strTravelId+"' AND TA.TRAVELLER_ID='"+strTravellerId+"' AND TA.TRAVEL_TYPE='"+strTrvType+"'"+ 
		   " and ORDER_ID = (SELECT max(ORDER_ID) FROM T_APPROVERS  WHERE approve_status =10 and TRAVEL_ID='"+strTravelId+"' AND TRAVELLER_ID='"+strTravellerId+"' AND TRAVEL_TYPE='"+strTrvType+"'))"+
		   " and site_id='"+strTravellerSiteId+"' and status_id=10 and unit_head=1";
  //System.out.println("strSql==unithead=inside=>"+strSql);
   	rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		strIsUnitHead			=	rs.getString(1).trim();			
	}
	rs.close();
}
//System.out.println("strIsUnitHead========="+strIsUnitHead);
//--------------------------------End--------------------------------------------------------------------------------------------

if(strStatus.equalsIgnoreCase("Approve") && strIsUnitHead.equals("1") && !SuserRole.equalsIgnoreCase("MATA"))
{	
	//System.out.println("hi----------15-May-07------>>>");
%>

<!-- code added by sachin on 3/13/2007 open 09/04/2007 vijay change mail subject-->
	<jsp:include page="T_MailToHRandAC.jsp" flush="true" >
		<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/>
		<jsp:param name="ReqTyp" value="<%=strReq%>"/>
		<jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
		<jsp:param name="RoleId" value="HR&AC"/>
		<jsp:param name="mailSubject" value="label.mail.intimationmailafterunitheadapproval"/> 
		<jsp:param name="mailMessage" value="label.mail.hasgotunitheadapproval"/>
		<jsp:param name="strTravellerSiteId" value="<%=strTravellerSiteId%>"/>

	</jsp:include>
<!-- code added by sachin on 3/13/2007 closed-->
<%		  
}
//Added by sachin 3/14/2007 start
if(strStatus.equalsIgnoreCase("Approve") && !strIsUnitHead.equals("1") && !SuserRole.equalsIgnoreCase("MATA"))
{
	String strBillingClient = "";
	String strManagerId = "";
	String strHodId     = "";
	strSql = "";
	if(strTrvType.equals("I"))
	{
		strSql = "SELECT ISNULL(MANAGER_ID,'-1') AS MANAGER_ID,ISNULL(HOD_ID,'-1') AS HOD_ID,ISNULL(BILLING_CLIENT,'') AS BILLING_CLIENT, BILLING_SITE FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strTravelId;
	}
	else if(strTrvType.equals("D"))
	{
		strSql = "SELECT ISNULL(MANAGER_ID,'-1') AS MANAGER_ID,ISNULL(HOD_ID,'-1') AS HOD_ID,ISNULL(BILLING_CLIENT,'') AS BILLING_CLIENT, BILLING_SITE FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strTravelId;
	}
   
   

	rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		strManagerId				=   rs.getString("MANAGER_ID").trim();
		strHodId					=   rs.getString("HOD_ID").trim();
		strBillingClient			=	rs.getString("BILLING_CLIENT").trim();			
	}
	rs.close();

	if(!strBillingClient.equals("self"))
	{
	  if(strOrderId != null && strOrderId.equals("1.0"))
	  {
%><!--@Vijay 05/04/2007 add the mailMessage in jsp param-->

<%--
		<jsp:include page="T_MailToHRandAC.jsp" flush="true" >
			<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/>
			<jsp:param name="ReqTyp" value="<%=strReq%>"/>
			<jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
			<jsp:param name="RoleId" value="HR&AC"/>
			<jsp:param name="mailSubject" value="Intimation Mail After First Approval"/>
			<jsp:param name="mailMessage" value=" is approved by me"/>
			<jsp:param name="strTravellerSiteId" value="<%=strTravellerSiteId%>"/>
		</jsp:include>	
--%>
<%//END MODIFICATION

	  }

	}
}
//Added by sachin 3/14/2007 end

if(SuserRole!=null && SuserRole.equalsIgnoreCase("MATA")) 
{
%>
	
	 <jsp:include page="T_requisitionMailOnReceiving.jsp" flush="true" >
		<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/>
        <jsp:param name="rad" value="<%=strStatus.trim()%>"/>
        <jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
	    <jsp:param name="ReqTyp" value="<%=strReq%>"/>
     </jsp:include>
	

<%      
} 
else 
{
	logger.info("Requisition Mail on Approval Start for Requisition number-->" +strTravelId+ " at "  +dateFormat.format(cal.getTime()));	
	
	mailDaoImpl.sendRequisitionMailOnApproval(strTravelId, strReq, strComments.trim(), strTravellerSiteId, Suser_id, strsesLanguage, strCurrentYear, strMailCreatedate);
%>
<%-- 	 <jsp:include page="T_requisitionMailOnApproval.jsp" flush="true" > --%>
<%-- 		<jsp:param name="purchaseRequisitionId" value="<%=strTravelId%>"/> --%>
<%--         <jsp:param name="rad" value="<%=strStatus.trim()%>"/> --%>
<%--         <jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/> --%>
<%-- 	    <jsp:param name="ReqTyp" value="<%=strReq%>"/> --%>
<%-- 	    <jsp:param name="SiteId" value="<%=strTravellerSiteId %>"/> --%>
<%--      </jsp:include> --%>

<% 
	logger.info("Requisition Mail on Approval End for Requisition number-->" +strTravelId+ " at "  +dateFormat.format(cal.getTime()));	
}
//System.out.println("************* out side ***** SuserRole *****"+SuserRole);
//code added by manoj chand on 10 jan 2013 to send data to web service.
String strCallFlag=PropertiesLoader.config.getProperty("wscallflag");
//System.out.println("strCallFlag--mo------>"+strCallFlag);
if(strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
	String strApproveStatus="",strCompanyName="";
	String strWSUrl="",strERPWSUrl="",strMATAXml="",strERPXml="",strWSResponse="",strERPXmlParam="";
	String strTravelReqNo="",strResonforTravel="",strCuserId="",strEmpCode="",strGroupReqFlag="N",strTA_Currency="INR";
	// Added By GURMEET SINGH 
	String strDepDate="", strReturnDate="";
	BigDecimal totalAmount=null;
	rs=null;
	try{
	strSql="select ltrim(rtrim(Travel_status_id)) as Travel_status_id from dbo.T_TRAVEL_STATUS tts where travel_id='"+strTravelId+"' and tts.TRAVEL_TYPE='"+strTrvType+"' AND tts.STATUS_ID=10";
	rs = dbConBean.executeQuery(strSql);
	if(rs.next()){
		strApproveStatus=rs.getString("Travel_status_id");
	}
	rs.close();
	
	//code added by manoj chand on 03 apr 2013 to check whether user is last approver of request of not.
	String strLastApprover = "";
	strSql="SELECT CASE WHEN EXISTS(SELECT 1 FROM T_APPROVERS WHERE ORDER_ID=(SELECT MAX(ORDER_ID) FROM T_APPROVERS"+ 
		" WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='"+strTrvType+"' AND STATUS_ID=10)"+
		" AND APPROVE_STATUS=10 AND APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='"+strTrvType+"')"+
		" THEN 'Y' ELSE 'N' END";
	rs=null;
	rs = dbConBean.executeQuery(strSql);
	if(rs.next()){
		strLastApprover=rs.getString(1);
	}
	rs.close();
	//System.out.println("strSql- post-->"+strSql);
	
	
	if(strApproveStatus.equals("10") && strLastApprover.equals("Y")){
		if(strTrvType.equalsIgnoreCase("D")){
			strSql= " select mc.COMPANY_NAME,mc.MATA_WS_URL,mc.ERP_WS_URL,ttdd.TRAVEL_REQ_NO,ttdd.REASON_FOR_TRAVEL, "+
		 			" ttdd.C_USERID,mu.EMP_CODE,ttdd.TOTAL_AMOUNT,isnull(ttdd.Group_Travel_Flag,'N') as Group_Travel_Flag, "+
					" isnull(ttdd.TA_CURRENCY,'') as TA_CURRENCY,ISNULL(mc.ERP_XML,'') AS ERP_XML,ISNULL(convert(varchar(12), "+
		 			" ttdd.TRAVEL_DATE,106),'-') as DEP_DATE,CASE WHEN (CONVERT(VARCHAR(10), TRJDD.TRAVEL_DATE, 20)) IS NULL "+
					" OR CONVERT(VARCHAR(10), TRJDD.TRAVEL_DATE, 20) = '1900-01-01' THEN CONVERT(VARCHAR(12), "+
		 			" MAX(TJDD.TRAVEL_DATE),106) ELSE CONVERT(VARCHAR(12),TRJDD.TRAVEL_DATE, 106) END as RET_DATE "+
					" FROM m_site "+
					" INNER JOIN dbo.T_TRAVEL_DETAIL_DOM TTDD (NOLOCK) ON M_SITE.SITE_ID=TTDD.SITE_ID "+ 
					" INNER JOIN  T_JOURNEY_DETAILS_DOM TJDD (NOLOCK)  ON TTDD.TRAVEL_ID = TJDD.TRAVEL_ID "+
					" LEFT OUTER JOIN T_RET_JOURNEY_DETAILS_DOM TRJDD (NOLOCK)  ON TTDD.TRAVEL_ID = TRJDD.TRAVEL_ID "+
					" AND TRJDD.STATUS_ID=10 "+ 
					" INNER JOIN dbo.M_USERINFO mu on mu.USERID=ttdd.TRAVELLER_ID "+
					" INNER JOIN dbo.M_COMPANY mc on mc.CID=m_site.COMPANY_ID "+
					" WHERE MC.STATUS_ID=10 AND M_SITE.STATUS_ID=10 AND TTDD.STATUS_ID=10 AND MU.STATUS_ID=10 "+
					" AND TJDD.STATUS_ID=10 "+
					" AND TTDD.TRAVEL_ID='"+strTravelId+"' "+
					" GROUP BY MC.COMPANY_NAME,MC.MATA_WS_URL,MC.ERP_WS_URL,TTDD.TRAVEL_REQ_NO,"+
					" TTDD.REASON_FOR_TRAVEL,TTDD.C_USERID,MU.EMP_CODE,TTDD.TOTAL_AMOUNT,"+
					" TTDD.GROUP_TRAVEL_FLAG,TTDD.TA_CURRENCY,mc.ERP_XML,ttdd.TRAVEL_DATE,TRJDD.TRAVEL_DATE";
		}
		if(strTrvType.equalsIgnoreCase("I")){
			strSql= " select mc.COMPANY_NAME,mc.MATA_WS_URL,mc.ERP_WS_URL,ttdi.TRAVEL_REQ_NO,ttdi.REASON_FOR_TRAVEL, "+
		 			" ttdi.C_USERID,mu.EMP_CODE,ttdi.TOTAL_AMOUNT,isnull(ttdi.Group_Travel_Flag,'N') as Group_Travel_Flag, "+
					" isnull(ttdi.TA_CURRENCY,'') as TA_CURRENCY,ISNULL(mc.ERP_XML,'') AS ERP_XML,ISNULL(convert(varchar(12), "+
		 			" ttdi.TRAVEL_DATE,106),'-') as DEP_DATE,CASE WHEN (CONVERT(VARCHAR(10), TRJDI.TRAVEL_DATE, 20)) IS NULL "+
					" OR CONVERT(VARCHAR(10), TRJDI.TRAVEL_DATE, 20) = '1900-01-01' THEN CONVERT(VARCHAR(12), "+
		 			" MAX(TJDI.TRAVEL_DATE),106) ELSE CONVERT(VARCHAR(12),TRJDI.TRAVEL_DATE, 106) END as RET_DATE "+
					" FROM m_site "+
					" INNER JOIN dbo.T_TRAVEL_DETAIL_INT TTDI (NOLOCK) ON M_SITE.SITE_ID=ttdi.SITE_ID "+ 
					" INNER JOIN  T_JOURNEY_DETAILS_INT TJDI (NOLOCK)  ON ttdi.TRAVEL_ID = TJDI.TRAVEL_ID "+
					" LEFT OUTER JOIN T_RET_JOURNEY_DETAILS_INT TRJDI (NOLOCK)  ON ttdi.TRAVEL_ID = TRJDI.TRAVEL_ID "+
					" INNER JOIN dbo.M_USERINFO mu on mu.USERID=ttdi.TRAVELLER_ID "+
					" INNER JOIN dbo.M_COMPANY mc on mc.CID=m_site.COMPANY_ID "+
					" WHERE MC.STATUS_ID=10 AND M_SITE.STATUS_ID=10 AND ttdi.STATUS_ID=10 AND MU.STATUS_ID=10 "+
					" AND TJDI.STATUS_ID=10 "+
					" AND ttdi.TRAVEL_ID='"+strTravelId+"' "+
					" GROUP BY MC.COMPANY_NAME,MC.MATA_WS_URL,MC.ERP_WS_URL,ttdi.TRAVEL_REQ_NO,"+
					" ttdi.REASON_FOR_TRAVEL,ttdi.C_USERID,MU.EMP_CODE,ttdi.TOTAL_AMOUNT,"+
					" ttdi.GROUP_TRAVEL_FLAG,ttdi.TA_CURRENCY,mc.ERP_XML,ttdi.TRAVEL_DATE,TRJDI.TRAVEL_DATE";
		}
		//System.out.println("strSql-approvereqpost-->"+strSql);
		rs=null;
		rs = dbConBean.executeQuery(strSql);
		if(rs.next()){
			strCompanyName = rs.getString("COMPANY_NAME");
			strWSUrl=rs.getString("MATA_WS_URL");
			strERPWSUrl=rs.getString("ERP_WS_URL");
			strTravelReqNo=rs.getString("TRAVEL_REQ_NO");
			strResonforTravel=rs.getString("REASON_FOR_TRAVEL");
			strCuserId=rs.getString("C_USERID");
			strEmpCode=rs.getString("EMP_CODE");
			totalAmount=new BigDecimal(rs.getString("TOTAL_AMOUNT"));
			strGroupReqFlag = rs.getString("Group_Travel_Flag").trim();
			strTA_Currency = rs.getString("TA_CURRENCY").trim();
			strERPXmlParam = rs.getString("ERP_XML").trim();
			strDepDate = rs.getString("DEP_DATE");
			strReturnDate = rs.getString("RET_DATE");
		}
		rs.close();
	
	if(!strWSUrl.equals("")){
		rs=null;
		String strConID=PropertiesLoader.config.getProperty("conid");
		cstmt=con.prepareCall("{?=call SPG_TRAVEL_REQUISITION_DTL(?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strTravelId);
		cstmt.setString(3, strTrvType);
		cstmt.setString(4, strConID);
		rs=cstmt.executeQuery();
		if(rs.next()){
		strMATAXml=rs.getString(1);
		}
		rs.close();
	    cstmt.close();
	}
	//System.out.println("strWSUrl----mo---->"+strWSUrl);
	//System.out.println("iresult outside---mo------>"+strMATAXml);
	if(!strWSUrl.equals("") && !strMATAXml.equals("")){
		strWSResponse=wsClientObj.pushStarsReqDetailsToMATA(strWSUrl,strMATAXml,"sendStarsReqDetailToERP",strTravelId,strTravellerSiteId);
	}
	
	if(!strERPWSUrl.equals("")){
		//for group/guest requset set empcode to 0 by manoj chand on 26 apr 2013
		/*if(strGroupReqFlag.equalsIgnoreCase("N")){
			strERPXml="<Root> <UnitCode>"+strTravellerSiteId+"</UnitCode> <ProjectCode>"+strTravelReqNo+"</ProjectCode> <projectDesc>"+strResonforTravel+"</projectDesc> <CreatedBy>"+strCuserId+"</CreatedBy> <EmpID>"+strEmpCode+"</EmpID> <amt>"+totalAmount+"</amt> <projectRemarks>"+strResonforTravel+"</projectRemarks></Root>";
		}else{
			strERPXml="<Root> <UnitCode>"+strTravellerSiteId+"</UnitCode> <ProjectCode>"+strTravelReqNo+"</ProjectCode> <projectDesc>"+strResonforTravel+"</projectDesc> <CreatedBy>"+strCuserId+"</CreatedBy> <EmpID></EmpID> <amt>"+totalAmount+"</amt> <projectRemarks>"+strResonforTravel+"</projectRemarks></Root>";
		}*/
		String strEmpCodeWS="STAR";
		if(strGroupReqFlag.equalsIgnoreCase("N")){
			strEmpCodeWS = strEmpCode;
		}
		//added on 22 May 2013 to fetch total amount and currency.
		strSql="SELECT * FROM DBO.[FN_GET_EXPENDITURE_WS] ("+strTravelId+",'"+strTrvType+"')";
		rs=null;
		rs = dbConBean.executeQuery(strSql);
		int rcount=0;
		strERPXml = "<Root>";
		while(rs.next()){
			rcount++;
			strERPXml = strERPXml + "<sendStarsReqDetailToERP><UnitCode>"+strTravellerSiteId+"</UnitCode><ProjectCode>"+strTravelReqNo+"</ProjectCode><projectDesc>"+strResonforTravel.replace("&", "")+"</projectDesc><CreatedBy>"+strCuserId+"</CreatedBy><EmpID>"+strEmpCodeWS+"</EmpID><amt>"+rs.getString("CUR_AMOUNT")+"</amt><Currency>"+rs.getString("CUR_NAME")+"</Currency><projectRemarks>"+strResonforTravel.replace("&", "")+"</projectRemarks><Travel_From_Dt>"+strDepDate+"</Travel_From_Dt><Travel_To_Dt>"+strReturnDate+"</Travel_To_Dt></sendStarsReqDetailToERP>";
		}
		strERPXml = strERPXml + "</Root>";
		
		if(rcount==0){
			strERPXml = "<Root><sendStarsReqDetailToERP><UnitCode>"+strTravellerSiteId+"</UnitCode><ProjectCode>"+strTravelReqNo+"</ProjectCode><projectDesc>"+strResonforTravel.replace("&", "")+"</projectDesc><CreatedBy>"+strCuserId+"</CreatedBy><EmpID>"+strEmpCodeWS+"</EmpID><amt>"+totalAmount+"</amt><Currency>"+strTA_Currency+"</Currency><projectRemarks>"+strResonforTravel.replace("&", "")+"</projectRemarks><Travel_From_Dt>"+strDepDate+"</Travel_From_Dt><Travel_To_Dt>"+strReturnDate+"</Travel_To_Dt></sendStarsReqDetailToERP></Root>";
		}
		//System.out.println("strERPXml--->"+strERPXml);
		strWSResponse=wsClientObj.pushStarsReqDetailsToERP(strCompanyName,strERPWSUrl,"sendStarsReqDetailToERP",strERPXml,strTravelId,strTravellerSiteId,strERPXmlParam);
	}
	}
	}catch(Exception e){
		wsErrormailObj.sendErrorMail("",e.getMessage(),"",strTravelId,"T_approveTravelRequisitions_Post.jsp",strTravellerSiteId);
	}
	
}//end if block of web service
}//end if block of approver approve request status check
}//end of strAlreadyApprove block
}//strCheckValue

}//end of for loop
dbConBean1.close();   //Close All Connection
%>
<SCRIPT LANGUAGE="JavaScript">
function lo()
{
alert(' <%=dbLabelBean.getLabel("message.approverequest.transaction",strsesLanguage)%> ');
}
</SCRIPT>

<body onLoad="document.frm.submit()" >
<%

//change on 07 March 2007 by sachin
String strPage = "";
if(strTravelType.equals("I"))
{
  strPage = "T_approveTravelRequisitions.jsp";
}
if(strTravelType.equals("D"))
{
  strPage = "T_approveTravelRequisitions_D.jsp";
}

String strFlag = request.getParameter("AllTravelPageFlag")==null ?"no" : request.getParameter("AllTravelPageFlag");
//System.out.println("strFlag--->"+strFlag);
if(strFlag.equals("yes"))
{
  strPage="T_approveTravelRequisitions_All.jsp";
}
%>
   <form name=frm action="<%=strPage%>" target="middle">
<%
%>
   <!--<form name=frm action="T_approveTravelRequisitions_D.jsp" target="middle">-->
<%
logger.info("Approve Travel Request End " +dateFormat.format(cal.getTime()));
logger.info("---------------**********---------------**********---------------**********---------------");
%>
<input type="hidden" name=travel_type value="<%=strTravelType%>"/>
</form>