<%@page import="org.apache.log4j.Level"%>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="src.enumTypes.TravelRequestEnums.TrainSeatPreferredTypes"%>
<%@ page import="src.enumTypes.TravelRequestEnums" %>
<%-- Import Statements  --%>
<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%@ page import="src.beans.*" %>
<%@ page import="src.dao.starDaoImpl" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean3" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<jsp:useBean id="mailDaoImpl" scope="page" class="src.dao.MailDaoImpl"/>
<%

	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	
	Logger logger=Logger.getLogger(this.getClass().getName()); 		
	logger.setLevel(Level.ALL);
		
	// Global Variables declared and initialized
	request.setCharacterEncoding("UTF-8");
	String strSql, strSql2, strSql3    			=  null;            // String for Sql String
	Connection objCon               			=  null;            //Object for Connection 
	Connection objCon1              			=  null;            //Object for Connection 
	ResultSet rs,rs1,rs2, rs3          			=  null;            // Object for ResultSet
	ResultSet rsFlt1,rsFlt2,rsFlt3     			=  null;            // Object for ResultSet
	ResultSet rsTrn1,rsTrn2,rsTrn3    			=  null;            // Object for ResultSet
	ResultSet rsCar,rsCar1,rsCar2	   			=  null;            // Object for ResultSet
	ResultSet rsAccom,rsAccom1,rsAccom2			=  null;            // Object for ResultSet
	CallableStatement objCstmt	    			=  null;		    // Object for Callable Statement
	Statement stmt								=  null;
	
	int intSuccess                  			=  0;
	int intSuccess1                 			=  0;
	int intSuccess2                 			=  0;
	int intSuccess3                 			=  0;
	int intSuccess4                 			=  0;
	int intSuccess5                 			=  0;
	int intSuccess33                			=  0;
	int intSuccess44                			=  0;
	int intSuccess55                			=  0;
	int intSuccess6                 			=  0;
	int intSuccess7                 			=  0;
	int intSuccess8                 			=  0;
	int iSuccess 								=  0;
	int iSuccess1								=  0;
	int iSuccess11								=  0;
	int iSuccess2								=  0;
	int iSuccess4								=  0;
	int iSuccess5								=  0;
	int iSuccess6								=  0;
	int iSuccess7								=  0;
	
	String strIPAddress 						= "127.1.1.1";   
	strIPAddress 								= request.getRemoteAddr(); 
	
	//Fields for Personal Details
	String strSiteId                			=  "";
	String strUserId                			=  "";
	String strDesigName             			=  "";
	String strContactNo		        			=  "";	
	String strAge                   			=  "";
	String strGender 							=  "";
	String strSex                   			=  "";
	String strMealId                			=  ""; 
	String strCostCentre						=  "0";
	String strProjectNo							=  "";
	String strReasonForTravel       			=  "";
	
	//Full, First and Last Name as per passport for MATA GmbH
	String fullName								=  "";
	String firstName							=  "";
	String lastName								=  "";	
	
	String strAirLineName		    			=  "";
	String strAirLineName1		    			=  "";
	String strAirLineName2		    			=  "";
	String strAirLineName3		    			=  "";
	String strAirLineName4		    			=  "";
	String strAirLineNo		        			=  "";
	String strAirLineNo1		    			=  "";
	String strAirLineNo2		    			=  "";
	String strAirLineNo3		    			=  "";
	String strAirLineNo4		    			=  "";
	String strHotelName		    				=  "";
	String strHotelName1		    			=  "";
	String strHotelName2		    			=  "";
	String strHotelName3		    			=  "";
	String strHotelName4		    			=  "";
	String strHotelNo		        			=  "";
	String strHotelNo1		    				=  "";
	String strHotelNo2		    				=  "";
	String strHotelNo3		    				=  "";
	String strHotelNo4		    				=  "";

	////Fields for Flight Details
	String strFlightMode	        			=  null;
	String strDepCityFlt[]          			=  null; 
	String strArrCityFlt[]          			=  null;
	String strDepDateFlt[]          			=  null; 
	String strPreferTimeModeFlt[]				=  null;
	String strPreferTimeFlt[]					=  null;
	String strTravelClassFlt[]      			=  null;
	String strPreferSeatFlt[]					=  null;	 

	String strDepCityFwdFlt            			=  "";                              
	String strArrCityFwdFlt            			=  ""; 
	String strDepDateFwdFlt            			=  ""; 
	String strTravelClassFwdFlt        			=  ""; 
	String strPreferTimeModeFwdFlt     			=  "";
	String strPreferTimeFwdFlt         			=  "";
	String strNameOfAirlineFwdFlt	        	=  "";
	String strPreferSeatFwdFlt					=  "";

	String strDepCityRetFlt            			=  "";                              
	String strArrCityRetFlt            			=  ""; 
	String strDepDateRetFlt            			=  ""; 
	String strTravelClassRetFlt        			=  ""; 
	String strPreferTimeModeRetFlt     			=  "";
	String strPreferTimeRetFlt         			=  "";
	String strNameOfAirlineRetFlt	        	=  "";
	String strPreferSeatRetFlt					=  "";

	String strDepCityIntrmiFlt            		=  "";                              
	String strArrCityIntrmiFlt            		=  ""; 
	String strDepDateIntrmiFlt            		=  ""; 
	String strTravelClassIntrmiFlt        		=  ""; 
	String strPreferTimeModeIntrmiFlt     		=  "";
	String strPreferTimeIntrmiFlt         		=  "";
	String strNameOfAirlineIntrmiFlt	    	=  "";
	String strPreferSeatIntrmiFlt				=  "";
	
	String strTravelModeFlt         			=  "1"; 
	String strRemarkFlt			       			=  "";
	String strChangeableAgainst					=  "";
	String strRefundableAgainst					=  "";
	String strCheckedBaggage					=  "";
	
	////Fields for Train Details
	String strTrainMode	            			=  null;
	String strDepCityTrn[]          			=  null; 
	String strArrCityTrn[]          			=  null;
	String strDepDateTrn[]          			=  null; 
	String strPreferTimeModeTrn[]				=  null;
	String strPreferTimeTrn[]					=  null;
	String strTravelClassTrn[]      			=  null;	
	String strPreferSeatTrnType1[]				=  null;
	String strPreferSeatTrnType2[]				=  null;
	String strPreferSeatTrnType3[]				=  null;	
	
	String strDepCityFwdTrn            			=  "";                              
	String strArrCityFwdTrn            			=  ""; 
	String strDepDateFwdTrn            			=  ""; 
	String strTravelClassFwdTrn        			=  ""; 
	String strPreferTimeModeFwdTrn     			=  "";
	String strPreferTimeFwdTrn         			=  "";
	String strNameOfAirlineFwdTrn	        	=  "";
	String strPreferSeatFwdTrn					=  "";

	String strDepCityRetTrn            			=  "";                              
	String strArrCityRetTrn            			=  ""; 
	String strDepDateRetTrn            			=  ""; 
	String strTravelClassRetTrn        			=  ""; 
	String strPreferTimeModeRetTrn     			=  "";
	String strPreferTimeRetTrn         			=  "";
	String strNameOfAirlineRetTrn	        	=  "";
	String strPreferSeatRetTrn					=  "";

	String strDepCityIntrmiTrn            		=  "";                              
	String strArrCityIntrmiTrn            		=  ""; 
	String strDepDateIntrmiTrn            		=  ""; 
	String strTravelClassIntrmiTrn        		=  ""; 
	String strPreferTimeModeIntrmiTrn     		=  "";
	String strPreferTimeIntrmiTrn         		=  "";
	String strNameOfAirlineIntrmiTrn	    	=  "";
	String strPreferSeatIntrmiTrn				=  "";
	
	String strTravelModeTrn         			=  "2"; 
	String strRemarkTrn			       			=  "";
	
	String strBahncard							=  "";
	String strBahncardNo						=  "";
	String strBahncardValidityDate				=  "";
	String strBahncardDiscnt					=  "";
	String strBahncardClass						=  "";
	String strBahncardOnlineTkt					=  "";
	String strSpecialTrain						=  "";
				
	//Fields for Rent a Car
	String strRentCar							=  "";
	String strTravelCarId[]						= null;
	String strStartDate[]        				= null;
	String strStartTime[]        				= null;
	String strStartCity[]           			= null;
	String strStartLocation[]               	= null;
	String strStartMobileNo[]					= null;
	String strStartRouting[]					= null;
	String strEndDate[]        					= null;
	String strEndTime[]        					= null;
	String strEndCity[]           				= null;
	String strEndLocation[]               		= null;
	String strEndMobileNo[]						= null;
	String strEndRouting[]						= null;
	String strCarClass   						=  "";
	String strNeedGps   						=  "";
	String strCategory               			=  "";
	String strCarRemarks						=  "";

	//Fields for Travel Accomodation
	String strAccomo							=  "";
    String strAccIdArr[] 		    			= null;
    String strHotelRequiredArr[]				= null; 
    String strPlaceArr[]        				= null;
    String strCheckinArr[]    					= null;
    String strCheckoutArr[]	        			= null;
    String strRemarksArr[]     					= null;

	String strHotelRequired         			=  "";
	String strBudgetCurrency        			=  "";
	String strHotelBudget           			=  "";
	String strPlace                 			=  "";
	String strCheckin							=  "";
	String strCheckout    						=  "";
	String strRemarks               			=  "";
	
	String strPassportNo        				=  "";
	String strNationality						=  "";
	String strPP_Issu_Country					=  "";
	String strPassportIssuePlace				=  "";	
	String strPassportIssueDate					=  "";		
	String strPassportExpireDate				=  "";	
	String strPermanentAddress					=  "";
	String strCurrentAddress	    			=  "";
	String strPermanentAddressOld				=  "";
	String strCurrentAddressOld		   			=  "";
	String strDOB				    			=  "";
	String strVisaRequired          			=  "";
	String strVisaComment           			=  "";
	
	String strBillingClient 					=  "";
	String strBillingApprover 					=  "";
	
	String strManager               			=  ""; 
	String strHod                   			=  ""; 
	String strBoardMember           			=  "";
	String strSelectManagerRadio    			=  ""; 
	String strReasonForSkip         			=  "";	
	
	String strInsuranceRequired     			=  "2";
	String strNominee               			=  ""; 
	String strRelation             		 		=  ""; 
	String strInsuranceComment      			=  "NA";
	String radioEcnr							=  "2";
	
	String strTravelReqId           			=  "";
	String strTravelId							=  "";
	String strTravelReqNo           			=  "";
	String strInterimId             			=  "";	
	String strParentId              			=  "";
	
	String strCARD_TYPE  						=  "";
	String strCARD_HOLDER_NAME 					=  "";
	String strCARD_NUMBER1 						=  "";
	String strCARD_NUMBER2 						=  "";
	String strCARD_NUMBER3 						=  "";
	String strCARD_NUMBER4 						=  "";
	String strCVV_NUMBER 						=  "";
	String strCARD_EXP_DATE 					=  "";
		
	String strTravllerSiteId 					=  "";
	String strTravellerId 						=  "";	
	String strTravelType            			=  "";	
	String strReturnType        				=  ""; 
	String strActionFlag            			=  "";
	String strMessage               			=  "";
		
	String strDepDateFwd            			=  ""; 	
	
	String strForTatkaalRequired				=  "";
	String strForCoupanRequired					=  "";
	String strRetTatkaalRequired				=  "";
	String strRetCoupanRequired					=  "";
	String strTicketRefundfwd 					=  ""; 
	String strTicketRefundRtd 					=  "";
		
	String strIdentityProof						=  "";
	String strIdentityProofNo					=  "";
	String strIdentityProofOld					=  "";
	String strIdentityProofNoOld				=  "";	
	
	String strBaseCurrency		    			=  "";
	String strTotalAmount           			=  "";
	String strExpenditureRemarks    			=  "";
	String strCashBreakupRemarks    			=  "";
	
	String strTotalFareCurrency					=  "";
	String strTotalFareAmount					=  "";
		
	String strTravellerCheque       			=  "";
	String strTravellerCheque1      			=  "";
	String strTravellerCheque2      			=  "";
	
	String strTCCurrency            			=  "";
	String strTCCurrency1           			=  "";
	String strTCCurrency2           			=  "";
	
	String dbl_YTM_BUDGET           			=  "";
	String dbl_YTD_ACTUAL           			=  "";
	String dbl_AVAIL_BUDGET         			=  "";
	String dbl_EST_EXP              			=  "";
	String str_EXP_REMARKS          			=  "";
	
	//Fields for T_Cash_BreakUp_Int Table
	String strCashAmount1           			=  "";
	String strCashAmount2           			=  "";
	String strCashAmount3           			=  "";
	String strCashAmount4           			=  "";

    String strCashCurrency1         			=  "";
    String strCashCurrency2         			=  "";
    String strCashCurrency3         			=  "";
    String strCashCurrency4         			=  "";
    
    String strLAprice               			=  "";
	String strLAAirLine             			=  "";
	String strLACurrency            			=  "";
	String strLAPrice               			=  "";
	String strLARemarks             			=  "";
	  
	String strTkAgent 		        			=  ""; 
	String strTkAirLine 	        			=  ""; 
	String strTkcurrency 	        			=  ""; 
	String strTklocalprice 	        			=  ""; 
	String strTkRemarks 	        			=  ""; 

	String strPermanent_Req_No      			=  "";
	String strJourneyOrder          			=  "0";
	String strTravelStatusId        			=  "1";  
	String strApproverId            			=  "";   
	String strApproveStatus         			=  "0"; 
	String strApproverOrderId       			=  "";   
	String strApproverRole          			=  ""; 
	ArrayList approverList          			=  new ArrayList();
	ArrayList approverList1         			=  new ArrayList();
	ArrayList l1                    			=  new ArrayList();
	String url                      			=  "";
		
	String strSetFlage 							=  "";
	String flag 								=  ""; 
	String strWhatAction            			=  "";
	String strSiteName							= "";
	String strWorkFlowCode						= "0";
	
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag 				= "";
	
	boolean strFwdJurnFlagFlt          			=  false;
	boolean strRetJurnFlagFlt          			=  false;
	boolean strIntrmiJurnFlagFlt       			=  false;
	boolean strFwdJurnFlagTrn          			=  false;
	boolean strRetJurnFlagTrn          			=  false;
	boolean strIntrmiJurnFlagTrn       			=  false;
	boolean strCreateTravelRequest     			=  false;
	boolean strUpdateTravelRequest     			=  false;
	boolean approversExists            			=  false;
	boolean saveApproverSuccess					=  false;
	boolean saveSuccess                			=  false;
	boolean submitToWorkFlow           			=  false;
	
	strUserId                       =  Suser_id;
	strSiteId                		=  (request.getParameter("travellerSiteId")==null || request.getParameter("travellerSiteId").equals("null")) ? strSiteIdSS : request.getParameter("travellerSiteId") ;
	strTravellerId              	=  request.getParameter("travellerUserId");
	strTravllerSiteId				=  strSiteId;
	strTravelType					=  request.getParameter("travelType");	
	strDesigName                  	=  "";
    strAge                     		=  "";	
	strSex                     		=  "";
	strMealId                    	=  request.getParameter("specialMeal");
	strContactNo		            =  request.getParameter("contactNo");	
	strCostCentre			   		=  request.getParameter("costCenter")==null?"0":request.getParameter("costCenter");
	strProjectNo					=  request.getParameter("projectNo")==null?"0":request.getParameter("projectNo");
	strReasonForTravel       		=  request.getParameter("reasonForTravel");
	
	strAirLineName		            = request.getParameter("airlineName1")== null ? "" : request.getParameter("airlineName1");
	strAirLineName1		            = request.getParameter("airlineName2")== null ? "" : request.getParameter("airlineName2");
	strAirLineName2		            = request.getParameter("airlineName3")== null ? "" : request.getParameter("airlineName3");
	strAirLineName3		            = request.getParameter("airlineName4")== null ? "" : request.getParameter("airlineName4");
	strAirLineName4		            = request.getParameter("airlineName5")== null ? "" : request.getParameter("airlineName5");
	strAirLineNo		            = request.getParameter("airlineNo1")== null ? "" : request.getParameter("airlineNo1");
	strAirLineNo1		            = request.getParameter("airlineNo2")== null ? "" : request.getParameter("airlineNo2");
	strAirLineNo2		            = request.getParameter("airlineNo3")== null ? "" : request.getParameter("airlineNo3");
	strAirLineNo3		            = request.getParameter("airlineNo4")== null ? "" : request.getParameter("airlineNo4");
	strAirLineNo4		            = request.getParameter("airlineNo5")== null ? "" : request.getParameter("airlineNo5");
	
	strHotelName		            = request.getParameter("hotelName1")== null ? "" : request.getParameter("hotelName1");
	strHotelName1		            = request.getParameter("hotelName2")== null ? "" : request.getParameter("hotelName2");
	strHotelName2		            = request.getParameter("hotelName3")== null ? "" : request.getParameter("hotelName3");
	strHotelName3		            = request.getParameter("hotelName4")== null ? "" : request.getParameter("hotelName4");
	strHotelName4		            = request.getParameter("hotelName5")== null ? "" : request.getParameter("hotelName5");
	strHotelNo		            	= request.getParameter("hotelNo1")== null ? "" : request.getParameter("hotelNo1");
	strHotelNo1		            	= request.getParameter("hotelNo2")== null ? "" : request.getParameter("hotelNo2");
	strHotelNo2		            	= request.getParameter("hotelNo3")== null ? "" : request.getParameter("hotelNo3");
	strHotelNo3		            	= request.getParameter("hotelNo4")== null ? "" : request.getParameter("hotelNo4");
	strHotelNo4		            	= request.getParameter("hotelNo5")== null ? "" : request.getParameter("hotelNo5");
	
	strFlightMode	          		=  request.getParameter("flight");		
	strDepCityFlt                  	=  request.getParameterValues("depCityFlt");	
	strArrCityFlt                  	=  request.getParameterValues("arrCityFlt");
	strDepDateFlt                 	=  request.getParameterValues("depDateFlt");
	strPreferTimeModeFlt			=  request.getParameterValues("preferTimeModeFlt");
	strPreferTimeFlt               	=  request.getParameterValues("preferTimeFlt");
	strTravelClassFlt          		=  request.getParameterValues("departClassFlt");	
	strPreferSeatFlt   				=  request.getParameterValues("seatPreffredFlt");
	strRemarkFlt	          		=  request.getParameter("remarksFlt");	
	strChangeableAgainst	   		=  request.getParameter("changeable");	
	strRefundableAgainst       		=  request.getParameter("refundable");	
	strCheckedBaggage          		=  request.getParameter("baggageFlt");	
	
	strTrainMode	          		=  request.getParameter("train");	
	strDepCityTrn                  	=  request.getParameterValues("depCityTrn");	
	strArrCityTrn                  	=  request.getParameterValues("arrCityTrn");
	strDepDateTrn                 	=  request.getParameterValues("depDateTrn");
	strPreferTimeModeTrn			=  request.getParameterValues("preferTimeModeTrn");
	strPreferTimeTrn               	=  request.getParameterValues("preferTimeTrn");
	strTravelClassTrn          		=  request.getParameterValues("departClassTrn");	
	strPreferSeatTrnType1   		=  request.getParameterValues("seatPreffredTrnType1");
	strPreferSeatTrnType2   		=  request.getParameterValues("seatPreffredTrnType2");
	strPreferSeatTrnType3   		=  request.getParameterValues("seatPreffredTrnType3");
	
	strRemarkTrn	          		=  request.getParameter("remarksTrn");	
	strBahncard	   					=  request.getParameter("bahncrd");	
	strBahncardNo		       		=  request.getParameter("bahnNo");	
	strBahncardValidityDate			=  request.getParameter("bahnCardValidDate");
	strBahncardDiscnt          		=  request.getParameter("bahnCardDisc");
	strBahncardClass	       		=  request.getParameter("bahnCardClass");	
	strBahncardOnlineTkt	   		=  request.getParameter("bahnOnlineTkt");	
	strSpecialTrain		       		=  request.getParameter("sparzug");	
	
	strRentCar						=  request.getParameter("rentCar");
	strTravelCarId					=  request.getParameterValues("travelCarId");
	strStartDate        			=  request.getParameterValues("startDate");
	strStartTime        			=  request.getParameterValues("startTime");
	strStartCity           			=  request.getParameterValues("startCity");
	strStartLocation               	=  request.getParameterValues("startLocation");
	strStartMobileNo				=  request.getParameterValues("startMobileNo");
	strStartRouting 				=  request.getParameterValues("startRouting");
	strEndDate        				=  request.getParameterValues("endDate");
	strEndTime        				=  request.getParameterValues("endTime");
	strEndCity           			=  request.getParameterValues("endCity");
	strEndLocation               	=  request.getParameterValues("endLocation");
	strEndMobileNo					=  request.getParameterValues("endMobileNo");
	strEndRouting					=  request.getParameterValues("endRouting");
	strCarClass						=  request.getParameter("carClass");
	strNeedGps   					=  request.getParameter("gps");
	strCategory               		=  request.getParameter("carCategory");
	strCarRemarks					=  request.getParameter("remarksCar");	
	
	strAccomo						= request.getParameter("accomodation");
	strAccIdArr 		    		= request.getParameterValues("accomId");
    strHotelRequiredArr 			= request.getParameterValues("hotel"); 
    strPlaceArr        	       		= request.getParameterValues("place");    
    strCheckinArr    				= request.getParameterValues("checkin");
    strCheckoutArr	        		= request.getParameterValues("checkout");
    strRemarks     					= request.getParameter("otherComment");
	
    strTotalFareCurrency		    = request.getParameter("TotalFareCurrency")==null?"":request.getParameter("TotalFareCurrency");
	strTotalFareAmount		        = request.getParameter("TotalFareAmount")==null?"0":request.getParameter("TotalFareAmount");
	
	strBillingClient               	=  request.getParameter("billingClient")==null ?"" :request.getParameter("billingClient");          
	strBillingApprover              =  request.getParameter("billingApprover")==null?"0":request.getParameter("billingApprover");    
		
	strManager             			=  request.getParameter("manager");
	strHod                			=  request.getParameter("hod");
	strSelectManagerRadio         	=  "manual";
	
	firstName						= request.getParameter("fNamePassport");
	lastName						= request.getParameter("lNamePassport");
	strPassportNo                   = request.getParameter("passportNo");
	strNationality                  = request.getParameter("nationality");
	strPP_Issu_Country				= request.getParameter("pp_country");
	strPassportIssuePlace		    = request.getParameter("placeOfIssue");
	strPassportIssueDate			= request.getParameter("dateOfIssue");		
	strPassportExpireDate			= request.getParameter("dateOfExpiry");	
	strDOB				            = request.getParameter("dob");
		
	strVisaRequired                 =  request.getParameter("visa");
	strVisaComment        			=  request.getParameter("visaComment");
	
	strBaseCurrency                 =  request.getParameter("basecur")==null?"INR":request.getParameter("basecur");
	
	strForTatkaalRequired			= "0";
	strForCoupanRequired			= "0";
	strRetTatkaalRequired			= "0";
	strRetCoupanRequired			= "0";
	strTicketRefundfwd 				= "n"; 
	strTicketRefundRtd 				= "n";
		
	strCARD_TYPE					=  "-1"; 
	strCARD_HOLDER_NAME         	=  ""; 
	strCVV_NUMBER			   		=  "";
	strCARD_EXP_DATE				=  "";
	strCARD_NUMBER1					=  "";
	strCARD_NUMBER2					=  "";
	strCARD_NUMBER3					=  "";
	strCARD_NUMBER4					=  ""; 
		
	strTravelReqId                  =  request.getParameter("travelReqId");    // from hidden field
	strTravelId                     =  request.getParameter("travelId");       // from hidden field
	strTravelReqNo                  =  request.getParameter("travelReqNo");    // for hidden field
	strInterimId			 		=  request.getParameter("interimId");	   // for hidden field
	strWhatAction                   =  request.getParameter("whatAction");     //from hidden field
			
	int maxJourneyOrderCount 		=  0;
	
	String strTravel_Req_Id  		=  "";
	String strTravel_Id  			=  "";
	String strTravel_Req_No 		=  "";
	String strTravel_Id_Intrim		=  "";
	
	if(strManager != null && strManager.equalsIgnoreCase("S")) {
		strManager = null;		
	}
	if(strHod != null && strHod.equalsIgnoreCase("S")) {
		strHod = null;		
	}
	if(strBoardMember!= null && strBoardMember.equalsIgnoreCase("B")) {
		strBoardMember = null;
	}	
	
	if(strCheckin !=null && "".equals(strCheckin)) {
		strCheckin	=	null;
	}
	if(strCheckout !=null && "".equals(strCheckout)) {
		strCheckout	=	null; 
	}
	
	if(strBahncardValidityDate !=null && "".equals(strBahncardValidityDate)) {
		strBahncardValidityDate	=	null; 
	}
	
	if(!strBillingClient.equals("") && strBillingClient.equals(strTravllerSiteId)) {
	 	flag ="no"; 
    }
	
	if(!strBillingApprover.equals("") && strBillingApprover.equals("-1")) {
		flag ="no"; 
	}
	
	if(strHotelRequired != null && strHotelRequired.equals("2")) {
		if(strHotelBudget!= null && strHotelBudget.equalsIgnoreCase("Budget")) {
			strHotelBudget = null;
		} 
	}
	
	if(strCostCentre.equals("")) {
		strCostCentre ="0"; 
    }
	
	if(strTotalFareAmount.equals("")) {
		strTotalFareAmount ="0"; 
    }
	
	if(strTravelReqId != null && strTravelReqId.equals("new")) {
	    strActionFlag   = "insert";
	}
	
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strSiteId, "0");		
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strTravellerId, strSiteId, "0");		
	} 
	if(!strUserAccessCheckFlag.equals("420") && !strTravelId.equals("new")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, '"'+strTravelType+'"', Suser_id);		
	}

	if(strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();
		dbConBean2.close();
		dbConBean3.close();
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_QuickTravel_Detail_GmbH_Post.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {
	
	strSql = "SELECT ISNULL(dbo.DESIGNATIONNAME(DESIG_ID),'') AS DESIG FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
      rs       =   dbConBean.executeQuery(strSql); 
	  if(rs.next()) {
        strDesigName = rs.getString("DESIG"); 
	  }
	  rs.close();	
	  
    strSql = "SELECT dbo.CalAge_YYMMDD(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;	  
	  rs       =   dbConBean.executeQuery(strSql);  
	  if(rs.next()) {
		strAge = rs.getString(1);
		strGender=rs.getString(2);	
	  }  
	  rs.close();
	  
	  if(strGender!=null) {
		  if(strGender.equals("Male")  ) {
			  strSex= "1";
		  } else {
			  strSex= "2";
		  }
	  } else {
		  strSex= "1";
	  }
	  
    strSql = "SELECT dbo.CALAGE(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strTravellerId;
	  rs       =   dbConBean.executeQuery(strSql);  
	  if(rs.next())  {
		  strAge = rs.getString(1);
	  }  
	  rs.close();
	  if(strAge == null)
		  strAge = "";
	  if(strAge != null && strAge.equals("0"))
		  strAge="";
	  if(strAge != null && strAge.equals("-1"))
		  strAge="";
		
	// code to check if identity proof is already exits in M_userinfor then added
	strSql="SELECT IDENTITY_ID, IDENTITY_NO, ISNULL(ADDRESS,'') AS ADDRESS, ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS FROM M_USERINFO (NOLOCK) WHERE USERID = "+strTravellerId+" AND STATUS_ID = 10";
	rs	=	dbConBean.executeQuery(strSql);
	while(rs.next()) {
		strIdentityProofOld 	=rs.getString("IDENTITY_ID"); 
		strIdentityProofNoOld	=rs.getString("IDENTITY_NO"); 
		strPermanentAddressOld 	=rs.getString("ADDRESS");
		strCurrentAddressOld	=rs.getString("CURRENT_ADDRESS");
		}
	rs.close();	
	
	if(strPermanentAddress == null || strPermanentAddress.equals("")){
		strPermanentAddress = strPermanentAddressOld;
	}
	if(strCurrentAddress == null || strCurrentAddress.equals("")){
		strCurrentAddress = strCurrentAddressOld;
	}	
	if( strIdentityProof ==null) {
		strIdentityProof="";
	}	
	if( strIdentityProofNo ==null) {
		strIdentityProofNo="";
	}	
	
	if(strDepCityFlt.length == 1) {	
		strFwdJurnFlagFlt 	= true;
		strReturnType 	=  "1"; 
	} else if(strDepCityFlt.length == 2) {	
		strFwdJurnFlagFlt 	= true;
		strRetJurnFlagFlt 	= true;
		strReturnType  	=  "2";
	} else if(strDepCityFlt.length > 2) {	
		strFwdJurnFlagFlt 	= true;
		strRetJurnFlagFlt 	= true;
		strIntrmiJurnFlagFlt = true;
		strReturnType     =  "2";
	}
	
	if(strDepCityTrn.length == 1) {	
		strFwdJurnFlagTrn 	= true;
		strReturnType 	=  "1"; 
	} else if(strDepCityTrn.length == 2) {	
		strFwdJurnFlagTrn 	= true;
		strRetJurnFlagTrn 	= true;
		strReturnType  	=  "2";
	} else if(strDepCityTrn.length > 2) {	
		strFwdJurnFlagTrn 	= true;
		strRetJurnFlagTrn 	= true;
		strIntrmiJurnFlagTrn = true;
		strReturnType     =  "2";
	}	
	
	if(strFlightMode != null && !strFlightMode.equals("") && strFlightMode.equals("1")) {
	    if(strFwdJurnFlagFlt) {					
	    	strDepDateFwd 		= strDepDateFlt[0];
	    } 
    } else if(strTrainMode != null && !strTrainMode.equals("") &&strTrainMode.equals("1")) {
    	if(strFwdJurnFlagTrn) {					
	    	strDepDateFwd 		= strDepDateTrn[0];
	    } 
    } else if(strRentCar != null && !strRentCar.equals("") && strRentCar.equals("1")) {
    		strDepDateFwd 		= strStartDate[0];
    } else if(strAccomo != null && !strAccomo.equals("") && strAccomo.equals("1")) {
    		strDepDateFwd 		= strCheckinArr[0];
    }
	
	if(strTravelType != null && strTravelType.equals("D")) {
		if(strFlightMode != null && !strFlightMode.equals("") && strFlightMode.equals("1")) {
			strWorkFlowCode = "1";
		} else {
			strWorkFlowCode = "0";
		}
	} else if(strTravelType != null && strTravelType.equals("I")) {
		strWorkFlowCode = "1";
	}
    
    if(strIntrmiJurnFlagFlt || strIntrmiJurnFlagTrn) {
		strTravel_Id_Intrim  =  dbUtilityBean.getNewGeneratedId("INTERIM_ID")+"";
    }
	
	if(!strSiteId.trim().equalsIgnoreCase(strSiteIdSS.trim())) {		 
		 strSql="select site_name from m_site where site_id="+strSiteId;
		 rs = dbConBean.executeQuery(strSql);
			while(rs.next()){  
				strSiteName = rs.getString("site_name");	 		
			 }			
			rs.close();				
	  } else {	  
		  strSiteName = strSiteFullName;
	  }
	 
	if(strActionFlag!=null && strActionFlag.equals("insert")) {
		strCreateTravelRequest = true;
		strTravel_Req_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_REQ_ID")+"";		
		if(strTravelType.equals("D")) {
			strTravel_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_DOM")+"";
			strTravel_Req_No = "TEMP/"+strSiteName.trim()+"/DOM/"+strTravel_Id;
		} else if(strTravelType.equals("I")) {
			strTravel_Id  =  dbUtilityBean.getNewGeneratedId("TRAVEL_ID_INT")+"";
			strTravel_Req_No = "TEMP/"+strSiteName.trim()+"/INT/"+strTravel_Id;
		}
		
	} else {
		strUpdateTravelRequest =  true;
		strTravel_Req_Id     = strTravelReqId;
	    strTravel_Id         = strTravelId;   
	    strTravel_Req_No     = strTravelReqNo;	    
	}
	
	try {	
		
		if(strCreateTravelRequest) {
		 	objCon =  dbConBean.getConnection(); 
		 	objCon.setAutoCommit(false);
		 
		   //PROCEDURE to insert the data in T_TRAVEL_MST
			objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_MST(?,?,?,?)}");
		    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		    objCstmt.setString(2, strTravel_Req_Id);
		    objCstmt.setString(3, strSiteId);
		    objCstmt.setString(4, Suser_id);
		    objCstmt.setString(5, strTravelType);
		    intSuccess1 = objCstmt.executeUpdate();
		    objCstmt.close();
		    
		    if(strTravelType != null && strTravelType.equals("D")) {
		    	  //PROCEDURE for INSERT data in T_TRAVEL_DETAIL_DOM
				  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");  
				  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  objCstmt.setString(2, strTravel_Req_Id);
				  objCstmt.setString(3, strTravel_Id);
				  objCstmt.setString(4, strTravel_Req_No);
				  objCstmt.setString(5, strSiteId);
				  objCstmt.setString(6, strTravellerId);
				  objCstmt.setString(7, strAge);
				  objCstmt.setString(8, strSex);
				  objCstmt.setString(9, strDepDateFwd);
				  objCstmt.setString(10, strMealId);
				  objCstmt.setString(11, strHotelRequired);
				  objCstmt.setString(12, strHotelBudget);
				  objCstmt.setString(13, strBudgetCurrency);
				  objCstmt.setString(14, strCheckin);
				  objCstmt.setString(15, strCheckout);
				  objCstmt.setString(16, strRemarks);
				  objCstmt.setString(17, strReturnType);
				  objCstmt.setString(18, Suser_id);
				  objCstmt.setString(19, strSelectManagerRadio);
				  objCstmt.setString(20, strManager);
		      	  objCstmt.setString(21, strHod);
		  		  objCstmt.setString(22, strCARD_TYPE);					  
				  objCstmt.setString(23, strCARD_HOLDER_NAME);
		          objCstmt.setString(24, strCARD_NUMBER1); 
				  objCstmt.setString(25, strCARD_NUMBER2); 
				  objCstmt.setString(26, strCARD_NUMBER3); 
				  objCstmt.setString(27, strCARD_NUMBER4); 
				  objCstmt.setString(28, strCVV_NUMBER); 
				  objCstmt.setString(29, strCARD_EXP_DATE); 
				  objCstmt.setString(30, strReasonForTravel); 
		  		  objCstmt.setString(31, strReasonForSkip); 
		   		  objCstmt.setString(32, strPlace); 	
		   		  objCstmt.setString(33, strForTatkaalRequired); 
		   		  objCstmt.setString(34, strForCoupanRequired); 
		  		  objCstmt.setString(35, strRetTatkaalRequired); 
				  objCstmt.setString(36, strRetCoupanRequired); 			  		 
				  objCstmt.setString(37, strIdentityProof);			         
				  objCstmt.setString(38, strIdentityProofNo); 
				  objCstmt.setString(39, "N");
				  objCstmt.setString(40, strBoardMember);
				  objCstmt.setInt(41, Integer.parseInt(strCostCentre));
				  objCstmt.setString(42, strProjectNo);
				  objCstmt.setString(43, strChangeableAgainst);
				  objCstmt.setString(44, strRefundableAgainst);
				  objCstmt.setString(45, strCheckedBaggage);
				  objCstmt.setString(46, strBahncardNo);
				  objCstmt.setString(47, strBahncardDiscnt);
				  objCstmt.setString(48, strBahncardClass);
				  objCstmt.setString(49, strBahncardOnlineTkt);
				  objCstmt.setString(50, strSpecialTrain);
				  objCstmt.setString(51, strRemarkFlt);
				  objCstmt.setString(52, strRemarkTrn);
				  objCstmt.setString(53, strBahncardValidityDate);
				  objCstmt.setString(54, strCarRemarks);
				  intSuccess2 = objCstmt.executeUpdate();
				  objCstmt.close();
				
			} else if(strTravelType != null && strTravelType.equals("I")) {
				//PROCEDURE to INSERT data in T_TRAVEL_DETAIL_INT			
			    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
				objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			    objCstmt.setString(2, strTravel_Req_Id);
			    objCstmt.setString(3, strTravel_Id);
			    objCstmt.setString(4, strTravel_Req_No);
			    objCstmt.setString(5, strSiteId);
			    objCstmt.setString(6, strTravellerId);
			    objCstmt.setString(7, strAge);
			    objCstmt.setString(8, strSex);
			    objCstmt.setString(9, strDepDateFwd);
			    objCstmt.setString(10, strMealId);
			    objCstmt.setString(11, strVisaRequired);
			    objCstmt.setString(12, strVisaComment);
			    objCstmt.setString(13, strInsuranceRequired);
			    objCstmt.setString(14, strNominee);
			    objCstmt.setString(15, strRelation);
			    objCstmt.setString(16, strInsuranceComment);
			    objCstmt.setString(17, strHotelRequired);
			    objCstmt.setString(18, strHotelBudget);
			    objCstmt.setString(19, strPlace);
			    objCstmt.setString(20, strBudgetCurrency);
			    objCstmt.setString(21, strRemarks);
			    objCstmt.setString(22, strReturnType);
				objCstmt.setString(23, Suser_id);
			    objCstmt.setString(24, strSelectManagerRadio);
				objCstmt.setString(25, strManager);
				objCstmt.setString(26, strHod);
				objCstmt.setString(27, strCARD_TYPE);  
				objCstmt.setString(28, strCARD_HOLDER_NAME);		
				objCstmt.setString(29, strCARD_NUMBER1); 
				objCstmt.setString(30, strCARD_NUMBER2); 
				objCstmt.setString(31, strCARD_NUMBER3); 
				objCstmt.setString(32, strCARD_NUMBER4); 
				objCstmt.setString(33, strCVV_NUMBER); 
				objCstmt.setString(34, strCARD_EXP_DATE); 
				objCstmt.setString(35, strCheckin); 
				objCstmt.setString(36, strCheckout); 
				objCstmt.setString(37, strReasonForTravel);
				objCstmt.setString(38, strReasonForSkip);
				objCstmt.setString(39, "");
				objCstmt.setString(40, "N");
				objCstmt.setString(41, strBoardMember);
				objCstmt.setInt(42, Integer.parseInt(strCostCentre));
				objCstmt.setString(43, strProjectNo);
				objCstmt.setString(44, strChangeableAgainst);
				objCstmt.setString(45, strRefundableAgainst);
				objCstmt.setString(46, strCheckedBaggage);
				objCstmt.setString(47, strBahncardNo);
				objCstmt.setString(48, strBahncardDiscnt);
				objCstmt.setString(49, strBahncardClass);
				objCstmt.setString(50, strBahncardOnlineTkt);
				objCstmt.setString(51, strSpecialTrain);
				objCstmt.setString(52, strRemarkFlt);
				objCstmt.setString(53, strRemarkTrn);
				objCstmt.setString(54, strBahncardValidityDate);
				objCstmt.setString(55, strCarRemarks);
			    intSuccess2 = objCstmt.executeUpdate();
			    objCstmt.close();
			}
		} else if(strUpdateTravelRequest) {
			    objCon =  dbConBean.getConnection(); 
			
				if(strTravelType != null && strTravelType.equals("D")) { 		 
	    		    stmt = 	objCon.createStatement();
	    		    
				    strSql = "SELECT PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strTravel_Id+" AND TRAVEL_TYPE ='D' AND TRAVEL_MODE=1";
				    rs2 = null;
					rs2     = dbConBean3.executeQuery(strSql);
					if(rs2.next()) {						
						strParentId = rs2.getString("PARENT_ID");						
						strSql2 = "DELETE FROM T_INTERIM_JOURNEY WHERE PARENT_ID="+strParentId+" AND TRAVEL_ID="+strTravel_Id+" AND TRAVEL_TYPE ='D' AND TRAVEL_MODE=1"; 
						iSuccess = stmt.executeUpdate(strSql2);						 					
					}
					rs2.close();
					
					strSql="DELETE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=1 AND STATUS_ID=10) AND STATUS_ID=10 AND APPLICATION_ID=1";
					intSuccess = stmt.executeUpdate(strSql);	
					
					strSql = "SELECT PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strTravel_Id+" AND TRAVEL_TYPE = 'D' AND TRAVEL_MODE=2";
				    rs2 = null;
					rs2     = dbConBean3.executeQuery(strSql);
					if(rs2.next()) {						
						strParentId = rs2.getString("PARENT_ID");						
						strSql2 = "DELETE FROM T_INTERIM_JOURNEY WHERE PARENT_ID="+strParentId+" AND TRAVEL_ID="+strTravel_Id+" AND TRAVEL_TYPE = 'D' AND TRAVEL_MODE=2"; 
						iSuccess = stmt.executeUpdate(strSql2);						 					
					}
					rs2.close();
					
					strSql="DELETE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=2 AND STATUS_ID=10) AND STATUS_ID=10 AND APPLICATION_ID=1";
					intSuccess = stmt.executeUpdate(strSql);
						    		  
					strSql = "DELETE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+"AND TRAVEL_MODE IN (1,2,5,7) AND STATUS_ID=10 AND APPLICATION_ID=1";
					intSuccess = stmt.executeUpdate(strSql);	
					
					strSql = "DELETE FROM T_RET_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravelId+" AND STATUS_ID=10 AND APPLICATION_ID=1";
					intSuccess = stmt.executeUpdate(strSql);
				  
				  if(strIdentityProofOld==null || strIdentityProofOld.equals("-1") || strIdentityProofOld.equals("0")) {
				        strSql = "UPDATE M_USERINFO SET  IDENTITY_ID='"+strIdentityProof+"',IDENTITY_NO='"+strIdentityProofNo+"', CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2+"',FF_NUMBER3=N'"+strAirLineNo3+"',FF_NUMBER4=N'"+strAirLineNo4 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId ;
				  } else {
				  		strSql = "UPDATE M_USERINFO SET CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2+"',FF_NUMBER3=N'"+strAirLineNo3+"',FF_NUMBER4=N'"+strAirLineNo4 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId ;
				  }	
				  int iupdate = stmt.executeUpdate(strSql);	
				   
					strSql = "SELECT * FROM T_APPROVERS WHERE TRAVEL_ID= "+strTravel_Id;
					rs2 = null;
					rs2     = dbConBean3.executeQuery(strSql);
					if(rs2.next()) {
					  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FROM_DOM_TABLE(?,?,?)}"); 
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strTravel_Req_Id);
					  objCstmt.setString(3, strTravel_Id);
					  objCstmt.setString(4, strTravelType); 
					  intSuccess1   =  objCstmt.executeUpdate();
					  objCstmt.close();
					} else {
						intSuccess1   = 1;
					}
					rs2.close();
					
				  objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_DETAIL_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
				  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  objCstmt.setString(2, strTravel_Req_Id);
				  objCstmt.setString(3, strTravel_Id);
				  objCstmt.setString(4, strTravel_Req_No);
				  objCstmt.setString(5, strSiteId);
				  objCstmt.setString(6, strTravellerId);
				  objCstmt.setString(7, strAge);
				  objCstmt.setString(8, strSex);
				  objCstmt.setString(9, strDepDateFwd);
				  objCstmt.setString(10, strMealId);
				  objCstmt.setString(11, strHotelRequired);
				  objCstmt.setString(12, strHotelBudget);
				  objCstmt.setString(13, strBudgetCurrency);
				  objCstmt.setString(14, strCheckin);
				  objCstmt.setString(15, strCheckout);
				  objCstmt.setString(16, strRemarks);
				  objCstmt.setString(17, strReturnType);
				  objCstmt.setString(18, Suser_id);
				  objCstmt.setString(19, strSelectManagerRadio);
				  objCstmt.setString(20, strManager);
				  objCstmt.setString(21, strHod);
				  objCstmt.setString(22, strCARD_TYPE); 
				  objCstmt.setString(23, strCARD_HOLDER_NAME);
				  objCstmt.setString(24, strCARD_NUMBER1); 
				  objCstmt.setString(25, strCARD_NUMBER2); 
				  objCstmt.setString(26, strCARD_NUMBER3); 
				  objCstmt.setString(27, strCARD_NUMBER4); 
				  objCstmt.setString(28, strCVV_NUMBER); 
				  objCstmt.setString(29, strCARD_EXP_DATE); 
				  objCstmt.setString(30, strReasonForTravel); 
				  objCstmt.setString(31, strReasonForSkip);	
				  objCstmt.setString(32, strPlace); 	
				  objCstmt.setString(33, strForTatkaalRequired); 
				  objCstmt.setString(34, strForCoupanRequired); 
				  objCstmt.setString(35, strRetTatkaalRequired); 
				  objCstmt.setString(36, strRetCoupanRequired); 
				  objCstmt.setString(37, strIdentityProof); 	
				  objCstmt.setString(38, strIdentityProofNo);	
				  objCstmt.setString(39, "");  
				  objCstmt.setString(40, strBoardMember);
				  objCstmt.setInt(41, Integer.parseInt(strCostCentre));
				  objCstmt.setString(42, strProjectNo);
				  objCstmt.setString(43, strChangeableAgainst);
				  objCstmt.setString(44, strRefundableAgainst);
				  objCstmt.setString(45, strCheckedBaggage);
				  objCstmt.setString(46, strBahncardNo);
				  objCstmt.setString(47, strBahncardDiscnt);
				  objCstmt.setString(48, strBahncardClass);
				  objCstmt.setString(49, strBahncardOnlineTkt);
				  objCstmt.setString(50, strSpecialTrain);
				  objCstmt.setString(51, strRemarkFlt);
				  objCstmt.setString(52, strRemarkTrn);
				  objCstmt.setString(53, strBahncardValidityDate);
				  objCstmt.setString(54, strCarRemarks);
				  intSuccess2   =  objCstmt.executeUpdate();
				  objCstmt.close();
	    	} else if(strTravelType != null && strTravelType.equals("I")) {	  
	    		  stmt = 	objCon.createStatement();
	    		  
	    		  strSql = "SELECT PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strTravel_Id+" AND TRAVEL_TYPE = 'I' AND TRAVEL_MODE=1";
	    		  rs2 = null;
				  rs2     = dbConBean3.executeQuery(strSql);
				  if(rs2.next()) {						
					 strParentId = rs2.getString("PARENT_ID");					 
					 strSql2 = "DELETE FROM T_INTERIM_JOURNEY WHERE PARENT_ID="+strParentId+" AND TRAVEL_ID="+strTravel_Id+" AND TRAVEL_TYPE = 'I' AND TRAVEL_MODE=1"; 
					 iSuccess = stmt.executeUpdate(strSql2);					 					
				  }
				  rs2.close();			    			
				  	    			  	  
				  strSql = "DELETE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=1 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=1 AND STATUS_ID=10) AND STATUS_ID=10 AND APPLICATION_ID=1";
				  intSuccess = stmt.executeUpdate(strSql);
				  
				  strSql = "SELECT PARENT_ID FROM T_INTERIM_JOURNEY WHERE TRAVEL_ID = "+strTravel_Id+" AND TRAVEL_TYPE = 'I' AND TRAVEL_MODE=2";
	    		  rs2 = null;
				  rs2     = dbConBean3.executeQuery(strSql);
				  if(rs2.next()) {						
					 strParentId = rs2.getString("PARENT_ID");						
					 strSql2 = "DELETE FROM T_INTERIM_JOURNEY WHERE PARENT_ID="+strParentId+" AND TRAVEL_ID="+strTravel_Id+" AND TRAVEL_TYPE = 'I' AND TRAVEL_MODE=2"; 
					 iSuccess = stmt.executeUpdate(strSql2);					 					
				  }
				  rs2.close();			    	
				  
				  strSql = "DELETE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=2 AND JOURNEY_ORDER >(SELECT MIN(JOURNEY_ORDER) FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND TRAVEL_MODE=2 AND STATUS_ID=10) AND STATUS_ID=10 AND APPLICATION_ID=1";
				  intSuccess = stmt.executeUpdate(strSql);				  
	    		  
				  strSql = "DELETE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+"AND TRAVEL_MODE IN (1,2,5,7) AND STATUS_ID=10 AND APPLICATION_ID=1";
				  intSuccess = stmt.executeUpdate(strSql);
				  
				  strSql = "DELETE FROM T_RET_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravelId+" AND APPLICATION_ID=1";
				  intSuccess = stmt.executeUpdate(strSql);
	    		
				  strSql = "SELECT * FROM T_APPROVERS WHERE TRAVEL_ID= "+strTravel_Id;
				  rs2 = null;
				  rs2     = dbConBean3.executeQuery(strSql);
					if(rs2.next()) {
			    	  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_FROM_INT_TABLE(?,?,?)}"); 
			  	      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  	      objCstmt.setString(2, strTravel_Req_Id);
			  	      objCstmt.setString(3, strTravel_Id);
			  		  objCstmt.setString(4, strTravelType); 
			  	      intSuccess1   =  objCstmt.executeUpdate();
			  	      objCstmt.close();
					} else {
						intSuccess1   = 1;
					}
			  	    rs2.close();
			  	    
			  	  objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_DETAIL_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
			  	  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			      objCstmt.setString(2, strTravel_Req_Id);
			      objCstmt.setString(3, strTravel_Id);
			      objCstmt.setString(4, strTravel_Req_No);
			      objCstmt.setString(5, strSiteId);
			      objCstmt.setString(6, strTravellerId);
			      objCstmt.setString(7, strAge);
			      objCstmt.setString(8, strSex);
			      objCstmt.setString(9, strDepDateFwd);
			      objCstmt.setString(10, strMealId);
			      objCstmt.setString(11, strVisaRequired);
			      objCstmt.setString(12, strVisaComment);
			      objCstmt.setString(13, strInsuranceRequired);
			      objCstmt.setString(14, strNominee);
			      objCstmt.setString(15, strRelation);
			      objCstmt.setString(16, strInsuranceComment);
			      objCstmt.setString(17, strHotelRequired);
			      objCstmt.setString(18, strHotelBudget);
			      objCstmt.setString(19, strPlace);
			      objCstmt.setString(20, strBudgetCurrency);
			      objCstmt.setString(21, strRemarks);
			      objCstmt.setString(22, strReturnType);
				  objCstmt.setString(23, Suser_id);
			      objCstmt.setString(24, strSelectManagerRadio);
				  objCstmt.setString(25, strManager);
				  objCstmt.setString(26, strHod);
				  objCstmt.setString(27, strCARD_TYPE);  
				  objCstmt.setString(28, strCARD_HOLDER_NAME);		
				  objCstmt.setString(29, strCARD_NUMBER1); 
				  objCstmt.setString(30, strCARD_NUMBER2); 
				  objCstmt.setString(31, strCARD_NUMBER3); 
				  objCstmt.setString(32, strCARD_NUMBER4); 
				  objCstmt.setString(33, strCVV_NUMBER); 
				  objCstmt.setString(34, strCARD_EXP_DATE); 
				  objCstmt.setString(35, strCheckin); 
				  objCstmt.setString(36, strCheckout); 
				  objCstmt.setString(37, strReasonForTravel);
				  objCstmt.setString(38, strReasonForSkip);
				  objCstmt.setString(39, "");
			  	  objCstmt.setString(40, strBoardMember);
			  	  objCstmt.setInt(41, Integer.parseInt(strCostCentre));
			  	  objCstmt.setString(42, strProjectNo);
				  objCstmt.setString(43, strChangeableAgainst);
				  objCstmt.setString(44, strRefundableAgainst);
				  objCstmt.setString(45, strCheckedBaggage);
				  objCstmt.setString(46, strBahncardNo);
				  objCstmt.setString(47, strBahncardDiscnt);
				  objCstmt.setString(48, strBahncardClass);
				  objCstmt.setString(49, strBahncardOnlineTkt);
				  objCstmt.setString(50, strSpecialTrain);
				  objCstmt.setString(51, strRemarkFlt);
				  objCstmt.setString(52, strRemarkTrn);
				  objCstmt.setString(53, strBahncardValidityDate);
				  objCstmt.setString(54, strCarRemarks);
			  	  intSuccess2   =  objCstmt.executeUpdate();
			  	  objCstmt.close();	    		
	    	}
		}
	    
		if(strFlightMode != null && !strFlightMode.equals("") && strFlightMode.equals("1")) {
			    
			 //Insert Flight Details Start
			 if(strFwdJurnFlagFlt) {				 				 
					strDepCityFwdFlt 		= strDepCityFlt[0];
					strArrCityFwdFlt 		= strArrCityFlt[0];
					strDepDateFwdFlt 		= strDepDateFlt[0];
					strPreferTimeModeFwdFlt = strPreferTimeModeFlt[0];
					strPreferTimeFwdFlt		= strPreferTimeFlt[0];					
					strTravelClassFwdFlt 	= strTravelClassFlt[0];
					strPreferSeatFwdFlt		= strPreferSeatFlt[0];
					
					if(strTravelType != null && strTravelType.equals("D")) {	
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						rsFlt1       =   dbConBean.executeQuery(strSql); 
						  if(rsFlt1.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsFlt1.getString("JOURNEY_ORDER"); 
						  }
						rsFlt1.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
						
						//PROCEDURE for INSERT data in T_JOURNEY_DETAILS_DOM
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityFwdFlt);
						objCstmt.setString(4, strArrCityFwdFlt);
						objCstmt.setString(5, strDepDateFwdFlt); 
						objCstmt.setString(6, strJourneyOrder);
						objCstmt.setString(7, strTravelModeFlt);
						objCstmt.setString(8, strNameOfAirlineFwdFlt);
						objCstmt.setString(9, strTravelClassFwdFlt);
						objCstmt.setString(10, strPreferTimeFwdFlt);
						objCstmt.setString(11, Suser_id);						  
						objCstmt.setString(12, strPreferSeatFwdFlt);
						objCstmt.setString(13, strTicketRefundfwd);	
						objCstmt.setString(14, strPreferTimeModeFwdFlt);
						objCstmt.setInt(15, 0);
						objCstmt.setInt(16, 0);
						intSuccess3 = objCstmt.executeUpdate();
						objCstmt.close();
					} else if(strTravelType != null && strTravelType.equals("I")) {
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						rsFlt1       =   dbConBean.executeQuery(strSql); 
						  if(rsFlt1.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsFlt1.getString("JOURNEY_ORDER"); 
						  }
						 rsFlt1.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
						
						//PROCEDURE to INSERT data in T_JOURNEY_DETAILS_INT
					    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
					    objCstmt.setString(3, strDepCityFwdFlt);
					    objCstmt.setString(4, strArrCityFwdFlt);
					    objCstmt.setString(5, strDepDateFwdFlt); 
					    objCstmt.setString(6, strJourneyOrder);
					    objCstmt.setString(7, strTravelModeFlt);
					    objCstmt.setString(8, strNameOfAirlineFwdFlt);
					    objCstmt.setString(9, strTravelClassFwdFlt);
					    objCstmt.setString(10, strVisaRequired);
					    objCstmt.setString(11, strVisaComment);
					    objCstmt.setString(12, strPreferTimeFwdFlt);
					    objCstmt.setString(13, Suser_id);
					    objCstmt.setString(14, strPreferSeatFwdFlt); 
					    objCstmt.setString(15, strPreferTimeModeFwdFlt);
					    objCstmt.setInt(16, 0);
					    objCstmt.setString(17, strTicketRefundfwd);
					    objCstmt.setInt(18, 0);
					    intSuccess3   =  objCstmt.executeUpdate();
					    objCstmt.close();
					}			
				} 
				
				if(strRetJurnFlagFlt) {
					
					strDepCityRetFlt 		= strDepCityFlt[(strDepCityFlt.length - 1)];
					strArrCityRetFlt 		= strArrCityFlt[strDepCityFlt.length - 1];
					strDepDateRetFlt 		= strDepDateFlt[strDepCityFlt.length - 1];
					strPreferTimeModeRetFlt = strPreferTimeModeFlt[strDepCityFlt.length - 1];
					strPreferTimeRetFlt		= strPreferTimeFlt[strDepCityFlt.length - 1];					
					strTravelClassRetFlt 	= strTravelClassFlt[strDepCityFlt.length - 1];
					strPreferSeatRetFlt		= strPreferSeatFlt[strDepCityFlt.length - 1];
					
					 if(strDepCityRetFlt==null) {
						 strDepCityRetFlt = ""; 
					 }
					 if(strArrCityRetFlt==null) {
						 strArrCityRetFlt = ""; 
					 }
					 if(strDepDateRetFlt==null) {
						 strDepDateRetFlt = ""; 
					 }
					 
					
					if(strTravelType != null && strTravelType.equals("D")) {
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_RET_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						rsFlt2       =   dbConBean.executeQuery(strSql); 
						  if(rsFlt2.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsFlt2.getString("JOURNEY_ORDER"); 
						  }
						rsFlt2.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
						
					    //PROCEDURE to INSERT data in T_RET_JOURNEY_DETAILS_DOM
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityRetFlt);
						objCstmt.setString(4, strArrCityRetFlt);
						objCstmt.setString(5, strDepDateRetFlt);
						objCstmt.setString(6, strJourneyOrder);
						objCstmt.setString(7, strTravelModeFlt);
						objCstmt.setString(8, strNameOfAirlineRetFlt);
						objCstmt.setString(9, strTravelClassRetFlt);
						objCstmt.setString(10, strPreferTimeRetFlt);
						objCstmt.setString(11, Suser_id); 
						objCstmt.setString(12, strPreferSeatRetFlt);
						objCstmt.setString(13, strTicketRefundRtd);
						objCstmt.setString(14, strPreferTimeModeRetFlt);
						objCstmt.setInt(15, 0);
						objCstmt.setInt(16, 0);
						intSuccess4 = objCstmt.executeUpdate();
						objCstmt.close();
					} else if(strTravelType != null && strTravelType.equals("I")) {
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_RET_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id;
						rsFlt2       =   dbConBean.executeQuery(strSql); 
						  if(rsFlt2.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsFlt2.getString("JOURNEY_ORDER"); 
						  }
						rsFlt2.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
							
						//PROCEDURE To INSERT data in T_RET_JOURNEY_DETAILS_INT
					    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					    objCstmt.setString(2, strTravel_Id);
					    objCstmt.setString(3, strDepCityRetFlt);
					    objCstmt.setString(4, strArrCityRetFlt);
					    objCstmt.setString(5, strDepDateRetFlt);
					    objCstmt.setString(6, strJourneyOrder);
					    objCstmt.setString(7, strTravelModeFlt);
					    objCstmt.setString(8, strNameOfAirlineRetFlt);
					    objCstmt.setString(9, strTravelClassRetFlt);
					    objCstmt.setString(10, strPreferTimeRetFlt);
					    objCstmt.setString(11, Suser_id);
					    objCstmt.setString(12, strPreferSeatRetFlt);
					    objCstmt.setString(13, strPreferTimeModeRetFlt);
					    objCstmt.setInt(14, 0);
					    objCstmt.setString(15, strTicketRefundRtd);
					    objCstmt.setInt(16, 0);
					    intSuccess4 = objCstmt.executeUpdate();
					    objCstmt.close();
					}			
				}
				
				if(strIntrmiJurnFlagFlt) {			
				  						
					for(int i = 1; i < strDepCityFlt.length - 1; i++) {	
						strDepCityIntrmiFlt 		= strDepCityFlt[i];
						strArrCityIntrmiFlt 		= strArrCityFlt[i];
						strDepDateIntrmiFlt 		= strDepDateFlt[i];
						strPreferTimeModeIntrmiFlt  = strPreferTimeModeFlt[i];
						strPreferTimeIntrmiFlt 		= strPreferTimeFlt[i];						
						strTravelClassIntrmiFlt 	= strTravelClassFlt[i];
						strPreferSeatIntrmiFlt		= strPreferSeatFlt[i];
						
						if(strTravelType != null && strTravelType.equals("D")) {
							
							strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
							rsFlt3       =   dbConBean.executeQuery(strSql); 
							  if(rsFlt3.next()) {
								  strJourneyOrder = "0";
								  strJourneyOrder = rsFlt3.getString("JOURNEY_ORDER"); 
							  }
							rsFlt3.close();	
						  	
						  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
						  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
						  	
						    //PROCEDURE to INSERT data in T_JOURNEY_DETAILS_DOM
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, strDepCityIntrmiFlt);
							objCstmt.setString(4, strArrCityIntrmiFlt);
							objCstmt.setString(5, strDepDateIntrmiFlt);
							objCstmt.setInt(6, maxJourneyOrderCount);
							objCstmt.setString(7, strTravelModeFlt);
							objCstmt.setString(8, strNameOfAirlineIntrmiFlt);
							objCstmt.setString(9, strTravelClassIntrmiFlt);
							objCstmt.setString(10, strPreferTimeIntrmiFlt);
							objCstmt.setString(11, Suser_id);
							objCstmt.setString(12, strPreferSeatIntrmiFlt);
							objCstmt.setString(13, "n");
							objCstmt.setString(14, strPreferTimeModeIntrmiFlt);
							objCstmt.setInt(15, 0);
							objCstmt.setInt(16, 0);
							intSuccess5 = objCstmt.executeUpdate();
							objCstmt.close();		
						} else if(strTravelType != null && strTravelType.equals("I")) {
							
							strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
							rsFlt3       =   dbConBean.executeQuery(strSql); 
							  if(rsFlt3.next()) {
								  strJourneyOrder = "0";
								  strJourneyOrder = rsFlt3.getString("JOURNEY_ORDER"); 
							  }
							rsFlt3.close();	
						  	
						  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
						  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
							
						    //PROCEDURE to INSERT data in T_JOURNEY_DETAILS_INT
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, strDepCityIntrmiFlt);
							objCstmt.setString(4, strArrCityIntrmiFlt);
							objCstmt.setString(5, strDepDateIntrmiFlt);
							objCstmt.setInt(6, maxJourneyOrderCount);
							objCstmt.setString(7, strTravelModeFlt);
							objCstmt.setString(8, strNameOfAirlineIntrmiFlt);
							objCstmt.setString(9, strTravelClassIntrmiFlt);
							objCstmt.setString(10, strVisaRequired);
							objCstmt.setString(11, strVisaComment);
							objCstmt.setString(12, strPreferTimeIntrmiFlt);     
							objCstmt.setString(13, Suser_id);
							objCstmt.setString(14, strPreferSeatIntrmiFlt); 
							objCstmt.setString(15, strPreferTimeModeIntrmiFlt);
							objCstmt.setInt(16, 0);
							objCstmt.setString(17, "n");
							objCstmt.setInt(18, 0);
							intSuccess5 = objCstmt.executeUpdate();
							objCstmt.close();				
						}
						
						  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id_Intrim);
						  objCstmt.setString(3, strDepCityIntrmiFlt);             //set the current user Site Id
						  objCstmt.setString(4, strArrCityIntrmiFlt);                //set the current user Login UserId
						  objCstmt.setString(5, strDepDateIntrmiFlt);
						  objCstmt.setString(6, strTravelModeFlt);
						  objCstmt.setString(7, strNameOfAirlineIntrmiFlt);
						  objCstmt.setString(8, strTravelClassIntrmiFlt);
						  objCstmt.setString(9, strVisaRequired);
						  objCstmt.setString(10, strVisaComment); 
						  objCstmt.setString(11, strTravelType);
						  objCstmt.setString(12, strPreferTimeIntrmiFlt);   /// added new for prefered time on 25-Oct-07 By Shiv Sharma   
						  objCstmt.setString(13, strPreferSeatIntrmiFlt);
						  objCstmt.setString(14, "n");
						 // objCstmt.setString(15, strPreferTimeModeIntrmiFlt);
						  iSuccess1   =  objCstmt.executeUpdate();
						  objCstmt.close();
						  
						 
					}				
				}//Insert Flight Details End
		}
		
		if(strTrainMode != null && !strTrainMode.equals("") && strTrainMode.equals("1")) {
				
				//Insert Train Details Start
				if(strFwdJurnFlagTrn) {
										
					strDepCityFwdTrn 		= strDepCityTrn[0];
					strArrCityFwdTrn 		= strArrCityTrn[0];
					strDepDateFwdTrn 		= strDepDateTrn[0];
					strPreferTimeModeFwdTrn = strPreferTimeModeTrn[0];
					strPreferTimeFwdTrn		= strPreferTimeTrn[0];					
					strTravelClassFwdTrn 	= strTravelClassTrn[0];
					strPreferSeatFwdTrn		= TravelRequestEnums.TrainSeatPreferredTypes.fromName(strPreferSeatTrnType1[0]+"-"+strPreferSeatTrnType2[0]+"-"+strPreferSeatTrnType3[0]).getId();
					
					if(strTravelType != null && strTravelType.equals("D")) {
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						rsTrn1       =   dbConBean.executeQuery(strSql); 
						  if(rsTrn1.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsTrn1.getString("JOURNEY_ORDER"); 
						  }
						rsTrn1.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
												
						//PROCEDURE for INSERT data in T_JOURNEY_DETAILS_DOM
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityFwdTrn);
						objCstmt.setString(4, strArrCityFwdTrn);
						objCstmt.setString(5, strDepDateFwdTrn); 
						objCstmt.setString(6, strJourneyOrder);
						objCstmt.setString(7, strTravelModeTrn);
						objCstmt.setString(8, strNameOfAirlineFwdTrn);
						objCstmt.setString(9, strTravelClassFwdTrn);
						objCstmt.setString(10, strPreferTimeFwdTrn);
						objCstmt.setString(11, Suser_id);						  
						objCstmt.setString(12, strPreferSeatFwdTrn);
						objCstmt.setString(13, strTicketRefundfwd);	
						objCstmt.setString(14, strPreferTimeModeFwdTrn);
						objCstmt.setInt(15, 0);
						objCstmt.setInt(16, 0);
						intSuccess33 = objCstmt.executeUpdate();
						objCstmt.close();
					} else if(strTravelType != null && strTravelType.equals("I")) {
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						rsTrn1       =   dbConBean.executeQuery(strSql); 
						  if(rsTrn1.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsTrn1.getString("JOURNEY_ORDER"); 
						  }
						rsTrn1.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
												
						//PROCEDURE to INSERT data in T_JOURNEY_DETAILS_INT
					    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
					    objCstmt.setString(3, strDepCityFwdTrn);
					    objCstmt.setString(4, strArrCityFwdTrn);
					    objCstmt.setString(5, strDepDateFwdTrn); 
					    objCstmt.setString(6, strJourneyOrder);
					    objCstmt.setString(7, strTravelModeTrn);
					    objCstmt.setString(8, strNameOfAirlineFwdTrn);
					    objCstmt.setString(9, strTravelClassFwdTrn);
					    objCstmt.setString(10, strVisaRequired);
					    objCstmt.setString(11, strVisaComment);
					    objCstmt.setString(12, strPreferTimeFwdTrn);
					    objCstmt.setString(13, Suser_id);
					    objCstmt.setString(14, strPreferSeatFwdTrn); 
					    objCstmt.setString(15, strPreferTimeModeFwdTrn);
					    objCstmt.setInt(16, 0);
					    objCstmt.setString(17, strTicketRefundfwd);
					    objCstmt.setInt(18, 0);
					    intSuccess33   =  objCstmt.executeUpdate();
					    objCstmt.close();
					}			
				} 
				
				if(strRetJurnFlagTrn) {
										
					strDepCityRetTrn 		= strDepCityTrn[(strDepCityTrn.length - 1)];
					strArrCityRetTrn 		= strArrCityTrn[strDepCityTrn.length - 1];
					strDepDateRetTrn 		= strDepDateTrn[strDepCityTrn.length - 1];
					strPreferTimeModeRetTrn = strPreferTimeModeTrn[strDepCityTrn.length - 1];
					strPreferTimeRetTrn		= strPreferTimeTrn[strDepCityTrn.length - 1];					
					strTravelClassRetTrn 	= strTravelClassTrn[strDepCityTrn.length - 1];
					strPreferSeatRetTrn		= TravelRequestEnums.TrainSeatPreferredTypes.fromName(strPreferSeatTrnType1[strDepCityTrn.length - 1]+"-"+strPreferSeatTrnType2[strDepCityTrn.length - 1]+"-"+strPreferSeatTrnType3[strDepCityTrn.length - 1]).getId();
					
					 if(strDepCityRetTrn==null) {
						strDepCityRetTrn = ""; 
					 }
					 if(strArrCityRetTrn==null) {
						 strArrCityRetTrn = ""; 
					 }
					 if(strDepDateRetTrn==null) {
						 strDepDateRetTrn = ""; 
					 }
					 
					
					if(strTravelType != null && strTravelType.equals("D")) {
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_RET_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						rsTrn2       =   dbConBean.executeQuery(strSql); 
						  if(rsTrn2.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsTrn2.getString("JOURNEY_ORDER"); 
						  }
						rsTrn2.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
						
					    //PROCEDURE to INSERT data in T_RET_JOURNEY_DETAILS_DOM
						objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Id);
						objCstmt.setString(3, strDepCityRetTrn);
						objCstmt.setString(4, strArrCityRetTrn);
						objCstmt.setString(5, strDepDateRetTrn);
						objCstmt.setString(6, strJourneyOrder);
						objCstmt.setString(7, strTravelModeTrn);
						objCstmt.setString(8, strNameOfAirlineRetTrn);
						objCstmt.setString(9, strTravelClassRetTrn);
						objCstmt.setString(10, strPreferTimeRetTrn);
						objCstmt.setString(11, Suser_id); 
						objCstmt.setString(12, strPreferSeatRetTrn);
						objCstmt.setString(13, strTicketRefundRtd);
						objCstmt.setString(14, strPreferTimeModeRetTrn);
						objCstmt.setInt(15, 0);
						objCstmt.setInt(16, 0);
						intSuccess44 = objCstmt.executeUpdate();
						objCstmt.close();
					} else if(strTravelType != null && strTravelType.equals("I")) {
						
						strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_RET_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id;
						rsTrn2       =   dbConBean.executeQuery(strSql); 
						  if(rsTrn2.next()) {
							  strJourneyOrder = "0";
							  strJourneyOrder = rsTrn2.getString("JOURNEY_ORDER"); 
						  }
						rsTrn2.close();	
					  	
					  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
												
						//PROCEDURE To INSERT data in T_RET_JOURNEY_DETAILS_INT
					    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_RET_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
					    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					    objCstmt.setString(2, strTravel_Id);
					    objCstmt.setString(3, strDepCityRetTrn);
					    objCstmt.setString(4, strArrCityRetTrn);
					    objCstmt.setString(5, strDepDateRetTrn);
					    objCstmt.setString(6, strJourneyOrder);
					    objCstmt.setString(7, strTravelModeTrn);
					    objCstmt.setString(8, strNameOfAirlineRetTrn);
					    objCstmt.setString(9, strTravelClassRetTrn);
					    objCstmt.setString(10, strPreferTimeRetTrn);
					    objCstmt.setString(11, Suser_id);
					    objCstmt.setString(12, strPreferSeatRetTrn);
					    objCstmt.setString(13, strPreferTimeModeRetTrn);	
					    objCstmt.setInt(14, 0);
					    objCstmt.setString(15, strTicketRefundRtd);
					    objCstmt.setInt(16, 0);
					    intSuccess44 = objCstmt.executeUpdate();
					    objCstmt.close();
					}			
				}
				
				if(strIntrmiJurnFlagTrn) {
										
					for(int i = 1; i < strDepCityTrn.length - 1; i++) {	
						strDepCityIntrmiTrn 		= strDepCityTrn[i];
						strArrCityIntrmiTrn 		= strArrCityTrn[i];
						strDepDateIntrmiTrn 		= strDepDateTrn[i];
						strPreferTimeModeIntrmiTrn  = strPreferTimeModeTrn[i];
						strPreferTimeIntrmiTrn 		= strPreferTimeTrn[i];						
						strTravelClassIntrmiTrn 	= strTravelClassTrn[i];
						strPreferSeatIntrmiTrn		= TravelRequestEnums.TrainSeatPreferredTypes.fromName(strPreferSeatTrnType1[i]+"-"+strPreferSeatTrnType2[i]+"-"+strPreferSeatTrnType3[i]).getId();
						
						if(strTravelType != null && strTravelType.equals("D")) {
							
							strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
							rsTrn3       =   dbConBean.executeQuery(strSql); 
							  if(rsTrn3.next()) {
								  strJourneyOrder = "0";
								  strJourneyOrder = rsTrn3.getString("JOURNEY_ORDER"); 
							  }
							rsTrn3.close();	
						  	
						  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
						  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
							
						    //PROCEDURE to INSERT data in T_JOURNEY_DETAILS_DOM
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, strDepCityIntrmiTrn);
							objCstmt.setString(4, strArrCityIntrmiTrn);
							objCstmt.setString(5, strDepDateIntrmiTrn);
							objCstmt.setInt(6, maxJourneyOrderCount);
							objCstmt.setString(7, strTravelModeTrn);
							objCstmt.setString(8, strNameOfAirlineIntrmiTrn);
							objCstmt.setString(9, strTravelClassIntrmiTrn);
							objCstmt.setString(10, strPreferTimeIntrmiTrn);
							objCstmt.setString(11, Suser_id);
							objCstmt.setString(12, strPreferSeatIntrmiTrn);
							objCstmt.setString(13, "n");
							objCstmt.setString(14, strPreferTimeModeIntrmiTrn);
							objCstmt.setInt(15, 0);
							objCstmt.setInt(16, 0);
							intSuccess55 = objCstmt.executeUpdate();
							objCstmt.close();		
						} else if(strTravelType != null && strTravelType.equals("I")) {
							
							strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
							rsTrn3       =   dbConBean.executeQuery(strSql); 
							  if(rsTrn3.next()) {
								  strJourneyOrder = "0";
								  strJourneyOrder = rsTrn3.getString("JOURNEY_ORDER"); 
							  }
							rsTrn3.close();	
						  	
						  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
						  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
							
						    //PROCEDURE to INSERT data in T_JOURNEY_DETAILS_INT
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, strDepCityIntrmiTrn);
							objCstmt.setString(4, strArrCityIntrmiTrn);
							objCstmt.setString(5, strDepDateIntrmiTrn);
							objCstmt.setInt(6, maxJourneyOrderCount);
							objCstmt.setString(7, strTravelModeTrn);
							objCstmt.setString(8, strNameOfAirlineIntrmiTrn);
							objCstmt.setString(9, strTravelClassIntrmiTrn);
							objCstmt.setString(10, strVisaRequired);
							objCstmt.setString(11, strVisaComment);
							objCstmt.setString(12, strPreferTimeIntrmiTrn);     
							objCstmt.setString(13, Suser_id);
							objCstmt.setString(14, strPreferSeatIntrmiTrn); 
							objCstmt.setString(15, strPreferTimeModeIntrmiTrn);
							objCstmt.setInt(16, 0);
							objCstmt.setString(17, "n");
							objCstmt.setInt(18, 0);
							intSuccess55 = objCstmt.executeUpdate();
							objCstmt.close();				
						}
						
						  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_INTERIM_JOURNEY_DETAILS(?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_INTERIM_JOURNEY  Table
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id_Intrim);
						  objCstmt.setString(3, strDepCityIntrmiTrn);             //set the current user Site Id
						  objCstmt.setString(4, strArrCityIntrmiTrn);                //set the current user Login UserId
						  objCstmt.setString(5, strDepDateIntrmiTrn);
						  objCstmt.setString(6, strTravelModeTrn);
						  objCstmt.setString(7, strNameOfAirlineIntrmiTrn);
						  objCstmt.setString(8, strTravelClassIntrmiTrn);
						  objCstmt.setString(9, strVisaRequired);
						  objCstmt.setString(10, strVisaComment); 
						  objCstmt.setString(11, strTravelType);
						  objCstmt.setString(12, strPreferTimeIntrmiTrn);   /// added new for prefered time on 25-Oct-07 By Shiv Sharma   
						  objCstmt.setString(13, strPreferSeatIntrmiTrn);
						  objCstmt.setString(14, "n");
						  iSuccess11   =  objCstmt.executeUpdate();
						  objCstmt.close();
						  
						 
					}
				}//Insert Train Details End				
		}
				
				if(strIntrmiJurnFlagFlt || strIntrmiJurnFlagTrn) {
					// update T_INTERIM_JOURNEY
					if(strTravel_Id_Intrim != null && !strTravel_Id_Intrim.equals("")) {
					  stmt = 	objCon.createStatement();
					  strSql = "UPDATE T_INTERIM_JOURNEY SET TRAVEL_ID='"+strTravel_Id+"' WHERE PARENT_ID ="+ strTravel_Id_Intrim;
					  int  iupdate1 = stmt.executeUpdate(strSql);
					}
				}
				
				if(strCreateTravelRequest) {
					//PROCEDURE to INSERT data in T_TRAVEL_STATUS
				    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_TRAVEL_STATUS(?,?,?,?,?)}"); 
				    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				    objCstmt.setString(2, strTravel_Req_Id);
				    objCstmt.setString(3, strTravel_Id);
				    objCstmt.setString(4, strTravelStatusId);      //set the Travel Status Id(1-Temp, 2-Permanent, 3-Return, 4-Rejected, 6-Canceled, 10-Approved by All)
				    objCstmt.setString(5, strTravelType);
				    objCstmt.setString(6, "");
				    intSuccess6   =  objCstmt.executeUpdate();
				    objCstmt.close();			
					objCon.commit(); //commit the query
				    objCon.setAutoCommit(true);
				}
				
			  //Insert Rent a Car Details			  
			  if(strRentCar != null && !strRentCar.equals("") && strRentCar.equals("1")) {				  
				  for (int i =0; i < strTravelCarId.length; i++) {
					    
					    strJourneyOrder = "0";			  	
					  	maxJourneyOrderCount = i;
					  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
					  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
						
						if(!strTravelCarId[i].equals("")) {
							  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_CAR_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  	          objCstmt.setString(2, strTravelCarId[i]);
				  	          objCstmt.setString(3, strTravel_Id);
				  	          objCstmt.setString(4, strTravelType);
				  	          objCstmt.setString(5, strStartCity[i]); 
				  	          objCstmt.setString(6, strStartLocation[i]);
				  			  objCstmt.setString(7, strEndCity[i]);
				  			  objCstmt.setString(8, strEndLocation[i]);
				  			  objCstmt.setString(9, strStartDate[i]);
				  		      objCstmt.setString(10, strStartTime[i]);
				  			  objCstmt.setString(11, strEndDate[i]); 
				  			  objCstmt.setString(12, strEndTime[i]); 	
				  			  objCstmt.setString(13, strNeedGps); 
				  			  objCstmt.setString(14, strCategory);
				  			  objCstmt.setString(15, strStartMobileNo[i]); 
				  			  objCstmt.setString(16, strEndMobileNo[i]); 
				  			  objCstmt.setString(17, strCarClass); 
				  			  objCstmt.setString(18, strStartRouting[i]); 
				  			  objCstmt.setString(19, strEndRouting[i]);
				  			  objCstmt.setString(20, "");
				  			  objCstmt.setString(21, strJourneyOrder);
				  			  objCstmt.setString(22, Suser_id); 
				  			  objCstmt.setString(23, "UPDATE"); 
				  			  objCstmt.setString(24, strIPAddress);
				  			  objCstmt.setInt(25, 0);
				  			  intSuccess7   =  objCstmt.executeUpdate();
				  			  objCstmt.close();	
						} else {
							  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_CAR_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				  	          objCstmt.setString(2, "0");
				  	          objCstmt.setString(3, strTravel_Id);
				  	          objCstmt.setString(4, strTravelType);
				  	          objCstmt.setString(5, strStartCity[i]); 
				  	          objCstmt.setString(6, strStartLocation[i]);
				  			  objCstmt.setString(7, strEndCity[i]);
				  			  objCstmt.setString(8, strEndLocation[i]);
				  			  objCstmt.setString(9, strStartDate[i]);
				  		      objCstmt.setString(10, strStartTime[i]);
				  			  objCstmt.setString(11, strEndDate[i]); 
				  			  objCstmt.setString(12, strEndTime[i]); 	
				  			  objCstmt.setString(13, strNeedGps); 
				  			  objCstmt.setString(14, strCategory);
				  			  objCstmt.setString(15, strStartMobileNo[i]); 
				  			  objCstmt.setString(16, strEndMobileNo[i]); 
				  			  objCstmt.setString(17, strCarClass); 
				  			  objCstmt.setString(18, strStartRouting[i]); 
				  			  objCstmt.setString(19, strEndRouting[i]); 
				  			  objCstmt.setString(20, "");
				  			  objCstmt.setString(21, strJourneyOrder);
				  			  objCstmt.setString(22, Suser_id); 
				  			  objCstmt.setString(23, "INSERT"); 
				  			  objCstmt.setString(24, strIPAddress);
				  			  objCstmt.setInt(25, 0);
				  			  intSuccess7   =  objCstmt.executeUpdate();
				  			  objCstmt.close();	
						}
						 
						if(strTravelType != null && strTravelType.equals("D")) {								  
						  	strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						  	rsCar2       =   dbConBean.executeQuery(strSql); 
								  if(rsCar2.next()) {
									  strJourneyOrder = "0";
									  strJourneyOrder = rsCar2.getString("JOURNEY_ORDER"); 
								  }
						    rsCar2.close();	
							  	
						  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
						  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
						  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);

							//PROCEDURE for INSERT data in T_JOURNEY_DETAILS_DOM
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, strStartCity[i]);
							objCstmt.setString(4, strEndCity[i]);
							objCstmt.setString(5, strStartDate[i]); 
							objCstmt.setString(6, strJourneyOrder);
							objCstmt.setString(7, "5");
							objCstmt.setString(8, "");
							objCstmt.setString(9, "1");
							objCstmt.setString(10, strStartTime[i]);
							objCstmt.setString(11, Suser_id);						  
							objCstmt.setString(12, "10");
							objCstmt.setString(13, strTicketRefundfwd);	
							objCstmt.setString(14, "1");
							objCstmt.setInt(15, 0);
							objCstmt.setInt(16, 0);
							iSuccess7 = objCstmt.executeUpdate();
							objCstmt.close();																	
							
						} else if(strTravelType != null && strTravelType.equals("I")) {									  
						    strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						    rsCar2       =   dbConBean.executeQuery(strSql); 
								  if(rsCar2.next()) {
									  strJourneyOrder = "0";
									  strJourneyOrder = rsCar2.getString("JOURNEY_ORDER"); 
								  }
						    rsCar2.close();	
						  	
						  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
						  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
						  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);
							
							//PROCEDURE to INSERT data in T_JOURNEY_DETAILS_INT
						    objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
						    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
						    objCstmt.setString(3, strStartCity[i]);
						    objCstmt.setString(4, strEndCity[i]);
						    objCstmt.setString(5, strStartDate[i]); 
						    objCstmt.setString(6, strJourneyOrder);
						    objCstmt.setString(7, "5");
						    objCstmt.setString(8, "");
						    objCstmt.setString(9, "1");
						    objCstmt.setString(10, "2");
						    objCstmt.setString(11, "");
						    objCstmt.setString(12, strStartTime[i]);
						    objCstmt.setString(13, Suser_id);
						    objCstmt.setString(14, "10"); 
						    objCstmt.setString(15, "1");
						    objCstmt.setInt(16, 0);
						    objCstmt.setString(17, strTicketRefundfwd);
						    objCstmt.setInt(18, 0);
						    iSuccess7   =  objCstmt.executeUpdate();
						    objCstmt.close();							  	
						}
				  }
			}
			//Insert Rent a Car Details
				    
			  //Insert Accommodation Details
			  if(strAccomo != null && !strAccomo.equals("") && strAccomo.equals("1")) {				  
				  for (int i =0; i < strAccIdArr.length ; i++) {					  	
					  if(!strAccIdArr[i].equals("")) {
						  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_ACCOMMODATION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  	          objCstmt.setString(2, strAccIdArr[i]);
			  	          objCstmt.setString(3, strTravel_Req_Id);
			  	          objCstmt.setString(4, strTravel_Id);
			  	          objCstmt.setString(5, strTravelType); 
			  	          objCstmt.setString(6, strHotelRequiredArr[i]);
			  			  objCstmt.setString(7, strPlaceArr[i]);
			  			  objCstmt.setDouble(8, Double.parseDouble("0"));
			  			  objCstmt.setString(9, "");
			  		      objCstmt.setString(10, strCheckinArr[i]);
			  			  objCstmt.setString(11, strCheckoutArr[i]); 
			  			  objCstmt.setString(12, Suser_id); 
			  			  objCstmt.setString(13, "UPDATE"); 
			  			  objCstmt.setString(14, strIPAddress); 
			  			  objCstmt.setInt(15, 0); 
			  			  intSuccess8   =  objCstmt.executeUpdate();
			  			  objCstmt.close();
					  } else {
						  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_ACCOMMODATION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  	          objCstmt.setString(2, "0");
			  	          objCstmt.setString(3, strTravel_Req_Id);
			  	          objCstmt.setString(4, strTravel_Id);
			  	          objCstmt.setString(5, strTravelType); 
			  	          objCstmt.setString(6, strHotelRequiredArr[i]);
			  			  objCstmt.setString(7, strPlaceArr[i]);
			  			  objCstmt.setDouble(8, Double.parseDouble("0"));			  			
			  			  objCstmt.setString(9, "");
			  		      objCstmt.setString(10, strCheckinArr[i]);
			  			  objCstmt.setString(11, strCheckoutArr[i]); 
			  			  objCstmt.setString(12, Suser_id); 
			  			  objCstmt.setString(13, "INSERT"); 
			  			  objCstmt.setString(14, strIPAddress);
			  			  objCstmt.setInt(15, 0);
			  			  intSuccess8   =  objCstmt.executeUpdate();
			  			  objCstmt.close(); 
					  }
					  
					  if(strTravelType != null && strTravelType.equals("D")) {								  
						    strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
						    rsAccom2       =   dbConBean.executeQuery(strSql); 
								  if(rsAccom2.next()) {
									  strJourneyOrder = "0";
									  strJourneyOrder = rsAccom2.getString("JOURNEY_ORDER"); 
								  }
						    rsAccom2.close();	
						  	
						  	maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
						  	maxJourneyOrderCount = maxJourneyOrderCount + 1;
						  	strJourneyOrder = Integer.toString(maxJourneyOrderCount);

							//PROCEDURE for INSERT data in T_JOURNEY_DETAILS_DOM
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, "-");
							objCstmt.setString(4, strPlaceArr[i]);
							objCstmt.setString(5, strCheckinArr[i]); 
							objCstmt.setString(6, strJourneyOrder);
							objCstmt.setString(7, "7");
							objCstmt.setString(8, "");
							objCstmt.setString(9, "1");
							objCstmt.setString(10, "");
							objCstmt.setString(11, Suser_id);						  
							objCstmt.setString(12, "10");
							objCstmt.setString(13, strTicketRefundfwd);	
							objCstmt.setString(14, "1");
							objCstmt.setInt(15, 0);
							objCstmt.setInt(16, 0);
							iSuccess7 = objCstmt.executeUpdate();
							objCstmt.close();							  										
							
						} else if(strTravelType != null && strTravelType.equals("I")) {								  
							 strSql = "SELECT ISNULL(MAX(JOURNEY_ORDER),0) AS JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravel_Id+" AND STATUS_ID=10";
							 rsAccom2       =   dbConBean.executeQuery(strSql); 
								  if(rsAccom2.next()) {
									  strJourneyOrder = "0";
									  strJourneyOrder = rsAccom2.getString("JOURNEY_ORDER"); 
								  }
							 rsAccom2.close();	
								
							 maxJourneyOrderCount = Integer.parseInt(strJourneyOrder);
							 maxJourneyOrderCount = maxJourneyOrderCount + 1;
							 strJourneyOrder = Integer.toString(maxJourneyOrderCount);
							
							//PROCEDURE to INSERT data in T_JOURNEY_DETAILS_INT
							objCstmt = objCon.prepareCall("{?=call PROC_INSERT_T_JOURNEY_DETAILS_INT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}"); 
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2, strTravel_Id);
							objCstmt.setString(3, "-");
							objCstmt.setString(4, strPlaceArr[i]);
							objCstmt.setString(5, strCheckinArr[i]); 
							objCstmt.setString(6, strJourneyOrder);
							objCstmt.setString(7, "7");
							objCstmt.setString(8, "");
							objCstmt.setString(9, "1");
							objCstmt.setString(10, "2");
							objCstmt.setString(11, "");
							objCstmt.setString(12, "");
							objCstmt.setString(13, Suser_id);
							objCstmt.setString(14, "10"); 
							objCstmt.setString(15, "1");
							objCstmt.setInt(16, 0);
							objCstmt.setString(17, strTicketRefundfwd);
							objCstmt.setInt(18, 0);
							iSuccess7   =  objCstmt.executeUpdate();
							objCstmt.close();							  	
						}
				  }			 
			  } 				 
			//Insert Accommodation Details						    	
			  	
				   
				   if(strTravelType != null && strTravelType.equals("D")) {
						  stmt = 	objCon.createStatement();
						  if(strIdentityProofOld==null || strIdentityProofOld.equals("-1") || strIdentityProofOld.equals("0")) {
						        strSql = "UPDATE M_USERINFO SET  IDENTITY_ID='"+strIdentityProof+"',IDENTITY_NO='"+strIdentityProofNo+"', CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2+"',FF_NUMBER3=N'"+strAirLineNo3+"',FF_NUMBER4=N'"+strAirLineNo4 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId;
						  } else {
						  strSql = "UPDATE M_USERINFO SET  CONTACT_NUMBER='"+strContactNo+"',FF_NUMBER=N'"+strAirLineNo+"',FF_NUMBER1=N'"+strAirLineNo1+"',FF_NUMBER2=N'"+strAirLineNo2+"',FF_NUMBER3=N'"+strAirLineNo3+"',FF_NUMBER4=N'"+strAirLineNo4 +"',FF_AIR_NAME=N'"+strAirLineName+"',FF_AIR_NAME1=N'"+strAirLineName1+"',FF_AIR_NAME2=N'"+strAirLineName2+"',FF_AIR_NAME3=N'"+strAirLineName3+"',FF_AIR_NAME4=N'"+strAirLineName4+"',HOTEL_NUMBER=N'"+strHotelNo+"',HOTEL_NUMBER1=N'"+strHotelNo1+"',HOTEL_NUMBER2=N'"+strHotelNo2+"',HOTEL_NUMBER3=N'"+strHotelNo3+"',HOTEL_NUMBER4=N'"+strHotelNo4 +"',HOTEL_NAME=N'"+strHotelName+"',HOTEL_NAME1=N'"+strHotelName1+"',HOTEL_NAME2=N'"+strHotelName2+"',HOTEL_NAME3=N'"+strHotelName3+"',HOTEL_NAME4=N'"+strHotelName4+"' WHERE USERID ="+strTravellerId ;
						  }			
						  int iupdate = stmt.executeUpdate(strSql); 						  
		
						  //Procedure for update the billing info and travel cheque info in T_Travel_Detail_Dom Table
						  objCstmt  =  objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO_DOM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						  objCstmt.setString(2, strTravel_Id);
						  objCstmt.setString(3, strBillingClient);             
						  objCstmt.setString(4, strBillingApprover);
						  objCstmt.setString(5, strTotalAmount);
						  objCstmt.setString(6, strBaseCurrency);
						  objCstmt.setString(7, strExpenditureRemarks);
						  objCstmt.setString(8, ""); 
						  objCstmt.setString(9, Suser_id);
						  objCstmt.setString(10, dbl_YTM_BUDGET);
						  objCstmt.setString(11, dbl_YTD_ACTUAL);
						  objCstmt.setString(12, dbl_AVAIL_BUDGET);
						  objCstmt.setString(13, dbl_EST_EXP);
						  objCstmt.setString(14, str_EXP_REMARKS);
						  objCstmt.setString(15, strTotalFareCurrency);
						  objCstmt.setInt(16,Integer.parseInt(strTotalFareAmount));
						  iSuccess2   =  objCstmt.executeUpdate();
						  objCstmt.close();						  
						    					    
					 } else if(strTravelType != null && strTravelType.equals("I")) {
							objCstmt =  objCon.prepareCall("{?=call PROC_TRANSFER_PASSPORTUSERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setString(2,strTravellerId.trim());
							objCstmt.setString(3, strPassportNo.trim());
							objCstmt.setString(4, strPassportIssuePlace.trim());
							objCstmt.setString(5, strPassportIssueDate.trim());
							objCstmt.setString(6, strPassportExpireDate.trim());
							objCstmt.setString(7, radioEcnr);
							objCstmt.setString(8, strDOB.trim());
							objCstmt.setString(9, strContactNo.trim());
							objCstmt.setString(10, strPermanentAddress.trim());
							objCstmt.setString(11, strAirLineNo.trim());
							objCstmt.setString(12, strAirLineNo1.trim());
							objCstmt.setString(13, strAirLineNo2.trim());
							objCstmt.setString(14, strCurrentAddress.trim());
							objCstmt.setString(15, strAirLineName.trim());
							objCstmt.setString(16, strAirLineName1.trim());
							objCstmt.setString(17, strAirLineName2.trim());
							objCstmt.setString(18, strAirLineNo3.trim());
							objCstmt.setString(19, strAirLineNo4.trim());
							objCstmt.setString(20, strAirLineName3.trim());
							objCstmt.setString(21, strAirLineName4.trim());
							objCstmt.setString(22, strHotelNo.trim());
							objCstmt.setString(23, strHotelNo1.trim());
							objCstmt.setString(24, strHotelNo2.trim());
							objCstmt.setString(25, strHotelNo3.trim());
							objCstmt.setString(26, strHotelNo4.trim());
							objCstmt.setString(27, strHotelName.trim());
							objCstmt.setString(28, strHotelName1.trim());
							objCstmt.setString(29, strHotelName2.trim());
							objCstmt.setString(30, strHotelName3.trim());
							objCstmt.setString(31, strHotelName4.trim());
							objCstmt.setString(32, fullName.trim());
							objCstmt.setString(33, firstName.trim());
							objCstmt.setString(34, lastName.trim());
							objCstmt.setString(35, strNationality.trim());
							objCstmt.setString(36, strPP_Issu_Country);
							objCstmt.execute();
							objCstmt.close();							
							
							//Procedure for update the billing info and travel cheque info in T_Travel_Detail_Int Table
							objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_BILLING_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST  Table
					        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					        objCstmt.setString(2, strTravel_Id);
					        objCstmt.setString(3, strBillingClient);             
					        objCstmt.setString(4, strBillingApprover);
					        objCstmt.setString(5, strTotalAmount);
							objCstmt.setString(6, strBaseCurrency);							
							objCstmt.setString(7, strTravellerCheque);
							objCstmt.setString(8, strTravellerCheque1);
							objCstmt.setString(9, strTravellerCheque2);					
							objCstmt.setString(10, strTCCurrency);
							objCstmt.setString(11, strTCCurrency1);
							objCstmt.setString(12, strTCCurrency2);					
							objCstmt.setString(13, strExpenditureRemarks);
							objCstmt.setString(14, strCashBreakupRemarks);					
							objCstmt.setString(15, "");					
							objCstmt.setString(16, Suser_id);		
							objCstmt.setString(17, dbl_YTM_BUDGET);
							objCstmt.setString(18, dbl_YTD_ACTUAL);
							objCstmt.setString(19, dbl_AVAIL_BUDGET);
							objCstmt.setString(20, dbl_EST_EXP);
							objCstmt.setString(21, str_EXP_REMARKS);
							objCstmt.setString(22, strTotalFareCurrency);
							objCstmt.setInt(23, Integer.parseInt(strTotalFareAmount));							
					        iSuccess2   =  objCstmt.executeUpdate();
					        objCstmt.close();
					
					}
			
				   //Insert Workflow Approver(s) 
				   	starDaoImpl dao = new starDaoImpl();
				    List workflowApproverList = null;
				    workflowApproverList = dao.getApproverList(strSiteId, strTravellerId, strTravelType, strWorkFlowCode);
				    if( workflowApproverList != null && !workflowApproverList.isEmpty()){
				    	saveApproverSuccess = dao.associateApproverWithRequest(workflowApproverList, strSiteId, strTravellerId, strTravel_Id, strTravelType,
				    			Suser_id, true);
				    }
					
				    if(saveApproverSuccess) {
				    	approversExists = true;
				    }
				 
				   strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
				   submitToWorkFlow = true;
			 
		} catch(SQLException se){
			submitToWorkFlow = false;
		    se.printStackTrace();
		    System.out.println("Error in Insertion block of T_QuickTravel_Detail_GmbH_Post.jsp=="+se);
			strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);
			  try{
				 if(objCon!=null)
					objCon.rollback();
					strTravel_Id = null;
		    }catch(SQLException se2){
		       se2.printStackTrace();
		       System.out.println("Error in Insertion block of T_QuickTravel_Detail_GmbH_Post.jsp=="+se2);
			   strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);
		    }
		 } catch(Exception e) {	
			  submitToWorkFlow = false;
			  System.out.println("Error in Insertion block of T_QuickTravel_Detail_GmbH_Post.jsp=="+e);
			  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);			  
		}
	 
	 if(submitToWorkFlow && strWhatAction != null && strWhatAction.equals("saveProceed")) {
		 logger.info("T_QuickTravel_Detail_GmbH_Post.jsp Submit To WorkFlow Start for Request number--> " +strTravel_Id+ " at " +dateFormat.format(cal.getTime()));	
		 if(approversExists) {
			 if(strTravelType != null && strTravelType.equals("D")) {			 
				 try {
					 if(flag!="no") {
						    int intTravelId =Integer.parseInt(strTravel_Id);
				            int intBillingApprover =Integer.parseInt(strBillingApprover);
				            int intTravellerId =Integer.parseInt(strTravellerId);
							int intC_userID =Integer.parseInt(Suser_id);						  
								
							objCon =  dbConBean.getConnection(); 
							objCstmt=objCon.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
							objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							objCstmt.setInt(2,intTravelId);
							objCstmt.setString(3,strTravelType);
							objCstmt.setInt(4,intBillingApprover);
							objCstmt.setInt(5,intTravellerId);
							objCstmt.setInt(6,intC_userID); 
						    objCstmt.executeUpdate();
					        objCstmt.close();
		           }	
		
			  		strPermanent_Req_No = strSiteName.trim()+"/DOM/"+strTravel_Id;	
			  		session.setAttribute("strSetFlage","1"); 
			  			   
				    objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS_DOM(?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
				    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				    objCstmt.setString(2, strTravel_Id);
				    objCstmt.setString(3, strTravel_Req_Id);
				    objCstmt.setString(4, "2");                        //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
				    objCstmt.setString(5, strTravelType);
				    objCstmt.setString(6, strPermanent_Req_No);
				    objCstmt.setString(7, "");
				   
		           try {
				   	  iSuccess4   =  objCstmt.executeUpdate();
				    } catch(Exception e) {
					   System.out.println("PROC_UPDATE_T_TRAVEL_STATUS_DOM---"+e);
				    }
				    objCstmt.close();
				
				    if(strTravel_Id_Intrim != null && !"".equals(strTravel_Id_Intrim.trim()) && !strTravel_Id_Intrim.trim().equals("null")) {
				       //Procedure for delete the all temp detail from T_INTRIM_JOURNEY temp Table
					   objCstmt = objCon.prepareCall("{?=call PROC_DELETE_INTERIM_JOURNEY(?,?)}");
					   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					   objCstmt.setString(2, strTravel_Id_Intrim);
					   objCstmt.setString(3, strTravelType);
					   iSuccess5 = objCstmt.executeUpdate();
					   objCstmt.close();
				    }		  	
			  		 
				      // Procedure for inserting the version for T_TRAVEL_DETAIL_DOM, T_JOURNEY_DETAIL_DOM, T_RET_JOURNEY_DETAIL_DOM in the audit table  
					  objCstmt = objCon.prepareCall("{?=call PROC_INSERT_IN_ALL_AUDIT_DOM(?,?)}");
					  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					  objCstmt.setString(2, strTravel_Req_Id);
					  objCstmt.setString(3, strTravel_Id);
					
					  try {
					 	  iSuccess6   =  objCstmt.executeUpdate();
					  } catch(Exception e) {
						 System.out.println("PROC_INSERT_IN_ALL_AUDIT_DOM---"+e);
					  }						  		
					  objCstmt.close();
					  
					  strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
					  
				 } catch(Exception e) {				  
					  System.out.println("Error in Save Proceed (DOM) block of T_QuickTravel_Detail_GmbH_Post.jsp=="+e);
					  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);			  
				}	
			 } else if(strTravelType != null && strTravelType.equals("I")) {			 
				 try {
					 	objCstmt = objCon.prepareCall("{?=call PROC_TRANSFER_USERINFO_TO_AUDIT_USERINFO(?)}");
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2,strTravellerId.trim());
						objCstmt.execute();
						objCstmt.close();
						
					 if(flag!="no") {
						 int intTravelId =Integer.parseInt(strTravel_Id);
			             int intBillingApprover =Integer.parseInt(strBillingApprover);
			             int intTravellerId =Integer.parseInt(strTravellerId);
						 int intC_userid= Integer.parseInt(Suser_id);				 
							
						objCon = dbConBean.getConnection(); 
						objCstmt=objCon.prepareCall("{?=call PROC_APPROVER_OF_OTHERSITE(?,?,?,?,?)}");
						objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setInt(2,intTravelId);
						objCstmt.setString(3,strTravelType);
						objCstmt.setInt(4,intBillingApprover);
						objCstmt.setInt(5,intTravellerId);
						objCstmt.setInt(6,intC_userid);
					    objCstmt.executeUpdate();
				        objCstmt.close();
		             }
		
					   strPermanent_Req_No = strSiteName.trim()+"/INT/"+strTravel_Id;				   
					   session.setAttribute("strSetFlage","1");					            
					    
			           objCstmt =  objCon.prepareCall("{?=call PROC_UPDATE_T_TRAVEL_STATUS(?,?,?,?,?,?)}");//PROCEDURE to insert the row in T_TRAVEL_MST Table
			           objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			           objCstmt.setString(2, strTravel_Id);
			           objCstmt.setString(3, strTravel_Req_Id);
			           objCstmt.setString(4, "2");                        //SET THE  TRAVEL_STATUS_ID 2 AS A PERMANENT REQUEST FOR THE WORKFLOW
					   objCstmt.setString(5, strTravelType);
					   objCstmt.setString(6, strPermanent_Req_No);
					   objCstmt.setString(7, "");
					   
					   try {
					   	  iSuccess4   =  objCstmt.executeUpdate();
					    } catch(Exception e) {
						   System.out.println("PROC_UPDATE_T_TRAVEL_STATUS---"+e);
					    }					           
			           objCstmt.close();
			
					   if(strTravel_Id_Intrim!= null && !"".equals(strTravel_Id_Intrim)  && !strTravel_Id_Intrim.trim().equals("null")) {
						   //Procedure for delete the all temp detail from T_INTRIM_JOURNEY temp Table
						   objCstmt =  objCon.prepareCall("{?=call PROC_DELETE_INTERIM_JOURNEY(?,?)}");
						   objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						   objCstmt.setString(2, strTravel_Id_Intrim);
						   objCstmt.setString(3, strTravelType);
						   iSuccess5 = objCstmt.executeUpdate();
						   objCstmt.close();
					   }
			
						// Procedure for inserting the version for T_TRAVEL_DETAIL_INT, T_JOURNEY_DETAIL_INT, T_RET_JOURNEY_DETAIL_INT in the audit table  
			            objCstmt =  objCon.prepareCall("{?=call PROC_INSERT_IN_ALL_AUDIT_INT(?,?)}");
			 		    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						objCstmt.setString(2, strTravel_Req_Id);
						objCstmt.setString(3, strTravel_Id);
						try {
						 	 iSuccess6   =  objCstmt.executeUpdate();
					     } catch(Exception e) {
						 System.out.println("PROC_INSERT_IN_ALL_AUDIT_INT---"+e);
					     }		
						objCstmt.close();
						
						strMessage = dbLabelBean.getLabel("message.global.save",strsesLanguage);
						
				 } catch(Exception e) {				  
					  System.out.println("Error in Save Proceed (INT) block of T_QuickTravel_Detail_GmbH_Post.jsp=="+e);
					  strMessage = dbLabelBean.getLabel("message.global.notsave",strsesLanguage);			  
				}	
			 }
		 } else {
			 strMessage = "approvernotexists";
		 }
		 logger.info("T_QuickTravel_Detail_GmbH_Post.jsp Submit To WorkFlow End for Request number--> " +strTravel_Id+ " at " +dateFormat.format(cal.getTime()));	
	 }
	 dbConBean3.close();
	 dbConBean2.close();
	 dbConBean1.close();
	 dbConBean.close(); 	
	
	if(strMessage!=null && strMessage.equals(dbLabelBean.getLabel("message.global.save",strsesLanguage))) {	
		if(strWhatAction != null && strWhatAction.equals("save")) {
		  url = "T_QuickTravel_Detail_GmbH.jsp?message="+strMessage+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravel_Req_No+"&interimId="+strTravel_Id_Intrim+"&travel_type="+strTravelType;
		} 
		else if(strWhatAction != null && strWhatAction.equals("saveExit")) {
			if(strTravelType != null && strTravelType.equals("D")) {
				url = "T_TravelRequisitionList_D.jsp?travel_type=DOM";
			} else if(strTravelType != null && strTravelType.equals("I")) {
				url = "T_TravelRequisitionList.jsp?travel_type=INT";
			}
		}
		else if(strWhatAction != null && strWhatAction.equals("saveProceed")) {
			if(iSuccess4 > 0) {	
				String	strReq	=	"";
				if(strTravelType.equalsIgnoreCase("I")) {
					strReq	=	"International Travel";
				} else {
					strReq	=	"Domestic Travel";
				}
				mailDaoImpl.sendRequisitionMailOnOriginating(strTravel_Id, strReq, Suser_id, strsesLanguage, strCurrentYear);
				
				url = "FinallySubmitted.jsp?travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strPermanent_Req_No+"&ReqTyp="+strTravelType+"&interimId="+strTravel_Id_Intrim+"&flag="+strSetFlage; 
			}
		}
	} else if(strMessage!=null && strMessage.equals("approvernotexists")) {
		url = "T_QuickTravel_Detail_GmbH.jsp?message="+strMessage+"&travelId="+strTravel_Id+"&travelReqId="+strTravel_Req_Id+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravllerSiteId+"&travelReqNo="+strTravel_Req_No+"&interimId="+strTravel_Id_Intrim+"&travel_type="+strTravelType;
	} else {	
		url = "T_QuickTravel_Detail_GmbH.jsp?message="+strMessage;
	}	
	logger.info("T_QuickTravel_Detail_GmbH_Post.jsp sendRedirect to -->" +url+ " at " +dateFormat.format(cal.getTime()));
	response.sendRedirect(url);
  }
%>