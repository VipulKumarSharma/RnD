
<%
	/***************************************************
	* Copyright (C) 2000 MIND 
	* All rights reserved.
	* The information contained here in is confidential and  
	* proprietary to MIND and forms the part of the MIND 
	* CREATED BY	  		 :Poonam Dahiya
	* Date			   		 :05 Jan 2009.
	  Project 		  		 :STARS
	* Operating environment  :Websphere , sql server 2000
	* DESCRIPTION            :
	* Modification           : code change in whole file for enabling single signon for mind user   
	* This jsp file is for Validating the users from the PMS database.
	* Modification           : Pankaj Dubey on 30/06/2010
	* to enable single sign on only for users whose status_id = 10
	* Modified By			: Manoj Chand
	* Modification Date		: 5-may-2011
	* Modification			: change in Sql query to allow single signon for smr site users while their domain name is changing.
	
	*Modification Date		:04-August-2011
	*Modification			:fetch path of STAR.properties file from web.xml 
	*Modified By			:Manoj Chand
	 
	*Modification Date		:11-April-2012
	*Modification			:Change in query to resolve sso issue of Mr. Pradeep kumar kurkal from mate 
	*Modified By			:Manoj Chand
	
	*Modification Date		:20-April-2012
	*Modification			:Change in query and else block added to resolve issue of SSO. 
	*Modified By			:Manoj Chand
	
	*Modified By			:Manoj Chand
	*Modification 			:Create Database connection from stars.properties located outside STARS application.
	*Modification Date		:02 Jan 2013
	**********************************************************/
%>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,src.connection.PropertiesLoader" %>
<%response.setHeader("Cache-Control", "max-age=1");%>

<FORM name=f1 METHOD=POST ACTION="">
 <script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>

<%
HttpSession hs = request.getSession(true);
// Variables declared and initialized
String dbdriver		=null;
String dburl		=null;
String dbuser		=null;
String dbpswd		=null;
String user			=null;		// To hold the user
String password		=null;		// To hold the password

Connection con , objCon = null;				// Object for connection 
PreparedStatement pStmt = null;				// Object for Statement
Statement stmt1 = null;
CallableStatement objCstmt = null;
ResultSet rs = null; 


String strIPAddress = request.getRemoteAddr();   
String strErrorcode  ="0";

//System.out.println("strIPAddress======================="+strIPAddress);
//ADDED BY MANOJ CHAND ON 04 AUGUST 2011
	//String contextServerPath  =	application.getInitParameter("serverPath");

//FileInputStream propfile = new FileInputStream(contextServerPath+"STAR.properties"); 
  // if( propfile != null)
	//{
	//	 Properties pmsprop = new Properties();
	//	 pmsprop.load( propfile);
	 	// propfile.close();
	 	//changed by manoj chand on 02 jan 2013 to fetch db connection parameters from outside STARS application.
		  dbdriver 	    = PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
		  dburl 		= PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
		  dbuser 		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
		  dbpswd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd"); 
    //}
//else
//	{
	//System.out.println("---------here is else------"+dbdriver);
