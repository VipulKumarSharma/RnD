	<%
	/***************************************************
	*Copyright (C) 2000 MIND 
	*All rights reserved.
	*The information contained here in is confidential and 
	*proprietary to MIND and forms the part of the MIND 
	*CREATED BY		:	SACHIN GUPTA
	*Date			:   27/09/2006
	*Description	:	post Screen for APPROVAL
	*Modified By	:	****************
	*Project		: 	STAR
	
	*Modified By	: Manoj Chand
	*Date of Modification: 21 Feb 2012
	*Modification	: add one more parameter in procedure PROC_USER_APPROVAL_REQ1
	
	*Modified By			: Manoj Chand
	 *Date of modification	: 15 May 2012
	 *Modification			: add one parameter comments in PROC_USER_APPROVAL_REQ1
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 10 Jan 2013
	 *Modification			: Web Service Calling added to push data to mata when request is approve by all
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 03 Apr 2013
	 *Modification			: prevent approval and ws calling in case request is already approved.
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 09 May 2013
	 *Modification			: send empid='' to erp webservice when request is group/guest travel request.
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 22 May 2013
	 *Modification			: send total amount with Curreny to erp webservice.
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 29 July 2013
	 *Modification			: send empid='STAR' to erp webservice when request is group/guest travel request.
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 14 August 2013
	 *Modification			: Implement a check whether approver already has approved the request.
	 
	 *Modified By			: MANOJ CHAND
	 *Date of Modification  : 26 August 2013
	 *Modification			: add condition to check for pap approver approving request.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:27 Aug 2013
	 *Modification			:pass one parameter xmlparam string to erp webservice method.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:04 Oct 2013
	 *Modification			:pass one parameter company name to erp webservice method.
	**********************************************************/
	%>
	<%@ include  file="importStatement.jsp" %>
	<%@ page language="java" import="src.connection.PropertiesLoader,java.math.BigDecimal" %>
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
	<jsp:useBean id="wsClientObj" scope="page" class="wsclient.WSClient" />
	<jsp:useBean id="wsErrormailObj" scope="page" class="wsclient.errormail.WSerrormail" />
	<jsp:useBean id="mailDaoImpl" scope="page" class="src.dao.MailDaoImpl"/>
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<base target="middle">
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
	Connection con					=		null;			    // Object for connection
	CallableStatement cstmt			=		null;			// Object for Callable Statement
	ResultSet             rs,rs1    =       null;          
	//Create Connection
	//Class.forName(Sdbdriver);
	//con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
	con = dbConBean.getConnection();
	String	sSqlStr,strSql=""; // For sql Statements
	String strNewReqId		=request.getParameter("purchaseRequisitionId");
	String strTravellerId	=request.getParameter("traveller_Id");
	String strStatus		=request.getParameter("rad");
	String strTravelType	=request.getParameter("travel_type");
	
	String strComments		=request.getParameter("COMMENTS");
	String	strTravel	 =	 "";
	String	strPage	=	"";
	String  strOriginatorMailUserId = "";
	String  strHrMailUserId     = "";  
	String  strSiteId           = "";
	String  strBillingSite      = "";
	ArrayList aList             = new ArrayList();  
	
	String strMATAAirlineIn		=""; 
	String strMATACurrencyIn	=""; 
	String strMATAPriceIn		=""; 
	String strMATARemarks		=""; 
	String strnewStatus			=""; 
	
	String strTravelTypeMail    ="";
	String stMATAapproval		="";
	
	String strMATAAirlineFN		= ""; 
	String strMATACurrencyFN	= "";
	String strMATAPriceInFN		= "";
	String strMATARemarksFN     = "";
	
	//block to add MATA initial price for travel Ticket on 06 Nov 2009
	
	String strIsMATAintial = request.getParameter("MATAApproval");  
	//System.out.println("==========2==========="+strIsMATAintial);
	if(strIsMATAintial==null) 
	{
		strIsMATAintial="";
	}else { 
				strnewStatus="Approve";
		    stMATAapproval		=request.getParameter("MATAApproval"); //initial or Final 
		
			if(stMATAapproval.equals("initial")){					 
					strMATAAirlineIn	= request.getParameter("MATAAirlineIN"); 
					strMATACurrencyIn	= request.getParameter("currncey");
					strMATAPriceIn		= request.getParameter("MATApriceIN");
					strMATARemarks		= request.getParameter("MATARemaraksIN");

					if(strTravelType.equals("I")){
						strSql="UPDATE T_TRAVEL_DETAIL_INT SET TK_AIRLINE_NAME_MATA =N'"+strMATAAirlineIn+"' , "+"TK_AMOUNT_MATA =N'"+strMATAPriceIn+"' ,TK_REMARKS_MATA =N'"+strMATARemarks+"' WHERE TRAVEL_ID='"+strNewReqId+"'" ;
					}else{
						strSql="UPDATE T_TRAVEL_DETAIL_DOM SET TK_AIRLINE_NAME_MATA =N'"+strMATAAirlineIn+"' , "+"TK_AMOUNT_MATA =N'"+strMATAPriceIn+"' ,TK_REMARKS_MATA =N'"+strMATARemarks+"' WHERE TRAVEL_ID='"+strNewReqId+"'" ;
					}
					int updaterow=   dbConBean.executeUpdate(strSql);  
					
			}else{
					strMATAAirlineFN	= request.getParameter("MATAAirlineFN"); 
					strMATAPriceInFN		= request.getParameter("MATApriceFN");
					strMATARemarksFN		= request.getParameter("MATARemaraksFN");
					if(strTravelType.equals("I")){
						strSql="UPDATE T_TRAVEL_DETAIL_INT SET  TK_AIRLINE_NAME_FINAL =N'"+strMATAAirlineFN+"' , "+"TK_AMOUNT_FINAL =N'"+strMATAPriceInFN+"' ,TK_REMARKS_FINAL =N'"+strMATARemarksFN+"' WHERE TRAVEL_ID='"+strNewReqId+"'" ;
					}else{
						strSql="UPDATE T_TRAVEL_DETAIL_DOM SET TK_AIRLINE_NAME_FINAL =N'"+strMATAAirlineFN+"' , "+"TK_AMOUNT_FINAL =N'"+strMATAPriceInFN+"' ,TK_REMARKS_FINAL =N'"+strMATARemarksFN+"' WHERE TRAVEL_ID='"+strNewReqId+"'" ;
			        }
			 		int updaterow=   dbConBean.executeUpdate(strSql);  
			}
	} 
	
	if(strStatus.equalsIgnoreCase("RECEIVED"))
	{
	strPage	=	"T_requisitionMailOnReceiving.jsp";
	}
	
	if(strStatus.equalsIgnoreCase("CONFIRM"))
	{
	strPage	=	"T_requisitionMailOnConfirm.jsp";
	}
	
	%>
	<%
	//added by manoj chand on 03 April 2013 to check whether request is already approved before approving request.
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
		// adding a case to check for pap approver on 26 august 2013
		strSql ="SELECT CASE WHEN EXISTS(SELECT  1 from dbo.T_APPROVERS ta WHERE TRAVEL_ID = '"+strNewReqId+"'"+
				" AND CASE WHEN PAP_APPROVER<>0 THEN PAP_APPROVER ELSE APPROVER_ID END = "+Suser_id+" AND TRAVEL_TYPE = '"+strTravelType+"'"+
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
		//Procedure for update the aprove_status in the T_Approver
		//Change by manoj chand on 21 feb 2012 to add one more parameter in procedure PROC_USER_APPROVAL_REQ1
		//passing on parameter for comments on 07 may 2012 by manoj chand
	    cstmt=con.prepareCall("{?=call PROC_USER_APPROVAL_REQ1(?,?,?,?,?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strNewReqId );
		cstmt.setString(3, strTravellerId);
		cstmt.setString(4, strTravelType);
		cstmt.setString(5, Suser_id);
		cstmt.setString(6, strStatus.trim());
		cstmt.setString(7, "");
		cstmt.setString(8, strComments.trim());
		cstmt.execute();
		cstmt.close();
	
	    if(strStatus.equalsIgnoreCase("RECEIVED"))
	    {
			//Procedure for checking that all approver approve this requisition or not. If all approve then this procedure update the requisition travel_status_id 10 in T_Travel_Status table 
	        cstmt=con.prepareCall("{?=call PROC_CHECK_APPROVE_STATUS(?,?)}");
	        cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	        cstmt.setString(2, strNewReqId);
	        cstmt.setString(3, strTravelType);
	        cstmt.execute();
	        cstmt.close();
		}
		if(strStatus.equalsIgnoreCase("CONFIRM"))
	    {
			 //Procedure for change the travel_status_id 11 in T_TRAVEL_STATUS TABLE
			 cstmt=con.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS_BY_MATA(?,?,?)}");
	    	 cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			 cstmt.setString(2, strNewReqId);
			 cstmt.setString(3, strTravelType);
	         cstmt.setString(4, "11");  //Set Travel Status 11
	         cstmt.execute();
	         cstmt.close();
	    }
		
		//2th March 2007
		//commented by manoj chand on 15 may 2012 as comments are inserted through PROC_USER_APPROVAL_REQ1 procedure.
			/*cstmt=con.prepareCall("{?=call PROC_TRAVEL_REQ_ADDCOMMENTS(?,?,?,?)}");
			cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt.setString(2, strNewReqId);
			cstmt.setString(3, strComments.trim());
			cstmt.setString(4, Suser_id);
			cstmt.setString(5, strTravelType);
			cstmt.execute();
			cstmt.close();*/
	   //2th March 2007
	
	
	}
	catch(Exception e)
	{
	  System.out.println("Error in T_ConfirmRequisition_MATA_Post.jsp=============="+e);
	}
	
	if(strTravelType.equalsIgnoreCase("I"))
	{
	strTravel	=	"International Travel";
	}
	else
	{
	strTravel	=	"Domestic Travel";
	}
	
	%>
	
	<!--<jsp:include page="<%//=strPage%>" flush="true" >
	<jsp:param name="purchaseRequisitionId" value="<%//=strNewReqId.trim()%>"/>
	<jsp:param name="COMMENTS" value="<%//=strComments.trim()%>"/>
	<jsp:param name="rad" value="<%//=strStatus.trim()%>"/>
	<jsp:param name="ReqTyp" value="<%//=strTravel%>"/>
	</jsp:include>-->
	
	<%
	
	//---------------------------------------------------------------------------------------------------------------
	//added by manoj chand on 15 may 2012 to fetch traveller site id.
	String strTravellerSiteId = "";
	if(strTravel.equals("Domestic Travel"))
	{
		strSql = "SELECT SITE_ID FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strNewReqId+" AND STATUS_ID=10";
	}
	else
	{
		strSql = "SELECT SITE_ID FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strNewReqId+" AND STATUS_ID=10";
	}
	rs1 = dbConBean.executeQuery(strSql);
	if(rs1.next())
	{
		strTravellerSiteId			=	rs1.getString(1).trim();
		//System.out.println("strTravellerSiteId-tres->"+strTravellerSiteId);
	}
	rs1.close();
	//end here
	
	    if(strStatus.equalsIgnoreCase("RECEIVED"))
		{
             
			if(stMATAapproval.equals("initial")){	
				mailDaoImpl.sendRequisitionMailOnApproval(strNewReqId.trim(), strTravel, strComments.trim(), strTravellerSiteId, Suser_id, strsesLanguage, strCurrentYear, strMailCreatedate);
			%>
<%-- 				 <jsp:include page="T_requisitionMailOnApproval.jsp" flush="true" > --%>
<%-- 					<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/> --%>
<%-- 			        <jsp:param name="rad" value="<%=strStatus.trim()%>"/> --%>
<%-- 			        <jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/> --%>
<%-- 				    <jsp:param name="ReqTyp" value="<%=strTravel%>"/> --%>
<%-- 				     <jsp:param name="SiteId" value="<%=strTravellerSiteId %>"/> --%>
<%-- 			     </jsp:include> --%>
			<% 
            }else{  
            	 
			%>
			<jsp:include page="T_requisitionMailOnReceiving.jsp" flush="true" >
			<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
			<jsp:param name="COMMENTS" value="<%=strComments.trim()%>"/>
			<jsp:param name="rad" value="<%=strStatus.trim()%>"/>
			<jsp:param name="ReqTyp" value="<%=strTravel%>"/>
			</jsp:include>
			<%
            }
	
		}
		if(strStatus.equalsIgnoreCase("CONFIRM"))
		{
			//There are two case. if billing client is self then mail goes to Originator otherwise mail goes to hr in the case of receiving.
			if(strTravel.equals("Domestic Travel"))
			{
				//query for finding the dom billing site
				strSql = "SELECT BILLING_SITE, C_USERID, SITE_ID FROM T_TRAVEL_DETAIL_DOM WHERE TRAVEL_ID="+strNewReqId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
			}
			else
			{
				//query for finding the international billing site
				strSql = "SELECT BILLING_SITE, C_USERID, SITE_ID FROM T_TRAVEL_DETAIL_INT WHERE TRAVEL_ID="+strNewReqId+" AND STATUS_ID=10 AND APPLICATION_ID=1";			
			}
			rs1 = dbConBean.executeQuery(strSql);
			if(rs1.next())
			{
				strBillingSite		= rs1.getString("BILLING_SITE");
				strOriginatorMailUserId = rs1.getString("C_USERID");
				strSiteId           = rs1.getString("SITE_ID");
			}
			rs1.close();
			strSql	=	"SELECT USERID,DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID IN ('MATA') AND STATUS_ID=10 AND APPLICATION_ID=1 ";
	
			if(strBillingSite != null && !strBillingSite.equals("0"))              //0 for self option 
			{
				//after confirm mail goes to HR and originator because billing site is not self(0)
				strSql	=	"SELECT USERID,DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strSiteId+" AND ROLE_ID IN ('HR') AND STATUS_ID=10 AND APPLICATION_ID=1";
				rs1 = dbConBean.executeQuery(strSql);
				while(rs1.next())
				{
					strHrMailUserId     =	rs1.getString("USERID");
					aList.add(strHrMailUserId);
				}
				rs1.close();			
	
				Iterator itr =  aList.iterator();
				while(itr.hasNext())
				{
					strHrMailUserId   =  (String)itr.next();//change in mailUserId  ( strHrMailUserId)
						%>
							<jsp:include page="T_requisitionMailOnConfirm.jsp" flush="true"> 
								<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
								<jsp:param name="mailUserId" value="<%=strHrMailUserId%>"/>
								<jsp:param name="Comments" value="<%=strComments.trim()%>"/>
								<jsp:param name="ReqTyp" value="<%=strTravel%>"/>
							</jsp:include>
						<%          
				}
						%>
						<jsp:include page="T_requisitionMailOnConfirm.jsp" flush="true"> 
							<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
							<jsp:param name="mailUserId" value="<%=strOriginatorMailUserId%>"/>
							<jsp:param name="Comments" value="<%=strComments.trim()%>"/>
							<jsp:param name="ReqTyp" value="<%=strTravel%>"/>
						</jsp:include>
			
					<%
	            
			}
			else
			{
	
				//after confirm Mail Only goes to the originator because billing site is self(0)
	%>
				<jsp:include page="T_requisitionMailOnConfirm.jsp" flush="true"> 
					<jsp:param name="purchaseRequisitionId" value="<%=strNewReqId.trim()%>"/>
					<jsp:param name="mailUserId" value="<%=strOriginatorMailUserId%>"/>
					<jsp:param name="Comments" value="<%=strComments.trim()%>"/>
					<jsp:param name="ReqTyp" value="<%=strTravel%>"/>
				</jsp:include>	
	<%
				
			}
	
		}
		
	//code added by manoj chand on 10 jan 2013 to send data to web service.
	String strCallFlag=PropertiesLoader.config.getProperty("wscallflag");
	//System.out.println("strCallFlag----mi---->"+strCallFlag);
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
		if(strApproveStatus.equals("10")){
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
			//System.out.println("strSql--confirmMATA-->"+strSql);
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
		//System.out.println("strWSUrl-----mi--->"+strWSUrl);
	    //System.out.println("iresult outside----mi----->"+strMATAXml);
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
				strERPXml = strERPXml + "<sendStarsReqDetailToERP><UnitCode>"+strTravellerSiteId+"</UnitCode><ProjectCode>"+strTravelReqNo+"</ProjectCode><projectDesc>"+strResonforTravel.replace("&","")+"</projectDesc><CreatedBy>"+strCuserId+"</CreatedBy><EmpID>"+strEmpCodeWS+"</EmpID><amt>"+rs.getString("CUR_AMOUNT")+"</amt><Currency>"+rs.getString("CUR_NAME")+"</Currency><projectRemarks>"+strResonforTravel.replace("&","")+"</projectRemarks><Travel_From_Dt>"+strDepDate+"</Travel_From_Dt><Travel_To_Dt>"+strReturnDate+"</Travel_To_Dt></sendStarsReqDetailToERP>";
			}
			strERPXml = strERPXml + "</Root>";
			
			if(rcount==0){
				strERPXml = "<Root><sendStarsReqDetailToERP><UnitCode>"+strTravellerSiteId+"</UnitCode><ProjectCode>"+strTravelReqNo+"</ProjectCode><projectDesc>"+strResonforTravel.replace("&","")+"</projectDesc><CreatedBy>"+strCuserId+"</CreatedBy><EmpID>"+strEmpCodeWS+"</EmpID><amt>"+totalAmount+"</amt><Currency>"+strTA_Currency+"</Currency><projectRemarks>"+strResonforTravel.replace("&","")+"</projectRemarks><Travel_From_Dt>"+strDepDate+"</Travel_From_Dt><Travel_To_Dt>"+strReturnDate+"</Travel_To_Dt></sendStarsReqDetailToERP></Root>";
			}
			//System.out.println("strERPXml--->"+strERPXml);
			strWSResponse=wsClientObj.pushStarsReqDetailsToERP(strCompanyName,strERPWSUrl,"sendStarsReqDetailToERP",strERPXml,strNewReqId,strTravellerSiteId,strERPXmlParam);
		}
		}
		}catch(Exception e){
			wsErrormailObj.sendErrorMail("",e.getMessage(),"",strNewReqId,"T_ConfirmRequisitions_MATA_Post.jsp",strTravellerSiteId);
		}
	}
	}//IF TO CHECK FOR REQUEST IS ALREADY APPROVED BY USER
	}
	//-----------------------------------------	------------------------------------------------------------------------------
	%>
	
	
	<SCRIPT LANGUAGE="JavaScript">
	function lo()
	{
	
	if ("<%=strTravelType%>" == 'I') {
	document.frm.action ="T_approveTravelRequisitions.jsp?travel_type=I";
	}
	else if ("<%=strTravelType%>" == 'D') {
	document.frm.action ="T_approveTravelRequisitions_D.jsp?travel_type=D";
	}
	parent.close();
	}
	</SCRIPT>
	<base target="middle">
	<body onLoad="lo();document.frm.submit();" >
	<form name=frm  target="middle">
	  <input type=hidden name="purchaseRequisitionId" value="<%=strNewReqId%>">
	  <input type=hidden name="traveller_Id" value="<%=strTravellerId%>">
	  <input type=hidden name="travel_type" value="<%=strTravelType%>">
	</form>
	</body>
	
	
	<%
	 dbConBean.close();   //Close All Connection
	%>