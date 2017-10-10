<%/******************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Abhinav Ratnawat
 *Date of Creation 		:11 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment	:Tomcat, sql server 2000 
 *Description 			: 
 *Modification 			:1. Add Currency field for choosing different currency.
						 2. Add function for disable and enable Reason For skipping area
						 3. Added  Identity  Proof No  on
 *Reason of Modification:1. change suggested by MATA
						 2. change suggested by MATA  
						 3.
						 4. Introduced for the Gender, this code is compatible to the previous options where User has not 
					        entered the gender i.e GENDER =null
						 5. Code modified   for showing default approver list for selected site by Shiv Sharma 
						 6. Code modified for giving proper information if site not uploaded.
						 7. @sanjeet on 19-July-07 to give a appropriate message incase site not uploaded.
						 8. Added a new field identity field on 22-Oct-07						by Shiv Sharma    
						 9. Changed  window size of Interimjourney   on 26-Oct-07  By Shiv Sharma 
						 10. Code added for showing alert if user dose not required accommodation in his journey on 4th jan 2008 by Shiv Sharma 
						 11. Code added for allowing the character & numeric in preferred Airline                            on 4th Jan 2008 by Shiv Sharma
						 12 .Code change for showing age(Yr,month,days  ) to user but not storing                         on 03-Mar-08 by    Shiv  Sharma     
						 13 .Credit card entry in not mendatory . changes done by shiv sharma on 2/2/2009   	 
						 14 added code by sachin on 2/17/2009 
						 15.added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers
						 16 Query changed for showing all user of UNit if usr is LA only for SMR on 04-03-2010
						 17.Commented Credit card no as it is not required for  to show any user on 10-03-2010 by shiv sharma  

 *Date of Modification  :1.	3 Nov 2006 
						 2. 12 Mar 2007
                         3  3/14/2007  
                         4. 03-May-2007
						 5. 14-May-07

 *Modified By	  :1. SACHIN GUPTA
						 2. SAMIR RANJAN PADHI
						  3. Shiv  Sharma
						  4. Gaurav Aggarwal
						  5.shiv sharma 
Modified by vaibhav on jul 2 2010 to change date input format for credit card expiry date
*Editor				:Editplus

*Modification			:To add a check on approver level 2 for unit head.
*Modified By			:manoj			
*Date of Modification   :18 jan 2011
*Editor					:Eclipse 3.5

*Modification			:To sort the second level approvers.
*Modified By			:manoj			
*Date of Modification   :25 jan 2011

*Modification			:Add alert if approvers already is in default workflow.
*Modified By			:manoj chand		
*Date of Modification   :25 march 2011

*Modification			:Disable both designation and age textbox.
*Modified By			:manoj chand			
*Date of Modification   :18 april 2011

*Modification			:manage designation field from becoming null when travel mode change
*Modified By			:manoj chand			
*Date of Modification   :20 May 2011

*Modified By					:Manoj Chand
*Date of Modification			:28 July 2011
*Modification					:change query to add passport as identity proof

*Modification			:modify workflow as per selected site
*Date of modification   :12 Oct 2011
*Modified By     		:Manoj Chand

*Modification			:resolve scripting error coming at the time of getting site value
*Date of modification   :10 Jan 2012
*Modified By     		:Manoj Chand

*Modification			:add board member drop down for SMP users
*Date of modification   :29 Mar 2012
*Modified By     		:Manoj Chand

*Modified By	  		:Manoj Chand
*Date of Modification   : 04 Apr 2012
*Modification 	        :add a check for unit head approval level 1 and 2 selection is not mandatory in SMP site

*Modification				:change in function defaultApproverList  
*Modified by				:Manoj Chand
*Date of Modification		:17 Apr 2012

*Modification				:Show a message when transit house is selected  
*Modified by				:Manoj Chand
*Date of Modification		:24 Apr 2012

*Modification				:Multilingual functionality added
*Modified by				:Manoj Chand
*Date of Modification		:24 May 2012

*Modification				:Add 'AMEX' Card Type in Credit Card Information
*Modified by				:Manoj Chand
*Date of Modification		:26 July 2012

*Modified By	       		:MANOJ CHAND
*Date of Modification  		:01 Aug 2012
*Description				:Provide Cost Centre Combobox for SMP Division

*Modified By	        	:MANOJ CHAND
*Date of Modification  		:06 Sept 2012
*Description				:for smr site only originator name coming in select user combox from originator login.
						 	 for LA all user of the selected site will come.
						 	 
*Modified By	        	:MANOJ CHAND
*Date of Modification  		:19 OCT 2012
*Description				:IMPLEMENT SITE WISE FLAG TO SHOW BOARD MEMBER IN SMP

*Modified By	        	:MANOJ CHAND
*Date of Modification  		:24 JAN 2013
*Description				:ADD BUS/CAR/VAN IN MODE AND FETCH MODE VALUES FROM TABLE M_TRAVEL_MODE.

*Modified By				:Manoj Chand
*Date of Modification		:03 June 2013
*Modification				:Provision to display other site user in approval level 1 or 2.

*Modified By				:Manoj Chand
*Date of Modification		:23 July 2013
*Modification				:Mandatory selection of approval level 1 and 2 for mssl site.

*Modified By				:Manoj Chand
*Date of Modification		:22 Oct 2013
*Modification				:javascript validation to stop from typing --,',>,<,&  symbol is added.
 *********************************************************************************************/
%>
<html>
<%@ page buffer="5kb" language="java" import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*,java.text.*" pageEncoding="UTF-8" %>

