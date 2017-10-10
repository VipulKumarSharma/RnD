<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:25 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp is used to update the Password in the STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/
%>

<%@ page import = "src.connection.DbConnectionBean" %>
<%@ include file="importStatement.jsp" %>
<%@ page import ="java.sql.*"%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="bean" scope="page" class="src.connection.DbConnectionBean" />
<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />

<html>
<head>
<%	
request.setCharacterEncoding("UTF-8");
 // Creating the connection 
 Connection con= null;
 con = dbConBean.getConnection();  //Get the Connection
  
 ResultSet rs = null;
         
//Declaring User Defined Variables

int application_id=1; //for STAR database
int USERID		=0;	
int DIV_ID		=0;
int SITE_ID		=0;
int DEPT_ID		=0;
int  DESIG_ID	=0;
int STATUS_ID	=0;
int  REPORT_TO	=0;
int APPLICATION_ID=0;
String C_DATE		= ""; 
String U_DATE		= "NULL";
String DATE_ISSUE	= "";
String EXPIRY_DATE	= "";
String DOB			= "";
String USERNAME		="";
String PIN			="";
String SECRET_QUESTION	=""; 
String SECRET_ANSWER	="";
String LOGINSTATUS		="";
String DISABLEDTIME		="";
String FIRSTNAME		="";
String LASTNAME			="";
String EMAIL			="";
String ROLE_ID			="";
String C_USER_ID		="";
String U_USER_ID		="";
String PASSPORT_NO		="";
String PLACE_ISSUE		="";
String ADDRESS			="";
String CONTACT_NUMBER	="";
String FF_NUMBER		="";
String FF_NUMBER1		="";
String FF_NUMBER2		="";
String ECNR				="";
String RECORD_TYPE      ="U"; 
int intdt	=	0;
int hr	=	0;
int min	=	0;
int dt	=	0;
int mn	=	0;
int yr	=	0;
String strdt	=	"";
String strmn	=	"";
String st_date=	"";
int intHour	=	0;
int intMinute	=	0;
int intSecond =0;
Calendar calendar	=	Calendar.getInstance();
intHour		=	calendar.get(Calendar.HOUR);
intMinute	=	calendar.get(Calendar.MINUTE);
intSecond   = 	calendar.get(Calendar.SECOND);
dt			=	 calendar.get(Calendar.DATE);  
strdt		=	""+dt;
mn			=	 calendar.get(Calendar.MONTH);   
mn			=	mn+1;
strmn		=	""+mn;
yr			=	 calendar.get(Calendar.YEAR);   
if(strmn.length()<2)
{
	strmn	=	"0"+mn;
}
if(strdt.length()<2)
{
	strdt	=	"0"+dt;
}
	
	
st_date	=	strmn +"/"+strdt+"/"+yr +" "+intHour+":"+intMinute+":"+intSecond ;



// Variable Declaration closed

// Reterving  User  from session.
HttpSession htsession	= request.getSession();
String user = (String)htsession.getValue("user"); 
String oldPassword   =  request.getParameter("oldPass").trim();
String db_password   = ""; 
// getting old password from database
rs = bean.executeQuery("select pin from M_USERINFO where  username=N'"+ user.trim()+"'"); 
if(rs.next())
{
	db_password = rs.getString(1);
	//System.out.println("db_password **** "+db_password);
}
rs.close();

db_password = dbUtility.decryptFromDecimalToString(db_password);
//System.out.println("db_password after decrypt===="+db_password);

// Getting value of new password from the changepassword jsp
String newpassword = request.getParameter("confirmPass").trim();
newpassword = dbUtility.encrypt(newpassword);
newpassword = dbUtility.decryptInDecimal(newpassword);

//System.out.println("encrypted password is=="+newpassword);

// updating the table M_USERINFO with the new password
int updated = 0;
if(oldPassword.equals(db_password.trim()))
{
  updated = bean.executeUpdate("update M_USERINFO set pin=N'" + newpassword + "',RECORD_TYPE='"+RECORD_TYPE+ "'," +"U_DATE='"+ st_date +"'"+ "where username=N'"+ user + "'" ); 
}

