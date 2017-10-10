	<!-- Header -->
	<%
	/***************************************************
	*Copyright (C) 2000 MIND 
	*All rights reserved.
	*The information contained here in is confidential and 
	*proprietary to MIND and forms the part of the MIND 
	*CREATED BY		:	ROHIT GANJOO
	*Date			:   06/09/2006
	*Description	:	APPROVAL SCREEN
	*Modification 			: Now Mail will go to MATA for tentative booking when unit head approve the requisition 
							:Change code for price analysis with mata and local travel agent on 23-Nov-09 byb shiv sharma 
	 *Reason of Modification: Suggested by MATA
	 *Date of Modification  : 20-02-2007
	 *Revision History		: by sachin Gupta
	 
	 *Modified By			: Manoj Chand
	 *Date of modification	: 21 feb 2012
	 *Modification			: add one more parameter in PROC_USER_APPROVAL_REQ1
	 
	 *Modified By			: Manoj Chand
	 *Date of modification	: 07 May 2012
	 *Modification			: add one parameter comments in PROC_USER_APPROVAL_REQ1
	 						: Change in query getting unit head flag.
	 						
	 *Modified By			: Manoj Chand
	 *Date of modification	: 10 Oct 2012
	 *Modification			: resolve issue of page refresh in chrome and safari
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :07 Feb 2013
	 *Description			:IE Compatibility Issue related to parent page not refresh after action taken from inside screen resolved.
     
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 10 Feb 2013
	 *Modification			: Web Service Calling added to push data to mata when request is approve by all
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 02 Apr 2013
	 *Modification			: stop calling of web service
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 14 August 2013
	 *Modification			: Implement a check whether approver already has approved the request.
	**********************************************************/
	%>
	<%@ page language="java" import="src.connection.PropertiesLoader,java.math.BigDecimal" %>
	<html>
	<head>
	<%@ include  file="importStatement.jsp" %>
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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<base target="middle">
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
	Connection con					=		null;			    // Object for connection
	ResultSet rs					=		null;			  // Object for ResultSet
	CallableStatement cstmt			=		null;			// Object for Callable Statement
	String	strSql	=	"";	 // query string
	con = dbConBean.getConnection();
	String	sSqlStr=""; // For sql Statements
	String strNewReqId		=request.getParameter("purchaseRequisitionId");
	String strTravellerId	=request.getParameter("traveller_Id");
	
	
	String strStatus		=request.getParameter("rad");
	String strTravelType	=request.getParameter("travel_type");
	String strComments		=request.getParameter("COMMENTS");
	String	strTravel		=	"";
	String	strPage			=	"";
	String	strOrderId		=	"";
	
	String	strReq			=	"";
	String strSql1			=   "";
		
	String strFinalAirline		="";
	String strFinalPrice		="";
	String strFinalremarks		="";
	String strflagforMataprice	=request.getParameter("flagforMataprice")==null?"y":request.getParameter("flagforMataprice");; 
	String finalbuyfrom			=""; 
	
	if(strflagforMataprice.equalsIgnoreCase("n")){ 
	
			 strFinalAirline	=request.getParameter("finalAirline");
			 strFinalPrice		=request.getParameter("finalPrice");
		 	 strFinalremarks	=request.getParameter("finalremarks");
		 	 finalbuyfrom		=request.getParameter("finalbuyer");
		 	 
			 if(strTravelType.equals("I"))
		      {
				strSql="UPDATE T_TRAVEL_DETAIL_INT SET Final_buyfrom=N'"+finalbuyfrom+"', TK_AIRLINE_NAME_FINAL =N'"+strFinalAirline+"' , "+"TK_AMOUNT_FINAL =N'"+strFinalPrice+"' ,TK_REMARKS_FINAL =N'"+strFinalremarks+"' WHERE TRAVEL_ID='"+strNewReqId+"'" ;
			  }else{
				strSql="UPDATE T_TRAVEL_DETAIL_DOM SET Final_buyfrom=N'"+finalbuyfrom+"', TK_AIRLINE_NAME_FINAL =N'"+strFinalAirline+"' , "+"TK_AMOUNT_FINAL =N'"+strFinalPrice+"' ,TK_REMARKS_FINAL =N'"+strFinalremarks+"' WHERE TRAVEL_ID='"+strNewReqId+"'" ;
		      }
		     int updaterow=   dbConBean.executeUpdate(strSql);  
		  
	 }
	
	//System.out.println("strTravelType--->"+strTravelType);
	if(strTravelType.equalsIgnoreCase("I")){
		strReq	=	"International Travel";
	 }else{
		strReq	=	"Domestic Travel";
	 }
	//System.out.println("strStatus--->"+strStatus);
	
	
	if(strStatus.equalsIgnoreCase("REJECT"))
	{
	strPage	=	"T_requisitionMailOnReject.jsp";
	}
	
	if(strStatus.equalsIgnoreCase("RETURNED FROM WORKFLOW"))
	{
	strPage	=	"T_requisitionMailOnReturn.jsp";
	}
	//if condition added by manoj chand on 03 may 2012 to send mail on passing the request by reviewer
	if(strStatus.equalsIgnoreCase("Pass"))
	{
	strPage	=	"T_requisitionMailOnPass.jsp";
	}
	    %>
	<%
	//added by manoj chand on 14 august 2013 to check whether request is already approved before approving request.
	  String strAlreadyApprove="no";
	  String strTravelStatus = null;
	  strSql="select ltrim(rtrim(Travel_status_id)) as Travel_status_id from dbo.T_TRAVEL_STATUS tts where travel_id='"+strNewReqId+"' and tts.TRAVEL_TYPE='"+strTravelType+"' AND tts.STATUS_ID=10";
	  rs = dbConBean.executeQuery(strSql);
	  if(rs.next()){
	    	strTravelStatus=rs.getString("Travel_status_id");
	    	if(strTravelStatus!=null && !strTravelStatus.equals("") && strTravelStatus.equals("10")){
	    		strAlreadyApprove="yes";
	    	}
	  }
	  rs.close();
	  
	if(strAlreadyApprove.equals("no")){
		
		//QUERY ADDED BY MANOJ CHAND ON 14 AUGUST 2013 TO CHECK WHETHER APPROVER ALREADY HAS APPROVED THE REQUEST 
		strSql ="SELECT CASE WHEN EXISTS(SELECT  1 from dbo.T_APPROVERS ta WHERE TRAVEL_ID = '"+strNewReqId+"'"+
				" AND APPROVER_ID = "+Suser_id+" AND TRAVEL_TYPE = '"+strTravelType+"'"+
				" AND (RECEIVED_DATE IS NOT NULL OR YEAR(RECEIVED_DATE)<>1900) AND APPROVE_STATUS=0"+
				" AND STATUS_ID=10) THEN 'Y' ELSE 'N' END AS APP_FLAG";
		rs = null;
		String strAlreadyApprovebyuser="N";
		rs = dbConBean.executeQuery(strSql);
		  if(rs.next()){
			  strAlreadyApprovebyuser=rs.getString("APP_FLAG");
		  }
		  rs.close();
		  
 if(strAlreadyApprovebyuser.equals("Y")){
	 
	try
	{
		//changed by manoj chand on 21 feb 2012 to add one parameter blank
		/*System.out.println("strNewReqId------->"+strNewReqId);
		System.out.println("strTravellerId------->"+strTravellerId);
		System.out.println("strTravelType------->"+strTravelType);
		System.out.println("Suser_id------->"+Suser_id);
		System.out.println("strStatus------->"+strStatus);
		System.out.println("strComments------->"+strComments);*/
		//passing on parameter for comments on 07 may 2012 by manoj chand
							cstmt=con.prepareCall("{?=call PROC_USER_APPROVAL_REQ1(?,?,?,?,?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt.setString(2, strNewReqId );
							cstmt.setString(3, strTravellerId);
							cstmt.setString(4, strTravelType);
							cstmt.setString(5, Suser_id);
							cstmt.setString(6, strStatus.trim());
							cstmt.setString(7, "");
							cstmt.setString(8, strComments);
							cstmt.execute();
							cstmt.close();
							

							if(strTravelType.equalsIgnoreCase("I")){
								strTravel	=	"International Travel";
							 }else{
								strTravel	=	"Domestic Travel";
							}
							
					       // new block addded on 11 nov 2009
							if(strflagforMataprice.equalsIgnoreCase("n"))
							   { 
								if(strTravelType.equals("I"))
								   		{
											 strSql1="delete from T_approvers "+
											"where travel_id='"+strNewReqId+"' and travel_type='i' "+
											"and role='MATA' and approve_status='0' ";
								       }else{
								    	strSql1="delete from T_approvers "+
										"where  travel_id='"+strNewReqId+"' and travel_type='D' "+
										"and role='MATA' and approve_status='0' ";
								       }
								 if(finalbuyfrom.equalsIgnoreCase("Locally")) 
								     {
										%>
											<jsp:include page="T_MailToMATAforUserdesicion.jsp" flush="true" >
											<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
											<jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
											<jsp:param name="rad" value="<%=strStatus.trim()%>"/>
											<jsp:param name="ReqTyp" value="<%=strTravel%>"/>
											</jsp:include>
										<%
										
										int updaterowinT_approver=   dbConBean.executeUpdate(strSql1);
								   	   }
							 }
	
							//Procedure for checking that all approver approve this requisition or not.
							//If all approve then this procedure update the requisition travel_status_id 10 in T_Travel_Status table
							//if condition added by manoj chand on 03 may 2012 not to execute these two procedure during pass.
						if(!strStatus.equalsIgnoreCase("Pass"))
						{
	                	 	 cstmt=con.prepareCall("{?=call PROC_CHECK_APPROVE_STATUS(?,?)}");
	                		 cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	                		 cstmt.setString(2, strNewReqId);
	                		 cstmt.setString(3, strTravelType);
	                		 cstmt.execute();
	                		 cstmt.close();
							//2th March 2007
						//commented by manoj chand on 04 May 2012 as comments are adding through proc_insert_approvers
						/*	cstmt=con.prepareCall("{?=call PROC_TRAVEL_REQ_ADDCOMMENTS(?,?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt.setString(2, strNewReqId);
							cstmt.setString(3, strComments.trim());
							cstmt.setString(4, Suser_id);
							cstmt.setString(5, strTravelType);
							cstmt.execute();
							cstmt.close();*/
						}
					
	}
	catch(Exception e)
	{
	System.out.println("Error in proc in t_fmrequisitionApproveByUser.jsp");
	e.printStackTrace();
	}

	//get the orderId from t_approver table of the approver
	strSql	=	"select  max(order_id) AS ORDER_ID from t_approvers where approve_status=10 and  approver_id="+Suser_id+" and travel_type='"+strTravelType+"'  and  travel_id="+strNewReqId;
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
	if(strTravelType != null && strTravelType.equals("D"))
	{
		strSql = "SELECT SITE_ID FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strNewReqId+" AND STATUS_ID=10";
	}
	else if(strTravelType != null && strTravelType.equals("I"))
	{
		strSql = "SELECT SITE_ID FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strNewReqId+" AND STATUS_ID=10";
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
			   " where userid= (SELECT  APPROVER_ID FROM T_APPROVERS TA WHERE TA.TRAVEL_ID='"+strNewReqId+"' AND TA.TRAVELLER_ID='"+strTravellerId+"' AND TA.TRAVEL_TYPE='"+strTravelType+"'"+ 
			   " and ORDER_ID = (SELECT max(ORDER_ID) FROM T_APPROVERS  WHERE approve_status =10 and TRAVEL_ID='"+strNewReqId+"' AND TRAVELLER_ID='"+strTravellerId+"' AND TRAVEL_TYPE='"+strTravelType+"'))"+
			   " and site_id='"+strTravellerSiteId+"' and status_id=10 and unit_head=1";
	   
	   	rs = dbConBean.executeQuery(strSql);
		if(rs.next())
		{
			strIsUnitHead			=	rs.getString(1).trim();			
		}
		rs.close();
	}
	//System.out.println("strSql==unithead=="+strSql);
	//--------------------------------End- Added by Sachin Gupta on 4/24/2007-----------------------------------------------------------------
	
	// System.out.println("strIsUnitHead====123==SSSasasasasasSSSSSSSSSSSS===");
	if(strStatus.equalsIgnoreCase("Approve") && strIsUnitHead.equals("1")  && !SuserRole.equalsIgnoreCase("MATA"))
	{  
	%> 
		<!-- commeted by shiv on 3/12/2007 open   -->
	  <%--   
	    <jsp:include page="T_IntimationToMATA.jsp" flush="true" >   
		<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
		<jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
		<jsp:param name="rad" value="<%=strStatus.trim()%>"/>
		<jsp:param name="ReqTyp" value="<%=strTravel%>"/>
		</jsp:include>  
	
	          --%> 
	   <!-- commeted by shiv on 3/12/2007 close   -->
	
	   <!-- code added by sachin on 3/13/2007 open     //new  added param by shiv on  04-May-07 "strTravellerSiteId"  -->
		<jsp:include page="T_MailToHRandAC.jsp" flush="true" >
			<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
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
		if(strTravelType.equals("I"))
		{
			strSql = "SELECT ISNULL(MANAGER_ID,'-1') AS MANAGER_ID,ISNULL(HOD_ID,'-1') AS HOD_ID,ISNULL(BILLING_CLIENT,'') AS BILLING_CLIENT, BILLING_SITE FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strNewReqId;
		}
		else if(strTravelType.equals("D"))
		{
			strSql = "SELECT ISNULL(MANAGER_ID,'-1') AS MANAGER_ID,ISNULL(HOD_ID,'-1') AS HOD_ID,ISNULL(BILLING_CLIENT,'') AS BILLING_CLIENT, BILLING_SITE FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strNewReqId;
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
		  { //  one parma added by shiv on  04-May-07   "strTravellerSiteId" 
	 %>
	 <!-- commeted by shiv on 2/18/2009 open   -->
	 <%--
			<jsp:include page="T_MailToHRandAC.jsp" flush="true" >
				<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
				<jsp:param name="ReqTyp" value="<%=strReq%>"/>
				<jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
				<jsp:param name="RoleId" value="HR&AC"/>
				<jsp:param name="mailSubject" value="Intimation Mail After First Approval"/>
				<jsp:param name="mailMessage" value=""/>
		          <jsp:param name="strTravellerSiteId" value="<%=strTravellerSiteId%>"/> 
			</jsp:include>	
	
			--%>
		<!-- commeted by shiv on 2/18/2009 close   -->
	
	<%
		  }
	
		}
	}
	
	
	//Added by sachin 3/14/2007 end
	if(SuserRole!=null && SuserRole.equalsIgnoreCase("MATA")) 
	{
	%>
			<jsp:include page="T_requisitionMailOnReceiving.jsp" flush="true" >
			<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
	        <jsp:param name="rad" value="<%=strStatus.trim()%>"/>
	        <jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
		    <jsp:param name="ReqTyp" value="<%=strTravel%>"/>
	     </jsp:include>
	
	<%      
	}
	else 
	{
			if(finalbuyfrom.equalsIgnoreCase("Locally")) {
		   }
		else
		   {
			if(strStatus.equalsIgnoreCase("Approve")) {
				mailDaoImpl.sendRequisitionMailOnApproval(strNewReqId.trim(), strReq, strComments.trim(), strTravellerSiteId, Suser_id, strsesLanguage, strCurrentYear, strMailCreatedate);
			} else {
	 		%>
				 <jsp:include page="<%=strPage%>" flush="true" >
					<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
			        <jsp:param name="rad" value="<%=strStatus.trim()%>"/>
			        <jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
				    <jsp:param name="ReqTyp" value="<%=strReq%>"/>
				    <jsp:param name="SiteId" value="<%=strTravellerSiteId %>"/>
				    
			     </jsp:include>
			<%
			}
		   }
	}
	%>
	
	<!--<jsp:include page="<%//=strPage%>" flush="true" >
	<jsp:param name="purchaseRequisitionId" value="<%//=strNewReqId.trim()%>"/>
	<jsp:param name="COMMENTS" value="<%//=strComments.trim()%>"/>
	<jsp:param name="rad" value="<%//=strStatus.trim()%>"/>
	<jsp:param name="ReqTyp" value="<%//=strTravel%>"/>
	</jsp:include>-->
	
	<%
	//code added by manoj chand on 10 feb 2013 to send data to web service.
	//code commented by manoj chand on 03 april 2013 because this page is not used by MATA to approve request.
	/*String strCallFlag=PropertiesLoader.config.getProperty("wscallflag");
	if(strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
		String strApproveStatus="";
		String strWSUrl="",strERPWSUrl="",strMATAXml="",strERPXml="",strWSResponse="";
		String strTravelReqNo="",strResonforTravel="",strCuserId="",strEmpCode="";
		BigDecimal totalAmount=null;
		rs=null;
		
		try{
		strSql="select ltrim(rtrim(Travel_status_id)) as Travel_status_id from dbo.T_TRAVEL_STATUS tts where travel_id='"+strNewReqId+"' and tts.TRAVEL_TYPE='"+strTravelType+"' AND tts.STATUS_ID=10";
		rs = dbConBean.executeQuery(strSql);
		if(rs.next()){
			strApproveStatus=rs.getString("Travel_status_id");
		}
		rs.close();
		if(strApproveStatus.equals("10")){
			if(strTravelType.equalsIgnoreCase("D")){
				strSql= "select mc.MATA_WS_URL,mc.ERP_WS_URL,ttdd.TRAVEL_REQ_NO,ttdd.REASON_FOR_TRAVEL,ttdd.C_USERID,mu.EMP_CODE,ttdd.TOTAL_AMOUNT from m_site"+
						" inner join dbo.T_TRAVEL_DETAIL_DOM ttdd on m_site.SITE_ID=ttdd.SITE_ID"+
						" inner join dbo.M_USERINFO mu on mu.USERID=ttdd.TRAVELLER_ID "+
						" inner join dbo.M_COMPANY mc on mc.CID=m_site.COMPANY_ID"+
						" where mc.STATUS_ID=10 and m_site.STATUS_ID=10 and ttdd.STATUS_ID=10 and mu.STATUS_ID=10 and ttdd.TRAVEL_ID='"+strNewReqId+"'";
			}
			if(strTravelType.equalsIgnoreCase("I")){
				strSql= "select mc.MATA_WS_URL,mc.ERP_WS_URL,ttdi.TRAVEL_REQ_NO,ttdi.REASON_FOR_TRAVEL,ttdi.C_USERID,mu.EMP_CODE,ttdi.TOTAL_AMOUNT  from m_site"+ 
						" inner join dbo.T_TRAVEL_DETAIL_INT ttdi on m_site.SITE_ID=ttdi.SITE_ID"+
						" inner join dbo.M_USERINFO mu on mu.USERID=ttdi.TRAVELLER_ID "+
						" inner join dbo.M_COMPANY mc on mc.CID=m_site.COMPANY_ID"+
						" where mc.STATUS_ID=10 and m_site.STATUS_ID=10 and ttdi.STATUS_ID=10 and mu.STATUS_ID=10 and ttdi.TRAVEL_ID='"+strNewReqId+"'";
			}
			//System.out.println("strSql-FM-->"+strSql);
			rs=null;
			rs = dbConBean.executeQuery(strSql);
			if(rs.next()){
				strWSUrl=rs.getString("MATA_WS_URL");
				strERPWSUrl=rs.getString("ERP_WS_URL");
				strTravelReqNo=rs.getString("TRAVEL_REQ_NO");
				strResonforTravel=rs.getString("REASON_FOR_TRAVEL");
				strCuserId=rs.getString("C_USERID");
				strEmpCode=rs.getString("EMP_CODE");
				totalAmount=new BigDecimal(rs.getString("TOTAL_AMOUNT"));
			}
			rs.close();
		
		if(!strWSUrl.equals("")){
			rs=null;
			String strConID=PropertiesLoader.config.getProperty("conid");
		    cstmt=con.prepareCall("{?=call SPG_TRAVEL_REQUISITION_DTL(?,?,?)}");
		    cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		    cstmt.setString(2, strNewReqId);
		    cstmt.setString(3, strTravelType);
		    cstmt.setString(4, strConID);
		    rs=cstmt.executeQuery();
		    if(rs.next()){
		    	strMATAXml=rs.getString(1);
		    	}
		    rs.close();
	        cstmt.close();
		}
		//System.out.println("strWSUrl-----ni--->"+strWSUrl);
	    //System.out.println("iresult outside----ni----->"+strMATAXml);
		if(!strWSUrl.equals("") && !strMATAXml.equals("")){
			strWSResponse=wsClientObj.pushStarsReqDetailsToMATA(strWSUrl,strMATAXml,"sendStarsReqDetailToERP",strNewReqId,strTravellerSiteId);
		}
		
		if(!strERPWSUrl.equals("")){
			strERPXml="<Root> <UnitCode>"+strTravellerSiteId+"</UnitCode> <ProjectCode>"+strTravelReqNo+"</ProjectCode> <projectDesc>"+strResonforTravel+"</projectDesc> <CreatedBy>"+strCuserId+"</CreatedBy> <EmpID>"+strEmpCode+"</EmpID> <amt>"+totalAmount+"</amt> <projectRemarks>"+strResonforTravel+"</projectRemarks></Root>";
			strWSResponse=wsClientObj.pushStarsReqDetailsToERP(strERPWSUrl,"sendStarsReqDetailToERP",strERPXml,strNewReqId,strTravellerSiteId);
		}
		}
		}catch(Exception e){
			wsErrormailObj.sendErrorMail("",e.getMessage(),"",strNewReqId,"T_fmRequisitionApproveByUser.jsp");
		}
	}//END IF
	*/
	
	//code added by Gurmeet Singh on 17 feb 2016 to send data to web service.
	String strCallFlag=PropertiesLoader.config.getProperty("wscallflag");
	if(strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
		String strApproveStatus="",strCompanyName="";
		String strWSUrl="",strERPWSUrl="",strMATAXml="",strERPXml="",strWSResponse="",strERPXmlParam="";
		String strTravelReqNo="",strResonforTravel="",strCuserId="",strEmpCode="",strGroupReqFlag="N",strTA_Currency="INR";
		// Added By GURMEET SINGH 
		String strDepDate="", strReturnDate="";
		BigDecimal totalAmount=null;
		rs=null;
		try{
		strSql="select ltrim(rtrim(Travel_status_id)) as Travel_status_id from dbo.T_TRAVEL_STATUS tts where travel_id='"+strNewReqId+"' and tts.TRAVEL_TYPE='"+strTravelType+"' AND tts.STATUS_ID=10";
		rs = dbConBean.executeQuery(strSql);
		if(rs.next()){
			strApproveStatus=rs.getString("Travel_status_id");
		}
		rs.close();
		
		//code added by manoj chand on 03 apr 2013 to check whether user is last approver of request of not.
		String strLastApprover = "";
		strSql="SELECT CASE WHEN EXISTS(SELECT 1 FROM T_APPROVERS WHERE ORDER_ID=(SELECT MAX(ORDER_ID) FROM T_APPROVERS"+ 
			" WHERE TRAVEL_ID="+strNewReqId+" AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10)"+
			" AND APPROVE_STATUS=10 AND APPROVER_ID="+Suser_id+" AND STATUS_ID=10 AND TRAVEL_ID="+strNewReqId+" AND TRAVEL_TYPE='"+strTravelType+"')"+
			" THEN 'Y' ELSE 'N' END";
		rs=null;
		rs = dbConBean.executeQuery(strSql);
		if(rs.next()){
			strLastApprover=rs.getString(1);
		}
		rs.close();
		//System.out.println("strSql- post-->"+strSql);
		
		
		if(strApproveStatus.equals("10") && strLastApprover.equals("Y")){
			if(strTravelType.equalsIgnoreCase("D")){
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
						" AND TTDD.TRAVEL_ID='"+strNewReqId+"' "+
						" GROUP BY MC.COMPANY_NAME,MC.MATA_WS_URL,MC.ERP_WS_URL,TTDD.TRAVEL_REQ_NO,"+
						" TTDD.REASON_FOR_TRAVEL,TTDD.C_USERID,MU.EMP_CODE,TTDD.TOTAL_AMOUNT,"+
						" TTDD.GROUP_TRAVEL_FLAG,TTDD.TA_CURRENCY,mc.ERP_XML,ttdd.TRAVEL_DATE,TRJDD.TRAVEL_DATE";
			}
			if(strTravelType.equalsIgnoreCase("I")){
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
						" AND ttdi.TRAVEL_ID='"+strNewReqId+"' "+
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
			cstmt.setString(2, strNewReqId);
			cstmt.setString(3, strTravelType);
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
			strWSResponse=wsClientObj.pushStarsReqDetailsToMATA(strWSUrl,strMATAXml,"sendStarsReqDetailToERP",strNewReqId,strTravellerSiteId);
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
			strSql="SELECT * FROM DBO.[FN_GET_EXPENDITURE_WS] ("+strNewReqId+",'"+strTravelType+"')";
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
			strWSResponse=wsClientObj.pushStarsReqDetailsToERP(strCompanyName,strERPWSUrl,"sendStarsReqDetailToERP",strERPXml,strNewReqId,strTravellerSiteId,strERPXmlParam);
		}
		}
		}catch(Exception e){
			wsErrormailObj.sendErrorMail("",e.getMessage(),"",strNewReqId,"T_fmRequisitionApproveByUser.jsp",strTravellerSiteId);
		}
		
	}//end if block of web service
	
 }
}//if block to check for request is approved by all or not
	
	//Added by sachin on 7 th March 2007
	String strFlag = request.getParameter("AllTravelPageFlag")==null ?"no" : request.getParameter("AllTravelPageFlag");
	 %>
	
	<SCRIPT LANGUAGE="JavaScript">
	function lo()
	{
		var x;
		var reqid='<%=strNewReqId%>';
		var travellerid='<%=strTravellerId%>';
		if ("<%=strTravelType%>" == 'I') {
		//document.frm.action ="T_approveTravelRequisitions.jsp?travel_type=I";
		x='T_approveTravelRequisitions.jsp?travel_type=I&purchaseRequisitionId='+'<%=strTravellerId%>'+'&traveller_Id='+'<%=strTravellerId%>';
		}
		else if ("<%=strTravelType%>" == 'D') {
		//document.frm.action ="T_approveTravelRequisitions_D.jsp?travel_type=D";
		x='T_approveTravelRequisitions_D.jsp?travel_type=D&purchaseRequisitionId='+'<%=strTravellerId%>'+'&traveller_Id='+'<%=strTravellerId%>';
		}
	
		if("<%=strFlag%>"=='yes')
		{
			//document.frm.action ="T_approveTravelRequisitions_All.jsp";
			x='T_approveTravelRequisitions_All.jsp?travel_type='+'<%=strTravelType%>'+'&purchaseRequisitionId='+'<%=strTravellerId%>'+'&traveller_Id='+'<%=strTravellerId%>';
		}	
		//document.frm.submit();
		window.opener.refreshParent(x);
		parent.close();
	}
	</SCRIPT>
	<base target="middle">
	<body onLoad="lo();" >
	<form name=frm   target="middle">
	  <input type=hidden name="purchaseRequisitionId" value="<%=strNewReqId%>">
	  <input type=hidden name="traveller_Id" value="<%=strTravellerId%>">
	  <input type=hidden name="travel_type" value="<%=strTravelType%>">
	</form>
	</body>