<%@ include file="cacheInc.inc"%>
<%@ include file="headerIncl.inc"%>
<%@ include file="application.jsp"%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<%@ include file="M_InsertProfile.jsp"  %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Domestic Travel Section</title>
<style type="text/css">
<!--
.style2 {font-size: 10px; font-weight: bold; color: #FF7D00; }

-->
</style>

 
<script type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->


//function added by manoj chand on 21 feb 2012 to replace multiple spaces with single space
function removeSpaces(str) {
	str = str.replace(/\s{2,}/g,' ');
 	return str;
}

</script>
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
<SCRIPT language="JavaScript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>
<script>
function MM_openBrWin(theURL,winName,features)
 { 
		   window.open(theURL,winName,features);
 }
 </script>
</head>
<%
request.setCharacterEncoding("UTF-8");
			ResultSet rs 								= null;
			String strSql 								= null;
			String strUserId 							= "";
			String strSiteId 							= "";
			String strDesigName 				    	= "";
			String strAge 								= "";
			String strAge1 								= "";

			String actualAge                            ="";
			String strPhone 							= "";
			String strFFNo 								= "";
			String strFFNo1 							= "";
			String strFFNo2 							= "";

//new 17-02-2007

			String strAirLineName		=	"";
			String strAirLineName1		=	"";
			String strAirLineName2		=	"";

			String strPlace					=	"";
			String strForTatkaalRequired	=	"";
			String strForCoupanRequired		=	"";
			String strRetTatkaalRequired	=	"";
			String strRetCoupanRequired		=	"";
			String strIdentityProof			=	"";
			String strIdentityProofNo      ="";


//



			String strFlag								= "";
			String strDepartMode				    	= "";
			String strArrivalMode 			     		= "";
			String strMealId  	 						= "";
			String strSex								= "";	
			String strDepartCity						= ""; 

			String strDepartCity1						= ""; 


			String strDepartDate  				    	= "";
			String strDepartTime				    	= "";
			String strDepartAirLineName             	= "";
			String strDepartClass				    	= "";
			String strArrivalCity						= "";

			String strArrivalCity1						= "";

			String strReturnDate			     		= "";
			String strArrivalTime				    	= "";
			String strArrivalAirLineName	        	= "";
			String strArrivalClass					    = "";
			String strManager				    		= "";
			String strPHOD						    	= "";
			String strBoardMember           			= "";
			String strSelectManger			        	= "manual";
			String strTransitType			    		= "";
			String strBudget							= "";
			String strBudgetCurrency                    = "";
			String strCheckin							= ""; 
			String strCheckout    						= "";
			String strOthers							= "";
			String strReasonForTravel					= "";
			String strReasonForSkip         			=  "";
			String strIntermiId	    					= "";
			String strTravelReqId	    				= "";
			String strTravelId							= "";
			String strTravelReqNo		        		= "";
			String strActionFlag	    				= "";
			//code added 
			String strCARD_TYPE  						="";
			String strGender							="";
            //added by shiv on 29-May-07  
			String strButtonState						=""; 
			///23-02-2007
			String strCARD_HOLDER_NAME 					="";
			String strSeatprefferRet   					="";
			String strSeatpreffer	   					="";	
			String strTicketRefundfwd 					="";
			String strTicketRefundrtd 					="";

            strCARD_HOLDER_NAME      =  request.getParameter("cardHolderName")==null ?"" :request.getParameter("cardHolderName") ; 

			///23-02-2007
			String strCARD_NUMBER1 			="";
			String strCARD_NUMBER2 			="";
			String strCARD_NUMBER3 			="";
			String strCARD_NUMBER4 			="";
			String strCVV_NUMBER 			="";
			String strCARD_EXP_DATE 		="";
			String strMessage   			="";
			String strMonth="";
			String strYear="";
			
			//code added By Rajeev on 17 Feb 2007
			String disableRadioForward		="";
			String disableRadioReturn		="";
			String strCostCentre="";
			String strShowflag="n";
			
			//code added by Gurmeet Singh on 17 january 2014
			String strManagerSelected = "";
			String strPHODSelected = "";
			String strBoardMemberSelected = "";
			 
			strCARD_TYPE               		=  request.getParameter("CARD_TYPE");
			strCARD_NUMBER1            		=  request.getParameter("CARD_NUMBER1");
			strCARD_NUMBER2            		=  request.getParameter("CARD_NUMBER2");
			strCARD_NUMBER3            		=  request.getParameter("CARD_NUMBER3");
			strCARD_NUMBER4            		=  request.getParameter("CARD_NUMBER4");
			strCVV_NUMBER              		=  request.getParameter("CVV_NUMBER");
			strCARD_EXP_DATE           		=  request.getParameter("CARD_EXP_DATE");
			//code ends
			strMessage                		=  request.getParameter("message");

			strFlag   				 		= request.getParameter("flag") == null ? "" :request.getParameter("flag");
			strSiteId 				 		= request.getParameter("site");
			strUserId 				 		= request.getParameter("userName");
			strDesigName			 		= request.getParameter("designation")==null?"":request.getParameter("designation");		
			strPhone				 		= request.getParameter("phoneNo") == null ? "" : request.getParameter("phoneNo").trim();
			strFFNo					 		= request.getParameter("FFNo") == null ? "" : request.getParameter("FFNo") .trim();	
			strFFNo1				 		= request.getParameter("FFNo1") == null ? "" : request.getParameter("FFNo1") .trim();	
			strFFNo2				 		= request.getParameter("FFNo2") == null ? "" : request.getParameter("FFNo2") .trim();	
             //new 17-02-2007 SACHIN
			strAirLineName					=	request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
			strAirLineName1					=	request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
			strAirLineName2					=	request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");
			
			strPlace						=	request.getParameter("place")== null ? "" : request.getParameter("place");
			strForTatkaalRequired			=	request.getParameter("forTatkaalRequired")== null ? "0" : request.getParameter("forTatkaalRequired");
			strForCoupanRequired			=	request.getParameter("forCoupanRequired")== null ? "0" : request.getParameter("forCoupanRequired");
			strRetTatkaalRequired			=	request.getParameter("retTatkaalRequired")== null ? "0" : request.getParameter("retTatkaalRequired");
			strRetCoupanRequired			=	request.getParameter("retCoupanRequired")== null ? "0" : request.getParameter("retCoupanRequired");
			strIdentityProof				=	request.getParameter("identityProof")== null ?"-1" : request.getParameter("identityProof");
			///  added by shiv on 3/14/2007 Identity  Proof No 
			strIdentityProofNo			=	request.getParameter("identityProofno")== null ? "" : request.getParameter("identityProofno");
			
			strDepartMode 			 = request.getParameter("departMode") == null? "1":request.getParameter("departMode");
			strDepartClass           = request.getParameter("departClass") == null? "1":request.getParameter("departClass");
			strArrivalMode 			 = request.getParameter("arrivalMode")== null ? "1" :request.getParameter("arrivalMode");
			strArrivalClass          = request.getParameter("arrivalClass") == null? "1":request.getParameter("arrivalClass");
			strMealId	   			 = request.getParameter("meal") == null ? "1" :  request.getParameter("meal") ;
			strSex					 = request.getParameter("sex") == null ? "1" : request.getParameter("sex");
			strDepartCity			 = request.getParameter("departCity") ==null ? "":	request.getParameter("departCity").trim();	
			strDepartCity1			 = request.getParameter("departCity1") ==null ? "":	request.getParameter("departCity1").trim();	
			strDepartDate   		 = request.getParameter("departDate") == null ? "": request.getParameter("departDate");
			strDepartTime			 = request.getParameter("departTime")== null? "1" : request.getParameter("departTime");
			strDepartAirLineName     = request.getParameter("departAirLineName") == null ? "" : request.getParameter("departAirLineName").trim();
			strArrivalCity			 = request.getParameter("arrivalCity") == null ? "" : request.getParameter("arrivalCity").trim();
			strArrivalCity1			 = request.getParameter("arrivalCity1") == null ? "" : request.getParameter("arrivalCity1").trim();
			strReturnDate			 = request.getParameter("returnDate") ==null ? "" : request.getParameter("returnDate");
			strArrivalTime			 = request.getParameter("arrivalTime") == null ? "1" : request.getParameter("arrivalTime") ;
			strArrivalAirLineName    = request.getParameter("arrivalAirLineName") == null ? "" : request.getParameter("arrivalAirLineName").trim();
			strManager				 = request.getParameter("manager") == null ? "-1" : request.getParameter("manager");
			strPHOD					 = request.getParameter("hod") == null ? "-1" : request.getParameter("hod");
			strSelectManger			 = request.getParameter("selectManger") == null ? "manual" : request.getParameter("selectManger");
			strTransitType			 = request.getParameter("transit") == null ? "0" :  request.getParameter("transit");
			strBudget				 = request.getParameter("budget") == null ? ""  : request.getParameter("budget").trim();
            strBudgetCurrency        = request.getParameter("currency") == null ? "INR" : request.getParameter("currency").trim();
			strCheckin				 = request.getParameter("checkin") == null ? "" : request.getParameter("checkin");
			strCheckout				 = request.getParameter("checkout") == null ? "" : request.getParameter("checkout");
			strOthers				 = request.getParameter("others")== null ?  "" : request.getParameter("others").trim();

//new
			strReasonForTravel	       = request.getParameter("reasonForTravel")== null ?  "" : request.getParameter("reasonForTravel").trim();
			strReasonForSkip           =  request.getParameter("reasonForSkip") == null ? "" : request.getParameter("reasonForSkip").trim();

			strIntermiId					=	request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
			strTravelReqId   				=  request.getParameter("travelReqId");    
			strTravelId						=  request.getParameter("travelId");       
			strTravelReqNo					=  request.getParameter("travelReqNo");  
			
			
			// added new for showing seat preffre and ticket refundable on  
			 strSeatprefferRet      =request.getParameter("prefferedSeatRet")== null ? "1" : request.getParameter("prefferedSeatRet");
			 strSeatpreffer	        =request.getParameter("prefferedSeatFwd")== null ? "1" : request.getParameter("prefferedSeatFwd");	
			 strTicketRefundfwd     =request.getParameter("ticketRefundfwd")== null ? "n" : request.getParameter("ticketRefundfwd");
			 strTicketRefundrtd     =request.getParameter("ticketRefundrtd")== null ? "n" : request.getParameter("ticketRefundrtd");
			 
			 strBoardMember					=  request.getParameter("boardmember")==null?"-1":request.getParameter("boardmember");
			 strCostCentre					=  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
			 String strAppLvl3flg = "";
			 String strAppLvl3flgforBM = "";
			 String strMandatatoryApvFlag = "";
			//Added By Gurmeet Singh
			 String strUserAccessCheckFlag = "";	
			
			//code added by manoj chand on 27 march 2012 to CHECK WHETHER DIVISION OF USER IS SMP OR NOT.
			strSql="SELECT SHOW_APP_LVL_3 FROM M_DIVISION MD INNER JOIN	M_USERINFO MU ON MU.DIV_ID=MD.DIV_ID WHERE USERID="+Suser_id;
			//System.out.println("strSql --->"+strSql);
			rs       =   dbConBean.executeQuery(strSql);  
			if(rs.next())
			{
				strAppLvl3flg=rs.getString("SHOW_APP_LVL_3");
				//System.out.println("strAppLvl3flg--DOMESTIC---->"+strAppLvl3flg);
			}
			rs.close();

			rs=null;

			if(strMessage != null && strMessage.equals(dbLabelBean.getLabel("message.global.save",strsesLanguage)))
		    {
			  strMessage = dbLabelBean.getLabel("message.global.savedsuccessfully",strsesLanguage);
		    }
		    else if(strMessage != null && strMessage.equals(dbLabelBean.getLabel("message.global.notsaved",strsesLanguage)))
		    {
			  strMessage = dbLabelBean.getLabel("message.global.couldnotsave",strsesLanguage); 
		    }
		    else
		    {
			  strMessage = ""; 
	  	    }

			//set the site value
			if (strSiteId == null) {
				strSiteId = strSiteIdSS;
			}
			else if ( strFlag != null && strFlag.equals("site")){
				strUserId 								= "-1";
				strDesigName 			         		= "";
				strPhone								= "";
				strFFNo									= "";
				strAge									= "";
				strSex 									= "1";		
				strDepartCity							= "";

				strDepartCity1							= "";

				strDepartDate					     	= "";
				strDepartTime				     		= "1";
				strDepartMode					     	= "1";
				strDepartAirLineName             		=	"";
				strArrivalCity							= "";

				strArrivalCity1							= "";

				strReturnDate					    	=	"";
				strArrivalTime				     		= "1";
				strArrivalMode					    	= "1";
				strArrivalAirLineName	         		=	"";
				strTransitType					    	=	"0";
				strBudget								=	"";
				strCheckin								= "";
				strCheckout					    		=	"";
				strSelectManger			         		= 	"manual";				
			}
			 

			//set the userid and site id
			if (strUserId == null) {
				strUserId = Suser_id;
				
				
				strDesigName = strDesigFullName; //get name from the session strDesigShortName of application.jsp
				strSql = "SELECT LTRIM(RTRIM(ISNULL(CONTACT_NUMBER,''))) AS CONTACT_NUMBER, LTRIM(RTRIM(ISNULL(FF_NUMBER,''))) AS FF_NUMBER,LTRIM(RTRIM(ISNULL(FF_NUMBER1,''))) AS FF_NUMBER1,LTRIM(RTRIM(ISNULL(FF_NUMBER2,''))) AS FF_NUMBER2,ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2, ISNULL(IDENTITY_ID,-1) AS IDENTITY_ID ,ISNULL(IDENTITY_NO,'') AS IDENTITY_NO  FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId+ "AND STATUS_ID =10 AND APPLICATION_ID = 1";
				//System.out.println("1======="+strSql);
				rs = dbConBean.executeQuery(strSql);
				if (rs.next()) {
					strPhone = rs.getString("CONTACT_NUMBER");
					strFFNo	 = rs.getString("FF_NUMBER");
					strFFNo1 = rs.getString("FF_NUMBER1");	
					strFFNo2 = rs.getString("FF_NUMBER2");

					//NEW 17-02-2007 SACHIN
			
					strAirLineName		=	rs.getString("FF_AIR_NAME");
					strAirLineName1		=	rs.getString("FF_AIR_NAME1");
					strAirLineName2		=	rs.getString("FF_AIR_NAME2");
					///added new for identity proof
					strIdentityProof					= rs.getString("IDENTITY_ID");
					strIdentityProofNo			= rs.getString("IDENTITY_NO");
 
				}
				rs.close();

			} 
			else if (strUserId != null && strFlag.equals("user") ) 
			{
				 
				strSql = "SELECT dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG,LTRIM(RTRIM(ISNULL(CONTACT_NUMBER,''))) AS CONTACT_NUMBER, LTRIM(RTRIM(ISNULL(FF_NUMBER,''))) AS FF_NUMBER,LTRIM(RTRIM(ISNULL(FF_NUMBER1,''))) AS FF_NUMBER1,LTRIM(RTRIM(ISNULL(FF_NUMBER2,''))) AS FF_NUMBER2,ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2,ISNULL(IDENTITY_ID,-1) AS IDENTITY_ID ,ISNULL(IDENTITY_NO,'') AS IDENTITY_NO FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId+ "AND STATUS_ID =10 AND APPLICATION_ID = 1";
				
				//System.out.println("strSql=====1=="+strSql);
				rs = dbConBean.executeQuery(strSql);
				if (rs.next()) {
					strDesigName = rs.getString("DESIG");
					strPhone = rs.getString("CONTACT_NUMBER");
					strFFNo = rs.getString("FF_NUMBER");
					strFFNo1 = rs.getString("FF_NUMBER1");	
					strFFNo2 = rs.getString("FF_NUMBER2");

					strAirLineName		=	rs.getString("FF_AIR_NAME");
					strAirLineName1		=	rs.getString("FF_AIR_NAME1");
					strAirLineName2		=	rs.getString("FF_AIR_NAME2");
					//addded new for identity  proof   22-Oct-07 by shiv 
					strIdentityProof					= rs.getString("IDENTITY_ID");
					strIdentityProofNo			= rs.getString("IDENTITY_NO");
				}
				rs.close();
			}

			if( strTravelId == null)
			{
			  strTravelReqId = "new";
			  strTravelId    = "new";
			} else if (strTravelId != null && strFlag != null && strFlag.trim().equals("save")){

				strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "D", Suser_id);
				if(strUserAccessCheckFlag.equals("420")){
					dbConBean.close();  
					securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_TravelDetail_Dom.jsp", "Unauthorized Access");
					response.sendRedirect("UnauthorizedAccess.jsp");
					return;
				} else {
 
 
				strSql = "SELECT LTRIM(RTRIM(TD.SITE_ID)) AS COMPANY ,LTRIM(RTRIM(TD.TRAVEL_REQ_ID)) as  TRAVELREQID, "+
				" LTRIM(RTRIM(TD.TRAVELLER_ID)) AS TRAVELLERNAME,LTRIM(RTRIM(TD.AGE)) AS AGE, LTRIM(RTRIM(TD.SEX)) AS SEX, "+
				" LTRIM(RTRIM(TD.MEAL)) AS MEAL,LTRIM(RTRIM(TD.APPROVER_SELECTION)) AS APPROVER_SELECTION, MANAGER_ID, HOD_ID,  " +
				" LTRIM(RTRIM(ISNULL(TD.CARD_TYPE,''))) AS CARD_TYPE,LTRIM(RTRIM(ISNULL(TD.CARD_NUMBER1,''))) AS CARD_NUMBER1, " +
				" LTRIM(RTRIM(ISNULL(TD.CARD_NUMBER2,''))) AS CARD_NUMBER2 ,LTRIM(RTRIM(ISNULL(TD.CARD_NUMBER3,''))) AS CARD_NUMBER3, "+
				" LTRIM(RTRIM(ISNULL(TD.CARD_NUMBER4,''))) AS CARD_NUMBER4 ,LTRIM(RTRIM(ISNULL(TD.CVV_NUMBER,''))) AS CVV_NUMBER, "+
				" LTRIM(RTRIM(ISNULL(dbo.CONVERTDATEDMY1(TD.CARD_EXP_DATE),''))) AS CARD_EXP_DATE,  " +
				" LTRIM(RTRIM(TJD.TRAVEL_FROM)) AS DEPARTCITY,ISNULL(.DBO.CONVERTDATEDMY1(TJD.TRAVEL_DATE),'') AS DEPARTDATE, " +
				" LTRIM(RTRIM(TJD.TIMINGS)) AS DEPARTTIME, LTRIM(RTRIM(TJD.TRAVEL_MODE)) AS DEPARTMODE,  "+
				" LTRIM(RTRIM(TJD.MODE_NAME)) AS DEPTAIRLINE, LTRIM(RTRIM(TJD.TRAVEL_CLASS)) AS DEPTCLASS,"+ 
				" LTRIM(RTRIM(TJD.TRAVEL_TO)) AS ARRIVALCITY,ISNULL(.DBO.CONVERTDATEDMY1(TJR.TRAVEL_DATE),'') AS RETURNDATE, LTRIM(RTRIM(TJR.MODE_NAME)) AS RETURNLINE, "+
				" LTRIM(RTRIM(TJR.TRAVEL_MODE)) AS RETURNMODE, LTRIM(RTRIM(TJR.TRAVEL_CLASS)) AS RETURNCLASS, "+
				" LTRIM(RTRIM(TJR.TIMINGS)) AS RETURNTIME ,LTRIM(RTRIM(TD.TRANSIT_TYPE)) AS TRANSITTYPE, "+
				" ISNULL(TD.TRANSIT_BUDGET,'') AS BUDGET,LTRIM(RTRIM(BUDGET_CURRENCY)) AS BUDGET_CURRENCY,"+    
				 
				" ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_IN_DATE),'') AS CHECKINDATE, "+ 
			    " ISNULL(.DBO.CONVERTDATEDMY1(TD.CHECK_OUT_DATE),'') AS CHECKOUTDATE, "+
			    "  LTRIM(RTRIM(TD.REMARKS)) AS REMARKS,ISNULL(TD.REASON_FOR_TRAVEL,'') AS REASON_FOR_TRAVEL ,"+ 
				"  ISNULL(TD.REASON_FOR_SKIP,'') AS REASON_FOR_SKIP,LTRIM(RTRIM(TJR.RETURN_FROM)) AS RETURN_FROM,LTRIM(RTRIM(TJR.RETURN_TO)) AS RETURN_TO, "+ 
				"  TD.PLACE AS PLACE, TD.FORWARD_TATKAAL AS FORWARD_TATKAAL, TD.RETURN_TATKAAL AS RETURN_TATKAAL, TD.FORWARD_COUPAN AS FORWARD_COUPAN, TD.RETURN_COUPAN AS RETURN_COUPAN, "+ 
				"  ISNULL(TD.IDENTITY_PROOFNO,'') AS IDENTITY_PROOFNO,ISNULL(TD.IDENTITY_PROOF,'0') AS IDENTITY_PROOF,ISNULL(CARD_HOLDER_NAME,'') AS CARD_HOLDER_NAME,ISNULL(TJD.SEAT_PREFFERED,'1') AS SEAT_PREFFERED,"+  
				"  ISNULL(TJR.SEAT_PREFFERED,'1') as  SEAT_PREFFEREDRet,TJD.TICKET_REFUNDABLE as TICKET_REFUNDABLEfwd,TJR.TICKET_REFUNDABLE  as TICKET_REFUNDABLErtd, TD.BOARD_MEMBER_ID,TD.CC_ID " +
				"  FROM T_TRAVEL_DETAIL_DOM TD (NOLOCK) inner join T_JOURNEY_DETAILS_DOM TJD (NOLOCK) on TD.TRAVEL_ID = TJD.TRAVEL_ID "+
				" inner join T_RET_JOURNEY_DETAILS_DOM TJR (NOLOCK) on TD.TRAVEL_ID= TJR.TRAVEL_ID WHERE  "+
				"  TJD.JOURNEY_ORDER = 1 AND TD.TRAVEL_ID= "+strTravelId; 

				 //System.out.println("strSql========aa========="+strSql);
                 
				 //IDENTITY_PROOFNO


				rs = dbConBean.executeQuery(strSql);
				if (rs.next()){
					strSiteId					= rs.getString("COMPANY");
					strTravelReqId				= rs.getString("TRAVELREQID");
					strUserId					= rs.getString("TRAVELLERNAME");
					strAge1						= rs.getString("AGE");
					strSex						= rs.getString("SEX");
					strMealId					= rs.getString("MEAL");
					strSelectManger				=	rs.getString("APPROVER_SELECTION");
					strManager            		= rs.getString("MANAGER_ID");
					strPHOD             		= rs.getString("HOD_ID");
					strCARD_TYPE				= rs.getString("CARD_TYPE");
					strCARD_NUMBER1			 	= rs.getString("CARD_NUMBER1");
					strCARD_NUMBER2			 	= rs.getString("CARD_NUMBER2");
					strCARD_NUMBER3			 	= rs.getString("CARD_NUMBER3");
					strCARD_NUMBER4			 	= rs.getString("CARD_NUMBER4");
					strCVV_NUMBER			 	= rs.getString("CVV_NUMBER");
					strCARD_EXP_DATE	 		= rs.getString("CARD_EXP_DATE");
					strDepartCity				= rs.getString("DEPARTCITY");

					
					strDepartDate				= rs.getString("DEPARTDATE");
					strDepartTime				= rs.getString("DEPARTTIME");
					strDepartMode				= rs.getString("DEPARTMODE");
					strDepartAirLineName		= rs.getString("DEPTAIRLINE");
					strDepartClass				= rs.getString("DEPTCLASS");		
					strArrivalCity				= rs.getString("ARRIVALCITY");
					strReturnDate				= rs.getString("RETURNDATE");
					strArrivalAirLineName		= rs.getString("RETURNLINE");
					strArrivalMode				= rs.getString("RETURNMODE");
					strArrivalClass				= rs.getString("RETURNCLASS");
					strArrivalTime				= rs.getString("RETURNTIME");
					strTransitType				= rs.getString("TRANSITTYPE");
					strBudget					= rs.getString("BUDGET");
					strBudgetCurrency			= rs.getString("BUDGET_CURRENCY");
					
					if(strBudgetCurrency == null)
					{
						strBudgetCurrency = "INR";
					}
					strCheckin 					=   rs.getString("CHECKINDATE");
					strCheckout					=   rs.getString("CHECKOUTDATE");		
					strOthers					=   rs.getString("REMARKS"); 
					strReasonForTravel      	=   rs.getString("REASON_FOR_TRAVEL");    
					strReasonForSkip			=   rs.getString("REASON_FOR_SKIP");

					strDepartCity1				=   rs.getString("RETURN_FROM");
					strArrivalCity1				=   rs.getString("RETURN_TO");
					// 17-02-2007 SACHIN
					strPlace					=	rs.getString("PLACE");
					strForTatkaalRequired		=	rs.getString("FORWARD_TATKAAL");
					strRetTatkaalRequired		=	rs.getString("RETURN_TATKAAL");
					strForCoupanRequired		=	rs.getString("FORWARD_COUPAN");
					strRetCoupanRequired		=	rs.getString("RETURN_COUPAN");
					//Added new  by Shiv  Sharma on 22-Oct-07  
					strIdentityProofNo			=	rs.getString("IDENTITY_PROOFNO");
					strIdentityProof			=	rs.getString("IDENTITY_PROOF");
					//23-02-2007
		            strCARD_HOLDER_NAME			=   rs.getString("CARD_HOLDER_NAME");
					
					// addedd new on  09 jan 2009 
		            strSeatpreffer 			    =	rs.getString("SEAT_PREFFERED");
 		            strSeatprefferRet 	        =	rs.getString("SEAT_PREFFEREDRet");
 		            
 		            strTicketRefundfwd 			=	rs.getString("TICKET_REFUNDABLEfwd");
 					strTicketRefundrtd 			=	rs.getString("TICKET_REFUNDABLErtd");
 					strBoardMember				=	rs.getString("BOARD_MEMBER_ID");
 					strCostCentre		=	rs.getString("CC_ID");
 					if(strCostCentre==null)
 						strCostCentre="0";
 					/*System.out.println("strManager----DOMQ UERY--->"+strManager);
 					System.out.println("strPHOD----DOMQ UERY--->"+strPHOD);
 					System.out.println("strBoardMember----DOMQ UERY--->"+strBoardMember);*/
 					if(strBoardMember==null){
 						strBoardMember="-1";
 					}
 						
      
 				}					
				rs.close();
				
				//added by manoj chand on 26 july 2012 to get month and year from card expiry date
				if(strCARD_EXP_DATE!=null && !strCARD_EXP_DATE.equals("")){
				strMonth=strCARD_EXP_DATE.substring(3,5);
				strYear=strCARD_EXP_DATE.substring(6,10);
				}

//				System.out.println("strArrivalMode:  "+strArrivalMode);
				if (strBudget.equals("0.0")) {
					strBudget	=	"";
				}
			 
			    strSql = "SELECT dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG,LTRIM(RTRIM(ISNULL(CONTACT_NUMBER,''))) AS CONTACT_NUMBER, LTRIM(RTRIM(ISNULL(FF_NUMBER,''))) AS FF_NUMBER,LTRIM(RTRIM(ISNULL(FF_NUMBER1,''))) AS FF_NUMBER1,LTRIM(RTRIM(ISNULL(FF_NUMBER2,''))) AS FF_NUMBER2,ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId+ "AND STATUS_ID =10 AND APPLICATION_ID = 1";
				//strSql = "SELECT dbo.DESIGNATIONNAME(DESIG_ID) AS DESIG, ISNULL(CONTACT_NUMBER,'') AS CONTACT_NUMBER , ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(FF_NUMBER1,'') AS FF_NUMBER1,ISNULL(FF_NUMBER2,'') AS FF_NUMBER2 FROM M_USERINFO WHERE USERID="+ strUserId + " AND STATUS_ID=10 AND APPLICATION_ID=1";
				//System.out.println("strSql----->"+strSql);
				rs = dbConBean.executeQuery(strSql);
				if (rs.next()) {
					strDesigName = rs.getString("DESIG");
					strPhone = rs.getString("CONTACT_NUMBER");
					strFFNo = rs.getString("FF_NUMBER");
					strFFNo1 = rs.getString("FF_NUMBER1").trim();
					strFFNo2 = rs.getString("FF_NUMBER2").trim();

					strAirLineName		=	rs.getString("FF_AIR_NAME");
					strAirLineName1		=	rs.getString("FF_AIR_NAME1");
					strAirLineName2		=	rs.getString("FF_AIR_NAME2");
				}
				rs.close();
				}
			}

		 // get the current date for checking the departureDate and arrivalDate
		  java.util.Date currentDate = new java.util.Date();
		  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  String strCurrentDate = (sdf.format(currentDate)).trim();

		//added by manoj chand on 01 august 2012 to get cost centre id
			rs=null;
			strSql =   "SELECT 1 FROM M_COST_CENTRE WHERE SITE_ID="+strSiteId+" AND M_COST_CENTRE.STATUS_ID=10";
			rs       =   dbConBean.executeQuery(strSql);
			if(rs.next()){
				strShowflag="y";
			}
			rs.close();
			//System.out.println("strAppLvl3flg--DOMESTIC---->"+strAppLvl3flg);
			//System.out.println("strShowflag--DOMESTIC---->"+strShowflag);
		  
		  //added by manoj to add check for unit head on 18 jan 2011
		String strUnit_Head="0";
		strSql="SELECT A.UNIT_HEAD FROM USER_MULTIPLE_ACCESS AS A INNER JOIN M_USERINFO AS B ON A.USERID = B.USERID WHERE (A.STATUS_ID = 10) AND (B.STATUS_ID = 10) AND (A.UNIT_HEAD = 1) AND A.USERID = "+strUserId+" AND A.SITE_ID = "+strSiteId+" ";
		rs = dbConBean.executeQuery(strSql); 
		if (rs.next()) {
			strUnit_Head = rs.getString("UNIT_HEAD");	
		}
		rs.close();
		// System.out.println("strSql>>>>>>>>"+strSql);		  
		// System.out.println("strUnit_Head>>>>>>>>"+strUnit_Head);
		
		//code added by manoj chand on 19 oct 2012 to CHECK WHETHER site OF USER IS SMP OR NOT.
		strSql="SELECT SHOW_APP_LVL_3,MANDATORY_APP_FLAG FROM dbo.M_SITE ms WHERE ms.STATUS_ID=10 and ms.SITE_ID="+strSiteId;
		rs       =   dbConBean.executeQuery(strSql);  
		if(rs.next())
		{
			strAppLvl3flgforBM=rs.getString("SHOW_APP_LVL_3");
			strMandatatoryApvFlag=rs.getString("MANDATORY_APP_FLAG");
		}
		rs.close();
		
		
		%> 
			
