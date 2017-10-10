package src.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;

import org.apache.log4j.*;

import src.connection.DbConnectionBean;
import src.connection.DbUtilityMethods;
import src.connection.LabelRepository;

public class MailDaoImpl {
	
	private static final DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	private static final Calendar cal = Calendar.getInstance();
	
	/* Get actual class name to be printed on */
	static Logger logger = Logger.getLogger(MailDaoImpl.class.getName());	
	
	public static void sendRequisitionMailOnOriginating(String strTravelId, String strReqType, String Suser_id, String strsesLanguage, String strCurrentYear) {
		DbConnectionBean dbConBean			= null;
		DbUtilityMethods dbUtilityBean 		= null;
		Connection con, con1				= null;
		Statement stmt,stmt1,stmt2 			= null;
		ResultSet rs,rs1,rs2				= null;
		CallableStatement cstmt_mail		= null;	
		LabelRepository dbLabelBean 		= new LabelRepository();
		
		try {
			
			logger.setLevel(Level.ALL);
		    logger.info("sendRequisitionMailOnOriginating Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
			
			dbConBean								=	new DbConnectionBean();
			con 									=	dbConBean.getConnection();
			
			String strType								= "";
			String strUserId 							= "";
			String strApproverId 						= "";
			String sSqlStr								= ""; 
			String strRequistionId						= null;
			String ReqTyp								= null;
			String strRequistionNumber	 				= null;
			String strMailSubject						= null;
			String strMailSubject1						= null;
			String strMailRefNumber						= null;
			String strRequistionCreatorName	 			= null;
			String strRequistionCreatorMail				= null;
			String strRequistionCreatedDate				= null;
			StringBuffer strMailMsg						= new StringBuffer();
			StringBuffer strMailMsg1					= new StringBuffer();
			String strstrRequistionApproverName			= null;
			String strstrRequistionApproverEmail		= null;
			int	intTries								= 0;
			String strSiteName							= null;
			String strUserNm							= "";
			String strTravelDate						= "";
			String strTravellerSex						= "";
			String strSex								= "";
			String strSql								= "";
			String strTravelFrom						= "";
			String strTravelTo							= "";
			String strRequistionCreatedDatewithoutPmAm	= "";	
			String strTravelReturnDate             	= "";
			String strSqlSql							= "";	
			String strGroupTravelFlag					= "";
			String strGroupTravel						= "";
			String strMailID_OrignalApprover			= "";
			String strBillingSite       				= "";
			String strreasonFortravel	 				= ""; 
			String strReviewer							= "";
			String strReviewerEmail						= "";
			String strApproverEmail						= "";
			String strIsmailFwd							= "N";
			String strTravelAgencyTypeId 				= "";
			String strMailToMATA		 				= "N";
			
			String strCC_CreatorMail					= "";
			//GET THE VALUES FROM THE PREVIOUS SCREEN
			strRequistionId								= strTravelId;
			ReqTyp										= strReqType;
			
			
	
			//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
			sSqlStr="SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(sSqlStr);
				if(rs.next()) {
					strMailRefNumber =	rs.getString(1); //Mail Reference Number
				}
			rs.close();
			stmt.close();
			con.close();
			int intMaliRefNumber = Integer.parseInt(strMailRefNumber)+1;
			
			if(ReqTyp.equals("Domestic Travel")) { 
				strType="D";
				sSqlStr="SELECT T.TRAVEL_REQ_NO AS RNO,DBO.USER_NAME(TA.APPROVER_ID)AS NEXTAPPROVER,DBO.USEREMAIL(TA.APPROVER_ID) AS APPROVEREMAIL,DBO.USER_NAME(T.C_USERID) AS CREATOR,DBO.USEREMAIL(T.C_USERID)AS CREATOREMAIL,CONVERT(VARCHAR(30),T.C_DATETIME,113),.DBO.USER_NAME(TA.TRAVELLER_ID) AS TRAVELLER_NAME ,CONVERT(VARCHAR(30),T.TRAVEL_DATE,113),T.SEX,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME ,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','D') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,T.SITE_ID as SITE_ID,T.C_USERID AS USER_ID,TA.APPROVER_ID,T.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID, (select MAIL_TO_MATA from M_SITE where SITE_ID = T.SITE_ID) as MAIL_TO_MATA FROM T_TRAVEL_DETAIL_DOM T,T_APPROVERS TA WHERE T.TRAVEL_ID=TA.TRAVEL_ID AND TA.APPROVE_STATUS=0 AND TA.ORDER_ID=DBO.MINREQORDERNO("+strRequistionId+") AND T.TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE='D' AND T.STATUS_ID=10 ";
			} else {
				strType="I";
				sSqlStr="SELECT T.TRAVEL_REQ_NO AS RNO,DBO.USER_NAME(TA.APPROVER_ID)AS NEXTAPPROVER,DBO.USEREMAIL(TA.APPROVER_ID)AS APPROVEREMAIL,DBO.USER_NAME(T.C_USERID) AS CREATOR,DBO.USEREMAIL(T.C_USERID)AS CREATOREMAIL,CONVERT(VARCHAR(30),T.C_DATETIME,113),.DBO.USER_NAME(TA.TRAVELLER_ID) AS TRAVELLER_NAME ,CONVERT(VARCHAR(30),T.TRAVEL_DATE,113),T.SEX,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME ,ISNULL(T.GROUP_TRAVEL_FLAG,'N') AS GROUP_TRAVEL_FLAG,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','I') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,T.SITE_ID SITE_ID,T.C_USERID AS USER_ID,TA.APPROVER_ID,T.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID, (select MAIL_TO_MATA from M_SITE where SITE_ID = T.SITE_ID) as MAIL_TO_MATA FROM T_TRAVEL_DETAIL_INT T,T_APPROVERS TA WHERE T.TRAVEL_ID=TA.TRAVEL_ID AND TA.APPROVE_STATUS=0 AND TA.ORDER_ID=DBO.MINREQORDERNO("+strRequistionId+") AND T.TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE='I' AND T.STATUS_ID=10 ";
			}
			
			dbConBean								=	new DbConnectionBean();
			con 									=	dbConBean.getConnection();
			stmt= con.createStatement(); 
			rs = stmt.executeQuery(sSqlStr);
			
			if(rs.next()) {					
				strRequistionNumber					=	rs.getString(1);// Number
				strRequistionCreatorName			=	rs.getString(2);///Receipent Name
				strRequistionCreatorMail			=	rs.getString(3);//Receipent Email
				strstrRequistionApproverName		=	rs.getString(4);//CREATOR NAME
				strstrRequistionApproverEmail		=	rs.getString(5);//CREATOR EMAIL
				String strRequistionCreatedDate1	=	rs.getString(6);//Req Created Date & time
				
				strCC_CreatorMail					= 	strstrRequistionApproverEmail;
				
				//Add the substring Method for time format
				String str= strRequistionCreatedDate1.substring(0,17);
				String str1= strRequistionCreatedDate1.substring(0,11);
				strRequistionCreatedDate=str;	
				strRequistionCreatedDatewithoutPmAm=str1;	
				//End Modification
			
				strUserNm							=	rs.getString(7);//TRAVELLER NAME
				strTravelDate						=	rs.getString(8).substring(0,11); // TRAVEL DATE
				strTravellerSex						=	rs.getString(9); // TRAVELLER SEX
			    strSiteName                     	= 	rs.getString(10); 
			    strTravelAgencyTypeId	 			=	rs.getString("TRAVEL_AGENCY_ID");
			    strMailToMATA						=	rs.getString("MAIL_TO_MATA");
			                    
				//get mail to person language preference
			    strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strRequistionCreatorMail+"' AND STATUS_ID=10";
			    stmt2= con.createStatement(); 
			    rs2 = stmt2.executeQuery(strSql);
				    if(rs2.next()) {
				    	strsesLanguage=rs2.getString("LANGUAGE_PREF");
			   			if(strsesLanguage==null || strsesLanguage.equals("")){
			   				strsesLanguage="en_US";
			   			}
			   		}
		   		rs2.close();
		   		stmt2.close();
								
				if(strTravellerSex.equals("1")) {
					strSex	 =	 "Mr.";
				} else {
					strSex	 =	 "Ms";
				}
			
			    if(ReqTyp.equals("Domestic Travel")) 	{
		              	strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
				      	strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
					  
				      	if(strGroupTravelFlag==null) {
		              		strGroupTravel =""; 
		 		      	}
				 	  
				      	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
		                     strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage);
		                     if(strTravelAgencyTypeId.equals("2")){
		                    	 strGroupTravel =dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
		 					}
		              	} else {
		            	  	strGroupTravel = strSex+" "+" <b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
					  	}
				      
						strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
					  	 	" T_RET_JOURNEY_DETAILS_DOM WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;
	
				} else {
						strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";
					    strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
		     			
					    if(strGroupTravelFlag==null) {
		             		strGroupTravel =""; 
				     	}
					    
			 			if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
			 				strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage);
			 				 if(strTravelAgencyTypeId.equals("2")){
		                    	 strGroupTravel =dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
		 					}
		                } else {
		                	strGroupTravel = strSex+" "+" <b>"+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage);
		                }
			 			