//if table has been updated  
 if(updated==1)
 {
	 // Reterving the whole updated row from the table M_USERINFO with changed password.
	 rs = bean.executeQuery("select USERID,USERNAME,PIN,SECRET_QUESTION,SECRET_ANSWER,LOGINSTATUS,DISABLEDTIME,FIRSTNAME,LASTNAME,EMAIL,DIV_ID,SITE_ID,DEPT_ID,DESIG_ID,ROLE_ID,STATUS_ID,C_USER_ID,C_DATE,U_USER_ID,U_DATE,REPORT_TO,APPLICATION_ID,PASSPORT_NO,DATE_ISSUE,EXPIRY_DATE,PLACE_ISSUE,ADDRESS,CONTACT_NUMBER,FF_NUMBER,FF_NUMBER1,FF_NUMBER2,ECNR,DOB  from M_USERINFO where pin='"+ newpassword.trim() + "' and username='" + user.trim() + "' and application_id="+application_id); 
	 // getting cloumn values
 	 while(rs.next())
	 {
			USERID			= rs.getInt("USERID");
			USERNAME		= rs.getString("USERNAME");		
			PIN				= rs.getString("PIN");			
			SECRET_QUESTION = rs.getString("SECRET_QUESTION");
			SECRET_ANSWER	= rs.getString("SECRET_ANSWER");	
			LOGINSTATUS		= rs.getString("LOGINSTATUS");		
			DISABLEDTIME	= rs.getString("DISABLEDTIME");	
			FIRSTNAME		= rs.getString("FIRSTNAME");	
			LASTNAME		= rs.getString("LASTNAME");	
			EMAIL			= rs.getString("EMAIL");	
			DIV_ID			= rs.getInt("DIV_ID");		
			SITE_ID			= rs.getInt("SITE_ID");		
			DEPT_ID			= rs.getInt("DEPT_ID");		
			DESIG_ID		= rs.getInt("DESIG_ID");	
			ROLE_ID			= rs.getString("ROLE_ID");	
			STATUS_ID		= rs.getInt("STATUS_ID");	
			C_USER_ID		= rs.getString("C_USER_ID");
			C_DATE			= rs.getString("C_DATE");		
			U_USER_ID		= rs.getString("U_USER_ID");	
			U_DATE			= rs.getString("U_DATE");	
			REPORT_TO		= rs.getInt("REPORT_TO");	
			APPLICATION_ID	= rs.getInt("APPLICATION_ID");	
			PASSPORT_NO		= rs.getString("PASSPORT_NO");	
			DATE_ISSUE		= rs.getString("DATE_ISSUE");	
			EXPIRY_DATE		= rs.getString("EXPIRY_DATE");	
			PLACE_ISSUE		= rs.getString("PLACE_ISSUE");	
			ADDRESS			= rs.getString("ADDRESS");	
			CONTACT_NUMBER	= rs.getString("CONTACT_NUMBER");	
			FF_NUMBER		= rs.getString("FF_NUMBER");	
			FF_NUMBER1		= rs.getString("FF_NUMBER1");	
			FF_NUMBER2		= rs.getString("FF_NUMBER2");	
			ECNR			= rs.getString("ECNR");	
			DOB				= rs.getString("DOB");	
	}
    rs.close();	
    // calling procedure to insert the updated row in the table PROC_TRANSFER_USERINFO

    CallableStatement proc = con.prepareCall("{?=call PROC_TRANSFER_USERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
    {
		proc.registerOutParameter(1,java.sql.Types.INTEGER);
		proc.setInt(2, USERID);
		proc.setString(3, USERNAME);
		proc.setString(4, PIN);
		proc.setString(5, SECRET_QUESTION);
		proc.setString(6, SECRET_ANSWER);
		proc.setString(7, LOGINSTATUS);
		proc.setString(8, DISABLEDTIME);
		proc.setString(9, FIRSTNAME);
		proc.setString(10, LASTNAME);
		proc.setString(11, EMAIL);
		proc.setInt(12, DIV_ID);
		proc.setInt(13, SITE_ID);;
		proc.setInt(14, DEPT_ID);
		proc.setInt(15, DESIG_ID);
		proc.setString(16, ROLE_ID);
		proc.setInt(17, STATUS_ID);
		proc.setString(18, C_USER_ID);
		proc.setString(19, C_DATE);
		proc.setString(20, U_USER_ID);
		proc.setString(21, U_DATE);
		proc.setInt(22, REPORT_TO);
		proc.setInt(23, APPLICATION_ID);
		proc.setString(24, PASSPORT_NO);
		proc.setString(25, DATE_ISSUE);
		proc.setString(26, EXPIRY_DATE);
		proc.setString(27, PLACE_ISSUE);
		proc.setString(28, ADDRESS);
		proc.setString(29, FF_NUMBER);

		proc.setString(30, FF_NUMBER1);
		proc.setString(31, FF_NUMBER2);

		proc.setString(32, CONTACT_NUMBER);
		proc.setString(33, ECNR);
		proc.setString(34, DOB);
		proc.setString(35,RECORD_TYPE);
		proc.execute();
		proc.close();
    } 
 }
// connection closed
//con.close();


//Close All Connecitons
bean.close();
dbConBean.close();
response.sendRedirect("M_changePassword.jsp?flag=confirm");
%>
</body>
</html>
