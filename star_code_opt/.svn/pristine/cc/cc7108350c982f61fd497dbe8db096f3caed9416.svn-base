<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:31 Jan 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:User Validation for STAR
 *Modification 			: file Update on 4/7/2009 for SSO enable by shiv sharma
 *Reason of Modification:  
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:23 Oct 2013
 *Modification			:captcha related changes.
 *******************************************************/
%>

<%@ include  file="importStatement.jsp" %>
<%@ include  file="cacheInc.inc" %>
<%@ include  file="headerIncl.inc" %>
<!--Create Conneciton by useBean-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />

<!--Create the DbUtilityMethods object for utility methods-->
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />




<%
// Variables declared and initialized

String user				=  null;		// To hold the user
String password			=  null;		// To hold the password
String strPass			=  null;
String encFlag 			=  null;
String username			=  null;
String strDeciPass		=  null;
String str				=  null;
String language			=  null;

Connection con		    =  null;				// Object for connection
PreparedStatement pStmt = null;				// Object for Statement
ResultSet rs			= null;
Statement stmt		= null;
user		= request.getParameter("Userid")== null ? "" : request.getParameter("Userid").trim();
password	= request.getParameter("hiddenPassword") == null ?"" : request.getParameter("hiddenPassword").trim();
language    = request.getParameter("lang")==null?"en_US":request.getParameter("lang");
//System.out.println("language-user1->"+language);
String strRedirectFlag = "N";

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date currentDate = dateFormat.parse(dateFormat.format(new Date()));
Date relievingDate = null;
boolean relievingDateFlag = false;

try
{

    //System.out.println("password========"+password);
  
	strPass			=  dbUtility.decrypt(password);           // decrypted password
	
	//System.out.println("password===afret decript ==>>==="+strPass);  ///in 123456789
	con  = dbConBean.getConnection();
  	
	//commented by manoj chand on 08 june 2012 to fetch username in japanese
	//str="select  username,enc_flag  from m_userinfo  where status_id=10 and username =? and pin=?";
    //pStmt = con.prepareStatement(str);
	//pStmt.setString(1,user);
	//pStmt.setString(2,strPass);
	//rs = pStmt.executeQuery();
	//CODE ADDED BY MANOJ CHAND ON 03 DEC 2013 TO IMPLEMENT SERVER SIDE CAPTCHA VALIDATION.
	HttpSession hs = request.getSession(true);
	String strVerificationCode = request.getParameter("txtInput")==null?"":request.getParameter("txtInput");
	if(hs.getAttribute("verificationCode") != null && !hs.getAttribute("verificationCode").equals("") && !hs.getAttribute("verificationCode").equals(strVerificationCode)){
		strRedirectFlag = "Y";
		response.sendRedirect("invalidUser.jsp");
	}
	//END HERE
	str="select  username,enc_flag, DISABLEDTIME from m_userinfo  where status_id=10 and username =N'"+user+"' and pin=N'"+strPass+"'";
	stmt=con.createStatement();
	rs=stmt.executeQuery(str);
	while(rs.next())
    {	
       username = rs.getString("username");
       encFlag  = rs.getString("enc_flag");
       relievingDate = (null != rs.getString("DISABLEDTIME") ? rs.getDate("DISABLEDTIME") : null);
    }
    rs.close();
	//pStmt.close();
	
    if(encFlag == null)
    {
       strDeciPass  =  dbUtility.decryptInDecimal(password);   //get the password in decimal from encypted boolean form
       
       /*
	   pStmt = con.prepareStatement(str);
       pStmt.setString(1,user);
       pStmt.setString(2,strDeciPass);
       rs = pStmt.executeQuery();*/	
       str="select  username,enc_flag, DISABLEDTIME from m_userinfo  where status_id=10 and username =N'"+user+"' and pin=N'"+strDeciPass+"'";
   	   stmt=con.createStatement();
   	   rs=stmt.executeQuery(str);
       while( rs.next() )
       {	
         username=rs.getString("username");
         encFlag= rs.getString("enc_flag");
         relievingDate = (null != rs.getString("DISABLEDTIME") ? rs.getDate("DISABLEDTIME") : null);
       }
       rs.close();
    }	
    
    if(relievingDate != null){
    	relievingDate = dateFormat.parse(dateFormat.format(relievingDate));
        if(relievingDate.before(currentDate) || relievingDate.equals(currentDate)) {
        	relievingDateFlag  = true;
        }
    }
    
    
	if(encFlag!=null && encFlag.trim().equals("y") && !relievingDateFlag)
	{
		
	%>
		 <jsp:forward page="userAuthentication.jsp" >
		   <jsp:param name="Userid" value="<%=user%>" />
		   <jsp:param name="hiddenPassword" value="<%=password%>" /> 
		   <jsp:param name="SSO"  value="NO" />
		   <jsp:param value="<%=language %>" name="lang"/>
		 </jsp:forward>
	<%
	}
	else if(encFlag!=null && encFlag.trim().equals("n") && !relievingDateFlag)
	{
	
%>
		<jsp:forward page="password_change_New.jsp" >
		  <jsp:param name="Userid" value="<%=user%>" />		  
		  <jsp:param name="hiddenPassword" value="<%=strPass%>" />
		  <jsp:param name="encFlag" value="<%=encFlag%>" />
		  <jsp:param value="<%=language %>" name="lang"/>
		</jsp:forward>
<%
		
	}
	else
	{
		//code added by manoj chand on 23 oct to implement captcha.
		//HttpSession hs = request.getSession(true);
	    if(hs.getValue("loginFailureCount") == null)
	    	hs.putValue("loginFailureCount", "0"); 
	    if(hs.getValue("loginFailureCount").toString().equals("0"))
		  	hs.putValue("loginFailureCount","1");
		else if(hs.getValue("loginFailureCount").toString().equals("1"))
		    hs.putValue("loginFailureCount", "2");    
		else if(hs.getValue("loginFailureCount").toString().equals("2"))
		    hs.putValue("loginFailureCount", "3");
	    if(!strRedirectFlag.equals("Y"))
	    	hs.putValue("invalidUserPass", "Y");
			response.sendRedirect("invalidUser.jsp");
	}
}
catch(Exception e)
{
	System.out.println("Error in userAuthentication1.jsp"+e);
	response.sendRedirect("invalidUser.jsp");
}
%>