	<% 
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				        :Shiv sharma 
	 *Date of Creation 	    :
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			        :STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 		     	:This is first jsp file  for create the Travel Requsition
							             
	 *Reason of Modification: change in update querty to update accomodation information in table
	 *Date of Modification  : 23 sep 2011
	 *Modified By		    : Manoj Chand
	 *Editor				:Eclipse 3.5
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	: 29 March 2012
	 *Modification			:add one parameter no 41 in proc_insert_t_traveldetails_int for boardmember
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:03 August 2012
	 *Modification			:pass one parameter costcentre in procedure
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:05 August 2012
	 *Modification			:pass gender in procedure PROC_INSERT_T_TRAVEL_DETAIL_INT
	 *******************************************************/
	%>
	<%@ page import="java.net.URLEncoder" %>
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
	 
	<style type="text/css">
	<!--
	.style2 {font-size: 10px; font-weight: bold; color: #FF7D00; }
	-->
	</style>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Untitled Document</title>
	
	<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css"/>
	 <script language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></script>
	<%
	request.setCharacterEncoding("UTF-8");
	//Global Variables declared and initialized
	//System.out.println("GID POST");
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
	int intSuccess10                = 0;
	int iSuccess3					   = 0;	
	int intSuccess11				   = 0;	
	int intCounter                     = 0;
	String strSql                       =  null;            // String for Sql String
	Connection objCon            =  null;            //Object for Connection 
	Connection objCon1          =  null;            //Object for Connection 
	ResultSet rs,rs1,rs2          =  null;            // Object for ResultSet
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
	
	String strManagerId             =  "";
	String strHodId                 =  "";
	
	String strTravelType            =  "I";     //I for International
	
	String strTravelStatusId        =  "1";  
	
	ArrayList approverList1         =  new ArrayList();
	ArrayList l1                            =  new ArrayList();
	
	String strTravelReqId            =  "";
	String strTravelId				      =  "";
	String strTravelReqNo          =  "";
	String strActionFlag              =  "";
	String G_userID	 	  ="";
	
	//ADDED BY MANOJ ON 23 MAY 2011
	String strFlagForUpdate= "";
	
	
	String strWhatAction								=  "";    
	String url													=  ""; 
	String strMessage									=  ""; 
	String strInterimId									=  "";  
	String strUserRole								     =  ""; 
	String strplace									  	     =  ""; 
	String strDOB										     ="";
	String strGender										 ="";
	String strPassport_issue_date				 ="";
	String strPassport_expire_date                ="";
	String strPassport_issue_place               ="";
	 
	String strECR											  ="";
	String strTravellerFirstName                    ="";
	 String strTravellerLastName					    ="";
	
	String strPassport                                     ="";
	String strNationality                                     ="";
	String strTACurrency[]                              =null;
	
	/// forex related  variables 
	String strExpID[]                                    =  {"1","2","3","4"};
	String strEntPerDay[]                             =  null;
	String strTotalTourDay[]                         =  null;
	String strTotalForex[]							    =  null; 
	String strContingecies[]						    =  null; 
	//added by manoj chand on 12 oct 2012
	String strEntPerDay2[]	      =  null;
	String strContingecies2[]     =  null;
	String strTotalTourDay2[]     =  null;
	String strExRate[]        	  =  null;
	String strTotalINR[]          =  null;
	String strHiddenValue[]		  =  null;
	
	String strTotalAmount							=  "";  
	String strFlagValue                              =  "";
	String stUserIDMax								="";
	String strG_userID								="";
	String  strExpRemarks							="";
	String strCurrencyflag							="";
	
	
	
	String strDeptcity					="";
	
	String strArialcity					="";
	String strdepatDate					="";
	String strprefferedAirline			="";
	String strprefferedTime				="";
	String strClass						="";
	String strprefferedSeat				="";
	String strCostCentre="0";
	String strSexFlag="";
	String strCancelledReqId		    ="0";
	
	 strDeptcity					=request.getParameter("depCity"); 
	 strArialcity					=request.getParameter("arrCity");		 
	 strdepatDate					=request.getParameter("depDate");
	 strprefferedAirline			=request.getParameter("nameOfAirline");
	 strprefferedTime				=request.getParameter("preferTime");
	 strClass						=request.getParameter("travelClass"); 
	 strprefferedSeat				=request.getParameter("seatpreference"); 
	
		
	strSiteId       =  (request.getParameter("site")==null || request.getParameter("site").equals("null")) ? strSiteIdSS : request.getParameter("site");
	
	strG_userID                  =  request.getParameter("G_userID")==null ?"" :request.getParameter("G_userID");    // from hidden field
	strTravelReqId                  =  request.getParameter("travelReqId")==null ?"" :request.getParameter("travelReqId");    // from hidden field
	strTravelId                     =  request.getParameter("travelId")==null ?"" :request.getParameter("travelId");       // from hidden field
	strFlagValue                     =  request.getParameter("strFlag")==null ?"" :request.getParameter("strFlag");       // from hidden field
	strWhatAction                   =  request.getParameter("whatAction");     //from hidden field        
	
	//added by manoj chand on 20 sept 2011 to add accomodation required
	String strsaveFlag = request.getParameter("saveflag")==null?"":request.getParameter("saveflag");
	String strHotelRequired             =  request.getParameter("hotel") == null ? "0" : request.getParameter("hotel");
	String strHotelBudget               =  request.getParameter("budget")==null ? "":request.getParameter("budget");
	String strBudgetCurrency               =  request.getParameter("currency")==null ? "USD":request.getParameter("currency");
	String strCheckin					=  request.getParameter("checkin") == null ? "" : request.getParameter("checkin");
	String strCheckout					=  request.getParameter("checkout") == null ? "" : request.getParameter("checkout");
	String strPlace			            =  request.getParameter("place")==null?"":request.getParameter("place");
	String strRemarks                   =  request.getParameter("otherComment")==null?"":request.getParameter("otherComment"); 	 
	strCostCentre			   =  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre"); 
	strCancelledReqId		   =  request.getParameter("cancelledTravelReq")==null?"0":request.getParameter("cancelledTravelReq");
	objCon		=dbConBean.getConnection();
	//Get the new Travel_Req_Id from the TID Table 
	String strTravel_Req_Id  = "";
	String strTravel_Id  = "";
	String strTravel_Req_No = "";  
	int intSuccess13 =0;
	
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strSiteId, "0");
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
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "Group_T_IntTrv_DetailsPost.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {

	if(strTravelReqId != null && strTravelReqId.equals("new")  && !strWhatAction.equals("update"))
	{
		   
		  strTravel_Req_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_REQ_ID")+"";
		  strTravel_Id			=  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_INT")+"";	  
		  //change by manoj on 05 oct 2011 to show selected site name in request number
		  if(!strSiteId.trim().equalsIgnoreCase(strSiteIdSS.trim())){
			  String strsiteName="";
			 strSql="select site_name from m_site where site_id="+strSiteId;
			 rs = dbConBean.executeQuery(strSql);
				while(rs.next()){  
					strsiteName = rs.getString("site_name");	 		
				 }
				strTravel_Req_No = "GR/TEMP/"+strsiteName.trim()+"/INT/"+strTravel_Id;
				rs.close();				
		  }else{
			  strTravel_Req_No = "GR/TEMP/"+strSiteFullName.trim()+"/INT/"+strTravel_Id;  
		  }
		  	  
		  strActionFlag   = "insert";
	}
	else  if(strFlagValue.equals("1") && !strWhatAction.equals("update") && !strWhatAction.equals("itenupdate")) 
	{
		  strActionFlag   = "insert";
		  strTravel_Req_Id=strTravelReqId;
		  strTravel_Id=strTravelId ;
	}
	else if(strFlagValue.equals("1") && strWhatAction.equals("itenupdate"))
	{	 
		strActionFlag   = "Itanarydetails";  
		strTravel_Id     = strTravelId;
	}
	else
	{
		strActionFlag   = "update"; 
		strTravel_Id     = strTravelId;
	}
	
	           
			strTravellerFirstName               =  request.getParameter("firstName").trim();	
			strTravellerLastName                =  request.getParameter("lastName").trim();
	        strDesigId                          =  request.getParameter("designation").trim();
			strDOB                              =  request.getParameter("passport_DOB").trim();
			strAge                              =  request.getParameter("age").trim();
	        strGender                           =  request.getParameter("Gender").trim();
	        strMeal                             =  request.getParameter("meal").trim();
	        strPassport                         =  request.getParameter("passportNo").trim();
	        strNationality                      =  request.getParameter("nationality") != null ? request.getParameter("nationality").trim() : "";
	        strPassport_issue_date		        =  request.getParameter("passport_issue_date").trim();
	        strPassport_expire_date		        =  request.getParameter("passport_expire_date").trim();
	        strPassport_issue_place		        =  request.getParameter("passport_issue_place").trim();
	 		strVisa								=  request.getParameter("visa").trim();
	        strECR								=  request.getParameter("ECR").trim();
		    strCurrencyflag						= request.getParameter("currencyflag"); 
	
		   // System.out.println("strCurrencyflag-------->"+strCurrencyflag);
		    
			 if (strCurrencyflag.equals("disabled"))
			 {
				//COMMENTED BY MANOJ CHAND AS THEIR IS NO NEED OF THIS DISTINCT CURRENCY	
				 /*strSql = "SELECT distinct currency FROM  T_TRAVEL_EXPENDITURE_INT WHERE TRAVEL_ID = "+strTravelId+"";	       
					rs = dbConBean.executeQuery(strSql);
					while(rs.next()){  
						strTACurrency = rs.getString(1);	 		
					 } 
					rs.close();*/
				 strTACurrency							= request.getParameterValues("expCurrency");	
	      	 }
			 else{
	         strTACurrency							= request.getParameterValues("expCurrency");   
			 }
	   
	        strEntPerDay                     =  request.getParameterValues("entitlement");     
	        strTotalTourDay                  =  request.getParameterValues("tourDays");     
		    strTotalForex                    =  request.getParameterValues("totalForex");      
	        strContingecies                  =  request.getParameterValues("contingencies");
	      //ADDED BY MANOJ CHAND ON 12 OCT 2012 TO GET VALUES 
	  	    strEntPerDay2                    =  request.getParameterValues("entitlement2");     
	  	    strTotalTourDay2                 =  request.getParameterValues("tourDays2");     
	  	    strContingecies2                 =  request.getParameterValues("contingencies2");
	  	    strExRate              	  	     =  request.getParameterValues("exRate");     
	  	    strTotalINR						 =  request.getParameterValues("totalInr");
	  	    strHiddenValue					 =  request.getParameterValues("hd");
	        
	        
	        
	        strTotalAmount                   =  request.getParameter("grandTotalForex");    
	        strExpRemarks                    =  request.getParameter("expRemarks");   
			
	        //System.out.println("grandTotalForex--->"+strTotalAmount);
	        //System.out.println("strExpRemarks--->"+strExpRemarks);
	  //code to update traveller those are in return journey added by shiv sharma on 23-jun-2009
	        String [] strUsertoReturn         =request.getParameterValues("userids"); 
	    	String strtext="-1";  
	    	int intTotleid=0; 
	    	String strUserids               ="-1"; 
	    	
	    	
	    	  
	    	 
	    		if (strUsertoReturn!=null){ 
	    				 intTotleid=strUsertoReturn.length ;  
	    				 for(int i=0;i<intTotleid;i++)
	    				 {
	    				      strUserids=strUsertoReturn[i];  
	    				      if(intTotleid>1){
	    				    	  strtext=strtext+","+strUserids.trim();    
	    				      }else{ 
	    				    	  strtext=strUserids.trim();   
	    				      }
	    				 }  
	    		}	 
	    				 objCon		=dbConBean.getConnection();
	    		         objCstmt             =  objCon.prepareCall("{?=call PROC_GROUP_RETURN_JOURNEY(?,?)}");
	    		 	     objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	    		 	     objCstmt.setString(2, strtext.trim()); 
	    		 	     objCstmt.setInt(3, Integer.parseInt(strTravel_Id.trim()));  
	    		  	     intSuccess10  =  objCstmt.executeUpdate();   
	    		 	     objCstmt.close();
	    				
	    		  
	if(strActionFlag!=null && strActionFlag.equals("insert")) 
	{
//System.out.println("----------ACTIONFLAG=INSERT------------------");		
	    try
	        {
			      objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?,?,     ?,?,?,?,   ?,?,?,?,?,     ?,?,?,?,    ?,?,?,?,   ?,?,?, ?,?,?,?,?,?,?)}");
		          objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	  
			         objCstmt.setString(2,"0");											   //set  G_userid
					 objCstmt.setString(3,strTravel_Id);								   //travel_id 
					 objCstmt.setString(4, strTravelType);						   //t ravel_type	
					 objCstmt.setString(5, strTravellerFirstName);		 	    //first Name	of traveler
					 objCstmt.setString(6, strTravellerLastName);              //last name  of traveler 
					 objCstmt.setString(7,strSiteId);									  //site id of traveler   
					 objCstmt.setString(8, strDesigId);								  //desig id of  traveler 
					 objCstmt.setString(9, "10");											 //status_id of requsition 10 					
					 objCstmt.setString(10, strPassport);						     //passport no of user 
					 objCstmt.setString(11, strPassport_issue_date);        //strPassport_issue_date
					 objCstmt.setString(12, strPassport_issue_place);       // lace of passport Issue  
					 objCstmt.setString(13, strPassport_expire_date);		 //strPassport_expire_date
					 objCstmt.setString(14, strAge);									//age of  	traveler
					 objCstmt.setString(15, strECR);									 //ECR  value		
					 objCstmt.setString(16, strDOB);							 //strDOB       
					 objCstmt.setString(17, strVisa);                                    //visa required 
					 objCstmt.setString(18, "I");											//record type I/U 				 
					 objCstmt.setString(19, strGender);								//gender 
					 objCstmt.setString(20, "0");                                                   //identity _id 
					 objCstmt.setString(21, "0");											//identity no	
					 objCstmt.setString(22, strMeal);				//mael prefrence
					 objCstmt.setString(23, strTotalAmount);   //float set  strTotalAmount
					 objCstmt.setString(24, strExpRemarks);             //set the current user Login UserId
					 objCstmt.setString(25, Suser_id);             //set the current user Login UserId
					 objCstmt.setString(26, "INSERT");   
					 objCstmt.setString(27, "");                                 //operation for procedure 
				 	 objCstmt.setString(28, strNationality);   
				 	 objCstmt.setString(29, "N");
				 	 objCstmt.setString(30, "");
				 	 objCstmt.setString(31, "");
				 	 objCstmt.setString(32, "");
					 objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
					  intSuccess3  = objCstmt.executeUpdate();
					  objCstmt.close();
	 		   
			           
	                   //if procedure   PROC_T_GROUP_USERINFO run sucessfully then fineduser id of person for which forex break up will be 
			           //adde in tabel  T_TRAVEL_EXPENDITURE_INT   
			           if(intSuccess3>0)
		                  {
	                           strSql=" SELECT   MAX(G_USERID)  as MAXuserID  FROM    T_GROUP_USERINFO WHERE     (TRAVEL_ID = "+strTravel_Id+") ";
	                           rs       =   dbConBean.executeQuery(strSql);  
					           while(rs.next()){
						  			   stUserIDMax= rs.getString("MAXuserID");
	           	                                      }
	                           rs.close();
			              }
			          //inser the data    when user id found  from T_Group _userinfo
						if(stUserIDMax!="" && stUserIDMax!=null )
								{
								/* for(int i=0; i<strEntPerDay.length; i++)
									{
									objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?    ,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2, strTravel_Id);
									objCstmt.setString(3, strExpID[i]);                       //set the ExpId
									objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
								    objCstmt.setString(5, strEntPerDay[i]);
								    objCstmt.setString(6, strTotalTourDay[i]);
								    objCstmt.setString(7, strTotalForex[i]);
						            objCstmt.setString(8, Suser_id);
						            objCstmt.setString(9, stUserIDMax);  
						           intSuccess4   =  objCstmt.executeUpdate();
						           objCstmt.close();   		  
						          }
	                          
						         int j = 0;
						         //PROCEDURE to insert the row in T_TRAVEL_EXPENDITURE_INT Table
						  for(int i=2; i<strExpID.length; i++)
						          {          
						            objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?    ,?)}");
						            objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						            objCstmt.setString(2, strTravel_Id);
						            objCstmt.setString(3, strExpID[i]);                     //set the ExpId
						            objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
						            objCstmt.setString(5, "0");
						            objCstmt.setString(6, "0");
						            objCstmt.setString(7, strContingecies[j++]);
						            objCstmt.setString(8, Suser_id);
						            objCstmt.setString(9, stUserIDMax);  
						            intSuccess5   =  objCstmt.executeUpdate();
						            objCstmt.close();		  
						         }*/
						         //for block added by manoj chand on 12 oct to save forex details info of each group traveller
						   for(int i=0; i<strEntPerDay.length; i++)
							{
								if(strEntPerDay[i]==null || strEntPerDay[i].equals(""))
								 strEntPerDay[i]="0";
								if(strTotalTourDay[i]==null || strTotalTourDay[i].equals(""))
								 strTotalTourDay[i]="0";
								if(strEntPerDay2[i]==null || strEntPerDay2[i].equals(""))
								 strEntPerDay2[i]="0";
								if(strTotalTourDay2[i]==null || strTotalTourDay2[i].equals(""))
								 strTotalTourDay2[i]="0";
								if(strContingecies[i]==null || strContingecies[i].equals(""))
								 strContingecies[i]="0";
								if(strContingecies2[i]==null || strContingecies2[i].equals(""))
								 strContingecies2[i]="0";
								if(strTotalForex[i]==null || strTotalForex[i].equals(""))
								 strTotalForex[i]="0";
								if(strTACurrency[i]!=null)
									strTACurrency[i]=strTACurrency[i].trim();
								if(strTotalINR[i]==null || strTotalINR[i].equals(""))
									  strTotalINR[i]="0";
								  
							    objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?,?,?,?,?)}");
					            objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					            objCstmt.setString(2, strTravel_Id);
						        objCstmt.setString(3, strTACurrency[i]);
						        objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[i]));                       //set the ExpId
						        objCstmt.setString(5, strTotalTourDay[i]);                //set the current user Login UserId
						        objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[i]));
								objCstmt.setString(7, strTotalTourDay2[i]);
								objCstmt.setDouble(8, Double.parseDouble(strContingecies[i]));
								objCstmt.setDouble(9, Double.parseDouble(strContingecies2[i]));
							    objCstmt.setDouble(10,Double.parseDouble(strTotalForex[i]));
								objCstmt.setString(11, Suser_id); 
								objCstmt.setString(12, stUserIDMax);    //added new field   for chenge in Group travel Requsition  byu shiv  sharma 19-Feb-08
								if(strHiddenValue[i].equals("v") && (Double.parseDouble(strTotalINR[i])>0 || i==0)){
									intSuccess4   =  objCstmt.executeUpdate();
									intSuccess5=intSuccess4;
								  }
								objCstmt.close();				   
							}
			   }//end of if block 
	
	
						//PROCEDUER TO UPDATE     T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP TO T_TRAVEL_DETAILS_INT
	
			              objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP(?)}");
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id);
		               	  intSuccess10  =  objCstmt.executeUpdate();
						  objCstmt.close();		  
						  
			   
			       
			            if (intSuccess3 >0 &&  intSuccess4>0 && intSuccess5>0)
				   	           {
				   					strMessage=dbLabelBean.getLabel("message.createrequest.useradded",strsesLanguage);
							   }
					 else
		                      {
				   		            strMessage=dbLabelBean.getLabel("message.createrequest.useraddedfailed",strsesLanguage); 
				              }
	                   if(!strFlagValue.equals("1"))          
							{
			           			    //"==========when====new request is created=============");
									objCstmt  =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_MST(?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2, strTravel_Req_Id);
									objCstmt.setString(3, strSiteId);                 //set the  Site Id  for whicb  the request is created 
									objCstmt.setString(4, Suser_id);                //set the current user Login UserId
									objCstmt.setString(5, strTravelType);
									intSuccess1   =  objCstmt.executeUpdate();
									objCstmt.close();
									 
	
								    //PROCEDURE for INSERT data in T_TRAVEL_STATUS
									objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_STATUS(?,?,?,?,?)}"); 
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2, strTravel_Req_Id);
									objCstmt.setString(3, strTravel_Id);
									objCstmt.setString(4, strTravelStatusId);//set the Travel Status Id(1-Temp,2-Permanent,3-Return,4-Rejected,6-Canceled,10-Approved by All)
									objCstmt.setString(5, strTravelType);    //set the Travel Type(I-international, D-Domestic)
									objCstmt.setString(6, strCancelledReqId);
									intSuccess2  =  objCstmt.executeUpdate();
									objCstmt.close();
						  
									 
						//added by manoj chand on 07 august to insert sex of origination in group/guest request.
						if(sGender.trim().equalsIgnoreCase("Male")){
							strSexFlag="1";
						}
						if(sGender.trim().equalsIgnoreCase("Female")){
							strSexFlag="0";
						}
						
							
							        //procedure to insert details  of orignatior open added by shiv on  
							        
									    objCstmt  =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");   
							        	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									    objCstmt.setString(2, strTravel_Req_Id);
										objCstmt.setString(3, strTravel_Id);
										objCstmt.setString(4, strTravel_Req_No);
										objCstmt.setString(5, strSiteId);                   //set the Traveller Site Id
										objCstmt.setString(6, Suser_id);                  //set the current user Login UserId
										objCstmt.setString(7, "");                      //set the Traveller Age
										objCstmt.setString(8, strSexFlag);                //set the Traveller Sex
										objCstmt.setString(9, "");                              //set the Traveller Departure Date
										objCstmt.setString(10, "");                            //set the Traveller Meal
										objCstmt.setString(11, "");                            //set the Traveller Visa Required
										objCstmt.setString(12, "");                            //set the Traveller Visa Comment
										objCstmt.setString(13, "");                            //set the Traveller Isurance Required
										objCstmt.setString(14, "");                            //set the Traveller's Nominee
										objCstmt.setString(15, "");                             //set the Traveller's Relation
										objCstmt.setString(16, "");                             //set the Traveller's Insurance Comment
										objCstmt.setString(17, "");                             //set the Traveller Hotel Required
										objCstmt.setString(18, "");                             //set the Traveller Hotel Budget
										objCstmt.setString(19, "");
										objCstmt.setString(20, "");                              //set the Traveller Hotel Budget Currency
										objCstmt.setString(21, "");                              //set the Traveller Remark(in table)
										objCstmt.setString(22, "");								//set the Traveller Return Type if(user fill the return date then Return Type is 2 otherwise 1							
										objCstmt.setString(23, Suser_id);                  //set the current user Login UserId
									   	objCstmt.setString(24, "manual");                             //set the select Approver radio button (manual or automatic)
										objCstmt.setString(25, "");                              //set the select Approver radio button (manual or automatic)
										objCstmt.setString(26, "");                              //set the select Approver radio button (manual or automatic)
										objCstmt.setString(27, "");
										objCstmt.setString(28,"");
										objCstmt.setString(29, ""); 
									    objCstmt.setString(30, ""); 
								  	    objCstmt.setString(31, ""); 
									    objCstmt.setString(32, ""); 
									    objCstmt.setString(33, ""); 
									    objCstmt.setString(34, ""); 
									    objCstmt.setString(35, ""); 
								  	    objCstmt.setString(36, ""); 
									    objCstmt.setString(37, "");                               //set the Reason For Travel
									    objCstmt.setString(38, "");                               //set the Reason for Skipping the Apprval Seleciton 1 and 2
									    objCstmt.setString(39, "");                                //Modified Fields 
									    objCstmt.setString(40, "Y");                               //Added new field for setting Flage for group request
									    //41 NUMBER PARAMETER ADDED BY MANOJ CHAND ON 27 MARCH 2012
									    objCstmt.setString(41, "");
									    objCstmt.setInt(42, Integer.parseInt(strCostCentre));
									    objCstmt.setString(43, "");
										objCstmt.setString(44, "2");
										objCstmt.setString(45, "2");
										objCstmt.setString(46, "0");
										objCstmt.setString(47, "");
										objCstmt.setString(48, "0");
										objCstmt.setString(49, "1");
										objCstmt.setString(50, "2");
										objCstmt.setString(51, "2");
										objCstmt.setString(52, "");
										objCstmt.setString(53, "");
										objCstmt.setString(54, null);
										objCstmt.setString(55, "");
										objCstmt.setString(56, "0");
										objCstmt.setString(57, null);
										objCstmt.setString(58, null);
									    intSuccess6   =  objCstmt.executeUpdate();
									    
								   	    objCstmt.close();
									  
										//procedure  to enter the details in T_JOURNEY_DETAILS_INT
										objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
										objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						//System.out.println("strTravel_Id-------post----->"+strTravel_Id);
										objCstmt.setString(2, strTravel_Id);
										
										//changed by manoj chand on 23 may 2011 START HERE
						//System.out.println("travel_from---->"+strDeptcity);
						//System.out.println("travel_to------>"+strArialcity);
										objCstmt.setString(3,strDeptcity );   		//set the Traveller Departure City Name(TRAVEL_FROM)
										objCstmt.setString(4,strArialcity );   		//set the Traveller Arrival City Namei(TRAVEL_TO)
										
										// END HERE
										//objCstmt.setString(3, "");   		//set the Traveller Departure City Name(TRAVEL_FROM)
										//objCstmt.setString(4, "");   		//set the Traveller Arrival City Namei(TRAVEL_TO)
										objCstmt.setString(5, "");   		//set the Traveller Departure Date
										objCstmt.setString(6, "1");  		//set the Order of Traveller intrim journey(it is 1 for the actual from and to)
										objCstmt.setString(7, "");   //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
										objCstmt.setString(8, "");   //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
										objCstmt.setString(9, "");        //set the Travel Class Name(in int value), e.g. First class, Business class 
									
	                                      //code modified  on 06/02/2008 by shiv sharma --sending  values through variables 
										objCstmt.setString(10,"");        //set the VISA_REQUIRED, e.g. 1 for yes and 2 for no
										objCstmt.setString(11,"");        //set the VISA_COMMENT
										objCstmt.setString(12, "");          //set the Travel Preferred Time e.g. Morning,evening etc.
										objCstmt.setString(13, Suser_id);              //set the current user Login UserId
										
										objCstmt.setString(14, "1");              //set the current user Login UserId
										objCstmt.setString(15, "1");
									    objCstmt.setInt(16, 0);
										//intSuccess7  =  objCstmt.executeUpdate();
										objCstmt.close();
	
										
									   // strMessage="user Added sucessfully "  ;
	                                   //procedure that update  expenditure in T_travel_details _int   table     
								        objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP(?)}");
								        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
								        objCstmt.setString(2, strTravel_Id);
											 
								         intSuccess10   =  objCstmt.executeUpdate();
									     objCstmt.close();		  
	              						 
			   		          }
				}
				catch(Exception e)
				{
					System.out.println("error in ====="+e);
				}
	 
	} 
	  //------------------------------------------------case of update------------------------------------  
	else if(strActionFlag!=null && strActionFlag.equals("update"))  
	{  
		//"================case of update============strActionFlag==== 
	  
					 G_userID =strG_userID ; 
					//Procedure for delete the date from the T_TRAVEL_EXPENDITURE_INT  
					 
					objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?,?,?,     ?,?,?,?,   ?,?,?,?,     ?,?,?,?,    ?,?,?,?,   ?,?,?, ?,?,?,?,?,?,?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  
					 objCstmt.setString(2,G_userID);											   //set  G_userid
					 objCstmt.setString(3,strTravel_Id);								           //travel_id 
					 objCstmt.setString(4, strTravelType);						              //t ravel_type	
					 objCstmt.setString(5, strTravellerFirstName);		 	              //first Name	of traveler
					 objCstmt.setString(6, strTravellerLastName);                        //last name  of traveler 
					 objCstmt.setString(7,strSiteId);									              //site id of traveler   
					 objCstmt.setString(8, strDesigId);								              //desig id of  traveler 
					 objCstmt.setString(9, "10");										           	  //status_id of requsition 10 					
					 objCstmt.setString(10, strPassport);						                  //passport no of user 
					 objCstmt.setString(11, strPassport_issue_date);                   //strPassport_issue_date
					 objCstmt.setString(12, strPassport_issue_place);                 // lace of passport Issue  
					 objCstmt.setString(13, strPassport_expire_date);		          //strPassport_expire_date
					 objCstmt.setString(14, strAge);									              //age of  	traveler
					  objCstmt.setString(15, strECR);									          //ECR  value		
					  objCstmt.setString(16, strDOB);							                  //strDOB       
					  objCstmt.setString(17, strVisa);                                             //visa required 
					  objCstmt.setString(18, "I");											          //record type I/U 				 
					  objCstmt.setString(19, strGender);								          //gender 
					  objCstmt.setString(20, "0");                                                    //identity _id 
					  objCstmt.setString(21, "0");											          //identity no	
					  objCstmt.setString(22, strMeal);				                               //mael prefrence
					  objCstmt.setString(23, strTotalAmount);                                 //float set  strTotalAmount
					   objCstmt.setString(24, strExpRemarks);                               //set the current user Login UserId
					  objCstmt.setString(25, Suser_id);                                           //set the current user Login UserId
	
					  objCstmt.setString(26, "UPDATE");                                 //operation for procedure 
					  objCstmt.setString(27, "");         
					  objCstmt.setString(28, strNationality);         //mobile no of usere
					  objCstmt.setString(29, "N"); 
					  objCstmt.setString(30, ""); 
					  objCstmt.setString(31, "");
					  objCstmt.setString(32, "");
					  objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
					  intSuccess3  = objCstmt.executeUpdate();
					  objCstmt.close();
	
						 
	
	
					  /*for(int i=0; i<strEntPerDay.length; i++)
								{
	
	
								 //objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?    ,?)}");
							     objCstmt     =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_EXPENDITURE_INT_GROUP(?,?,?,?,?,?,?    ,?)}");
								  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
								  objCstmt.setString(2, strTravel_Id);
								  objCstmt.setString(3, strExpID[i]);                       //set the ExpId
								  objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
								  objCstmt.setString(5, strEntPerDay[i]);
								  objCstmt.setString(6, strTotalTourDay[i]);
								   objCstmt.setString(7, strTotalForex[i]);
								  objCstmt.setString(8, Suser_id);
								  objCstmt.setString(9, G_userID);  
								  intSuccess4   =  objCstmt.executeUpdate();
								  objCstmt.close();   		  
								}
	
	                  
								int j = 0;
								//PROCEDURE to insert the row in T_TRAVEL_EXPENDITURE_INT Table
						 for(int i=2; i<strExpID.length; i++)
								{          
								  //objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?    ,?)}");
								  objCstmt   =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_EXPENDITURE_INT_GROUP(?,?,?,?,?,?,?    ,?)}");
								  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
								  objCstmt.setString(2, strTravel_Id);
								  objCstmt.setString(3, strExpID[i]);                     //set the ExpId
								  objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
								  objCstmt.setString(5, "0");
								  objCstmt.setString(6, "0");
								  objCstmt.setString(7, strContingecies[j++]);
								  objCstmt.setString(8, Suser_id);
	
								  objCstmt.setString(9, G_userID);  
	
								  intSuccess5   =  objCstmt.executeUpdate();
								  objCstmt.close();		  
								}*/
								//Procedure for delete the date from the T_TRAVEL_EXPENDITURE_INT AND T_CASH_BREAKUP_INT
								objCstmt             =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_Group(?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
						        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						        objCstmt.setString(2, strTravelId);
						        objCstmt.setString(3, G_userID);
						        objCstmt.setString(4, "I");
						        intSuccess1   =  objCstmt.executeUpdate();
						        objCstmt.close();
						        
						        
								for(int i=0; i<strEntPerDay.length; i++)
								{
									if(strEntPerDay[i]==null || strEntPerDay[i].equals(""))
									 strEntPerDay[i]="0";
									if(strTotalTourDay[i]==null || strTotalTourDay[i].equals(""))
									 strTotalTourDay[i]="0";
									if(strEntPerDay2[i]==null || strEntPerDay2[i].equals(""))
									 strEntPerDay2[i]="0";
									if(strTotalTourDay2[i]==null || strTotalTourDay2[i].equals(""))
									 strTotalTourDay2[i]="0";
									if(strContingecies[i]==null || strContingecies[i].equals(""))
									 strContingecies[i]="0";
									if(strContingecies2[i]==null || strContingecies2[i].equals(""))
									 strContingecies2[i]="0";
									if(strTotalForex[i]==null || strTotalForex[i].equals(""))
									 strTotalForex[i]="0";
									if(strTACurrency[i]!=null)
										strTACurrency[i]=strTACurrency[i].trim();
									if(strTotalINR[i]==null || strTotalINR[i].equals(""))
										  strTotalINR[i]="0";
								
									objCstmt     =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_INT(?,?,?,?,?,?,?,?,?,?,?)}");
									objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
									objCstmt.setString(2, strTravel_Id);
							        objCstmt.setString(3, strTACurrency[i]);
							        objCstmt.setDouble(4, Double.parseDouble(strEntPerDay[i]));                       //set the ExpId
							        objCstmt.setString(5, strTotalTourDay[i]);                //set the current user Login UserId
							        objCstmt.setDouble(6, Double.parseDouble(strEntPerDay2[i]));
									objCstmt.setString(7, strTotalTourDay2[i]);
									objCstmt.setDouble(8, Double.parseDouble(strContingecies[i]));
									objCstmt.setDouble(9, Double.parseDouble(strContingecies2[i]));
								    objCstmt.setDouble(10,Double.parseDouble(strTotalForex[i]));
									objCstmt.setString(11, Suser_id); 
									objCstmt.setString(12, G_userID);    //added new field   for chenge in Group travel Requsition  byu shiv  sharma 19-Feb-08
									if(strHiddenValue[i].equals("v") && (Double.parseDouble(strTotalINR[i])>0 || i==0)){
										intSuccess4   =  objCstmt.executeUpdate();
									  }
									objCstmt.close();
								}
							 objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP(?)}");
					         objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
											 
							 intSuccess11   =  objCstmt.executeUpdate();
							  objCstmt.close();		  
	              			
								strMessage=dbLabelBean.getLabel("message.global.updatedsuccessfully",strsesLanguage);
						   
	
	 }//end of else block 
	 else{
		 
		    strSql = "SELECT TOP 1 TRAVEL_ID FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
			rs       =   dbConBean.executeQuery(strSql);
		 if(rs.next()){
		    objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");  
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			objCstmt.setString(2, strTravel_Id);
			objCstmt.setString(3, strDeptcity);   		//set the Traveller Departure City Name(TRAVEL_FROM)
			objCstmt.setString(4, strArialcity);   		//set the Traveller Arrival City Namei(TRAVEL_TO)
			objCstmt.setString(5, strdepatDate);   		//set the Traveller Departure Date
			objCstmt.setString(6, "1");  		        //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
			objCstmt.setString(7, "1");                 //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
			objCstmt.setString(8, strprefferedAirline); //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
			objCstmt.setString(9, strClass);            //set the Travel Class Name(in int value), e.g. First class, Business class 
		
           //code modified  on 06/02/2008 by shiv sharma --sending  values through variables 
			objCstmt.setString(10,strprefferedTime);    //set the VISA_REQUIRED, e.g. 1 for yes and 2 for no
			objCstmt.setString(11,"");                  //set tmodified field 
			objCstmt.setString(12, Suser_id);           //set the Travel Preferred Time e.g. Morning,evening etc.
			objCstmt.setString(13, strprefferedSeat);   //set the current user Login UserId
			objCstmt.setString(14, "1");
			objCstmt.setInt(15, 0);
			//intSuccess7  =  objCstmt.executeUpdate();  

			 objCstmt.execute();	// executing procedure
			 int retval		=	objCstmt.getInt(1);// get output parameter from the procedure
			 if(retval==-3 || retval==-50002){
				  strMessage=dbLabelBean.getLabel("message.createrequest.forwardjourneydetailsnotsaved",strsesLanguage);
			  }else{  
				  //System.out.println("retval========"+retval);
			 }
			  objCstmt.close();
		 } else {
			//procedure  to enter the details in T_JOURNEY_DETAILS_INT
				objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
//System.out.println("strTravel_Id-------post----->"+strTravel_Id);
				objCstmt.setString(2, strTravel_Id);
				
				//changed by manoj chand on 23 may 2011 START HERE
//System.out.println("travel_from---->"+strDeptcity);
//System.out.println("travel_to------>"+strArialcity);
				objCstmt.setString(3,strDeptcity );   		//set the Traveller Departure City Name(TRAVEL_FROM)
				objCstmt.setString(4,strArialcity );   		//set the Traveller Arrival City Namei(TRAVEL_TO)
				
				// END HERE
				//objCstmt.setString(3, "");   		//set the Traveller Departure City Name(TRAVEL_FROM)
				//objCstmt.setString(4, "");   		//set the Traveller Arrival City Namei(TRAVEL_TO)
				objCstmt.setString(5, strdepatDate);   		//set the Traveller Departure Date
				objCstmt.setString(6, "1");  		//set the Order of Traveller intrim journey(it is 1 for the actual from and to)
				objCstmt.setString(7, "1");   //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
				objCstmt.setString(8, strprefferedAirline);   //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
				objCstmt.setString(9, strClass);        //set the Travel Class Name(in int value), e.g. First class, Business class 
			
               //code modified  on 06/02/2008 by shiv sharma --sending  values through variables 
				objCstmt.setString(10,"");        //set the VISA_REQUIRED, e.g. 1 for yes and 2 for no
				objCstmt.setString(11,"");        //set the VISA_COMMENT
				objCstmt.setString(12, strprefferedTime);          //set the Travel Preferred Time e.g. Morning,evening etc.
				objCstmt.setString(13, Suser_id);              //set the current user Login UserId
				
				objCstmt.setString(14, strprefferedSeat);              //set the current user Login UserId
				objCstmt.setString(15, "1");
			    objCstmt.setInt(16, 0);
				//intSuccess7  =  objCstmt.executeUpdate();
			     
				objCstmt.execute();	// executing procedure
				 int retval2		=	objCstmt.getInt(1);// get output parameter from the procedure
				 if(retval2==-3 || retval2==-50002){
					  strMessage=dbLabelBean.getLabel("message.createrequest.forwardjourneydetailsnotsaved",strsesLanguage);
				  }else{  
					  //System.out.println("retval========"+retval);
				 }
				  objCstmt.close();
		 }
		 rs.close();  
		 
		 strSql = "SELECT TD.TRAVEL_REQ_NO FROM T_TRAVEL_DETAIL_INT TD WHERE TD.TRAVEL_ID ="+strTravel_Id+" AND TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10";
		  rs       =   dbConBean.executeQuery(strSql);
		  if(rs.next()) {
			  strTravelReqNo = rs.getString("TRAVEL_REQ_NO");
		  }
			rs.close();
		
		   objCstmt   =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS(?,?,?,?,?,?)}");
		   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		   objCstmt.setString(2, strTravelId);
			objCstmt.setString(3, strTravelReqId);
			objCstmt.setString(4, strTravelStatusId); //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
			objCstmt.setString(5, strTravelType);
			objCstmt.setString(6, strTravelReqNo);
			objCstmt.setString(7, strCancelledReqId);
			intSuccess5 = objCstmt.executeUpdate();
		   //System.out.println("intSuccess5----------->"+intSuccess5);
		   objCstmt.close();
			
			/*strSql=" SET DATEFORMAT dmy update T_travel_detail_INT  "+
			        " set  TRAVEL_DATE='"+strdepatDate+"' where TRAVEL_ID="+strTravelId+" and STATUS_ID='10'";*/
		 
			//written by manoj on 20 sep 2011 to update t_travel_detail_int with accomodation values
			
			strSql=" SET DATEFORMAT dmy update T_travel_detail_INT  "+   
			        " set  TRAVEL_DATE='"+strdepatDate+"',HOTEL_REQUIRED=N'"+strHotelRequired+"',PLACE=N'"+strPlace+"'"+
			        " ,HOTEL_BUDGET=N'"+strHotelBudget+"',BUDGET_CURRENCY=N'"+strBudgetCurrency+"',CHECK_IN_DATE='"+strCheckin+"'"+
			        " ,CHECK_OUT_DATE='"+strCheckout+"',REMARKS=N'"+strRemarks+"'"+
			        " where TRAVEL_ID="+strTravelId+" and STATUS_ID='10'";	
		//System.out.println("strSql-gr int-->"+strSql);	        	        
            int updaterow=   dbConBean.executeUpdate(strSql);  
            
			strMessage=dbLabelBean.getLabel("message.global.infosavesuccessfully",strsesLanguage);   
			strFlagForUpdate="UpdateRecord";
			//System.out.println("strFlagForUpdate---->"+strFlagForUpdate);
	 } 
			  
	 dbConBean.close(); 
	%>
	
	<% 
	if(strFlagForUpdate.equalsIgnoreCase("UpdateRecord") && !strsaveFlag.equalsIgnoreCase("save")){
		url="Group_itinerary_details.jsp?UpFlag="+strFlagForUpdate+"&site="+strSiteId;
		RequestDispatcher dispatcher =  request.getRequestDispatcher(url);
		dispatcher.forward(request,response);	
	}
	else{
		//System.out.println("----else----");
		url = "Group_T_IntTrv_Details.jsp?strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travelReqNo="+strTravel_Req_No+"&manager="+strManagerId+"&hod="+strHodId+"&interimId="+strInterimId+"&site="+strSiteId;
		response.sendRedirect(url);
	}
	//url ="Group_T_IntTrv_Details.jsp";
	
	}  %>
	</html>