<script language="JavaScript">
//function added by vaibhav on jul 2 2010 to change date input format for credit card expiry date

function expiryDate()
{
	document.frm.CARD_EXP_DATE.value ='';
	var selIndex = document.frm.yearSelect.selectedIndex;
	var year = document.frm.yearSelect.options[selIndex].text;
	//alert(year);
	if(year!='<%=dbLabelBean.getLabel("label.global.year",strsesLanguage)%>')
	{
		var selIndex = document.frm.monSelect.selectedIndex;
		var month = document.frm.monSelect.options[selIndex].text;
		//alert(month);
		if(month!='<%=dbLabelBean.getLabel("label.global.month",strsesLanguage)%>')
		{
			//alert('01'+'/'+month+'/'+year);
			document.frm.CARD_EXP_DATE.value = '01'+'/'+month+'/'+year;
			
		}
	}
}

function CreditCheck(frm)
{
if(document.frm.CARD_TYPE.value=='-1')
	{
	    ///23/02/2007
        document.frm.cardHolderName.value="";  
		///23/02/2007
		//document.frm.CARD_NUMBER1.value="";
		//document.frm.CARD_NUMBER2.value="";
		//document.frm.CARD_NUMBER3.value="";
		//document.frm.CARD_NUMBER4.value="";
		///document.frm.CVV_NUMBER.value="";
		document.frm.CARD_EXP_DATE.value="";

         ///23/02/2007 
		document.frm.cardHolderName.disabled=true;
         ///23/02/2007

		//document.frm.CARD_NUMBER1.disabled=true;
		//document.frm.CARD_NUMBER2.disabled=true;
		//document.frm.CARD_NUMBER3.disabled=true;
		//document.frm.CARD_NUMBER4.disabled=true;
		//document.frm.CVV_NUMBER.disabled=true;
		document.frm.CARD_EXP_DATE.disabled=true;
		document.frm.monSelect.value='';
		document.frm.yearSelect.value='';
		document.frm.monSelect.disabled=true;
		document.frm.yearSelect.disabled=true;
}  
else
	{   ///23/02/2007 
		document.frm.cardHolderName.disabled=false;
        ///23/02/2007 
		//document.frm.CARD_NUMBER1.disabled=false;
		//document.frm.CARD_NUMBER2.disabled=false;
		//document.frm.CARD_NUMBER3.disabled=false;
		//document.frm.CARD_NUMBER4.disabled=false; 
		//document.frm.CVV_NUMBER.disabled=false;
		document.frm.CARD_EXP_DATE.disabled=false;
		document.frm.monSelect.disabled=false;
		document.frm.yearSelect.disabled=false;
		
	}

}

		function setId(id) {
			document.frm.interimId.value = id;
		}

		function getUserID()
		{
			//added by manoj chand on 03 august 2012
			if(document.frm.costcentre!=null || document.frm.costcentre!=undefined){
				  document.frm.costcentre.value="0";
				  }
			//document.frm.flag.value = "site";	
			document.frm.action="T_TravelDetail_Dom.jsp";
			document.frm.submit();
		}
		
		function getUserID1()
		{	
			
			var smpsitebmflag_val='<%=strAppLvl3flgforBM%>';
			
			document.frm.flag.value = "user";
			
			document.frm.manager.value= "";
			document.frm.hod.value= "";
			
			if(smpsitebmflag_val=='y'){
				document.frm.boardmember.value = ""
			}
			
			document.frm.action="T_TravelDetail_Dom.jsp";
			document.frm.submit();
		}

		function getUserID2()
		{
			document.frm.action="T_TravelDetail_Dom.jsp";
			document.frm.submit();
		}


		// CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
		// FUNCTION USE FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA

		function skipDisabled(f1,flag)
		{
//alert(flag);
if(flag=='first')
{
			//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
			//$.noConflict();
			jQuery(document).ready(function($) {
						//var siteid=document.f1.site.value;
						//change by manoj chand on 10 jan 2012 to resolve scripting error coming at the time of getting get site value
						var siteid=document.getElementById('site').value
						var managerId = $("#firstapprover option:selected").val();
						//var urlParams2 = '<%="&SITE_ID="+strSiteIdSS+"&sp_role="+SSstrSplRole+"&reqpage=approver1&traveltype=D"%>';
						var urlParams2 = '<%="&sp_role="+SSstrSplRole+"&reqpage=approver1&traveltype=D"%>';
						var urlParams = "managerId="+managerId+"&SITE_ID="+siteid+urlParams2;
						//alert(urlParams);
						$.ajax({
				            type: "post",
				            url: "AjaxMaster.jsp",
				            data: urlParams,
				            success: function(result){
				        
				            	var res = result.trim();
				                if(res == 'y'){
				                		alert('<%=dbLabelBean.getLabel("alert.global.approverindefaultworkflow",strsesLanguage)%>');
				                		//document.getElementById('firstapprover').value='-1';
				                }


				            	 
				            },
							error: function(){
								alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
				            }
				          });
				//	}
			//	);
			});
}//end if


			String.prototype.trim = function() {
				return this.replace(/^\s+|\s+$/g,"");
			}
			//JQUERY DROPDOWN FILLING IMPLEMENTAION ENDS

			
			//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
			//$.noConflict();
	if(flag=='second')
	{		
			jQuery(document).ready(function($) {
						var siteid=document.getElementById('site').value;
						var managerId = $("#secondapprover option:selected").val();
						//var urlParams2 = '<%="&SITE_ID="+strSiteIdSS+"&sp_role="+SSstrSplRole+"&reqpage=approver2&traveltype=D"%>';
						var urlParams2 = '<%="&sp_role="+SSstrSplRole+"&reqpage=approver2&traveltype=D"%>';
						var urlParams = "managerId="+managerId+"&SITE_ID="+siteid+urlParams2;
						//alert(urlParams);
						$.ajax({
				            type: "post",
				            url: "AjaxMaster.jsp",
				            data: urlParams,
				            success: function(result){
				            	
				            	var res = result.trim();
				                if(res == 'y'){
				                		alert('<%=dbLabelBean.getLabel("alert.global.approverindefaultworkflow",strsesLanguage)%>');
				                		//document.getElementById('secondapprover').value='-1';
				                }


				            	 
				            },
							error: function(){
								alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
				            }
				          });
				//	}
			//	);
			});
	}//end if

			
			if((f1.manager.value != '-1' && f1.manager.value != '') && 
				(f1.hod.value != '-1' && f1.hod.value != ''))
			{
				f1.reasonForSkip.disabled=true;
				f1.reasonForSkip.value="";
			}

			else if((f1.manager.value == '-1' || f1.manager.value == '') && 
				(f1.hod.value == '-1' || f1.hod.value == ''))
			{
				f1.reasonForSkip.disabled=false;
			}
		
			else if((f1.manager.value != '-1' || f1.manager.value != '') && 
				(f1.hod.value == '-1' || f1.hod.value == ''))
			{
				f1.reasonForSkip.disabled=false;
			}
	
			else if((f1.manager.value == '-1' || f1.manager.value == '') && 
				(f1.hod.value != '-1' || f1.hod.value != ''))
			{
				f1.reasonForSkip.disabled=false;
			}

		}

		// END OF skipDisabled() FUNCTION ON 3/12/2007 BY SAMIR RANJAN PADHI

	   function checkData(f1,flag) 
	   {
		  
		if (f1.userName.value == -1) {
			alert('<%=dbLabelBean.getLabel("alert.global.travellername",strsesLanguage)%>'); 
			f1.userName.focus();
			return false;
		   }

			if (f1.age.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.age",strsesLanguage)%>');
				f1.age.focus();
				return false;
			}

			if (f1.phoneNo.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.mobilenumber",strsesLanguage)%>');
				f1.phoneNo.focus();
				return false;
			}	

			var x='<%=strAppLvl3flg%>';
			var y='<%=strShowflag%>';
			if(x=='Y' && y=='y'){
			if(f1.costcentre.value=='0'){
				alert('<%=dbLabelBean.getLabel("alert.global.costcentre",strsesLanguage)%>');
				f1.costcentre.focus();
				return false;
			}
			}
			
			if (f1.departCity.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
				f1.departCity.focus();
				return false;
			}

			///change by shiv on 2/19/2007 open
			if (f1.arrivalCity.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
				f1.arrivalCity.focus();
				return false;
			}
         ///change by shiv on 2/19/2007 open
			if (f1.departDate.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.departuredateofforwardjourney",strsesLanguage)%>');//2/26/2007
				f1.departDate.focus();
				return false;
			}

     /////  20--20--2007

if(f1.departCity1.value!=''  ||  f1.arrivalCity1.value!=''  || f1.returnDate.value!='')
		{

		 if(f1.departCity1.value=='')
	         {
		     alert('<%=dbLabelBean.getLabel("alert.global.departurecity",strsesLanguage)%>');
		     f1.departCity1.focus();
		     return false;
	        }
	    if(f1.arrivalCity1.value=='')
	       {
		     alert('<%=dbLabelBean.getLabel("alert.global.arrivalcity",strsesLanguage)%>');
		     f1.arrivalCity1.focus();
	     	return false;
        	}
       if(f1.returnDate.value=='')
	       {
	    	alert('<%=dbLabelBean.getLabel("alert.global.departuredate",strsesLanguage)%>');
		    f1.returnDate.focus();
		   return false;
	        }
			 
  }


/////  20--20--2007

	
			if (f1.departAirLineName.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.preferredairlinetraincab",strsesLanguage)%>');
				f1.departAirLineName.focus();
				return false;
			}

			

		    if (f1.returnDate.value != "" && f1.arrivalAirLineName.value == "") {
				alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
				f1.arrivalAirLineName.focus();
				return false;
		     }
			 /*Added by Rajeev Dubey on 17 Feb 2007*/
			 if (f1.identityProof.value == -1) {
				alert('<%=dbLabelBean.getLabel("alert.global.identityproof",strsesLanguage)%>');
				f1.identityProof.focus();
				return false;
		     }

			 /*Added by shiv on 3/14/2007*/
              			 if (f1.identityProofno.value == "") {

				alert('<%=dbLabelBean.getLabel("alert.createrequest.identityproofnumber",strsesLanguage)%>');
				f1.identityProofno.focus();
				return false;
		     }
  
 //new
			  if(f1.reasonForTravel.value == "")
			  {
				alert('<%=dbLabelBean.getLabel("alert.global.enterreasonfortravel",strsesLanguage)%>');
					f1.reasonForTravel.focus();
					return false;	
		      }
			  //

			  // manoj
			
		//code added by manoj chand on 23 july 2013 to make mandatory selection of user for mssl unit.
		  var var_mand_flag = '<%=strMandatatoryApvFlag%>';
		  if(var_mand_flag=='Y'){
		  	if(f1.manager.value=='-1' || f1.hod.value=='-1'){
		  		alert('<%=dbLabelBean.getLabel("alert.createrequest.bothapprovallevelismandatory",strsesLanguage)%>');
		  		if(f1.manager.value=='-1')
		  			frm.manager.focus();
		  		else
		  			frm.hod.focus();
		  		return false;
		  	}
		  	
		  }
		  else{
			  
			  var divflag='<%=strAppLvl3flg%>'; 
			  var unitHeadFlag = f1.hid_UnitHeadFlag.value;
			  if(unitHeadFlag == '1' && f1.hod.value=="-1" && divflag!='Y'){
			  	alert('<%=dbLabelBean.getLabel("alert.global.approvallevel2",strsesLanguage)%>');
			  	f1.hod.focus();
			  	return false;
			  }
			  
			//code added by manoj chand on 28 March 2012 to validate at least one level approver is selected for SMP SITE.
			//code added by manoj chand on 04 April 2012 this check will work only when travel is not equal to unit head.	
				if(divflag=='Y' && unitHeadFlag!='1'){
					if(f1.manager.value=='-1' && f1.hod.value=='-1'){
						alert('<%=dbLabelBean.getLabel("alert.global.approvallevel1or2",strsesLanguage)%>');
						frm.manager.focus();
						return false;
					}
				}

			if(f1.selectManger[0].checked)
			{
				if(f1.manager.disabled == false)
				{
					if((f1.manager.value == '-1' || f1.manager.value == '') && (f1.hod.value == '-1' || f1.hod.value == ''))
					{
						if(f1.reasonForSkip.value == '')
					    {
							alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1or2",strsesLanguage)%>');
							frm.reasonForSkip.focus();				
						    return false;  
						}					   
					}
					else if((f1.manager.value == '-1' || f1.manager.value == '') && (f1.hod.value != '-1' || f1.hod.value != ''))  
					{
					   if(f1.reasonForSkip.value == '')
					   {
							alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel1",strsesLanguage)%>');
							frm.reasonForSkip.focus();				
							return false;  
					   }
					}
					else if((f1.manager.value != '-1' || f1.manager.value != '') && (f1.hod.value == '-1' || f1.hod.value == ''))
					{
					   if(f1.reasonForSkip.value == '')
					   {
							alert('<%=dbLabelBean.getLabel("alert.global.reasonforskippingapprovallevel2",strsesLanguage)%>');
							frm.reasonForSkip.focus();				
							return false;  
					   }
					}				
				}	
				
			  //
			}

	   }//else block
			
			//code added by manoj chand on 28 March 2012 to make mandatory selection for board member
			var smpsitebmflag_val='<%=strAppLvl3flgforBM%>';
			if(smpsitebmflag_val=='y' && f1.boardmember!=undefined){
				if((f1.boardmember.value!=null && (f1.boardmember.value=='-1' || f1.boardmember.value==''))){
					alert('<%=dbLabelBean.getLabel("alert.global.boardmember",strsesLanguage)%>');
					frm.boardmember.focus();
					return false;
				}
			}
			
			 if (f1.transit.value != "0") 
			 {
				if(f1.place.value == "")
				{
					alert('<%=dbLabelBean.getLabel("alert.global.preferredplace",strsesLanguage)%>');
					f1.place.focus();
					return false;
				} 
				if(f1.transit.value == "1")
				{
					if (f1.budget.value == ""  || f1.budget.value == 0) {
							alert('<%=dbLabelBean.getLabel("alert.global.budget",strsesLanguage)%>');
							f1.budget.focus();
							return false;
					}
				}

				if (f1.checkin.value == "" ) {
						alert('<%=dbLabelBean.getLabel("alert.global.checkindate",strsesLanguage)%>');
						f1.checkin.focus();
						return false;
				}

				if (f1.checkout.value == "" ) {
					alert('<%=dbLabelBean.getLabel("alert.global.checkoutdate",strsesLanguage)%>');
					f1.checkout.focus();
					return false;
				}
			  }
	  	
		  if(f1.transit.value == "0")
	            {
	 		     if (f1.others.value=='')
		             {  
			         alert('<%=dbLabelBean.getLabel("alert.global.enterremarksifaccomodationnotrequired",strsesLanguage)%>');
		             f1.others.focus();
		            return false;
		             }
               }
			 

			  f1.flag1.value = flag;
			
		 	  var todayDate  =  f1.todayDate.value;  
			  var depDate    =  f1.departDate.value;
			  var returnDate =  f1.returnDate.value;
			  var checkinDate  =  f1.checkin.value;
			  var checkoutDate = f1.checkout.value;
			//2/26/2007
			  var flag = checkDate(f1,todayDate,depDate,f1.todayDate,f1.departDate,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthantodaydate",strsesLanguage)%>','no');
			  if(flag == false)
				  return flag;
			  if(returnDate != null && returnDate != '')
			  {
			      flag = checkDate(f1,todayDate,returnDate,f1.todayDate,f1.returnDate,'<%=dbLabelBean.getLabel("alert.global.departuredateofreturnjourneynotsmallerthantodyadate",strsesLanguage)%>','no');
				  if(flag == false)
					return flag;                                                                                          //2/26/2007
				  flag = checkDate(f1,depDate,returnDate,f1.depDate,f1.returnDate,'<%=dbLabelBean.getLabel("alert.global.departuredateoffwdjourneynotsmallerthandeptdateofreturnjourney",strsesLanguage)%>','no');
				  if(flag == false)
					return flag; 
			  }

			  if (f1.transit.value != "0") {
				  flag = checkDate(f1,todayDate,checkinDate,f1.todayDate,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthantodaydate",strsesLanguage)%> ','no');
				  if(flag == false)
						return flag;

				  flag = checkDate(f1,depDate,checkinDate,f1.departDate,f1.checkin,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthandeparturedate",strsesLanguage)%>','no');
				  if(flag == false)
						return flag;

				  flag = checkDate(f1,todayDate,checkoutDate,f1.todayDate,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotsmallerthantodaydate",strsesLanguage)%>','no');
				  if(flag == false)
						return flag;

				  flag = checkDate(f1,checkinDate,checkoutDate,f1.checkin,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkindatecannotsmallerthancheckoutdate",strsesLanguage)%>','no');
				  if(flag == false)
					return flag; 

				  flag = checkDate(f1,checkoutDate,returnDate,f1.returnDate,f1.checkout,'<%=dbLabelBean.getLabel("alert.global.checkoutdatecannotbegreaterthandeparturedate",strsesLanguage)%>','no');
				  if(flag == false)
					return flag; 


			  }
              
              
              // new code added to make CC maendatory----on 19-01-2009  by shiv 
			  //Credit card entry in not mendatory . changes done by shiv sharma on 2/2/2009
              
           // if(f1.transit.value == "1" || f1.transit.value=="2")
            {
   
		 	 if(f1.CARD_TYPE.value == "-1"){
		  		// alert("Credit Card is mandatory, if you required Hotel/Transit House for accommodation on travelling.");
		  		// f1.CARD_TYPE.focus();
		  		// return false;
		  		 }
		  	 else{ 
			  if(f1.CARD_TYPE.value != -1 )
			  {
				/// 23022007 open
                  if(f1.cardHolderName.value == "")
	                       { 
			                 alert('<%=dbLabelBean.getLabel("alert.global.creaditcardholdername",strsesLanguage)%>');
			                 f1.cardHolderName.focus();
			                 return false;
		                    }
              /// 23022007  close
				 
				/*if(f1.CARD_NUMBER1.value == "" || f1.CARD_NUMBER1.value.length < 4)
				  {
					alert("Please enter Credit Card Number ");
					f1.CARD_NUMBER1.focus();
					return false;
				  }

				  if(f1.CARD_NUMBER2.value == "" || f1.CARD_NUMBER2.value.length < 4)
				  {
					alert("Please enter Credit Card Number");
					f1.CARD_NUMBER2.focus();
					return false;
				  }

				  if(f1.CARD_NUMBER3.value == "" || f1.CARD_NUMBER3.value.length < 4)
				  {
					alert("Please enter Credit Card Number");
					f1.CARD_NUMBER3.focus();
					return false;
				  }

				  if(f1.CARD_NUMBER4.value == "" || f1.CARD_NUMBER4.value.length < 4)
				  {
					alert("Please enter Credit Card Number");
					f1.CARD_NUMBER4.focus();
					return false;
				  } 
				  */
				  if(f1.CARD_EXP_DATE.value == "")
				  {
					alert('<%=dbLabelBean.getLabel("alert.global.creditcardexpirydate",strsesLanguage)%>');
					//commented by vaibhav
					//f1.CARD_EXP_DATE.focus();
					if(f1.monSelect.value==''){
						f1.monSelect.focus();
						}
						else{
							if(f1.yearSelect.value==''){
								f1.yearSelect.focus();
							}
							}
					return false;
				  }

				  /*  if(f1.CVV_NUMBER.value == "" || f1.CVV_NUMBER.value.length < 3)
				  {
					alert("Please enter Credit Card 3 Digit CVV Number");
					f1.CVV_NUMBER.focus();
					return false;
				  }*/
             

			  }
			} 
		}	
			//code end for modification    
			
          if(f1.airLineName.value !="" || f1.FFNo.value !="")
				  {

			         if (f1.airLineName.value=="" )
	              {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
                   f1.airLineName.focus(); 
	                return false;
	                 } 

					    if (f1.FFNo.value=="" )
	              {alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
                   f1.FFNo.focus(); 
	                return false;
	                 }  
				  }

				   if(f1.airLineName1.value !="" || f1.FFNo1.value !="")
				  {

			         if (f1.airLineName1.value=="" )
	              {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
                   f1.airLineName1.focus(); 
	                return false;
	                 } 

					    if (f1.FFNo1.value=="" )
	              {alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
                   f1.FFNo1.focus(); 
	                return false;
	                 }   
				  }

 if(f1.airLineName2.value !="" || f1.FFNo2.value !="")
				  {

			         if (f1.airLineName2.value=="" )
	              {alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>');
                   f1.airLineName2.focus(); 
	                return false;
	                 } 

					    if (f1.FFNo2.value=="" )
	              {alert('<%=dbLabelBean.getLabel("alert.global.airlinenumber",strsesLanguage)%>');
                   f1.FFNo2.focus(); 
	                return false;
	                 }   
				  }




			  var CARD_EXP_DATE = f1.CARD_EXP_DATE.value;
			  var flag = checkDate(f1,todayDate,CARD_EXP_DATE,f1.todayDate,f1.CARD_EXP_DATE,'<%=dbLabelBean.getLabel("label.global.creditcardexpired",strsesLanguage)%> ','no');
				if(flag == false)
				  return flag;



				 //added code by sachin on 2/17/2009 
				f1.saveProceed.disabled=true;  //added by sachin
				f1.save.disabled=true;  //added by sachin
				f1.saveExit.disabled=true;  //added by sachin
				f1.submit();
		
			  return true;
		  }

		function test1(obj1, length, str)
		{	
			var obj;
			if(obj1=='age')
			{
				obj = document.frm.age;
			}

			if(obj1=='phoneNo')
			{
				obj = document.frm.phoneNo;
			}

			if(obj1=='FFNo')
			{
				obj = document.frm.FFNo;
			}
			
			if(obj1=='FFNo1')
			{
				obj = document.frm.FFNo1;
			}

			if(obj1=='FFNo2')
			{
				obj = document.frm.FFNo2;
			}

//new 17-02-2007 sachin
			if(obj1=='airLineName')
			{
				 obj = document.frm.airLineName;
			}	
			if(obj1=='airLineName1')
			{
				 obj = document.frm.airLineName1;
			}	
			if(obj1=='airLineName2')
			{
				 obj = document.frm.airLineName2;
			}	

			if(obj1=='place')
			{
				 obj = document.frm.place;
			}	


         


			if(obj1=='identityProof')
			{
				 obj = document.frm.identityProof;
			}	

/////added on 3/14/2007 by shiv
			if(obj1=='identityProofno')
			{
				 obj = document.frm.identityProofno;
			}
//// added on 3/14/2007 by shiv

			if(obj1=='departCity')
			{
				obj = document.frm.departCity;
			}

			if(obj1=='departCity1')
			{
				obj = document.frm.departCity1;
			}

			if(obj1=='departAirLineName')
			{
				obj = document.frm.departAirLineName;
			}

			if(obj1=='arrivalCity')
			{
				obj = document.frm.arrivalCity;
			}

			if(obj1=='arrivalCity1')
			{
				obj = document.frm.arrivalCity1;
			}

			if(obj1=='arrivalAirLineName')
			{
				 
				obj = document.frm.arrivalAirLineName;
			}

			if(obj1=='budget')
			{
				obj = document.frm.budget;
				zeroChecking(obj);
			}

			if(obj1=='others')
			{
				obj = document.frm.others;
				upToTwoHyphen(obj);
			}
//new
			if(obj1=='reasonForTravel')
			{
				obj = document.frm.reasonForTravel;
				upToTwoHyphen(obj);
			}
			if(obj1=='reasonForSkip')
			{
				 obj = document.frm.reasonForSkip;
				 upToTwoHyphen(obj);
			}

               ///23-02-2007
                    if(obj1=='cardHolderName')
	                        {
		                   obj = document.frm.cardHolderName;
 	                        } 

///23-02-2007
//
			if(obj1=='CARD_NUMBER1')
			{
				 obj = document.frm.CARD_NUMBER1;
			} 

			if(obj1=='CARD_NUMBER2')
			{
				 obj = document.frm.CARD_NUMBER2;
			} 

			if(obj1=='CARD_NUMBER3')
			{
				 obj = document.frm.CARD_NUMBER3;
			} 

			if(obj1=='CARD_NUMBER4')
			{
				 obj = document.frm.CARD_NUMBER4;
			} 

			/*if(obj1=='CVV_NUMBER')
			{
				 obj = document.frm.CVV_NUMBER;
			} */

			charactercheck(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj); //function for checking leading zero and spaces
			spaceChecking(obj);


		}

//Checking the date of departure and arrival date from the current date(second date should not be the smalle from the first date
function checkDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2)
{
	var todayDate=firstDate;                //today date
	var dDate=secondDate;

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get Reaching Date at Destination information
	var f=dDate.substr(6,4);
	var year1=parseInt(f,10);

	var b=dDate.substr(3,2);
	var month1=parseInt(b,10);

	var h=dDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1)
	{
		 alert(message1);
		 secondDateName.value="";
		 //Commented by vaibhav
		 //secondDateName.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		 alert(message1);
		 secondDateName.value="";
		 //Commented by vaibhav
		// secondDateName.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1))
	{		
		 alert(message1);
		 secondDateName.value="";
		 //Commented by vaibhav
		// secondDateName.focus();
		 return false;
	}//end of elseif
}

function approverSelection() {
	if (document.frm.selectManger[1].checked  == true ) {
		document.frm.manager.disabled	=	true;
		document.frm.hod.disabled	=	true;
		var userid = document.frm.userName.value;	
		var win = window.open('T_Travel_ManagerAuto.jsp?userid='+userid+'&traveltype=DOM','AutoSelection','scrollbars=yes,resizable=no,width=550,height=150');
		win.focus();
	}
	else if (document.frm.selectManger[0].checked  == true) {
		document.frm.manager.disabled	=	false;
		document.frm.hod.disabled	=	false;
	}
}

function MM_openBrWindow()
 { 
   var id =	document.frm.interimId.value;
   window.open('InterimJourney_Dom.jsp?interimTravelId='+id+'&actualTravelId=<%=strTravelId%>','SEARCH','scrollbars=yes,resizable=yes,width=800,height=410');
 }

 function transitOnClick(f1)
{
	//alert(f1.transit.value);
	var transitValue = f1.transit.value;
	//alert(transitValue);
	if(transitValue != null && transitValue == "0")
	{ 
		document.getElementById('hidethis').style.display = 'none';
		f1.budget.value="";
		f1.budget.disabled=true;
		f1.currency.disabled=true;
		f1.checkin.disabled=true;
		f1.checkout.disabled=true;
		f1.place.disabled=true;
	}
	else
	{
		if(transitValue != null && transitValue == "1"){
			document.getElementById('hidethis').style.display = 'none'; 
		}
		if(transitValue != null && transitValue == "2"){
			document.getElementById('hidethis').style.display = '';  
		}
		f1.budget.disabled=false;
		f1.currency.disabled=false;
		f1.checkin.disabled=false;
		f1.checkout.disabled=false;
		f1.place.disabled=false;
		f1.place.focus();
	}	
}


/*function skip(frm,skip)
{
	if(skip == "skip")
	{
		//alert("Plese give the reason for skip approval selection");
		if(confirm('Are you sure you want to skip the Approval Selection 1 and Approval Selection 2 !'))
		{
			alert("Please give the reason for skipping Approval Selection.");
			frm.manager.disabled		= true;
			frm.hod.disabled			= true;
			frm.reasonForSkip.disabled  = false;
			frm.skip11.disabled         = true;
			frm.unskip11.disabled		= false;
			frm.reasonForSkip.value     = "";
			frm.reasonForSkip.focus();
			return true;
		}
		else
		{
			return false;
		}
	}
	if(skip == "unskip")
	{
		//alert("Plese give the reason for skip approval selection");
		if(confirm('Are you sure you want to unskip the Approval Selection 1 and Approval Selection 2 !'))
		{
			frm.manager.disabled		= false;
			frm.hod.disabled			= false;
			frm.reasonForSkip.disabled  = true;
			frm.skip11.disabled         = false;
			frm.unskip11.disabled       = true;
			frm.reasonForSkip.value     = "";
			return true;
		}
		else
		{
			return false;
		}
	}
}*/

//function for showing the default approver list

/// code modified by shiv on 14-May-07 for showing default approver list open
function defaultApproverList(frm)
{
//traveller id fetch and send in url by manoj chand on 17 april 2012
	var siteId = document.frm.site.value;
	var travellerId=document.frm.userName.value;
	var url = 'T_DefaultApproverList.jsp?traveltype=DOM&siteId='+siteId+'&traveller='+travellerId;
   /*window.open('T_DefaultApproverList.jsp?traveltype=DOM&siteId=<%=strSiteIdSS%>','DefaultApprovers','scrollbars=yes,resizable=no,width=550,height=350');
	*/
	window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=550,height=350');
}
/// code modified by shiv on 14-May-07 for showing default approver list close 

</script>

<!-- new code added here on 29-May-07  --> 

<%  //code added by  Shiv on 28 -May-07 for checking workflow for selected  site open 
 
         strSql="SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS (NOLOCK) WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND  APPLICATION_ID=1";
                     rs       =   dbConBean.executeQuery(strSql);  
                     if(!rs.next())
                                {
							          strButtonState="disabled";  
						                 %>
                                                     <script language="javascript">
							  		                  alert('<%=dbLabelBean.getLabel("alert.global.cannotproceed",strsesLanguage)%>');
									                 </script> 
					                     <%
		           			  }
		                        rs.close();	 
%>

<!-- new code added here on 29-May-07 -->

<!--
// CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
// FUNCTION skipDisabled() USE FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA 
// THIS FUNCTION ADDED IN "onLoad()" EVENT OF "body"
-->

<body onLoad="CreditCheck();skipDisabled(frm,'abcd');">
 
<form name="frm"  method="post" action="T_TravelDetail_Dom_Post.jsp">
 <% 
 // Code added by Sanjeet Kumar on 16-july-2007 for giving a proper information incase site not uploaded
 //SpolicyPath variable used on 07 jan 2013 for getting company policy path
 //String Path	=application.getInitParameter("companyPolicyPath");
 File UploadFile=new File(SpolicyPath+"/"+strSiteFullName+"/"+strSiteFullName+".html");
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td height="36" valign="top">
 	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td width="85%" height="36" class="bodyline-top">
		    <img src="images/PageHeadingDomestic.png?buildstamp=2_0_0" width="374" height="26" />		  </td>
		  <td width="15%" align="center" class="bodyline-top"><img src="images/BigIcon.gif?buildstamp=2_0_0" width="46" height="31" /></td>
		</tr>
	  </table>
	</td>
  </tr>
  

  <tr>
    <td align="center" style="padding-top:5px;">
	  
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
		  <td><div align="center"><img src="images\newTabs\4.png?buildstamp=2_0_0" /></div></td>
	    </tr>
	  </table>

	  <table width="95%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
		  <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0">
		    <img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle"/>
			  <span class="formTit"><%=dbLabelBean.getLabel("label.createrequest.createdomestictravelrequest",strsesLanguage)%></span>					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Company Policy" onClick="<% 
			  // code by sanjeet kumar on 16-july-2007 for giving proper information if site not uploaded.
			  if(UploadFile.exists()) {
			  	%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')
				<%; } else{%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;} %>"><img src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a>
			  <span class="formTit" style="text-align:right">
			    <a href="#" onClick="MM_openBrWin('helpdomestictravel.html#300a','','scrollbars=yes,resizable=yes,width=700,height=300')"><img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" />
				</a>
					 
				<td background="images/index_03.png?buildstamp=2_0_0"></td>
			</tr>
			<tr>
				<td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
				<td valign="top" bgcolor="#FFFFFF"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="0">  
					<tr>
						<td height="25" colspan="2" align="left" valign="bottom"
							bgcolor="#FFFFFF" class="formfirstfield"><%=dbLabelBean.getLabel("label.global.basicinformation",strsesLanguage) %> <%=strMessage%></td>
					</tr>
					<tr>
						<td nowrap="nowrap" height="30" colspan="2" align="left" bgcolor="#FFFFFF"	class="formtxt"><%=dbLabelBean.getLabel("label.global.foryourconvenience",strsesLanguage)%> <%=dbLabelBean.getLabel("label.global.fieldsmarkedwithanasterisk",strsesLanguage)%> (<span class="starcolour">*</span>) <%=dbLabelBean.getLabel("label.global.arerequired",strsesLanguage)%></td>
					</tr>
					<tr>
						<td width="51%" height="34" align="left" valign="top"
							bgcolor="#FFFFFF" class="forminnerbrdff">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
							<tr>
								<td height="30" colspan="2" valign="bottom" class="label2"><span class="label1"><%=dbLabelBean.getLabel("label.global.personaladdress",strsesLanguage)%></span></td>
							</tr>
							<tr>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage) %> </td> 
								<td width="49%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.travellername",strsesLanguage) %><span class="starcolour">*</span></td>
							</tr>
							<tr>

								<td height="30" valign="top">
<!-- 								    <select name="site" class="textBoxCss" disabled onChange="javascript:getUserID();">  changed on 03-May-07  -->
								    <select name="site" class="textBoxCss"  onChange="javascript:getUserID();">
									<%  
									 
									  /*   strSql = "select site_id, site_Name from M_Site where status_id=10 and application_id=1 order by 1";
									rs = dbConBean.executeQuery(strSql);   ///orignal 
									 */


									///// 03-May-07 open
									 strSql = "select distinct site_id, dbo.sitename(site_id) as Site_Name  from USER_MULTIPLE_ACCESS (NOLOCK) where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA') order by 2";
									//System.out.println("strSql---1-->"+strSql);
                                       rs       =   dbConBean.executeQuery(strSql); 

									////// 03-May-07close 
		
									while (rs.next()) {

									%>
									<option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option> 
									<%}
									rs.close();
                                       ///// 03-May-07 open    
									 strSql =   "select Site_id, Site_Name from M_Site (NOLOCK) where status_id=10 and application_id=1 and Site_id="+strSiteIdSS+" and Site_id Not IN (select distinct site_id from USER_MULTIPLE_ACCESS (NOLOCK) where userid="+Suser_id+" and status_id=10 and (UNIT_HEAD=1 or ROLE_ID='LA'))  order by 2";
									 //System.out.println("strSql---2-->"+strSql);
						            rs       =   dbConBean.executeQuery(strSql);  

										   while(rs.next())
										  {
				%>
											 <option value="<%=rs.getString("Site_Id")%>"><%=rs.getString("Site_Name")%></option> 
				<%                    }
										  rs.close();	
                                    ////// 03-May-07 close

										%>
								</select></td>
								<script language="javascript">
								//alert("strSiteId=======<%//=strSiteId%>");
                          		document.frm.site.value="<%=strSiteId%>";
                       			 </script>

								<td valign="top"><span class="formtr11"> <select name="userName" class="textBoxCss" onChange="javascript:getUserID1();">
									<option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.travellername",strsesLanguage) %></option>
									
									<%
									//Query changed for showing all user of UNit if usr is LA only for SMR on 04-03-2010
									strSql = "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where site_id="+ strSiteId + " and status_id = 10  order by 2";
									
									if(ssflage.equals("1") && strAppLvl3flg.trim().equalsIgnoreCase("N")){
										if(SuserRoleOther.equals("LA")){
											//CHANGE BY MANOJ CHAND ON 03 SEP 2011 TO GET USERNAME OF CURRENT USER
											 // strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where site_id="+strSiteId+" and status_id=10 and application_id=1 order by 2";
											strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
											 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
											 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
											 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) ORDER BY USERNAME";
										}else{
											//query opened by manoj chand on 06 sept 2012 to show originator only his name in select user combobox.
											strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where userid="+Suser_id+" and status_id=10 and application_id=1 order by 2";
											/*strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
											 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
											 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
											 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) ORDER BY USERNAME";*/
										} 
										
									}else{
									 //strSql =   "select userid, dbo.user_name(userid) As UserName from M_userInfo (NOLOCK) where site_id="+strSiteId+" and status_id=10 and application_id=1 order by 2";
									 // CONDITION FOR LA OR UNIT HEAD =1 IS ADDED BY MANOJ CHAND ON 05 AUG 2013
										strSql=" SELECT     USERID, DBO.USER_NAME(USERID) AS USERNAME "+
										 "FROM         M_USERINFO WITH (NOLOCK) WHERE     (SITE_ID = "+strSiteId+") AND (STATUS_ID = 10) AND (APPLICATION_ID = 1) "+
										 " UNION SELECT USERID,DBO.USER_NAME(USERID) AS USERNAME "+
										 " FROM USER_MULTIPLE_ACCESS WHERE (SITE_ID = "+strSiteId+") AND (USER_MULTIPLE_ACCESS.ROLE_ID='LA' OR  USER_MULTIPLE_ACCESS.UNIT_HEAD=1) AND (STATUS_ID = 10) ORDER BY USERNAME";
									}
									
									rs = dbConBean.executeQuery(strSql);
										while (rs.next()) {
									%>
									<option value=<%= rs.getString(1) %>><%=rs.getString(2)%></option>
									<%}
									/*
									if(strSiteIdSS!=strSiteId)
							          { 
										  */
                              	        %>
									  <!--<option value="<%=Suser_id%>"> <%=sUserFirstName.trim()%> <%=sUserLastName.trim()%></option> -->
							            <% 
							         // }
									rs.close();
									%>	
								</select> 
						<script language="javascript">
			                document.frm.userName.value= "<%=strUserId%>";
            			</script> </span></td>
							</tr>
							<tr>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage) %></td>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.age",strsesLanguage) %></td>
							</tr>
							<tr>
								<td height="30" valign="top"><input name="designation" value="<%=strDesigName%>" readonly type="text" class="textBoxCss" id="test232" size="20" disabled="disabled" /></td>
								<%//For finding the date of birth of traveller

									if (strUserId.equals("") || strUserId.equals("S")) {
									} else {

									//@Gaurav 16-May-2007 Changed the query needed for the Gender 
									  strSql = "SELECT dbo.CalAge_YYMMDD(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId;
 
 										rs = dbConBean.executeQuery(strSql);
										if (rs.next()) {
											strAge = rs.getString(1);
											strGender=rs.getString(2);	
										}
										//@Gaurav End of Code
									    rs.close();

                                      
							          //code change for showing age(Yr,month,days  ) to user but not storing-------on 03-Mar-08 by shiv sharma     
									 strSql = "SELECT dbo.CALAGE(DOB,GETDATE()), GENDER FROM M_USERINFO (NOLOCK) WHERE USERID="+strUserId;

									   rs       =   dbConBean.executeQuery(strSql);  
										 if(rs.next())
											  {
												actualAge = rs.getString(1);
											  }  

											  rs.close();

											  if(actualAge == null)
												actualAge = "";
											  if(actualAge != null && actualAge.equals("0"))
												actualAge="";
                                      
																				  
											  if(actualAge != null && actualAge.equals("-1"))
												actualAge="";

									}

									if (strAge == null)
										strAge = "";
									if (strAge != null && strAge.equals("0"))
										strAge = "";
                                    
                                  /*
									if(strAge1 != null && !strAge1.equals(""))
										   strAge = strAge1;
                                  */
					 

									%>
								
								<td height="30" valign="top"><input name="age" value="<%=strAge%>" readonly  type="text" class="textBoxCss" size="24" disabled="disabled" /></td>
							</tr>
							<tr>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage) %></td>
								<td height="25" valign="bottom" class="label2">
								<!-- added by manoj chand on 01 aug 2012 to show cost centre for SMP division -->
                    <% if(strAppLvl3flg.trim().equalsIgnoreCase("Y") && strShowflag.equalsIgnoreCase("y")) {
                    %>
                    <%= dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %><span class="starcolour">*</span>                  
                    <%}else{ %>
                    &nbsp;
                    <%} %>
								</td>
							</tr>
							<tr>

								<td height="30" valign="top" class="label2"><input name="phoneNo" type="text"  value="<%= strPhone%>"  class="textBoxCss" size="12"  onKeyUp="return test1('phoneNo', 19, 'phone')"/></td>
								<td height="30" valign="top" class="label2">
								<!-- cost centre drop down added by manoj chand on 01 august 2012 -->
                        <%
                        if(strAppLvl3flg.trim().equalsIgnoreCase("Y") && strShowflag.equalsIgnoreCase("y")){
                        %>
                        <span class="label2">
                          <select name="costcentre"  class="textBoxCss">
                          <option value="0"><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage) %></option>
