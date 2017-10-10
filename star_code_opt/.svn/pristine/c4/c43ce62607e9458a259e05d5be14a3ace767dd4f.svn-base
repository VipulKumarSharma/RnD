/***************************************************
*Copyright (C) 2008 MIND
*All rights reserved.
*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Sachin Gupta.
*Date			:	16/10/2008 (DD/MM/YYYY format)
*Description	:	General Class For Diffrent Mail Formation
*Project		:	STAR
*Date of Modification  :
*Modified by vaibhav on jul 19 2010 to enable SSO in Mails
**********************************************************/ 

package src.mail;

import src.connection.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MailFormat {
	
	/**************************************************************************************
	 * This method used of generating diffrent Mail Body as per the received request.
	 **************************************************************************************/
	public void mailFormater(MailBean mailBean){
		try{
			DbUtilityMethods dbUtility		=	new DbUtilityMethods();
			String strMailRefNumber			=	dbUtility.getMailRefNo();
			String strMailSubject			=	"";
			StringBuffer strMailMsg			= 	new StringBuffer();
			
			String travelType				=	mailBean.getTravelType();
			String travelNumber				=	mailBean.getTravelNumber();
			String mailSubjectMessage		=	mailBean.getMailSubjectMessage();
			String travelerSex				=	mailBean.getTravelerSex(); 
			String travelerName				=	mailBean.getTravelerName();
			String groupTravelFlag			=	mailBean.getGroupTravelFlag();
			String travelFrom				=	mailBean.getTravelFrom();
			String travelTo					=	mailBean.getTravelTo(); 
			String departureDate			=	mailBean.getDepartureDate();
			String visaRequired				= 	mailBean.getVisaRequired();
			String visaComment				=	mailBean.getVisaComment();
			String ecrRequired				=	mailBean.getEcrRequired();
			String mailBlockFlag			=	mailBean.getMailBlockFlag();  //used for finding the block of Mail Format Block
			String approvalAction			=   mailBean.getApprovalAction(); //Approve, Returned From Worflow, Reject
			String reqCreationDate			=	mailBean.getReqCreationDate(); //Travel Requisition Creation Date
			String nextApproverName			=	mailBean.getNextApproverName();		
			String reqCreatorName			=   mailBean.getReqCreatorName();
			String approverName				=	mailBean.getApproverName();
			String approverComments			=	mailBean.getApproverComments();
			String currentDateTime			=	mailBean.getCurrentDateTime();
			String appendMailMessage		=	mailBean.getAppendMailMessage(); //used in Intimation Mail of HRandAdmin block. Message are: For Simple Case Message--> is approved by me.  For Unit Head Case Message--> has got the Unit Head Approval  
			String strCurrentYear			=	"";
			String strGroupTravelMessage	=	"";
			String strSSOUrl 				=	mailBean.getSSOUrl(); //added by vaibhav
			
			
			
			
			//get Current Year
			Date currentDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			strCurrentYear	=	sdf.format(currentDate);
			
			System.out.println("groupTravelFlag====="+groupTravelFlag);
			
			//	set group message if groupTravelFlag is yes
			if(groupTravelFlag.equalsIgnoreCase("yes")){
				strGroupTravelMessage	=	"A <B>Group</b> is scheduled to travel.";
			}else{
				strGroupTravelMessage = travelerSex+" "+"<b> "+travelerName+ "</b> is scheduled to travel.";
			}
			
			if(mailBlockFlag.equalsIgnoreCase("MailOnApprove")){
				
				
				strMailSubject="STARS Notification: "+travelType+" '"+travelNumber.trim()+"' pending for Approval ";//Mail Subject
				
				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+currentDateTime+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000><img src=\"http://SmailUrl:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000><img src=\"http://SmailUrl:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>:: STARS Mail NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://SmailUrl:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000><img src=\"http://SmailUrl:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#000000><img src=\"http://SmailUrl:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+travelType+" Requisition</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+travelType+" Requisition Number : "+travelNumber.trim()+"</b>(Dated : "+reqCreationDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
				strMailMsg.append(" Dear "+nextApproverName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Requisition Number "+travelNumber.trim()+" which was generated by "+reqCreatorName+" on "+reqCreationDate+" has been approved by me.</p>"+ "\n"); 				
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravelMessage+"<br> Departure Date  is "+departureDate+".  </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Departure City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelFrom+" </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Arrival City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelTo+" </font>\n<br>"); 
				strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+approverName+" Approving Comments</u><br>"+approverComments.trim()+" "+ "\n"); 
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>Please click here to login to STARS </a> "+ "\n");  
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best               Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+approverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>MAIL Reference Number: </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>Disclaimer : This communication is System Generated. "+ "\n");  
				strMailMsg.append("Please do not reply to this Email. <br>If you are not the correct receipent for this notification please contact the STARS Administrator quoting the Mail Reference Number</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://SmailUrl:8080/star/images/spacer.gif\"width=1 height=1></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;MIND. All Rights Reserved.</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
				
				mailBean.setSourcePage("User Submitting the Req");  //set for SourcePage coulum of database table
			
			}else if(mailBlockFlag.equalsIgnoreCase("IntimationMailToHRandAC")){
				String intimatorName		=	mailBean.getIntimatorName();
				
				strMailSubject="STARS Notification :"+travelType+" '"+travelNumber.trim()+"' "+mailSubjectMessage;//Mail Subject
				
				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+currentDateTime+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr> \n");
				strMailMsg.append("<tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>:: STARS Mail NOTIFICATION ::</font></td></tr></table></td></tr>"+ "\n");
				strMailMsg.append("<tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+travelType+" Requisition(Intimation)</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+travelType+" Requisition Number : "+travelNumber.trim()+"</b>(Dated : "+reqCreationDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
				strMailMsg.append(" Dear "+intimatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Requisition Number "+travelNumber.trim()+" was generated by "+reqCreatorName+" on "+reqCreationDate+" "+appendMailMessage+".</p>"+ " \n"); 		//added by shiv on 3/23/2007	change 04/04/2007 vijay	
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravelMessage+"<br> Departure Date  is "+departureDate+".  </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Departure City: </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelFrom+" </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Arrival City: </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelTo+" </font>\n<br>"); 
				
				if(travelType.equals("International Travel") && (groupTravelFlag.trim().equalsIgnoreCase("NO")))
				{			
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Visa Required: </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+visaRequired+" </font>\n<br>"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Visa Comment: </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+visaComment+" </font>\n<br>"); 
					strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>ECR Required: </font></u><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+ecrRequired+" </font>\n<br>"); 
				}
				 
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>Please click here to login to STARS </a> "+ "\n");  
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best               Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+approverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>MAIL Reference Number: </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>Disclaimer : This communication is System Generated. "+ "\n");  
				strMailMsg.append("Please do not reply to this Email. <br>If you are not the correct receipent for this notification please contact the STARS Administrator quoting the Mail Reference Number</font></b></td></tr></table></td></tr> \n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;MIND. All Rights Reserved.</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");	
			}else if(mailBlockFlag.equalsIgnoreCase("MailOnReturn")){
				strMailSubject="STARS Notification :"+travelType+" '"+travelNumber.trim()+"' has been Returned ";//Mail Subject
				
				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+currentDateTime+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>:: STARS MAIL NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+travelType+" Requisition</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>Travel Requisition Number : "+travelNumber.trim()+"</b>(Dated : "+reqCreationDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 
				strMailMsg.append(" Dear "+reqCreatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Requisition Number "+travelNumber.trim()+" which was generated by you on "+reqCreationDate+" has been returned by me.</p>"+ "\n"); 	
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravelMessage+"<br> Departure Date is "+departureDate+".  </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Departure City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelFrom+" </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Arrival City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelTo+" </font>\n<br>"); 
				strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+approverName+"  Comments</u><br>"+approverComments.trim()+" "+ "\n"); 
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best               Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+approverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>MAIL Reference Number: </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>Disclaimer : This communication is System Generated. "+ "\n");  
				strMailMsg.append("Please do not reply to this Email. <br>If you are not the correct receipent for this notification please contact the STARS Administrator quoting the Mail Reference Number</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\"width=1 height=1></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;MIND. All Rights Reserved.</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
			}else if(mailBlockFlag.equalsIgnoreCase("MailOnReject")){
				strMailSubject="STARS Notification :"+travelType+" '"+travelNumber.trim()+"' has been Rejected ";//Mail Subject
				
				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+currentDateTime+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>:: STARS Mail NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+travelType+" Requisition</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+travelType+" Requisition Number : "+travelNumber.trim()+"</b>(Dated : "+reqCreationDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
				strMailMsg.append(" Dear "+reqCreatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Requisition Number "+travelNumber.trim()+" which was generated by you on "+reqCreationDate+" has been rejected by me.</p>"+ "\n"); 				
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravelMessage+"<br> Departure Date  is "+departureDate+".  </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Departure City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelFrom+" </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Arrival City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelTo+" </font>\n<br>"); 
				strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>"+approverName+" Comments</u><br>"+approverComments.trim()+" "+ "\n"); 
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>Please click here to login to STARS </a> "+ "\n");  
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best               Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+approverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>MAIL             Reference Number: </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>Disclaimer : This communication is System Generated. "+ "\n");  
				strMailMsg.append("Please do not reply to this Email. <br>If you are not the correct receipent for this notification please contact the STARS Administrator quoting the Mail Reference Number</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\"width=1 height=1></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;MIND. All Rights Reserved.</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
			}else if(mailBlockFlag.equalsIgnoreCase("MailOnReceiveByMATAToHR")){
				String intimatorName		=	mailBean.getIntimatorName();
				strMailSubject="STARS Notification: "+travelType+" '"+travelNumber.trim()+"' Received by MATA ";//Mail Subject
				
				strMailMsg.append("<html><style>.formhead{ font-family:Arial;font-size:11px;font-style: normal;font-weight:normal;color:#000000;text-decoration:none;letter-spacing:normal;word-spacing:normal;border:1px #333333 solid;background:#E2E4D6;}</style><body bgcolor=\"#d0d0d0\">" + "\n");	
				strMailMsg.append(" <table width=80% border=0 cellspacing=0 cellpadding=0 align=center><tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+currentDateTime+"</font><font color=#FFFFFF></font><font color=#000000><br></font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center>"+ "\n");
				strMailMsg.append("</td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=15><tr><td align=center bgcolor=#aa1220><font face=Arial, Helvetica, sans-serif size=5 color=#FFFFFF>:: STARS Mail NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr>"+ "\n");
				strMailMsg.append("<td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\" width=1 height=1></td></tr><tr><td bgcolor=#FFFFFF><table width=100% border=0 cellspacing=0 cellpadding=5>"+ "\n");						
				strMailMsg.append("  <tr><td align=center bgcolor=#aa1220><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF><font size=3>"+travelType+" Requisition</font> </font></b></font></td></tr><tr><td bgcolor=#878787><font face=Verdana, Arial, Helvetica, sans-serif size=2><b>"+travelType+" Requisition Number : "+travelNumber.trim()+"</b>(Dated : "+reqCreationDate+")</font></td></tr><tr><td><p><font color=#FFFFFF>.</font><font size=2 face=Verdana, Arial, Helvetica, sans-serif><br>"+ "\n"); 				
				strMailMsg.append(" Dear "+intimatorName+",</font></p><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Requisition Number "+travelNumber.trim()+" which was generated by "+reqCreatorName+" on "+reqCreationDate+" has been <b>received</b> by me.</p>"+ "\n"); 				
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Requisition Details:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+strGroupTravelMessage+"<br> Departure Date is "+departureDate+".  </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Departure City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelFrom+" </font>\n<br>"); 
				strMailMsg.append("<u><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=blue>Arrival City:-</font></u><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif >"+travelTo+" </font>\n<br>"); 
				strMailMsg.append("<br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><U><FONT COLOR=BLUE>My Comments</u><br>"+approverComments.trim()+" "+ "\n"); 
				strMailMsg.append("</font><br><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif><a href='"+strSSOUrl+"'>Please click here to login to STARS </a> "+ "\n");  
				strMailMsg.append("   </b></form></font><br><p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best   Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>"+approverName.trim()+"<br></font></p></td></tr></table></td></tr><tr><td bgcolor=#878787 align=center> <font face=Verdana, Arial, Helvetica, sans-serif size=2><b>MAIL             Reference Number: </b>"+strMailRefNumber+"/"+strCurrentYear+"</font></td></tr><tr><td bgcolor=#FFFFFF align=center>       <table width=100% border=0 cellspacing=0 cellpadding=12>"+ "\n"); 
				strMailMsg.append("<tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana, Arial, Helvetica, sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana, Arial, Helvetica, sans-serif color=#000000>"+ "\n"); 
				strMailMsg.append("<a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>  "+ "\n");  
				strMailMsg.append(" </tr><tr><td  align=center bgcolor=#878787 height=55> <b><font size=1 face=Verdana, Arial, Helvetica, sans-serif>Disclaimer : This communication is System Generated. "+ "\n");  
				strMailMsg.append("Please do not reply to this Email. <br>If you are not the correct receipent for this notification please contact the STARS Administrator quoting the Mail Reference Number</font></b></td></tr></table></td></tr><tr><td bgcolor=#000000><img src=\"http://:8080/star/images/spacer.gif\"width=1 height=1></td></tr>"+ "\n");    
				strMailMsg.append("<tr><td align=center><font size=2 face=Verdana, Arial, Helvetica, sans-serif><font size=1 color=#000000>&copy;MIND. All Rights Reserved.</font></font></td>  </tr></table><p>&nbsp;</p></body></html>"+ "\n");
						
				
			}
			mailBean.setMailSubject(strMailSubject);
			mailBean.setMailMessage(strMailMsg.toString());
			dbUtility.saveMailInDB(mailBean);
			//System.out.println("Mail Message==="+strMailMsg.toString());
		}catch(Exception e){
			System.out.println("Error in mailFormater() method of MailFormat.java===="+e);
		}
	}
	
	
	public static void main(String args[]){
		MailBean mailBean = new MailBean();
		
		mailBean.setMailBlockFlag("MailOnReceiveByMATAToHR");  //used for finding the block of Mail Format Block
		//mailBean.setApprovalAction("Approve"); //Approve, Returned From Worflow, Reject
		
		mailBean.setCurrentDateTime("17 Oct 2008 3:50");
		mailBean.setTravelType("International Travel");
		mailBean.setTravelId("111");
		mailBean.setTravelNumber("MIND/TEST/1111");
		mailBean.setMailSubjectMessage("Intimation after First approval");
		mailBean.setTravelerSex("Mr."); 
		mailBean.setTravelerName("Sachin Gupta");
		mailBean.setGroupTravelFlag("no");
		mailBean.setTravelFrom("Delhi");
		mailBean.setTravelTo("London"); 
		mailBean.setDepartureDate("30/10/2008");
		mailBean.setVisaRequired("Visa Required:yes");
		mailBean.setVisaComment("Visa Comment:-");
		mailBean.setEcrRequired("ECR Required: no");
		mailBean.setReqCreationDate("16 Oct 2008 12:39"); //Travel Requisition Creation Date
		mailBean.setNextApproverName("SOM DUTT MEHTA");
		mailBean.setIntimatorName("Rakesh Sharma");
		mailBean.setReqCreatorName("STAR Admin");
		mailBean.setApproverName("Anurag Aggarwal");
		mailBean.setApproverComments("Approved by Anurag Aggarwal");
		mailBean.setReceipentTo("somduttmehta@mind-infotech.com");
		mailBean.setReceipentFrom("anuragaggrwal@mind-infotech.com");
		mailBean.setReceipentCC("shivsharma@mind-infotech.com");
		
		MailFormat mt = new MailFormat();
		mt.mailFormater(mailBean);
		
	}

}
