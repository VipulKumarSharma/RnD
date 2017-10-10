	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				        :Shiv sharma 
	 *Date of Creation 	    :
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			        :STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 		     	:This is   jsp file  for create the Domestice  Group Travel Requisition
	 *Modification 	    	    ::added code for showing other currency in domestic group travel on 03-Mar-10 by shiv sharma
	 *Reason of Modification:
	 *Date of Modification  :
	 *Modified By	  :
	 *Editor				:Editplus
	 
	 *Date of Modification	: 17 May 2011
	 *Modified By			: Manoj Chand
	 *Modification 			: To resolve problem which is gender status showing as female when mata receive request (domestic group request)
	
	 *Date of Modification	: 20 Sep 2011
	 *Modified By			: Manoj Chand
	 *Modification			: To save domestic group/guest accomodation details
	 
	 *Date of Modification	: 29 Mar 2012
	 *Modified By			: Manoj Chand
	 *Modification			: add one more parameter in procedure to save board member id.
	 
	 *Date of Modification	: 11 May 2012
	 *Modified By			: Manoj Chand
	 *Modification			: Change strExpId array's value for inserting correct expid in t_expenditure_dom table for group domestic request.
	 
	 *Modification				:Multilingual functionality added
	 *Modified by				:Manoj Chand
	 *Date of Modification		:24 May 2012
	 
	 *Modification				:pass one parameter costcentre in procedure
	 *Modified by				:Manoj Chand
	 *Date of Modification		:03 August 2012
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :01 Feb 2013
	 *Description			:IE Compatibility Issue resolved
	 *******************************************************/
	%>
	<html>
	<%@ page import="java.net.URLEncoder" %>
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
	int intSuccess10                = 0;
	int iSuccess3					= 0;	
	int intSuccess11				= 0;	
	int intCounter                  = 0;
	String strSql                   =  null;            // String for Sql String
	Connection objCon            	=  null;            //Object for Connection 
	Connection objCon1          	=  null;            //Object for Connection 
	ResultSet rs,rs1,rs2          	=  null;            // Object for ResultSet
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
	String strTravelType            =  "D";     //I for Domestice 
	String strTravelStatusId        =  "1";  
	ArrayList approverList1         =  new ArrayList();
	ArrayList l1                    =  new ArrayList();
	
	String strTravelReqId           =  "";
	String strTravelId				=  "";
	String strTravelReqNo           =  "";
	String strActionFlag            =  "";
	String G_userID	 	            =  "";
	String strWhatAction			=  "";    
	String url						=  ""; 
	String strMessage				=  ""; 
	String strInterimId				=  "";  
	String strUserRole				=  ""; 
	String strplace					=  ""; 
	String strDOB					=  "";
	String strGender				=  "";
	String strPassport_issue_date	=  "";
	String strPassport_expire_date  =  "";
	String strPassport_issue_place  =  "";
	 
	String strECR					=  "";
	String strTravellerFirstName    =  "";
	 String strTravellerLastName	=  "";
	
	String strPassport              =  ""; 
	String strTACurrency[]          = null;
	
	/// forex related  variables 
	//strExpID ARRAY values change by manoj chand on 11 may 2012 from 1,2,3,4 to 5,6,7,8
	 String strExpID[]              =  {"5","6","7","8"};
	String strEntPerDay[]           =  null;
	String strTotalTourDay[]        =  null;
	String strTotalForex[]			=  null; 
	String strContingecies[]		=  null;  
	//added by manoj chand on 15 oct 2012
	String strEntPerDay2[]	      =  null;
	String strContingecies2[]     =  null;
	String strTotalTourDay2[]     =  null;
	String strExRate[]        	  =  null;
	String strTotalINR[]          =  null;
	String strHiddenValue[]		  =  null;
	
    String strTotalAmount		    =  "";  
	String strFlagValue             =  "";
	String stUserIDMax			    =  "";
	String strG_userID			    =  "";
	String strExpRemarks			=  "";
	String strCurrencyflag		    =  "";
	
	
 	String  strIdentityProof_expire_date           ="";
    String  strIdentityProofno                     ="";
    String  strIdentityProof                       ="";
    String  strIdentityProof_issue_place           ="";
	
	String strPhoneNo="";
	

	String strDeptcity					="";
	
	String strArialcity					="";
	String strdepatDate					="";
	String strprefferedAirline			="";
	String strprefferedTime				="";
	String strClass						="";
	String strprefferedSeat				="";
	String strfwdTatkaalRequired		="";
	String strFwdprefferedSeat	        ="";
	String strfwdprefferedSeat    		="";  
	String strfwdCoupanRequired			="";	
	String strfwdticketrefund			=""; 
	String strfwdtravelMode				="";
	String strCancelledReqId		    ="0";
	
	strDeptcity					=request.getParameter("fwddepCity");
	strArialcity				=request.getParameter("fwdarrCity");
	strdepatDate				=request.getParameter("fwddepDate");
	strprefferedAirline			=request.getParameter("fwdnameOfAirline");
	strprefferedTime			=request.getParameter("fwdpreferTime");
	strClass					=request.getParameter("fwdtravelClass"); 
	strprefferedSeat			=request.getParameter("fwdseatpreference"); 
	
	strfwdTatkaalRequired		=request.getParameter("fwdforTatkaalRequired");
	strfwdCoupanRequired		=request.getParameter("fwdforCoupanRequired"); 
	strfwdticketrefund			=request.getParameter("fwdticketrefund");
	strfwdtravelMode			=request.getParameter("travelMode");

	strSiteId       			=  (request.getParameter("site")==null || request.getParameter("site").equals("null")) ? strSiteIdSS : request.getParameter("site");
	String strsaveFlag = request.getParameter("saveflag")==null?"":request.getParameter("saveflag");
	strG_userID            =  request.getParameter("G_userID")==null ?"" :request.getParameter("G_userID");    // from hidden field
	strTravelReqId         =  request.getParameter("travelReqId")==null ?"" :request.getParameter("travelReqId");    // from hidden field
	strTravelId            =  request.getParameter("travelId")==null ?"" :request.getParameter("travelId");       // from hidden field
	strFlagValue           =  request.getParameter("strFlag")==null ?"" :request.getParameter("strFlag");       // from hidden field
	strWhatAction          =  request.getParameter("whatAction");     //from hidden field        
	//ADDED BY MANOJ CHAND ON 19 SEPT 2011 TO ADD INTERMEDIATE DESTINATION AND ACCOMODATION 
	String	strTransitType			 = request.getParameter("transit") == null ? "0" :  request.getParameter("transit");
	String	strBudget				 = request.getParameter("budget") == null ? ""  : request.getParameter("budget").trim();
	String  strBudgetCurrency        = request.getParameter("currency") == null ? "INR" : request.getParameter("currency").trim();
	String	strCheckin				 = request.getParameter("checkin") == null ? "" : request.getParameter("checkin");
	String	strCheckout				 = request.getParameter("checkout") == null ? "" : request.getParameter("checkout");
	String	strOthers				 = request.getParameter("others")== null ?  "" : request.getParameter("others").trim();
	String strPlace				     = request.getParameter("place")== null ? "" : request.getParameter("place");
	String strIntermiId			 	 = request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
	String strCostCentre="0";
	strCostCentre			   =  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
	strCancelledReqId		   =  request.getParameter("cancelledTravelReq")==null?"0":request.getParameter("cancelledTravelReq");
	objCon		=dbConBean.getConnection();
	//Get the new Travel_Req_Id from the TID Table
	String strTravel_Req_Id  = "";
	String strTravel_Id  = "";
	String strTravel_Req_No = ""; 
	String strFlagForUpdate= "";
	//System.out.println("strTravelReqId="+strTravelReqId+",strTravelReqId="+strTravelReqId+",strWhatAction="+strWhatAction+",strFlagValue="+strFlagValue);

	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strSiteId, "0");		
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
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "Group_T_TravelDetail_Dom_POST.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {
		
		//	case when requets is new
		if(strTravelReqId != null && strTravelReqId.equals("new")  && !strWhatAction.equals("update"))
		{   
			  strTravel_Req_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_REQ_ID")+"";
			  strTravel_Id			=  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_DOM")+"";
			//change by manoj on 11 oct 2011 to show selected site name in request number
			  if(!strSiteId.trim().equalsIgnoreCase(strSiteIdSS.trim())){
				 String strsiteName="";
				 strSql="select site_name from m_site where site_id="+strSiteId;
				 rs = dbConBean.executeQuery(strSql);
					if(rs.next()){  
						strsiteName = rs.getString("site_name");	 		
					 }
					strTravel_Req_No = "GR/TEMP/"+strsiteName.trim()+"/DOM/"+strTravel_Id;
					rs.close();				
			  }else{			  
			  strTravel_Req_No = "GR/TEMP/"+strSiteFullName.trim()+"/DOM/"+strTravel_Id;
			  }
			  strActionFlag   = "insert";
		}//case when request in not new and traveller should be added in t_guoup_userinfo when strFlagValue=1
		else  if(strFlagValue.equals("1") && !strWhatAction.equals("update") && !strWhatAction.equals("itenupdate"))
		{   
			  strActionFlag   = "insert";
			  strTravel_Req_Id=strTravelReqId; 
			  strTravel_Id=strTravelId ;
		}//case when request in not new and travel details should be added in journey table 
		else if(strFlagValue.equals("1") && strWhatAction.equals("itenupdate")){ 
			strActionFlag   = "Itanarydetails";  
			strTravel_Id     = strTravelId;
		}//case when request in not new and traveler details is updated in t_group_userinfo
		else  
		{   
			strActionFlag   = "update"; 
			strTravel_Id     = strTravelId;
		}
	  
			  strTravellerFirstName     =  request.getParameter("firstName").trim();	
			  strTravellerLastName      =  request.getParameter("lastName").trim();
			  strDesigId                =  request.getParameter("designation").trim();
			  strDOB                    =  request.getParameter("passport_DOB").trim();
			  strAge                    =  request.getParameter("age").trim();
			  strGender                 =  request.getParameter("Gender").trim();		  
			  strMeal                   =  request.getParameter("meal").trim();
			  strIdentityProof          =  request.getParameter("identityProof").trim();
			  strIdentityProofno        =  request.getParameter("identityProofno").trim();
			  strPhoneNo                =  request.getParameter("phoneNo").trim();
	
	
	         strCurrencyflag							= request.getParameter("currencyflag"); 
	
			 if (strCurrencyflag.equals("disabled"))
			 {
					strSql = "SELECT distinct currency FROM  T_TRAVEL_EXPENDITURE_DOM WHERE TRAVEL_ID = "+strTravelId+"";	       
					rs = dbConBean.executeQuery(strSql);
					while(rs.next()) 
					{  
						//strTACurrency = rs.getString(1);
						//added by manoj chand on 15 oct 2012
						strTACurrency							= request.getParameterValues("expCurrency");
					 } 
					rs.close();				
	      	 }
			 else{
	         strTACurrency							= request.getParameterValues("expCurrency"); 
			 }
			 
	        strEntPerDay                     =  request.getParameterValues("entitlement");     
	        strTotalTourDay                  =  request.getParameterValues("tourDays");     
	        strTotalForex                    =  request.getParameterValues("totalForex");      
	        strContingecies                  =  request.getParameterValues("contingencies");
	        //ADDED BY MANOJ CHAND ON 15 OCT 2012 TO GET VALUES 
	  	    strEntPerDay2                    =  request.getParameterValues("entitlement2");     
	  	    strTotalTourDay2                 =  request.getParameterValues("tourDays2");     
	  	    strContingecies2                 =  request.getParameterValues("contingencies2");
	  	    strExRate              	  	     =  request.getParameterValues("exRate");     
	  	    strTotalINR						 =  request.getParameterValues("totalInr");
	  	    strHiddenValue					 =  request.getParameterValues("hd");
	        
	        strTotalAmount                   =  request.getParameter("grandTotalForex");    
	        strExpRemarks                   =  request.getParameter("expRemarks");  
			//  code to update traveller those are in return journey added by shiv sharma on 23-jun-2009
			
	        String [] strUsertoReturn         =request.getParameterValues("userids"); 
			
	     	String strtext					="-1";  
	     	int intTotleid					=0; 
	     	String strUserids               ="-1";       
	     	 
	     		 if (strUsertoReturn!=null )     
	     		    { 
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
			//System.out.println("------------------insert ----------------");
			    try
		        {
			       		//System.out.println("in side insert block "); 
				       objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?,?, ?,    ?,?,?,?,   ?,?,?,?,     ?,?,?,?,    ?,?,?,?,   ?,?,?, ?,?,?      ,?,?,?,?)}");
			           objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		  
				         objCstmt.setString(2,"0");								   //set  G_userid
						 objCstmt.setString(3,strTravel_Id);					   //travel_id 
						 objCstmt.setString(4, strTravelType);				   	   //t ravel_type	
						 objCstmt.setString(5, strTravellerFirstName);		 	   //first Name	of traveler
						 objCstmt.setString(6, strTravellerLastName);              //last name  of traveler 
						 objCstmt.setString(7,strSiteId);						   //site id of traveler   
						 objCstmt.setString(8, strDesigId);						   //desig id of  traveler 
						 objCstmt.setString(9, "10");							   //status_id of requsition 10 					
						 objCstmt.setString(10, "");						       //passport no of user 
						 objCstmt.setString(11, "");        					   //strPassport_issue_date
						 objCstmt.setString(12, "");       						    // place of passport Issue  
						 objCstmt.setString(13, "");		 						//strPassport_expire_date
						 objCstmt.setString(14, strAge);							//age of  	traveler
						 objCstmt.setString(15, "");							    //ECR  value		
						 objCstmt.setString(16, strDOB);							//strDOB       
						 objCstmt.setString(17, "");                                //visa required 
						 objCstmt.setString(18, "I");								//record type I/U 				 
						 objCstmt.setString(19, strGender);							//gender 
						 objCstmt.setString(20, strIdentityProof);                  //identity _id 
						 objCstmt.setString(21, strIdentityProofno);				//identity no	
						 objCstmt.setString(22, strMeal);				            //mael prefrence
						 objCstmt.setString(23, strTotalAmount);   					//float set  strTotalAmount
						 objCstmt.setString(24, strExpRemarks);             		//set the current user Login UserId
						 objCstmt.setString(25, Suser_id);             				//set the current user Login UserId
		
						 objCstmt.setString(26, "INSERT");                          //operation for procedure 
					     objCstmt.setString(27, strPhoneNo);                        //operation for procedure
					     objCstmt.setString(28, "");   
					     objCstmt.setString(29, "N");
					     objCstmt.setString(30, "");
					     objCstmt.setString(31, "");
					     objCstmt.setString(32, "");
						 objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
						 intSuccess3  = objCstmt.executeUpdate();
						 objCstmt.close();
		 		         
					    //if procedure   PROC_T_GROUP_USERINFO run sucessfully then fineduser id of person for which forex break up will be 
			            //adde in tabel  T_TRAVEL_EXPENDITURE_DOM  
	
						
				           if(intSuccess3>0)
			                  {
		                           strSql=" SELECT   MAX(G_USERID)  as MAXuserID  FROM    T_GROUP_USERINFO WHERE   travel_type='d' and (TRAVEL_ID = "+strTravel_Id+") ";
		                           rs       =   dbConBean.executeQuery(strSql);  
						           while(rs.next()){
							  			   stUserIDMax= rs.getString("MAXuserID");
		           	                                      }
		                           rs.close();
				              }
				          //inser the data    when user id found  from T_Group _userinfo
						  	if(stUserIDMax!="" && stUserIDMax!=null )
									{
								/*	 for(int i=0; i<strEntPerDay.length; i++)
										{
										objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_DOM(?,?,?,?,?,?,?  ,?)}");
										objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
										objCstmt.setString(2, strTravel_Id);
										objCstmt.setString(3, strExpID[i]);                    //set the ExpId
										//objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
									    objCstmt.setString(4, strEntPerDay[i]);
									    objCstmt.setString(5, strTotalTourDay[i]);
									    objCstmt.setString(6, strTotalForex[i]);
							            objCstmt.setString(7, Suser_id);
							            objCstmt.setString(8, stUserIDMax);  
							            objCstmt.setString(9, strTACurrency);  				   // added on 03 -03 -2010 by shiv sharma  
							           intSuccess4   =  objCstmt.executeUpdate();
							           objCstmt.close();   		  
							          }
							         int j = 0;
							         //PROCEDURE to insert the row in T_TRAVEL_EXPENDITURE_DOM Table
							  for(int i=2; i<strExpID.length; i++)
							          {        
								          
							            objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_DOM(?,?,?,?,?,?,?,?)}"); 
							            objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							            objCstmt.setString(2, strTravel_Id);
							            objCstmt.setString(3, strExpID[i]);                    //set the ExpId
							           // objCstmt.setString(4, strTACurrency);                //set the current user Login UserId
							            objCstmt.setString(4, "0");
							            objCstmt.setString(5, "0");
							            objCstmt.setString(6, strContingecies[j++]);
							            objCstmt.setString(7, Suser_id);
							            objCstmt.setString(8, stUserIDMax);  
							            objCstmt.setString(9, strTACurrency);    // added on 03 -03 -2010 by shiv sharma  
							            intSuccess5   =  objCstmt.executeUpdate();
							            objCstmt.close(); 		  
							         }*/
							         
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
						  		objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_DOM(?,?,?,?,?,?,?,?,?,?,?)}");
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
								objCstmt.setString(12, stUserIDMax);
								if(strHiddenValue[i].equals("v") && (Double.parseDouble(strTotalINR[i])>0 || i==0)){
									intSuccess4   =  objCstmt.executeUpdate();
									intSuccess5=intSuccess4;
								  }
								objCstmt.close();	
								}
							         
				   
				   }//end of if block 
		
							//PROCEDUER TO UPDATE     T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP TO T_TRAVEL_DETAILS_INT
		                
				              objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_DOM_UPDATE_GROUP(?)}");
							  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							  objCstmt.setString(2, strTravel_Id);
			               	  intSuccess10  =  objCstmt.executeUpdate();
							  objCstmt.close();		  
		
		
						if (intSuccess3 >0 &&  intSuccess4>0 && intSuccess5>0)  {
					   					strMessage=dbLabelBean.getLabel("message.createrequest.useradded",strsesLanguage);
						    } else {
					   		           strMessage=dbLabelBean.getLabel("message.createrequest.useraddedfailed",strsesLanguage);
					       }
		                   if(!strFlagValue.equals("1"))          
								{
				           			    objCstmt  =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_MST(?,?,?,?)}");
										objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
										objCstmt.setString(2, strTravel_Req_Id);
										objCstmt.setString(3, strSiteId);               //set the  Site Id  for whicb  the request is created 
										objCstmt.setString(4, Suser_id);                //set the current user Login UserId
										objCstmt.setString(5, strTravelType);
										intSuccess1   =  objCstmt.executeUpdate();
										objCstmt.close();
										
									   
		
									    //PROCEDURE for INSERT data in T_TRAVEL_STATUS
										objCstmt             = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_STATUS(?,?,?,?,?)}"); 
										objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
										objCstmt.setString(2, strTravel_Req_Id);
										objCstmt.setString(3, strTravel_Id);
										objCstmt.setString(4, strTravelStatusId);		//set the Travel Status Id(1-Temp,2-Permanent,3-Return,4-Rejected,6-Canceled,10-Approved by All)
										objCstmt.setString(5, strTravelType);    		//set the Travel Type(I-international, D-Domestic)
										objCstmt.setString(6, strCancelledReqId);
										intSuccess2  =  objCstmt.executeUpdate();
										objCstmt.close();
							       
		
										  objCstmt             =   objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,   ?,?,?,?,?,?,     ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");  
	
										  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
										  objCstmt.setString(2, strTravel_Req_Id);
										  objCstmt.setString(3, strTravel_Id);
										  objCstmt.setString(4, strTravel_Req_No);
										  objCstmt.setString(5, strSiteId);               //set the Traveller Site Id
										  objCstmt.setString(6, Suser_id);           	  //set the Traveller Id
										  
								/* changed by manoj  start on 17 may 2011 */	
										  objCstmt.setString(7, "");                      //set the Traveller Age
										  objCstmt.setString(8, strGender);                      //set the Traveller Sex		  
								 /* changed by manoj end */			  
										  objCstmt.setString(9, "");                      //set the Traveller Departure Date
										  objCstmt.setString(10, "");                     //set the Traveller Meal
										  objCstmt.setString(11, "");                     //set the Traveller Hotel Required
										  objCstmt.setString(12, "");                     //set the Traveller Hotel Budget
										  objCstmt.setString(13, "");                     //set the Traveller Hotel Budget Currency
										  objCstmt.setString(14, "");                     //set the Traveller Remark(in table)
										  objCstmt.setString(15, "");                     //set the current user Login UserId
										  objCstmt.setString(16, "");                     //set the current user Login UserId
										  objCstmt.setString(17, "");                     //set the Traveller Return Type if(user fill the return date then Return Type is 2 otherwise 1
										  objCstmt.setString(18, Suser_id);               //set the current user Login UserId
										  objCstmt.setString(19, "");                     //set the select Approver radio button (manual or automatic)
										  objCstmt.setString(20, "");                     //set the select Approver radio button (manual or automatic)
										  objCstmt.setString(21, "");                     //set the select Approver radio button (manual or automatic)
										  objCstmt.setString(22, ""); 
										  objCstmt.setString(23,"");
										  objCstmt.setString(24, ""); 
										  objCstmt.setString(25, ""); 
										  objCstmt.setString(26, ""); 
										  objCstmt.setString(27, ""); 
										  objCstmt.setString(28, ""); 
										  objCstmt.setString(29, ""); 
										  objCstmt.setString(30, ""); 
										  objCstmt.setString(31, ""); 
										  objCstmt.setString(32, ""); 	
										  objCstmt.setString(33, ""); 
										  objCstmt.setString(34, ""); 
										  objCstmt.setString(35, ""); 
										  objCstmt.setString(36, ""); 
										  objCstmt.setString(37, ""); 
										  objCstmt.setString(38, ""); 
									      objCstmt.setString(39, "Y");                //Added new field for setting Flage for group request
									      objCstmt.setString(40, "");
									      objCstmt.setInt(41,Integer.parseInt(strCostCentre));
									      objCstmt.setString(42, "");
										  objCstmt.setString(43, "2");
										  objCstmt.setString(44, "2");
										  objCstmt.setString(45, "0");
										  objCstmt.setString(46, "");
										  objCstmt.setString(47, "0");
										  objCstmt.setString(48, "1");
										  objCstmt.setString(49, "2");
										  objCstmt.setString(50, "2");
										  objCstmt.setString(51, "");
										  objCstmt.setString(52, "");
										  objCstmt.setString(53, null);
										  objCstmt.setString(54, "");
										  intSuccess6   = objCstmt.executeUpdate(); 
		
										   /////0000 procedure to insert Entry into  T_JOURNEY_DETAILS_DOM
				
									       objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
										  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
										  objCstmt.setString(2, strTravel_Id);
										  objCstmt.setString(3, "");             //set the Traveller Departure City Name(TRAVEL_FROM)
										  objCstmt.setString(4, "");             //set the Traveller Arrival City Namei(TRAVEL_TO)
										  objCstmt.setString(5, "");             //set the Traveller Departure Date
										  objCstmt.setString(6, "1");            //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
										  objCstmt.setString(7, "");             //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
										  objCstmt.setString(8, "");             //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
										  objCstmt.setString(9, "");             //set the Travel Class Name(in int value), e.g. First class, Business class 
										  objCstmt.setString(10,"");             //set the Travel Preferred Time e.g. Morning,evening etc.
										  objCstmt.setString(11, Suser_id);      //set the current user Login UserId
										  objCstmt.setString(12, "1");           //set the current user Login UserId
										  objCstmt.setString(13, "n");           //set the current user Login UserId
										  objCstmt.setString(14, "1");
										  objCstmt.setInt(15, 0);
										  //intSuccess6   =  objCstmt.executeUpdate();
										  objCstmt.close();
	 
		                                  //procedure that update  expenditure in T_travel_details _DOM   table     
										  
								          objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_DOM_UPDATE_GROUP(?)}");
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
	
	else if(strActionFlag!=null && strActionFlag.equals("update"))  
	{
				
		//System.out.println("------------------update ----------------");
					 G_userID =strG_userID; 
					//Procedure for delete the date from the T_TRAVEL_EXPENDITURE_DOM 
			       /*
				    objCstmt =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_DOM(?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strTravelId);
					intSuccess1   =  objCstmt.executeUpdate();
					objCstmt.close(); 
			     */
					objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?, ?,?,    ?,?,?,?,   ?,?,?,?,     ?,?,?,?,    ?,?,?,?,   ?,?,?, ?,?,?       ,?,?,?,?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  
					 objCstmt.setString(2,G_userID);						   //set  G_userid
					 objCstmt.setString(3,strTravel_Id);				       //travel_id 
					 objCstmt.setString(4, strTravelType);					   //t ravel_type	
					 objCstmt.setString(5, strTravellerFirstName);		 	   //first Name	of traveler
					 objCstmt.setString(6, strTravellerLastName);              //last name  of traveler 
					 objCstmt.setString(7,strSiteId);						   //site id of traveler   
					 objCstmt.setString(8, strDesigId);						   //desig id of  traveler 
					 objCstmt.setString(9, "10");							   //status_id of requsition 10 					
					 objCstmt.setString(10, "");						       //passport no of user 
					 objCstmt.setString(11, "");                   			   //strPassport_issue_date
					 objCstmt.setString(12, "");                 			   // lace of passport Issue  
					 objCstmt.setString(13, "");		                        //strPassport_expire_date
					 objCstmt.setString(14, strAge);						    //age of  	traveler
					  objCstmt.setString(15, "");								//ECR  value		
					  objCstmt.setString(16, strDOB);							//strDOB       
					  objCstmt.setString(17, "");                               //visa required 
					  objCstmt.setString(18, "I");								//record type I/U 				 
					  objCstmt.setString(19, strGender);						//gender 
					  objCstmt.setString(20, strIdentityProof);                 //identity _id 
					  objCstmt.setString(21, strIdentityProofno);				//identity no	
					  objCstmt.setString(22, strMeal);				            //mael prefrence
					  objCstmt.setString(23, strTotalAmount);                   //float set  strTotalAmount
					   objCstmt.setString(24, strExpRemarks);                   //set the current user Login UserId
					  objCstmt.setString(25, Suser_id);                         //set the current user Login UserId
	
					  objCstmt.setString(26, "UPDATE");                         //operation for procedure 
					  objCstmt.setString(27,strPhoneNo);
					  objCstmt.setString(28, "");   
					  objCstmt.setString(29, "N");
					  objCstmt.setString(30, "");
					  objCstmt.setString(31, "");
					  objCstmt.setString(32, "");
					  objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
					  intSuccess3  = objCstmt.executeUpdate();
					  objCstmt.close();
	
					 /* for(int i=0; i<strEntPerDay.length; i++)
								{
							
							     objCstmt     =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_EXPENDITURE_dom_GROUP(?,?,?,?,   ?,?,?,?    )}");
								  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
								  objCstmt.setString(2, strTravel_Id);
								  objCstmt.setString(3, strExpID[i]);                       //set the ExpId
								  objCstmt.setString(4, strTACurrency);                       //set the ExpId
						          objCstmt.setString(5, strEntPerDay[i]);
								  objCstmt.setString(6, strTotalTourDay[i]);
								  objCstmt.setString(7, strTotalForex[i]);
								  objCstmt.setString(8, Suser_id);
								  objCstmt.setString(9, G_userID);  
								  intSuccess4   =  objCstmt.executeUpdate();
								  objCstmt.close();   		  
								}
								int j = 0;
								//PROCEDURE to insert the row in T_TRAVEL_EXPENDITURE_DOM Table
						 for(int i=2; i<strExpID.length; i++)
								{          
								  objCstmt   =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_EXPENDITURE_dom_GROUP(?,?,?,?,  ?,?,?,?    )}");
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
								// added by manoj on 15 oct 2012 Procedure for delete the updated user data from the T_TRAVEL_EXPENDITURE_DOM
								objCstmt             =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_Group(?,?,?)}");
								objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
								objCstmt.setString(2, strTravel_Id);
								objCstmt.setString(3, G_userID);
								objCstmt.setString(4, "D");
								iSuccess3   =  objCstmt.executeUpdate();
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
									
									objCstmt   =  objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_EXPENDITURE_DOM(?,?,?,?,?,?,?,?,?,?,?)}");
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
									 objCstmt.setString(12, G_userID); 
									 if(strHiddenValue[i].equals("v") && (Double.parseDouble(strTotalINR[i])>0 || i==0)){
										 intSuccess4   =  objCstmt.executeUpdate();
										  }
									objCstmt.close();
								}
								                             
							objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_DOM_UPDATE_GROUP(?)}");
					        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
											 
							intSuccess11   =  objCstmt.executeUpdate();
						    objCstmt.close();		  
						
	                       strMessage=dbLabelBean.getLabel("message.global.updatedsuccessfully",strsesLanguage);
	
	 }
	else 
	  {	
		
		strSql = "SELECT TOP 1 TRAVEL_ID FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
		rs       =   dbConBean.executeQuery(strSql); 
		  if(rs.next()) {
			  objCstmt             =  objCon.prepareCall("{?=call PROC_UPDATE_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Id);
			  objCstmt.setString(3, strDeptcity);             	 //set the Traveller Departure City Name(TRAVEL_FROM)  
			  objCstmt.setString(4, strArialcity);               //set the Traveller Arrival City Namei(TRAVEL_TO)
			  objCstmt.setString(5, strdepatDate);               //set the Traveller Departure Date
			  objCstmt.setString(6, "1");        				 //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
			  objCstmt.setString(7, strfwdtravelMode);           //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
			  objCstmt.setString(8, strprefferedAirline);        //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
			  objCstmt.setString(9, strClass);       			 //set the Travel Class Name(in int value), e.g. First class, Business class 
			  objCstmt.setString(10,strprefferedTime);           //set the Travel Preferred Time e.g. Morning,evening etc.
			  objCstmt.setString(11,"");                         //set the modified fields 
			  objCstmt.setString(12, Suser_id);                  //set the current user Login UserId
			  objCstmt.setString(13, strprefferedSeat);          //set the current user Login UserId
			  objCstmt.setString(14, strfwdticketrefund);        //set the ticket refundabled 
			  objCstmt.setString(15, "1");
			  objCstmt.setInt(16, 0);
			  //intSuccess6   =  objCstmt.executeUpdate();
			  try{
			  objCstmt.execute();	// executing procedure
			  }
			  catch(Exception e){
				  e.printStackTrace();
			  }
			  int retval		=	objCstmt.getInt(1);// get output parameter from the procedure
			  
			  if(retval==-3 || retval==-50002){
				  strMessage=dbLabelBean.getLabel("message.createrequest.forwardjourneydetailsnotsaved",strsesLanguage);  
			  }else{  
				 // System.out.println("retval========"+retval);
			  }
			  objCstmt.close();
		  } else {
			  objCstmt             =  objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  objCstmt.setString(2, strTravel_Id);
			  objCstmt.setString(3, strDeptcity);             //set the Traveller Departure City Name(TRAVEL_FROM)
			  objCstmt.setString(4, strArialcity);             //set the Traveller Arrival City Namei(TRAVEL_TO)
			  objCstmt.setString(5, strdepatDate);             //set the Traveller Departure Date
			  objCstmt.setString(6, "1");            //set the Order of Traveller intrim journey(it is 1 for the actual from and to)
			  objCstmt.setString(7, strfwdtravelMode);             //set the Travel Mode name( in int value) e.g. 1 for Air or 2 for Train
			  objCstmt.setString(8, strprefferedAirline);             //set the Travel Mode name(in int value), e.g. Air India, Air Deccon etc.
			  objCstmt.setString(9, strClass);             //set the Travel Class Name(in int value), e.g. First class, Business class 
			  objCstmt.setString(10, strprefferedTime);             //set the Travel Preferred Time e.g. Morning,evening etc.
			  objCstmt.setString(11, Suser_id);      //set the current user Login UserId
			  objCstmt.setString(12, strprefferedSeat);           //set the current user Login UserId
			  objCstmt.setString(13, strfwdticketrefund);           //set the current user Login UserId
			  objCstmt.setString(14, "1");
			  objCstmt.setInt(15, 0);
			  //intSuccess6   =  objCstmt.executeUpdate();
			 
			  try{
				  objCstmt.execute();	// executing procedure
				  }
				  catch(Exception e){
					  e.printStackTrace();
				  }
				  int retval2		=	objCstmt.getInt(1);// get output parameter from the procedure
				  
				  if(retval2==-3 || retval2==-50002){
					  strMessage=dbLabelBean.getLabel("message.createrequest.forwardjourneydetailsnotsaved",strsesLanguage);  
				  }else{  
					 // System.out.println("retval========"+retval);
				  }
				  objCstmt.close();
		  }
		  
		  strSql = "SELECT TD.TRAVEL_REQ_NO FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID ="+strTravel_Id+" AND TD.APPLICATION_ID = 1 AND TD.STATUS_ID = 10";
		  rs       =   dbConBean.executeQuery(strSql);
		  if(rs.next()) {
			  strTravelReqNo = rs.getString("TRAVEL_REQ_NO");
		  }
			rs.close();
		
		   objCstmt   =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS_DOM(?,?,?,?,?,?)}");
		   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		   objCstmt.setString(2, strTravelId);
		   objCstmt.setString(3, strTravelReqId);
		   objCstmt.setString(4, strTravelStatusId);      //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
		   objCstmt.setString(5, strTravelType);
		   objCstmt.setString(6, strTravelReqNo);
		   objCstmt.setString(7, strCancelledReqId);
		   intSuccess5   =  objCstmt.executeUpdate();
		   //System.out.println("intSuccess5----------->"+intSuccess5);
		   objCstmt.close();
		   
		   
			/*	strSql=" SET DATEFORMAT dmy update T_travel_detail_dom  "+   
				   " set  TRAVEL_DATE='"+strdepatDate+"',FORWARD_TATKAAL='"+strfwdTatkaalRequired+"',FORWARD_COUPAN='"+strfwdCoupanRequired+"'"+
				   "  where TRAVEL_ID="+strTravelId+" and STATUS_ID='10'"; */
				   
			//change by manoj chand on 20 sep 2011 to save accomodatin t_travel_details_dom table
			   strSql=" SET DATEFORMAT dmy update T_travel_detail_dom  "+   
			   " set  TRAVEL_DATE='"+strdepatDate+"',TRANSIT_TYPE='"+strTransitType+"',TRANSIT_BUDGET='"+strBudget+"',BUDGET_CURRENCY='"+strBudgetCurrency+"',CHECK_IN_DATE='"+strCheckin+"', CHECK_OUT_DATE='"+strCheckout+"',  REMARKS=N'"+strOthers+"',PLACE=N'"+strPlace+"' ,FORWARD_TATKAAL='"+strfwdTatkaalRequired+"',FORWARD_COUPAN='"+strfwdCoupanRequired+"'"+ 
			   " where TRAVEL_ID="+strTravelId+" and STATUS_ID='10'";
		//System.out.println("strSql---dom post->"+strSql);		
		        int updaterow=   dbConBean.executeUpdate(strSql);   	
	            
	            if(updaterow>0){
	            	 strMessage=dbLabelBean.getLabel("message.global.infosavesuccessfully",strsesLanguage);  
	            }
	            strFlagForUpdate="UpdateRecord";
	            dbConBean.close();
		
	}
	//end of else block  
	
	//ADDED BY MANOJ CHAND ON 08 FEB 2013 TO RESOLVE ISSUE OF FORWARD JOURNEY NOT SAVED.
	if(strFlagForUpdate.equalsIgnoreCase("UpdateRecord") && !strsaveFlag.equalsIgnoreCase("save")){
		url="Group_itinerary_details_DOM.jsp";
		RequestDispatcher dispatcher =  request.getRequestDispatcher(url);
		dispatcher.forward(request,response);	
	}else{
		url = "Group_T_TravelDetail_Dom.jsp?strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travelReqNo="+strTravel_Req_No+"&manager="+strManagerId+"&hod="+strHodId+"&interimId="+strInterimId+"&site="+strSiteId;
		response.sendRedirect(url);    
	}
	} %>
	</html>