<% 								
                             strSql =   "SELECT CC_ID,CC_CODE+' - '+CC_DESC+'' AS CC_CODE FROM M_COST_CENTRE WHERE SITE_ID="+strSiteId+" AND M_COST_CENTRE.STATUS_ID=10 ORDER BY CC_CODE";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
%>
                              <option value="<%=rs.getString("CC_ID")%>"><%=rs.getString("CC_CODE")%></option>
<%
                         	 }
                             rs.close();	  
%>
                          </select>
                          <script language="javascript">
                            document.frm.costcentre.value="<%=strCostCentre%>";
                          </script>
                        </span>
                        <%}else{ %>
                        &nbsp;
                        <%} %>
								</td>
							</tr>
							<tr>
							  <td height="25" colspan="2" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.createrequest.frequentflyerdetails",strsesLanguage) %></span></td>
						  </tr>
							<tr>
							  <td height="25" colspan="2" valign="bottom"><table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td align="left" scope="row"  class="label2">&nbsp;</td>
                                  <td align="left"  class="label2">&nbsp;</td>
                                </tr>
                                <tr>
                                   <td align="left" scope="row"  class="label2"><%=dbLabelBean.getLabel("label.global.airlinename",strsesLanguage)%> </td>
                                  <td align="left"  class="label2"><%=dbLabelBean.getLabel("label.createrequest.airlinenumber",strsesLanguage)%> </td>
                                </tr>
                                <tr>
                                  <th align="left" scope="row"><span class="label2">
                                    <input name="airLineName" type="text" value="<%=strAirLineName%>" class="textBoxCss" size="12" onKeyUp="return test1('airLineName', 20, 'c')"/>                            
                                  </span></th>
                                  <td align="left"><span class="label2">
									<input name="FFNo" type="text" value="<%= strFFNo%>" class="textBoxCss" size="12" onKeyUp="return test1('FFNo', 20, 'cn')"/>
                                  </span></td>
                                </tr>
                                <tr>
                                  <th align="left" scope="row"><span class="label2">
                                    <input name="airLineName1" type="text" value="<%=strAirLineName1%>" class="textBoxCss" size="12" onKeyUp="return test1('airLineName1', 20, 'c')"/>                                   
                                  </span></th>
                                  <td align="left"><span class="label2">
									 <input name="FFNo1" type="text" class="textBoxCss"  value="<%= strFFNo1%>" size="12" onKeyUp="return test1('FFNo1', 20, 'cn')"/>
                                  </span></td>
                                </tr>
                                <tr>
                                  <th align="left" scope="row"><span class="label2">
                                    <input name="airLineName2" type="text" value="<%=strAirLineName2%>" class="textBoxCss" size="12" onKeyUp="return test1('airLineName1', 20, 'c')"/>
                                  </span></th>
                                  <td align="left"><span class="label2">
                                    <input name="FFNo2" type="text"  value="<%= strFFNo2%>" class="textBoxCss" size="12" onKeyUp="return test1('FFNo2', 20, 'cn')"/>
                                  </span></td>
                                </tr>
                              </table></td>
						  </tr>
							
							<tr>
								<td height="25" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></span></td>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.mealpreference",strsesLanguage)%></td>
							</tr>
							<tr>
                      <td height="30" valign="top">
		    		   <!-- <input name="sex" type="radio" value="1" /><span class="label2">Male 
					   <input name="sex" type="radio" value="2" />Female</span>-->
					   <!--@Gaurav  Introduced for the Gender, this code is compatible to the previous options where User has not 
					   entered the gender i.e GENDER =null-->
		    		     <%
						if(strGender!=null){
								if(strGender.equals("Male")  ){%>
									<input name="sex" type="radio" value="1" checked disabled/><span class="label2"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%> 	
									<input name="sex" type="radio" value="2" disabled/><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></span>
									<% strSex= "1"; %>
							  <%}else{%>
									<input name="sex" type="radio" value="1" disabled /><span class="label2"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%> 	
									<input name="sex" type="radio" value="2" checked disabled/><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></span>
									<% strSex= "2"; %>
								<%}
					  }else{%>
						  <input name="sex" type="radio" value="1" checked /><span class="label2"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%> 	
						  <input name="sex" type="radio" value="2" /><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></span>						  
						 <% strSex= "1"; %>
					  <%}%>		
						  
					  <!--End Code-->
				
						<!-- <script language="JavaScript">
						document.frm.sex.value = "<%= strSex%>";
						if (document.frm.sex.value == 1) {
							 document.frm.sex[0].checked = true;
						 } else if (document.frm.sex.value == 2) {
							 document.frm.sex[1].checked = true;
						 }
						</script> -->		
						<script language="javascript">
                            var aa ="<%=strSex%>";
							if(aa != null && aa == "2")
							{
							   document.frm.sex[1].checked=true;
							}
							if(aa != null && aa == "1")
							{
							   document.frm.sex[0].checked=true;
							}
                       </script>   
					   </td>

							<td height="30" valign="top"><span class="label2"> 
							<select name="meal" class="textBoxCss">
						<%
                     		//For Population of Meal Combo 
                             strSql =   "SELECT MEAL_ID, MEAL_NAME FROM M_MEAL (NOLOCK) WHERE TRAVEL_AGENCY_ID = 1 AND AND STATUS_ID =10 ORDER BY MEAL_ID";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
						%>
                              <option value="<%=rs.getString("MEAL_ID")%>"><%=rs.getString("MEAL_NAME")%></option>
						<%
                         	 }
                             rs.close();	  
						%>
								</select> </span></td>
                          <script language="javascript">
                            document.frm.meal.value="<%=strMealId%>";
                          </script>
							</tr>
                             <!-- 14-02-2007 open by shiv -->

							<tr>
							  <td class="label2"><%=dbLabelBean.getLabel("label.global.proofofidentity",strsesLanguage)%><span class="starcolour">*</span></td>  <td class="label2"><%=dbLabelBean.getLabel("label.createrequest.identityproofnumber",strsesLanguage)%><span class="starcolour">*</span> </td>
							  </tr>
							  <tr>
							  <td>
							  
								<!-- added new on 10/18/2007 by shiv   -->
								<select name="identityProof" class="textBoxCss">
										<option value="-1"> <%=dbLabelBean.getLabel("label.createrequest.proofofidentity",strsesLanguage)%></option>
										<%	
											strSql = "SELECT IDENTITY_ID, IDENTITY_NAME FROM m_IDENTITY_PROOF (NOLOCK) WHERE STATUS_ID=10 ORDER BY ORDER_ID ";
												rs = dbConBean.executeQuery(strSql); 
															while(rs.next()) 
													{ 
												%>
														<option value = <%=rs.getString(1)%> > <%= rs.getString(2)%></option>
												<%
													}
									rs.close();
										%>
							</select>

								<!-- close 10/18/2007   -->
							   <script language="javascript">
							      //alert('<%=strIdentityProof%>');
										document.frm.identityProof.value="<%=strIdentityProof%>";
                                </script>
						  </td>
						  <td>
						  
						  <input type='text' name='identityProofno' value="<%=strIdentityProofNo%>"  class="textBoxCss" onKeyUp="return test1('identityProofno', 30, 'all')"/>
						  <script language="javascript">
								document.frm.identityProofno.value="<%=strIdentityProofNo%>";
                          </script>
						     <!-- 14-02-2007 closed by shiv -->
						  <tr>

						  <td height="30" colspan="4" valign="top"><span class="formtxt2"><%=dbLabelBean.getLabel("label.createrequestl.mandatorytocarrythesameatthetimeoftravel",strsesLanguage)%></span></td>
							</tr>
						</table>
						</td>

						<td width="49%" height="34" align="left" valign="top" bgcolor="#FFFFFF" style="padding-right: 5px;padding-left: 5px; border-bottom: #F0F0F0 1px solid;">
						<table width="100%" border="0" cellspacing="3" cellpadding="0">
							<tr>
								<td height="30" width="100%" colspan="4" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.additinerary",strsesLanguage)%></td>
							</tr>
							<tr>
								<td height="30" width="100%" colspan="4" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.forwardjourney",strsesLanguage)%> <span class="starcolour">*</span></td></tr>
							<tr>
								<td width="27%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)%></td>
								<td width="27%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)%></td>
							    <td width="22%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)%>  <br></td><!-- 2/26/2007 -->
								<td width="22%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage)%></td>							
							</tr>
							<tr>
								<td height="30" valign="top" width="25%">
								<input name="departCity" type="text" class="textBoxCss" size="16" onKeyUp="return test1('departCity', 20, 'c')"/> 
			                        	<script language="javascript">
			                            document.frm.departCity.value="<%=strDepartCity%>";
			                          	</script>
			                     </td>
								<td height="30" valign="top" width="25%"><span class="label2"> <input name="arrivalCity" type="text" class="textBoxCss" size="16" value="<%= strArrivalCity %>" onKeyUp="return test1('arrivalCity', 30, 'c')"/>
								</span>
								</td>

								

								<td valign="top" width="25%"><input name="departDate" type="text" class="textBoxCss" id="test2" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.departDate','a','a','DD/MM/YYYY');"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img border="0"
									name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
                                  <script language="javascript">
                            document.frm.departDate.value= "<%=strDepartDate%>";
                                  </script></td>
                                  <td width="25%" valign="top"><select name="departTime" class="textBoxCss">
                                  <%
                     //For Population of Prefer Timing Combo 
                             strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
						%>
                                  <option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
                                  <%
                         	 }
                             rs.close();	  
						%>
                                </select></td>
                        <script language="javascript"> 
                            document.frm.departTime.value="<%=strDepartTime%>";
                          </script>
							</tr> 
							<tr>
							    <td height="25" width="25%" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage)%></span></td> 
								<td height="25" width="25%" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab",strsesLanguage)%></td>
								<td height="25" width="25%" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage)%></td>
								<td height="25" width="25%" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage)%>&nbsp;</td> 
							</tr>
							<tr>
							    <td valign="top" width="25%">
							    <select name="departMode" class="textBoxCss" onChange="getUserID2();">
							    <%--ADDED BY MANOJ CHAND ON 24 JAN 2013 TO FETCH TRAVEL MODE FROM TABLE --%>
							    <%
							    strSql =   "SELECT TRIP_ID,TRIP_TYPE FROM dbo.M_TRAVEL_MODE WHERE dbo.M_TRAVEL_MODE.STATUS_ID=10 AND dbo.M_TRAVEL_MODE.TRAVEL_AGENCY_ID = 1 AND dbo.M_TRAVEL_MODE.TRV_TYPE='D'";
							    rs=null;
	                             rs       =   dbConBean.executeQuery(strSql);
	                             while(rs.next())
	                             {
							    %>
							    <option  value ="<%=rs.getString("TRIP_ID") %>"><%=rs.getString("TRIP_TYPE")%></option>
								<%
		                         	 }
		                             rs.close();	  
								%>
						<script language="javascript">
			                document.frm.departMode.value= "<%=strDepartMode%>";
            			</script> </select></td>
								<td valign="top" ><span class="label2" width="25%">
	                            <!--@ Vijay Singh 23/03/2007 Increase the size of text field -->
								  <input name="departAirLineName" type="text" class="textBoxCss" size="16" value="<%= strDepartAirLineName %>" onKeyUp="return test1('departAirLineName', 25, 'cn')"/>
								</span></td>
					<td height="30" width="25%" colspan="1" valign="top" class="label2"> 
								<select name="departClass" class="textBoxCss">
						<% 	
						//change query by manoj chand on 24 jan 2013 to populate travel class combobox from one common class table rather than individual table
		                    strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='"+strDepartMode+"' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10";
							rs = dbConBean.executeQuery(strSql);
							while (rs.next()) {
						
								%>
                                 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
								<%
                           }
		                      rs.close();	  
						%>	
						<script language="javascript">
			                document.frm.departClass.value= "<%=strDepartClass%>"; 
            			</script> 
    							</select> &nbsp;&nbsp;</td>
    							
								<!--  added new for preeffered seat for forward journey on 09 jan 2009   -->
								
					<td height="30" width="25%"  valign="top" align="left" > 
								<select name="prefferedSeatFwd" class="textBoxCss">  
						<%  
						strSql =   "SELECT seat_id, Seat_Name	FROM M_SEAT_PREFER  (NOLOCK) WHERE  (Mode_id = '"+strDepartMode+"') AND (TRAVEL_AGENCY_ID = 1) and   (STATUS_ID = 10)"; 
								rs = dbConBean.executeQuery(strSql);
								while (rs.next()) {
						%>
	                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
						<%
                           }  
		                      rs.close();	  
						%>	
						<script language="javascript">
			                document.frm.prefferedSeatFwd.value= "<%=strSeatpreffer%>";
            			</script> 
								</select>
								
								</td>
								 
	    				</tr>
					<tr> 
						
						  <td height="30" width="25%" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage)%></td>
						  
						  <td height="30" width="50%"  colspan="2" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.couponticketrequired",strsesLanguage)%></td>
						  <td nowrap="nowrap" height="30" width="25%"  colspan="1" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%> </td> 
					    </tr>
						<tr>

						<% //Added by Rajeev Dubey on 17 Feb 2007
							if(strDepartMode.equals("2")){%>
						  <td height="30" width="25%" valign="top" class="label2"><!--FOR TATKAAL REQUIRED -->
						    <input name="forTatkaalRequired" type="radio" value="1"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
						    <input name="forTatkaalRequired" type="radio" checked value="0"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %> </td>
						
						 <%}else{%>
						 <td height="30" width="25%" valign="top" class="label2"><!--FOR TATKAAL REQUIRED -->
						    <input name="forTatkaalRequired" type="radio" disabled  value="1"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
						    <input name="forTatkaalRequired" type="radio" disabled checked value="0"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %></td>
						
						<%}%>
						<script language="JavaScript">
							var aa = "<%= strForTatkaalRequired%>";
							if (aa == "1") {							 
								 document.frm.forTatkaalRequired[0].checked = true;
							 } else if (aa == "0") {
								document.frm.forTatkaalRequired[1].checked = true;
							 }
						</script>
						
						<td height="30" width="50%" colspan="2" valign="top" class="label2"><!--FOR COUPAN REQUIRED -->						    <span class="label2">
						    <input name="forCoupanRequired" type="radio" value="1"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
                            <input name="forCoupanRequired" type="radio" checked value="0"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %></span></td>
							<!-- //Added by Rajeev Dubey on 17 Feb 2007 -->
						  <script language="JavaScript">
							var aa = "<%= strForCoupanRequired%>";
							if (aa == "1") {
								 document.frm.forCoupanRequired[0].checked = true;
							 } else if (aa == "0") {
								 document.frm.forCoupanRequired[1].checked = true;
							 }
						</script>	
						<!-- // -->
						<td height="30" width="75%" colspan="3" valign="top" class="label2"><!--FOR COUPAN REQUIRED -->						    <span class="label2">
						    <input name="ticketRefundfwd" type="radio" value="y"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
                            <input name="ticketRefundfwd" type="radio" checked value="n"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %> </span></td>
							<!-- //Added by Rajeev Dubey on 17 Feb 2007 -->
						  <script language="JavaScript">
							var aa = "<%= strTicketRefundfwd%>";
							if (aa == "y") {
								 document.frm.ticketRefundfwd[0].checked = true;
							 } else if (aa == "n") {
								 document.frm.ticketRefundfwd[1].checked = true;
							 }
						</script>	
						</tr>
						<!--Return Journey-->
						<tr>
						<td height="30" width="100%" colspan="4" valign="bottom" class="label1"><%=dbLabelBean.getLabel("label.global.returnjourney",strsesLanguage) %>
						</td>
						</tr>
						<tr>
						        <td width="25%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departurecity",strsesLanguage) %></td>
								<td width="25%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage) %></td>
						        <td width="25%" height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.departuredate",strsesLanguage) %> <br></td>
								<td width="25%" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredtime",strsesLanguage) %></td>								
							</tr>
							<tr>
							    <td height="30" valign="top" width="25%"><input name="departCity1" type="text" class="textBoxCss" size="16" onKeyUp="return test1('departCity1', 20, 'c')"/> 
                        	<script language="javascript">
                            document.frm.departCity1.value="<%=strDepartCity1%>";
                          	</script>								</td>
								<td height="30" width="25%" valign="top"><span class="label2"> <input name="arrivalCity1" type="text" class="textBoxCss" size="16" value="<%= strArrivalCity1 %>" onKeyUp="return test1('arrivalCity1', 20, 'c')"/>
								</span></td>
								<td width="25%" valign="top"><input name="returnDate" type="text"class="textBoxCss" id="test22" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'"
									onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"><a href="javascript:show_calendar('frm.returnDate','a','a','DD/MM/YYYY');"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img border="0"
									name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
			                       <script language="javascript">
			                            document.frm.returnDate.value = "<%= strReturnDate %>";
			                       </script>								</td>
								
								<td width="25%" valign="top"><select name="arrivalTime" class="textBoxCss">
							<%
                        //For Population of Prefer Timing Combo 
                             strSql =   "SELECT TIME_ID, PREFER_TIME FROM M_PREFER_TIME (NOLOCK) WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY DISPLAY_ORDER ASC";
                             rs       =   dbConBean.executeQuery(strSql);  
                             while(rs.next())
                             {
							%>
                              <option value="<%=rs.getString("TIME_ID")%>"><%=rs.getString("PREFER_TIME")%></option>
							<%
                         	 }
                             rs.close();	  
							%>
                        <script language="javascript">
                            document.frm.arrivalTime.value="<%=strArrivalTime.trim() %>"; 
                          </script>

								</select></td>
								</tr>
							<tr>
								<td width="25%"height="25" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.mode",strsesLanguage) %></span></td>
								<td width="25%" height="25" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.preferredairlinetraincab",strsesLanguage) %></span></td>
								<td width="25%" height="24" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.class",strsesLanguage) %></td>
								<td width="25%" valign="bottom"   class="label2" class="label2"><%=dbLabelBean.getLabel("label.global.preferredseat",strsesLanguage) %>&nbsp;</td> 
							</tr>
							<tr>
							    <td valign="top" width="25%">
							      <select name="arrivalMode" class="textBoxCss" onChange="getUserID2();">
							      <%--ADDED BY MANOJ CHAND ON 24 JAN 2013 TO FETCH TRAVEL MODE FROM TABLE --%>
							      <%
							      	 rs=null;
		                             strSql =  "SELECT TRIP_ID,TRIP_TYPE FROM dbo.M_TRAVEL_MODE WHERE dbo.M_TRAVEL_MODE.STATUS_ID=10 AND dbo.M_TRAVEL_MODE.TRAVEL_AGENCY_ID = 1 AND dbo.M_TRAVEL_MODE.TRV_TYPE='D'";
		                             rs       =   dbConBean.executeQuery(strSql);  
		                             while(rs.next())
		                             {
								%>
											<option  value ="<%=rs.getString("TRIP_ID") %>"><%=rs.getString("TRIP_TYPE") %></option>
								<%} rs.close(); %>	
											<script language="javascript">
								                document.frm.arrivalMode.value= "<%=strArrivalMode%>";
					            			</script> 
								   </select>
						     	</td>
							<%  
								if (strArrivalAirLineName != null)
									strArrivalAirLineName = strArrivalAirLineName.trim();
							%><!-- Code added for allowing the character & numeric in preferred Airline on 4th Jan 2008 by shiv sharma  -->
								<td height="30" width="25%" valign="top"><span class="label2"> <input name="arrivalAirLineName" type="text" class="textBoxCss" size="16" value="<%= strArrivalAirLineName %>" onKeyUp="return test1('arrivalAirLineName', 16, 'cn')"/>
								</span></td>                                                                             
								<td height="30" width="25%"  valign="top" align="left"><!--  preffered seat   --> 
								<select name="arrivalClass" class="textBoxCss">
									<% 						
						                    strSql =   "SELECT CLASS_ID,ELIGIBILITY from dbo.M_MODE_CLASS mmc WHERE mmc.MODE_ID='"+strArrivalMode+"' AND mmc.TRAVEL_AGENCY_ID = 1 AND mmc.STATUS_ID=10";
											rs = dbConBean.executeQuery(strSql);
											while (rs.next()) {
									%>
				                             <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
									<%
			                           }
					                      rs.close();	  
									%>	
									<script language="javascript">
			                document.frm.arrivalClass.value= "<%=strArrivalClass%>";
            			</script> 
								</select> </td> 
								<!-- added seat prefference    -->
							<td height="30" width="25%" valign="top"> 
										<select name="prefferedSeatRet" class="textBoxCss"> 
											<%  
													strSql =   "SELECT seat_id, Seat_Name FROM M_SEAT_PREFER (NOLOCK) WHERE  (Mode_id = '"+strArrivalMode+"') AND (TRAVEL_AGENCY_ID = 1) and   (STATUS_ID = 10)"; 
													rs = dbConBean.executeQuery(strSql);
													while (rs.next()) { 
									                    %>
	                                                    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
					             	 					<%
                                                     } 
		                      				     rs.close();	  
										    %>	
											<script language="javascript">
								                  document.frm.prefferedSeatRet.value="<%=strSeatprefferRet%>";
					            			</script> 
								</select>
								
								</td>
							</tr>
							<tr>
							
							<td height="30" width="25%" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.tatkaalrequired",strsesLanguage)%></td>
						  
						   <td height="30" width="50%"  colspan="2" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.createrequest.couponticketrequired",strsesLanguage)%></td>
						  <td height="30" width="25%"   colspan="1" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.nonrefundableticket",strsesLanguage)%></td> 
							</tr>
							<tr>
							<% //Added by Rajeev Dubey on 17 Feb 2007

							if(strArrivalMode.equals("2")){%>
							  <td height="30" width="25%" valign="top" class="label2"><!--RET TATKAAL REQUIRED -->
								<input name="retTatkaalRequired" type="radio" value="1"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
								<input name="retTatkaalRequired" type="radio" checked value="0"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %> </td>

							  <%}else{%>
							  <td height="30" width="25%" valign="top" class="label2"><!--RET TATKAAL REQUIRED -->
								<input name="retTatkaalRequired" type="radio" disabled value="1"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
							  	<input name="retTatkaalRequired" type="radio"  disabled checked value="0"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %> </td>
								<%}
								//
								%>
							  <script>
                                //alert("<%=strRetTatkaalRequired%>");  
								var aa = "<%= strRetTatkaalRequired%>";
								if (aa == "1") {
									//alert("yes selected ret");
									 document.frm.retTatkaalRequired[0].checked = true;
								 } else if (aa == "0") {
									// alert("no selected ret");
									 document.frm.retTatkaalRequired[1].checked = true;
								 }
								 else
								 {}
								</script>
							  <td height="30" width="50%"  colspan="2" valign="top" class="label2"><!--RET COUPAN REQUIRED -->
								<input name="retCoupanRequired" type="radio"  value="1"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %><input name="retCoupanRequired" type="radio" checked value="0"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %> </td>
							  <script language="JavaScript">
								var aa = "<%= strRetCoupanRequired%>"; 
								if (aa == "1") {
									 document.frm.retCoupanRequired[0].checked = true;
								 } else if (aa == "0") {
									 document.frm.retCoupanRequired[1].checked = true;
								 }
								</script> 
								
						<!--  added new refundable ticket on 08 jan 2009  --> 		
					  <td height="30" width="25%" colspan="1" valign="top" class="label2"><!--FOR COUPAN REQUIRED -->						    <span class="label2">
						    <input name="ticketRefundrtd" type="radio" value="y"/><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage) %>
                            <input name="ticketRefundrtd" type="radio" checked value="n"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage) %> </span></td>
							<!-- //Added by Rajeev Dubey on 17 Feb 2007 -->
						  <script language="JavaScript">
							var aa = "<%= strTicketRefundrtd%>"; 
							if (aa == "y") {
								 document.frm.ticketRefundrtd[0].checked = true;
							 } else if (aa == "n") {
								 document.frm.ticketRefundrtd[1].checked = true;
							 }
						</script>	
			</tr>
			<tr>
							  <td height="30" width="25%" valign="top">&nbsp;</td>
                              <td height="30" width="25%" valign="top">&nbsp;</td>
                              <td height="30" width="50%" colspan="2" valign="top">&nbsp;</td>
						    </tr>
						    <tr><td colspan="4" width="100%"><a href="#"onClick="MM_openBrWindow()"><img src="images/InterimJourney.gif?buildstamp=2_0_0"
									 align="top" border="0" /></a></td></tr>
									 <tr>
								<td height="30" width="100%" colspan="4" valign="top"><span class="formtxt2"><%=dbLabelBean.getLabel("label.createrequest.requireinterimflightsortrainspecifyit",strsesLanguage) %></span></td>
							</tr>
							<tr>
							  <td height="25" width="50%" colspan="2" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage) %>&nbsp;&nbsp;</span></td>
						  	  <td height="25" width="50%" align="left" valign="bottom" colspan="2"><span class="label2">&nbsp;&nbsp;&nbsp;</span></td>
							</tr>
							<tr>
						      <td align="left" width="50%" valign="top" colspan="2"><span class="label2"><!-- Reason for Travel -->
							    <textarea name="reasonForTravel" cols="18" rows="2"  onKeyUp="return test1('reasonForTravel', 200, 'all')"><%= strReasonForTravel%></textarea>
							    </span>
							  </td>
							  <td height="25" width="50%" colspan="2" align="left" valign="bottom"><span class="label2">&nbsp;&nbsp;&nbsp;</span></td>
						    </tr>
						</table>
							

						</td>
					</tr>
					<tr>
					  <td height="34" align="left" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
					    <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
						  <tr>
						    <td height="30" colspan="3"><span class="label1"><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel",strsesLanguage) %></span><span class="starcolour">*</span></td>
						  </tr>
						  
						
						  
 						  <tr>
 						  <input type="hidden" name="hid_UnitHeadFlag" value="<%=strUnit_Head %>">
						    <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage) %>&nbsp;&nbsp;</span></td>
						  	<td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage) %>&nbsp;&nbsp;&nbsp;</span></td>
						  </tr>
						  <tr>
						    <td height="30" align="left" valign="top">


								<!--
								
								// CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
								// CALL FUNCTION FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA 
								// ADD ONE FUNCTION ON "onChange" event in "manager" FIELD i.e skipDisabled(this.form)
								
								-->

							  <select name="manager" id="firstapprover" class="textBoxCss" onChange="skipDisabled(this.form,'first');">
								<!--   MODIFICATION END -->
							   <option value = "-1" ><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel1",strsesLanguage) %></option>
							<%
								//AND USERID NOT IN(SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND STATUS_ID=10)
			                     //For Population of Manager Class Combo for the particular site
			                     //this query is commented by manoj chand on 31 May 2013
			                    //strSql = "Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
								//strSql = "Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 and userid not in ((SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND  sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1)) ORDER BY 2";
								//added by manoj chand on 31 May 2013 to add otherside user in approver level 1
								strSql="Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=1 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1	UNION	SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM	WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL1='Y' AND STATUS_ID=10	ORDER BY 2";
			     //   System.out.println("approver 1----->"+strSql);	   
							rs       =   dbConBean.executeQuery(strSql);  
								   while(rs.next())
			                       {
							%>
								   <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
							<%
								   }
								   rs.close();	
								   
							if(strTravelId !=null && strTravelId.equals("new")) {
							 	strSql="SELECT TOP 1 MANAGER_ID, HOD_ID, BOARD_MEMBER_ID FROM T_TRAVEL_DETAIL_DOM INNER JOIN T_TRAVEL_STATUS ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID=T_TRAVEL_STATUS.TRAVEL_ID AND TRAVEL_TYPE='D' AND T_TRAVEL_STATUS.TRAVEL_STATUS_ID = 10 WHERE TRAVELLER_ID = "+strUserId+" ORDER BY C_DATETIME DESC";
			                 	rs       =   dbConBean.executeQuery(strSql); 
			                 	if(rs.next()) {
			                	 	strManagerSelected = rs.getString("MANAGER_ID");
			                	 	strPHODSelected = rs.getString("HOD_ID");
			                	 	strBoardMemberSelected = rs.getString("BOARD_MEMBER_ID");
			                	 
			                  	}
			                 	rs.close();
							}
			                 
							if(strManager !=null && !strManager.equals("") && !strManager.equalsIgnoreCase("-1")){%>
								<script language="javascript">
		            				document.frm.manager.value= "<%=strManager%>";
			        			</script>  
				        	<%}
							else if (strManagerSelected == null || strManagerSelected.equals("")){%>
								<script language="javascript">
			            				document.frm.manager.value= "<%=strManager%>";
				        		</script>
							<%}
							else { %>
				        		<script language="javascript">
				        		var firstApprover = document.getElementById("firstapprover");
				        		var firstAppVal;
				        		var i;
				        		for (i = 0; i < firstApprover.length; i++) {
				        			firstAppVal = firstApprover.options[i].value;	                    	
				        			if(firstAppVal == <%=strManagerSelected%>){	                    		
				        				document.frm.manager.value= "<%=strManagerSelected%>";
				        				break;
				        			} else if(firstAppVal != <%=strManagerSelected%>){                    		
				        				document.frm.manager.value="-1";
				        			} 
				        		}
		            				
			        			</script>
				        			<%} %>
							  </select>
							</td>
							<td height="30" align="left" valign="top"><span class="label2">
	