//	   propfile.close();
//	   response.sendRedirect("invaliduser.jsp");
//	}
 //added by manoj chand on 03 jan 2013
  if(dbdriver.equals("") || dburl.equals("") || dbuser.equals("") || dbpswd.equals("")){
	  response.sendRedirect("invaliduser.jsp");
  }
  
  
	/*String strSessionID="SID"; //=request.getParameter("reqSID");
	String strTokenID="TID";  //request.getParameter("reqTID"); 
	*/
	
	

	String strSessionID =request.getParameter("reqSID");
	String strTokenID   =request.getParameter("reqTID"); 
	
	strErrorcode      =request.getParameter("reqErrorCode")==null?"":request.getParameter("reqErrorCode");  
	//System.out.println("--------1--->"+strErrorcode);
	
	//System.out.println("strErrorcode========index.jap========="+strErrorcode); 
	String user1 = "";
	String strPass = "";

	//System.out.println("strSessionID:::"+strSessionID+":::strTokenID:::"+strTokenID);

	try
	{
		/*String str1="SELECT   m_userinfo.username,m_userinfo.pin FROM SSO_SESSION_TABLE INNER JOIN "+ 
	                " m_userinfo ON SSO_SESSION_TABLE.WIN_USER_ID = m_userinfo.Win_User_ID AND "+
	                " SSO_SESSION_TABLE.DOMAIN_NAME = case when exists(SELECT 1 FROM M_USERINFO m INNER JOIN M_SITE s on m.SITE_ID=s.SITE_ID "+ 
	                " WHERE m.status_id=10 and s.status_id=10 and m.WIN_USER_ID=m_userinfo.Win_User_ID and s.SMR_SITE_FLAG='Y' AND SSO_ENABLE='Y') "+
	                " then SSO_SESSION_TABLE.DOMAIN_NAME else m_userinfo.[DOMAIN_NAME] end WHERE  "+
	                " (SSO_SESSION_TABLE.TOKEN_ID = '"+strTokenID+"') AND (SSO_SESSION_TABLE.SESSION_ID = '"+strSessionID+"') AND " +
	                " (SSO_SESSION_TABLE.SSO_SUCCESS = 'n') AND (M_USERINFO.SSO_ENABLE = 'y') AND (M_USERINFO.Status_ID = 10) ";*/
	    
	    //Query changed on 11 april 2012 to resolve sso issue of mr. pradeep kumar kurkal from mate            
       /* String str1="SELECT   m_userinfo.username,m_userinfo.pin FROM SSO_SESSION_TABLE INNER JOIN"+
					" M_USERINFO ON SSO_SESSION_TABLE.WIN_USER_ID = M_USERINFO.WIN_USER_ID"+ 
					" AND  SSO_SESSION_TABLE.DOMAIN_NAME 	=	CASE WHEN SSO_SESSION_TABLE.DOMAIN_NAME <>M_USERINFO.[DOMAIN_NAME] THEN"+
					" CASE WHEN EXISTS	(SELECT 1 FROM   M_USERINFO M INNER JOIN M_SITE S ON M.SITE_ID = S.SITE_ID"+
					" WHERE      M.STATUS_ID = 10 AND S.STATUS_ID = 10 AND M.WIN_USER_ID = M_USERINFO.WIN_USER_ID  AND M.[DOMAIN_NAME] = M_USERINFO.[DOMAIN_NAME]"+ 
					" AND S.SMR_SITE_FLAG = 'Y' AND SSO_ENABLE = 'Y')"+ 
					" THEN SSO_SESSION_TABLE.DOMAIN_NAME ELSE M_USERINFO.[DOMAIN_NAME] END"+ 
					" ELSE M_USERINFO.[DOMAIN_NAME] END WHERE  "+
			        " (SSO_SESSION_TABLE.TOKEN_ID = '"+strTokenID+"') AND (SSO_SESSION_TABLE.SESSION_ID = '"+strSessionID+"') AND " +
			        " (SSO_SESSION_TABLE.SSO_SUCCESS = 'n') AND (M_USERINFO.SSO_ENABLE = 'y') AND (M_USERINFO.Status_ID = 10) ";*/              
	//Query changed on 20 april 2012 to resolve sso issue of mr. gaurav ahuja from mate  
		String str1="SELECT   m_userinfo.username,m_userinfo.pin FROM SSO_SESSION_TABLE INNER JOIN"+
					" M_USERINFO ON SSO_SESSION_TABLE.WIN_USER_ID = M_USERINFO.WIN_USER_ID"+ 
					" AND  SSO_SESSION_TABLE.DOMAIN_NAME 	= M_USERINFO.[DOMAIN_NAME]"+
					" WHERE (SSO_SESSION_TABLE.TOKEN_ID = '"+strTokenID+"') AND (SSO_SESSION_TABLE.SESSION_ID = '"+strSessionID+"') AND " +
			        " (SSO_SESSION_TABLE.SSO_SUCCESS = 'n') AND (M_USERINFO.SSO_ENABLE = 'y') AND (M_USERINFO.Status_ID = 10) ";		        
			        
			        
//System.out.println("str1:::>>>> "+str1); 
 	     
		 ResultSet rs1=dbConBean.executeQuery(str1);
		 
		 
		if(rs1.next())
           {	
			    user=rs1.getString(1); 
		        if(user!=null){
				user=user.trim();
				}
		    
		       strPass= rs1.getString(2);
		       if(strPass!=null){
				strPass=strPass.trim();
				}
		       
		      //con.close();  
				 
	   }else{
		   //this else block with query added by manoj chand on 20 apr 2012
		   str1="SELECT   m_userinfo.username,m_userinfo.pin "+
		   		" FROM         SSO_SESSION_TABLE INNER JOIN"+
				" M_USERINFO ON SSO_SESSION_TABLE.WIN_USER_ID = M_USERINFO.WIN_USER_ID"+ 
				" AND SSO_SESSION_TABLE.DOMAIN_NAME 	=	CASE WHEN EXISTS	(SELECT 1 FROM   M_USERINFO M INNER JOIN M_SITE S ON M.SITE_ID = S.SITE_ID"+
				" WHERE      M.STATUS_ID = 10 AND S.STATUS_ID = 10 AND M.WIN_USER_ID = M_USERINFO.WIN_USER_ID  AND M.[DOMAIN_NAME] = M_USERINFO.[DOMAIN_NAME]"+ 
				" AND S.SMR_SITE_FLAG = 'Y' AND SSO_ENABLE = 'Y') THEN SSO_SESSION_TABLE.DOMAIN_NAME ELSE M_USERINFO.[DOMAIN_NAME] END"+ 
				" WHERE (SSO_SESSION_TABLE.TOKEN_ID = '"+strTokenID+"') AND (SSO_SESSION_TABLE.SESSION_ID = '"+strSessionID+"') AND "+ 
                " (SSO_SESSION_TABLE.SSO_SUCCESS = 'n') AND (M_USERINFO.SSO_ENABLE = 'y') AND (M_USERINFO.STATUS_ID = 10)";
		   //System.out.println("str1----else--->"+str1); 
		   rs1=null;  
		   rs1=dbConBean.executeQuery(str1);
		   if(rs1.next())
           {	
			    user=rs1.getString(1); 
		        if(user!=null){
				user=user.trim();
				}
		    
		       strPass= rs1.getString(2);
		       if(strPass!=null){
				strPass=strPass.trim();
				}	 
	       }
	   }

		rs1.close();
	
}
catch(Exception eee)
{
	System.out.println("Error in login page in single sign on ..."+eee);
}

