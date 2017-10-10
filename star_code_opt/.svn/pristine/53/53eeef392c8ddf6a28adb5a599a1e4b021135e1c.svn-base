<%
	/***************************************************
	* Copyright (C) 2000 MIND 
	* All rights reserved.
	* The information contained here in is confidential and  
	* proprietary to MIND and forms the part of the MIND 
	* CREATED BY	  		 :Manoj Chand
	* Date			   		 :13 Nov 2011.
	  Project 		  		 :STARS
	* Operating environment  :Tomcat 6.0, sql server 2000
	* DESCRIPTION            :SSO LOGIC CHANGED IN STARS
	
	*Modified By			:Manoj Chand
	*Date of Modification	:14 Nov 2011
	*Modification			:remove jsp:forward tag and use form action to submit the page.
	
	*Modified By			:Manoj Chand
	*Date of Modification	:05 Sept 2012
	*Modification			:add check of domain name for smr sites
	
	*Modified By			: Manoj Chand
	*Modification 			: Create Database connection from stars.properties located outside STARS application.
	*Modification Date		: 02 Jan 2013
	**********************************************************/
%>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,src.connection.PropertiesLoader" %>
<%response.setHeader("Cache-Control", "max-age=1");%>
<html>
<head>

<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
<!-- Written by manoj chand on 14 Nov 2011 to submit form using javascript -->
<script type="text/javascript">

function callUrl(page,user,pass,flag){
	document.f1.Userid.value=user;
	document.f1.hiddenPassword.value=pass;
	document.f1.SSO.value=flag;
	document.f1.action=page;
	document.f1.submit();
}

function callUrl1(page,user,pass,encflag){
	document.f1.Userid.value=user;
	document.f1.hiddenPassword.value=pass;
	document.f1.encFlag.value=encflag;
	document.f1.action=page;
	document.f1.submit();
}

</script>


</head>


<body>
<form name=f1 method="post" action="">
<input type="hidden" name="Userid" value=""/>
<input type="hidden" name="hiddenPassword" value=""/>
<input type="hidden" name="SSO" value=""/>
<input type="hidden" name="encFlag" value=""/>

<%
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

//ADDED BY MANOJ CHAND ON 04 AUGUST 2011
//	String contextServerPath  =	application.getInitParameter("serverPath");

//FileInputStream propfile = new FileInputStream(contextServerPath+"STAR.properties"); 
  // if( propfile != null)
	//{
	//	 Properties pmsprop = new Properties();
	//	 pmsprop.load( propfile);
	// 	 propfile.close();
	     dbdriver 	    = PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
		 dburl 		    = PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
		 dbuser 		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
		 dbpswd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd"); 
 //   }