<!--

// CHANGE BY SAMIR RANJAN PADHI ON (3/12/2007)
// CALL FUNCTION FOR DISABLE AND ENABLE THE "Reason for Skipping " TEXTAREA 
// ADD ONE FUNCTION ON "onChange" event in "manager" FIELD i.e skipDisabled(this.form)

-->
							  
							  <select name="hod" id="secondapprover" class="textBoxCss" onChange="skipDisabled(this.form,'second');">
							<!--   MODIFICATION END -->
						    <option value="-1" ><%=dbLabelBean.getLabel("label.createrequest.selectapprovallevel2",strsesLanguage) %></option>
							<%
			                   //For Population of HOD Class Combo for the particular site
			               /* strSql = "Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+" AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
							System.out.println("strSql====123--->"+strSql);
			         		    rs       =   dbConBean.executeQuery(strSql);  
			                    while(rs.next())
			                    {*/
							%>
							   <%--  <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>--%>
							<%
			                  /*  }
			                    rs.close();	  
							    //ADD GLOBAL APPROVER		
							    strSql =   "Select USERID, dbo.user_name(USERID)AS HOD FROM M_USERINFO  (NOLOCK) WHERE APPROVER_LEVEL=3 AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
							    System.out.println("strSql====456--->"+strSql);*/
							    //added by manoj
							    //add both gloabal approvers and corresponding approvers to site.
							    //this query is commented by manoj chand on 31 May 2013
				//strSql="Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";
							   // strSql="Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 and userid not in ((SELECT APPROVER_ID FROM M_DEFAULT_APPROVERS WHERE SITE_ID="+strSiteId+" AND TRV_TYPE='D' AND  sp_role="+SSstrSplRole+" AND STATUS_ID=10 AND APPLICATION_ID=1)) ORDER BY 2";
							   //added by manoj chand on 31 May 2013 to add otherside user in approver level 2
				strSql="Select USERID, dbo.user_name(USERID)AS PM FROM M_USERINFO (NOLOCK) WHERE ((APPROVER_LEVEL=2 AND SITE_ID="+strSiteId+") or (APPROVER_LEVEL=3)) AND STATUS_ID=10 AND APPLICATION_ID=1 UNION SELECT UAM.USERID,dbo.user_name(UAM.USERID)AS PM  FROM USER_MULTIPLE_ACCESS UAM WHERE SITE_ID="+strSiteId+" AND APPROVAL_LVL2='Y' AND STATUS_ID=10 ORDER BY 2";
				//System.out.println("approver 2----->"+strSql);
         					    rs       =   dbConBean.executeQuery(strSql);  
							    while(rs.next())
			                    {
							%>	
			                     <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
							<%
			                    }
						        rs.close();							
						        if(strPHOD !=null && !strPHOD.equals("") && !strPHOD.equalsIgnoreCase("-1")){%>
								    <script language="javascript"> 
			                	    	document.frm.hod.value= "<%=strPHOD%>";
				            	    </script> 
			            	    <%}
						        else if(strPHODSelected == null || strPHODSelected.equals("")){%>
							        <script language="javascript"> 
			                	    	document.frm.hod.value= "<%=strPHOD%>";
				            	    </script> 
						        <%}
								else { %>
					        		<script language="javascript">
					        		var secondApprover = document.getElementById("secondapprover");
					        		var secondAppVal;
					        		var i;
					        		for (i = 0; i < secondApprover.length; i++) {
					        			secondAppVal = secondApprover.options[i].value;	                    	
					        			if(secondAppVal == <%=strPHODSelected%>){	                    		
					        				document.frm.hod.value= "<%=strPHODSelected%>";
					        				break;
					        			} else if(secondAppVal != <%=strPHODSelected%>){                    		
					        				document.frm.hod.value="-1";
					        			} 
					        		}
				            			
					        		</script>
					        			<%} %> 
								   </select>
							</td>
						  </tr>
						 
						  <tr>
							  <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.reasonforskipping",strsesLanguage) %></span></td>
							  <% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>	
							  <td height="25" align="left" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.boardmember",strsesLanguage) %></span></td>
							  <%} %>
						  </tr>		  
						  <tr> 
 						 <td>
							    <textarea  name="reasonForSkip" disabled onKeyUp="return test1('reasonForSkip', 200, 'all')" maxlength="200" rows="4" cols="20"><%=strReasonForSkip%></textarea>&nbsp;&nbsp;
							    </td>
							   
								<% if(!strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
								<td style="padding-left:20px">
								<span class="label2"><a href="#" onClick="return defaultApproverList(this.form);"><%=dbLabelBean.getLabel("link.global.viewallapprovers",strsesLanguage) %></a></span>
								</td>
								<%} %>
								<% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>		
				<td height="30" align="left" valign="top">
				<select name="boardmember" id="thirdapprover" class="textBoxCss" onChange="skipDisabled(this.form,'third');">
				<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectboardmember",strsesLanguage) %></option>
				<option value="-2"><%=dbLabelBean.getLabel("label.global.notapplicable",strsesLanguage)%></option> 