//user=request.getParameter("name").trim();

String encFlag 		= null;
String username=null;
String strDeciPass = null;
try
{

	//System.out.println("user====="+user);
	//System.out.println("strPass====="+strPass); //0101010101010 
	
	
	if(user!=null)
	{       
				con=DriverManager.getConnection(dburl,dbuser,dbpswd); 
	
				String str="select  username,enc_flag  from m_userinfo  where status_id=10 and username =? and pin=?";
	//System.out.println("str--->"+str);			
  	 			if(encFlag == null)
					{
					 // System.out.println("password===when enc _flag null ====="+strPass);
					  pStmt = con.prepareStatement(str);
					  pStmt.setString(1,user);
					  pStmt.setString(2,strPass);
					  rs = pStmt.executeQuery();	
					  
					   while( rs.next() )
					   {	
					     username=rs.getString("username");
					     encFlag= rs.getString("enc_flag");
					   }
					   rs.close();
					}

				System.out.println("ecnFlag is=after ="+encFlag); 

				// procedure to update sso_session 
				try{
					  
					  //System.out.println("strSessionID=====1==="+strSessionID);
				      if (strSessionID!=null )
						      {
						  if(!strErrorcode.equals("1")){	
			 
				    	 // System.out.println("strSessionID==2======"+strSessionID);
						    	objCon=DriverManager.getConnection(dburl,dbuser,dbpswd);
								objCstmt  =  objCon.prepareCall("{?=call SPG_SSO_SESSION(?,?,?,?,?,?,?,?,?)}"); 
							    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);                                        
							    objCstmt.setString(2,strSessionID);
							    objCstmt.setString(3,"STAR"); 
							    objCstmt.setString(4,""); 
							    objCstmt.setString(5,"");                                         
							    objCstmt.setString(6,"");  
							    objCstmt.setString(7,strIPAddress);  
							    objCstmt.setString(8,"SSO_UPDATE");
							    objCstmt.registerOutParameter(9,java.sql.Types.INTEGER);                                        
							    objCstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
							    objCstmt.setString(10,strTokenID);
							    objCstmt.execute();     // executing procedure
								objCon.close();
							    
						  }
						       } 
								
				}catch(Exception e){
					
					System.out.println("eeeeeeeeeeeeeeee"+e);
				}


			
			if(encFlag!=null && encFlag.trim().equals("y") ) 
			{
				 //System.out.println("===================3=========1=============");
					//System.out.println("inside yyyy");		
				 
				%>
					<jsp:forward page="userAuthentication.jsp" >  
					  <jsp:param name="Userid" value="<%=user%>" />
					  <jsp:param name="hiddenPassword" value="<%=strPass%>" /> 
					  <jsp:param name="SSO"  value="yes" />
					  </jsp:forward>
			 <%}
			else if(encFlag!=null && encFlag.trim().equals("n") ) 
			{
				//System.out.println("===================4=========1=============");
				//System.out.println("inside nnnn");
			%>
			          <jsp:forward page="password_change_New.jsp" >
					  <jsp:param name="Userid" value="<%=user%>" /> 
					  <jsp:param name="hiddenPassword" value="<%=strPass%>" />
					  <jsp:param name="encFlag" value="<%=encFlag%>" /> 
					  </jsp:forward>
			<%
					response.sendRedirect("password_change_New.jsp") ;
			}
				else
				{
					//System.out.println("hi.........................");
					hs.putValue("loginFailureCount", "0");
					hs.putValue("invalidUserPass", "N");
					response.sendRedirect("invalidUser.jsp?error_code="+strErrorcode);  
					response.sendRedirect("index.jsp");  
					
				}
			
			
			
	 
} 
else{ 
//System.out.println("hi........TID NOT FOUND ................."+strErrorcode);
	hs.putValue("loginFailureCount", "0");
	hs.putValue("invalidUserPass", "N");
	response.sendRedirect("invalidUser.jsp?error_code="+strErrorcode);	  

	//response.sendRedirect("index.jsp");  
	
} 
	
}	 
catch(Exception e){
	
	System.out.println("eeeeeeeeeeeeeeee"+e);
}
%>
 
</FORM>