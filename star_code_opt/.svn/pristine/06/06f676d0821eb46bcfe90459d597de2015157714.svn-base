	<%
	/********************************************************************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author									:Abhinav Ratnawat
	 *Date of Creation 				:08 September 2006
	 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved10/3/2006
	 *Project	  					:STAR
	 *Operating environment	:Tomcat, sql server 2000 
	 *Description 						:This is first jsp file  for create the Travel Requsition
	 *Modification 			: 1.Add Currency field for choosing different currency.
	                          2.Add Identity Proof No on 3/14/2007 
							  3. Code Not in Use
							  4. For Two Unit Heads belonging to the same site
							  5. For Two Unit Heads belonging to the same site with site_id check 
	 *Reason of Modification: 1.change suggested by MATA
							  2.
							  3.Code Review
							  4.Special case handling refer Issue_Log_STARS_Latest point no.81
							  5.Adding Site_id Check
	                          6.Added new Identity field on 22-Oct-07 by shiv  
							  7.code Added by Shiv Sharma  on 26-Oct-07  for new prefered time for intermediate journey 
							  8 Code added by Shiv sharma  on  22 Nov -2007 for inserting identity proof no in m_userinfor if it is not exits.
							  9 Code change for showing age(Yr,month,days  ) to user but not storing--         on 03-Mar-08 by shiv sharma     
							 10:added on 19-Jun-08 for settin group flag as N by   for domestice travel    by shiv sharma
							 11:added code for checking if appro ver is exits in defualt approver list on 19-01-2009 
							 12: new code added for removing traveller name from approver list if he/she Exist on 17 - Mach -2009 by shiv sharma 
							 13 ://added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
							 14.Commented Credit card no as it is not required   to show any user on 10-03-2010 by shiv sharma 
	                                   
	 *Date of Modification  :  3-Nov-2006 
							 2.
							 3. 30-Apr-2007
							 4. 27-Apr-2007
							 5. 08-Apr-2007
	
	 *Modified By	        :1.SACHIN GUPTA
	                         2.Shiv sharma
							 3. Gaurav Aggarwal 
							 4. Gaurav Aggarwal 
							 5. Gaurav Aggarwal 
	 *Editor									:Editplus
	 
	 *Modification			:Modification in the approvers flow.i.e Unit Head then AVP/ VP and then COO.
	 *Date of modification  :05 april 2011
	 *Modified By     		:Manoj Chand
	 
	 *Modification			:modify workflow as per selected site
	 *Date of modification  :12 Oct 2011
	 *Modified By     		:Manoj Chand
	
	 *Modification			:Not remove mata from workflow when mata is creating self request.  
	 *Date of modification  :05 March 2012
	 *Modified By     		:Manoj Chand
	 
	 *Modification				:Save the value of board members in table  
	 *Modified by				:Manoj Chand
	 *Date of Modification		:28 Mar 2012
	 
	 *Modification				:change in query to implement according to traveller workflow for smr  
	 *Modified by				:Manoj Chand
	 *Date of Modification		:16 Apr 2012
	 
	 *Modification				:Add status_id=10 in query which is checking default approver for unithead flag.
	 *Modified by				:Manoj Chand
	 *Date of Modification		:17 Apr 2012
	 
	 *Modification				:Multilingual functionality added
	 *Modified by				:Manoj Chand
	 *Date of Modification		:24 May 2012
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:01 Aug 2012
	 *Description				:Pass Cost Centre parameter to proc_insert_t_travel_detail_dom
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:19 OCT 2012
	 *Description				:IMPLEMENT SITE WISE FLAG TO SHOW BOARD MEMBER IN SMP
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:22 Mar 2013
	 *Description				:change position of board member from second last to after approver 1 and 2 in approver list
	 
	 *Modified By				:Manoj Chand
	 *Date of Modification		:23 July 2013
	 *Modification				:Mandatory selection of approval level 1 and 2 for mssl site. approver name will come one time in approver list
	 ********************************************************************************************************/
	%>
	<html>
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%@ page import="src.travelBean.BreakUp" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/> 
	<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
	
	<SCRIPT language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	
	<style type="text/css">
	<!--
	.style2 {font-size: 10px; font-weight: bold; color: #FF7D00; }
	-->
	</style>
	<head>
	<title>Untitled Document</title>
	
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<%
	//Global Variables declared and initialized

	request.setCharacterEncoding("UTF-8");
	String strSql									 =  null;            // String for Sql String
	Connection objCon						=  null;            //Object for Connection 
	Connection objCon1					=  null;            //Object for Connection 
	ResultSet rs,rs1,rs2					=  null;            // Object for ResultSet
	CallableStatement objCstmt	    =  null;		    // Object for Callable Statement
	Statement stmt;					
	src.connection.DbConnectionBean db11 = null;
	String strSiteId									=  "";
	String strTravellerId							=  "";
	String strDesigId								=  "";
	String strAge										=  "";
	String strPhone								=  "";
	String strFFNo									=  "";
	String strSex										=  "";
	String strFFNo1										=  "";
	String strFFNo2										=  "";
	
	
	//new 17-02-2007
	String strAirLineName		=	request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
	String strAirLineName1		=	request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
	String strAirLineName2		=	request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");
	
	
	String strPlace					=	request.getParameter("place")== null ? "" : request.getParameter("place");
	String strForTatkaalRequired	=	request.getParameter("forTatkaalRequired")== null ? "0" : request.getParameter("forTatkaalRequired");
	String strForCoupanRequired		=	request.getParameter("forCoupanRequired")== null ? "0" : request.getParameter("forCoupanRequired");
	String strRetTatkaalRequired	=	request.getParameter("retTatkaalRequired")== null ? "0" : request.getParameter("retTatkaalRequired");
	String strRetCoupanRequired		=	request.getParameter("retCoupanRequired")== null ? "0" : request.getParameter("retCoupanRequired");
	String strIdentityProof			=	request.getParameter("identityProof")== null ? "" : request.getParameter("identityProof");
	//added by shiv on  3/14/2007 
	String strIdentityProofno			=	request.getParameter("identityProofno")== null ? "" : request.getParameter("identityProofno");
	
	
	
	//
	
	///22-02-2007
	String strCARD_HOLDER_NAME ="";
	
	strCARD_HOLDER_NAME      =  request.getParameter("cardHolderName")==null ?"" :request.getParameter("cardHolderName") ; 
	
	///22-02-2007
	
	
	
	String strMeal									=  "";                           
	String strDepCity								=  "";                              
	
	String strDepCity1								=  "";                              
	
	
	String strDepDate						    =  "";                              
	String strDeptTime							=  "";                                
	String strDepartMode						=  "";                                  
	String strDepartAirLineName	    =  "";
	String strDepartClass						=  "";
	String strArrivalCity							=  "";
	
	String strArrivalCity1							=  "";
	
	String strReturnDate						=  "";                                 
	String strArrivalTime						=  "";	                                 
	String strArrivalMode						=  "";                                  
	String strArrivalAirLineName			=  "";
	String strArrivalClass						=  "";
	String strSelectManager					=  "";
	String strManagerId							=  "";
	String strHodId									=  "";
	String strBoardMemberId     	=  "";
	String strHidAppFlag			=  "";
	String strHidAppShowBMFlag	="";
	String strTransitType						=  "";
	String strBudget								=  "";
	String strBudgetCurrency				= "";
	String strCheckIn								=  "";
	String strCheckOut							=  "";
	String strOtherComment				=  "";
	String strFlag									=  "";
	String strTravelType						=  "D";     //D for Domestic
	String strReturnType						=  "";      // if user filled the return date then return type is 2 otherwise 1
	String strJourneyOrder					=  "1";
	String strTravelStatusId					=  "1";  
	String strApproverId							=  "";   
	String strInterimId							=	"";
	
	String strUserRole              =  ""; 
	
	String strMessage = "";
	String strUrl     = "";
	String strReasonForTravel       =  "";
	String strReasonForSkip         =  ""; 
	
	String strRoleofTraveler   ="";
	String strIDofTraveler     =""; 
	 
	
	
	String strCARD_TYPE = request.getParameter("CARD_TYPE"); 
	//blocked by shiv on  09-03-2010 
	String strCARD_NUMBER1 = "";//request.getParameter("CARD_NUMBER1");
	String strCARD_NUMBER2 = "";//request.getParameter("CARD_NUMBER2");
	String strCARD_NUMBER3 = "";//request.getParameter("CARD_NUMBER3");
	String strCARD_NUMBER4 = "";//request.getParameter("CARD_NUMBER4");
	
	String strCARD_EXP_DATE =request.getParameter("CARD_EXP_DATE");
	String strCVV_NUMBER = request.getParameter("CVV_NUMBER");
	
	
	//flag varibles
	int iSuccess1  = 0 ;
	int iSuccess2  = 0 ;
	int iSuccess3  = 0;
	int iSuccess4  = 0;
	int iSuccess5  = 0;
	int iSuccess6  = 0;
	
	//ArrayList
	String strApproveStatus			 =  "0"; 
	String strApproverOrderId       =  "";   
	String strApproverRole			 =  ""; 
	ArrayList approverList				 =  new ArrayList();
	ArrayList approverList1			 =  new ArrayList();
	ArrayList l1 								 =	  new ArrayList();
	int intCounter							 =	  0;
	
	String strTravelReqId				 =  "";
	String strTravelId						 =  "";
	String strTravelReqNo			 =  "";
	String strActionFlag					 =  "";
	String strIdentityIDNo				="";
	String strIdentityID					="";		
	String strIdentityIDNoOld			="";
	String  strIdentityIDOld			="";
	
	//added on 08 jan 2009 
	String strprefferedSeatRet ="";
	String strprefferedSeatfwd ="";
	String strTicketRefund     ="";
	String strTicketRefundfwd ="";	
	String strTicketRefundRtd ="";	
	String strWorkFlowName			= "";
	strWorkFlowName=SSstrSplRole;
	String strCostCentre="0";
	
	 //strSiteId									=  request.getParameter("site");
	strSiteId                =  (request.getParameter("site")==null || request.getParameter("site").equals("null")) ? strSiteIdSS : request.getParameter("site") ;
	
	strTravellerId								=  request.getParameter("userName");
	//System.out.println("strTravellerId--dom-->"+strTravellerId);
	strDesigId									=  request.getParameter("designation");
	
	 //code change for showing age(Yr,month,days  ) to user but not storing-------on 03-Mar-08 by shiv sharma     
	strAge										=  request.getParameter("actualAge");
	 
	strPhone									=  request.getParameter("phoneNo");
	strCostCentre			   =  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
	strFFNo										=  request.getParameter("FFNo");
	// code added 
	
	strFFNo1										=  request.getParameter("FFNo1");
	strFFNo2										=  request.getParameter("FFNo2");
	
	//System.out.println("strFFNo1 --> "+strFFNo1 + "strFFNo2-- >  "+strFFNo2);
	
	// code ends
	
	strSex										=  request.getParameter("sex");
	strMeal										=  request.getParameter("meal");
	strDepCity									=  request.getParameter("departCity");
	
	strDepCity1									=  request.getParameter("departCity1")==null?"":request.getParameter("departCity1");
	
	
	
	strDepDate									=  request.getParameter("departDate");
	strDeptTime									=  request.getParameter("departTime");
	strDepartMode								=  request.getParameter("departMode");
	strDepartAirLineName						=  request.getParameter("departAirLineName");
	strDepartClass								=  request.getParameter("departClass");
	strArrivalCity								=  request.getParameter("arrivalCity");
	strArrivalCity1								=  request.getParameter("arrivalCity1")==null?"":request.getParameter("arrivalCity1");
	
	
	strReturnDate								=  request.getParameter("returnDate");
	strArrivalTime								=  request.getParameter("arrivalTime");
	strArrivalMode								=  request.getParameter("arrivalMode");
	strArrivalAirLineName						=  request.getParameter("arrivalAirLineName");
	strArrivalClass								=  request.getParameter("arrivalClass");
	strSelectManager							=  request.getParameter("selectManger");
	strManagerId								=  request.getParameter("manager");
	strHodId									=  request.getParameter("hod");
	strBoardMemberId		 =  request.getParameter("boardmember");
	strHidAppFlag			 =  request.getParameter("hidAppLvl3flg");
	strHidAppShowBMFlag		=	request.getParameter("hidAppLvl3showbmflg");
	//System.out.println("strBoardMemberId--t_td post--->"+strBoardMemberId);
	//strTransitType								=  request.getParameter("transit").equals("-1") ? null : request.getParameter("transit");
	strTransitType								=  request.getParameter("transit");
	strBudget        							=  request.getParameter("budget");
	strBudgetCurrency                           =  request.getParameter("currency");
	strCheckIn									=  request.getParameter("checkin");
	strCheckOut									=  request.getParameter("checkout");
	strOtherComment								=  request.getParameter("others");
	
//System.out.println("strManagerId------->"+strManagerId);
//System.out.println("strHodId------->"+strHodId);
	//new code
	if(strManagerId != null && strManagerId.equalsIgnoreCase("-1"))
	{
		strManagerId = null;
	}
	if(strHodId != null && strHodId.equalsIgnoreCase("-1"))
	{
		strHodId = null;
	}
	if(strBoardMemberId != null && strBoardMemberId.equalsIgnoreCase("-1"))
	{
		strBoardMemberId = null;
	}
	
	if(strManagerId == null && strHodId == null)
	{
		//strSelectManager     =  "skip";
	}
	strReasonForTravel							=  request.getParameter("reasonForTravel");
	strReasonForSkip						    =  request.getParameter("reasonForSkip");
	//
	
	strFlag										=  request.getParameter("flag1");
	strTravelReqId								=  request.getParameter("travelReqId");    // from hidden field
	strTravelId									=  request.getParameter("travelId");       // from hidden field
	strTravelReqNo								=  request.getParameter("travelReqNo");    // for hidden field
	strInterimId								=  request.getParameter("interimId");
	
	
	//added by shiv on 22 -oct -2007
	strIdentityID								=	 request.getParameter("identityProof");   
	strIdentityIDNo								=	 request.getParameter("identityProofno");   
	
	
	//Added new on 09 jan 2008 
	strprefferedSeatfwd							=	 request.getParameter("prefferedSeatFwd");   
	strprefferedSeatRet							=	 request.getParameter("prefferedSeatRet"); 
	
	strTicketRefundfwd 							=	 request.getParameter("ticketRefundfwd"); 
	strTicketRefundRtd 							=	 request.getParameter("ticketRefundrtd");
	
	/*System.out.println("strprefferedSeatfwd===08 jan==11==========="+strprefferedSeatfwd);
	System.out.println("strprefferedSeatRet=====08 jan==11========="+strTicketRefundfwd);
	
	
	System.out.println("strprefferedSeatRet=====08 jan====22======="+strprefferedSeatRet);
	System.out.println("strprefferedSeatRet=====08 jan====22======="+strTicketRefundRtd);
	
	*/
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
		
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strSiteId, "0");		
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strTravellerId, strSiteId, "0");		
	} 
	if(strManagerId != null && !strManagerId.equalsIgnoreCase("-1") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strManagerId, strSiteId, "1");
	} 
	if(strHodId != null && !strHodId.equalsIgnoreCase("-1") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strHodId, strSiteId, "2");
	} 
	if(strBoardMemberId != null && !strBoardMemberId.equalsIgnoreCase("-1") && !strBoardMemberId.equalsIgnoreCase("-2") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBoardMemberId, strSiteId, "3");
	}
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthCostCenter(strCostCentre, strSiteId);		
	}
	if(!strUserAccessCheckFlag.equals("420") && !strTravelId.equals("new")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "D", Suser_id);		
	}
	
	if(strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();
		dbConBean2.close();
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_TravelDetail_Dom_Post.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {
	
	//CODE ADDED BY MANOJ CHAND ON 16 APRIL 2012 TO FETCH WORKFLOW NAME OF TRAVELLER
	strSql="SELECT SP_ROLE FROM M_USERINFO WHERE M_USERINFO.USERID="+strTravellerId+" AND M_USERINFO.STATUS_ID=10";
	 rs = dbConBean.executeQuery(strSql);
		if(rs.next()){  
			strWorkFlowName= rs.getString("SP_ROLE");	 		
		 }
	rs.close();
	
	
	//  code to check if identity proof is alreday exits in M_userinfor then added by shiv on 22 Nov 2007   open
	
	strSql="SELECT   IDENTITY_ID, IDENTITY_NO FROM   M_USERINFO (NOLOCK) WHERE USERID = "+strTravellerId+" AND STATUS_ID = 10";
	rs	=	dbConBean.executeQuery(strSql);
	while(rs.next())
		{
			strIdentityIDOld =rs.getString("IDENTITY_ID"); 
	    strIdentityIDNoOld=rs.getString("IDENTITY_NO"); 
		}
	
	// code to check if identity proof is alreday exits in M_userinfor then added by shiv on 22 Nov 2007   close 
	
	
	
	
	if( strIdentityID ==null)
	{
	strIdentityID="";
	}
	
	if( strIdentityIDNo ==null)
	{
	strIdentityIDNo="";
	}
	
	if(strTravelReqId != null && strTravelReqId.equals("new"))
	{
	    strActionFlag   = "insert";
	}
	else
	{
		strActionFlag   = "update"; 
	}
	
	
	
	
	if(strReturnDate !=null && strReturnDate.equals(""))
	{
		strReturnType       =  "1"; 
	}
	else
	{
	    strReturnType       =  "2"; 
	}
	
	if ("".equals(strDepDate)) {
		strDepDate	=	null;	
	}
	if ("".equals(strReturnDate)) {
		strReturnDate	=	null;
	}
	if ("".equals(strCheckIn)){
		strCheckIn	=	null;
	}
	if ("".equals(strCheckOut)) {
		strCheckOut	=	null;
	}
	
	
	String strTravel_Req_Id  = "";
	String strTravel_Id  = "";
	String strTravel_Req_No = "";
	 
	if (strInterimId!= null && !"".equals(strInterimId) && !strInterimId.equals("null")) 
	// need to be change for adding new timing --shiv sharama 25-Oct-07 
	{
		strSql = "SELECT LTRIM(RTRIM(TRAVEL_FROM)) AS TRAVEL_FROM, LTRIM(RTRIM(TRAVEL_TO)) AS TRAVEL_TO, TRAVEL_DATE, LTRIM(RTRIM(TRAVEL_MODE)) AS TRAVEL_MODE, LTRIM(RTRIM(MODE_NAME)) AS MODE_NAME, LTRIM(RTRIM(TRAVEL_CLASS))  AS TRAVEL_CLASS,ISNULL(TIMINGS,1) AS  TIMINGS FROM T_INTERIM_JOURNEY (NOLOCK) WHERE PARENT_ID ="+strInterimId+" AND TRAVEL_TYPE = 'D' AND APPLICATION_ID =1";
		 
	
		 // System.out.println("------------------------>>>"+strSql);
	 
	
		rs	=	dbConBean.executeQuery(strSql);
		while(rs.next())
		{
			l1.add(new String(rs.getString("TRAVEL_FROM")));
			l1.add(new String(rs.getString("TRAVEL_TO")));
			l1.add(new String(rs.getString("TRAVEL_DATE")));
			l1.add(new String(rs.getString("TRAVEL_MODE")));
			l1.add(new String(rs.getString("MODE_NAME")));
			l1.add(new String(rs.getString("TRAVEL_CLASS")));	
			l1.add(new String(rs.getString("TIMINGS")));	// Added new for prefered timings  for domestic journey 
		}
		rs.close();
	}
	
	if(strActionFlag!=null && strActionFlag.equals("insert")) 
	{
		// Travel_Req_Id 
		strTravel_Req_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_REQ_ID")+"";
		// Travel_Id 
		strTravel_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_DOM")+"";
		
		//added by manoj chand on 12 oct 2011 to show request number based on selected site
		if(!strSiteId.trim().equalsIgnoreCase(strSiteIdSS.trim())){
			String strsiteName="";
			strSql="select site_name from m_site where site_id="+strSiteId;
			//System.out.println("str DOM POST-->"+strSql);
			 rs = dbConBean.executeQuery(strSql);
				if(rs.next()){  
					strsiteName = rs.getString("site_name");	 		
				 }
			strTravel_Req_No = "TEMP/"+strsiteName.trim()+ "/DOM/" + strTravel_Id;
			//System.out.println("strTravel_Req_No---->"+strTravel_Req_No);
			rs.close();
		}else{		
		strTravel_Req_No = "TEMP/"+strSiteFullName.trim()+"/DOM/"+strTravel_Id;
		}
	  
		try
		{
			  objCon               =  dbConBean.getConnection(); 
			  objCon.setAutoCommit(false);
	
			  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_MST(?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Req_Id);
			  //CHANGE BY MANOJ
			  objCstmt.setString(3, strSiteId);             //set the current user Site Id
			  objCstmt.setString(4, Suser_id);                //set the current user Login UserId
			  objCstmt.setString(5, strTravelType);
			  iSuccess1   =  objCstmt.executeUpdate();
			  objCstmt.close();
	
		  	  //System.out.println("**********************1*");	  
			  //PROCEDURE for INSERT data in T_TRAVEL_DETAIL_DOM
			  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,   ?,?,?,?,?,?,     ?,?   ,?,?)}");  
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Req_Id);
			  objCstmt.setString(3, strTravel_Id);
			  objCstmt.setString(4, strTravel_Req_No);
			  objCstmt.setString(5, strSiteId);             //set the Traveller Site Id
			  objCstmt.setString(6, strTravellerId);        //set the Traveller Id
			  objCstmt.setString(7, strAge);                //set the Traveller Age
			  objCstmt.setString(8, strSex);                //set the Traveller Sex
			  objCstmt.setString(9, strDepDate);            //set the Traveller Departure Date
			  objCstmt.setString(10, strMeal);              //set the Traveller Meal
			  objCstmt.setString(11, strTransitType);             //set the Traveller Hotel Required
			  objCstmt.setString(12, strBudget);       //set the Traveller Hotel Budget
			  objCstmt.setString(13, strBudgetCurrency);     //set the Traveller Hotel Budget Currency
			  objCstmt.setString(14, strCheckIn);      //set the Traveller Remark(in table)
			  objCstmt.setString(15, strCheckOut);             //set the current user Login UserId
			  objCstmt.setString(16, strOtherComment);             //set the current user Login UserId
			  objCstmt.setString(17, strReturnType);        //set the Traveller Return Type if(user fill the return date then Return Type is 2 otherwise 1
			  objCstmt.setString(18, Suser_id);                //set the current user Login UserId
			  objCstmt.setString(19, strSelectManager);             //set the select Approver radio button (manual or automatic)
			  objCstmt.setString(20, strManagerId);             //set the select Approver radio button (manual or automatic)
	      	  objCstmt.setString(21, strHodId);             //set the select Approver radio button (manual or automatic)
	  		  objCstmt.setString(22, strCARD_TYPE); 
	
	
			  //22-02-2007  
			  objCstmt.setString(23,strCARD_HOLDER_NAME);
	          //22-02-2007
	
	
			  objCstmt.setString(24, strCARD_NUMBER1); 
			  objCstmt.setString(25, strCARD_NUMBER2); 
			  objCstmt.setString(26, strCARD_NUMBER3); 
			  objCstmt.setString(27, strCARD_NUMBER4); 
			  objCstmt.setString(28, strCVV_NUMBER); 
			  objCstmt.setString(29, strCARD_EXP_DATE); 
			  objCstmt.setString(30, strReasonForTravel); 
	  		  objCstmt.setString(31, strReasonForSkip); 
	
	
	          //ADDED SIX ADDITIONAL INFORMATION 17-02-2007 SACHIN
	   		  objCstmt.setString(32, strPlace); 	
	   		  objCstmt.setString(33, strForTatkaalRequired); 
	   		  objCstmt.setString(34, strForCoupanRequired); 
	  		  objCstmt.setString(35, strRetTatkaalRequired); 
			  objCstmt.setString(36, strRetCoupanRequired); 
	  		 
			  objCstmt.setString(37, strIdentityProof); 
	           /// added by shiv on 3/14/2007
			  objCstmt.setString(38, strIdentityProofno); 
			  objCstmt.setString(39, "N");              /// added on 19-Jun-08 for settin group flag as N by   for domestice travel
			  objCstmt.setString(40,strBoardMemberId);
			  objCstmt.setInt(41, Integer.parseInt(strCostCentre));
			  objCstmt.setString(42, null);
			  iSuccess2   =  objCstmt.executeUpdate();
	
			  objCstmt.close();
			  
		  	  //System.out.println("**********************2*");  
	              
			  //PROCEDURE for INSERT data in T_JOURNEY_DETAILS_DOM
			  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?  ,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Id);
			  objCstmt.setString(3, strDepCity);             //set the Traveller Departure City Name(TRAVEL_FROM)
			  objCstmt.setString(4, strArrivalCity);             //set the Traveller Arrival City Namei(TRAVEL_TO)
			  objCstmt.setString(5, strDepDate);             //set the Traveller Departure Date
			  objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
			  objCstmt.setString(7, strDepartMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
			  objCstmt.setString(8, strDepartAirLineName);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
			  objCstmt.setString(9, strDepartClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
			  objCstmt.setString(10, strDeptTime);          //set the Travel Preferred Time e.g. Morning,evening etc.
			  objCstmt.setString(11, Suser_id);              //set the current user Login UserId
			  
			  objCstmt.setString(12, strprefferedSeatfwd);  //added new on 09 jan 2009 by shiv sharma 
			  objCstmt.setString(13, strTicketRefundfwd);  //added new on 09 jan 2009 by shiv sharma
			  objCstmt.setInt(14, 0);
			  
			  iSuccess3   =  objCstmt.executeUpdate();
			  objCstmt.close();
			  
		  	  //System.out.println("*********************3*");
			  //PROCEDURE for INSERT data in T_RET_JOURNEY_DETAILS_DOM
			  objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?  ,?,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Id);
			  objCstmt.setString(3, strDepCity1);             //set the Traveller Return Departure City Name(RETURN_FROM)
			  objCstmt.setString(4, strArrivalCity1);             //set the Traveller Return Arrival City Name(RETURN_TO)
			  objCstmt.setString(5, strReturnDate);             //set the Traveller Departure Date
			  objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to
			  objCstmt.setString(7, strArrivalMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
			  objCstmt.setString(8, strArrivalAirLineName);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
			  objCstmt.setString(9, strArrivalClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
			  objCstmt.setString(10, strArrivalTime);          //set the Travel Preferred Time e.g. Morning,evening etc.
			  objCstmt.setString(11, Suser_id);              //set the current user Login UserId
			  objCstmt.setString(12, strprefferedSeatfwd);  //added new on 09 jan 2009 by shiv sharma 
			  objCstmt.setString(13, strTicketRefundRtd);  //added new on 09 jan 2009 by shiv sharma 
			  objCstmt.setInt(14, 0);
			  iSuccess4   =  objCstmt.executeUpdate();
			  objCstmt.close();
	
	
			  //PROCEDURE for INSERT data in T_TRAVEL_STATUS
			  objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_STATUS(?,?,?,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Req_Id);
			  objCstmt.setString(3, strTravel_Id);
			  objCstmt.setString(4, strTravelStatusId);      //set the Travel Status Id(1-Temp, 2-Permanent, 3-Return, 4-Rejected, 6-Canceled, 10-Approved by All)
			  objCstmt.setString(5, strTravelType);          //set the Travel Type(I-international, D-Domestic)
			  iSuccess5   =  objCstmt.executeUpdate();
			  objCstmt.close();
	
			  objCon.commit(); //commit the query
			  objCon.setAutoCommit(true);
	          //System.out.println("intSuccess is======="+iSuccess1+" "+iSuccess2+" "+iSuccess3+" "+iSuccess4+" "+iSuccess5);
	
			if(iSuccess1 > 0 &&  iSuccess2 >0 && iSuccess3 > 0 && iSuccess4 > 0  && iSuccess5 > 0) 
			{
				//System.out.println("inside if block");
	
	
				// UPDATE M_USERINFO TABLE 
				// QUERY  CHANGED BY SHIV ON 22-Oct-07 \
				//code cahnged by shiv on 22 Nov 2007 for adding IDENTITY_ID and IDENTITY_NO  in M_userinfro incase of it is not there
				  stmt = 	objCon.createStatement();
				  if (strIdentityIDOld==null || strIdentityIDOld.equals("-1") || strIdentityIDOld.equals("0")) 
			            {
				        strSql = "UPDATE M_USERINFO SET  IDENTITY_ID='"+strIdentityID+"',IDENTITY_NO='"+strIdentityIDNo+"', CONTACT_NUMBER='"+strPhone+"',FF_NUMBER=N'"+strFFNo+"',FF_NUMBER1=N'"+strFFNo1+"',FF_NUMBER2=N'"+strFFNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"' WHERE USERID ="+strTravellerId ;
				        //System.out.println("strSql -1->"+strSql);
				  }else {
				  strSql = "UPDATE M_USERINFO SET  CONTACT_NUMBER='"+strPhone+"',FF_NUMBER=N'"+strFFNo+"',FF_NUMBER1=N'"+strFFNo1+"',FF_NUMBER2=N'"+strFFNo2 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"' WHERE USERID ="+strTravellerId ;
				  //System.out.println("strSql -2->"+strSql);
				  }
	
				  int iupdate = stmt.executeUpdate(strSql);
	
				// update T_INTERIM_JOURNEY
				  if(strInterimId != null && !strInterimId.equals("") && !strInterimId.equals("null") )
				  {
					stmt = 	objCon.createStatement();
					strSql = "UPDATE T_INTERIM_JOURNEY SET TRAVEL_ID='"+strTravel_Id+"' WHERE PARENT_ID ="+ strInterimId;
					int  iupdate1 = stmt.executeUpdate(strSql);
				  }	
	
				//PROCEDURE for INSERT data in T_JOURNEY_DETAILS_DOM for break up journey
				 if (strInterimId != null && !"".equals(strInterimId) && !strInterimId.equals("null"))
				 {
					int z = 0;	
					int n = 2;	
					for (int k = 0 ; k < l1.size()/6; k++) {
					  	  //System.out.println("**********************4*");
						  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?   ,?,?)}"); 
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id);
						  objCstmt.setString(3, (String)l1.get(z++));             //set the Traveller Departure City Name(TRAVEL_FROM)
						  objCstmt.setString(4, (String)l1.get(z++));             //set the Traveller Arrival City Namei(TRAVEL_TO)
						  objCstmt.setString(5, (String)l1.get(z++));             //set the Traveller Departure Date
						  objCstmt.setInt(6, n++);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
						  objCstmt.setString(7, (String)l1.get(z++));         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
						  objCstmt.setString(8, (String)l1.get(z++));      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
						  objCstmt.setString(9, (String)l1.get(z++));        //set the Travel Class Name(in int value), e.g. First class, Business class 
						  objCstmt.setString(10, (String)l1.get(z++));     
						  //set the Travel Preferred Time e.g. Morning,evening etc---- by Shiv sharma. on 25-Oct-07
						  objCstmt.setString(11, Suser_id);              //set the current user Login UserId
						  
						  objCstmt.setString(12, strprefferedSeatfwd);  //added new on 09 jan 2009 by shiv sharma
						  objCstmt.setString(13, "n");  //added new on 09 jan 2009 by shiv sharma 
						  objCstmt.setInt(14, 0);
						  iSuccess3   =  objCstmt.executeUpdate();
						  objCstmt.close();						
					}		
				}
	
				//PROCEDURE for INSERT data in T_APPROVERS
				//Get the new Approve_Id from the T_Travel_Mst Table
				String strApprove_Id  = "";
				strApprove_Id  =  dbUtilityBean.getNewId("T_APPROVERS","APPROVE_ID")+"";
	
				 if(strSelectManager != null && strSelectManager.equals("manual"))
				 {
					//6th March 2007 --start--
					String strTravellerRole  = "";
					String strUnitHead       = "0";          //0 for no and 1 for yes
					strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId; 	
					rs     = dbConBean1.executeQuery(strSql);
					if(rs.next())
					{
						 strTravellerRole = rs.getString("ROLE_ID");
						 //strUnitHead	  = rs.getString("UNIT_HEAD");	
						 //System.out.println("Role id ========"+strTravellerRole);
						 if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
						 {
							approverList.clear();
						 }
										
							//System.out.println("approver List======="+approverList);
							//System.out.println("strUnitHead======="+strUnitHead);
					}
					rs.close();	
	
	//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
				  strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS (NOLOCK) where userid="+strTravellerId+" and site_id="+strSiteId+" and status_id=10 and unit_head=1";
				  rs = dbConBean1.executeQuery(strSql);
				  if(rs.next())
				  {
					strUnitHead			=	rs.getString(1).trim();			
				  }
				  rs.close();
	//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
					
					//added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
					if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
					{
						//approverList.clear();
						strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
						rs     = dbConBean1.executeQuery(strSql);
						while(rs.next())
						{
	
							  strUserRole = rs.getString("USERROLE");
							 if(strUserRole != null && strUserRole.equalsIgnoreCase("MATA"))
							 {
								approverList.add(rs.getString("APPROVER_ID"));	
								approverList.add(strUserRole);  
							 }				 
						}
						rs.close();	
					}
					else
					{					
					//6th March 2007 -- end--
						if(strManagerId != null)
						{
							approverList.add(strManagerId);
							approverList.add("WORKFLOW");
						}
						if(strHodId != null)
						{
							//if condition added on 23 july 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
							if(!approverList.contains(strHodId)){
								approverList.add(strHodId);
								approverList.add("WORKFLOW");
							}
						}
						
						//added by manoj chand on 22 mar 2013 to add board member after approver 1 and 2
						 if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-2") && !strBoardMemberId.equalsIgnoreCase("-1")){
							approverList.add(strBoardMemberId);
							approverList.add("WORKFLOW");
						 } 
						
						strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE = 'D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
//System.out.println("strSql-----1--->"+strSql);						
						rs     = dbConBean1.executeQuery(strSql);
						while(rs.next())
						{
							 String strTempApproverId =  rs.getString("APPROVER_ID").trim();
							 strUserRole = rs.getString("USERROLE");
							 //if traveller id is unit head of the site then it would not be appear in the approver list.	
							 if(strUnitHead.equalsIgnoreCase("1") && strTravellerId.equals(strTempApproverId))	
							 {
							 }
							 //@Gaurav 27-Apr-2007 For Two Unit Heads belonging to the same site.
							 //STATUS_ID=10 ADDED BY MANOJ CHAND ON 17 APRIL 2012
								 String strQuery="Select Unit_Head from USER_MULTIPLE_ACCESS (NOLOCK) where USERID="+strTempApproverId+" AND SITE_ID="+strSiteId+" AND UNIT_HEAD=1 AND STATUS_ID=10 ORDER BY 1";
								 rs1     = dbConBean2.executeQuery(strQuery);							 
								 if(strUnitHead.equalsIgnoreCase("1") && rs1.next()) {													
								}
					        //End
							 else
							 {
										// added code for checking if appro ver is exits in defualt approver list on 19-01-2009  
//System.out.println("strTempApproverId--------->"+strTempApproverId);
//System.out.println("approverList------------>"+approverList);
										    if(approverList.contains(strTempApproverId)){  
											  // approverList.remove(strTempApproverId); 
					 						  // approverList.remove("WORKFLOW");
										    	int j = approverList.indexOf(strTempApproverId);
										    	int k=j+1;
	
												if (j == k - 1) {
													approverList.remove(j);
													approverList.remove(j);
												}
								             }	
											approverList.add(strTempApproverId);
											if(strUserRole != null && strUserRole.equalsIgnoreCase("OR"))
											{
												strUserRole = "DEFAULT";
											}
											approverList.add(strUserRole);  
								   		
							 } rs1.close();						
						}
						rs.close();	
					}// end of else 6th march 2007
				 }
	
				
	//
	
	
	
	//new code added for removing traveller name from approver list if he/she Exist on 17 - March -2009 by shiv sharma 
	
	
	 strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_DOM AS TTDI (NOLOCK)  INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
	 		  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
		
		
			   rs     = dbConBean1.executeQuery(strSql);
			   while(rs.next())
			   {
				strRoleofTraveler=rs.getString("ROLE_ID");
				strIDofTraveler=rs.getString("TRAVELLER_ID");
			   }
			   
			   if(strRoleofTraveler.equalsIgnoreCase("OR"))
				{
				   strRoleofTraveler = "DEFAULT";
				}
	
	   if(strManagerId== null || !strManagerId.equals(strIDofTraveler) )
	   {
	 	   if (strHodId==null ||  !strHodId.equals(strIDofTraveler))
	 	   { 
	 		//ROLE != MATA CONDITION ADDED BY MANOJ CHAND ON 05 MARCH 2012 TO SHOW MATA AS APPROVER FOR MATA'S REQUEST
			   if(approverList.contains(strIDofTraveler) && !strRoleofTraveler.trim().equalsIgnoreCase("MATA"))
			     {
				   int i=approverList.indexOf(strIDofTraveler);
				 	//System.out.println("i---12->"+i);
				     approverList.remove(i);
				     approverList.remove(i);
				   //approverList.remove(strIDofTraveler);  
				   //approverList.remove(strRoleofTraveler);
			   }
	 	   }
	   }
	//System.out.println("--------- ------------000--------------------------------");
				 
	 //ADDED BY MANOJ CHAND ON 28 MARCH 2012 TO ADD BOARD MEMBER IN SECOND LAST POSITION IN APPROVER LIST
	   if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-2") && !strBoardMemberId.equalsIgnoreCase("-1")){
		/*   int s=approverList.size();
		   String x= (String) approverList.get(s-1);
			String y= (String) approverList.get(s-2);
			approverList.remove(s-1);
			approverList.remove(s-2);
			approverList.add(strBoardMemberId);
			approverList.add("WORKFLOW");
			approverList.add(y);
			approverList.add(x);*/
	   }
	
				 Iterator itr =  approverList.iterator();
				  while(itr.hasNext())
				  {
					 intCounter++;  
					 strApprove_Id       = dbUtilityBean.getNewId("T_APPROVERS","APPROVE_ID")+""; 
					 strApproverId       = (String) itr.next();
					 strApproverRole     = (String)itr.next(); 
					 strApproverOrderId  = intCounter+"";
/*System.out.println("int counter is----->"+intCounter);
System.out.println("strApproverId----->"+strApproverId);
System.out.println("strApproverRole----->"+strApproverRole);*/
					 db11                 = new src.connection.DbConnectionBean();  //Create a new Object of DbConnectionBean
					 objCon1              = db11.getConnection();                                    
					 objCstmt             = objCon1.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
					 objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					 objCstmt.setString(2, strApprove_Id);            //set the Approve Id      
					 objCstmt.setString(3, strTravel_Id);             //set the Travel Id    
					 objCstmt.setString(4, strSiteId);                //set the Traveller Site Id  
					 objCstmt.setString(5, strTravellerId);           //Set the Traveller Id
					 objCstmt.setString(6, strTravelType);            //Set the TravelType 
				 
					 objCstmt.setString(7, strApproverId);            //Set the Approver Id
					 objCstmt.setString(8, strApproveStatus);         //Set the Approve Status(0-no approve, 10-approve, 3-return, 4-rejected)
					 objCstmt.setString(9, strApproverOrderId);       //Set the Approver Order Id in which  order approver approve the requsition
					 objCstmt.setString(10, strApproverRole);         //Set the Approver Role
					 objCstmt.setString(11, Suser_id);                //Set the Login user id 
	
				   
					 iSuccess6   =  objCstmt.executeUpdate();
					 objCstmt.close();
					 objCon1.close();
					 if(iSuccess6 == 0)
						 break;
				  }
				  strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
			}//end of if
			else
			{
				objCon.rollback();
				strTravel_Id = null;
				strMessage = dbLabelBean.getLabel("message.global.notsaved",strsesLanguage);
			}
		}
		catch(Exception e)
		{
		  strMessage = dbLabelBean.getLabel("message.global.notsaved",strsesLanguage);
		  System.out.println("Error in T_Travel_Dom_Post.jsp=="+e);
		}
		/*if(iSuccess1 > 0 &&  iSuccess2 >0 && iSuccess3 > 0 && iSuccess4 > 0  && iSuccess5 > 0 && iSuccess6 > 0) 
		{
			System.out.println("Data inserted successfully");
			objCon.commit();   
	
		}
		else
		{
		objCon.rollback();
		}*/
	} 
	else
	{
		//System.out.println("----------else block --------------");
		strTravel_Req_Id   = strTravelReqId;
	    strTravel_Id       = strTravelId;   
	    strTravel_Req_No   = strTravelReqNo; 
		try
		{
	
		//PROCEDURE for DELETE DATA FROM THE T_TRAVEL_DETAIL_INT, T_JOURNEY_DETAILS_INT, T_RET_JOURNEY_DETAILS_INT AND T_APPROVERS
		  objCon               =  dbConBean.getConnection(); 
	
		  // update userinfo table
		  //QUERY CHANGEDV  BY SHIV ON 22-Oct-07
	
	      //code cahnged by shiv on 22 Nov 2007 for adding IDENTITY_ID and IDENTITY_NO  in M_userinfro incase of it is not there
		  stmt = 	objCon.createStatement();
		  if (strIdentityIDOld==null || strIdentityIDOld.equals("-1") || strIdentityIDOld.equals("0")) 
			  {
			  		 strSql = "UPDATE M_USERINFO SET IDENTITY_ID='"+strIdentityID+"',IDENTITY_NO='"+strIdentityIDNo+"', CONTACT_NUMBER='"+strPhone+"',FF_NUMBER=N'"+strFFNo+"',FF_NUMBER1=N'"+strFFNo1+"',FF_NUMBER2=N'"+strFFNo2+"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"' WHERE USERID ="+strTravellerId+" and status_id=10" ;
			  		//System.out.println("strSql----0.1-->"+strSql);
		  }else {
			  strSql = "UPDATE M_USERINFO SET CONTACT_NUMBER='"+strPhone+"',FF_NUMBER=N'"+strFFNo+"',FF_NUMBER1=N'"+strFFNo1+"',FF_NUMBER2=N'"+strFFNo2+"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"' WHERE USERID ="+strTravellerId+" and status_id=10" ;
			  //System.out.println("strSql----0.2-->"+strSql);
		  }
		  int iupdate = stmt.executeUpdate(strSql);
		 
			// update T_INTERIM_JOURNEY
			/*if(strInterimId != null && !strInterimId.equals("") && !strInterimId.equals("null"))
			{
			  stmt = 	objCon.createStatement();
			  strSql = "UPDATE T_INTERIM_JOURNEY SET TRAVEL_ID='"+strTravel_Id+"' WHERE PARENT_ID ="+ strInterimId;
			  int  iupdate1 = stmt.executeUpdate(strSql);
			}*/
	
	
			//objCon.setAutoCommit(false);
			  objCstmt             = objCon.prepareCall("{?=call PROC_DELETE_FROM_DOM_TABLE(?,?,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Req_Id);
			  objCstmt.setString(3, strTravel_Id);
			  objCstmt.setString(4, strTravelType); 
			  iSuccess1   =  objCstmt.executeUpdate();
			  objCstmt.close();
	
	
		  //PROCEDURE for INSERT data in T_TRAVEL_DETAIL_DOM
		  objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,    ?,?,?,?,?,?,   ?,?,?)}"); 
		  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		  objCstmt.setString(2, strTravel_Req_Id);
		  objCstmt.setString(3, strTravel_Id);
		  objCstmt.setString(4, strTravel_Req_No);
		  objCstmt.setString(5, strSiteId);             //set the Traveller Site Id
		  objCstmt.setString(6, strTravellerId);        //set the Traveller Id
		  objCstmt.setString(7, strAge);                //set the Traveller Age
		  objCstmt.setString(8, strSex);                //set the Traveller Sex
		  objCstmt.setString(9, strDepDate);            //set the Traveller Departure Date
		  objCstmt.setString(10, strMeal);              //set the Traveller Meal
		  objCstmt.setString(11, strTransitType);             //set the Traveller Hotel Required
		  objCstmt.setString(12, strBudget);       //set the Traveller Hotel Budget
		  objCstmt.setString(13, strBudgetCurrency);     //set the Traveller Hotel Budget Currency
		  objCstmt.setString(14, strCheckIn);      //set the Traveller Remark(in table)
		  objCstmt.setString(15, strCheckOut);             //set the current user Login UserId
		  objCstmt.setString(16, strOtherComment);             //set the current user Login UserId
		  objCstmt.setString(17, strReturnType);        //set the Traveller Return Type if(user fill the return date then Return Type is 2 otherwise 1
		  objCstmt.setString(18, Suser_id);                //set the current user Login UserId
		  objCstmt.setString(19, strSelectManager);             //set the select Approver radio button (manual or automatic)
		 // code added
	
	
	//NEW
		  objCstmt.setString(20, strManagerId);             //set the select Approver radio button (manual or automatic)
		  objCstmt.setString(21, strHodId);             //set the select Approver radio button (manual or automatic)
	//
	
	
			objCstmt.setString(22, strCARD_TYPE); 
	
	//22-02-2007  
			objCstmt.setString(23,strCARD_HOLDER_NAME);
	//22-02-2007
	
			objCstmt.setString(24, strCARD_NUMBER1); 
			objCstmt.setString(25, strCARD_NUMBER2); 
			objCstmt.setString(26, strCARD_NUMBER3); 
			objCstmt.setString(27, strCARD_NUMBER4); 
			objCstmt.setString(28, strCVV_NUMBER); 
			objCstmt.setString(29, strCARD_EXP_DATE); 
			objCstmt.setString(30, strReasonForTravel); 
			objCstmt.setString(31, strReasonForSkip); 	
	
	
	//ADDED SIX ADDITIONAL INFORMATION 17-02-2007 SACHIN
	   		  objCstmt.setString(32, strPlace); 	
	   		  objCstmt.setString(33, strForTatkaalRequired); 
	   		  objCstmt.setString(34, strForCoupanRequired); 
	  		  objCstmt.setString(35, strRetTatkaalRequired); 
			  objCstmt.setString(36, strRetCoupanRequired); 
	  		  objCstmt.setString(37, strIdentityProof); 
	/// Added by shiv on 3/14/2007 
			   objCstmt.setString(38, strIdentityProofno);
	//
		objCstmt.setString(39, "");      //MODIFIED_FIELDS
		objCstmt.setString(40, strBoardMemberId);
		objCstmt.setInt(41, Integer.parseInt(strCostCentre));
		objCstmt.setString(42, null);
	
		// code ends
	
		  iSuccess2   =  objCstmt.executeUpdate();
		  objCstmt.close();
	
		   
	//------------------------------------------------------
	   //PROCEDURE for UPDATE data in T_JOURNEY_DETAILS_DOM
	      objCstmt             = objCon.prepareCall("{?=call PROC_UPDATE_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?  ,?,?)}"); 
	      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strTravel_Id);
	      objCstmt.setString(3, strDepCity);             //set the Traveller Return Departure City Name(RETURN_FROM)
	      objCstmt.setString(4, strArrivalCity);             //set the Traveller Return Arrival City Name(RETURN_TO)
	      objCstmt.setString(5, strDepDate);             //set the Traveller Departure Date
	      objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to
	      objCstmt.setString(7, strDepartMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
	      objCstmt.setString(8, strDepartAirLineName);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
	      objCstmt.setString(9, strDepartClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
	      objCstmt.setString(10, strDeptTime);          //set the Travel Preferred Time e.g. Morning,evening etc.
	      objCstmt.setString(11, "");                    //set the Modified columns  
	
	      objCstmt.setString(12, Suser_id);              //set the current user Login UserId
	      objCstmt.setString(13, strprefferedSeatfwd);              //set the current user Login UserId
	      objCstmt.setString(14, strTicketRefundfwd);              //set the current user Login UserId
	      objCstmt.setInt(15, 0);
	      iSuccess4   =  objCstmt.executeUpdate();
	      objCstmt.close();
	
	
	
	
	   
	   
	//--------------------------------------------------------------------------------------
	//PROCEDURE for UPDATE data in T_RET_JOURNEY_DETAILS_DOM 
	      objCstmt             = objCon.prepareCall("{?=call PROC_UPDATE_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?  ,?,?)}"); 
	      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strTravel_Id);
	      objCstmt.setString(3, strDepCity1);             //set the Traveller Return Departure City Name(RETURN_FROM)
	      objCstmt.setString(4, strArrivalCity1);             //set the Traveller Return Arrival City Name(RETURN_TO)
	      objCstmt.setString(5, strReturnDate);             //set the Traveller Departure Date
	      objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to
	      objCstmt.setString(7, strArrivalMode);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
	      objCstmt.setString(8, strArrivalAirLineName);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
	      objCstmt.setString(9, strArrivalClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
	      objCstmt.setString(10, strArrivalTime);          //set the Travel Preferred Time e.g. Morning,evening etc.
	      objCstmt.setString(11, "");                    //set the Modified columns  
	      objCstmt.setString(12, Suser_id);              //set the current user Login UserId
	      objCstmt.setString(13, strprefferedSeatRet);              //set the current user Login UserId
	      objCstmt.setString(14, strTicketRefundRtd);              //set the current user Login UserId
	      objCstmt.setInt(15, 0);
	      iSuccess4   =  objCstmt.executeUpdate();
	      objCstmt.close();
	//--------------------------------------------------------------------------------------
		  
	      //PROCEDURE for INSERT data in T_APPROVERS
	
	      //Get the new Approve_Id from the T_Travel_Mst Table
	      String strApprove_Id  = "";
	      strApprove_Id  =  dbUtilityBean.getNewId("T_APPROVERS","APPROVE_ID")+"";
	
	      if(strSelectManager != null && strSelectManager.equals("manual"))
	      {
	        //6th March 2007 --start--
			String strTravellerRole  = "";
			String strUnitHead       = "0";          //0 for no and 1 for yes
			strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO  (NOLOCK) WHERE USERID="+strTravellerId; 	
			rs     = dbConBean1.executeQuery(strSql);
			if(rs.next())
			{
				 strTravellerRole = rs.getString("ROLE_ID");
				// strUnitHead	  = rs.getString("UNIT_HEAD");	
				 //System.out.println("Role id ========"+strTravellerRole);
				 if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
				 {
					approverList.clear();
				 }
				//System.out.println("approver List======="+approverList);
				//System.out.println("strUnitHead======="+strUnitHead);
			}
			rs.close();	
	
	//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
			  strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS (NOLOCK) where userid="+strTravellerId+" and site_id="+strSiteId+" and status_id=10 and unit_head=1";
			  rs = dbConBean1.executeQuery(strSql);
			  if(rs.next())
			  {
				strUnitHead			=	rs.getString(1).trim();			
			  }
			  rs.close();
	//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
							
			if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
			{
				strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
				rs     = dbConBean1.executeQuery(strSql);
				while(rs.next())
				{
					  strUserRole = rs.getString("USERROLE");
					  if(strUserRole != null && strUserRole.equalsIgnoreCase("MATA"))
					  {
						approverList.add(rs.getString("APPROVER_ID"));	
						approverList.add(strUserRole);  
					  }				 
				}
				rs.close();	
				}
				else
				{					
					//6th March 2007 -- end--
					if(strManagerId != null)
					{
						approverList.add(strManagerId);
						approverList.add("WORKFLOW");
					}
					if(strHodId != null)
					{
						//if condition added on 23 july 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
						if(!approverList.contains(strHodId)){
							approverList.add(strHodId);
							approverList.add("WORKFLOW");
						}
						
					}
					//added by manoj chand on 22 mar 2013 to add board member after approver 1 and 2
					if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-2")){
						approverList.add(strBoardMemberId);
						approverList.add("WORKFLOW");
					}
					
					strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE = 'D' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
//System.out.println("strSQL=====>"+strSql);					
					rs     = dbConBean1.executeQuery(strSql);
					while(rs.next())
					{
						 String strTempApproverId =  rs.getString("APPROVER_ID").trim();
						 strUserRole = rs.getString("USERROLE");
						 //if traveller id is unit head of the site then it would not be appear in the approver list.	
						 if(strUnitHead.equalsIgnoreCase("1") && strTravellerId.equals(strTempApproverId))	
						 {
						 }  //@Gaurav 08-May-2007 For Two Unit Heads belonging to the same site with site_id check
						 //STATUS_ID=10 ADDED BY MANOJ CHAND ON 17 APRIL 2012
								 String strQuery="Select Unit_Head from USER_MULTIPLE_ACCESS (NOLOCK) where USERID="+strTempApproverId+" AND SITE_ID="+strSiteId+" AND UNIT_HEAD=1 AND STATUS_ID=10 ORDER BY 1";
								 rs1     = dbConBean2.executeQuery(strQuery);							
								 if(strUnitHead.equalsIgnoreCase("1") && rs1.next()) {													
								}
					        //End
						 else
						 {
	                //		added code for checking if appro ver is exits in defualt approver list on 19-01-2009
	                
	       //System.out.println("strTempApproverId------->"+strTempApproverId);    
	       //System.out.println("approverList------->"+approverList);
							    if(approverList.contains(strTempApproverId)){ 
							    	int j = approverList.indexOf(strTempApproverId);
							    	int k=j+1;

									if (j == k - 1) {
										approverList.remove(j);
										approverList.remove(j);
									}
							    		
							    }
							  
									approverList.add(strTempApproverId);
									if(strUserRole != null && strUserRole.equalsIgnoreCase("OR"))
									{
										strUserRole = "DEFAULT";
									}
									approverList.add(strUserRole);  
							    //}	
						 }rs1.close(); 						
					}
					rs.close();	
				}// end of else 6th march 2007
	      }
	
	 
	//
	
	
	
	
	//new code added for removing traveller name from approver list if he/she Exist on 17 - March -2009 by shiv sharma 
	
	
	 strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_DOM AS TTDI (NOLOCK) INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
	 		  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
		
		//System.out.println("strSql==============="+strSql);
			   rs     = dbConBean1.executeQuery(strSql);
			   while(rs.next())
			   {
				strRoleofTraveler=rs.getString("ROLE_ID");
				strIDofTraveler=rs.getString("TRAVELLER_ID");
			   }
			   
			   if(strRoleofTraveler.equalsIgnoreCase("OR"))
				{
				   strRoleofTraveler = "DEFAULT";
				}
	
	   //System.out.println("approverList=========>>====strRoleofTraveler====="+approverList+" "+strRoleofTraveler); 
	   
	   //System.out.println("strManagerId=========>>====strHodId====strIDofTraveler=>"+strManagerId+"< 2>"+strHodId+"< 3>"+strIDofTraveler);  
	   
	   if(strManagerId== null || !strManagerId.equals(strIDofTraveler) )
	   {
	 	   if (strHodId==null || !strHodId.equals(strIDofTraveler))
	 	   { 
	 		//ROLE != MATA CONDITION ADDED BY MANOJ CHAND ON 05 MARCH 2012 TO SHOW MATA AS APPROVER FOR MATA'S REQUEST
			   if(approverList.contains(strIDofTraveler) && !strRoleofTraveler.trim().equalsIgnoreCase("MATA"))
			     {
				   int i=approverList.indexOf(strIDofTraveler);
				   //System.out.println("i---->"+i);
				   approverList.remove(i);
				   approverList.remove(i);
				   //approverList.remove(strIDofTraveler);  
				   //approverList.remove(strRoleofTraveler);
			   }
	 	   }
	   }
	   //System.out.println("approverList======after remove===>>========="+approverList);
	
	 //ADDED BY MANOJ CHAND ON 28 MARCH 2012 TO ADD BOARD MEMBER IN SECOND LAST POSITION IN APPROVER LIST
	 //System.out.println("strBoardMemberId--single dom-->"+strBoardMemberId);
	   if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-2")){
		   /*int s=approverList.size();
		   String x= (String) approverList.get(s-1);
			String y= (String) approverList.get(s-2);
			approverList.remove(s-1);
			approverList.remove(s-2);
			approverList.add(strBoardMemberId);
			approverList.add("WORKFLOW");
			approverList.add(y);
			approverList.add(x);*/
	   }
		  
		  
		 Iterator itr =  approverList.iterator();
	     while(itr.hasNext())
	     {
	        intCounter++;  
	        strApprove_Id       = dbUtilityBean.getNewId("T_APPROVERS","APPROVE_ID")+""; 
		    strApproverId       = (String) itr.next();
		    strApproverRole     = (String)itr.next(); 
	 	    strApproverOrderId  = intCounter+"";
	
			db11                 = new src.connection.DbConnectionBean();  //Create a new Object of DbConnectionBean
	        objCon1              = db11.getConnection();                                    
	        objCstmt             = objCon1.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
	        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	        objCstmt.setString(2, strApprove_Id);            //set the Approve Id      
	        objCstmt.setString(3, strTravel_Id);             //set the Travel Id    
	        objCstmt.setString(4, strSiteId);                //set the Traveller Site Id  
	        objCstmt.setString(5, strTravellerId);           //Set the Traveller Id
	        objCstmt.setString(6, strTravelType);            //Set the TravelType 
	 
	        objCstmt.setString(7, strApproverId);            //Set the Approver Id
	        objCstmt.setString(8, strApproveStatus);         //Set the Approve Status(0-no approve, 10-approve, 3-return, 4-rejected)
	        objCstmt.setString(9, strApproverOrderId);       //Set the Approver Order Id in which  order approver approve the requsition
	        objCstmt.setString(10, strApproverRole);         //Set the Approver Role
	        objCstmt.setString(11, Suser_id);                //Set the Login user id 
	
		    iSuccess5   =  objCstmt.executeUpdate();
		    objCstmt.close();
		    objCon1.close();
		    if(iSuccess5 == 0)
			   break;
	      }
	  
		  strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
		}
		catch(Exception e)
		{
	   	    strMessage = dbLabelBean.getLabel("message.global.notsaved",strsesLanguage);
			System.out.println("Error in Update bolock of T_TravelDetail_Dom_Post.jsp=="+e);
		}	
		
	    /*if(iSuccess1 > 0 && iSuccess2 > 0 && iSuccess3 > 0 && iSuccess4 > 0 && iSuccess5 >0 )
	    {
		   System.out.println("Data updated successfully");
		   objCon.commit();   
	    }
	    else
	    {
	       System.out.println("Data not updated"); 
		   objCon.rollback();
	    }*/
	}//end of else (update block)
	
	dbConBean2.close();
	dbConBean.close();  // CLOSE ALL CONNECTION
	//System.out.println("flag is========="+strFlag);
	if(strMessage != null && strMessage.equals(dbLabelBean.getLabel("message.global.save",strsesLanguage)))
	{
		if (strFlag.equals("Proceed"))
		{
			//change by manoj
			//strUrl = "T_TravelDetail_Dom_Forex.jsp?travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strSiteId+"&travelReqNo="+strTravel_Req_No+"&interimId="+strInterimId+"&flagSave=save";
			strUrl = "T_TravelDetail_Dom_Forex.jsp?travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strSiteId+"&travelReqNo="+strTravel_Req_No+"&interimId="+strInterimId+"&site="+strSiteId+"&flagSave=save&smpsiteflag="+strHidAppFlag;
			//response.sendRedirect("T_TravelDetail_Dom_Forex.jsp?travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strSiteId+"&travelReqNo="+strTravel_Req_No+"&interimId="+strInterimId+"&flagSave=save");
		}
		else if (strFlag.equals("Save")) 
		{
			strUrl = "T_TravelDetail_Dom.jsp?message="+strMessage+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travelReqNo="+strTravel_Req_No+"&userName="+strTravellerId+"&flag=save&manager="+strManagerId+"&hod="+strHodId+"&interimId="+strInterimId+"&boardmember="+strBoardMemberId;
			  //response.sendRedirect("T_TravelDetail_Dom.jsp?travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travelReqNo="+strTravel_Req_No+"&flag=save&manager="+strManagerId+"&hod="+strHodId+"&interimId="+strInterimId);		
		}
		else if (strFlag.equals("Exit")) 
		{
			strUrl = "T_TravelRequisitionList_D.jsp?travel_type=DOM";
			//response.sendRedirect("T_TravelRequisitionList_D.jsp?travel_type=DOM");
		}
	}
	else
	{
		strUrl = "T_TravelDetail_Dom.jsp?message="+strMessage+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travelReqNo="+strTravel_Req_No+"&flag=save&manager="+strManagerId+"&hod="+strHodId+"&interimId="+strInterimId+"&boardmember="+strBoardMemberId;
	}
	
	response.sendRedirect(strUrl);
	}
	%>
	</html>
