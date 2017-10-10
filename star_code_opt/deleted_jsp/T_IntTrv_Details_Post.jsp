	<% 
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:SACHIN GUPTA
	 *Date of Creation 		:08 September 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is first jsp file  for create the Travel Requsition
	 *Modification 	    	:1.Change the Accomodation Information.
							 2.For Two Unit Heads belonging to the same site. 
	 *Reason of Modification:1.Change suggested by MATA
							 2.Issue_Log_STARS_Latest reference no. 53 
							 3.Issue_Log_STARS_Latest reference no. 53 with site_id check
							 4 . code changed by shiv sharma on 26-Oct-07 for Addeding prefered Time  for intermediate journey  
							 5  .Code modified  on 06/02/2008 by shiv sharma --sending  values through variables
							 6 .Code change for storing actual age in years only on 03-Mar-08   by shiv Sharma 
							 7 . Added New Field For Setting Group flag as "N"
							 8 :code changed by shiv on 7 jan 2008  to removing air mode for intrenational travel requested by mata  
							 9: added code for checking if approver is exits in defualt approver list on 19-01-2009
							 10 new code added for removing traveller name from approver list if he/she Exist on 17 - March -2009 by
							 shiv sharma 
							 11. added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers on 26-Oct-09 by shiv sharma 
							 12.Commented Credit card no as it is not required for  to show any user on 10-03-2010 by shiv sharma 
	 *Date of Modification  :1.3 Nov 2006 
							 2.27-Apr-2007 
							 3.08-May-2007
	 *Modified By	        :1. SACHIN GUPTA
							 2. Gaurav Aggarwal
							 3. Gaurav Aggarwal
							 4. Modified by vaibhav paliwal on jul 15 2010 to remove bug in case of duplicate approvers in workflow
	 *Editor				:Editplus
	 
	 *Date of Modification  :20-apr-2011
	 *Modified By			:Manoj Chand
	 *Modification			:Remove problem which is 'basic information was not saved in case of originator creating request for 
	 							self as his/her name appears in default workflow at last position'.
	 							
	 *Modification			:modify workflow as per selected site
	 *Date of modification  :12 Oct 2011
	 *Modified By     		:Manoj Chand	 		
	 
	 *Modification			:Not remove mata from workflow when mata is creating self request.  
	 *Date of modification  :05 March 2012
	 *Modified By     		:Manoj Chand
	 
	 *Modification				:Add Board Member for SMP  
	 *Modified by				:Manoj Chand
	 *Date of Modification		:28 Mar 2012
	 
	 *Modification				:change in query to implement according to traveller workflow for smr  
	 *Modified by				:Manoj Chand
	 *Date of Modification		:16 Apr 2012
	 
	 *Modification				:Add status_id=10 in query which is checking default approver for unithead flag.
	 *Modified by				:Manoj Chand
	 *Date of Modification		:17 Apr 2012
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:01 Aug 2012
	 *Description				:Pass Cost Centre parameter to proc_insert_t_travel_detail_int
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:19 OCT 2012
	 *Description				:IMPLEMENT SITE WISE FLAG TO SHOW BOARD MEMBER IN SMP
	 
	 *Modified By	        	:MANOJ CHAND
	 *Date of Modification  	:22 Mar 2013
	 *Description				:change position of board member from second last to after approver 1 and 2 in approver list
	 
	 *Modified By				:Manoj Chand
	 *Date of Modification		:23 July 2013
	 *Modification				:Mandatory selection of approval level 1 and 2 for mssl site. more than one approver name not come in approver list.
	 *******************************************************/
	%>
	<html>
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
	
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	 
	<style type="text/css">
	<!--
	.style2 {font-size: 10px; font-weight: bold; color: #FF7D00; }
	-->
	</style>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Untitled Document</title>
	
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
	<!--@Gaurav 30-Apr-2007 Not in Use <script type="text/javascript" language="JavaScript1.2" src="style/company.js?buildstamp=2_0_0"></script>-->
	<script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<%
	//Global Variables declared and initialized
	request.setCharacterEncoding("UTF-8");
	int intSuccess1                 = 0;
	int intSuccess2                 = 0;
	int intSuccess3                 = 0;
	int intSuccess4                 = 0;
	int intSuccess41                = 0;    //flag for intrim journey
	int intSuccess5                 = 0;
	int intSuccess6                 = 0;
	int intSuccess7                 = 0;
	int intSuccess8                 = 0;
	int intSuccess9                 = 0;
	int iSuccess3					  = 0;	
	int intCounter                     = 0;
	String strSql                       =  null;            // String for Sql String
	Connection objCon               =  null;            //Object for Connection 
	Connection objCon1              =  null;            //Object for Connection 
	ResultSet rs,rs1,rs2            =  null;            // Object for ResultSet
	CallableStatement objCstmt	    =  null;		    // Object for Callable Statement
	Statement stmt					=  null;
	src.connection.DbConnectionBean db11 = null;
	src.travelBean.TravelBean travelBean1      =  null;  
	String strSiteId                =  "";
	String strTravellerId           =  "";
	String strDesigId               =  "";                    
	String strAge                   =  "";                          
	String strSex                   =  "";                          
	String strMeal                  =  "";                           
	String strVisa                  =  "";                           
	String strVisaComment           =  "";                                  
	String strDepCity               =  "";                              
	String strDepDate               =  "";                              
	String strPrefTime1             =  "";                                
	String strTravelMode1           =  "";                                  
	String strNameOfAirline1        =  "";
	String strTravelClass1          =  "";
	String strArrCity               =  "";
	//new
	String strDepCity1              =  "";                              
	String strArrCity1              =  "";
	//
	String strReturnDate            =  "";                              
	String strPrefTime2             =  "";                                
	String strTravelMode2           =  "";                                  
	String strNameOfAirline2        =  "";
	String strTravelClass2          =  "";
	String strInsurance             =  "";
	String strNominee               =  "";
	String strRelation              =  "";
	String strInsuranceComment      =  "";
	String strSelectManager         =  "";
	String strManagerId             =  "";
	String strHodId                 =  "";
	String strBoardMemberId     	=  "";
	String strHidAppFlag			=  "";
	String strHidAppShowBMFlag	="";
	String strHotel                 =  "";
	String strBudgetCurrency        =  "";
	String strHotelBudget           =  "";
	String strOtherComment          =  "";
	//NEW
	String strReasonForTravel       =  "";
	String strReasonForSkip         =  ""; 
	//
	String strCheckIn				=  "";
	String strCheckOut				=  "";
	String strTravelType            =  "I";     //I for International
	String strReturnType            =  "";      // if user filled the return date then return type is 2 otherwise 1
	String strJourneyOrder          =  "1";
	String strTravelStatusId        =  "1";  
	String strApproverId            =  "";   
	String strApproveStatus         =  "0"; 
	String strApproverOrderId       =  "";   
	String strApproverRole          =  ""; 
	ArrayList approverList           =  new ArrayList();
	ArrayList approverList1         =  new ArrayList();
	ArrayList l1                             =  new ArrayList();
	String strTravelReqId           =  "";
	String strTravelId				=  "";
	String strTravelReqNo           =  "";
	String strActionFlag            =  "";
	String strWhatAction            =  "";    
	String url                      =  ""; 
	String strMessage               =  ""; 
	String strInterimId             =  "";  
	String strUserRole              =  "";        
	String strplace              =  "";     
	
	String strRoleofTraveler   ="";
	String strIDofTraveler     =""; 
	
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	 
	//strplace
	String strCARD_TYPE				= request.getParameter("CARD_TYPE"); 
	///22-02-2007
	String strCARD_HOLDER_NAME ="";
	
	strCARD_HOLDER_NAME      =  request.getParameter("cardHolderName")==null ?"" :request.getParameter("cardHolderName") ; 
	
	///22-02-2007
		//blocked by shiv on  09-03-2010 
		
	String strCARD_NUMBER1			= "";//request.getParameter("CARD_NUMBER1");
	String strCARD_NUMBER2			= "";//request.getParameter("CARD_NUMBER2");
	String strCARD_NUMBER3			= "";//request.getParameter("CARD_NUMBER3");
	String strCARD_NUMBER4			= "";//request.getParameter("CARD_NUMBER4"); 
	String strWorkFlowName			= "";
	strWorkFlowName=SSstrSplRole;

	String strCostCentre="0";
	
	String strCARD_EXP_DATE			= request.getParameter("CARD_EXP_DATE");
	String strCVV_NUMBER			= request.getParameter("CVV_NUMBER");
	strTravelReqId                  =  request.getParameter("travelReqId");    // from hidden field
	strTravelId                     =  request.getParameter("travelId");       // from hidden field
	strWhatAction                   =  request.getParameter("whatAction");     //from hidden field                                 
	strTravelReqNo                  =  request.getParameter("travelReqNo");    // for hidden field
	
	if(strTravelReqId != null && strTravelReqId.equals("new"))
	{
	    strActionFlag   = "insert";
	}
	else
	{
		strActionFlag   = "update"; 
	}
	
	strSiteId                =  (request.getParameter("site")==null || request.getParameter("site").equals("null")) ? strSiteIdSS : request.getParameter("site") ;
	
//System.out.println("strSiteId--int-->"+strSiteId);	
	strTravellerId              =  request.getParameter("userName");
	//System.out.println("strTravellerId--int-->"+strTravellerId);
	strDesigId                  =  request.getParameter("designation");
	//Code change for storing actual age in years only on 03-Mar-08   by shiv Sharma
	
	strAge                     =  request.getParameter("actualAge");
	
	strSex                     =  request.getParameter("sex");
	strMeal                    =  request.getParameter("meal");
	strCostCentre			   =  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
	strVisa                    =  request.getParameter("visa");
	strVisaComment        =  request.getParameter("visaComment");
	strDepCity                  =  request.getParameter("depCity");
	strDepCity1                =  request.getParameter("depCity1");
	strDepDate                 =  request.getParameter("depDate");
	strPrefTime1               =  request.getParameter("preferTime1");
	
	//code changed by shiv on 7 jan to removing air mode for intrenational travel requested by mata
	///strTravelMode1           =  request.getParameter("travelMode1");
	strTravelMode1          = "1"; // for air,changed  by shiv as requested by MATA on oct 2008
	
	
	strNameOfAirline1      =  request.getParameter("nameOfAirline1");
	strTravelClass1          =  request.getParameter("travelClass1");
	strArrCity                    =  request.getParameter("arrCity");
	strArrCity1                  =  request.getParameter("arrCity1");
	strReturnDate            =  request.getParameter("returnDate");
	strPrefTime2              =  request.getParameter("preferTime2");
	
	/*	System.out.println("strDepDate---->"+strDepDate);
		System.out.println("strReturnDate---->"+strReturnDate);*/
	//System.out.println("strCostCentre in post===>"+strCostCentre);
	//strTravelMode2          = request.getParameter("travelMode2");
	strTravelMode2          = "1"; // for air always by shiv as requested by MATA on oct 2008
	
	strNameOfAirline2     =  request.getParameter("nameOfAirline2");
	strTravelClass2         =  request.getParameter("travelClass2");
	strInsurance              =  request.getParameter("insurance");
	strNominee                =  request.getParameter("nominee");
	strRelation                  =  request.getParameter("relation");
	strInsuranceComment      =  request.getParameter("insuranceComment");
	strSelectManager         =  request.getParameter("selectManager");
	strManagerId             =  request.getParameter("manager");
	strHodId                 =  request.getParameter("hod");
	strBoardMemberId		 =  request.getParameter("boardmember");
	strHidAppFlag			 =  request.getParameter("hidAppLvl3flg");
	strHidAppShowBMFlag		=	request.getParameter("hidAppLvl3showbmflg");
	//System.out.println("strBoardMemberId--->"+strBoardMemberId);
	//System.out.println("strHidAppFlag--->"+strHidAppFlag);
	strHotel                 =  request.getParameter("hotel");
	strBudgetCurrency        =  request.getParameter("currency");
	strHotelBudget           =  request.getParameter("budget");
	strOtherComment          =  request.getParameter("otherComment");
	strplace                 =request.getParameter("place");
	//New
	if(strManagerId != null && strManagerId.equalsIgnoreCase("S"))
	{
		strManagerId = null;
	}
	if(strHodId != null && strHodId.equalsIgnoreCase("S"))
	{
		strHodId = null;
	}
	if(strBoardMemberId!= null && strBoardMemberId.equalsIgnoreCase("B"))
	{
		strBoardMemberId = null;
	}
	
	if(strManagerId == null && strHodId == null) 
	{
		//strSelectManager     =  "skip";
	}
	strReasonForTravel       =  request.getParameter("reasonForTravel");
	strReasonForSkip         =  request.getParameter("reasonForSkip");
	//
	strCheckIn				 =  request.getParameter("checkin");
	strCheckOut				 =  request.getParameter("checkout");
	strInterimId			 =  request.getParameter("interimId");
	
	
	
	//added new on 07 jan 2009
	String strSeatPrefferedFwdJny   =  request.getParameter("seatpreffredForjony");
	String strSeatPrefferedRetJny   =  request.getParameter("seatpreffredRetjony");
	
	
	
	//Added By Gurmeet Singh
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strSiteId, "0");		
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strTravellerId, strSiteId, "0");		
	} 
	if(strManagerId != null && !strManagerId.equalsIgnoreCase("S") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strManagerId, strSiteId, "1");
	} 
	if(strHodId != null && !strHodId.equalsIgnoreCase("S") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strHodId, strSiteId, "2");
	} 
	if(strBoardMemberId!= null && !strBoardMemberId.equalsIgnoreCase("B") && !strUserAccessCheckFlag.equals("420")){
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strBoardMemberId, strSiteId, "3");
	}
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthCostCenter(strCostCentre, strSiteId);		
	}
	if(!strUserAccessCheckFlag.equals("420") && !strTravelId.equals("new")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "I", Suser_id);		
	}
	
	
	if(strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();
		dbConBean2.close();
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_IntTrv_Details_Post.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {	
		
	
	//CODE ADDED BY MANOJ CHAND ON 16 APRIL 2012 TO FETCH WORKFLOW NAME OF TRAVELLER
	strSql="SELECT SP_ROLE FROM M_USERINFO WHERE M_USERINFO.USERID="+strTravellerId+" AND M_USERINFO.STATUS_ID=10";
	 rs = dbConBean.executeQuery(strSql);
		if(rs.next()){  
			strWorkFlowName= rs.getString("SP_ROLE");	 		
		 }
	rs.close();
	
	
	if (strInterimId!= null && !"".equals(strInterimId))   
	{  
		 //Query Changed by shiv on 25-Oct-07 ---------------by Shiv Sharma 
		 strSql="SELECT TRAVEL_FROM, TRAVEL_TO, TRAVEL_DATE, TRAVEL_MODE, MODE_NAME, TRAVEL_CLASS,VISA_REQUIRED, VISA_COMMENT,ISNULL(TIMINGS,1) AS  TIMINGS FROM T_INTERIM_JOURNEY (NOLOCK) WHERE PARENT_ID ="+strInterimId+"AND TRAVEL_TYPE='I' AND APPLICATION_ID =1";
		 
	 
//System.out.println("Query "+strSql);
	
		rs	=	dbConBean.executeQuery(strSql);
	
		while(rs.next())
		{
			l1.add(new String(rs.getString("TRAVEL_FROM")));
			l1.add(new String(rs.getString("TRAVEL_TO")));
			l1.add(new String(rs.getString("TRAVEL_DATE")));
			l1.add(new String(rs.getString("TRAVEL_MODE")));
			l1.add(new String(rs.getString("MODE_NAME")));
			l1.add(new String(rs.getString("TRAVEL_CLASS")));	
			l1.add(new String(rs.getString("VISA_REQUIRED")));	
			l1.add(new String(rs.getString("VISA_COMMENT")));	
			l1.add(new String(rs.getString("TIMINGS")));	// Added new for frefered timing on 25-Oct-07 -----by Shiv Sharma   
		}	
	}
	
	if(strReturnDate !=null && strReturnDate.equals(""))
	{
		strReturnType       =  "1"; 
	}
	else
	{
	    strReturnType       =  "2"; 
	}
	
	if (strCheckIn !=null && "".equals(strCheckIn)){
		strCheckIn	=	null;
	}
	if (strCheckOut !=null && "".equals(strCheckOut)) {
		strCheckOut	=	null; 
	}
	
	//Get the new Travel_Req_Id from the TID Table
	String strTravel_Req_Id  = "";
	String strTravel_Id  = "";
	String strTravel_Req_No = "";
	
	if(strActionFlag!=null && strActionFlag.equals("insert"))
	{
	  strTravel_Req_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_REQ_ID")+"";
	  strTravel_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_INT")+"";
	  
	//change by manoj on 12 oct 2011 to show selected site name in request number
	  if(!strSiteId.trim().equalsIgnoreCase(strSiteIdSS.trim())){
		  String strsiteName="";
		 strSql="select site_name from m_site where site_id="+strSiteId;
		 rs = dbConBean.executeQuery(strSql);
			while(rs.next()){  
				strsiteName = rs.getString("site_name");	 		
			 }
			strTravel_Req_No = "TEMP/"+strsiteName.trim()+"/INT/"+strTravel_Id;
			rs.close();				
	  }else{	  
	  strTravel_Req_No = "TEMP/"+strSiteFullName.trim()+"/INT/"+strTravel_Id;
	  }
	  
	  try
	  {
	    objCon               =  dbConBean.getConnection(); 
	    objCon.setAutoCommit(false);
		objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_MST(?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
	    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	    objCstmt.setString(2, strTravel_Req_Id);
	    //change manoj
	    objCstmt.setString(3, strSiteId);             //set the current user Site Id
	    objCstmt.setString(4, Suser_id);                //set the current user Login UserId
	    objCstmt.setString(5, strTravelType);
	    intSuccess1   =  objCstmt.executeUpdate();
	    objCstmt.close();
	
		//PROCEDURE for INSERT data in T_TRAVEL_DETAIL_INT
		//one parameter for boardmember added by manoj chand
	    objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,     ?,?,?)}");     objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	    objCstmt.setString(2, strTravel_Req_Id);
	    objCstmt.setString(3, strTravel_Id);
	    objCstmt.setString(4, strTravel_Req_No);
	    objCstmt.setString(5, strSiteId);             //set the Traveller Site Id
	    objCstmt.setString(6, strTravellerId);        //set the Traveller Id
	    objCstmt.setString(7, strAge);                //set the Traveller Age
	    objCstmt.setString(8, strSex);                //set the Traveller Sex
	    objCstmt.setString(9, strDepDate);            //set the Traveller Departure Date
	    objCstmt.setString(10, strMeal);              //set the Traveller Meal
	    objCstmt.setString(11, strVisa);              //set the Traveller Visa Required
	    objCstmt.setString(12, strVisaComment);       //set the Traveller Visa Comment
	    objCstmt.setString(13, strInsurance);         //set the Traveller Isurance Required
	    objCstmt.setString(14, strNominee);           //set the Traveller's Nominee
	    objCstmt.setString(15, strRelation);          //set the Traveller's Relation
	    objCstmt.setString(16, strInsuranceComment);  //set the Traveller's Insurance Comment
	    objCstmt.setString(17, strHotel);             //set the Traveller Hotel Required
	    objCstmt.setString(18, strHotelBudget);       //set the Traveller Hotel Budget
	//
		objCstmt.setString(19, strplace);
	//
	    objCstmt.setString(20, strBudgetCurrency);     //set the Traveller Hotel Budget Currency
	    objCstmt.setString(21, strOtherComment);      //set the Traveller Remark(in table)
	    objCstmt.setString(22, strReturnType);        //set the Traveller Return Type if(user fill the return date then Return Type is 2 otherwise 1
		objCstmt.setString(23, Suser_id);             //set the current user Login UserId
	    objCstmt.setString(24, strSelectManager);             //set the select Approver radio button (manual or automatic)
	
	
	//NEW
		objCstmt.setString(25, strManagerId);             //set the select Approver radio button (manual or automatic)
		objCstmt.setString(26, strHodId);             //set the select Approver radio button (manual or automatic)
	//
		objCstmt.setString(27, strCARD_TYPE);
	
	//22-02-2007  
		objCstmt.setString(28,strCARD_HOLDER_NAME);
	//22-02-2007
	
		objCstmt.setString(29, strCARD_NUMBER1); 
		objCstmt.setString(30, strCARD_NUMBER2); 
		objCstmt.setString(31, strCARD_NUMBER3); 
		objCstmt.setString(32, strCARD_NUMBER4); 
		objCstmt.setString(33, strCVV_NUMBER); 
		objCstmt.setString(34, strCARD_EXP_DATE); 
		objCstmt.setString(35, strCheckIn); 
		objCstmt.setString(36, strCheckOut); 
		objCstmt.setString(37, strReasonForTravel);      //set the Reason For Travel
		objCstmt.setString(38, strReasonForSkip);        //set the Reason for Skipping the Apprval Seleciton 1 and 2
		objCstmt.setString(39, "");                            //Modified Fields 
		objCstmt.setString(40, "N");                          //Added New Field For Setting Group flag as "N"
		objCstmt.setString(41,strBoardMemberId);
		objCstmt.setInt(42,Integer.parseInt(strCostCentre));
		objCstmt.setString(43, null);     
	    intSuccess2   =  objCstmt.executeUpdate();
	    objCstmt.close();
	   
	   //PROCEDURE for INSERT data in T_JOURNEY_DETAILS_INT
	    objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
	    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		objCstmt.setString(2, strTravel_Id);
	    objCstmt.setString(3, strDepCity);             //set the Traveller Departure City Name(TRAVEL_FROM)
	    objCstmt.setString(4, strArrCity);  //set the Traveller Arrival City Namei(TRAVEL_TO)
	    objCstmt.setString(5, strDepDate);             //set the Traveller Departure Date
	    objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
	    objCstmt.setString(7, strTravelMode1);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
	    objCstmt.setString(8, strNameOfAirline1);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
	    objCstmt.setString(9, strTravelClass1);        //set the Travel Class Name(in int value), e.g. First class, Business class 
	    
	     //code modified  on 06/02/2008 by shiv sharma --sending  values through variables 
	    objCstmt.setString(10,strVisa);        //set the VISA_REQUIRED, e.g. 1 for yes and 2 for no
	    objCstmt.setString(11,strVisaComment);        //set the VISA_COMMENT
	
	    objCstmt.setString(12, strPrefTime1);          //set the Travel Preferred Time e.g. Morning,evening etc.
	    objCstmt.setString(13, Suser_id);              //set the current user Login UserId
	    objCstmt.setString(14, strSeatPrefferedFwdJny); //set the seat preffered  for forward journey added on 09-2009 bt shiv
	    objCstmt.setInt(15, 0);
	    intSuccess3   =  objCstmt.executeUpdate();
	    objCstmt.close();
	
	  //PROCEDURE for INSERT data in T_RET_JOURNEY_DETAILS_INT
	    objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?)}"); 
	    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	    objCstmt.setString(2, strTravel_Id);
	    objCstmt.setString(3, strDepCity1);             //set the Traveller Return Departure City Name(RETURN_FROM)
	    objCstmt.setString(4, strArrCity1);             //set the Traveller Return Arrival City Name(RETURN_TO)
	    objCstmt.setString(5, strReturnDate);             //set the Traveller Departure Date
	    objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to
	    objCstmt.setString(7, strTravelMode2);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
	    objCstmt.setString(8, strNameOfAirline2);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
	    objCstmt.setString(9, strTravelClass2);        //set the Travel Class Name(in int value), e.g. First class, Business class 
	    objCstmt.setString(10, strPrefTime2);          //set the Travel Preferred Time e.g. Morning,evening etc.
	    objCstmt.setString(11, Suser_id);              //set the current user Login UserId
	    objCstmt.setString(12, strSeatPrefferedRetJny);  //set the seat preffered  for return journey added on 09-2009 bt shiv
	    objCstmt.setInt(13, 0);
	    intSuccess4   =  objCstmt.executeUpdate();
	    objCstmt.close();
	
	   //PROCEDURE for INSERT data in T_TRAVEL_STATUS
	    objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_STATUS(?,?,?,?)}"); 
	    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	    objCstmt.setString(2, strTravel_Req_Id);
	    objCstmt.setString(3, strTravel_Id);
	    objCstmt.setString(4, strTravelStatusId);      //set the Travel Status Id(1-Temp, 2-Permanent, 3-Return, 4-Rejected, 6-Canceled, 10-Approved by All)
	    objCstmt.setString(5, strTravelType);          //set the Travel Type(I-international, D-Domestic)
	    intSuccess5   =  objCstmt.executeUpdate();
	    objCstmt.close();
	
		objCon.commit(); //commit the query
	    objCon.setAutoCommit(true);
	
		if(intSuccess1 > 0 && intSuccess2 > 0 && intSuccess3 > 0 && intSuccess4 > 0 && intSuccess5 >0)
		{
			//  Getting the data from the T_INTRIM_JOURNEY TABLE and put these values in the T_JOURNEY_DETAILS_INT Table
			//PROCEDURE for INSERT data in T_JOURNEY_DETAILS_INT for break up journey
			if (strInterimId != null && !"".equals(strInterimId)) 
			{
			  int z = 0;	
			  int n = 2;	
			  for (int k = 0 ; k < l1.size()/8; k++) 
			  {		
				  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
				  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  objCstmt.setString(2, strTravel_Id);
				  objCstmt.setString(3, (String)l1.get(z++));             //set the Traveller Departure City Name(TRAVEL_FROM)
				  objCstmt.setString(4, (String)l1.get(z++));             //set the Traveller Arrival City Namei(TRAVEL_TO)
				  objCstmt.setString(5, (String)l1.get(z++));             //set the Traveller Departure Date
				  objCstmt.setInt(6, n++);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
				  objCstmt.setString(7, (String)l1.get(z++));         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
				  objCstmt.setString(8, (String)l1.get(z++));      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
				  objCstmt.setString(9, (String)l1.get(z++));        //set the Travel Class Name(in int value), e.g. First class, Business class 
				  objCstmt.setString(10, (String)l1.get(z++));        //set the VISA_REQUIRED, e.g. 1 for yes and 2 for no
				  objCstmt.setString(11, (String)l1.get(z++));        //set the VISA_COMMENT
				  objCstmt.setString(12, (String)l1.get(z++));     
				   //set the Travel Preferred Time e.g. Morning,evening etc //on 25-Oct-07 ----by Shiv Sharma .
				  objCstmt.setString(13, Suser_id);              //set the current user Login UserId
				  objCstmt.setString(14, strSeatPrefferedFwdJny); //set the seat preffered  for forward journey added on 09-2009 bt shiv
				  objCstmt.setInt(15, 0);
				  iSuccess3   =  objCstmt.executeUpdate();
				  objCstmt.close();				
			   }		
			}
	
			// update T_INTERIM_JOURNEY
			if(strInterimId != null && !strInterimId.equals(""))
			{
			  stmt = 	objCon.createStatement();
			  strSql = "UPDATE T_INTERIM_JOURNEY SET TRAVEL_ID='"+strTravel_Id+"' WHERE PARENT_ID ="+ strInterimId;
			  //System.out.println("Query "+strSql);
			  int  iupdate1 = stmt.executeUpdate(strSql);
			}
	
		   //PROCEDURE for INSERT data in T_APPROVERS
	
		   //Get the new Approve_Id from the T_Travel_Mst Table
		   String strApprove_Id  = "";
		   strApprove_Id  =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";
	
		   if(strSelectManager != null && strSelectManager.equals("manual"))
		   {
					//6th March 2007
				String strTravellerRole  = "";
				String strUnitHead       = "0";
				strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;
				//System.out.println("Query "+strSql);
				rs     = dbConBean1.executeQuery(strSql);
				if(rs.next())
				{
					 strTravellerRole = rs.getString("ROLE_ID");
					// strUnitHead	  = rs.getString("UNIT_HEAD");	
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
				//System.out.println("Query "+strSql);
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
					strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+"  AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4"; 
					
					//System.out.println("Query "+strSql);
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
				  //6th March 2007
				  
				  if(strManagerId != null)
				  {
					// adding 1 level approver  as manager id 
				    approverList.add(strManagerId);
					approverList.add("WORKFLOW");
				  }
				  if(strHodId != null)
				  {
					//adding 2 level approver  as hod id
					//if condition added on 23 july 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
					if(!approverList.contains(strHodId)){
						approverList.add(strHodId);
						approverList.add("WORKFLOW"); 
					}
				  }
				  //added by manoj chand on 22 mar 2013 to add board member after approver 1 and 2
				   if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-1")){
						approverList.add(strBoardMemberId);
						approverList.add("WORKFLOW"); 
				   }
				  
				 
				  strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";

				  //System.out.println("Query "+strSql);
				// System.out.println("After strSql====   "+strSql);
				  rs     = dbConBean1.executeQuery(strSql);
				  while(rs.next())
				  {
					//  System.out.println("Approve list in loop"+approverList);
					String strTempApproverId =  rs.getString("APPROVER_ID").trim();
					 strUserRole = rs.getString("USERROLE");
					 //if traveller id is unit head of the site then it would not be appear in the approver list.	
					 if(strUnitHead.equalsIgnoreCase("1") && strTravellerId.equals(strTempApproverId))	
					 {
					 }
					 //@Gaurav 27-Apr-2007 For Two Unit Heads belonging to the same site.
					 //STATUS_ID=10 ADDED BY MANOJ CHAND ON 17 APRIL 2012
						 String strQuery="Select Unit_Head from USER_MULTIPLE_ACCESS (NOLOCK) where USERID="+strTempApproverId+" and SITE_ID="+strSiteId+" AND UNIT_HEAD=1 AND STATUS_ID=10 ORDER BY 1";
						 //System.out.println("Query "+strQuery);
						 rs1     = dbConBean2.executeQuery(strQuery);
						 if(strUnitHead.equalsIgnoreCase("1") && rs1.next()) {	}
						 //End of modification
						 else
						 {
							// added code for checking if appro ver is exits in defualt approver list on 19-01-2009  
						   //modified by vaibhav on jul 15 2010 added "approverList.contains("WORKFLOW")" condition in if
								if(approverList.contains(strTempApproverId) && approverList.contains("WORKFLOW") ){  
								  approverList.remove(strTempApproverId); 
								  approverList.remove("WORKFLOW"); 
								  }
		 					    approverList.add(strTempApproverId); 
							   if(strUserRole != null && strUserRole.equalsIgnoreCase("OR"))
								{
									strUserRole = "DEFAULT";
								}
								approverList.add(strUserRole);  
							
						 }rs1.close();
				  }
				  rs.close();	
				 
				  
				}//6th march 2007
			}
	
	
	
	//new code added for removing traveller name from approver list if he/she Exist on 17 - March -2009 by shiv sharma 
	
	 strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_INT AS TTDI (NOLOCK) INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
	 		  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
	// System.out.println("Query "+strSql);
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
		//System.out.println("approverList----start-->"+approverList);
	   if(strManagerId == null || !strManagerId.equals(strIDofTraveler) )
	   {
	 	   if (strHodId==null ||  !strHodId.equals(strIDofTraveler))
	 	   { 
	 		//ROLE != MATA CONDITION ADDED BY MANOJ CHAND ON 05 MARCH 2012 TO SHOW MATA AS APPROVER FOR MATA'S REQUEST
			   if(approverList.contains(strIDofTraveler) && !strRoleofTraveler.trim().equalsIgnoreCase("MATA"))
			     {
				   	 int i=approverList.indexOf(strIDofTraveler);//added by 
				     //System.out.println("i---->"+i);
				     approverList.remove(i);
				     approverList.remove(i);
				   //approverList.remove(strIDofTraveler);  
				   //approverList.remove(strRoleofTraveler);
			   }
	 	   }
	   }
	 
	
	   //System.out.println("strBoardMemberId---post---->"+strBoardMemberId);
	   //ADDED BY MANOJ CHAND ON 28 MARCH 2012 TO ADD BOARD MEMBER IN SECOND LAST POSITION IN APPROVER LIST
	   if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") && strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-1")){
		  /* int s=approverList.size();
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
		   //System.out.println("approverList--0-->"+approverList);  
		   while(itr.hasNext())
		   {
			  intCounter++;  
			 // strApprove_Id  =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+""; //NO NEED GENERATION OF THIS ID DUE TO FIELD IS AUTO-GENERATED IN THE T_APPROVER TABLE
			 //System.out.println("Varriables ghjkdfhgjdfh  " +strApprove_Id+"   " +strTravel_Id+"   " +strSiteId+"   " +strTravellerId+"   " +strTravelType+"   " +strApproverId+"   " +strApproveStatus+"   " +strApproverOrderId+"   " +strApproverRole+"   " +Suser_id);
	 	    
			 strApproverId       = (String) itr.next();
			  strApproverRole     = (String)itr.next(); 
			  strApproverOrderId  = intCounter+"";
			  objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
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
			  intSuccess6   =  objCstmt.executeUpdate();
			  objCstmt.close();
			  if(intSuccess6 == 0)
				 break;
			}
			strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
		}//end of if
		else
		{
			//System.out.println("001");
			objCon.rollback();
			strTravel_Id = null;
			strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);
		}
	  }
	  catch(Exception e)
	  {
		  //System.out.println("002");
		  System.out.println("Error in Insertion block of T_IntTrv_Details_Post.jsp=="+e);
		  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);
		  /*try
		  {
			  //PROCEDURE for Delete date from all the tables because some error occured in insertion of data
	          objCstmt             = objCon.prepareCall("{?=call PROC_DELETE_ALL_INT_AT_INSERTION_ERROR(?,?,?)}"); 
	          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	          objCstmt.setString(2, strTravel_Req_Id);
	          objCstmt.setString(3, strTravel_Id);
	          objCstmt.setString(4, strTravelType);          //set the Travel Type(I-international, D-Domestic)
	          intSuccess5      =  objCstmt.executeUpdate();
	          objCstmt.close();
			  strTravel_Req_Id = null;
			  strTravel_Id     = null;
			 // System.out.println("11 --> ");
		  }
		  catch(Exception e1)
		  {
			  System.out.println("Error in nested catch block of Insertion block of M_IntTrv_Details_Post.jsp=="+e1);
		  }*/
	  }
	  //System.out.println("approverList----0.1-->"+approverList);  
	  if(intSuccess1 > 0 && intSuccess2 > 0 && intSuccess3 > 0 && intSuccess4 > 0 && intSuccess5 >0 && intSuccess6 >0)
	  {
		//objCon.commit();   
	  }
	  else
	  {
		//objCon.rollback();
	  }
	}
	else
	{
		strTravel_Req_Id   = strTravelReqId;
	    strTravel_Id       = strTravelId;   
	    strTravel_Req_No   = strTravelReqNo; 
		try
		{
	      //PROCEDURE for DELETE DATA FROM THE  T_JOURNEY_DETAILS_INT, T_RET_JOURNEY_DETAILS_INT AND T_APPROVERS
		  objCon               =  dbConBean.getConnection(); 
	      //objCon.setAutoCommit(false);
	      objCstmt             = objCon.prepareCall("{?=call PROC_DELETE_FROM_INT_TABLE(?,?,?)}"); 
	      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strTravel_Req_Id);
	      objCstmt.setString(3, strTravel_Id);
		  objCstmt.setString(4, strTravelType); 
	      intSuccess1   =  objCstmt.executeUpdate();
	      objCstmt.close();
	      //System.out.println("a " + intSuccess1);
	   	  //PROCEDURE for INSERT data in T_TRAVEL_DETAIL_INT
	   	  //add on parameter to insert board member by manoj chand on 27 march 2012
	      objCstmt            =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
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
	      objCstmt.setString(11, strVisa);              //set the Traveller Visa Required
	      objCstmt.setString(12, strVisaComment);       //set the Traveller Visa Comment
	      objCstmt.setString(13, strInsurance);         //set the Traveller Isurance Required
	      objCstmt.setString(14, strNominee);           //set the Traveller's Nominee
	      objCstmt.setString(15, strRelation);          //set the Traveller's Relation
	      objCstmt.setString(16, strInsuranceComment);  //set the Traveller's Insurance Comment
	      objCstmt.setString(17, strHotel);             //set the Traveller Hotel Required
	      objCstmt.setString(18, strHotelBudget);       //set the Traveller Hotel Budget
		  //
	      objCstmt.setString(19, strplace);  
		  //
	      objCstmt.setString(20, strBudgetCurrency);     //set the Traveller Hotel Budget Currency
	      objCstmt.setString(21, strOtherComment);      //set the Traveller Remark(in table)
	      objCstmt.setString(22, strReturnType);        //set the Traveller Return Type if(user fill the return date then Return Type is 2 otherwise 1
	      objCstmt.setString(23, Suser_id);             //set the current user Login UserId
		  objCstmt.setString(24, strSelectManager);     //set the select Approver radio button (manual or automatic)
	
	     //NEW
		 objCstmt.setString(25, strManagerId);             //set the select Approver radio button (manual or automatic)
		 objCstmt.setString(26, strHodId);             //set the select Approver radio button (manual or automatic)
	     //
	 	 objCstmt.setString(27, strCARD_TYPE);		// set credit card info
	       //22-02-2007  
		  objCstmt.setString(28,strCARD_HOLDER_NAME);
	     //22-02-2007
		  objCstmt.setString(29, strCARD_NUMBER1);	//set credit card number1
		  objCstmt.setString(30, strCARD_NUMBER2);	//set credit card number 2
		  objCstmt.setString(31, strCARD_NUMBER3);	//set credit card number 3
		  objCstmt.setString(32, strCARD_NUMBER4);	//set credit card number 4
		  objCstmt.setString(33, strCVV_NUMBER);	// set Expiry date
		  objCstmt.setString(34, strCARD_EXP_DATE);	 	//set CVV no
		  objCstmt.setString(35, strCheckIn); 
	  	  objCstmt.setString(36, strCheckOut); 
		  objCstmt.setString(37, strReasonForTravel);      //set the Traveller Remark(in table)
		  objCstmt.setString(38, strReasonForSkip);        //set the Reason for Skipping the Apprval Seleciton 1 and 2
	   	  objCstmt.setString(39, "");                             //MODIFIED_FIELDS
	   	  objCstmt.setString(40, strBoardMemberId);
	   	  objCstmt.setInt(41, Integer.parseInt(strCostCentre));
	   	  objCstmt.setString(42, null);   
	      intSuccess2   =  objCstmt.executeUpdate();
	      objCstmt.close();
	      //System.out.println("b "+intSuccess2);
	//PROCEDURE for UPDATE data in T__JOURNEY_DETAILS_INT
	      objCstmt             = objCon.prepareCall("{?=call PROC_UPDATE_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
	      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strTravel_Id);
	      objCstmt.setString(3, strDepCity);             //set the Traveller Return Departure City Name(TRAVEL_FROM)
	      objCstmt.setString(4, strArrCity);             //set the Traveller Return Arrival City Name(TRAVEL_TO)
	      objCstmt.setString(5, strDepDate);             //set the Traveller Departure Date
	      objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to
	      objCstmt.setString(7, strTravelMode1);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
	      objCstmt.setString(8, strNameOfAirline1);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
	      objCstmt.setString(9, strTravelClass1);        //set the Travel Class Name(in int value), e.g. First class, Business class 
	      objCstmt.setString(10, strPrefTime1);          //set the Travel Preferred Time e.g. Morning,evening etc.
	      objCstmt.setString(11, "");                    //set the Modified columns  
	      objCstmt.setString(12, Suser_id);              //set the current user Login UserId
	      objCstmt.setString(13, strSeatPrefferedFwdJny); //set the seat preffered  for forward journey added on 09-2009 bt shiv   
	      objCstmt.setInt(14, 0);
	      intSuccess4   =  objCstmt.executeUpdate();
	      objCstmt.close();
	      //System.out.println("c " + intSuccess4);
	     //PROCEDURE for UPDATE data in T_RET_JOURNEY_DETAILS_INT
	      objCstmt             = objCon.prepareCall("{?=call PROC_UPDATE_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?)}"); 
	      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	      objCstmt.setString(2, strTravel_Id);
	      objCstmt.setString(3, strDepCity1);             //set the Traveller Return Departure City Name(RETURN_FROM)
	      objCstmt.setString(4, strArrCity1);             //set the Traveller Return Arrival City Name(RETURN_TO)
	      objCstmt.setString(5, strReturnDate);             //set the Traveller Departure Date
	      objCstmt.setString(6, strJourneyOrder);        //set the Order of Traveller intrim journey(it is 1 for the actual from and to
	      objCstmt.setString(7, strTravelMode2);         //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
	      objCstmt.setString(8, strNameOfAirline2);      //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
	      objCstmt.setString(9, strTravelClass2);        //set the Travel Class Name(in int value), e.g. First class, Business class 
	      objCstmt.setString(10, strPrefTime2);          //set the Travel Preferred Time e.g. Morning,evening etc.
	      objCstmt.setString(11, "");                    //set the Modified columns  
	      objCstmt.setString(12, Suser_id);              //set the current user Login UserId
	      objCstmt.setString(13, strSeatPrefferedRetJny); //set the seat preffered  for forward journey added on 09-2009 bt shiv   
	     
	      intSuccess4   =  objCstmt.executeUpdate();
	      objCstmt.close();
	      //System.out.println("d " + intSuccess4);
		  //PROCEDURE for INSERT data in T_APPROVERS
	      //Get the new Approve_Id from the T_Travel_Mst Table
	      String strApprove_Id  = "";
		  strApprove_Id       =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";
	      if(strSelectManager != null && strSelectManager.equals("manual"))
	      {
			//6th March 2007
			String strTravellerRole  = "";
			String strUnitHead       = "0";          //0 for no and 1 for yes
			strSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,'OR'))) AS ROLE_ID, LTRIM(RTRIM(ISNULL(UNIT_HEAD,'0'))) AS UNIT_HEAD FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;
			//System.out.println("Query "+strSql);
			rs     = dbConBean1.executeQuery(strSql);
			if(rs.next())
			{
				 strTravellerRole = rs.getString("ROLE_ID");
				 //strUnitHead	  = rs.getString("UNIT_HEAD");	
				 if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
				 {
					approverList.clear();
				 }
			}
			rs.close();	
	
	//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
				strSql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS (NOLOCK) where userid="+strTravellerId+" and site_id="+strSiteId+" and status_id=10 and unit_head=1";
				//System.out.println("Query "+strSql);
				rs = dbConBean1.executeQuery(strSql);
				if(rs.next())
				{
					strUnitHead			=	rs.getString(1).trim();			
				}
				rs.close();
	//------------- Start Added by Sachin Gupta on 4/24/2007 for one UnitHead for multiple site---------------
			if(strTravellerRole.equalsIgnoreCase("CHAIRMAN"))
			{
				//approverList.clear();
				strSql = "SELECT LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE, APPROVER_ID, SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+"  AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
				//System.out.println("Query "+strSql);
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
			//6th March 2007
				if(strManagerId != null)
				{
					approverList.add(strManagerId);
					approverList.add("WORKFLOW");
				}
				if(strHodId != null)
				{
					//if condition added on 23 jyly 2013 by manoj chand to prevent addition of approval level 1 approver in level 2.
					if(!approverList.contains(strHodId)){
						approverList.add(strHodId); 
						approverList.add("WORKFLOW");
					}
				}
				//added by manoj chand on 22 mar 2013 to add board member after approver 1 and 2
				if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") &&  strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-1")){
					approverList.add(strBoardMemberId); 
					approverList.add("WORKFLOW");
				}
				
				//System.out.println("updat block for before default approver  level aprover"+approverList);
				
				strSql = "SELECT APPROVER_ID, LTRIM(RTRIM(DBO.USER_ROLE(APPROVER_ID))) AS USERROLE , SITE_ID, ORDER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='I' AND sp_role="+strWorkFlowName+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 4";
			//	System.out.println("Query "+strSql);
				rs     = dbConBean1.executeQuery(strSql); 
				
				
				//System.out.println("for sql0000000 "+strSql);
				
				while(rs.next())
				{
					// System.out.println("approverList--1-->"+approverList);
					 String strTempApproverId =  rs.getString("APPROVER_ID").trim();
					 strUserRole = rs.getString("USERROLE");
					 //if traveller id is unit head of the site then it would not be appear in the approver list.	
					 if(strUnitHead.equalsIgnoreCase("1") && strTravellerId.equals(strTempApproverId))	
					 {
					 }//@Gaurav 08-May-2007  For Two Unit Heads belonging to the same site.
					//STATUS_ID=10 ADDED BY MANOJ CHAND ON 17 APRIL 2012
						 String strQuery="Select Unit_Head from USER_MULTIPLE_ACCESS (NOLOCK) where USERID="+strTempApproverId+" and SITE_ID="+strSiteId+" AND UNIT_HEAD=1 AND STATUS_ID=10 ORDER BY 1";
						 //System.out.println("Query "+strQuery);
						 rs1     = dbConBean2.executeQuery(strQuery);					 
						 if(strUnitHead.equalsIgnoreCase("1") && rs1.next()) {	}
						 //End of modification
					 else
					 {     
					  //added code for checking if approver is exits in defualt approver list on 19-01-2009
				      //System.out.println("for approverList addtion "+approverList.contains(strTempApproverId));
					  //modified by vaibhav on jul 15 2010 added "approverList.contains("WORKFLOW")" condition in if

						if(approverList.contains(strTempApproverId) && approverList.contains("WORKFLOW")){  
	                      approverList.remove(strTempApproverId); 
						  approverList.remove("WORKFLOW"); 
	                      }
					         
								approverList.add(strTempApproverId);
								if(strUserRole != null && strUserRole.equalsIgnoreCase("OR"))
								{
									strUserRole = "DEFAULT";
								}
								
								approverList.add(strUserRole); 
					 
						
					 }rs1.close();
				} 
				rs.close();	
			}//6th march 2007
	      }
	    
	//
	
	
	//System.out.println("approverList--1.1->"+approverList);
	//new code added for removing traveller name from approver list if he/she Exist on 17 - March -2009 by shiv sharma 
	
	
	 strSql = "SELECT  isnull(MUI.ROLE_ID,'OR') as ROLE_ID, TTDI.TRAVELLER_ID as TRAVELLER_ID FROM T_TRAVEL_DETAIL_INT AS TTDI (NOLOCK) INNER JOIN M_USERINFO AS MUI (NOLOCK) ON TTDI.TRAVELLER_ID = MUI.USERID "+
	 		  "	WHERE     (TTDI.TRAVEL_ID = "+strTravel_Id+")";
	 //System.out.println("Query "+strSql);
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
	 
	   if(strManagerId==null || !strManagerId.equals(strIDofTraveler) )
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
	
	
	 //ADDED BY MANOJ CHAND ON 28 MARCH 2012 TO ADD BOARD MEMBER IN SECOND LAST POSITION IN APPROVER LIST
	   if(strHidAppFlag.equalsIgnoreCase("Y") && strHidAppShowBMFlag.equalsIgnoreCase("Y") &&  strBoardMemberId!=null && !strBoardMemberId.equalsIgnoreCase("-1")){
		  /* int s=approverList.size();
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
	     //System.out.println("approverList--2-->"+approverList);  

	     while(itr.hasNext())
	     {
	        intCounter++;  
		    //strApprove_Id       =  dbUtilityBean.getNewGeneratedId("APPROVE_ID")+"";  //NO NEED GENERATION OF THIS ID DUE TO FIELD IS AUTOGENERATED IN THE T_APPROVER TABLE
		    strApproverId       = (String) itr.next();
		    strApproverRole     = (String)itr.next(); 
	 	    strApproverOrderId  = intCounter+"";
	 	   
	        objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_APPROVERS(?,?,?,?,?,?,?,?,?,?)}"); 
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
		    intSuccess5   =  objCstmt.executeUpdate();
		    objCstmt.close();
		   // System.out.println("e " + intSuccess5);
	//	    objCon1.close();
		    if(intSuccess5 == 0)
			   break;
	      }
		  strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
		}
		catch(Exception e)
		{
			//System.out.println("003");
			strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);
			System.out.println("Error in Update bolock of T_IntTrv_Details_Post.jsp=="+e);
		}	
		
	    if(intSuccess1 > 0 && intSuccess2 > 0 && intSuccess3 > 0 && intSuccess4 > 0 && intSuccess5 >0 )
	    {
		   objCon.commit();   
	    }
	    else
	    {
	    	//commented by manoj chand on 31 may 2012 as it is giving exception for jtds driver case
		  // objCon.rollback();
	    }
	}//end of else 
	%>
	
	<%
	   dbConBean2.close();
	   dbConBean1.close();
	   dbConBean.close();  // CLOSE ALL CONNECTION
	   //System.out.println("strMessage:"+strMessage+ " strWhatAction:"+strWhatAction);
	if(strMessage!=null && strMessage.equals(dbLabelBean.getLabel("message.global.save",strsesLanguage)))
	{
		if(strWhatAction != null && strWhatAction.equals("save"))
		{
			url = "T_IntTrv_Details.jsp?message="+strMessage+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travelReqNo="+strTravel_Req_No+"&manager="+strManagerId+"&hod="+strHodId+"&interimId="+strInterimId+"&boardmember="+strBoardMemberId;
		}
		else if(strWhatAction != null && strWhatAction.equals("saveExit"))
		{
			url = "T_TravelRequisitionList.jsp?travel_type=INT";
		}
		else if(strWhatAction != null && strWhatAction.equals("saveProceed"))
		{
			//change by manoj
			url = "T_IntPassport_Details.jsp?travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strSiteId+"&travelReqNo="+strTravel_Req_No+"&interimId="+strInterimId;
			
		}
		else
		{
		}
	}
	else
	{	
		//System.out.println("004");
		url = "T_IntTrv_Details.jsp?message="+strMessage+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travelReqNo="+strTravel_Req_No+"&manager="+strManagerId+"&hod="+strHodId+"&interimId="+strInterimId+"&boardmember="+strBoardMemberId;
	}
	   response.sendRedirect(url);    
	}%>
	</html>