<%  
		//For Population of Board Members for SMP DIVISION 
                 strSql = "SELECT USERID, DBO.user_name(USERID) AS BM FROM M_BOARD_MEMBER WHERE M_BOARD_MEMBER.SITE_ID="+strSiteId+" AND M_BOARD_MEMBER.STATUS_ID=10";
         		 rs       =   dbConBean.executeQuery(strSql);  
                       while(rs.next())
                       {
%>
                       <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%
                       }
                       rs.close();
%>
                  </select>
                 <% if(strBoardMember !=null && !strBoardMember.equals("") && !strBoardMember.equalsIgnoreCase("-1")){%>
						<script language="javascript">
						document.frm.boardmember.value="<%=strBoardMember%>";
	        			</script>  
	        	<%}
                 else if (strBoardMemberSelected == null || strBoardMemberSelected.equals("")){%>
                 	<script language="javascript">
						document.frm.boardmember.value="<%=strBoardMember%>";
	        		</script> 
                <%}
				else { %>
	        		<script language="javascript">
	        		var thirdApprover = document.getElementById("thirdapprover");
	        		var thirdAppVal;
	        		var i;
	        		for (i = 0; i < thirdApprover.length; i++) {
	        			thirdAppVal = thirdApprover.options[i].value;	                    	
	        			if(thirdAppVal == <%=strBoardMemberSelected%>){	                    		
	        				document.frm.boardmember.value="<%=strBoardMemberSelected%>";
	        				break;
	        			} else if(thirdAppVal != <%=strBoardMemberSelected%>){                    		
	        				document.frm.boardmember.value="-1";
	        			} 
	        		}
	        		    
	        		</script>
	        		<%} %>                 
				</td> 
				<%} %>
						</tr>
						<!-- added by Manoj Chand on 27 March 2012 to add board member combobox for smp sites -->
			  <% if(strAppLvl3flgforBM.trim().equalsIgnoreCase("Y")) {%>
              <tr>
              <td style="padding-left:20px"><span class="label2"><a href="#" onClick="return defaultApproverList(this.form);"><%=dbLabelBean.getLabel("link.global.viewallapprovers",strsesLanguage) %></a></span></td>
              <td>&nbsp;</td>
              </tr>
              <%} %>
						
				<!-- End here -->		

							<tr>
								<td height="2" align="left"><span class="label2" style="display:none"> 
								<input name="selectManger" type="radio" value="manual"  checked="checked" onClick="approverSelection();"/> <%=dbLabelBean.getLabel("label.createrequest.selectmanually",strsesLanguage) %></span></td>
								<td height="2" align="left" class="label2">&nbsp;</td> 
							</tr> 
							<tr>
								<td height="5" align="left" valign="top"> 
								<span style="display:none"><input name="selectManger" type="radio" value="automatic" onClick="approverSelection();"/></span>
								<span class="menu"><span class="label2" style="display:none"><%=dbLabelBean.getLabel("label.createrequest.automaticselection",strsesLanguage)%> </span></span></td>
								<td height="2" align="left" valign="top">&nbsp;</td>
								<script language="javascript">
									var sel = "<%=strSelectManger%>";						
									if(sel != null && sel == "automatic")
									{				
									   document.frm.selectManger[1].checked=true;	
									   document.frm.manager.disabled = true;
									   document.frm.hod.disabled = true;
									}
									if(sel != null && sel == "skip")
									{
									   document.frm.manager.disabled = true;
									   document.frm.hod.disabled = true;
									   //document.frm.skip11.disabled = true;
									   //document.frm.unskip11.disabled = false;
									   document.frm.reasonForSkip.disabled = false;					   
									}
									if(sel != null && sel == "manual")
									{
									   document.frm.manager.disabled = false;
									   document.frm.hod.disabled = false;
									   //document.frm.skip11.disabled = false;
									   //document.frm.unskip11.disabled = true;
									   document.frm.reasonForSkip.disabled = false;					   
									}
								</script> 
							</tr> 
							 
						</table>
						</td>
						
						<td height="34" align="left" valign="top" bgcolor="#FFFFFF"	style="padding-right: 5px;padding-left: 5px; border-bottom: #F0F0F0 1px solid;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"><!-- ACCOMMODATION REQUIRED --> 
							<tr>                                                                    
								<td height="30" colspan="4" class="label1"><%=dbLabelBean.getLabel("label.global.accomodationrequired",strsesLanguage) %><span class="starcolour">*</span></td>
							</tr>
							<tr>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.staytype",strsesLanguage) %></td>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.preferredplace",strsesLanguage) %></td>
								<td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.budget",strsesLanguage) %></td>
							</tr>
							<tr>
							<%//System.out.println(strTransitType +" strTransitType"); %>
								<td height="25" valign="top"><span class="label2"> 
								<select name="transit" class="textBoxCss" onChange="return transitOnClick(this.form);">
									<option value = "0"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage) %></option>
									<option value="1"><%=dbLabelBean.getLabel("label.global.hotel",strsesLanguage) %></option>
									<option value = "2"><%=dbLabelBean.getLabel("label.global.transithouse",strsesLanguage) %></option>
								<script language="javascript">
                				document.frm.transit.value= "<%=strTransitType%>";
		            			</script> 
								</select> 

								<td align="left" valign="top" class="label2">
								<select name="currency" class="textBoxCss"><!--BUDGET CURRENCY--> 
				<%
									 //For Population of Currenc Combo for the particular site
									   strSql =   "Select Currency, Currency from m_currency where status_id=10";
									   rs       =   dbConBean.executeQuery(strSql);  
									   while(rs.next())
									   {                       
				%>
										  <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
				<%
									   }
									   rs.close();	 					 
				%>
								 </select>
								 <script language="javascript">
									   document.frm.currency.value="<%=strBudgetCurrency%>"; 
								 </script>								</td>

								<td align="left" valign="top" class="label2"> <!-- PLACE -->
								  <input name="place" type="text" value="<%=strPlace%>" size="10" onKeyUp="return test1('place', 20, 'c')"/>	
								  <script language="javascript">
									   document.frm.place.value="<%=strPlace%>"; 
								 </script>	</td>

							  <td><span class="label2">
							    <input name="budget" type="text" value="<%= strBudget %>" size="5" onKeyUp="return test1('budget', 12, 'n')"/>
							  </span></td>  
  						</tr>
  						
  						 <!-- Transit house message added by manoj chand on 24 april 2012 -->
						 <tr id="hidethis" style="display: none;">
						 	<td colspan="4" class="formtxt2"><span style="color: red;"><%=dbLabelBean.getLabel("label.global.smokingmessage",strsesLanguage) %></span></td>
						 </tr>
  						
  						
							<tr>
							  <td height="25" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.checkindate",strsesLanguage) %></td>
							  <td height="25" colspan="1" align="left" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.checkoutdate",strsesLanguage) %></td>
								 <td height="25" colspan="2" align="left" valign="bottom"  class="label2""><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage) %>  </td>
							 <!--  <td height="25" colspan="2" align="left" valign="bottom"  class="style1">Remarks for other services</td> -->
							</tr>
							<tr>                                                              <!--CHECK_IN AND CHECK_OUT DATE-->
								<td height="30" valign="top"><input name="checkin" type="text" class="textBoxCss" id="test223" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'"
									onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
								<a href="javascript:show_calendar('frm.checkin','a','a','DD/MM/YYYY');"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img border="0"
									name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
                        <script language="javascript">
                            document.frm.checkin.value="<%=strCheckin%>";
                          </script>								</td>
								<td height="30" colspan="1" align="left" valign="top"><input name="checkout" type="text" class="textBoxCss" id="test224" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'"
									onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
									onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
								<a href="javascript:show_calendar('frm.checkout','a','a','DD/MM/YYYY');"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img border="0"
									name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a></td>

							  <td align="left" valign="top" colspan="2"><span class="label2"> 
								<textarea name="others"  class="style1" cols="18" rows="2"  onKeyUp="return test1('others', 100, 'all')" onblur="this.value=removeSpaces(this.value);"><%= strOthers%></textarea> </span></td>
							</tr>
							
							
							<tr>   
								<td height="10" colspan="4" valign="top">&nbsp;</td>
								 
							  <script language="javascript">
                            document.frm.checkout.value="<%=strCheckout%>";
                          </script>
							</tr>
							<tr> 
								<td  colspan="4" class="formtxt2"><%=dbLabelBean.getLabel("label.global.requirehotelthenspecifyhotelbudget",strsesLanguage)%></td>
							</tr> 

						<!-- JAVA SCRIPT for setting the Accomodation detail enable or disable according the transit type -->
						 <script language="javascript">
							  var aa ="<%=strTransitType%>";
							  if(aa != null && aa == "0") 
							  {
								   //alert("hotel value no is=="+aa);
								   document.frm.budget.disabled=true;
								   document.frm.place.disabled=true;
								   document.frm.currency.disabled=true;
								   document.frm.checkin.disabled=true;
								   document.frm.checkout.disabled=true;
							  }
						 </script>


						</table>


						</td>
					</tr>

  <tr>
            <td colspan="2" align="left" class="forminnerbrdff">  
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30" colspan="4" class="label1"><%=dbLabelBean.getLabel("label.global.creditcardinfo",strsesLanguage)%></td>
              </tr>
              <tr>
                <td width="12%" height="25" valign="bottom" class="label2" ><%=dbLabelBean.getLabel("label.global.cardtype",strsesLanguage)%> </td>
				<!-- 23/02/2007 -->
				<td width="26%" height="25" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.creditcardholder",strsesLanguage)%></span></td>
				
				<!-- 23/02/2007 -->
                <!-- <td width="26%" height="25" valign="bottom"><span class="label2">Credit Card Number </span></td>  -->
                <td width="46%" valign="bottom"><span class="label2"><%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%> </span></td>
                <td width="48%" valign="bottom"><span class="label2"><!--CVV Number--> </span></td>
              </tr>
              <tr>
                <%
				if(strCARD_TYPE==null || strCARD_TYPE=="")
				{
				strCARD_TYPE="-1";

				}
				%>
				<!-- add AMEX as a credit card type on 26 july 2012 by manoj chand -->
				<td height="30" valign="top" ><select name="CARD_TYPE" class="textBoxCss" onChange="return CreditCheck(frm);">
                   <option value = "-1"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%></option>
					<option value="0"><%=dbLabelBean.getLabel("label.global.visa",strsesLanguage)%></option>
                    <option value="1"><%=dbLabelBean.getLabel("label.global.master",strsesLanguage)%></option>
                    <option value="2"><%=dbLabelBean.getLabel("label.createrequest.amex",strsesLanguage)%></option>
                </select></td>
				<script language="javascript">
                				document.frm.CARD_TYPE.value= "<%=strCARD_TYPE%>";
		         </script> </span></td>
				 
						
                 <!-- 23-02-2007   -->

                  <td height="21" valign="top"><span class="formtxt2">
                  <input name="cardHolderName" type="text"  class="textBoxCss"  size="25" maxlength="40" onKeyUp="return  test1('cardHolderName', 40, 'c')" value="<%=strCARD_HOLDER_NAME%>" class="textBoxCss"/></td>

                 <!-- 23-02-2007  -->

				 
				




              <!--  <td height="21" valign="top"><span class="formtxt2">      
                <input name="CARD_NUMBER1" type="text" value="<%//=strCARD_NUMBER1%>" class="textBoxCss"  size="1" maxlength="4"onKeyUp="return test1('CARD_NUMBER1', 4, 'n')"  class="textBoxCss" />