			 			strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
				   			" T_RET_JOURNEY_DETAILS_INT WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;
				}
							
			    String text 		 				=	rs.getString("Expenditure");
				strBillingSite       				=   rs.getString("BILLING_SITE");
				strreasonFortravel   				=   rs.getString("REASON_FOR_TRAVEL");
				String strbillingSiteid		 		=   rs.getString("BILLING_SITE_id");  
				String strBillingClient    			=   rs.getString("BILLING_CLIENT");  
				String strSiteID	 				=   rs.getString("SITE_ID");  	
							
				if(strbillingSiteid.equals("-1")) { //case of out side smg 
					strBillingSite=strBillingClient;  
				}
			
				if(strbillingSiteid.equals("0")) { //case of self smg 
					strBillingSite=strBillingClient;
				}
							
				dbConBean								=	new DbConnectionBean();
				con1 									=	dbConBean.getConnection();
				stmt1= con1.createStatement(); 
				rs1 = stmt1.executeQuery(strSql);
				if(rs1.next()) {
						strTravelFrom	=	rs1.getString(1);
						strTravelTo		=	rs1.getString(2);
				}
					
				rs1.close();
				stmt1.close();
				con1.close();
							
		       //code to find return date from Query 
				dbConBean								=	new DbConnectionBean();
				con1 									=	dbConBean.getConnection();
			   stmt1= con1.createStatement(); 
			   rs1 = stmt1.executeQuery(strSqlSql);
			   if(rs1.next()) {
						strTravelReturnDate	=	rs1.getString(1);
						
			   }
	
			   rs1.close();
			   stmt1.close();
			   con1.close();
			
			   //find the orignal approver name in case of handover mail for sending mail 					
				if(ReqTyp.equals("Domestic Travel")) {
					strSql="select dbo.USEREMAIL(ORIGINAL_APPROVER) from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='d' and ORIGINAL_APPROVER<>'0'";
				
				} else {
					strSql="select dbo.USEREMAIL(ORIGINAL_APPROVER) from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='i' and ORIGINAL_APPROVER<>'0'";
				}
				dbConBean								=	new DbConnectionBean();
				con1 									=	dbConBean.getConnection();
				stmt1= con1.createStatement();
			 	rs1 = stmt1.executeQuery(strSql);
				if(rs1.next()) {
			          strMailID_OrignalApprover	=	rs1.getString(1);//Mail ID of CC mails
				 }
				rs1.close();
				stmt1.close();
				con1.close();
				
				//sending mail on origination for intimation for SMR FRANCE,UK,Spain added on 02-Nov-2009 
				if(ReqTyp.equals("Domestic Travel")) {
					sSqlStr	="SELECT isnull(dbo.Find_email(MAIL_TO),'') as MAIL_TO  FROM  MAIL_AT_STAGES	WHERE site_id="+strSiteID+" and (MAIL_STAGE = 'submit')";
					
					String strMailtoCCon ="";
					dbConBean								=	new DbConnectionBean();
					con1 									=	dbConBean.getConnection();
					stmt1= con1.createStatement();
					rs1 = stmt1.executeQuery(sSqlStr);
					while(rs1.next()) {
						
						strMailtoCCon =rs1.getString("MAIL_TO"); 
					}			
					if(strMailtoCCon==null) {
						strMailtoCCon="";
					}
					rs1.close();
					stmt1.close();
					con1.close();
					strMailID_OrignalApprover=strMailID_OrignalApprover+strMailtoCCon;
				}
				
				strUserId							=   rs.getString("USER_ID");
				strApproverId						=	rs.getString("APPROVER_ID");
				String strTravellerId				=	rs.getString("TRAVELLER_ID");
								
				String ReqTyp1="";
				if(ReqTyp.equals("Domestic Travel")){
					ReqTyp1="label.mail.domestictravel";
					if(strTravelAgencyTypeId.equals("2")){
						ReqTyp1="label.global.domesticeuropetravelrequest";
					}
				}else{
					ReqTyp1="label.mail.internationaltravel";
					if(strTravelAgencyTypeId.equals("2")){
						ReqTyp1="label.global.interconttravelrequest";
					}
				}
				
				
				//get mail id of report_to and mail_cc person		
				String strQuery = "SELECT MDA.MATA_CC_MAIL CC_MAIL"+
							    " FROM M_DEFAULT_APPROVERS AS MDA  WHERE MDA.APPLICATION_ID = 1 AND MDA.STATUS_ID = 10 AND MDA.SITE_ID = '"+strSiteID+"' AND MDA.TRV_TYPE = '"+strType+"'"+ 
								" AND SP_ROLE =(select sp_role from M_userinfo where   userid='"+strTravellerId+"' and loginstatus in ('ACTIVE','ENABLE')) "+
								" AND MDA.ORDER_ID=(select min(order_id) from M_DEFAULT_APPROVERS MA where MA.site_id='"+strSiteID+"' and MA.STATUS_ID=10 and TRV_TYPE='"+strType+"' "+
								" AND SP_ROLE =(select sp_role from M_userinfo where   userid='"+strTravellerId+"' and loginstatus in ('ACTIVE','ENABLE')) AND MA.ORDER_ID<>10 )"+
								" UNION"+
								" select isnull((select m.EMAIL from m_userinfo um inner join m_userinfo m on um.report_to = m.userid inner join m_site s on s.site_id = um.site_id where um.userid='"+strTravellerId+"' and um.status_id=10 and m.status_id=10 and  MAIL_TO_REPORTING ='Y' and um.userid <> 504 ),'') as MATA_CC_MAIL";
								
				stmt = con.createStatement(); 
				rs = stmt.executeQuery(strQuery);
								
				//get value of report_to person mail and mail_cc from two rows
				String strCCMailOnInitial="";
				while(rs.next()) {
					String strCCMailOnInitialTemp=rs.getString(1);
					if(!strCCMailOnInitialTemp.equals("") && strCCMailOnInitial.equals("")) {
						strCCMailOnInitial =strCCMailOnInitialTemp+strCCMailOnInitial;
					} else if(!strCCMailOnInitialTemp.equals("") && !strCCMailOnInitial.equals("")) {
						strCCMailOnInitial =strCCMailOnInitialTemp+";"+strCCMailOnInitial;
					}
				}
				
				if(!strCCMailOnInitial.trim().equalsIgnoreCase("")) {
					strMailID_OrignalApprover=strMailID_OrignalApprover+";"+strCCMailOnInitial;	
				}
								
				String strTravellerMail="";
				if(!strTravellerId.equals(strUserId)) {							
					String strQuery1 = "SELECT DBO.USEREMAIL(MUI.USERID) AS TRAVELLEREMAIL FROM M_USERINFO MUI WHERE MUI.USERID="+strTravellerId+" AND MUI.STATUS_ID=10 AND MUI.APPLICATION_ID=1"; 
					stmt = con.createStatement(); 
					rs = stmt.executeQuery(strQuery1);
					if(rs.next()) {
						strTravellerMail =  rs.getString("TRAVELLEREMAIL");
					}
				
					if(!"".equals(strTravellerMail)){
						strMailID_OrignalApprover 	= strMailID_OrignalApprover+";"+strTravellerMail;	
						strCC_CreatorMail 			= strCC_CreatorMail+";"+strTravellerMail;
					}
				}
				
				if(strMailID_OrignalApprover.length() > 0) {
					if(strMailID_OrignalApprover.charAt(0)==';')
						strMailID_OrignalApprover = strMailID_OrignalApprover.substring(1);
				}
				
				String strSqlQuery = "SELECT DBO.[FN_FIND_ACTIVE_CC_EMAIL]('"+strMailID_OrignalApprover+"') as CC_USER_EMAIL;";
				String strActiveCCUserMail = "" ;
				stmt = con.createStatement(); 
				rs = stmt.executeQuery(strSqlQuery);
				if(rs.next()) {
					strActiveCCUserMail =  rs.getString("CC_USER_EMAIL")==null?"":rs.getString("CC_USER_EMAIL").trim();
				}
				
				String groupGuestLabel = "";
				if(strTravelAgencyTypeId.equals("2")){
					groupGuestLabel = "label.global.guest";
				}else{
					groupGuestLabel = "label.approverequest.groupguest";
				}
	
				//change the mailSubject
				if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
					strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionno",strsesLanguage)+"'"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject
				} else {
					strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionno",strsesLanguage)+"'"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject
				}
				
				
					try {
						dbUtilityBean = new DbUtilityMethods();
						String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strRequistionCreatorMail);
						
						strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");
						strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDatewithoutPmAm+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
						strMailMsg.append("</td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
						strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
						strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel("label.mail.travelrequisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+"\n"); 
						strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strRequistionCreatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.hasbeenoriginatedby",strsesLanguage)+" "+strstrRequistionApproverName+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+"</p>"+ "\n"); 
						strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+"</u> :-</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"   </font>\n<br>"); 
						strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)+" </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
						
						if((strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {
							strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyGmbh(strRequistionId, strType, strTravellerId));
						}else{
							strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyIndia(strRequistionId, strType, strTravellerId, strGroupTravelFlag));
						}
						
						strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");  
						strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
						strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
						strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
						strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
						strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
						strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
						
						try {
							logger.info("sendRequisitionMailOnOriginating [Pending for Approval] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
							dbConBean								=	new DbConnectionBean();
							con1 									=	dbConBean.getConnection();
							//Procedure for inserting Mail Data
							cstmt_mail=con1.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
							cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt_mail.setString(2, strRequistionId);
							cstmt_mail.setString(3, strRequistionNumber);
							cstmt_mail.setString(4, strRequistionCreatorMail);//To
							cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
							cstmt_mail.setString(6, strActiveCCUserMail);//CC  Mail Address is remove By  shar sharma on 03-Apr-08
							cstmt_mail.setString(7, strMailSubject);
							cstmt_mail.setString(8, strMailMsg.toString());
							cstmt_mail.setInt(9, intTries);
							cstmt_mail.setString(10, "NEW");
							cstmt_mail.setString(11, Suser_id);
							cstmt_mail.setString(12, "New");
							cstmt_mail.setString(13, "User Submitting the Req");
							cstmt_mail.execute();
							cstmt_mail.close();
							con1.close();
							logger.info("sendRequisitionMailOnOriginating [Pending for Approval] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
						}
						catch(Exception b) {
							b.printStackTrace();
							System.out.println("Error in sendRequisitionMailOnOriginating========="+b);
						}
						
						rs1=null;			
					    String approverId="";
						String approver="";
						strSql="SELECT TA.APPROVER_ID, dbo.user_name(TA.APPROVER_ID) as approver, DBO.USEREMAIL(TA.APPROVER_ID) AS ApproverEmail"+
							" ,dbo.user_name(TA.PAP_APPROVER) as reviewer, DBO.USEREMAIL(TA.PAP_APPROVER) AS reviewerEmail, pap.IS_MAIL_FWD"+
							" FROM T_APPROVERS TA inner join"+ 
							" VW_PAGE_ACCESS_PERMISSION PAP on pap.viewToUser=TA.PAP_APPROVER and pap.pendingWithUser = TA.APPROVER_ID"+ 
							" WHERE TA.TRAVEL_ID='"+strRequistionId+"' "+
							" AND TA.ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE T_APPROVERS.TRAVEL_ID='"+strRequistionId+"' AND T_APPROVERS.SITE_ID='"+strSiteID+"' AND T_APPROVERS.TRAVEL_TYPE='"+strType+"' AND T_APPROVERS.APPROVE_STATUS=0) "+
							" AND TA.SITE_ID='"+strSiteID+"' "+
							" AND TA.TRAVEL_TYPE='"+strType+"'";
						stmt = con.createStatement(); 
						rs1 = stmt.executeQuery(strSql);
							if(rs1.next()) {
								approverId=rs1.getString("APPROVER_ID");
								approver=rs1.getString("approver");
								strApproverEmail=rs1.getString("ApproverEmail");
								strReviewer=rs1.getString("reviewer");
								strReviewerEmail=rs1.getString("ReviewerEmail");
								strIsmailFwd=rs1.getString("is_mail_fwd");
							}
							
						 stmt2=null;
						 rs2=null;
							
						 // get mail to person language preference
						 strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strReviewerEmail+"' AND STATUS_ID=10";
						 stmt2= con.createStatement(); 
						 rs2 = stmt2.executeQuery(strSql);
						 if(rs2.next()) {
							strsesLanguage=rs2.getString("LANGUAGE_PREF");
							if(strsesLanguage==null || strsesLanguage.equals("")){
								strsesLanguage="en_US";
							}
						 }
						 rs2.close();
						 stmt2.close();
							
						 strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisitionno",strsesLanguage)+"'"+strRequistionNumber.trim()+"'  "+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+" ";
							
						if(strIsmailFwd!=null && strIsmailFwd.trim().equalsIgnoreCase("Y")) {
							
						strMailMsg1.append("<html><style>.formhead {	font-family: Arial;	font-size: 11px;	font-style: normal;	font-weight: normal;	color: #000000;");
						strMailMsg1.append("border: 1px #333333 solid;	background: #00CCFF;}</style>");
						strMailMsg1.append("<body bgcolor=#00CCFF><table width=80% align=center><tr><td align=right><font size=2><b><font color=#FFFFFF>"+strRequistionCreatedDatewithoutPmAm+"</font>");
						strMailMsg1.append("<font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td>");
						strMailMsg1.append("</tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=9></table>");
						strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220>");
						strMailMsg1.append("<font size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table>");
						strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font size=2><b>");
						strMailMsg1.append("<font	color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font size=2></font></td></tr><tr><td><p>");
						strMailMsg1.append("<font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strReviewer+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif> "+dbLabelBean.getLabel("mail.label.kindlyreviewtherequest",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("mail.label.pendingwithmeandtakeappropriateaction",strsesLanguage));
						strMailMsg1.append("<br><br><font color=blue></p></font> </font><font size=2></font></p><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='https://stars.mindeservices.com'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> </b></form>");
						strMailMsg1.append("</font><br>	<p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+approver+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center>");
						strMailMsg1.append("<font face=Verdana,Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+intMaliRefNumber+"/"+strCurrentYear+"</font></td></tr>");
						strMailMsg1.append("<tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5><tr>");
						strMailMsg1.append("<td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000> <a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>");
						strMailMsg1.append("</tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+"  "+dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td>");
						strMailMsg1.append("</tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td></tr></table><p>&nbsp;</p></body></html>");
	
						try {
							logger.info("sendRequisitionMailOnOriginating [For Review] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
							dbConBean								=	new DbConnectionBean();
							con1 									=	dbConBean.getConnection();
							cstmt_mail=con1.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
							cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt_mail.setString(2, "");
							cstmt_mail.setString(3, strRequistionNumber);
							cstmt_mail.setString(4, strReviewerEmail);//To
							cstmt_mail.setString(5, strApproverEmail);//From
							cstmt_mail.setString(6, "");
							cstmt_mail.setString(7, strMailSubject1);
							cstmt_mail.setString(8, strMailMsg1.toString());
							cstmt_mail.setInt(9, intTries);
							cstmt_mail.setString(10, "NEW");
							cstmt_mail.setString(11, approverId);
							cstmt_mail.setString(12, "New");
							cstmt_mail.setString(13, "User Submitting the Req");
							cstmt_mail.execute();
							cstmt_mail.close();
							con1.close();
							logger.info("sendRequisitionMailOnOriginating [For Review] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
						} catch(Exception b) {	
							b.printStackTrace();
							System.out.println("Error in sendRequisitionMailOnOriginating second mail block========="+b);		
						}
						
						}
						
						logger.info("sendRequisitionMailOnOriginating [Travel Agency Type Id] " +strTravelAgencyTypeId+ " for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
						
						// Send Mail to TRAVEL MATA GmbH/India and Travel Coordinator
						if(strTravelAgencyTypeId != null && !"".equals(strTravelAgencyTypeId) && !"0".equals(strTravelAgencyTypeId) && "Y".equals(strMailToMATA)) {
							if(!isAdvanceTravelRequest(strTravelId, strType, strTravelAgencyTypeId)) {
								logger.info("sendRequisitionMailOnOriginating [Send Mail to TRAVEL MATA GmbH/India] Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
								
								String strMataGmbHMailContent = "";
								String functionKey = "";
								String adminIDFlag = "";								
								 if(strTravelAgencyTypeId.equals("1")) {
									
									functionKey = "@MataindiaSite";
									adminIDFlag = "AND M_USERINFO.USERID=1129";
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getGroupMailBodyForMataIndia(strRequistionId, strType, strTravellerId);
									} else if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("N"))){
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getMailBodyForMataIndia(strRequistionId, strType, strTravellerId);
									}
									
								} else if(strTravelAgencyTypeId.equals("2")) {
									
									functionKey = "@MataGmbHSite";
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getGroupMailBodyForMataGmbH(strRequistionId, strType, strTravellerId);
									} else if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("N"))){
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getMailBodyForMataGmbH(strRequistionId, strType, strTravellerId);
									}
								} 
								
								String firstDepartureDate = "";
								String strSqlDepartureDate = "";
								if("I".equals(strType) || "INT".equals(strType)) {
									strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId;
								} else if("D".equals(strType) || "DOM".equals(strType)) {
									strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId;
								}
		
								stmt2=null;
								rs2=null;
								stmt2= con.createStatement(); 
								rs2 = stmt2.executeQuery(strSqlDepartureDate);
								if(rs2.next()) {
									firstDepartureDate=rs2.getString("FIRST_JOURNY_DATE");
								}
								rs2.close();
								stmt2.close();
								
								String emailIdsMataSql = "";					
								if("I".equals(strType) || "INT".equals(strType)) {
									
									emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_INT TDI "+ 
											" INNER JOIN T_APPROVERS TA ON TDI.TRAVEL_ID=TA.TRAVEL_ID AND "+
											" TA.TRAVEL_TYPE='"+strType+"' WHERE TDI.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
											" select email AS MATAGMBH from m_userinfo "+ 
											" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='"+functionKey+"') and role_id ='MATA' and "+ 
											" exists(select 1 from T_TRAVEL_DETAIL_INT tdi inner join m_site s on tdi.SITE_ID = s.site_id "+ 
											" WHERE TRAVEL_ID="+strRequistionId+" and TRAVEL_AGENCY_ID="+strTravelAgencyTypeId+") and M_USERINFO.STATUS_ID=10 " + adminIDFlag + " UNION "+
											" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_INT TDI "+
											" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDI.SITE_ID=UMA.SITE_ID "+
											" WHERE TDI.TRAVEL_ID="+strRequistionId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
									
								} else if("D".equals(strType) || "DOM".equals(strType)) {
									
									emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_DOM TDD "+
											" INNER JOIN T_APPROVERS TA ON TDD.TRAVEL_ID=TA.TRAVEL_ID AND "+
											" TA.TRAVEL_TYPE='"+strType+"' WHERE TDD.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
											" select email AS MATAGMBH from m_userinfo "+ 
											" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='"+functionKey+"') and role_id ='MATA' and "+ 
											" exists(select 1 from T_TRAVEL_DETAIL_DOM tdd inner join m_site s on tdd.SITE_ID = s.site_id "+ 
											" WHERE TRAVEL_ID="+strRequistionId+" and TRAVEL_AGENCY_ID="+strTravelAgencyTypeId+") and M_USERINFO.STATUS_ID=10 " + adminIDFlag + " UNION "+
											" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_DOM TDD "+
											" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDD.SITE_ID=UMA.SITE_ID "+
											" WHERE TDD.TRAVEL_ID="+strRequistionId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
									
								}
								
								ArrayList<String> emailIdsList = new ArrayList<String>();
								String emailId = "";
								String emailIds = "";
								stmt2=null;
								rs2=null;
								stmt2= con.createStatement(); 
								rs2 = stmt2.executeQuery(emailIdsMataSql);
								while(rs2.next()) {
									emailId=rs2.getString("MATAGMBH");
									emailIdsList.add(emailId);
								}
								rs2.close();
								stmt2.close();
								
								StringBuilder sb = new StringBuilder();
								int size = emailIdsList.size(); 
								if (size > 0) {
									sb.append(emailIdsList.get(0));
									for (int i = 1; i < size; ++i) {
										sb.append("; ").append(emailIdsList.get(i));
								    }
									
									emailIds = sb.toString();
								}
								
								String resubmitStatus = "";
								String resubmitStatusQuery = "";
								
								if("I".equals(strType) || "INT".equals(strType)) {
									resubmitStatusQuery = "SELECT CASE WHEN EXISTS(SELECT 1 FROM AUDIT_T_TRAVEL_STATUS WHERE TRAVEL_ID= '" + strRequistionId 
											+ "'AND TRAVEL_TYPE='" + strType + "' AND TRAVEL_STATUS_ID=3 AND STATUS_ID=10)"
											+ " THEN 'Y' ELSE 'N' END AS RESUBMIT_STATUS";
								}else if("D".equals(strType) || "DOM".equals(strType)) {
									resubmitStatusQuery = "SELECT CASE WHEN EXISTS(SELECT 1 FROM AUDIT_T_TRAVEL_STATUS WHERE TRAVEL_ID= '" + strRequistionId 
											+ "'AND TRAVEL_TYPE='" + strType + "' AND TRAVEL_STATUS_ID=3 AND STATUS_ID=10)"
											+ " THEN 'Y' ELSE 'N' END AS RESUBMIT_STATUS";
								}
								
								stmt2=null;
								rs2=null;
								stmt2= con.createStatement(); 
								rs2 = stmt2.executeQuery(resubmitStatusQuery);
								while(rs2.next()) {
									resubmitStatusQuery=rs2.getString("RESUBMIT_STATUS");
									if(resubmitStatusQuery.equalsIgnoreCase("Y"))
										resubmitStatus = " - Resubmitted";										
								}
								rs2.close();
								stmt2.close();
								
								String strSqlTravellerName = "";
								String strGrpTravellerName = "";
								int grpTravllerCount  		= 0;
								
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
									strSqlTravellerName = "SELECT TOP 1 LTRIM(RTRIM(FIRST_NAME)) +' '+ LTRIM(RTRIM(ISNULL(LAST_NAME,''))) AS TRAVELLER, COUNT(*) OVER (partition by 1) TRAVELLERCOUNT FROM T_GROUP_USERINFO WHERE TRAVEL_ID="+strRequistionId+" AND SITE_ID="+strSiteID+" AND TRAVEL_TYPE='"+strType+"' AND STATUS_ID=10 ORDER BY G_USERID";
									stmt2=null;
									rs2=null;
									stmt2= con.createStatement(); 
									rs2 = stmt2.executeQuery(strSqlTravellerName);
									if(rs2.next()){
										strGrpTravellerName	=	rs2.getString("TRAVELLER");
										grpTravllerCount 	=	rs2.getInt("TRAVELLERCOUNT") - 1;
									}
									rs2.close();
									stmt2.close();
								}
								
								
								
								String strFromMail= "";
								String strMataGmbhSubject = "";
								
								if(strTravelAgencyTypeId.equals("1")) {
									strFromMail="administrator.stars@mind-infotech.com";
									
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
										strMataGmbhSubject = "STARS - Pending"+ resubmitStatus + " - ["+strGrpTravellerName+"+"+grpTravllerCount+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] ["+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+"]";
									} else {
										strMataGmbhSubject = "STARS - Pending"+ resubmitStatus + " - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"]";
									}
								} else if(strTravelAgencyTypeId.equals("2")) {
									strFromMail= strstrRequistionApproverEmail;
									
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
										strMataGmbhSubject = "STARS - " + "["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] ["+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+"] - Pending"+ resubmitStatus;
									} else {
										strMataGmbhSubject = "STARS - " + "["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] - Pending"+ resubmitStatus;
									}
								}
								
								try {
										logger.info("sendRequisitionMailOnOriginating [Send Mail to TRAVEL MATA GmbH/India] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
										dbConBean								=	new DbConnectionBean();
										con1 									=	dbConBean.getConnection();
										cstmt_mail=con1.prepareCall("{call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
										cstmt_mail.setString(1, strRequistionId);
										cstmt_mail.setString(2, strRequistionNumber);
										cstmt_mail.setString(3, emailIds);//Email Ids of MATA and Travel Coordinator.
										cstmt_mail.setString(4, strFromMail);//From Admin
										cstmt_mail.setString(5, strCC_CreatorMail);
										cstmt_mail.setString(6, strMataGmbhSubject);
										cstmt_mail.setString(7, strMataGmbHMailContent);
										cstmt_mail.setString(8, "0");
										cstmt_mail.setString(9, "NEW");
										cstmt_mail.setString(10, Suser_id);
										cstmt_mail.setString(11, "New");
										cstmt_mail.setString(12, "User Submitting the Req");
										cstmt_mail.execute();
										cstmt_mail.close();
										con1.close();
										logger.info("sendRequisitionMailOnOriginating [Send Mail to TRAVEL MATA GmbH/India] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
								} catch(Exception b) {
									b.printStackTrace();
									System.out.println("Error in sendRequisitionMailOnOriginating second mail block========="+b);		
								}					
								logger.info("sendRequisitionMailOnOriginating [Send Mail to TRAVEL MATA GmbH/India] End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));	
							}
						}
						
					} catch(Exception e) {
							System.out.println("Error in sendRequisitionMailOnOriginating ========="+ e);
					}
				}
				rs.close();
				stmt.close();
				con.close();
				dbConBean.close();
		
			    logger.info("sendRequisitionMailOnOriginating End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
		} catch(Exception e) {
			System.out.println("Error in sendRequisitionMailOnOriginating main try/catch block========="+ e);
	    }				
	}
	
	public static void sendRequisitionMailOnApproval(String strTravelId, String strReqType, String strComments, String strTravellerSiteId, String Suser_id, String strsesLanguage, String strCurrentYear, String strMailCreatedate) {
		DbConnectionBean dbConBean			= null;
		DbUtilityMethods dbUtilityBean 		= null;
		Connection con, con1				= null;
		Statement stmt, stmt1, stmt2 		= null;
		ResultSet rs,rs1,rs2,rs3,rs4		= null;
		CallableStatement cstmt_mail		= null;	
		LabelRepository dbLabelBean 		= new LabelRepository();
		
		try {
		
			logger.setLevel(Level.ALL);
			logger.info("sendRequisitionMailOnApproval Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
			
			dbConBean								=	new DbConnectionBean();
			con 									=	dbConBean.getConnection();
			
			//DECLARE VARIABLES
			String	sSqlStr								=	""; 
			String strRequistionId						=	null;
			String strRequistionNumber	 				=	null;
			String strMailSubject						=	null;
			String strMailSubject1						=	null;
			String strMailRefNumber						=	null;
			String strRequistionCreatorName	 			=	null;
			String strRequistionCreatorMail				=	null;
			String strRequistionCreatedDate				=	null;
			String strRequisitionComments				=	null;
			StringBuffer strMailMsg						=	new StringBuffer();
			String strstrRequistionApproverName			=	null;
			String strstrRequistionApproverEmail		=	null;
			String strRequistionNextApprover_UserId		=	null;
			String strstrRequistionNextApproverName		=	null;
			String strstrRequistionNextApproverEmail	=	null;
			int	intTries								=	0;
			String strSiteName							=	null;
			String strUserNm							=	"";
			String strTravelDate						=	"";
			String strTravellerSex						=	"";
			String strSex								=	"";
			String strSql								=	"";
			String strTravelFrom						=	"";
			String strTravelTo							=	"";
			String strSiteId                            =   "";
			String strCreationDate                      =	"";
			String TType								=	"";
			String strTraveltype						=	"";			
			String strGroupTravel          				=	"";
			String strGroupTravelFlag   				=	"";			
			String strLastApprover_flag					=	"";			
			String strMailID_MataAsso					=	"";	
			ArrayList aList								=   new ArrayList();   
			String strMailID_OrignalApprover			=	"";			
			String strRequistionCreatedDateWithoutAMPM 	=	"";			
			String strSqlSql							=	"";			
			String strreasonFortravel   				=   "";			
			String strBillingSite		 				=	"";			
			String strTravelReturnDate					=	"";
			String strTravelClass						=	"";
			String strTransitType						= 	"0";
			String strTrasitMsg							= 	"";
			String strTrvType							=	"";
			String strApproverId						=	"";
			String strMailFlag							=	"N";
			String strTrasitMsg1						= 	"";
			String strTravelAgencyTypeId 				= 	""; 
			String strMailToMATA						= 	"N";
			
			String strCC_CreatorMail 					= 	"";
			
			//GET THE VALUES FROM THE PREVIOUS SCREEN
			strRequistionId								=	strTravelId;
			strRequisitionComments						=	strComments;
			String ReqTyp								=	strReqType;
			String strSiteID							= 	strTravellerSiteId;
			
			String ReqTyp1="";
			if(ReqTyp.equals("Domestic Travel")) {
				ReqTyp1="label.mail.domestictravel";
			} else {
				ReqTyp1="label.mail.internationaltravel";
			}

			//FETCH THE LATEST MAIL ID FROM REQ_MAILBOX
			sSqlStr			= "SELECT ISNULL(MAX(MAIL_ID),'999')+1 FROM REQ_MAILBOX";
			stmt			= con.createStatement(); 
			rs				= stmt.executeQuery(sSqlStr);
			if(rs.next()) {
				strMailRefNumber		=	rs.getString(1);//Mail Reference Number
			}
			rs.close();
			stmt.close();
			
			int intMaliRefNumber 		= Integer.parseInt(strMailRefNumber)+1;
			
			if(ReqTyp.equals("Domestic Travel")) {
				strTrvType="D";
				sSqlStr=" select .DBO.USER_NAME(mailfrom) AS APPROVER_NAME, DBO.USEREMAIL(mailfrom) AS APPROVER_MAIL ,"+
						" .DBO.USER_NAME(mailto) AS NEXTWITH, DBO.USEREMAIL(mailto) AS NEXTWITH_MAIL , IS_MAIL_FWD, TOTAL_AMOUNT, PAP_VALUE_LIMIT"+ 
						" ,MAIL_DIRECTION from ("+
						" select  ta.travel_id, order_id, TA.site_id ,travel_type, approver_id, pap_approver, pap_flag, approve_status,"+ 
						" VW.IS_MAIL_FWD, td.TOTAL_AMOUNT, VW.PAP_VALUE_LIMIT ,"+
						" case when (PAP_APPROVER<>0 and pap_flag<>'') then 'R2A' else 'A2R' end MAIL_DIRECTION,"+
						" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then approver_id else pap_approver end mailfrom,"+ 
						" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then pap_approver else approver_id end mailto"+ 
						" from t_approvers ta INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TD.TRAVEL_ID = ta.TRAVEL_ID and ta.TRAVELLER_ID = td.TRAVELLER_ID"+ 
						" LEFT JOIN VW_PAGE_ACCESS_PERMISSION  VW ON TA.SITE_ID = VW.SITE_ID "+
						" AND TA.APPROVER_ID  = VW.pendingWithUser AND TA.PAP_APPROVER = VW.viewToUser"+ 
						" where ta.travel_id='"+strRequistionId+"' and travel_type ='d' "+
						" AND  (td.TOTAL_AMOUNT > VW.PAP_VALUE_LIMIT OR pap_flag ='')"+
						" and(order_id = (select min(order_id ) from  t_approvers  where travel_id =ta.travel_id and travel_type =ta.travel_type and approve_status =0) )	)tbl";
			} else {
				strTrvType="I";
				sSqlStr=" select .DBO.USER_NAME(mailfrom) AS APPROVER_NAME, DBO.USEREMAIL(mailfrom) AS APPROVER_MAIL ,"+
				" .DBO.USER_NAME(mailto) AS NEXTWITH, DBO.USEREMAIL(mailto) AS NEXTWITH_MAIL , IS_MAIL_FWD, TOTAL_AMOUNT, PAP_VALUE_LIMIT"+ 
				" ,MAIL_DIRECTION from ("+
				" select  ta.travel_id, order_id, TA.site_id ,travel_type, approver_id, pap_approver, pap_flag, approve_status,"+ 
				" VW.IS_MAIL_FWD, td.TOTAL_AMOUNT, VW.PAP_VALUE_LIMIT ,"+
				" case when (PAP_APPROVER<>0 and pap_flag<>'') then 'R2A' else 'A2R' end MAIL_DIRECTION,"+
				" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then approver_id else pap_approver end mailfrom,"+ 
				" case when pap_approver<>0 AND pap_flag ='' and approve_status =0 then pap_approver else approver_id end mailto"+ 
				" from t_approvers ta INNER JOIN T_TRAVEL_DETAIL_INT TD ON TD.TRAVEL_ID = ta.TRAVEL_ID and ta.TRAVELLER_ID = td.TRAVELLER_ID"+ 
				" LEFT JOIN VW_PAGE_ACCESS_PERMISSION  VW ON TA.SITE_ID = VW.SITE_ID "+
				" AND TA.APPROVER_ID  = VW.pendingWithUser AND TA.PAP_APPROVER = VW.viewToUser"+ 
				" where ta.travel_id='"+strRequistionId+"' and travel_type ='I' "+
				" AND  (td.TOTAL_AMOUNT > VW.PAP_VALUE_LIMIT OR pap_flag ='')"+
				" and(order_id = (select min(order_id ) from  t_approvers  where travel_id =ta.travel_id and travel_type =ta.travel_type and approve_status =0) )	)tbl";

			}

			stmt					= con.createStatement(); 
			rs						= stmt.executeQuery(sSqlStr);
			String strFromName		=	"";
			String strFromMail		=	"";
			String strToName		=	"";
			String strToMail		=	"";
			String strMailFwdFlag	=	"";
			String strMailDir		=	"";
			
			if(rs.next()) {
				strMailFlag			=	"Y";
				strFromName			= 	rs.getString("APPROVER_NAME");
				strFromMail			= 	rs.getString("APPROVER_MAIL");
				strToName			= 	rs.getString("NEXTWITH");
				strToMail			= 	rs.getString("NEXTWITH_MAIL");
				strMailFwdFlag		= 	rs.getString("IS_MAIL_FWD");
				
				if(strMailFwdFlag==null) {
					strMailFwdFlag	=	"";
				}
				
				strMailDir			= 	rs.getString("MAIL_DIRECTION");
			}
			rs.close();
			stmt.close();
			
			sSqlStr=" SELECT TA.APPROVER_ID FROM T_APPROVERS TA"+
				    " inner join VW_PAGE_ACCESS_PERMISSION PAP on "+
				    " pap.viewToUser=TA.PAP_APPROVER and pap.pendingWithUser = case when ta.ORIGINAL_APPROVER =0 then TA.APPROVER_ID else ta.ORIGINAL_APPROVER  end"+
				 	" WHERE TA.TRAVEL_ID='"+strRequistionId+"'"+ 
				 	" AND TA.ORDER_ID=(SELECT MAX(ORDER_ID) FROM T_APPROVERS WHERE T_APPROVERS.TRAVEL_ID='"+strRequistionId+"'"+ 
				 	" AND SITE_ID='"+strSiteID+"' AND TRAVEL_TYPE='"+strTrvType+"' AND PAP_APPROVER='"+Suser_id+"' AND PAP_FLAG ='A')"+ 
				 	"AND TA.SITE_ID='"+strSiteID+"' AND TA.TRAVEL_TYPE='"+strTrvType+"'";
			
			stmt		= con.createStatement(); 
			rs			= stmt.executeQuery(sSqlStr);
			if(rs.next()) {
				strApproverId		=	rs.getString("APPROVER_ID");
			}
			rs.close();
			stmt.close();
			
			if(strApproverId==null || strApproverId.equals("")) {
				strApproverId=Suser_id;
			}
			
			 // FETCH Requisition Details
			if(ReqTyp.equals("Domestic Travel")) {
				TType="label.mail.domesticatravelrequisitionno";
				sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+strApproverId+"') AS APPROVER_NAME,DBO.USEREMAIL('"+strApproverId+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30), C_DATETIME,113), .DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113),SEX ,.DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','D') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'D') as travel_class,t.TRANSIT_TYPE,t.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = t.SITE_ID) as TRAVEL_AGENCY_ID, (select MAIL_TO_MATA from M_SITE where SITE_ID = T.SITE_ID) as MAIL_TO_MATA FROM T_TRAVEL_DETAIL_DOM t  WHERE TRAVEL_ID="+strRequistionId+" ";
				
			} else {
				TType="label.mail.internationalatravelrequisitionno";
				sSqlStr="SELECT TRAVEL_REQ_NO ,.DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL, .DBO.USER_NAME('"+strApproverId+"') AS APPROVER_NAME, DBO.USEREMAIL('"+strApproverId+"') AS APPROVER_MAIL, ISNULL(RTRIM(.DBO.PRESENTAPPROVER("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_USERID, ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strRequistionId+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL, convert(varchar(30),C_DATETIME,113),.DBO.USER_NAME(TRAVELLER_ID) AS TRAVELLER_NAME ,convert(varchar(30),TRAVEL_DATE,113), SEX, .DBO.SITENAME(T.SITE_ID) AS SITE_NAME,SITE_ID,T.GROUP_TRAVEL_FLAG,REASON_FOR_TRAVEL,dbo.FN_GET_EXPENDITURE('"+strRequistionId+"','I') AS Expenditure,dbo.sitename(t.BILLING_SITE) as BILLING_SITE,REASON_FOR_TRAVEL,BILLING_SITE as BILLING_SITE_id ,BILLING_CLIENT,C_USERID,dbo.FN_TRAVEL_CLASS("+strRequistionId+",'I') as travel_class,T.HOTEL_REQUIRED AS TRANSIT_TYPE,T.TRAVELLER_ID, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T.SITE_ID) as TRAVEL_AGENCY_ID, (select MAIL_TO_MATA from M_SITE where SITE_ID = T.SITE_ID) as MAIL_TO_MATA FROM T_TRAVEL_DETAIL_INT T  WHERE TRAVEL_ID="+strRequistionId+"  ";
			}
			
			stmt	= con.createStatement(); 			
			rs 		= stmt.executeQuery(sSqlStr);
			
			
			if(rs.next()) {
				strRequistionNumber									=	rs.getString(1);// Number
				strRequistionCreatorName			 				=	rs.getString(2);//Creator Name
				strRequistionCreatorMail				 			=	rs.getString(3);//Creator Email
				strstrRequistionApproverName						=	rs.getString(4);//APPROVER NAME
				strstrRequistionApproverEmail			 			=	rs.getString(5);//APPROVER EMAIL
				strstrRequistionNextApproverName					=	rs.getString(6);//NEXT APPROVER NAME
				strRequistionNextApprover_UserId					=	rs.getString(7);//NEXT APPROVER USER_ID NEW FIELDS
				strstrRequistionNextApproverEmail			 		=	rs.getString(8);//NEXT APPROVER MAIL
				String strRequistionCreatedDate1			 		=	rs.getString(9);//Req Created Date & time
				String str											=   strRequistionCreatedDate1.substring(0,17);
				String str1											=   strRequistionCreatedDate1.substring(0,11);
				strRequistionCreatedDate							=	str;
				strRequistionCreatedDateWithoutAMPM					=	str1;	
				strUserNm								 			=	rs.getString(10);//TRAVELLER NAME
				strTravelDate										=	rs.getString(11).substring(0,11); // TRAVEL DATE
				strTravellerSex										=	rs.getString(12); // TRAVELLER SEX
				strSiteName											=	rs.getString(13); //site name
				strSiteId                                           =	rs.getString(14); //site id
								
				strCC_CreatorMail									= 	strRequistionCreatorMail;
				
				String strTravellerId								=	rs.getString("TRAVELLER_ID");				
				strMailToMATA										=	rs.getString("MAIL_TO_MATA");
				strTravelAgencyTypeId	 							=	rs.getString("TRAVEL_AGENCY_ID");
				
				if(strTravellerSex.equals("1"))	{
					strSex	 =	 "Mr.";
				} else {
					strSex	 =	 "Ms";
				}
				
				if(ReqTyp.equals("Domestic Travel")) {
				   strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'d')";
				   strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
				     if(strGroupTravelFlag==null) {
		               strGroupTravel =""; 
			 		 }
				     
					 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
                   		strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage); 
                   		if(strTravelAgencyTypeId.equals("2")) {
	                    	 strGroupTravel =dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
	 					}
                     } else {
                   		strGroupTravel = strSex+" "+"<b> "+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
					 }
				     
					 strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
						   " T_RET_JOURNEY_DETAILS_DOM WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;			
			   } else {
			         strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
					     if(strGroupTravelFlag==null) {
			               strGroupTravel =""; 
				 		 }
	
						 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
							 strGroupTravel =dbLabelBean.getLabel("label.mail.groupguestisscheduledtotravel",strsesLanguage);
							 if(strTravelAgencyTypeId.equals("2")) {
		                    	 strGroupTravel =dbLabelBean.getLabel("label.mail.guestisscheduledtotravel",strsesLanguage);
		 					 }
	                     } else {
	                   			strGroupTravel = strSex+" "+"<b> "+strUserNm+ "</b> "+dbLabelBean.getLabel("label.mail.isscheduledtotravel",strsesLanguage); 
						 }
			
					strSql ="select * FROM  [dbo].[FN_GetDeparturecity]("+strRequistionId+",'i')";
			
					// Sql for getting return date
					strSqlSql="SELECT CONVERT(VARCHAR(11), TRAVEL_DATE, 113) FROM "+         		   
									   " T_RET_JOURNEY_DETAILS_INT WHERE  (TRAVEL_ID = "+strRequistionId+") and  (RETURN_FROM <> '') AND (RETURN_TO <> '')" ;			
				}
			
				strreasonFortravel   		=   rs.getString("REASON_FOR_TRAVEL");
				String text   		 		= 	rs.getString("Expenditure"); 
				strBillingSite       		=   rs.getString("BILLING_SITE");
				String strbillingSiteid		= 	rs.getString("BILLING_SITE_id");  
				String strBillingClient    	= 	rs.getString("BILLING_CLIENT");  
				String strCreatorID        	= 	rs.getString("C_USERID");
				strTravelClass				=	rs.getString("travel_class"); 
				strTransitType 				= 	rs.getString("TRANSIT_TYPE");
				
				if(strTransitType.trim().equalsIgnoreCase("2")) {
					strTrasitMsg="label.mail.smokingandalcolholmsg";
				}
				
				String strISLastapprover   ="no";	
				
				if(strRequistionNextApprover_UserId.equalsIgnoreCase("NA")) {
					strRequistionNextApprover_UserId	=strCreatorID;
					strstrRequistionNextApproverName    =strRequistionCreatorName;
					strISLastapprover="yes"; 
				}
					
				if(strbillingSiteid.equals("-1")) { //case of out side smg 
					strBillingSite=strBillingClient;  
				}
			
				if(strbillingSiteid.equals("0")) { //case of self smg 
					strBillingSite=strBillingClient; 
				}
			   	
				rs.close();
				stmt1= con.createStatement(); 
				rs1 = stmt1.executeQuery(strSql);
				if(rs1.next()) {
					strTravelFrom	=	rs1.getString(1);
					strTravelTo		=	rs1.getString(2);
				}
				rs1.close();
				stmt1.close();
				
			   //code to find return date from Query 
				stmt1= con.createStatement(); 
		   		rs2 = stmt1.executeQuery(strSqlSql);
					if(rs2.next()) {
							strTravelReturnDate	=	rs2.getString(1);		
					}
			
				rs2.close();
				stmt1.close();
				
			dbUtilityBean = new DbUtilityMethods();	 
			aList  = dbUtilityBean.getApproverAccoringToRole(strRequistionNextApprover_UserId,strSiteId);
			
			if(ReqTyp.equals("Domestic Travel")) {
			    strTraveltype="d";
			} else {
				strTraveltype="i";
			}
			
		    sSqlStr ="select case when 	(select max(order_id) from T_APPROVERS where TRAVEL_ID="+strRequistionId+" AND TRAVEL_TYPE= '"+strTraveltype+"')= (select isnull(max(order_id),-1)  from T_APPROVERS 	where TRAVEL_ID="+strRequistionId+" AND approve_status =10 AND TRAVEL_TYPE= '"+strTraveltype+"')  then 'y' else 'n' end  " ;

			stmt= con.createStatement(); 
		    rs = stmt.executeQuery(sSqlStr);
			while(rs.next()) {
				  strLastApprover_flag=rs.getString(1);
			}			
			rs.close();
			
			if(strLastApprover_flag.equals("y"))  {
				
				sSqlStr="SELECT  M_DEFAULT_APPROVERS.MATA_CC_MAIL  FROM   T_APPROVERS INNER JOIN  M_DEFAULT_APPROVERS  ON T_APPROVERS.APPROVER_ID = M_DEFAULT_APPROVERS.APPROVER_ID AND  T_APPROVERS.SITE_ID =M_DEFAULT_APPROVERS.SITE_ID  WHERE    (T_APPROVERS.SITE_ID = "+strSiteId+") AND (T_APPROVERS.TRAVEL_ID = "+strRequistionId+") AND (T_APPROVERS.TRAVEL_TYPE = '"+strTraveltype+"') AND M_DEFAULT_APPROVERS.TRV_TYPE='"+strTraveltype+"' AND T_APPROVERS.STATUS_ID=10 AND M_DEFAULT_APPROVERS.STATUS_ID=10 AND M_DEFAULT_APPROVERS.ORDER_ID=(SELECT MAX(ORDER_ID) FROM M_DEFAULT_APPROVERS A WHERE A.SITE_ID="+strSiteId+" AND A.TRV_TYPE='"+strTraveltype+"' AND A.STATUS_ID=10)";
		     		
		     	rs = dbConBean.executeQuery(sSqlStr);
			    
                if(rs.next()) {
			        strMailID_MataAsso	=	rs.getString(1);//Mail ID of CC mails 
			        
			        if (strMailID_MataAsso==null || strMailID_MataAsso.equals("")) {
			        		strMailID_MataAsso=strRequistionCreatorMail;
					}
			   }
			} else {
				strMailID_MataAsso="";
			}
			
			rs=null;
			String strTempflag="";
			sSqlStr="select case when not exists(select  1 FROM T_APPROVERS WHERE (TRAVEL_ID = '"+strRequistionId+"') AND (TRAVEL_TYPE = '"+strTraveltype+"') AND APPROVE_STATUS=0 AND STATUS_ID=10) then 'y' else 'n' end";
			 rs = dbConBean.executeQuery(sSqlStr);
			 if(rs.next()) {
				 strTempflag=rs.getString(1);
			 }

			 if(strTempflag.equals("y")) {
		      	  sSqlStr="SELECT isnull(MDA.MATA_CC_MAIL,'') FROM T_APPROVERS TA"+
		 			 " INNER JOIN M_DEFAULT_APPROVERS MDA"+
		 			 " ON MDA.SITE_ID=TA.SITE_ID AND MDA.APPROVER_ID=TA.APPROVER_ID"+ 
		 			 " WHERE (TA.SITE_ID = '"+strSiteId+"') AND (TA.TRAVEL_ID = '"+strRequistionId+"') AND (TA.TRAVEL_TYPE = '"+strTraveltype+"') AND MDA.TRV_TYPE='"+strTraveltype+"' AND TA.STATUS_ID=10 AND MDA.STATUS_ID=10"+
		 			 " AND TA.ORDER_ID=(SELECT MAX(ORDER_ID) FROM T_APPROVERS WHERE (TRAVEL_ID = '"+strRequistionId+"') AND (TRAVEL_TYPE = '"+strTraveltype+"') AND APPROVE_STATUS=10 AND STATUS_ID=10) AND TA.ROLE<>'MATA' "+
		 			 " and sp_role = (select sp_role from m_userinfo where userid='"+strTravellerId+"' and loginstatus in ('ACTIVE','ENABLE'))";
		 			 rs4 = dbConBean.executeQuery(sSqlStr);
		        	  if(rs4.next()){
		        	  	strMailID_MataAsso	=	rs4.getString(1);
		        	  }
		          }
			
				if(ReqTyp.equals("Domestic Travel")) {
					strSql="select isnull(dbo.USEREMAIL(ORIGINAL_APPROVER),'') as  ORIGINAL_APPROVER from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='d' and approve_status='0'";
			
				} else {
					strSql="select isnull(dbo.USEREMAIL(ORIGINAL_APPROVER),'') as  ORIGINAL_APPROVER from t_approvers where (TRAVEL_ID = "+strRequistionId+") and travel_type='i' and approve_status='0'";
				}
			
				rs = dbConBean.executeQuery(strSql);
			 	if(rs.next()) {
			  	    strMailID_OrignalApprover	=	rs.getString(1);//Mail ID of CC mails 						 
			    }
			 	
			 	if (!strMailID_MataAsso.equals("")) {
			 		strMailID_MataAsso=strMailID_MataAsso+";"+strMailID_OrignalApprover;			 	
			 	} else {
			 		strMailID_MataAsso=strMailID_MataAsso+strMailID_OrignalApprover;
			 	}	 
			 	
			 	String strSqlQuery = "SELECT DBO.[FN_FIND_ACTIVE_CC_EMAIL]('"+strMailID_MataAsso+"') as CC_USER_EMAIL;";
				String strActiveCCUserMail = "" ;
				stmt = con.createStatement(); 
				rs = stmt.executeQuery(strSqlQuery);
				if(rs.next()) {
					strActiveCCUserMail =  rs.getString("CC_USER_EMAIL")==null?"":rs.getString("CC_USER_EMAIL").trim();
				}
				
				Iterator itr =  aList.iterator();
				while(itr.hasNext()) {
					strstrRequistionNextApproverName       = (String) itr.next();
					strstrRequistionNextApproverEmail      = (String) itr.next();
					
					strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strstrRequistionNextApproverEmail+"' AND STATUS_ID=10";
					stmt2= con.createStatement(); 
					rs3 = stmt2.executeQuery(strSql);
					if(rs3.next()){
						strsesLanguage=rs3.getString("LANGUAGE_PREF");
						if(strsesLanguage==null || strsesLanguage.equals("")){
							strsesLanguage="en_US";
						}
					}
					rs3.close();
					stmt2.close();
					
					
					strMailMsg = new StringBuffer();
					strCreationDate	=	strMailCreatedate;
			  
					if(strTransitType.trim().equalsIgnoreCase("2")) {
					 	strTrasitMsg1="<font size=2 color=red >"+dbLabelBean.getLabel(strTrasitMsg,strsesLanguage)+"</font><br>";
					 }
					
					String groupGuestLabel = "";
					if(strTravelAgencyTypeId.equals("2")){
						groupGuestLabel = "label.global.guest";
					}else{
						groupGuestLabel = "label.approverequest.groupguest";
					}
					
				   if(strISLastapprover.equals("no")) {
					   
				   if(strMailFlag.equals("N") || strMailDir.equals("A2R")){
					   if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						   strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject
					   } else {
						   strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mainmenu.pendingforapproval",strsesLanguage)+" ";//Mail Subject 
					   }
					
					try {
						
						dbUtilityBean = new DbUtilityMethods();
						String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strstrRequistionNextApproverEmail); //Added by vaibhav

						strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
						strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
						strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
						strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
						strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+ "\n"); 				
						strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strstrRequistionNextApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedby",strsesLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenapprovedbyme",strsesLanguage)+"</p>"+ "\n"); 
						strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+" </u>:-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 
						strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)+" </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
						
						if((strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {
							strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyGmbh(strRequistionId, strTraveltype, strTravellerId));
						}else{
							strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyIndia(strRequistionId, strTraveltype, strTravellerId, strGroupTravelFlag));
						}
						
						strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strstrRequistionApproverName+" "+dbLabelBean.getLabel("label.mail.approvingcomments",strsesLanguage)+"</FONT></u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
					    strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");
						strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
						strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
						strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
						strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
						strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
						strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
						
						try {
							logger.info("sendRequisitionMailOnApproval [Pending for Approval] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
							//Procedure for inserting Mail Data
							cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
							cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt_mail.setString(2, strRequistionId);
							cstmt_mail.setString(3, strRequistionNumber);
							cstmt_mail.setString(4, strstrRequistionNextApproverEmail);//To
							cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
							cstmt_mail.setString(6, strActiveCCUserMail);//CC  mail will go to mata Associates
							cstmt_mail.setString(7, strMailSubject);
							cstmt_mail.setString(8, strMailMsg.toString());
							cstmt_mail.setInt(9, intTries);
							cstmt_mail.setString(10, "NEW");
							cstmt_mail.setString(11, strApproverId);
							cstmt_mail.setString(12, "Approval Process");
							cstmt_mail.setString(13, "Signatory Approves IT");
			                cstmt_mail.execute();
							cstmt_mail.close(); 
							logger.info("sendRequisitionMailOnApproval [Pending for Approval] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
						}
						catch(Exception b) {
							System.out.println("ERROR in sendRequisitionMailOnApproval---1--------"+b);
						}
					}
					catch(Exception e) {
						System.out.println("Error in sendRequisitionMailOnApproval--------------2-------------"+e);
					}
				   }// IF END

				  }//if of last approver
				   else {					   
					   String strTravellerMail="";
					 	if(!strTravellerId.equals(strCreatorID)) {			
							String strQuery1 = "SELECT DBO.USEREMAIL(MUI.USERID) AS TRAVELLEREMAIL FROM M_USERINFO MUI WHERE MUI.USERID="+strTravellerId+" AND MUI.STATUS_ID=10 AND MUI.APPLICATION_ID=1"; 
							rs = dbConBean.executeQuery(strQuery1);
							if(rs.next()){
								strTravellerMail =  rs.getString("TRAVELLEREMAIL");
							}
							if(!"".equals(strTravellerMail)) {
						 		strCC_CreatorMail = strCC_CreatorMail+";"+strTravellerMail;
							}
						}
					   
					 	logger.info("sendRequisitionMailOnApproval [Travel Agency Type Id] " +strTravelAgencyTypeId+ " for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
					    // Send Mail to TRAVEL MATA GmbH/India and Travel Coordinator
						if(strTravelAgencyTypeId != null && !"".equals(strTravelAgencyTypeId) && !"0".equals(strTravelAgencyTypeId) && "Y".equals(strMailToMATA)) {
							
							if(!isAdvanceTravelRequest(strTravelId, strTrvType, strTravelAgencyTypeId)) {
								
								logger.info("sendRequisitionMailOnApproval [Send Mail to TRAVEL MATA GmbH/India] Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
								
								String strMataGmbHMailContent = "";
								String functionKey = "";
								String adminIDFlag = "";
								
							   if(strTravelAgencyTypeId.equals("1")) {
									
									functionKey = "@MataindiaSite";
									adminIDFlag = "AND M_USERINFO.USERID=1129";
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getGroupMailBodyForMataIndia(strRequistionId, strTrvType, strTravellerId);
									} else if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("N"))){
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getMailBodyForMataIndia(strRequistionId, strTrvType, strTravellerId);
									}
								} else if(strTravelAgencyTypeId.equals("2")) {	
									
									functionKey = "@MataGmbHSite";
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getGroupMailBodyForMataGmbH(strRequistionId, strTrvType, strTravellerId);
									} else if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("N"))){
										 strMataGmbHMailContent = new T_QuicktravelRequestDaoImpl().getMailBodyForMataGmbH(strRequistionId, strTrvType, strTravellerId);
									}
								}  
								
								String firstDepartureDate = "";
								String strSqlDepartureDate = "";
								if("I".equals(strTrvType) || "INT".equals(strTrvType)){
									strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strRequistionId;
								}else if("D".equals(strTrvType) || "DOM".equals(strTrvType)){
									strSqlDepartureDate = "SELECT CONVERT(VARCHAR(10),MIN(TRAVEL_DATE),103) AS FIRST_JOURNY_DATE FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strRequistionId;
								}
								
								stmt2=null;
								rs2=null;
								stmt2= con.createStatement(); 
								rs2 = stmt2.executeQuery(strSqlDepartureDate);
								if(rs2.next()){
									firstDepartureDate=rs2.getString("FIRST_JOURNY_DATE");
								}
								rs2.close();
								stmt2.close();
								
								String strSqlTravellerName = "";
								String strGrpTravellerName = "";
								int grpTravllerCount  		= 0;
								
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
									strSqlTravellerName = "SELECT TOP 1 LTRIM(RTRIM(FIRST_NAME)) +' '+ LTRIM(RTRIM(ISNULL(LAST_NAME,''))) AS TRAVELLER, COUNT(*) OVER (partition by 1) TRAVELLERCOUNT FROM T_GROUP_USERINFO WHERE TRAVEL_ID="+strRequistionId+" AND SITE_ID="+strSiteId+" AND TRAVEL_TYPE='"+strTrvType+"' AND STATUS_ID=10 ORDER BY G_USERID";
									
									stmt2=null;
									rs2=null;
									stmt2= con.createStatement(); 
									rs2 = stmt2.executeQuery(strSqlTravellerName);
									if(rs2.next()){
										strGrpTravellerName	=	rs2.getString("TRAVELLER");
										grpTravllerCount 	=	rs2.getInt("TRAVELLERCOUNT") - 1;
									}
									rs2.close();
									stmt2.close();									
								}
								
								
							
								String emailIdsMataSql = "";
								
								
								if("I".equals(strTrvType) || "INT".equals(strTrvType)) {
									
									emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_INT TDI "+ 
											" INNER JOIN T_APPROVERS TA ON TDI.TRAVEL_ID=TA.TRAVEL_ID AND "+
											" TA.TRAVEL_TYPE='"+strTrvType+"' WHERE TDI.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
											" select email AS MATAGMBH from m_userinfo "+ 
											" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='"+functionKey+"') and role_id ='MATA' and "+ 
											" exists(select 1 from T_TRAVEL_DETAIL_INT tdi inner join m_site s on tdi.SITE_ID = s.site_id "+ 
											" WHERE TRAVEL_ID="+strRequistionId+" and TRAVEL_AGENCY_ID="+strTravelAgencyTypeId+") and M_USERINFO.STATUS_ID=10 " + adminIDFlag + " UNION "+
											" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_INT TDI "+
											" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDI.SITE_ID=UMA.SITE_ID "+
											" WHERE TDI.TRAVEL_ID="+strRequistionId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
									
								} else if("D".equals(strTrvType) || "DOM".equals(strTrvType)) {
									
									emailIdsMataSql = " select DBO.USEREMAIL(APPROVER_ID) MATAGMBH from T_TRAVEL_DETAIL_DOM TDD "+
											" INNER JOIN T_APPROVERS TA ON TDD.TRAVEL_ID=TA.TRAVEL_ID AND "+
											" TA.TRAVEL_TYPE='"+strTrvType+"' WHERE TDD.TRAVEL_ID="+strRequistionId+" AND TA.ROLE='MATA' UNION "+
											" select email AS MATAGMBH from m_userinfo "+ 
											" WHERE site_id in (select FUNCTION_VALUE from  functional_ctl where function_key='"+functionKey+"') and role_id ='MATA' and "+ 
											" exists(select 1 from T_TRAVEL_DETAIL_DOM tdd inner join m_site s on tdd.SITE_ID = s.site_id "+ 
											" WHERE TRAVEL_ID="+strRequistionId+" and TRAVEL_AGENCY_ID="+strTravelAgencyTypeId+") and M_USERINFO.STATUS_ID=10 " + adminIDFlag + " UNION "+
											" SELECT DBO.USEREMAIL(USERID) MATAGMBH FROM T_TRAVEL_DETAIL_DOM TDD "+
											" INNER JOIN  USER_MULTIPLE_ACCESS UMA ON TDD.SITE_ID=UMA.SITE_ID "+
											" WHERE TDD.TRAVEL_ID="+strRequistionId+" AND UMA.TRAVEL_COORDINATOR =1 AND UMA.STATUS_ID=10";			
									
								}
								
								
								ArrayList<String> emailIdsList = new ArrayList<String>();
								String emailId = "";
								String emailIds = "";
								stmt2=null;
								rs2=null;
								stmt2= con.createStatement(); 
								rs2 = stmt2.executeQuery(emailIdsMataSql);
								while(rs2.next()){
									emailId=rs2.getString("MATAGMBH");
									emailIdsList.add(emailId);
								}
								rs2.close();
								stmt2.close();
								
								StringBuilder sb = new StringBuilder();
								int size = emailIdsList.size(); 
								if (size > 0) {
									sb.append(emailIdsList.get(0));
									for (int i = 1; i < size; ++i) {
										sb.append("; ").append(emailIdsList.get(i));
								    }
									
									emailIds = sb.toString();
								}
								
								String strFromMailGmbH = "";
								String strMataGmbhSubject = "";
								
								if(strTravelAgencyTypeId.equals("1")) {
									strFromMailGmbH="administrator.stars@mind-infotech.com";
									
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {										
										strMataGmbhSubject = "STARS - Approved - ["+strGrpTravellerName+"+"+grpTravllerCount+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] ["+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+"]";
									} else {
										strMataGmbhSubject = "STARS - Approved - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"]";
									}
								}else if(strTravelAgencyTypeId.equals("2")) {
									strFromMailGmbH = strRequistionCreatorMail;
									
									if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
										strMataGmbhSubject = "STARS - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] ["+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+"] - Approved";
									} else {
										strMataGmbhSubject = "STARS - ["+strUserNm+"] - ["+firstDepartureDate+"] ["+strRequistionNumber+"] - Approved";
									}
								}
								try {
										logger.info("sendRequisitionMailOnApproval [Send Mail to TRAVEL MATA GmbH/India] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
										dbConBean								=	new DbConnectionBean();
										con1 									=	dbConBean.getConnection();
										cstmt_mail=con1.prepareCall("{call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
										cstmt_mail.setString(1, strRequistionId);
										cstmt_mail.setString(2, strRequistionNumber);
										cstmt_mail.setString(3, emailIds);//Email Ids of MATA and Travel Coordinator.
										cstmt_mail.setString(4, strFromMailGmbH);//From Admin
										cstmt_mail.setString(5, strCC_CreatorMail);
										cstmt_mail.setString(6, strMataGmbhSubject);
										cstmt_mail.setString(7, strMataGmbHMailContent);
										cstmt_mail.setString(8, "0");
										cstmt_mail.setString(9, "NEW");
										cstmt_mail.setString(10, Suser_id);
										cstmt_mail.setString(11, "New");
										cstmt_mail.setString(12, "User Submitting the Req");
										cstmt_mail.execute();
										cstmt_mail.close();
										con1.close();
										logger.info("sendRequisitionMailOnApproval [Send Mail to TRAVEL MATA GmbH/India] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
								} catch(Exception b) {	b.printStackTrace();
									System.out.println("Error in sendRequisitionMailOnApproval second mail block========="+b);	
								}
								logger.info("sendRequisitionMailOnApproval [Send Mail to TRAVEL MATA GmbH/India] End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
							}
						} 
					    
						 	if(!"".equals(strTravellerMail)) {
						 		if (!strMailID_MataAsso.equals("")) {
							 		strMailID_MataAsso=strMailID_MataAsso+";"+strTravellerMail;				 	
							 	} else {
							 		strMailID_MataAsso=strMailID_MataAsso+strTravellerMail;
							 	}
							}
						 	
						 	strSqlQuery = "SELECT DBO.[FN_FIND_ACTIVE_CC_EMAIL]('"+strMailID_MataAsso+"') as CC_USER_EMAIL;";
						 	strActiveCCUserMail = "" ;
							stmt = con.createStatement(); 
							rs = stmt.executeQuery(strSqlQuery);
							if(rs.next()) {
								strActiveCCUserMail =  rs.getString("CC_USER_EMAIL")==null?"":rs.getString("CC_USER_EMAIL").trim();
							}
						 	
						 	//this block will work when approver is last approver 
						 	// then following mail content will go to originator   
							if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
								strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" '"+strRequistionNumber.trim()+"' has been Approved ";//Mail Subject
							} else {
								strMailSubject=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' has been Approved ";//Mail Subject
							}
						try {
							dbUtilityBean = new DbUtilityMethods();
							String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strstrRequistionNextApproverEmail); //Added by vaibhav

							strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
							strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
							strMailMsg.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
							strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
							strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+ "\n"); 				
							strMailMsg.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strstrRequistionNextApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedbyyou",strsesLanguage)+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenapprovedbyme",strsesLanguage)+"</p>"+ "\n"); 
							strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details </u>:-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 
							strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Reason for Travel </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
							
							/*strMailMsg.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.report.returndate",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)+"</TD><TD width=240><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite+" </TD></TR></TABLE>");*/
							if((strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2"))) {
								strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyGmbh(strRequistionId, strTraveltype, strTravellerId));
							}else{
								strMailMsg.append(new T_QuicktravelRequestDaoImpl().customizeApproverMailBodyIndia(strRequistionId, strTraveltype, strTravellerId, strGroupTravelFlag));
							}
							
							strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+strstrRequistionApproverName+" "+dbLabelBean.getLabel("label.mail.approvingcomments",strsesLanguage)+"</FONT></u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
							if(strstrRequistionNextApproverName.trim().equalsIgnoreCase(strRequistionCreatorName.trim())){
								strMailMsg.append("</font><br><br>"+strTrasitMsg1+"<font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");
							}else{
								strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");	
							}
							
							strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strstrRequistionApproverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
							strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
							strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
							strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
							strMailMsg.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
							strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
				
							try {
								logger.info("sendRequisitionMailOnApproval [Has been Approved] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
								//Procedure for inserting Mail Data
								cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
								cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
								cstmt_mail.setString(2, strRequistionId);
								cstmt_mail.setString(3, strRequistionNumber);
								cstmt_mail.setString(4, strstrRequistionNextApproverEmail);//To
								cstmt_mail.setString(5, strstrRequistionApproverEmail);//From
								cstmt_mail.setString(6, strActiveCCUserMail);//CC  mail will go to mata Associates
								cstmt_mail.setString(7, strMailSubject);
								cstmt_mail.setString(8, strMailMsg.toString());
								cstmt_mail.setInt(9, intTries);
								cstmt_mail.setString(10, "NEW");
								cstmt_mail.setString(11, strApproverId);
								cstmt_mail.setString(12, "Approval Process");
								cstmt_mail.setString(13, "Signatory Approves IT");
				                cstmt_mail.execute();
								cstmt_mail.close(); 
								logger.info("sendRequisitionMailOnApproval [Has been Approved] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
							} catch(Exception b) {
								System.out.println("ERROR in sendRequisitionMailOnApproval---1--------"+b);	
							}
						} catch(Exception e) {
							System.out.println("Error in sendRequisitionMailOnApproval--------------2-------------"+e);
						}						
					   
				   }//else end here 
					
				}// end of while
				
				//TO SENT MAILS FROM REV TO APP AND APP TO REV.		
				if(strMailFlag.equals("Y") && (strTravelAgencyTypeId != null && !strTravelAgencyTypeId.equals("2"))){	
					StringBuffer strMailMsg1 = new StringBuffer();
					//get mail to person language preference
					stmt2=null;
					rs3=null;
					strSql	=	"SELECT LANGUAGE_PREF FROM M_USERINFO WHERE EMAIL =N'"+strToMail+"' AND STATUS_ID=10";
					stmt2= con.createStatement(); 
					rs3 = stmt2.executeQuery(strSql);
					if(rs3.next()){
						strsesLanguage=rs3.getString("LANGUAGE_PREF");
						if(strsesLanguage==null || strsesLanguage.equals("")){
							strsesLanguage="en_US";
						}
					}
					rs3.close();
					stmt2.close();
					
					String groupGuestLabel = "";
					if(strTravelAgencyTypeId.equals("2")){
						groupGuestLabel = "label.global.guest";
					}else{
						groupGuestLabel = "label.approverequest.groupguest";
					}

				   if(strMailDir.equals("R2A")){
					   dbUtilityBean = new DbUtilityMethods();
					   String strSSOUrl = dbUtilityBean.sSSOUrlByMailid(strToMail);
					   if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y"))) {
						   strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel(groupGuestLabel,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.forapproval",strsesLanguage)+" ";
					   } else {
						   strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.forapproval",strsesLanguage)+" ";
					   }
					   
					   strMailMsg1.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
					   strMailMsg1.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
					   strMailMsg1.append("</td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000> </td></tr><tr>"+ "\n");
					   strMailMsg1.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#000000> </td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
					   strMailMsg1.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=2>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.mail.requisition",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+dbLabelBean.getLabel(ReqTyp1,strsesLanguage)+" "+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" : "+strRequistionNumber.trim()+"</b> ("+dbLabelBean.getLabel("label.mail.dated",strsesLanguage)+" : "+strRequistionCreatedDate+")</font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+ "\n"); 				
					   strMailMsg1.append(dbLabelBean.getLabel("label.mail.dear",strsesLanguage)+" "+strToName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.whichwasoriginatedby",strsesLanguage)+" "+strRequistionCreatorName+" "+dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)+" "+strSiteName+" "+dbLabelBean.getLabel("label.mail.on",strsesLanguage)+" "+strRequistionCreatedDate+" "+dbLabelBean.getLabel("label.mail.hasbeenapprovedbyme",strsesLanguage)+"</p>"+ "\n"); 
					   strMailMsg1.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.requisitionsdetails",strsesLanguage)+" </u>:-</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravel+"<br>  </font>\n<br>"); 
					   strMailMsg1.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.reasonfortravel",strsesLanguage)+" </u>:- </font><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strreasonFortravel+"</font>\n<br><br>"); 
					   strMailMsg1.append("<TABLE border=0 width=750  ><TR  height=10 ><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue >"+dbLabelBean.getLabel("label.global.departuredate",strsesLanguage)+" </TD><TD    width=200><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelDate+"</TD><TD    width=170><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.departurecity",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif > :- "+strTravelFrom+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.report.returndate",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, elvetica, sans-serif > :- "+strTravelReturnDate+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.global.arrivalcity",strsesLanguage)+" </TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif>:-  "+strTravelTo+"</TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)+"</TD><TD width=240><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+text+"&nbsp;[<font size=2 face=Verdana, Arial, Helvetica, sans-serif color=red>Over Limit</font>]</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.requestdetails.billingclient",strsesLanguage)+" </TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strBillingSite+" </TD></TR><TR  height=10><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>"+dbLabelBean.getLabel("label.approverequest.travelclass",strsesLanguage)+"</TD><TD ><font size=2 face=Verdana, Arial, Helvetica, sans-serif >:- "+strTravelClass+"</TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue></TD><TD><font size=2 face=Verdana, Arial, Helvetica, sans-serif >&nbsp;</TD></TR></TABLE>");
					   strMailMsg1.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+dbLabelBean.getLabel("label.mail.reviewercomments",strsesLanguage)+" </FONT></u><br>"+strRequisitionComments.trim()+" "+ "\n"); 
					   strMailMsg1.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> "+ "\n");
					   strMailMsg1.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strFromName+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n"); 
					   strMailMsg1.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
					   strMailMsg1.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
					   strMailMsg1.append(" </tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+" "+ "\n");  
					   strMailMsg1.append(dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr>"+ "\n");    
					   strMailMsg1.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");

					   try {
						   		logger.info("sendRequisitionMailOnApproval [For Approval] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
								cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
								cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
								cstmt_mail.setString(2, "");
								cstmt_mail.setString(3, strRequistionNumber);
								cstmt_mail.setString(4, strToMail);//To
								cstmt_mail.setString(5, strFromMail);//From
								cstmt_mail.setString(6, "");
								cstmt_mail.setString(7, strMailSubject1);
								cstmt_mail.setString(8, strMailMsg1.toString());
								cstmt_mail.setInt(9, intTries);
								cstmt_mail.setString(10, "NEW");
								cstmt_mail.setString(11, Suser_id);
								cstmt_mail.setString(12, "Approval Process");
								cstmt_mail.setString(13, "Signatory Approves IT");
								cstmt_mail.execute();
								cstmt_mail.close();
								logger.info("sendRequisitionMailOnApproval [For Approval] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
						} catch(Exception b) {
							System.out.println("Error in sendRequisitionMailOnApproval second mail block=====R2A===="+b);
							b.printStackTrace();
						}
					   
				   } else if(strMailDir.equals("A2R") && strMailFwdFlag.equals("Y")) {	
					    strMailSubject1=dbLabelBean.getLabel("label.mail.starsnotification",strsesLanguage)+" "+dbLabelBean.getLabel(TType,strsesLanguage)+" '"+strRequistionNumber.trim()+"' "+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+" ";
					    
						strMailMsg1.append("<html><style>.formhead {	font-family: Arial;	font-size: 11px;	font-style: normal;	font-weight: normal;	color: #000000;");
						strMailMsg1.append("border: 1px #333333 solid;	background: #00CCFF;}</style>");
						strMailMsg1.append("<body bgcolor=#00CCFF><table width=80% align=center><tr><td align=right><font size=2><b><font color=#FFFFFF>"+strRequistionCreatedDateWithoutAMPM+"</font>");
						strMailMsg1.append("<font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.forinternalcirculationonly",strsesLanguage)+"</font></font></td>");
						strMailMsg1.append("</tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=9></table>");
						strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220>");
						strMailMsg1.append("<font size=5 color=#FFFFFF>"+dbLabelBean.getLabel("label.mail.starsmailnotification",strsesLanguage)+"</font></td></tr></table>");
						strMailMsg1.append("</td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font size=2><b>");
						strMailMsg1.append("<font	color=#FFFFFF><font size=3>"+dbLabelBean.getLabel("label.mail.forreview",strsesLanguage)+"</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font size=2></font></td></tr><tr><td><p>");
						strMailMsg1.append("<font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>Dear "+strToName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif> "+dbLabelBean.getLabel("label.mail.kindlyreviewtherequest",strsesLanguage)+" "+strRequistionNumber.trim()+" "+dbLabelBean.getLabel("label.mail.pendingwithmeandtakeappropriateaction",strsesLanguage));
						strMailMsg1.append("<br><br><font color=blue></p></font> </font><font size=2></font></p><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='https://stars.mindeservices.com'>"+dbLabelBean.getLabel("label.mail.pleaseclickheretologintostars",strsesLanguage)+" </a> </b></form>");
						strMailMsg1.append("</font><br>	<p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.bestregards",strsesLanguage)+"</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+strFromName+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center>");
						strMailMsg1.append("<font face=Verdana,Arial, Helvetica, sans-serif size=1><b>"+dbLabelBean.getLabel("label.mail.mailreferencenumber",strsesLanguage)+" </b>"+intMaliRefNumber+"/"+strCurrentYear+"</font></td></tr>");
						strMailMsg1.append("<tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5><tr>");
						strMailMsg1.append("<td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>"+dbLabelBean.getLabel("label.mail.starsadministratorcanbecontacted",strsesLanguage)+" : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000> <a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>");
						strMailMsg1.append("</tr><tr><td  align=center bgcolor=#878787 height=15> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>"+dbLabelBean.getLabel("label.mail.disclaimer",strsesLanguage)+"</b> : "+dbLabelBean.getLabel("label.mail.thiscommunicationissystemgenererated",strsesLanguage)+"  "+dbLabelBean.getLabel("label.mail.pleasedonnotreplytothismail",strsesLanguage)+" <br>"+dbLabelBean.getLabel("label.mail.ifyouarenotthecorrectrecipientforthisnotification",strsesLanguage)+"</font></td>");
						strMailMsg1.append("</tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;"+dbLabelBean.getLabel("label.mail.mindallrightsreserved",strsesLanguage)+"</font></font></td></tr></table><p>&nbsp;</p></body></html>");

						try {
									logger.info("sendRequisitionMailOnApproval [For Review] try block Start for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
									cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
									cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
									cstmt_mail.setString(2, "");
									cstmt_mail.setString(3, strRequistionNumber);
									cstmt_mail.setString(4, strToMail);//To
									cstmt_mail.setString(5, strFromMail);//From
									cstmt_mail.setString(6, "");
									cstmt_mail.setString(7, strMailSubject1);
									cstmt_mail.setString(8, strMailMsg1.toString());
									cstmt_mail.setInt(9, intTries);
									cstmt_mail.setString(10, "NEW");
									cstmt_mail.setString(11, strRequistionNextApprover_UserId);
									cstmt_mail.setString(12, "Review Process");
									cstmt_mail.setString(13, "Signatory Approves IT");
									cstmt_mail.execute();
									cstmt_mail.close();
									logger.info("sendRequisitionMailOnApproval [For Review] try block End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
							} catch(Exception b) {
								System.out.println("Error in sendRequisitionMailOnApproval second mail block=====A2R===="+b);
								b.printStackTrace();	
							}							
				   }						   	
				}
			}
			stmt.close();
			con.close();
			dbConBean.close();				
		
			logger.info("sendRequisitionMailOnApproval End for Requisition Number-->"+strTravelId+ " at " +dateFormat.format(cal.getTime()));
		} catch(Exception e) {
			System.out.println("Error in sendRequisitionMailOnApproval main try/catch block========="+ e);
	    }				
	}
	
	public static boolean isAdvanceTravelRequest(String strTravelId, String strTravelType, String strTravelAgencyId) {
		
		DbConnectionBean dbConBean	= null;
		Connection con				= null;
		Statement stmt	 			= null;
		ResultSet rs				= null;
		String sSqlStr				= ""; 
		
		dbConBean								=	new DbConnectionBean();
		con 									=	dbConBean.getConnection();
		
		boolean isAdvanceTravelRequestFlag = false;
		String strFlightTravelFlag 	= "N";
		String strTrainTravelFlag 	= "N";
		String strCarTravelFlag 	= "N";
		String strAccommoTravelFlag = "N";
		String strAdvanceTravelFlag = "N";
		
		if(("D".equals(strTravelType) || "DOM".equals(strTravelType)) && !strTravelAgencyId.equals("2")) {
			sSqlStr = " SELECT CASE WHEN EXISTS(SELECT 1 FROM T_JOURNEY_DETAILS_DOM "+
					  " WHERE TRAVEL_MODE=1 AND TRAVEL_ID="+strTravelId+" AND ISNULL(TRAVEL_FROM,'')<>'') THEN 'Y' ELSE 'N' END AS FLIGHT_TRAVEL_FLAG, "+
					  " CASE WHEN EXISTS(SELECT 1 FROM T_JOURNEY_DETAILS_DOM "+
					  " WHERE TRAVEL_MODE=2 AND TRAVEL_ID="+strTravelId+" AND ISNULL(TRAVEL_FROM,'')<>'') THEN 'Y' ELSE 'N' END AS TRAIN_TRAVEL_FLAG, "+
					  " CASE WHEN EXISTS(SELECT 1 FROM T_TRAVEL_CAR_DETAIL "+
					  " WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='D' AND STATUS_ID=10) THEN 'Y' ELSE 'N' END AS CAR_TRAVEL_FLAG, "+
					  " CASE WHEN EXISTS(SELECT 1 FROM T_TRAVEL_ACCOMMODATION "+
					  " WHERE TRAVEL_ID="+strTravelId+" AND TRAVEL_TYPE='D') THEN 'Y' ELSE 'N' END AS ACCOMMODATION_TRAVEL_FLAG, "+
					  " CASE WHEN EXISTS(SELECT 1 FROM T_TRAVEL_EXPENDITURE_DOM "+
					  " WHERE TRAVEL_ID="+strTravelId+") THEN 'Y' ELSE 'N' END AS ADVANCE_FLAG";
			
			try {
				stmt = con.createStatement(); 
				rs = stmt.executeQuery(sSqlStr);
					if(rs.next()) {
						strFlightTravelFlag  	= rs.getString("FLIGHT_TRAVEL_FLAG");
						strTrainTravelFlag 	 	= rs.getString("TRAIN_TRAVEL_FLAG");
						strCarTravelFlag 	 	= rs.getString("CAR_TRAVEL_FLAG");
						strAccommoTravelFlag 	= rs.getString("ACCOMMODATION_TRAVEL_FLAG");
						strAdvanceTravelFlag 	= rs.getString("ADVANCE_FLAG");
					}
					
					if(strFlightTravelFlag.equals("N") && strTrainTravelFlag.equals("N") && strCarTravelFlag.equals("N") && strAccommoTravelFlag.equals("N") && strAdvanceTravelFlag.equals("Y")) {
						isAdvanceTravelRequestFlag = true;
					}
					
				rs.close();
				stmt.close();
				con.close();
			} catch(SQLException se) {
			      se.printStackTrace();
			} catch(Exception e) {
			      e.printStackTrace();
			} finally{
		      try{
		         if(con!=null)
		        	 con.close();
		      }catch(SQLException se) {
		         se.printStackTrace();
		      }
			}
			
		}
		
		return isAdvanceTravelRequestFlag;
	}

}
