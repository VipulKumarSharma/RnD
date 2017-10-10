	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:SACHIN GUPTA
	 *Date of Creation 		:25 August 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:User Validation for STAR 
	 *Reason of Modification:1.For Gender  
							 2.Using Deployment descriptor for getting server's path by @Gaurav Aggarwal on 04-Jun-2007 	
							 3 file Update on 4/7/2009 for SSO enable by shiv sharma
							 4:added new to identify visio corp user set ssflage=1 else  2 on 01-Sep-09
							 5:added new to flag to configure dynamic workflow of SMR sites for  while adding approvers from M_default_approvers  
							 6:Change the page redirection to approval page if is there any pendin requsition to approver on 10-12-2009 by shiv sharma 
	 *Date of Modification  :1.02-May-2007 
	 *Modification By		:1.Gaurav Aggarwal  
	 *Revision History		:
	 *Editor				:Editplus
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
	
	<html>
	<head>
	<script>
	function convertToDecimal(strbooleancode)
	{
	   var i=0;
	   var result=0;
	   var base=2;
	   var temp="";
	   
	   for(i=0,j=8;i<9;i++,j--)
	   {
	    temp=strbooleancode.charAt(i);
	    result += Math.pow(base,j)*parseInt(temp);
	   }     
	   
	   return result;
	}
	
	function convertToBoolean(intcode)
	{
	    alert("intcode"+intcode);
	    var num=intcode;
	    var quot;
	    var div=2;
	    var rem;
	    var temp=new Array(9);
	    var len=temp.length;
	    var k;
	    var i;
	    var str="";
	    
	    for(k=0;num!=0;k++)
	    {
	     quot=parseInt(num/div);
	     rem=num%div;
	     temp[k]=rem;
	     num=quot;     
	    }
	    
	    for(i=k;i<len;i++)
	    temp[i]=0;
	    
	    temp=temp.reverse();
	    
	    for(i=0;i<len;i++)
	    str +=temp[i];
	    
	    return str;       
	}
	function decrypt(password)
	{
	  alert("Inside Decrypt with password "+password); 
	  var len=password.length;
	  alert("Pwd length "+len);
	  var oldPassword="";
	  var temp=new Array();
	  var k=0;
	  var i=0;
	  var ran;
	  var strbooleantemp="";
	  var strbooleanRan=password.substring(len-9);
	  alert("random No. is "+strbooleanRan);
	  ran=convertToDecimal(strbooleanRan);
	  var pwdLen=((len/9)-1);
	  alert("pwdLen"+pwdLen);
	  
	  for(k=0;k<(pwdLen);k++)
	  {
	    strbooleantemp=password.substring((9*k),9*(k+1));
	    temp[k]=(convertToDecimal(strbooleantemp)-ran);
	    
	    alert("temp[k]"+temp[k]);
	
	    if((temp[k]>=0) && (temp[k]<64)) { alert("Inside Quad1"); temp[k] +=128;}
	    else if((temp[k]>=64) && (temp[k]<128)) { alert("Inside Quad2"); temp[k] +=128;}
	    else if((temp[k]>=128) && (temp[k]<192)) { alert("Inside Quad3"); temp[k] -=128;}
	    else if((temp[k]>=192) && (temp[k]<256)) { alert("Inside Quad4"); temp[k] -=128;}
	    else ;
	  
	    oldPassword +=String.fromCharCode(temp[k]);
	    alert("oldPassword"+oldPassword);
	  }
	 
	  alert("Actual Password After Decryption is::"+oldPassword);
	   
	}
	</script>
	</head>
	<body>
	
	<%
	
	// Variables declared and initialized
	String dbdriver										=		null;				// To hold database driver
	String dburl										=		null;				// To hold database url
	String dbuser										=		null;				// To hold database username
	String dbpswd										=		null;				// To hold database password
	String user											=		null;				// To hold the user id 
	String password							    		=		null;				// To hold the password
	Connection con,con1						        	=		null;			    // Object for connection
	Statement stmt,stmt1						    	=		null;			    // Object for Statement
	PreparedStatement pStmt				        		=		null;
	ResultSet rs,rs1									=		null;  			    // Object for ResultSet
	Statement stmt_systemSettings		                =		null;			    // Object for Statement
	ResultSet rs_systemSettings		                	=		null;			    // Object for ResultSet
	
	String user_id										=		null;
	HttpSession hs								        =		request.getSession(true);
	String sid											=		hs.getId();
	//System.out.println("********************hs=="+hs+"=sid="+sid);
	//FileInputStream propfile					    	=		new FileInputStream("C:/Tomcat/webapps/star/Security/STAR.properties");
	
	//@Gaurav Aggarwal on 04-Jun-2007 Using Deployment descriptor for getting server's path
	String contextServerPath							=		application.getInitParameter("serverPath");
	
	FileInputStream propfile					    	=		new FileInputStream(contextServerPath+"STAR.properties");
	//System.out.println("Before Calling"+getClass());
	//FileInputStream propfile					    	=		new FileInputStream(getClass().getResource("STAR.properties").getPath());
	//System.out.println("After Calling"+propfile);
	//End of Code
	
	String sUserValidationSql			             	=		null;	//Object for user validation Sql Statement
	String sCss1										=		null;
	String sCss2										=		null;
	String userRole								    	=		null;
	String sUserFirstName			        			=		null;
	String sUserLastName					        	=		null;
	String strDivId										=		null;
	String strSiteId									=		null;
	String strDeptId									=		null;
	String strDesigId									=		null;
	String strLoginDateTime	             				=		null;
	String strDepartShortName			             	=		null;
	String strCurrentYear	          					=		null;
	String strUserPass				     				=		null;
	String strGender				     				=		"";
	
	if ( propfile != null)
	{
		Properties pmsprop = new Properties();
		pmsprop.load( propfile);
		propfile.close();
		//Retrieve values from the properties file and set it in the session
		hs.putValue("dbuser", pmsprop.getProperty("dbuser")==null?"":pmsprop.getProperty("dbuser"));
		hs.putValue("dbpwd", pmsprop.getProperty("dbpwd")==null?"":pmsprop.getProperty("dbpwd"));
		hs.putValue("dburl", pmsprop.getProperty("dburl")==null?"":pmsprop.getProperty("dburl"));
		hs.putValue("dbdriver",pmsprop.getProperty("dbdriver")==null?"":pmsprop.getProperty("dbdriver"));
		hs.putValue("date_format",pmsprop.getProperty("date_format")==null?"":pmsprop.getProperty("date_format"));
		hs.putValue("db_date_format",pmsprop.getProperty("db_date_format")==null?"":pmsprop.getProperty("db_date_format"));
		hs.putValue("smtp_server",pmsprop.getProperty("smtp_server")==null?"":pmsprop.getProperty("smtp_server"));
		hs.putValue("no_of_rows",pmsprop.getProperty("no_of_rows")==null?"":pmsprop.getProperty("no_of_rows"));
		hs.putValue("default_currency",pmsprop.getProperty("default_currency")==null?"":pmsprop.getProperty("default_currency"));
		hs.putValue("po_percentage",pmsprop.getProperty("po_percentage")==null?"":pmsprop.getProperty("po_percentage"));
	    hs.putValue("sanction_percentage",pmsprop.getProperty("sanction_percentage")==null?"":pmsprop.getProperty("sanction_percentage"));
		hs.putValue("attachment_size",pmsprop.getProperty("attachment_size")==null?"":pmsprop.getProperty("attachment_size"));
		hs.putValue("decimal",pmsprop.getProperty("decimal")==null?"":pmsprop.getProperty("decimal"));
	    hs.putValue("financial_year_start_date",pmsprop.getProperty("financial_year_start_date")==null?"":pmsprop.getProperty("financial_year_start_date"));	
	    hs.putValue("financial_year_end_date",pmsprop.getProperty("financial_year_end_date")==null?"":pmsprop.getProperty("financial_year_end_date"));    
	    hs.putValue("sanction_capex_limit",pmsprop.getProperty("sanction_capex_limit")==null?"":pmsprop.getProperty("sanction_capex_limit"));
		hs.putValue("sanction_revex_limit",pmsprop.getProperty("sanction_revex_limit")==null?"":pmsprop.getProperty("sanction_revex_limit"));
		hs.putValue("file_path",pmsprop.getProperty("file_path")==null?"":pmsprop.getProperty("file_path"));
	
		hs.putValue("policy_path",pmsprop.getProperty("policy_path")==null?"":pmsprop.getProperty("policy_path"));
		hs.putValue("error_mail_receipent",pmsprop.getProperty("error_mail_receipent")==null?"":pmsprop.getProperty("error_mail_receipent"));
		hs.putValue("fm_desig_id",pmsprop.getProperty("fm_desig_id")==null?"":pmsprop.getProperty("fm_desig_id"));
		hs.putValue("file_path1",pmsprop.getProperty("file_path1")==null?"":pmsprop.getProperty("file_path1"));
		hs.putValue("mailUrl",pmsprop.getProperty("mailUrl")==null?"":pmsprop.getProperty("mailUrl"));
	
		//Retrieve values from the session as procured from the properties file
		dbdriver 		            = (String)hs.getValue("dbdriver");
		dburl 			            = (String)hs.getValue("dburl");
		dbuser 		                = (String)hs.getValue("dbuser");
		dbpswd 		                = (String)hs.getValue("dbpwd");
		
		
		// Userid & Password
		
		/*System.out.println("dburl====================="+dburl);
		System.out.println("dbuser================"+dbuser);
		System.out.println("dbpswd==============="+dbpswd);
		*/
		
	
		
		String strDesigShortName	=  "";
		String strDesigFullName		=  "";
		String strSiteFullName		=  "";
		String decryptPassword      =  ""; 
		String strSSo				=  ""; 
		String strSplRole			="";
	
	//new
		String strApprovalLevel     =  "";
	//
	
		user		=    request.getParameter("Userid").trim();
		password	=    request.getParameter("hiddenPassword").trim(); 
		
		strSSo	    =    request.getParameter("SSO").trim()==null?"":request.getParameter("SSO").trim(); 
		 if (strSSo.equals("")){
			 strSSo="NO"; 
		 }
		 
		decryptPassword=password;
		
		//need to be removed ------------- for origanal----- 
		if (strSSo.equals("yes")){
			 //if then no need to decrypt 
	         //decryptPassword  =  dbUtility.decryptInDecimal(password);              //decrypt the boolean password in decimal without the key            		
		}else{
		 decryptPassword  =  dbUtility.decryptInDecimal(password);              //decrypt the boolean password in decimal without the key            
		}
	   
		
	
		//Validate User
		con = dbConBean.getConnection();
		// fetches the user details from the M_USERINFO table
        //query change for making dynamic workflow for darrc eric on 23-Oct-09

		sUserValidationSql="select *,convert(varchar(17),getdate(),113) as ldt,DBO.DESIGNATIONSHORTNAME(DESIG_ID) as dsn,ISNULL(DBO.DESIGNATIONNAME(DESIG_ID),'') AS DESIG,LTRIM(RTRIM(DBO.SITENAME(SITE_ID))) AS SITENAME,DBO.DEPARTMENTNAME(DEPT_ID) as dpn,datepart(yy,getDate()) as cyear, sp_role as role  from m_userinfo where m_userinfo.username =? and m_userinfo.pin=? and status_id=10 and application_id=1";
		// Replacing statement by prepared statement to avoid sql injection 
		pStmt = con.prepareStatement(sUserValidationSql);
		pStmt.setString(1,user);
		pStmt.setString(2,decryptPassword);
		rs=pStmt.executeQuery();
		
		//System.out.println("sUserValidationSql==============="+sUserValidationSql);
		
		
		if(rs.next())
		{	
			
			user_id							=	rs.getString("userid");
			user							=	rs.getString("username");
			sUserFirstName		         	=	rs.getString("firstname");
			sUserLastName		        	=	rs.getString("lastname");
			strDivId						=	rs.getString("div_id");
			strSiteId						=	rs.getString("site_id");
			strDeptId						=	rs.getString("dept_id");
			strDesigId						=	rs.getString("desig_id");
			userRole						=	rs.getString("role_id");
			
	
	        //new
			strApprovalLevel				=   rs.getString("APPROVER_LEVEL");
			//@Gaurav 02-Apr-2007 For Gender 
			strGender						=	rs.getString("GENDER");
	     
			//System.out.println("strApprovalLevel==="+strApprovalLevel);
			if(strApprovalLevel != null && strApprovalLevel.trim().equalsIgnoreCase("3"))
			{
				strApprovalLevel = "global";
			}
			else
			{
				strApprovalLevel = "no";
			}
	
			strLoginDateTime	        	=	rs.getString("ldt");
			strDesigShortName	            =	rs.getString("dsn");
			strDesigFullName                =   rs.getString("DESIG"); 
			strSiteFullName	          		=   rs.getString("SITENAME"); 
			strDepartShortName          	=	rs.getString("dpn");
			strCurrentYear			    	=	rs.getString("cyear");
			
			
			// added new for SMR France  on 14 -oct -2009 
			strSplRole					 	=	rs.getString("role");
			
			
			//System.out.println("strSplRole======"+strSplRole);
			
							
			//Values for Session 
			// FETCHES THE STYLESHEET
			sUserValidationSql              =   "select * from STAR_system where status_id=10";
			rs_systemSettings	        	=	dbConBean1.executeQuery(sUserValidationSql);
	    	if(rs_systemSettings.next())
			{
				sCss1  =  rs_systemSettings.getString(1);
				sCss2  =  rs_systemSettings.getString(2);
			}
			rs_systemSettings.close();		
	
			String []strUserRoles	=  null;
			String strRoles         =  null; 
			String strFlag          =  "no";
			sUserValidationSql = "SELECT LTRIM(RTRIM(ISNULL(ROLE_ID,''))) AS ROLE_ID FROM M_USERROLE WHERE USERID="+user_id+" AND STATUS_ID=10";
			rs1 = dbConBean1.executeQuery(sUserValidationSql);
			if(rs1.next())
			{
				strRoles		=  rs1.getString("ROLE_ID");			
				if(!strRoles.equals(""))
				{
					strUserRoles	=  strRoles.split(";");
					for(int i=0; i<strUserRoles.length; i++)
					{
						if(strUserRoles[i].equalsIgnoreCase("LA"))
						{
							hs.putValue("userRoleOther",strUserRoles[i]);
							strFlag = "yes";
						}
					}
				}
			}
			rs1.close();
			if(strFlag.equals("no"))
			{
				hs.putValue("userRoleOther","");
			}
			//System.out.println("strRoles========="+strRoles);
	
			//Other Session Variables
			hs.putValue("user", user);// User Name
			hs.putValue("user_id", user_id);	// User Id		
			hs.putValue("sCss1", sCss1);
			hs.putValue("sCss2", sCss2);
			hs.putValue("sid",sid);	//Session ID
			hs.putValue("userRole",userRole.trim());	//Session ID
			//@Gaurav 02-Apr-2007 For Gender 
			hs.putValue("sGender",strGender);	//Session ID
			hs.putValue("sUserFirstName",sUserFirstName);	//Session ID		
			hs.putValue("sUserLastName",sUserLastName);	//Session ID
			hs.putValue("strDivId",strDivId);	//Session ID
			hs.putValue("strSiteId",strSiteId);	//Session ID
			hs.putValue("strDeptId",strDeptId);	//Session ID
			hs.putValue("strDesigId",strDesigId);	//Session ID
			hs.putValue("strDesigId",strDesigId);	//Session ID
			hs.putValue("strLoginDateTime",strLoginDateTime);	//Session ID
			hs.putValue("strDesigShortName",strDesigShortName);	//Session ID
			hs.putValue("strDesigFullName",strDesigFullName);	//Session ID
			hs.putValue("strSiteFullName",strSiteFullName);	//Session ID
			hs.putValue("strDepartShortName",strDepartShortName);	//Session ID
			hs.putValue("strCurrentYear",strCurrentYear);	//Session ID
			hs.putValue("strUserPass", strUserPass);// User Name
			
			//new
			hs.putValue("golbalApproverRole",strApprovalLevel);
			
			hs.putValue("SSstrSplRole",strSplRole);
			
	
			//ssflage
	
	         
	         //added new to identify visio corp user set ssflage=1 else  2
			String sSql		= "";
	
			sSql= "select 1 from m_userinfo  where  userid="+user_id+" and site_id in (select site_id from m_Site where SMR_SITE_FLAG='Y')";
	
			String flagVis	="2";
	
	
			 
	
			rs1 = dbConBean1.executeQuery(sSql);
	
			if(rs1.next()){
	
			flagVis=rs1.getString(1);
	
			}
			rs1.close();
	
		
	//		// added flage for identifing visio corp user on 12 aug  2009 
			hs.putValue("ssflage",flagVis);    
	
	
			  
			  	String	strSqlStr	=	""; // For sql Statements
				String strCheckAlert		="";
				String strApproverRole 		= "";
				String strSql				= "";	 
				String strPage 		= "no";
				String strOutOFOfficestatus	="";
			   //ssif(strApproverRole!=null)//
			  //Change the page redirection to approval page if is there any pendin requsition to approver on 10-12-2009 by shiv sharma  
			   //if(userRole!=null && !userRole.trim().equals("MATA"))
			   {  
				 
					strSql="SELECT  DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+user_id+"      AND TA.TRAVEL_TYPE='I'  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";
					
					rs = dbConBean.executeQuery(strSql);
					if (rs.next()) 
					{
					   strPage	=	"yes"; 
					   
					}
					rs.close();
					
					strSql="SELECT  DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+user_id+"      AND TA.TRAVEL_TYPE='D'  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";
					rs = dbConBean.executeQuery(strSql);
					if (rs.next()) 
					{
					   
					   
					   strPage	=	"yes"; 
					   
					}
					rs.close();
			   }		
	  %>
	  
	  
	  <%
			//Redirection for valid user
	      try {
	        	
	    	  if(strPage.equals("yes")) 
	    	  {
	        	%>
	        	   <jsp:forward page="innerMainforApproval.jsp" >
	        	   	<jsp:param name="Userid" value="<%=user%>" />
	        	   </jsp:forward> 
	        	<% 
	    	  }else{
	    		  %>
	        	   <jsp:forward page="innerMain.jsp" >
	        	   	<jsp:param name="Userid" value="<%=user%>" />
	        	   </jsp:forward> 
	        	<% 
	    	  
	    		   	
	    	  }
	        	
		}catch(Exception e){
			System.out.println("===============error============="+e);  
		}
			
		
	 
		con.close();
	
		} 
		else
		{
			//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>2345>>>>");
			response.sendRedirect("invalidUser.jsp");
		}
			
	}
	else
	{
		propfile.close();
		response.sendRedirect("invalidUser.jsp");
	}
	 
	
	//	###################################End of File #########################
	%>
	
	</body>
	</html>
	
