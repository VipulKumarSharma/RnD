	<%
	/***************************************************
	*Copyright (C) 2000 MIND
	*All rights reserved.
	*The information contained here in is confidential and *proprietary to MIND and forms the part of the MIND 
	*CREATED BY		:	Abhinav Ratnawat 
	*Date			:	12/12/2005  
	*Description	:	Production Workflow Page
	**Project		:	STARS
	*Modification			:1. Made a procedure for inserting a record PROC_INSERT_M_DEFAULT_APPROVERS
	*Reason of Modification:1. Code Enhancement
	                                        2.Code added for adding CC mail of mata person when mata approver is added in  
											    workflow  on 26-Mar-08 by shiv Sharma    
	
	*Date of Modification  :1. 16-May-2007
	*Modification By		:1. Gaurav Aggarwal 
	
	*Modified By			: Manoj Chand
	*Date of Modification	: 05 August 2011
	*Modification			: implementing Remark in workflow screen
	
	*Modified By			: Manoj Chand
	*Date of Modification	: 14 August 2012
	*Modification			: adding if condition for sprole
	**********************************************************/%>
	<%@ page import= "java.sql.*" pageEncoding="UTF-8" %>
	
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include page styles  --%>
	<%-- <%@ include  file="systemStyle.jsp" %> --%>
	
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbUtilityBean" scope="page" class="src.connection.DbUtilityMethods" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<%
	request.setCharacterEncoding("UTF-8");
	Connection objCon				    = null;	
	ResultSet rs						= null;
	
	String samicolan=";";
	String strMailID="";
	
	List EmailList=new ArrayList(); 
	String arrayOfStrings[]= new String[20];
	
	String strSiteId				= request.getParameter("ID");
	String strDesigId		    = request.getParameter("DESIGINFO");
	String strVal	                = request.getParameter("VAL");
	String strUinfo	            = request.getParameter("UINFO");
	String strOrder	        = request.getParameter("ORD");
	String strWKType       = request.getParameter("TYPE");
	String strTravelType    = request.getParameter("TTYPE");
	String strRemark		= request.getParameter("remark");
	String strMessg           ="";
	String strValidMailId		="";
	String flag                    =""; //flage to add  CC  mail  ID  with mata apprver 
	String strmailId			="";
	
	String spRole= request.getParameter("sprole")== null ? "0" : request.getParameter("sprole");
	//added by manoj chand on 14 aug 2012
	if(spRole.equalsIgnoreCase("")){
		spRole="0";
	}
	//System.out.println("spRole=====123==="+spRole);
	
	
	if(SuserRole.equalsIgnoreCase("AD") && strOrder.equals("10")) 
	   {  
	       strmailId			=request.getParameter("mail_ids").trim();
	   }
	 
	
	// code added for adding CC mail of mata person when mata approver is added in  workflow  on 26-Mar-08 by shiv Sharma   
	if(!strmailId.equals("") && strmailId!=null)
	{
	    arrayOfStrings=strmailId.split(samicolan);
	
	     for (int i=0;i<arrayOfStrings.length;i++) 
		  { 
		   
		     if(dbUtilityBean.validateEmailID(arrayOfStrings[i])==false)
			   {
	             strMessg="<font color=green>"+dbLabelBean.getLabel("message.administration.mailidofmataassociateaddedsuccessfully",strsesLanguage)+"</font>";
				 flag="1";
			     strValidMailId+=arrayOfStrings[i]+";";
		     	}
			else
			{
		         strMessg="<font color=red>"+dbLabelBean.getLabel("message.administration.mailidofmataassociateisnotvalid",strsesLanguage)+"</font>";
				 flag="2";
			     strValidMailId="";
			     break;
			}
	 	}
	}
	else{
		 strValidMailId="";
		 flag="1";
	}
	
	
	String strUserId = Suser_id;
	String strIPAddress	="172.29.32.151";
	String strSqlInsert="";
	String strSql      ="";
	String strApplicationID = "1";
	String strRecordType = "I";
	
	String strTempOrder = "";
	int intQueryReturn=1;
	boolean isOrderExist = false;
	CallableStatement objCstmt		    = null;
	
	//Query for finding the order of approver is exist or not, if order is exist then we doesn't put the multiple entry for the same order.
	strSql = "SELECT LTRIM(RTRIM(ORDER_ID)) AS ORDER_ID, RTRIM(TRV_TYPE) AS TRV_TYPE FROM M_DEFAULT_APPROVERS WHERE APPLICATION_ID =1 AND STATUS_ID=10 AND SITE_ID="+strSiteId+" AND TRV_TYPE='"+strTravelType+"' and sp_role="+spRole+" ORDER BY TRV_TYPE,ORDER_ID";
	rs = dbConBean.executeQuery(strSql);
	while(rs.next())
	{
		strTempOrder = rs.getString("ORDER_ID");
		if(strOrder != null && strOrder.equals(strTempOrder))
		{
			isOrderExist = true;
		}
	}
	rs.close();
	
	if(flag.equals("1") ) // 
	{
	if(!isOrderExist)     //SAME ORDER NOT BE INSERT AGAIN
	{
		
		 //@Gaurav 16-May-2007	 Made a procedure for inserting a record PROC_INSERT_ADMIN_LA_ROLE
			try 
		    {
							objCon               =  dbConBean.getConnection(); 
							objCstmt=  objCon.prepareCall("{?=call PROC_INSERT_M_DEFAULT_APPROVERS(?,?,?,?,?,?,?,?,?,?,?    ,?)}");
					 	    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						    objCstmt.setString(2, strSiteId);
						    objCstmt.setString(3, strUinfo);
							objCstmt.setString(4,strOrder);
							objCstmt.setString(5,strUserId);
							objCstmt.setString(6,strIPAddress);
							objCstmt.setString(7,strTravelType);
							objCstmt.setString(8,strDesigId);
							objCstmt.setString(9,strApplicationID);
							objCstmt.setString(10,strRecordType);
	
							objCstmt.setString(11,strValidMailId); // added intimator of mata  by shiv on 19-Mar-08
							objCstmt.setString(12,spRole); // added intimator of mata  by shiv on 30-oct-2009
							objCstmt.setString(13,strRemark);
						    objCstmt.execute();
							intQueryReturn=objCstmt.getInt(1);
							if(intQueryReturn==0)
							{ 
															//System.out.println("!Success in M_WorkflowAddNewApprover.jsp=========== ");
	
							}else{
								System.out.println("!Error in Executing Procedure=========== ");
							}
	
							objCstmt.close();						
	
			}catch (Exception e) {
							System.out.println("!Error in M_WorkFlowAddNewApprover.jsp=========== "+e);
							e.printStackTrace();
			}finally{
						try{
				
							}catch(Exception e){		
							}
			}						
			//@Gaurav 16-May-2007	End Code 
		
		/*strSqlInsert="INSERT INTO M_DEFAULT_APPROVERS(SITE_ID, APPROVER_ID,  ORDER_ID, STATUS_ID, C_USER_ID, C_DATETIME, C_IPADDRESS,TRV_TYPE,DESIG_ID,APPLICATION_ID,RECORD_TYPE)VALUES("+strSiteId+",'"+strUinfo+"','"+strOrder+"',10,"+strUserId+",GETDATE(),'"+strIPAddress+"','"+strTravelType+"' ,'"+strDesigId+"','"+strApplicationID+"','"+strRecordType+"')";
	
		
			dbConBean.executeUpdate(strSqlInsert);	*/
		}
	}
	%>
	<FORM METHOD=POST NAME=FRM ACTION="M_WorkFlowAddApprover.jsp">
	<input type=hidden name="ID" value=<%=strSiteId%>>
	<input type=hidden name="VAL" value=<%=strVal%>>
	<input type=hidden name="TYPE" value=<%=strWKType%>>
	<input type=hidden name="strMessg" value="<%=strMessg%>">
	</form>
	<SCRIPT LANGUAGE="JavaScript">
	document.FRM.submit();
	</SCRIPT>
	</html>
