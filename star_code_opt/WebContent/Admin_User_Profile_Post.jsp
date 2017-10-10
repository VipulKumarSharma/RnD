	<%
	/*************************************************** 
	 *The information contained here in is confidential and 
	 *proprietary to MIND and forms the part of the MIND 
	 *Author				:Gaurav Aggarwal 
	 *Date of Creation 		:18 May2007 
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STARS
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is Jsp post  file  for updating the M_USERINFO in the STARS Database 
	                         and Granting Multiple  access to the user(s) for  different sites
	 *Modification			:
	 *Reason of Modification:1Issue_Log_STARS.xls point no. 53 and 54
	                          2 .code is added  by shiv on for getting person to "report to " on 25-May-07 by shiv sharma
	                          3: Added  new fields for windows user id,domian id & sso flage on 05-02-2009 by shiv sharma  
	                          4: code change for allowing multiple Local admin for one unit on 16 march 2010 by shiv sharma 
	 *Date of Modification  :1. 16-May-2007
	 *Modification By		:1. Gaurav Aggarwal 
	 *Editor				        :         Editplus
	 :Modified by vaibhav on Aug 20 2010 to give billing approver rights
	 
	 *Modified By		:Manoj Chand
	 *Date of Modification	: 19 dec 2011
	 *Modification		: modify page to add any one as billing approver for the site.
	 
	 *Modified By		:Manoj Chand
	 *Date of Modification	: 28 Mar 2012
	 *Modification		: Post page to save board member for SMP
	 
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 23 Aug 2012
	 *Modification			: Resolve issue related to report to person was not update in case of japanese language.
	 
	 *Modified By					:Manoj Chand
	 *Date of Modification			:03 June 2013
	 *Modification					:Provision to give access of a site to user for approval level 1 and 2.
	 *******************************************************/
	%>
	<%@ page pageEncoding="UTF-8" %>
	<%@ include  file="importStatement.jsp" %>
	
	<%@page import="java.net.URLEncoder"%>
	<html>
	<head>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include page styles  --%>
	<%@ include  file="systemStyle.jsp" %>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<!--Create the DbUtilityMethods object for utility methods-->
	<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
	</head>
	
	
	<%
	request.setCharacterEncoding("UTF-8");
	//<%= enum enumLAUH{YY,YN,NY,NN} 
	    // Global Variables declared and initialized
		
		Connection objCon				    = null;			    // Object for connection
		Connection objCon2				    = null;	
	    ResultSet objRs,rs		            = null;			    // Object for ResultSet
	    CallableStatement objCstmt		    = null;			    // Object for Callable Statement
		StringBuffer  strMessage            = new StringBuffer(""); 
		StringBuffer strUpdateProfile		= new StringBuffer("");
		String strUrl                       = "";
		String strSql                       = "";
	    String strUserId                    = "";     //Get the User Id
		String strFirstName                 = "";
		String strLastName                  = "";
		String strEmpcode                   = "";
		String strEmail                     = "";
		String strDivId                     = "";
		String strSiteId                    = "";	
		String strDeptId                    = "";
		String strDesigId                   = "";
		String strReportTo                  = "";      // when user not select any new report to userid
		String strDob						= ""; //added on 16-May-07 by shiv 
		String strSiteIdnew                 = "";
		String strDeptIdnew					= "";
		String strDesigIdnew                = "";
		String strRoleidnew                 = "";
		String strTravelCoordinator			= "";
		String strTC						= "";
		String strAC						= "";
		String strAccountant				= "";
		String strUnitHead					= "";	
		String strLocalAdmin				= "";
		String strUH						= "";
		String strLA						= "";
		String strUpdate					= "";
		String strMiddlename				= "";
		String strUserName  				= "";
		String strUserNameOld  				= "";
		String strRelievingDate				= "";
		
		String strReportTo1			="";
		int intQueryReturn					=1;
		int intLAUH							=0;
		int msgNumber						=0;
		int msgForBillApprover				=0;
		int intLA							=0;
		int intUH							=0;
		int intBM							=0;
		
		String billApprover					="";
		String strBranchManager				="";
		String strUserDivName				="";
	    String strIpAddress					=request.getRemoteAddr();
	    String strBMFlag="no";
	    String strBMFlag1="";
	    String strBMFlag2="";
	    String strApprovallevel1 = null;
	    String strApprovallevel2 = null;
	    String strCostCentre =  "0"; 
	    //Added by shiv for workflow id on 30 oct 2009
		
	    String strSp_role	 = request.getParameter("sp_role")== null ? "0" : request.getParameter("sp_role");
	    
	  //Added by shiv for windows user id and Domain name
		String strWinUserID  = request.getParameter("winUserID")== null ? "" : request.getParameter("winUserID");
		String strDomainName = request.getParameter("domainname")== null ? "" : request.getParameter("domainname");
		String strSsoflag = request.getParameter("ssoflag")== null ? "" : request.getParameter("ssoflag");
	
		//Added by Sachin for SMS Sending Checkbox on 20th Nov 2008	
		String strSendingSMSFlag		=	request.getParameter("smsFlag")==null?"N":request.getParameter("smsFlag").trim(); 
		String CONTACT_NUMBER           =  	request.getParameter("mobNo")==null?"":request.getParameter("mobNo").trim(); 
		
		strUpdate						   =  request.getParameter("Submit").trim();	
		strUserId                          =  request.getParameter("userId")==null?"":request.getParameter("userId").trim(); 
		strFirstName                       =  request.getParameter("firstName")==null?"":request.getParameter("firstName").trim();
	    strLastName                        =  request.getParameter("lastName")==null?"":request.getParameter("lastName").trim();  
	    strEmpcode                         =  request.getParameter("empcode")==null?"":request.getParameter("empcode").trim();  
	  	strEmail                           =  request.getParameter("email")==null?"":request.getParameter("email").trim();  
	    strDivId                           =  request.getParameter("division")==null?"":request.getParameter("division").trim();  
		strSiteId                          =  request.getParameter("site")==null?"":request.getParameter("site").trim();  
		strDeptId                          =  request.getParameter("department")==null?"":request.getParameter("department").trim(); 
		strDesigId                         =  request.getParameter("designation")==null?"":request.getParameter("designation").trim(); 
	
		//commented  by shiv  on 25-May-07
		//strReportTo                        =  request.getParameter("reportto")==null?"":request.getParameter("reportto").trim();
	    strDob                         	   =  request.getParameter("dateOfBirth")==null?"":request.getParameter("dateOfBirth").trim();
	   	strSiteIdnew					   =  request.getParameter("userSite")==null?"":request.getParameter("userSite").trim();  
		strDeptIdnew                       =  request.getParameter("usDept")==null?"":request.getParameter("usDept").trim();  
		strDesigIdnew                      =  request.getParameter("usdesg")==null?"":request.getParameter("usdesg").trim();  
		strRoleidnew                       =  request.getParameter("roleid")==null?"":request.getParameter("roleid").trim();  
	    strLocalAdmin                      =  request.getParameter("LocalAdmin")==null?"":request.getParameter("LocalAdmin").trim();  
		strUnitHead                        =  request.getParameter("UnitHead")==null?"":request.getParameter("UnitHead").trim();
		billApprover					   =  request.getParameter("billApprover")==null?"":request.getParameter("billApprover").trim();
		strBranchManager				   =  request.getParameter("branchManager")==null?"":request.getParameter("branchManager").trim();
		strUserDivName					   =  request.getParameter("userDivision")==null?"N":request.getParameter("userDivision");
		strApprovallevel1				   =  request.getParameter("approvallevel1")==null?"N":request.getParameter("approvallevel1");
		strApprovallevel2				   =  request.getParameter("approvallevel2")==null?"N":request.getParameter("approvallevel2");
		strUserName						   =  request.getParameter("userName")==null?"":request.getParameter("userName").trim();
		strUserNameOld					   =  request.getParameter("userNameOld")==null?"":request.getParameter("userNameOld").trim();
		strRelievingDate               	   =  request.getParameter("relievingDate")==""?null:request.getParameter("relievingDate").trim();
		
		strTravelCoordinator			   =  request.getParameter("travelCoordinator")==null?"":request.getParameter("travelCoordinator").trim();
		strAccountant					   =  request.getParameter("accountant")==null?"":request.getParameter("accountant").trim();
		
		objCon               			   =  dbConBean.getConnection();
		objCon2              			   =  dbConBean.getConnection();
		
	   ////code added by shiv  on 25-May-07   open
	     String flag = "";
	     strReportTo                        =  request.getParameter("repTo")==null?"":request.getParameter("repTo").trim();
		 strReportTo1                        =  request.getParameter("repToUserId")==null?"s1":request.getParameter("repToUserId").trim();
	  	 if(strReportTo1 != null && !strReportTo1.equals("s1"))
		   {
			strReportTo = strReportTo1;
		   }
		 ////code added by shiv  on 25-May-07 close  
		 //added by shiv on 12 jan 2009 for adding middel name 
		 
		 strMiddlename                        =  request.getParameter("middlename")==null?"":request.getParameter("middlename").trim(); 
	     strCostCentre 						=  request.getParameter("costcentre")==null?"0":request.getParameter("costcentre");
	
		try{
			if(strUpdate.equalsIgnoreCase(dbLabelBean.getLabel("label.suggestions.update",strsesLanguage))){
				String isMobileNoAvailable			=	"Yes";
				boolean userNameNotExist			=   true;
				if(!CONTACT_NUMBER.equals("")){
					isMobileNoAvailable		=	dbUtility.isMobileNoAvailable(strUserId,CONTACT_NUMBER);
				}
				if(!strUserName.equals("") && !strUserName.equalsIgnoreCase(strUserNameOld)){
					userNameNotExist			=	dbUtility.validateUserName(strUserName);
				}
				if(isMobileNoAvailable.equalsIgnoreCase("yes") && userNameNotExist){
					//PROCEDURE TO update  M_USERINFO IN M_USERINFO TABLE 
					objCstmt = objCon.prepareCall("{?=call PROC_UPDATE_USER_PROFILE_ADMIN(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					objCstmt.setString(2, strUserId);
					objCstmt.setString(3, strUserName);
					objCstmt.setString(4, strFirstName);
					objCstmt.setString(5, strLastName);
					objCstmt.setString(6, strEmail);
					objCstmt.setString(7, strDivId);
					objCstmt.setString(8, strSiteId);
					objCstmt.setString(9, strDeptId);
					objCstmt.setString(10, strDesigId);
					objCstmt.setString(11, strReportTo); 
					objCstmt.setString(12, strDob); 
					objCstmt.setString(13, Suser_id);//set the current user Login UserId
					objCstmt.setString(14,strEmpcode);
					objCstmt.setString(15,strSendingSMSFlag);
					objCstmt.setString(16,CONTACT_NUMBER);
					// added on 12 jan 2009 by shiv Sharma 
					objCstmt.setString(17,strMiddlename);
					// added on  03 Feb 2009 by shiv Sharma 
					objCstmt.setString(18,strDomainName);
					objCstmt.setString(19,strWinUserID);
					objCstmt.setString(20,strSsoflag);
					// added on 30 Oct  2009 by shiv Sharma
					objCstmt.setString(21,strSp_role);
					objCstmt.setString(22,strIpAddress);
					objCstmt.setString(23,strRelievingDate);
					objCstmt.setString(24,strCostCentre);
					objCstmt.executeUpdate();
					intQueryReturn=objCstmt.getInt(1);	
					
					if(intQueryReturn==0)
					{ 
						
						strUpdateProfile.append(" "+dbLabelBean.getLabel("message.master.profileupdatedsuccessfully",strsesLanguage)+" ");
					}else{
						msgNumber=10;					
					}
					objCstmt.close();
					//System.out.println("Exiting Update");		
				} else if(isMobileNoAvailable.equalsIgnoreCase("no")){
					msgNumber	=	11;
				} else if(!userNameNotExist){
					msgNumber	=	4;
				}
				else{
					msgNumber	=	10;
				}
					
				
			}else{
			  	    
					strSql ="Select * from USER_MULTIPLE_ACCESS where USERID="+strUserId+" and SITE_ID="+strSiteIdnew+" and STATUS_ID=10 ";
					//System.out.println("If a user already contains a record1== "+strSql);
					rs       =   dbConBean.executeQuery(strSql); 
			
					if(rs.next()){
						msgNumber=1;
					}else{
						
						msgNumber=2;
						
						strLA				= "" ;
						strUH				= "0";
						strTC				= "" ;
						strAC				= "" ;
						
						if(strTravelCoordinator.equalsIgnoreCase("Y")){
							strTC="TC";	
							flag = flag+"Travel Coordinator, ";
						}
						if(strAccountant.equalsIgnoreCase("Y")){
							strAC="AC";	
							flag = flag+"Accountant, ";
						}
						if(strLocalAdmin.equals("y")){
							strLA="LA";	
							flag = flag+dbLabelBean.getLabel("label.master.localadmin",strsesLanguage)+", ";
						}
						if(strUnitHead.equals("1")){
							strUH="1";
							flag = flag+dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage)+", ";
						}
						if(strApprovallevel1.equals("Y")){
							flag = flag+dbLabelBean.getLabel("label.global.approvallevel1",strsesLanguage)+", ";
						}
						if(strApprovallevel2.equals("Y")){
							flag = flag+dbLabelBean.getLabel("label.global.approvallevel2",strsesLanguage)+", ";
						}
						//System.out.println("flag-3->"+flag);	
						
						if(strBranchManager.equals("1")){
							intBM=10;
						}else{
							intBM=0;
						}
						
						if(strUH.equals("1")){
							strSql ="Select * from USER_MULTIPLE_ACCESS where SITE_ID="+strSiteIdnew+" and UNIT_HEAD=1 and STATUS_ID=10 ";
							rs       =   dbConBean.executeQuery(strSql); 
							if(rs.next()){
								msgNumber=3;
								flag = dbLabelBean.getLabel("message.master.unitheadalreadyexist",strsesLanguage);
							}
						}
						if(msgNumber!=3 && !flag.equals("")) {
							objCstmt=  objCon.prepareCall("{?=call PROC_INSERT_ADMIN_LA_ROLE(?,?,?,?,?,?,?,?,?,?,?,?)}");
					 	    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						    objCstmt.setString(2, strUserId);
						    objCstmt.setString(3, strSiteIdnew);							
						    objCstmt.setString(4, strDesigId);
						    objCstmt.setString(5, strDeptId);
						    objCstmt.setString(6, strAC);
						    objCstmt.setString(7, strTC);
						    objCstmt.setString(8, strUH);
						    objCstmt.setString(9, strLA);
						    objCstmt.setString(10, strApprovallevel1);
						    objCstmt.setString(11, strApprovallevel2);
						    objCstmt.setString(12, Suser_id);
						    objCstmt.setString(13, strIpAddress);
						    objCstmt.execute();
							intQueryReturn=objCstmt.getInt(1);	 			
							if(intQueryReturn==0)
							{ 
								//msgNumber =7;
								strBMFlag1="7";
							}else{
								msgNumber=10;
								strBMFlag1="10";
								flag = " "+dbLabelBean.getLabel("label.master.notupdatedsuccessfully",strsesLanguage);
							}
						    objCstmt.close();
						}
							
							if(strBranchManager.equalsIgnoreCase("Y"))
								strBMFlag="yes";
							
							//if(strUserDivName.trim().equalsIgnoreCase("Y") && SuserRole.trim().equalsIgnoreCase("AD"))
							if(!strUpdate.equalsIgnoreCase(dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)) && strBranchManager.equals("Y"))	
							{
								strSql ="SELECT 1 FROM [dbo].[M_BOARD_MEMBER](Nolock) WHERE [SITE_ID]="+strSiteIdnew+" AND [USERID]="+strUserId+" AND [STATUS_ID]=10";
								//System.out.println("strSql===1==>> "+strSql);
								ResultSet rs_BA       =   dbConBean.executeQuery(strSql);
								if(!rs_BA.next()){	
									if(msgNumber!=3){
										strSql = "insert into M_BOARD_MEMBER(SITE_ID,USERID,STATUS_ID,IP_ADDRESS,C_USER_ID,C_DATE) values('"+strSiteIdnew+"','"+strUserId+"','10','"+strIpAddress+"','"+Suser_id+"',getdate())";
										int retval       =   dbConBean.executeUpdate(strSql);
										if(retval == 1){
											flag = flag+dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)+", ";	
										}
									}//end if
								}
							}
								  
						}
					}			 
				
					//Modification by vaibhav starts
					if(billApprover.equals("1"))
						strBMFlag2="30";
					
					if(!strUpdate.equalsIgnoreCase(dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)) && billApprover.equals("1"))
					{
						strSql ="Select * from M_BILLING_APPROVER where APPROVER_ID="+strUserId+" and SITE_ID="+strSiteIdnew;
						//System.out.println("If a user already contains a record== "+strSql);
						ResultSet rs_BA       =   dbConBean.executeQuery(strSql); 
						if(!rs_BA.next()){
							//if block added by manoj on 19 dec 2011	
								if(msgNumber!=3){
							strSql = "insert into M_BILLING_APPROVER values("+strSiteIdnew+","+strUserId+","+hs.getValue("user_id")+",getdate())";
						//System.out.println("Query for Billing approver insert:::"+strSql);
							
							int retval       =   dbConBean.executeUpdate(strSql);
							if(retval == 1){
								flag = flag+dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)+", ";				
							}
						}//end if
							
					}
					}	
					//System.out.println("msgNumber--"+msgNumber);
					//System.out.println("flag--"+flag);
					if(flag.equals(""))
						flag="  ";
										
					switch(msgNumber){
					case 0:		strMessage.append("");
								break;
					case 1:		strMessage.append("<font color='red'>"+dbLabelBean.getLabel("alert.master.recordalreadyexist",strsesLanguage)+"</font>");
								break;
					case 3:	    strMessage.append("<font color='red'>"+dbLabelBean.getLabel("message.master.unitheadalreadyexist",strsesLanguage)+" </font>");
								break;
					case 4:	    strMessage.append("<font color='red'>"+dbLabelBean.getLabel("label.register.userwithsameusernameexists",strsesLanguage)+" </font>");
								break;
					default :
						strMessage.append("<font color='red'>"+flag.substring(0,flag.length()-2)+ " "+dbLabelBean.getLabel("label.master.addedsuccessfully",strsesLanguage)+" </font>");
						//System.out.println(strMessage);
					}
		}catch(Exception e){   	 
			e.printStackTrace();
		 	System.out.println("Error in ADMIN_User_Profile_POST=="+e);
		 }	  
	      strMessage.append(strUpdateProfile);
	      strUrl = "Admin_User_Profile_Edit.jsp?strMessage="+URLEncoder.encode(strMessage.toString().trim(),"UTF-8")+"&userId="+strUserId+"&userName="+strUserName;
	      //System.out.println("strUrl--->"+strUrl);
	 	  response.sendRedirect(strUrl);	
		  dbConBean.close();
%>