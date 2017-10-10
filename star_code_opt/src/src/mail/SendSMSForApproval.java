
/*
 * /***************************************************
	*Copyright (C) 2000 MIND 
	*All rights reserved.
	*The information contained here in is confidential and 
	*proprietary to MIND and forms the part of the MIND 
	*CREATED BY				:Shiv sharma
	*Date					:22 Oct 2008    
	*Description			:This class files will approver the requisiton for on SMS Receives FOR STARS System   	
	*Modification 			: 
    *Reason of Modification : 
	*Date of Modification   : 
	*Revision History		: Modified by vaibhav on jul 19 2010 to enable SSO in Mails

*********************************************************
*/

package src.mail;
 

import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Properties;
//added by vaibhav
import src.connection.*;
 
 
public class SendSMSForApproval {
	
	public static void main(String args[])
	{
		//connection Variables 
		 Connection conn			=null;
		 Connection conn1			=null;
		 Statement stmt;
		 ResultSet rs;
		 ResultSet rs1;
		 
		 CallableStatement cstmt	=null;
		 String sql="";
		 
		 String	 dbdriver			=null;
		 String	 dburl				=null;
		 String	 dbuser				=null;
		 String	 dbpwd				=null;
		 String  strMsg				="";	
		 
		 try {
			FileInputStream propfile = new FileInputStream("C:/DevWorkSpaces/Workflow/star/src/src/connection/STAR.properties");
			 if ( propfile != null)
			 {
				Properties pmsprop 	= new Properties();
				pmsprop.load( propfile);
				propfile.close();
				dbdriver			=	pmsprop.getProperty("dbdriver");
				dburl				=	pmsprop.getProperty("dburl");
				dbuser				=	pmsprop.getProperty("dbuser");
				dbpwd				=	pmsprop.getProperty("dbpwd");
				Class.forName(dbdriver);
				
				  System.out.println("dburl>>"+dburl);
					System.out.println("dbuser"+dbuser);
					System.out.println("dbpwd"+dbpwd);
				 
				
				
				conn	=DriverManager.getConnection(dburl,dbuser,dbpwd);
				conn1	=DriverManager.getConnection(dburl,dbuser,dbpwd);
			 }
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}  
		
		
		String strUserMobileNo					="";//9810202210".trim();
		
		//String strActualMAilmsg					="APD MIND/DOM/4663      # shiv  sharma to going to kanpur. ";
		//String strMailReply						=strActualMAilmsg.substring(0, strActualMAilmsg.indexOf("#")).trim();
		//System.out.println("strMailReply to parse======"+strMailReply);
		 
		// strMailReply						="RTN       MIND/DOM/4663                     ".trim();
		
		String strTravleID						="";
		String strReqNO							="";
		String strTravletype					=""; 
		String strtemp							="";
		String strTravelTypeGRFlage				="";
		String strTemp2							="";
		
		String  strUserID 						="";
		String  strUnitHEAD 					="";
		String  strRoleID						="";
		String  strEmail						="";
		String strTRaveller_id					="";
		String strOrderId        				="";
		String strTravellerSiteId 				="";
		String strIsUnitHead					=""; 
		String strBillingClient					="";
		String strApproverName					="";	
		String strTRAVELDATE					="";	
	    String strSEX							="";
		String strTravelerName					="";
		String strTravelFrom					="";
		String strTravelTO					    ="";
		String strVisaRequired					="";
		String strVisaRequiredComment			="";
		String strECRRequired					="";	
		String strRequistionCreatedDate			="";
		
		String strRequistionCreatorMail			="";//Creator Email
		String strstrRequistionApproverName		="";//APPROVER NAME
		String strstrRequistionApproverEmail	="";//APPROVER EMAIL
		String strstrRequistionNextApproverName	="";//NEXT APPROVER NAME
		String strstrRequistionNextApproverEmail="";	
		String strRequistionCreatorName			="";
		String strHrNm								="";
		String strHrMail   						="";
		String strMailID_MataAsso				="";
		String strLastApprover_flag				="";
		String strTraveltypeNew					="";
		String strStatus						="";
		String strISAprovalStatus				="";
		
		int intLastindexofSlash					=0;
		int intSeconddLastindexofSlash			=0;
	 	int intLengthofReqno	  				=0;
	 	String strMailReply						="";
	 	ArrayList aList                         =new ArrayList();
	 	int succ1=0,succ2=0, succ3=0;
	 	int succ11=0;
	 	int succ12=0;
	 	String 	strInvalidAction				="";				
	 	
		
        String strActualMAilmsg					="";//APD [s]MIND/DOM/4663      # shiv  sharma to going to kanpur. ";
        DbUtilityMethods dbutility; //added by vaibhav
        String strSSOUrl = "";		//added by vaibhav
        /*
        strResult	=	"SELECT count(*) FROM tbl_Mail_Info where Read_Mail='null'";
		
		stmt_chk								=	con_chk.createStatement();
		rs_chk									=	stmt_chk.executeQuery(strResult);
		if(rs_chk.next())
		{
			cntLoop=rs_chk.getString(1);
			intCntLoop=Integer.parseInt(cntLoop.trim());
		}
		rs_chk.close();
		stmt_chk.close();
		*/
	 	
    try {  //try block no1 start
	   	  sql = "SELECT From_No, Text_Msg, Status FROM tbl_Receive_Sms_Msg where status is null";
		  System.out.println("sql====="+sql);
			stmt = conn1.createStatement(); 
			 rs1	   = stmt.executeQuery(sql);
		 	  while (rs1.next()){
		 		  
		 			   strUserMobileNo     = rs1.getString(1).trim();
			 		   strActualMAilmsg	   = rs1.getString(2).trim(); 	
			 	  
			 		  System.out.println("strActualMAilmsg==="+strActualMAilmsg);	
			 		   strMailReply		   = strActualMAilmsg.substring(0, strActualMAilmsg.indexOf(",")).trim();   
			 		 
			 		   
			 		   System.out.println("strMailReply==="+strMailReply);	 	
				       strStatus=strMailReply.substring(0, 1);
				       
				       System.out.println("strStatus===>>"+strStatus+"<<");	 //a	
				       
				       
				       if(!strStatus.equalsIgnoreCase("A") && !strStatus.equalsIgnoreCase("J") && !strStatus.equalsIgnoreCase("A"))
					 	 {
					 		strInvalidAction="YES";
					   	}else{ 
								 	if(strStatus.equalsIgnoreCase("A")){
								 	    
								 		strStatus="Approve";
							 	    }
								 	if(strStatus.equalsIgnoreCase("R")){
								 		strStatus="RETURNED FROM WORKFLOW";
								 	}
								 	if(strStatus.equalsIgnoreCase("J")){
							 		strStatus="REJECT";
								}
					 	}
					 	 
					 	  
			
			System.out.println("strInvalidAction==="+strInvalidAction);	 	 
		
			//System.out.println("strMailReply==="+strMailReply);
		 	  
		 	// MESSAGE PARSING 
		 	intLengthofReqno=strMailReply.length();
		 	
		 	//System.out.println("strMailReply==="+strMailReply);
		 	
		 	//System.out.println(strMailReply.indexOf(" "));
		 	intLastindexofSlash=strMailReply.lastIndexOf("/");
		 	//finding A travel ID
		 	strTravleID=strMailReply.substring(intLastindexofSlash+1, intLengthofReqno);
		 	
			//System.out.println("strTravleID==="+strTravleID);
		 	//finding A travel  Req_no ID
			//System.out.println("strMailReply==="+strMailReply); 
		 	strReqNO   =strMailReply.substring(1, intLengthofReqno);
		 	//System.out.println(">>>>>>>>>>strReqNO>>"+strReqNO);
		    //finding A travel Type
		 	strtemp=strReqNO.substring(0, intLastindexofSlash);
		 	//System.out.println(">>>>>>>>>>strTemp2>>"+strtemp);
		 	strTravletype=strtemp.substring(strtemp.lastIndexOf("/")-3,strtemp.length()-1);
		 	
		 	//System.out.println(">>>>>>>>>>strTravletype==="+strTravletype);
		 	System.out.println("::::::::"+strMailReply.substring(1,strtemp.length()).trim());
		 	strTemp2=strMailReply.substring(2,strtemp.length()).trim();
			System.out.println(">>>>>>>>>>strTemp2"+strTemp2);
		 	strTravelTypeGRFlage=strTemp2.substring(0,strTemp2.indexOf("/"));
		 	
		 	if (strTravelTypeGRFlage.equals("GR")){
		 		strTravelTypeGRFlage="yes";	
		 	}
		 	else {
		 		strTravelTypeGRFlage="no";	
		 	}
		 	
		 	System.out.println("*********************Requisition Details************************");
		 	System.out.println("groutp trave>>>>>"+strTravelTypeGRFlage);
		 	System.out.println("action type >>"+strStatus);
		 	System.out.println("travel type>>>"+strTravletype);
		 	System.out.println("strTravleID >>>> "+strTravleID);
		 	System.out.println("strReqNO >>>>"+strReqNO.trim());
		 	
		 	 
		 	
	         //find the Approver Details for the M_userinfo  
		 	try {
		 		
		 		
		 		if (!strInvalidAction.equals("YES")) // if action not belongs to A-approved ,J-Reject ,R-Return 
			 	{
				 sql = " SELECT USERID,UNIT_HEAD,ROLE_ID,EMAIL, dbo.user_name(USERID) as username from " +
				 		" M_USERINFO where right(rtrim(CONTACT_NUMBER),10)=right(rtrim('"+strUserMobileNo+"'),10) " +
				 		" and status_id=10";
				 //System.out.println("sql=====>>"+sql);
				   stmt = conn.createStatement(); 
				   rs	   = stmt.executeQuery(sql);
			 	   while (rs.next()){   
		                      strUserID 		=rs.getString("USERID");
		                      strUnitHEAD 		=rs.getString("UNIT_HEAD");
		                      strRoleID			=rs.getString("ROLE_ID");
		                      strEmail			=rs.getString("EMAIL");
		                      strApproverName   =rs.getString("username");
		           } 
				   rs.close();
			/* 
			System.out.println("\n======USER Specfic detial base on his mobile no=====");
			System.out.println("strUserID  >>>>>"+strUserID);
		 	System.out.println("strUnitHEAD >>"+strUnitHEAD);
		 	System.out.println("strRoleID>>>"+strRoleID);
		 	System.out.println("strEmail >>>>"+strEmail);
		 	System.out.println("strTravleID>>>"+strTravleID);
		 	System.out.println("strTravletype>>"+strTravletype);
		 	System.out.println("strUserID  >>>>>"+strUserID);
		 	System.out.println("strStatus>>"+strStatus);
		 	*/
			System.out.println("strStatus>>"+strStatus+strTravleID);
		 		 	
		 	if (strTravletype.equalsIgnoreCase("INT")){
		 		strTravletype="I";
		 		sql="SELECT  TRAVELLER_ID FROM T_TRAVEL_DETAIL_INT WHERE " +
			 		" (STATUS_ID = 10) AND (TRAVEL_ID = "+strTravleID+")";
		 	}else{
		 		strTravletype="D";
		 		sql="SELECT  TRAVELLER_ID FROM T_TRAVEL_DETAIL_DOM WHERE " +
		 		   " (STATUS_ID = 10) AND (TRAVEL_ID = "+strTravleID+")";
		 	}
		 	
		 	stmt = conn.createStatement(); 
			rs	   = stmt.executeQuery(sql);
			while(rs.next()){			 
				strTRaveller_id 		= rs.getString("TRAVELLER_ID");
			 }
			
			//============Procedure to Update T_approver,T_travel_status and TRAVEL_REQ_COMMENTSt tabel
		   
			sql="SELECT count(*) FROM T_Approvers WHERE " +
	 		   " (STATUS_ID = 10) AND (TRAVEL_ID = "+strTravleID+") and APPROVER_ID="+strUserID+" and APPROVE_STATUS=0 and travel_type='"+strTravletype+"'" +
	 		   		" and order_id  = (select min(order_id) from T_Approvers where TRAVEL_ID = "+strTravleID+" and APPROVE_STATUS=0 and  travel_type='"+strTravletype+"')"; 
	 		stmt = conn.createStatement();
		   	System.out.println("sql======"+sql);
			rs	   = stmt.executeQuery(sql);
			while(rs.next()){			 
				 	strISAprovalStatus 	= rs.getString(1);
			 }
			System.out.println("strISAprovalStatus======"+strISAprovalStatus);
			try {
				
				if(!strISAprovalStatus.equals("0"))
				{
				//procedure to update T_approver table   
				cstmt=conn.prepareCall("{?=call PROC_USER_APPROVAL_REQ1(?,?,?,?,?)}");
				cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt.setString(2, strTravleID );
				cstmt.setString(3, strTRaveller_id);
				cstmt.setString(4, strTravletype);
				cstmt.setString(5, strUserID);
				cstmt.setString(6, strStatus.trim());
				succ1=cstmt.executeUpdate();
				cstmt.close();
				//System.out.println("Proc on T_Approvers succ11 21/10/2008"+succ1);
				
				//Procedure for checking that all approver approve this requisition or not. If all approve then this procedure update the requisition travel_status_id 10 in T_Travel_Status table 
				cstmt=conn.prepareCall("{?=call PROC_CHECK_APPROVE_STATUS(?,?)}");
				cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt.setString(2, strTravleID);
				cstmt.setString(3, strTravletype);
				succ2= cstmt.executeUpdate();
				
				cstmt.close();
				
				//System.out.println("Proc on T_Approvers succ2221/10/2008"+succ2);
				
				//Procedure to Add comment in TRAVEL_REQ_COMMENTS table
				cstmt=conn.prepareCall("{?=call PROC_TRAVEL_REQ_ADDCOMMENTS(?,?,?,?)}");
				cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				cstmt.setString(2, strTravleID);
				cstmt.setString(3, strStatus+" by "+strApproverName);
				cstmt.setString(4, strUserID);
				cstmt.setString(5, strTravletype);
			    succ3= cstmt.executeUpdate();
				
				//System.out.println("Proc on T_Approvers succ13 21/10/2008"+succ3);
				cstmt.close();
		 	  }else{
		 		  //there is no requisition with providede travel id and mobile no to approver
		 		  System.out.println("***************Requsiton  is already approves by this user*******");
		 		  
		 	  }
		 	
				
			} catch (RuntimeException e) {
				
				System.out.println(e);
			}
		 	
			//----------- 	find the Travaller Details from the T_trvale_details_INT/DOM---------  
			if (strTravletype.equals("I")){
				
			 	sql = "SELECT  TRAVELLER_ID,Site_id,ISNULL(BILLING_CLIENT,'') AS BILLING_CLIENT," +
		 			" convert(varchar(10),TRAVEL_DATE,103) as TRAVEL_DATE, " +
			 	 	" SEX,dbo.user_name(TRAVELLER_ID) as travelername," +
			 		" ISNULL(VISA_REQUIRED,'1') AS VISA_REQUIRED,ISNULL(VISA_COMMENT,'-') AS VISA_COMMENT," +
			 		" convert(varchar(30),C_DATETIME,113)as C_DATETIME," +
			 		" dbo.user_name(ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strTravleID+",'I',TRAVELLER_ID)),'-1')) AS NEXTWITH_USERID," +
			 		" ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strTravleID+",'I',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL," +
			 		" .DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL,.DBO.USER_NAME('"+strUserID+"') AS APPROVER_NAME," +
			 		" DBO.USEREMAIL('"+strUserID+"') AS APPROVER_MAIL FROM T_TRAVEL_DETAIL_INT WHERE" +
			 		" (STATUS_ID = 10) AND (TRAVEL_ID = "+strTravleID+")";
			 			strTravletype="I";
			}else{
			 sql = "SELECT  TRAVELLER_ID,Site_id,ISNULL(BILLING_CLIENT,'') AS BILLING_CLIENT," +
			 		" convert(varchar(10),TRAVEL_DATE,103) as TRAVEL_DATE, SEX,dbo.user_name(TRAVELLER_ID) as travelername," +
			 		" convert(varchar(30)," +
			 		" C_DATETIME,113) as C_DATETIME,dbo.user_name(ISNULL(RTRIM(.DBO.PRESENTAPPROVER_USERID("+strTravleID+",'D',TRAVELLER_ID)),'-1')) AS NEXTWITH_USERID," +
			 		" ISNULL(RTRIM(.DBO.PRESENTAPPROVER_MAIL("+strTravleID+",'D',TRAVELLER_ID)),'NA') AS NEXTWITH_MAIL," +
			 		" .DBO.user_name(C_USERID) AS ORIGINATOR, DBO.USEREMAIL(C_USERID)AS ORIGINATOR_MAIL," +
			 		"  .DBO.USER_NAME('"+strUserID+"') AS APPROVER_NAME, DBO.USEREMAIL('"+strUserID+"') AS APPROVER_MAIL" +
			 	    " FROM T_TRAVEL_DETAIL_DOM WHERE  (STATUS_ID = 10) AND (TRAVEL_ID = "+strTravleID+")";
			        strTravletype="D";
			 }
			
			 //System.out.println("sql=====>>"+sql);
			stmt = conn.createStatement(); 
			rs	   = stmt.executeQuery(sql);
		
			 while(rs.next()){
				strTRaveller_id 		= rs.getString("TRAVELLER_ID");
				strTravellerSiteId		=	rs.getString("Site_id");
				strBillingClient		=	rs.getString("BILLING_CLIENT").trim();	
				strTRAVELDATE			=rs.getString("TRAVEL_DATE").trim();
			    strSEX					=rs.getString("SEX").trim();  
			    strTravelerName			=rs.getString("travelername").trim();
			
			    if(strSEX.equals("1")){
			    	strSEX	 =	 "Mr.";
				}
				else{
					strSEX	 =	 "Ms.";
				}
			    
			    if(strTravletype.equals("I")){
				    strVisaRequired				=	rs.getString("VISA_REQUIRED");
				if(strVisaRequired.equals("2")) ///changed by shiv 3/28/2007
					strVisaRequired = "no";
				else
					strVisaRequired = "yes";
				strVisaRequiredComment		=	rs.getString("VISA_COMMENT");
			    }
				
				String strRequistionCreatedDate1	=	rs.getString("C_DATETIME");//Req Created Date & time
				String str							= strRequistionCreatedDate1.substring(0,17);
				strRequistionCreatedDate=str;
				strstrRequistionNextApproverName	=	rs.getString("NEXTWITH_USERID");//NEXT APPROVER NAME
				strstrRequistionNextApproverEmail	=	rs.getString("NEXTWITH_MAIL");//NEXT APPROVER NAME
				strRequistionCreatorName			=	rs.getString("ORIGINATOR");//Creator Email
				strRequistionCreatorMail			=	rs.getString("ORIGINATOR_MAIL");//Creator Email
				strstrRequistionApproverName		=	rs.getString("APPROVER_NAME");//APPROVER NAME
				strstrRequistionApproverEmail		=	rs.getString("APPROVER_MAIL");//APPROVER EMAIL
		  }
			 /*
			 System.out.println("strstrRequistionNextApproverName======="+strstrRequistionNextApproverName);
			 System.out.println("strstrRequistionNextApproverEmail===="+strstrRequistionNextApproverEmail);
			 System.out.println("strRequistionCreatorName====="+strRequistionCreatorName);
			 System.out.println("strRequistionCreatorMail======"+strRequistionCreatorMail);
			 System.out.println("strstrRequistionApproverName===="+strstrRequistionApproverName);
			 System.out.println("strstrRequistionApproverEmail====="+strstrRequistionApproverEmail);
			 System.out.println("strstrRequistionNextApproverEmail====="+strstrRequistionNextApproverEmail);
			 System.out.println("strRequistionCreatedDate====="+strRequistionCreatedDate);
			 System.out.println("");
			 System.out.println("strTravellerSiteId====="+strTravellerSiteId);
			 */
			 rs.close();
			 //Find the ECNR info for strTRaveller_id
			 sql = "SELECT ISNULL(ECNR,'1') AS ECNR FROM M_USERINFO WHERE USERID="+strTRaveller_id;
			 stmt = conn.createStatement(); 
			 rs	   = stmt.executeQuery(sql);
			 while(rs.next()){
				 strECRRequired	=	rs.getString("ECNR").trim();
				 if(strECRRequired.equals("2")) ///changed by shiv 3/28/2007
				      	strECRRequired = "no";
			   	 else
						strECRRequired = "yes";			 
			 }
			 /*	 
			 System.out.println("Approver name:::"+strstrRequistionApproverName);
			 System.out.println("strTravleID:::"+strTravleID);
			 System.out.println("strTravletype:::"+strTravletype);
			 System.out.println("strUserID:::"+strUserID);
			 */
			
		     sql	=	" select  max(order_id) AS ORDER_ID from t_approvers where approve_status=10 and  " +
			   		    " approver_id="+strUserID+" and travel_type='"+strTravletype+"'and  travel_id="+strTravleID;
		     //System.out.println("======+++====="+sql);
			     
			 stmt = conn.createStatement(); 
			 rs	   = stmt.executeQuery(sql);
			 while(rs.next()){
				 strOrderId 	= rs.getString(1);
				  if(strOrderId == null)
					    strOrderId = "-1";
				  } 
					 
		    if(strTravellerSiteId != null) {
				   sql = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS where userid="+strUserID+" and site_id="+strTravellerSiteId+" and status_id=10 and unit_head=1";
				   //System.out.println("strSql==unithead=="+sql);
				   stmt = conn.createStatement(); 
				   rs	   = stmt.executeQuery(sql);
				   while(rs.next()){
						  strIsUnitHead			=	rs.getString(1).trim();		            
				    } 
		    }
		   System.out.println("strIsUnitHead===="+strIsUnitHead);
		   
		   //Find the journey details
		    if(strTravletype.equals("I")){
			     sql = "SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_INT WHERE TRAVEL_ID="+strTravleID+"	";
			}else{
			    sql = "SELECT TRAVEL_FROM,TRAVEL_TO FROM T_JOURNEY_DETAILS_DOM WHERE TRAVEL_ID="+strTravleID+"	";
			}
			stmt = conn.createStatement(); 
			rs	 = stmt.executeQuery(sql);
			while(rs.next()){
				  strTravelFrom	=rs.getString("TRAVEL_FROM");
				  strTravelTO	=rs.getString("TRAVEL_TO");
		    }
		
			if(strTravletype.equals("I")){
					strTravletype="International Travel";
				}else{
					strTravletype="Domestic Travel";
			   }
		        
		        //find the date
		       	String strMailCreatedate		=""; 
	            Date currentDateformail 		= new Date();
				SimpleDateFormat sdfformail 	= new SimpleDateFormat("dd MMM yyyy  kk:mm");//@ Vijay 30-Mar-2007 Change date format 
				String strCurrentDateformail 	= (sdfformail.format(currentDateformail)).trim();
				strMailCreatedate=strCurrentDateformail;
			
				MailBean mailBean = new MailBean();
				if(strStatus.equalsIgnoreCase("Approve") && strIsUnitHead.equals("1")  && !strRoleID.equalsIgnoreCase("MATA") && !strISAprovalStatus.equals("0"))
				{
					//Mail to HR AND account
					System.out.println("mail should go to HR Admin and approver next because approved by UNit head");
					sql	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('HR','AC') AND STATUS_ID=10";
					//stmt = conn.createStatement(); 
					rs	 = stmt.executeQuery(sql);
					while(rs.next())
					{
						strHrNm			=	rs.getString(1);
						strHrMail		=	rs.getString(2);
				
						System.out.println("mail should go to HR Admin and approver next not a self val case");
					
					//modification by vaibhav starts
						dbutility = new DbUtilityMethods();
						strSSOUrl = dbutility.sSSOUrlByMailid(strHrMail);
						mailBean.setSSOUrl(strSSOUrl);
					//modification by vaibhav ends
					mailBean.setMailBlockFlag("IntimationMailToHRandAC");  //used for finding the block of Mail Format Block
					//mailBean.setApprovalAction("Approve"); 			   //Approve, Returned From Worflow, Reject
					mailBean.setCurrentDateTime(strMailCreatedate);		   //current date time,Mailcreate time  
					mailBean.setTravelType(strTravletype); 				   //"International Travel"
					mailBean.setTravelId(strTravleID.trim());			   //1111	
					mailBean.setTravelNumber(strReqNO.trim()); 				//"MIND/TEST/1111"
					mailBean.setMailSubjectMessage("Intimation after Unit head approval");
					mailBean.setTravelerSex(strSEX); 
					mailBean.setTravelerName(strTravelerName);
					mailBean.setGroupTravelFlag(strTravelTypeGRFlage);
					mailBean.setTravelFrom(strTravelFrom);
					mailBean.setTravelTo(strTravelTO); 
					mailBean.setDepartureDate(strTRAVELDATE);
					mailBean.setVisaRequired(strVisaRequired);
					mailBean.setVisaComment(strVisaRequiredComment);
					mailBean.setEcrRequired(strECRRequired);
					mailBean.setReqCreationDate(strRequistionCreatedDate); //Travel Requisition Creation Date
					mailBean.setNextApproverName(strstrRequistionNextApproverName);
					mailBean.setIntimatorName(strHrNm);
					mailBean.setReqCreatorName(strRequistionCreatorName);
					mailBean.setApproverName(strApproverName);
					mailBean.setApproverComments("Approved by "+strApproverName);
					mailBean.setReceipentTo(strHrMail);
					mailBean.setReceipentFrom(strstrRequistionApproverEmail);
					mailBean.setReceipentCC("");
					mailBean.setMailCreaterUserId(strUserID);
					mailBean.setAppendMailMessage("has got the Unit Head Approval");
					MailFormat mt = new MailFormat();
					mt.mailFormater(mailBean);
					}
				}
				
			  if(strStatus.equalsIgnoreCase("Approve") && !strIsUnitHead.equals("1") && !strRoleID.equalsIgnoreCase("MATA") && !strISAprovalStatus.equals("0")){
				  if(!strBillingClient.equals("self"))
					{
						if(strOrderId != null && strOrderId.equals("1.0")) 
						  {
								//Mail to HR AND account
							sql	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('HR','AC') AND STATUS_ID=10";
							//stmt = conn.createStatement(); 
							rs	 = stmt.executeQuery(sql);
							while(rs.next())
							{
								strHrNm			=	rs.getString(1);
								strHrMail		=	rs.getString(2);
								
								//modification by vaibhav starts
								dbutility = new DbUtilityMethods();
								strSSOUrl = dbutility.sSSOUrlByMailid(strHrMail);
								mailBean.setSSOUrl(strSSOUrl);
							//modification by vaibhav ends
							System.out.println("mail should go to HR Admin and approver next not a self val case");
							mailBean.setMailBlockFlag("IntimationMailToHRandAC");  //used for finding the block of Mail Format Block
							//mailBean.setApprovalAction("Approve"); //Approve, Returned From Worflow, Reject
							mailBean.setCurrentDateTime(strMailCreatedate);
							mailBean.setTravelType(strTravletype); //"International Travel"
							mailBean.setTravelId(strTravleID.trim());	//1111	
							mailBean.setTravelNumber(strReqNO.trim()); //"MIND/TEST/1111"
							mailBean.setMailSubjectMessage("Intimation after First approval");
							mailBean.setTravelerSex(strSEX); 
							mailBean.setTravelerName(strTravelerName);
							mailBean.setGroupTravelFlag(strTravelTypeGRFlage);
							mailBean.setTravelFrom(strTravelFrom);
							mailBean.setTravelTo(strTravelTO); 
							mailBean.setDepartureDate(strTRAVELDATE);
							mailBean.setVisaRequired(strVisaRequired);
							mailBean.setVisaComment(strVisaRequiredComment);
							mailBean.setEcrRequired(strECRRequired);
							mailBean.setReqCreationDate(strRequistionCreatedDate); //Travel Requisition Creation Date
							mailBean.setNextApproverName(strstrRequistionNextApproverName);
							mailBean.setIntimatorName(strHrNm);
							mailBean.setReqCreatorName(strRequistionCreatorName);
							mailBean.setApproverName(strApproverName);
							mailBean.setApproverComments("Approved by "+strApproverName);
							mailBean.setReceipentTo(strHrMail);
							mailBean.setReceipentFrom(strstrRequistionApproverEmail);
							mailBean.setReceipentCC("");
							mailBean.setMailCreaterUserId(strUserID);
							mailBean.setAppendMailMessage(" is approved by me");
							MailFormat mt = new MailFormat();
							mt.mailFormater(mailBean);
							}
						  }
					}
				}
				
				if(strRoleID!=null && strRoleID.equalsIgnoreCase("MATA") && !strISAprovalStatus.equals("0")) 
				{
					//mail of Receiving to orignator and hr /admin
					 //System.out.println("mail should go to HR Admin and approver next because approved by mata ");
					 mailBean.setMailBlockFlag("MailOnReceiveByMATAToHR");  //used for finding the block of Mail Format Block
					//mailBean.setApprovalAction("Approve"); //Approve, Returned From Worflow, Reject
					 sql	="SELECT DBO.USER_NAME(USERID),EMAIL FROM M_USERINFO WHERE SITE_ID="+strTravellerSiteId+" AND ROLE_ID IN ('HR','AC') AND STATUS_ID=10";
					//stmt = conn.createStatement(); 
						rs	 = stmt.executeQuery(sql);
						while(rs.next())
						{
							strHrNm			=	rs.getString(1);
							strHrMail		=	rs.getString(2);
							aList.add(strHrNm);
							aList.add(strHrMail);
						}
						aList.add(strRequistionCreatorName);
						aList.add(strRequistionCreatorMail);
						Iterator itr =  aList.iterator();
						while(itr.hasNext())
						{	
						strstrRequistionNextApproverName       = (String) itr.next();
						strstrRequistionNextApproverEmail      = (String) itr.next(); 
						
						//modification by vaibhav starts
						dbutility = new DbUtilityMethods();
						strSSOUrl = dbutility.sSSOUrlByMailid(strstrRequistionNextApproverEmail);
						mailBean.setSSOUrl(strSSOUrl);
						//modification by vaibhav ends
							
						mailBean.setCurrentDateTime(strMailCreatedate);
						mailBean.setTravelType(strTravletype); //"International Travel"
						mailBean.setTravelId(strTravleID.trim());	//1111	
						mailBean.setTravelNumber(strReqNO.trim()); //"MIND/TEST/1111"
						mailBean.setMailSubjectMessage("");
						mailBean.setTravelerSex(strSEX); 
						mailBean.setTravelerName(strTravelerName);
						mailBean.setGroupTravelFlag(strTravelTypeGRFlage);
						mailBean.setTravelFrom(strTravelFrom);
						mailBean.setTravelTo(strTravelTO); 
						mailBean.setDepartureDate(strTRAVELDATE);
						mailBean.setVisaRequired(strVisaRequired);
						mailBean.setVisaComment(strVisaRequiredComment);
						mailBean.setEcrRequired(strECRRequired);
						mailBean.setReqCreationDate(strRequistionCreatedDate); //Travel Requisition Creation Date
						mailBean.setNextApproverName(strRequistionCreatorName);
						mailBean.setIntimatorName(strstrRequistionNextApproverName);
						mailBean.setReqCreatorName(strRequistionCreatorName);
						mailBean.setApproverName(strApproverName);
						mailBean.setApproverComments("Approved by "+strApproverName);
						mailBean.setReceipentTo(strstrRequistionNextApproverEmail);
						mailBean.setReceipentFrom(strstrRequistionApproverEmail);
						mailBean.setReceipentCC("");
						mailBean.setMailCreaterUserId(strUserID);
						
						MailFormat mt = new MailFormat();
						mt.mailFormater(mailBean);
						}
					
				}else
				{
					if(strStatus.equalsIgnoreCase("Approve") && !strISAprovalStatus.equals("0"))
					{
						System.out.println("REQUISITON IS APPROVED:: Approveed by "+strApproverName);
						if(strTravletype.equals("International Travel")){
							strTraveltypeNew="i";
						}else{
							strTraveltypeNew="D";
						}
						//select the  CC mail Associate  when next approver is mata 
						sql ="select case when 	(select max(order_id) from T_APPROVERS where TRAVEL_ID="+strTravleID+" AND TRAVEL_TYPE= '"+strTraveltypeNew+"')=(select order_id from T_APPROVERS where order_id = (select isnull(max(order_id),-1)  from T_APPROVERS 	where TRAVEL_ID="+strTravleID+" AND approve_status =10 AND TRAVEL_TYPE= '"+strTraveltypeNew+"')  	and TRAVEL_ID="+strTravleID+" AND TRAVEL_TYPE='"+strTraveltypeNew+"')  then 'y' else 'n' end  " ;
						rs = stmt.executeQuery(sql);
						while(rs.next()){
								  strLastApprover_flag=rs.getString(1);
						 }
							if(strLastApprover_flag.equals("y")) 
							{
						    //code that send CC mail to mata Assoctias for intimaton  
							  sql="SELECT  M_DEFAULT_APPROVERS.MATA_CC_MAIL  FROM   T_APPROVERS INNER JOIN  M_DEFAULT_APPROVERS  ON T_APPROVERS.APPROVER_ID = M_DEFAULT_APPROVERS.APPROVER_ID AND  T_APPROVERS.SITE_ID =M_DEFAULT_APPROVERS.SITE_ID  WHERE    (T_APPROVERS.SITE_ID = "+strTravellerSiteId+") AND (T_APPROVERS.TRAVEL_ID = "+strTravleID+") AND (T_APPROVERS.TRAVEL_TYPE = '"+strTraveltypeNew+"') AND M_DEFAULT_APPROVERS.TRV_TYPE='"+strTraveltypeNew+"' AND T_APPROVERS.STATUS_ID=10 AND M_DEFAULT_APPROVERS.STATUS_ID=10 AND M_DEFAULT_APPROVERS.ORDER_ID=(SELECT MAX(ORDER_ID) FROM M_DEFAULT_APPROVERS A WHERE A.SITE_ID="+strTravellerSiteId+" AND A.TRV_TYPE='"+strTraveltypeNew+"' AND A.STATUS_ID=10)"; 

							  rs = stmt.executeQuery(sql);
						          if(rs.next()){
						           	  strMailID_MataAsso	=	rs.getString(1);//Mail ID of CC mails 
									  if (strMailID_MataAsso==null || strMailID_MataAsso.equals("")){
										  strMailID_MataAsso=strRequistionCreatorMail;
										}
						          }
							}
							else{
							strMailID_MataAsso="";
							}
						System.out.println("strTravelTypeGRFlage======"+strTravelTypeGRFlage);
						
						
						//modification by vaibhav starts
						dbutility = new DbUtilityMethods();
						strSSOUrl = dbutility.sSSOUrlByMailid(strstrRequistionNextApproverEmail);
						mailBean.setSSOUrl(strSSOUrl);
						//modification by vaibhav ends
						
						mailBean.setMailBlockFlag("MailOnApprove");  //used for finding the block of Mail Format Block
						mailBean.setCurrentDateTime(strMailCreatedate);
						mailBean.setTravelType(strTravletype); //"International Travel"
						mailBean.setTravelId(strTravleID.trim());	//1111	
						mailBean.setTravelNumber(strReqNO.trim()); //"MIND/TEST/1111"
						mailBean.setMailSubjectMessage("");
						mailBean.setTravelerSex(strSEX); 
						mailBean.setTravelerName(strTravelerName);
						mailBean.setGroupTravelFlag(strTravelTypeGRFlage);
						mailBean.setTravelFrom(strTravelFrom);
						mailBean.setTravelTo(strTravelTO); 
						mailBean.setDepartureDate(strTRAVELDATE);
						mailBean.setVisaRequired(strVisaRequired);
						mailBean.setVisaComment(strVisaRequiredComment);
						mailBean.setEcrRequired(strECRRequired);
						mailBean.setReqCreationDate(strRequistionCreatedDate); //Travel Requisition Creation Date
						mailBean.setNextApproverName(strstrRequistionNextApproverName);
						mailBean.setIntimatorName("");
						mailBean.setReqCreatorName(strRequistionCreatorName);
						mailBean.setApproverName(strApproverName);
						mailBean.setApproverComments("Approved by "+strApproverName);
						mailBean.setReceipentTo(strstrRequistionNextApproverEmail);
						mailBean.setReceipentFrom(strstrRequistionApproverEmail);
						mailBean.setReceipentCC(strMailID_MataAsso);
						mailBean.setMailCreaterUserId(strUserID);
						
						MailFormat mt = new MailFormat();
						mt.mailFormater(mailBean);
						
					}

					if(strStatus.equalsIgnoreCase("REJECT") && !strISAprovalStatus.equals("0"))
					{
						//modification by vaibhav starts
						dbutility = new DbUtilityMethods();
						strSSOUrl = dbutility.sSSOUrlByMailid(strRequistionCreatorMail);
						mailBean.setSSOUrl(strSSOUrl);
						//modification by vaibhav ends
						System.out.println("REQUISITON IS SEJECT");
						//Requisition mail on Reject
						mailBean.setMailBlockFlag("MailOnReject");  //used for finding the block of Mail Format Block
						//mailBean.setApprovalAction("Approve"); //Approve, Returned From Worflow, Reject
						
						mailBean.setCurrentDateTime(strMailCreatedate);
						mailBean.setTravelType(strTravletype); //"International Travel"
						mailBean.setTravelId(strTravleID.trim());	//1111	
						mailBean.setTravelNumber(strReqNO.trim()); //"MIND/TEST/1111"
						mailBean.setMailSubjectMessage("");
						mailBean.setTravelerSex(strSEX); 
						mailBean.setTravelerName(strTravelerName);
						mailBean.setGroupTravelFlag(strTravelTypeGRFlage);
						mailBean.setTravelFrom(strTravelFrom);
						mailBean.setTravelTo(strTravelTO); 
						mailBean.setDepartureDate(strTRAVELDATE);
						mailBean.setVisaRequired(strVisaRequired);
						mailBean.setVisaComment(strVisaRequiredComment);
						mailBean.setEcrRequired(strECRRequired);
						mailBean.setReqCreationDate(strRequistionCreatedDate); //Travel Requisition Creation Date
						mailBean.setNextApproverName(strRequistionCreatorName);
						mailBean.setIntimatorName("");
						mailBean.setReqCreatorName(strRequistionCreatorName);
						mailBean.setApproverName(strApproverName);
						mailBean.setApproverComments("Rejected By "+strApproverName);
						mailBean.setReceipentTo(strRequistionCreatorMail);
						mailBean.setReceipentFrom(strstrRequistionApproverEmail);
						mailBean.setReceipentCC("");
						mailBean.setMailCreaterUserId(strUserID);
						
						MailFormat mt = new MailFormat();
						mt.mailFormater(mailBean);
					}

					if(strStatus.equalsIgnoreCase("RETURNED FROM WORKFLOW") && !strISAprovalStatus.equals("0"))
					{
						//modification by vaibhav starts
						dbutility = new DbUtilityMethods();
						strSSOUrl = dbutility.sSSOUrlByMailid(strRequistionCreatorMail);
						mailBean.setSSOUrl(strSSOUrl);
						//modification by vaibhav ends
						
						
						System.out.println("RETURNED FROM WORKFLOW");
						//	Requisition mail on Returned	
						mailBean.setMailBlockFlag("MailOnReturn");  //used for finding the block of Mail Format Block
						//mailBean.setApprovalAction("Approve"); //Approve, Returned From Worflow, Reject
						
						mailBean.setCurrentDateTime(strMailCreatedate);
						mailBean.setTravelType(strTravletype); //"International Travel"
						mailBean.setTravelId(strTravleID.trim());	//1111	
						mailBean.setTravelNumber(strReqNO.trim()); //"MIND/TEST/1111"
						mailBean.setMailSubjectMessage("");
						mailBean.setTravelerSex(strSEX); 
						mailBean.setTravelerName(strTravelerName);
						mailBean.setGroupTravelFlag(strTravelTypeGRFlage);
						mailBean.setTravelFrom(strTravelFrom);
						mailBean.setTravelTo(strTravelTO); 
						mailBean.setDepartureDate(strTRAVELDATE);
						mailBean.setVisaRequired(strVisaRequired);
						mailBean.setVisaComment(strVisaRequiredComment);
						mailBean.setEcrRequired(strECRRequired);
						mailBean.setReqCreationDate(strRequistionCreatedDate); //Travel Requisition Creation Date
						mailBean.setNextApproverName(strRequistionCreatorName);
						mailBean.setIntimatorName("");
						mailBean.setReqCreatorName(strRequistionCreatorName);
						mailBean.setApproverName(strApproverName);
						mailBean.setApproverComments("Returned by "+strApproverName);
						mailBean.setReceipentTo(strRequistionCreatorMail);
						mailBean.setReceipentFrom(strstrRequistionApproverEmail);
						mailBean.setReceipentCC("");
						mailBean.setMailCreaterUserId(strUserID);
						//mailBean.setGroupTravelFlag(strTravelTypeGRFlage)
						
						MailFormat mt = new MailFormat();
						mt.mailFormater(mailBean);
					}
					
			    }
			  
			 	}
		 	
		 	  }//codition for invalid action close
		 	//End of Try
					   catch (SQLException e) {
							
						System.out.println(e);
		   }	
					   
					   
					   
			  if (succ1>0 && succ3>0 && !strInvalidAction.equals("YES")){
			 		  String strms=strReqNO+" has been "+strStatus; 
			 		  System.out.println("strms====="+strms); 
			 		   // update received table when status is done based on mobile no and req no with status "D"
			 	 		  	try {
			 	 		  		
			 	 		  		System.out.println("strUserMobileNo====="+strUserMobileNo);
			 	 		  	    System.out.println("strReqNO====="+strReqNO);
			 	 		  		
			 		  			cstmt=conn.prepareCall("{?=call SPG_INS_UPD_RECV_MSG(?,?,?,?)}");
								cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
								cstmt.setString(2, strUserMobileNo.trim());
								cstmt.setString(3, strReqNO.trim());
								cstmt.setString(4, "D");
								cstmt.setString(5, "UPDATE");
								succ11= cstmt.executeUpdate();
								cstmt.close();
							} catch (Exception e) {
								// TODO Auto-generated catch block
								System.out.println(e);
							}
							System.out.println("succ11=======>>"+succ11);
						///Insert a row in send table when status is done based on mobile no
						    cstmt=conn.prepareCall("{?=call SPG_INS_UPD_SEND_MSG(?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						    cstmt.setString(2, strUserMobileNo);
							cstmt.setString(3, strms);
							cstmt.setString(4, "INSERT");
							succ12 =cstmt.executeUpdate();
						    cstmt.close();
						    System.out.println("succ3====after last proc"+succ3);
		 		 	  }else{//case of Error 
		 		 		  
		 		 		 String strms=strReqNO+ " Request could not be processe ";
		 	                   	 		 
			 		      //System.out.println("strms====="+strms);
			 		      //Proc to update recevied table based on mobile no and Req no
				 		  	cstmt=conn.prepareCall("{?=call SPG_INS_UPD_RECV_MSG(?,?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
							cstmt.setString(2, strUserMobileNo);
							cstmt.setString(3, strReqNO);
							cstmt.setString(4, "E");
							cstmt.setString(5, "UPDATE");
							succ1= cstmt.executeUpdate();
						    cstmt.close();
				 		    
				 		 //Insert a row in send table when status is done based on mobile no
						    cstmt=conn.prepareCall("{?=call SPG_INS_UPD_SEND_MSG(?,?,?)}");
							cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						    cstmt.setString(2, strUserMobileNo);
							cstmt.setString(3, strms);
							cstmt.setString(4, "INSERT");
							succ2= cstmt.executeUpdate();
						    cstmt.close();
				 		     
							//System.out.println("in case of Error block  succ2===="+succ2);     
		 		 		  
		 		 	  }
		 	  }	//End of Main WHILE	
		   		
		} catch (SQLException e1) { ///try block no1
			System.out.println("Error in final catch block======of SendSMSForApproval.java "+e1);
		}
	 	
		 
		} //END OF MAIN	
	 
}