-
				<input name="CARD_NUMBER2" type="text" value="<%//=strCARD_NUMBER2%>" class="textBoxCss"  size="1" maxlength="4" onKeyUp="return test1('CARD_NUMBER2', 4, 'n')"  class="textBoxCss"/>
-
				<input name="CARD_NUMBER3" type="text" value="<%//=strCARD_NUMBER3%>" class="textBoxCss"  size="1" maxlength="4" onKeyUp="return test1('CARD_NUMBER3', 4, 'n')"  class="textBoxCss"/>
-
				<input name="CARD_NUMBER4" type="text" value="<%//=strCARD_NUMBER4%>" class="textBoxCss"  size="1" maxlength="4" onKeyUp="return test1('CARD_NUMBER4', 4, 'n')"  class="textBoxCss"/>
                </span></td>  
                 --> 
                <td height="21" valign="top">
				
				<input name="CARD_EXP_DATE" type="hidden" class="textBoxCss" id="test23" size="6" value="<%=strCARD_EXP_DATE%>" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  /> 
				<!-- Modification by vaibhav starts -->
					<!-- 	<a href="javascript:show_calendar('frm.CARD_EXP_DATE','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> -->
                  <select name="monSelect" class="textBoxCss" onchange = "return expiryDate()"> 
                 		<option value=""><%=dbLabelBean.getLabel("label.global.month",strsesLanguage)%></option>
                 		<option value="01">01</option>
                 		<option value="02">02</option>
                 		<option value="03">03</option>
                 		<option value="04">04</option>
                 		<option value="05">05</option>
                 		<option value="06">06</option>
                 		<option value="07">07</option>
                 		<option value="08">08</option>
                 		<option value="09">09</option>
                 		<option value="10">10</option>
                 		<option value="11">11</option>
                 		<option value="12">12</option>
                 		</select>
                 		
                 		<script type="text/javascript">
                 		document.frm.monSelect.value='<%=strMonth%>';
                 		</script>
                 		
                 		<% int year =  Calendar.getInstance().get(Calendar.YEAR);
                 			int count = 0;
                 		%>
                 		<select name="yearSelect" class="textBoxCss" onchange = "return expiryDate()"> 
                 		<option value=""><%=dbLabelBean.getLabel("label.global.year",strsesLanguage)%></option>
                 		<%while(count < 15){%>
                 		<option value="<%=year%>"><%=year%></option>
                 		<%year = year+1;count = count+1;}%>
                 				
                 		</select>
                 		
                 		</select>
                 		<script type="text/javascript">
                 		document.frm.yearSelect.value='<%=strYear%>';
                 		</script>
                 		
                 		<!-- Modification by vaibhav ends -->
                  </td>

                <!--<td height="21" valign="top"><span class="formtxt2">
                  <input name="CVV_NUMBER" type="text" class="textBoxCss"  value="<%=strCVV_NUMBER%>"size="1" maxlength="4"  onKeyUp="return test1('CVV_NUMBER', 3, 'n')" /></span></td>-->
              </tr>

              <tr>
                <td height="25" colspan="4" class="formtxt2" ><%=dbLabelBean.getLabel("alert.global.creditcarddetails",strsesLanguage)%> </td>
              </tr>
            </table></td>
            </tr>
					<tr>
						<td align="left" bgcolor="#FFFFFF" class="newformbot">&nbsp;</td>
						<td align="right" bgcolor="#FFFFFF" class="newformbot">
						 <!-- modified by shiv on 29-May-07 added  "strButtonState" close   -->   
					    <input type="submit" class="formButton" name="saveExit" value="<%=dbLabelBean.getLabel("button.global.saveandexit",strsesLanguage)%>" <%=strButtonState%> onClick="return checkData(this.form,'Exit');"/> 
					    <input type="submit" class="formButton" name="save" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage)%>"   <%=strButtonState%> onClick="return checkData(this.form,'Save');"/> 
					    <input type="submit" class="formButton" name="saveProceed" value="<%=dbLabelBean.getLabel("button.global.saveandnext",strsesLanguage)%>" <%=strButtonState%> onClick="return checkData(this.form,'Proceed');"/> 		    
						 <!-- modified by shiv on 29-May-07 added  "strButtonState" close   -->  
						 </td> 
					</tr>
				</table>
				</td>
				<td width="11" background="images/index_03.png?buildstamp=2_0_0"></td>
			</tr>
			<tr>
				<td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
				<td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
				<td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
			</tr>
		</table>
		
		</td>
	</tr>
</table>
<input type="hidden" name="flag" value="user"> <!--  HIDDEN FIELD  -->
<input type="hidden" name="flag1" value=""> <!--  HIDDEN FIELD  -->
<input type="hidden" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
<input type="hidden" name="travelReqId" value="<%=strTravelReqId%>"/> <!--  HIDDEN FIELD  -->
<input type="hidden" name="travelReqNo" value="<%=strTravelReqNo%>"/> <!--  HIDDEN FIELD  -->
<input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->
<input type ="hidden" name = "interimId"  value = "<%= strIntermiId %>" /><!--  HIDDEN FIELD  -->
<input type ="hidden" name = "sex"  value = "<%= strSex %>" /><!--  HIDDEN FIELD  -->
<input type ="hidden" name = "strSex"  value = "<%= strSex %>" /><!--  HIDDEN FIELD  -->
<input type ="hidden" name = "actualAge"  value = "<%= actualAge %>" /><!--  HIDDEN FIELD  -->
<input type="hidden" name="hidAppLvl3flg" value="<%=strAppLvl3flg %>" />
<input type="hidden" name="hidAppLvl3showbmflg" value="<%=strAppLvl3flgforBM%>" />
</form>

</body>
</html>