//else
	//{
	//   propfile.close();
	//   response.sendRedirect("invaliduser.jsp");
	//}
		 //added by manoj chand on 03 jan 2013
		 if(dbdriver.equals("") || dburl.equals("") || dbuser.equals("") || dbpswd.equals("")){
			  response.sendRedirect("invaliduser.jsp");
		  }
	/*String strSessionID="SID"; //=request.getParameter("reqSID");
	String strTokenID="TID";  //request.getParameter("reqTID"); 
	*/
	
	

	String reqWinId 	= request.getParameter("reqWinId");
	String reqDomain 	= request.getParameter("reqDomain");
	
	HttpSession hs      = request.getSession(true);
	String frmApp		= request.getParameter("frmApp");
	hs.putValue("frmApp", frmApp);
	
	String strWinUserId	= dbUtility.decrypt(reqWinId);
	String strDomainName= dbUtility.decrypt(reqDomain);
	
	strErrorcode      =request.getParameter("reqErrorCode")==null?"":request.getParameter("reqErrorCode"); ;  
	String user1 = "";
	String strPass = "";

	try
	{
	
		/*String str1="SELECT   m_userinfo.username,m_userinfo.pin FROM SSO_SESSION_TABLE INNER JOIN "+ 
	                " m_userinfo ON SSO_SESSION_TABLE.WIN_USER_ID = m_userinfo.Win_User_ID AND "+
	                " SSO_SESSION_TABLE.DOMAIN_NAME = case when exists(SELECT 1 FROM M_USERINFO m INNER JOIN M_SITE s on m.SITE_ID=s.SITE_ID "+ 
	                " WHERE m.status_id=10 and s.status_id=10 and m.WIN_USER_ID=m_userinfo.Win_User_ID and s.SMR_SITE_FLAG='Y' AND SSO_ENABLE='Y') "+
	                " then SSO_SESSION_TABLE.DOMAIN_NAME else m_userinfo.[DOMAIN_NAME] end WHERE  "+
	                " (SSO_SESSION_TABLE.TOKEN_ID = '"+strTokenID+"') AND (SSO_SESSION_TABLE.SESSION_ID = '"+strSessionID+"') AND " +
	                " (SSO_SESSION_TABLE.SSO_SUCCESS = 'n') AND (M_USERINFO.SSO_ENABLE = 'y') AND (M_USERINFO.Status_ID = 10) ";
*/
//for smr sites domain name check implemented by manoj chand on 05 sept 2012
//String str1= "SELECT     m.USERNAME, m.PIN FROM M_USERINFO m INNER JOIN M_SITE s ON m.SITE_ID = s.SITE_ID WHERE m.status_id = 10 AND s.status_id = 10 AND SSO_ENABLE = 'Y' AND m.WIN_USER_ID ='"+strWinUserId+"' AND (m.domain_name = '"+strDomainName+"' or s.SMR_SITE_FLAG = 'Y') ";
String str1= "SELECT     m.USERNAME, m.PIN FROM M_USERINFO m INNER JOIN M_SITE s ON m.SITE_ID = s.SITE_ID WHERE m.status_id = 10 AND s.status_id = 10 AND SSO_ENABLE = 'Y' AND m.WIN_USER_ID ='"+strWinUserId+"' AND m.domain_name = '"+strDomainName+"'";
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
				 
	   }
		rs1.close();
	
}
catch(Exception eee)
{
	System.out.println("Error in login page in single sign on ..."+eee);
}

String encFlag 		= null;
String username=null;
String strDeciPass = null;
try
{
	if(user!=null)
	{       
				con=DriverManager.getConnection(dburl,dbuser,dbpswd); 
	
				String str="select  username,enc_flag  from m_userinfo  where status_id=10 and username =? and pin=?";
				//System.out.println("str--->"+str);			
  	 			if(encFlag == null)
					{
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

				//System.out.println("ecnFlag is=after ="+encFlag); 

				// procedure to update sso_session 
				/*try{
					  
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
*/

			if(encFlag!=null && encFlag.trim().equals("y") ) 
			{
				//System.out.println("===================3=========1=============");
				%>
				<!-- added by manoj on 14 Nov 2011 to call userAuthentication.jsp page using javascript -->
				<script type="text/javascript">
					callUrl('userAuthentication.jsp','<%=user%>','<%=strPass%>','yes');
				</script>
		
			 <%
			}
			else if(encFlag!=null && encFlag.trim().equals("n") ) 
			{
				//System.out.println("===================4=========1=============");
			%>	  <!-- added by manoj on 14 Nov 2011 to call password_change_New.jsp page using javascript -->
				<script type="text/javascript">
					callUrl1('password_change_New.jsp','<%=user%>','<%=strPass%>','<%=encFlag%>');
				</script>
					  
			<%
					//response.sendRedirect("password_change_New.jsp") ;
			}
				else
				{
					//System.out.println("hi.........................");
					response.sendRedirect("invalidUser.jsp?error_code=1");  
					//response.sendRedirect("index.jsp");	
				}
} 
else{ 
	//System.out.println("hi........TID NOT FOUND ................."+strErrorcode);
	response.sendRedirect("invalidUser.jsp?error_code=1");	  
	//response.sendRedirect("index.jsp");  
} 
	
}	 
catch(Exception e){
	System.out.println("eeeeeeeeeeeeeeee"+e);
}
%>

</form>
</body>
</html>