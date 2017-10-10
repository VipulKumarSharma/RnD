<%
/*************************************************** 
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand 
 *Date of Creation 		:01 August 2013 
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat 6.0, sql server 2005 
 *Description 			:This file is used to assign rights to user
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
	    ResultSet objRs,rs		            = null;			    // Object for ResultSet
	    CallableStatement objCstmt,cstmt	= null;			    // Object for Callable Statement
		StringBuffer  strMessage            = new StringBuffer(""); 
		String strUrl                       = "";
		String strSql                       = "";
	    String strUserId                    = "";     //Get the User Id
		String strUnitHead					= "";	
		String strLocalAdmin				= "";
		String strUH						= "";
		String strLA						= "";
		String strUpdate					="";
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
	    String strApprovallevel1 = null;
	    String strApprovallevel2 = null;
	    String strAssignSiteId = "";
	    String strSiteId = "",strDeptId="",strDesigId="";
	    	    
		//Added by shiv for workflow id on 30 oct 2009
		strSiteId					       =  request.getParameter("Site")==null?"-1":request.getParameter("Site").trim();
		strUserId                          =  request.getParameter("userName")==null?"-1":request.getParameter("userName").trim(); 
		strAssignSiteId					   =  request.getParameter("AssignSite")==null?"-1":request.getParameter("AssignSite").trim();
	    strLocalAdmin                      =  request.getParameter("LocalAdmin")==null?"":request.getParameter("LocalAdmin").trim();  
		strUnitHead                        =  request.getParameter("UnitHead")==null?"":request.getParameter("UnitHead").trim();
		billApprover					   =  request.getParameter("billApprover")==null?"":request.getParameter("billApprover").trim();
		strBranchManager				   =  request.getParameter("branchManager")==null?"":request.getParameter("branchManager").trim();
		strUserDivName					   =  request.getParameter("userDivision")==null?"N":request.getParameter("userDivision");
		strApprovallevel1				   =  request.getParameter("approvallevel1")==null?"N":request.getParameter("approvallevel1");
		strApprovallevel2				   =  request.getParameter("approvallevel2")==null?"N":request.getParameter("approvallevel2");
		objCon               			   =  dbConBean.getConnection();
	    String flag = "";
	    String strloadflag = request.getParameter("flag")==null?"":request.getParameter("flag");
	    String strActionFlag = request.getParameter("actionflag")==null?"":request.getParameter("actionflag");
	    
	    //System.out.println("strActionFlag------->"+strActionFlag.trim());
	    //System.out.println("strApprovallevel1------->"+strApprovallevel1);
	    //System.out.println("strApprovallevel2------->"+strApprovallevel2);
		try{
				if(strActionFlag.equals("transfer")){
					
					String transfersiteid = request.getParameter("accesstosite")==null?"":request.getParameter("accesstosite");
				    String transferuserid = request.getParameter("transeruser")==null?"":request.getParameter("transeruser");
				    String strCount = request.getParameter("count");
				    int intCount = Integer.parseInt(strCount);
				    int intOutflag=0;
				    String strCheckValue= null,siteid=null,userid=null;
				    for (int j=1;j<=intCount;j++ )
				    {
				    	strCheckValue =  "";
				    	if((request.getParameter("chk"+j)!=null) && !(request.getParameter("chk"+j)).equals("")){
				    		strCheckValue = request.getParameter("chk"+j);
				    	}
				    	//System.out.println(strCheckValue.trim());
			            if(strCheckValue!=null && !strCheckValue.equals(""))
			    	     {
			          		StringTokenizer token = new StringTokenizer(strCheckValue,";"); 
			    	  		while(token.hasMoreTokens())
			    	 		 {
			    		  		siteid = token.nextToken();
			    		  	 	userid = token.nextToken();		 
			    	  		 }
				    	 
				    		try
				    		{
				    	 
				    			//System.out.println(" **************** In transfer rights procedure **************************");
				    			cstmt=objCon.prepareCall("{?=call PROC_TRANSFER_USER_ACCESS_RIGHTS(?,?,?,?,?,?)}");
				        		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				    			cstmt.setString(2, userid);
				    			cstmt.setString(3, siteid);
				    			cstmt.setString(4, transferuserid);
				    			cstmt.setString(5, strIpAddress);
				    			cstmt.setString(6, Suser_id);
				    			cstmt.registerOutParameter(7,java.sql.Types.INTEGER);
				    			cstmt.executeUpdate();	
				    			intOutflag=cstmt.getInt(7);
				    			//System.out.println("intOutflag-->"+intOutflag);
				    			cstmt.close();
				    			
				    			if(intOutflag==0){
				    				strMessage.append("<font color='red'>User Rights Transfer Successfully</font>");
				    			}else{
				    				strMessage.append("<font color='red'>User Rights Transfer Fail</font>");
				    			}
				    			//System.out.println("********************************* in Transfer Rights Procedure Ends *********************");
				    			 
				    		}
				    		catch(Exception ex)
				    		{
				    			System.out.println("Error in M_userRightsAdd_Post.jsp ----->"+ex);
				    		}
				    	}  //end of second if
				    } //end of for
				}
				else{
				strSql = "select DEPT_ID,DESIG_ID from dbo.M_USERINFO mu where USERID="+strUserId+" AND mu.STATUS_ID=10";
				rs       =   dbConBean.executeQuery(strSql); 
				if(rs.next()){
					strDeptId=rs.getString("DEPT_ID");
					strDesigId=rs.getString("DESIG_ID");
				}
				rs.close();
				rs=null;
					strSql ="Select * from USER_MULTIPLE_ACCESS where USERID="+strUserId+" and SITE_ID="+strAssignSiteId+" and STATUS_ID=10 ";
					rs       =   dbConBean.executeQuery(strSql); 
					if(rs.next()){
						msgNumber=1;
					}else{
						
						msgNumber=2;
						
						strLA="";strUH="0";
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
						
						if(strUH.equals("1")){
							strSql ="Select * from USER_MULTIPLE_ACCESS where SITE_ID="+strAssignSiteId+" and UNIT_HEAD=1 and STATUS_ID=10 ";
							rs       =   dbConBean.executeQuery(strSql); 
							if(rs.next()){
								msgNumber=3;
								flag = dbLabelBean.getLabel("message.master.unitheadalreadyexist",strsesLanguage);
							}
						}
						if(msgNumber!=3 && !flag.equals("")){
							
							/*System.out.println("strUserId--------->"+strUserId);
							System.out.println("strAssignSiteId--->"+strAssignSiteId);
							System.out.println("strDesigId-------->"+strDesigId);
							System.out.println("strDeptId--------->"+strDeptId);
							System.out.println("strUH------------->"+strUH);
							System.out.println("strLA------------->"+strLA);
							System.out.println("strApprovallevel1->"+strApprovallevel1);
							System.out.println("strApprovallevel2->"+strApprovallevel2);*/
							
							objCstmt=  objCon.prepareCall("{?=call PROC_INSERT_ADMIN_LA_ROLE(?,?,?,?,?,?,?,?,?,?)}");
					 	    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						    objCstmt.setString(2, strUserId);
						    objCstmt.setString(3, strAssignSiteId);							
						    objCstmt.setString(4, strDesigId);
						    objCstmt.setString(5, strDeptId);
						    objCstmt.setString(6, strUH);
						    objCstmt.setString(7, strLA);
						    objCstmt.setString(8, strApprovallevel1);
						    objCstmt.setString(9, strApprovallevel2);
						    objCstmt.setString(10, Suser_id);
						    objCstmt.setString(11, strIpAddress);
						    
						    objCstmt.execute();
							intQueryReturn=objCstmt.getInt(1);	 			
							if(intQueryReturn==0)
							{ 
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
							
							if(strBranchManager.equals("Y"))	
							{
								strSql ="SELECT 1 FROM [dbo].[M_BOARD_MEMBER](Nolock) WHERE [SITE_ID]="+strAssignSiteId+" AND [USERID]="+strUserId+" AND [STATUS_ID]=10";
								//System.out.println("strSql===1==>> "+strSql);
								ResultSet rs_BA       =   dbConBean.executeQuery(strSql);
								if(!rs_BA.next()){	
									if(msgNumber!=3){
										strSql = "insert into M_BOARD_MEMBER(SITE_ID,USERID,STATUS_ID,IP_ADDRESS,C_USER_ID,C_DATE) values('"+strAssignSiteId+"','"+strUserId+"','10','"+strIpAddress+"','"+Suser_id+"',getdate())";
										int retval       =   dbConBean.executeUpdate(strSql);
										if(retval == 1){
											flag = flag+dbLabelBean.getLabel("label.global.boardmember",strsesLanguage)+", ";	
										}
									}//end if
								}
							}
							
							if(billApprover.equals("1"))
							{
								strSql ="Select * from M_BILLING_APPROVER where APPROVER_ID="+strUserId+" and SITE_ID="+strAssignSiteId;
								ResultSet rs_BA       =   dbConBean.executeQuery(strSql); 
								if(!rs_BA.next()){
									//if block added by manoj on 19 dec 2011	
									if(msgNumber!=3){
									strSql = "insert into M_BILLING_APPROVER values("+strAssignSiteId+","+strUserId+","+hs.getValue("user_id")+",getdate())";
									int retval       =   dbConBean.executeUpdate(strSql);
									if(retval == 1){
										flag = flag+dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)+", ";
										msgNumber=50;
									}
								}//end if
									
								}
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
					default :
						strMessage.append("<font color='red'>"+flag.substring(0,flag.length()-2)+ " "+dbLabelBean.getLabel("label.master.addedsuccessfully",strsesLanguage)+" </font>");
						//System.out.println(strMessage);
					}
			}
		}catch(Exception e){   	 
			e.printStackTrace();
		 	System.out.println("Error in M_userRightsAdd_Post.jsp=="+e);
		 }	  
	      strUrl = "M_userRights.jsp?Message="+URLEncoder.encode(strMessage.toString(),"UTF-8")+"&Site="+strSiteId+"&userName="+strUserId+"&AssignSite="+strAssignSiteId+"&flag="+strloadflag;
	      //System.out.println("strUrl--->"+strUrl);
	 	  response.sendRedirect(strUrl);	
		  dbConBean.close();
%>