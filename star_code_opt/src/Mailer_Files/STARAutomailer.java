package Mailer_Files;

/***********************************************************************************************
*Copyright (C) 2000 MIND 07422-44118, 73455
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY				:	DEEPALI DHAR
*Date								:	13th September,2006.
*Project							:	STAR
*DESCRIPTION			:	*This java file will generate the mails  .Table reference is REQ_MAILBOX.
*Modification				:   code modified for sending multiple CC recipient of MATA added by shiv sharma on 27-Mar-08
*Modified By	: Manoj Chand
*Modification : Create Database connection from stars.properties located outside STARS application.
*Modification Date: 03 Jan 2013
*********************************************************************************************/
// Importing package which are used in this java file
import java.sql.*;
import java.io.*;
import java.util.Date;
import java.text.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import java.util.*;
import src.connection.PropertiesLoader;

public class STARAutomailer
{

public static void main( String args[])
	
	{
// setting database connection

Connection	con			=	null;		// JDBC Connection Object
Connection	con_1		=	null;		// JDBC Connection Object
Connection	con_2		=	null;		// JDBC Connection Object
Statement 	stmt			=	null;	   // JDBC Object for Statement
//Statement 	stmt1			=	null;	   // JDBC Object for Statement
//Statement 	stmt2			=	null;	   // JDBC Object for Statement
ResultSet	rs					=	null; // JDBC ResultSet Object
//ResultSet	rs1				=	null;	  // JDBC ResultSet Object
Connection	con1			=	null;	 // JDBC Connection Object
//Connection	con2			=	null;	 // JDBC Connection Object

String	 sqlstr				=	null;	// Query String
//String	sqlstr1			=	null;
String	 Ssmtp_server		=	null;
String	 dbdriver				=	null;
String	 dburl					=  null;
String	 dbuser				=  null;
String	dbpwd				=  null;
CallableStatement cstmt=		null;			// Object for Callable Statement
CallableStatement cstmt_1=		null;			// Object for Callable Statement
//CallableStatement cstmt_mail=		null;			// Object for Callable Statement

 // Get Connection and SMTP variables


 try
 {
	 //System.out.println("before star");
	 //FileInputStream propfile = new FileInputStream("C:/DevWorkSpaces/Workflow/star/src/src/connection/STAR.properties");
	 //if ( propfile != null)
	// {
		//Properties pmsprop = new Properties();
		//pmsprop.load( propfile);
		//propfile.close();
		Ssmtp_server		=	PropertiesLoader.config.getProperty("smtp_server");
		dbdriver			=	PropertiesLoader.config.getProperty("dbdriver");
		dburl				=	PropertiesLoader.config.getProperty("dburl");
		dbuser				=	PropertiesLoader.config.getProperty("dbuser");
		dbpwd				=	PropertiesLoader.config.getProperty("dbpwd");
		/*System.out.println("Ssmtp_server--->"+Ssmtp_server);
		System.out.println("dbdriver--->"+dbdriver);
		System.out.println("dburl--->"+dburl);
		System.out.println("dbuser--->"+dbuser);
		System.out.println("dbpwd--->"+dbpwd);*/
		String	 strMailId		=	"";
		String	 strMailFrom	=	"";
		String	 strMailTo		=	"";
		String	 strMailSubject	=	"";
		String	 strMailBody	=	"";
		String	 strStatus		=	"";
		String   strMailCc		=	"";
		String strMailCcMsg	=	"";
		int iTrials				=	0;
		//int iMaxTrials			=	10; // For maximum tries
		//int	iMAIL_ID										=	0;
		//String	strREQ_ID									=	"";
		//String	strREQ_NUMBER					=	"";
		//String	strRECEIPENT_TO					=	"";
		//String	strRECEIPENT_FROM			=	"";
		//String	strRECEIPMENT_CC				="";
		//String	strMAIL_SUBJECT					=	"";
		//String	strMAIL_MSG								="";
		//String	strTRIES										=	"";
		//String	strERROR_SUCCESS			=	"";
		//String	strMAIL_CREATED_DATE		=	"";
		//String	strMAIL_CREATOR					=	"";
	    //String	strMAIL_SEND_DATE				=	"";
		//String	strREQUISITION_STATUS		=	"";
		//String	strSOURCE_PAGE					=	"";
		try
    	{
			Class.forName(dbdriver);
	    	con	=DriverManager.getConnection(dburl,dbuser,dbpwd);
			con_1=DriverManager.getConnection(dburl,dbuser,dbpwd);
			con_2=DriverManager.getConnection(dburl,dbuser,dbpwd);
			con1=DriverManager.getConnection(dburl,dbuser,dbpwd);
     		//Make Connection to retrieve the Mail Data based on status
	    	sqlstr="SELECT MAIL_ID,RTRIM(RECEIPENT_TO),RTRIM(RECEIPENT_FROM),RTRIM(RECEIPMENT_CC),RTRIM(MAIL_SUBJECT),RTRIM(MAIL_MSG),TRIES,ERROR_SUCCESS,RTRIM(MAIL_MSG) FROM  REQ_MAILBOX WHERE ERROR_SUCCESS IN ('NEW','ERROR') AND TRIES<=50 ";
			stmt = con.createStatement(); 
			rs	   = stmt.executeQuery(sqlstr);
			while(rs.next())
			{
				strMailId				=	rs.getString(1);
				strMailTo 			=	rs.getString(2);
				strMailFrom		=	rs.getString(3);
				strMailCc			=	rs.getString(4);
				strMailSubject	=	rs.getString(5);
				strMailBody		=	rs.getString(6);
				iTrials					=	rs.getInt(7);
				strStatus			=	rs.getString(8);
    			strMailCcMsg	=	rs.getString(9);
				if(iTrials>=50)
				{
					strMailSubject		="Mail Could not be send From Requisition- Trials conducted=10";
					strMailFrom			="administrator.stars@mind-infotech.com";
					strMailTo			="administrator.stars@mind-infotech.com";
				}
				try
				{
					//Send Mails for TO
					Properties    props    =  System.getProperties();
					props.put("mail.smtp.host", Ssmtp_server);  // IP Address of Mail Server
					Session    session    =  Session.getDefaultInstance(props, null);
					session.setDebug(false);
    				Message     msg    =  new MimeMessage(session);
					msg.setSubject(strMailSubject);
					msg.setFrom(new InternetAddress(strMailFrom));
					msg.addRecipient(Message.RecipientType.TO, new InternetAddress(strMailTo));

					
					//code for sending multiple CC recipient of MATA added by shiv sharma on 27-Mar-08
					if(strMailCc==null || strMailCc.equals(""))
					{
					}
					else
					{
						StringTokenizer st=new StringTokenizer(strMailCc,";");
						while(st.hasMoreElements())
						{
							
						   msg.addRecipient(Message.RecipientType.CC, new InternetAddress(st.nextToken()));
						}
					}


					//msg.addRecipient(Message.RecipientType.CC, new InternetAddress(strMailCc));


					MimeBodyPart    mbp  =  new MimeBodyPart();
					mbp.setContent(strMailBody,"text/html");
					Multipart      mp   =  new MimeMultipart();
					mp.addBodyPart(mbp);
					msg.setContent(mp);
					msg.saveChanges();
					msg.setSentDate(new Date());
					msg.setHeader("X-Priority", "1"); 
	     			msg.setHeader("x-msmail-priority", "high"); 
					Transport.send(msg);
					try
					{
						//Update Mail Status
						cstmt=con_1.prepareCall("{?=call PROC_REQUISITIONMAILINFO_UPDATE(?,?,?)}");
						cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						cstmt.setString(2, strMailId);
						cstmt.setString(3, "SEND");
						cstmt.setInt(4, iTrials+1);
						cstmt.execute();
					}
					catch(Exception e_2)
					{
						System.out.println("Error------77--"+e_2);
					}
					cstmt.close();	//close the connection
                }
				catch(Exception e_1)
				{
            		//Update Mail Status in case of errors
					cstmt_1=con_2.prepareCall("{?=call PROC_REQUISITIONMAILINFO_UPDATE(?,?,?)}");
					cstmt_1.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt_1.setString(2, strMailId);
					cstmt_1.setString(3, "ERROR");
					cstmt_1.setInt(4, iTrials+1);
					cstmt_1.execute();
					cstmt_1.close();	//close the connection
				}
			}// End of While
    		rs.close();	//close the resultset
			stmt.close();	//close the statement
			con.close();	//close the connection
 		}
		catch(Exception e)
		{
     		System.out.println("Errror-----99----"+e);
	    }
	//}
	/*else
	{
		propfile.close();
	}*/
}	// end of try
catch(Exception ex)
{
   System.out.print("Errror-----109----"+ex);
}
}//end of main
}//end of class






