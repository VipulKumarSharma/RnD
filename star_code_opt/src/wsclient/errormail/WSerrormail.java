/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY		:	Manoj Chand
*Date			:	16 January 2013
*Description	:	CREATE WEBSERVICE FAIL ERROR MAIL.
*Project		:	STARS
*
*Modified By		: 	Manoj Chand
*Modification Date  :   05 April 2013
*Modification   	:   add site name in both error mail.
**********************************************************/ 

package wsclient.errormail;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;

import src.connection.DbConnectionBean;


public class WSerrormail {

	public void sendErrorMail(String strWebSeviceDetails,String strResMessage,String strMethodName,String strTravelId,String strPageName,String strSiteId) {
		try{
			Statement stmt=null;
			CallableStatement cstmt_mail=null;
			ResultSet rs=null;
			DbConnectionBean objCon=new DbConnectionBean();
			Connection con=objCon.getConnection();
			String strMailRefNumber="",strCurrentDate="",strSiteName="";
			Calendar cal=Calendar.getInstance();
			int year=cal.get(Calendar.YEAR);
			
			String sSqlStr		= "SELECT ISNULL(MAX(MAIL_ID),'999')+1,convert(varchar(20),getdate(),113) as currentdate,LTRIM(RTRIM(dbo.SITENAME('"+strSiteId+"'))) as SITE FROM REQ_MAILBOX";
			stmt		= con.createStatement(); 
			rs			= stmt.executeQuery(sSqlStr);
			if(rs.next())
			{
				strMailRefNumber		=	rs.getString(1);//Mail Reference Number
				strCurrentDate			=	rs.getString(2);//Current Date
				strSiteName				=   rs.getString(3);//Site Name
			}
			rs.close();
			stmt.close();
			int intMaliRefNumber = Integer.parseInt(strMailRefNumber);
			String strMailSubject="";
			String strMailBody="";
			if(strPageName.equals("")){
			 strMailSubject="STARS Notification : Error Occured during Web Service Calling";
			 strMailBody="<html><style>.formhead {font-family: Arial;font-size: 11px;font-style: normal;font-weight: normal;color: #000000;text-decoration: none;letter-spacing: normal;word-spacing: normal;border: 1px #333333 solid;background: #E2E4D6;}</style>"+
								" <body bgcolor=#d0d0d0><table width=80% border=0 cellspacing=0 cellpadding=0 align=center>	<tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCurrentDate+"</font><font color=#FFFFFF></font><font color=#000000><br>"+
								" </font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10>"+
								" <tr><td align=center bgcolor=#aa1220><font face=Arial,Helvetica,sans-serif size=5 color=#FFFFFF>:: STARS MAIL NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF>"+
								" <table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font face=Verdana,Arial,Helvetica,sans-serif size=2><b><font color=#FFFFFF><font size=3>Error Information</font></font></b></font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana,Arial, Helvetica, sans-serif> Dear All,</font></p>"+
								" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Error had occurred while calling WebService URL: "+strWebSeviceDetails+"</p>"+
								" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Method Name: "+strMethodName+"</font></p>"+
								" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Site Name: "+strSiteName+"</font></p>"+
								" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Error Details: "+strResMessage+"</font></p>"+
								" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>STARS Admin<br></font></p></td></tr></table></td>	</tr><tr><td bgcolor=#878787 align=center><font face=Verdana,Arial,Helvetica,sans-serif size=1><b>MAIL Reference Number: </b>"+intMaliRefNumber+"/"+year+"</font></td>"+
								" </tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana,Arial,Helvetica,sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana,Arial,Helvetica,sans-serif color=#000000> <a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>"+
								" </tr><tr><td align=center bgcolor=#878787 height=55><b><font size=1 face=Verdana,Arial,Helvetica,sans-serif>Disclaimer </b>: This communication is System Generated. Please do not reply to this Email. <br>If you are not the correct recipient for this notification please forward this mail to STARS Administrator</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td align=center><font size=2 face=Verdana,Arial,Helvetica,sans-serif><font size=1 color=#000000>&copy;MIND.All Rights Reserved.</font></font></td></tr></table><p>&nbsp;</p></body></html>";
			}
			else{
				 strMailSubject="STARS Notification : Error Occured in approve request page before Web Service Calling";
				 strMailBody="<html><style>.formhead {font-family: Arial;font-size: 11px;font-style: normal;font-weight: normal;color: #000000;text-decoration: none;letter-spacing: normal;word-spacing: normal;border: 1px #333333 solid;background: #E2E4D6;}</style>"+
									" <body bgcolor=#d0d0d0><table width=80% border=0 cellspacing=0 cellpadding=0 align=center>	<tr><td align=right><font face=Verdana, Arial, Helvetica, sans-serif size=2><b><font color=#FFFFFF>"+strCurrentDate+"</font><font color=#FFFFFF></font><font color=#000000><br>"+
									" </font></b><font color=#FFFFFF>(For Internal Circulation Only)</font></font></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=10>"+
									" <tr><td align=center bgcolor=#aa1220><font face=Arial,Helvetica,sans-serif size=5 color=#FFFFFF>:: STARS MAIL NOTIFICATION ::</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#B6DCDC></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#000000></td></tr><tr><td bgcolor=#FFFFFF>"+
									" <table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font face=Verdana,Arial,Helvetica,sans-serif size=2><b><font color=#FFFFFF><font size=3>Error Information</font></font></b></font></td></tr><tr><td><p><font color=#FFFFFF></font><font size=2 face=Verdana,Arial, Helvetica, sans-serif> Dear All,</font></p>"+
									" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Error had occurred in approve request page named as "+strPageName+" before calling WebService.</p>"+
									" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Site Name: "+strSiteName+"</font></p>"+
									" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Error Details: "+strResMessage+"</font></p>"+
									" <p><font size=2 face=Verdana, Arial, Helvetica, sans-serif>Best Regards,</font><br><font size=2 face=Verdana, Arial, Helvetica, sans-serif>STARS Admin<br></font></p></td></tr></table></td>	</tr><tr><td bgcolor=#878787 align=center><font face=Verdana,Arial,Helvetica,sans-serif size=1><b>MAIL Reference Number: </b>"+intMaliRefNumber+"/"+year+"</font></td>"+
									" </tr><tr><td bgcolor=#FFFFFF align=center><table width=100% border=0 cellspacing=0 cellpadding=5><tr><td align=center bgcolor=#aa1220><font size=2 face=Verdana,Arial,Helvetica,sans-serif><b><font size=1>STARS Administrator can be contacted at the following EMail Address : - </font></b><font size=1><font size=2 face=Verdana,Arial,Helvetica,sans-serif color=#000000> <a href=mailto:administrator.stars@mind-infotech.com><font size=1 color=#ffffff>administrator.stars@mind-infotech.com</font></a></font></font></font></td>"+
									" </tr><tr><td align=center bgcolor=#878787 height=55><b><font size=1 face=Verdana,Arial,Helvetica,sans-serif>Disclaimer </b>: This communication is System Generated. Please do not reply to this Email. <br>If you are not the correct recipient for this notification please forward this mail to STARS Administrator</font></td></tr></table></td></tr><tr><td bgcolor=#000000></td></tr><tr><td align=center><font size=2 face=Verdana,Arial,Helvetica,sans-serif><font size=1 color=#000000>&copy;MIND.All Rights Reserved.</font></font></td></tr></table><p>&nbsp;</p></body></html>";
			}
			String strToMail="gurmeet.virdi@mind-infotech.com";
			String strCCMail="rajay.kumar@mind-infotech.com; varun.kumar@mind-infotech.com";
			String strFromMail="administrator.stars@mind-infotech.com";
			int intTries=0;
			
			cstmt_mail=con.prepareCall("{?=call PROC_REQUISITION_MAIL_ADD(?,?,?,?,?,?,?,?,?,?,?,?)}");
			cstmt_mail.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt_mail.setString(2, strTravelId);
			cstmt_mail.setString(3, "WS Error Information");
			cstmt_mail.setString(4, strToMail);//To
			cstmt_mail.setString(5, strFromMail);//From
			cstmt_mail.setString(6, strCCMail);
			cstmt_mail.setString(7, strMailSubject);
			cstmt_mail.setString(8, strMailBody);
			cstmt_mail.setInt(9, intTries);
			cstmt_mail.setString(10, "NEW");
			cstmt_mail.setString(11, "1");
			cstmt_mail.setString(12, "WS Error Information");
			cstmt_mail.setString(13, "Signatory Approves IT");
			cstmt_mail.execute();
			cstmt_mail.close();
			con.close();
			
			}catch(Exception e){
				System.out.println("ERROR in mail generation in WSerrormail.java file...");
			}
			
		
	}	
	
	
}
