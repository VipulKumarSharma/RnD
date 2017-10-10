
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj
 *Date of Creation 		:12 Jan 2011
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is post jsp file  for Cancel the Requisition
 *Editor				:Eclipse
 *******************************************************/
%>
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
<%@ include  file="systemStyle.jsp" %>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
int intSuccess            = 0; 
String strTravelType      = "";
String strTravelTypeFlag  = "";
//------------- Start Added by Sachin Gupta on 4/25/2007  for one UnitHead for multiple site---------------
String strTravellerId   = "";
String strTravllerSiteId = "";
//------------- End Added by Sachin Gupta on 4/25/2007 for one UnitHead for multiple site---------------

strTravelType   =  request.getParameter("travelType"); 
String strfinalUrl=request.getParameter("final_url");

//System.out.println("strfinalUrl   on cancel_post_new=="+strfinalUrl);
//System.out.println("strTravelType=="+strTravelType);

String strWhichPage    =  "";
String strTargetFlag   =  "";
String flage					="";

String unitheadcheck	="";
String chairmancheck	 ="";
strWhichPage    =  request.getParameter("whichPage"); 

//System.out.println("strWhichPage=="+strWhichPage);

if(strWhichPage == null)
   strWhichPage = "#";

strTargetFlag    =  request.getParameter("targetFrame"); 
if(strTargetFlag !=null && strTargetFlag.equals("yes"))
{
	strTargetFlag = "yes";
}
Connection con					=		null;			    // Object for connection
ResultSet rs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement

//Create Connection
con=dbConBean.getConnection();
String	sSqlStr=""; // For sql Statements
 
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

String strRequisitionId     	=   ""; // Object to store Requisition ID
strRequisitionId				=	request.getParameter("purchaseRequisitionId");

String strComments          	=   "";
String strSiteId				=	"";
String strUserSiteID			=	"";
String strRoleId				=	"";	
String strTableName				=	"";
//String strUserMailID			=	"";
//System.out.println(""+);
strComments		            	=   request.getParameter("comments");
try
{
	if(SuserRole!=null  && SuserRole.equals("MATA"))
    {
		cstmt=con.prepareCall("{?=call PROC_TRAVEL_REQ_CANCELATION(?,?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strRequisitionId);
		cstmt.setString(3, strComments.trim());
		cstmt.setString(4, Suser_id);
		cstmt.setString(5, strTravelType);
		intSuccess = cstmt.executeUpdate();
		cstmt.close();
	}
	else
	{
		cstmt=con.prepareCall("{?=call PROC_TRAVEL_REQ_CANCELATION_BY_ORIGINATOR(?,?,?,?)}");
		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		cstmt.setString(2, strRequisitionId);
		cstmt.setString(3, strComments.trim());
		cstmt.setString(4, Suser_id);
		cstmt.setString(5, strTravelType);
		intSuccess = cstmt.executeUpdate();
		cstmt.close();
	}
     
    //intSuccess = 1;
	String strMailUserId = "";
    String strUserBillingClient="";



	if(intSuccess > 0 )       
	{
        //this query used for finding that no one approver approve the requisition and  originator cancel that requisition then mail goes to only the first approver not to mata		  
        String  strFlag1 = "no";
		sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND APPROVE_STATUS=10 AND APPLICATION_ID=1 AND STATUS_ID=10";
		rs = dbConBean.executeQuery(sSqlStr);         //get the result set
		if(rs.next())
		{
			strFlag1 = "yes";  //It means no one approve this requisition and originator cancel the requisition
		}
		rs.close();

          //check for unithead or ChairMan on 3/29/2007 open 

		




		if(strFlag1!=null && strFlag1.equals("no") && !SuserRole.equals("MATA"))
		{
			sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND STATUS_ID=10 AND APPLICATION_ID=1 AND ORDER_ID=1";

			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			if(rs.next())
			{
				strMailUserId    =     rs.getString("APPROVER_ID"); 
				//System.out.println("-------Vijay Singh-----------when self cancel----------------------");
                //If Traveller is UH or Chairman then on cancellation a mail to HR/AC is required				
	%>
<%-- 				<jsp:include page="T_requisitionMailOnCancel.jsp"> 
					<jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
					<jsp:param name="mailUserId" value="<%=strMailUserId%>"/>
					<jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
					<jsp:param name="travelType" value="<%=strTravelType%>"/>
				</jsp:include>	--%>
	<%
			}
			rs.close();
			//cancel mail for HR anc AC in case of orignator is UH or  Chairmain --open

			sSqlStr = "SELECT DISTINCT C_USER_ID AS ORIGINATOR_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND  STATUS_ID=10 AND APPLICATION_ID=1";
           // System.out.println("-------Vijay Singh--16/04/2007---------when self cancel----------------------");
			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			while(rs.next())
			{
				strMailUserId  = rs.getString("ORIGINATOR_ID"); 
			}
			rs.close();
			// check for unit head						
              //------------- Start Added by Sachin Gupta on 4/25/2007  for one UnitHead for multiple site---------------
			sSqlStr = "";
			if(strTravelType!=null && strTravelType.equals("I"))
			{
				sSqlStr = "select site_id,traveller_id from t_travel_Detail_Int where travel_id="+strRequisitionId+" and status_id=10";
			}
			else if(strTravelType!=null && strTravelType.equals("D"))
			{
				sSqlStr = "select site_id,traveller_id from t_travel_Detail_Dom where travel_id="+strRequisitionId+" and status_id=10";
			}
			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			if(rs.next())
			{
				strTravllerSiteId = rs.getString("site_id");
				strTravellerId	   = rs.getString("traveller_id");
			}
			rs.close();

			if(strTravllerSiteId != null && !strTravllerSiteId.equals(""))
			{
			   sSqlStr = "SELECT ISNULL(UNIT_HEAD,'0') AS UNIT_HEAD   FROM USER_MULTIPLE_ACCESS where userid="+strTravellerId+" and site_id="+strTravllerSiteId+" and status_id=10 and unit_head=1";
			  
				rs = dbConBean.executeQuery(sSqlStr);
				if(rs.next())
				{
					unitheadcheck			=	"yes";		
				}
				rs.close();
			}

          //------------- End Added by Sachin Gupta on 4/25/2007  for one UnitHead for multiple site---------------
			
			/*sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  userid="+strMailUserId+" AND   UNIT_HEAD=1   AND  STATUS_ID=10  AND APPLICATION_ID=1    ";
			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			while(rs.next())
			{
				unitheadcheck="yes" ;
				
			}
			rs.close();*/
			// check  for chairmain 


			sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE   userid="+strTravellerId+" AND   ROLE_ID IN ('CHAIRMAN')  AND   STATUS_ID=10  AND APPLICATION_ID=1    ";
			//System.out.println("sSqlStr======"+sSqlStr);
             rs = dbConBean.executeQuery(sSqlStr);         
			while(rs.next())
			{
				chairmancheck="yes" ;
				//System.out.println(" case of originator when he cancle hi own request for chairman");
			}
			rs.close();

			sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE   userid="+strMailUserId+" AND   ROLE_ID IN ('CHAIRMAN')  AND   STATUS_ID=10  AND APPLICATION_ID=1    ";
			
			// System.out.println("-------Vijay Singh--19/04/2007--------------19/04/2007--------------");
			 //System.out.println("-------sSqlStr>>>>>>-strRequisitionId------strMailUserId------"+strRequisitionId);

			rs = dbConBean.executeQuery(sSqlStr);         
			while(rs.next())
			{
				chairmancheck="yes" ;
				//System.out.println(" case of originator when he cancle hi own request for chairman");
			}
			rs.close();

			if(strTravelType.equals("I"))
			{
				strTableName=" T_TRAVEL_detail_INT";
			}
			else 
			{
				strTableName=" T_TRAVEL_detail_DOM";
			}
			sSqlStr	=	"SELECT BILLING_CLIENT  FROM "+strTableName+"  WHERE  TRAVEL_ID="+strRequisitionId+"  AND STATUS_ID=10 AND APPLICATION_ID=1";
            
			rs = dbConBean.executeQuery(sSqlStr);
			while(rs.next())
			{
				strUserBillingClient  = rs.getString("BILLING_CLIENT"); 
			}
            rs.close();  
		  
			if(strUserBillingClient!=null && strUserBillingClient.equals("self"))
			{
			//	System.out.println("self vala case ");  
			}
			else if (unitheadcheck!=null && unitheadcheck.equals("yes")||chairmancheck.equals("yes"))
			{
				//System.out.println("----------------case of unit head-------"+strMailUserId +" "+SuserRole);  
				/*sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID = (SELECT  SITE_ID  FROM m_userinfo  WHERE USERID="+strMailUserId+"  AND STATUS_ID=10 AND APPLICATION_ID=1)";
                       */
               //////
                   sSqlStr = "";
			if(strTravelType!=null && strTravelType.equals("I"))
			{
				sSqlStr = "select site_id,traveller_id from t_travel_Detail_Int where travel_id="+strRequisitionId+" and status_id=10";
			}
			else if(strTravelType!=null && strTravelType.equals("D"))
			{
				sSqlStr = "select site_id,traveller_id from t_travel_Detail_Dom where travel_id="+strRequisitionId+" and status_id=10";
			}
			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			if(rs.next())
			{
				strTravllerSiteId = rs.getString("site_id");
				strTravellerId	   = rs.getString("traveller_id");
			}
			rs.close(); 

			   //////



					   
			sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID ="+strTravllerSiteId+" ";
			//System.out.println("-----------------------1-1----- ------------------------");
								 
				rs = dbConBean.executeQuery(sSqlStr);         //get the result set
				while(rs.next())
				{
					strUserSiteID  = rs.getString("USERID"); 

	%>
		<%-- 		<jsp:include page="T_requisitionMailOnCancel.jsp"> 
						<jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
						<jsp:param name="mailUserId" value="<%=strUserSiteID%>"/>    
						<jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
						<jsp:param name="travelType" value="<%=strTravelType%>"/>
					</jsp:include> --%> 
	<%
				}
				rs.close();
			}
               
          //mail for HR anc AC in case of orignator is UH or  Chairmain --close
		}
		else
		{
            String strFlag2  = "no"; 
			// When first approver return the requisition, after that originator cancel this requisition, in this case mail goes to only to the first approver who have returned this requisition.
			
			sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND APPROVE_STATUS=3 AND STATUS_ID=10 AND APPLICATION_ID=1 AND ORDER_ID=1";
			
			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			if(rs.next())
			{
				strFlag2 = "yes";
			}
			rs.close();
			if(strFlag2!=null && strFlag2.equals("yes"))
			{
				//mail goes to first approver
				sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND APPROVE_STATUS=3 AND STATUS_ID=10 AND APPLICATION_ID=1 AND ORDER_ID=1";
				//System.out.println("sqlStr 2====="+sSqlStr);
				rs = dbConBean.executeQuery(sSqlStr);         //get the result set
				if(rs.next())
				{
					strMailUserId    =     rs.getString("APPROVER_ID"); 
					//System.out.println("--------------------------------2----------------------");
	%>
			<%-- 	 <jsp:include page="T_requisitionMailOnCancel.jsp"> 
						<jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
						<jsp:param name="mailUserId" value="<%=strMailUserId%>"/>
						<jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
						<jsp:param name="travelType" value="<%=strTravelType%>"/>
					</jsp:include>	 --%>
    <%
				}
				rs.close();
            }
			else
			{
	            String strFlag3  = "no"; 
				// When after approving first approver, second approver return the requisition, after that originator cancel this requisition, in this case mail goes to all approver that have approve the requisition and mata.
				sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND APPROVE_STATUS=3 AND STATUS_ID=10 AND APPLICATION_ID=1";
				rs = dbConBean.executeQuery(sSqlStr);         //get the result set
				if(rs.next())
				{
					strFlag3 = "yes";
				}
				rs.close();
				if(strFlag3!=null && strFlag3.equals("yes"))
				{
					//query for approver who return requisition
					sSqlStr = "SELECT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND APPROVE_STATUS=3 AND STATUS_ID=10 AND APPLICATION_ID=1";
					
					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					if(rs.next())
					{
						strMailUserId    =     rs.getString("APPROVER_ID"); 
						//System.out.println("--------------------------------3----------------------");


%>
			<%--		<jsp:include page="T_requisitionMailOnCancel.jsp"> 
						  <jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
						  <jsp:param name="mailUserId" value="<%=//strMailUserId%>"/>
						  <jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
						  <jsp:param name="travelType" value="<%=//strTravelType%>"/>
						</jsp:include>  --%>		
<%

					}
					rs.close();


					//query for approver who have approve the requisition i.e. approve_status=10
					/*sSqlStr = "SELECT APPROVER_ID, ROLE FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"'  AND APPROVE_STATUS=10 AND APPLICATION_ID=1 AND STATUS_ID=10";//AND ROLE<>'MATA'  (change by sachin 3/20/2007)
					System.out.println("Hello Vijay how r u ====="+sSqlStr);
					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					while(rs.next())
					{
						strMailUserId    =     rs.getString("APPROVER_ID"); */
%>
				<%--		<jsp:include page="T_requisitionMailOnCancel.jsp"> 
						  <jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
						  <jsp:param name="mailUserId" value="<%=strMailUserId%>"/>
						  <jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
						  <jsp:param name="travelType" value="<%=strTravelType%>"/>
						</jsp:include>--%>
<%
		/*			}
					System.out.println("Hello Vijay how r u ====="+sSqlStr);
					rs.close();
					sSqlStr = "SELECT DISTINCT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND ROLE='MATA' AND  STATUS_ID=10 AND APPLICATION_ID=1";
					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					if(rs.next())
					{
						strMailUserId    =     rs.getString("APPROVER_ID"); 
						//System.out.println("-------------------------------5----------------------");*/
%>
					<%-- <jsp:include page="T_requisitionMailOnCancel.jsp">
						  <jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
						  <jsp:param name="mailUserId" value="<%=strMailUserId%>"/>
						  <jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
						  <jsp:param name="travelType" value="<%=strTravelType%>"/>
						</jsp:include> --%>
<%/*
					}
					rs.close();*/
					//System.out.println("Hello Vijay how r u ==18/04/2007VVVVVVV==="+sSqlStr);
					//@changes by vijay on 18/04/2007 in case of return mail sent to HR AC
					/*sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID = (SELECT  SITE_ID  FROM m_userinfo  WHERE USERID="+strMailUserId+"  AND STATUS_ID=10 AND APPLICATION_ID=1)";
                    */

					 /////////

					 sSqlStr = "";
			if(strTravelType!=null && strTravelType.equals("I"))
			{
				sSqlStr = "select site_id,traveller_id from t_travel_Detail_Int where travel_id="+strRequisitionId+" and status_id=10";
			}
			else if(strTravelType!=null && strTravelType.equals("D"))
			{
				sSqlStr = "select site_id,traveller_id from t_travel_Detail_Dom where travel_id="+strRequisitionId+" and status_id=10";
			}
			rs = dbConBean.executeQuery(sSqlStr);         //get the result set
			if(rs.next())
			{
				strTravllerSiteId = rs.getString("site_id");
				strTravellerId	   = rs.getString("traveller_id");
			}
			rs.close();

					 /////////  this query changed by shiv on 09-May-07

					sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID ="+strTravllerSiteId+"";
                     //System.out.println("-----------------------1-2------------------------------");      
								 
							rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					
							while(rs.next())
							{
								strUserSiteID  = rs.getString("USERID"); 
							 %>	
						<%--		<jsp:include page="T_requisitionMailOnCancel.jsp"> 
									<jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
									<jsp:param name="mailUserId" value="<%=//strUserSiteID%>"/>    
									<jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
									<jsp:param name="travelType" value="<%=//strTravelType%>"/>
								</jsp:include>    --%>
		                    <%
							}
							rs.close();
							//end modification
				}
				else  //When no approver return the requisition (Simple Case)
				{
					sSqlStr = "SELECT APPROVER_ID, ROLE FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND APPROVE_STATUS=10 AND APPLICATION_ID=1 AND STATUS_ID=10";//AND ROLE<>'MATA' (changed by sachin 3/20/2007)
					//System.out.println("sqlStr==3/30/2007==="+sSqlStr);

					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					while(rs.next())
					{
						strMailUserId    =     rs.getString("APPROVER_ID"); 
						///-------after first approval by normal user------------//cancel after first approver
                        flage="yes";   
		%>
				<%--		<jsp:include page="T_requisitionMailOnCancel.jsp"> 
						  <jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
						  <jsp:param name="mailUserId" value="<%=//strMailUserId%>"/>
						  <jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
						  <jsp:param name="travelType" value="<%=//strTravelType%>"/>
						</jsp:include>     --%>
		<%
					}
					rs.close();   

					//NEW CODE  ON 3/26/2007 OPEN
					sSqlStr = "SELECT DISTINCT C_USER_ID AS ORIGINATOR_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND  STATUS_ID=10 AND APPLICATION_ID=1";
					rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					while(rs.next())
					{
						strMailUserId  = rs.getString("ORIGINATOR_ID"); 
					}
			       	//check for self billing open	
			
					if(strTravelType.equals("I"))
					{
						strTableName=" T_TRAVEL_detail_INT";
					}
					else 
					{
						strTableName=" T_TRAVEL_detail_DOM";
					}
					sSqlStr	=	"SELECT BILLING_CLIENT  FROM "+strTableName+"  WHERE  TRAVEL_ID="+strRequisitionId+"  AND STATUS_ID=10 AND APPLICATION_ID=1";
               
               		rs = dbConBean.executeQuery(sSqlStr);
					while(rs.next())
					{
						strUserBillingClient  = rs.getString("BILLING_CLIENT"); 
					}
					rs.close();  
					//check for self billing close
	
					if(strUserBillingClient!=null && strUserBillingClient.equals("self"))
					{
	             			//System.out.println("self vala case ");  
					}
                    else if (unitheadcheck.equals("yes")) //(unitheadcheck!=null && unitheadcheck.equals("yes"))
					{
						/*sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID = (SELECT  SITE_ID  FROM m_userinfo  WHERE USERID="+strMailUserId+"  AND STATUS_ID=10 AND APPLICATION_ID=1)";*/

						sSqlStr = "";
								if(strTravelType!=null && strTravelType.equals("I"))
								{
									sSqlStr = "select site_id,traveller_id from t_travel_Detail_Int where travel_id="+strRequisitionId+" and status_id=10";
								}
								else if(strTravelType!=null && strTravelType.equals("D"))
								{
									sSqlStr = "select site_id,traveller_id from t_travel_Detail_Dom where travel_id="+strRequisitionId+" and status_id=10";
								}
								rs = dbConBean.executeQuery(sSqlStr);         //get the result set
								if(rs.next())
								{
									strTravllerSiteId = rs.getString("site_id");
									strTravellerId	   = rs.getString("traveller_id");
								}
								rs.close();
						                                   
                         //// this query Changed by shiv  on 09-May-07 
  								sSqlStr="SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND   STATUS_ID=10  AND  SITE_ID                                          ="+strTravllerSiteId+"	";

								//System.out.println("-----------------------13------------------------------");
							     rs = dbConBean.executeQuery(sSqlStr);         //get the result set
					              while(rs.next())
						              {
							              strUserSiteID  = rs.getString("USERID"); 
			                                  %>
										<%--			<jsp:include page="T_requisitionMailOnCancel.jsp"> 
														<jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
														<jsp:param name="mailUserId" value="<%=//strUserSiteID%>"/>    
														<jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
														<jsp:param name="travelType" value="<%=//strTravelType%>"/>
													</jsp:include>  --%>
			                                <%
						              }
							    rs.close();
					   }
					else if (strUserBillingClient!=null && !strUserBillingClient.equals("self"))
  					{
					   /*sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID = (SELECT  SITE_ID  FROM m_userinfo  WHERE USERID="+strMailUserId+"  AND STATUS_ID=10 AND APPLICATION_ID=1)";
					   */
			                       sSqlStr = "";
									if(strTravelType!=null && strTravelType.equals("I"))
									{
										sSqlStr = "select site_id,traveller_id from t_travel_Detail_Int where travel_id="+strRequisitionId+" and status_id=10";
									}
									else if(strTravelType!=null && strTravelType.equals("D"))
									{
										sSqlStr = "select site_id,traveller_id from t_travel_Detail_Dom where travel_id="+strRequisitionId+" and status_id=10";
									}
									rs = dbConBean.executeQuery(sSqlStr);         //get the result set
									if(rs.next())
									{
										strTravllerSiteId = rs.getString("site_id");
										strTravellerId	   = rs.getString("traveller_id");
									}
									rs.close();
					   /////////


									sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID ="+strTravllerSiteId+"" ;
									//System.out.println("-----------------------1-4------------------------------");
                       			
									rs = dbConBean.executeQuery(sSqlStr);         //get the result set
										while(rs.next())
										{
											strUserSiteID  = rs.getString("USERID"); 
													%>
													<%--	
														<jsp:include page="T_requisitionMailOnCancel.jsp"> 
														<jsp:param name="purchaseRequisitionId" value="<%=strRequisitionId%>"/>
														<jsp:param name="mailUserId" value="<%=strUserSiteID%>"/>    
														<jsp:param name="CancelComments" value="<%=strComments.trim()%>"/>
														<jsp:param name="travelType" value="<%=strTravelType%>"/>
														</jsp:include>
												   --%> 
													<%
										}
										rs.close();
					       }  

				  //NEW  CODE ON 3/26/2007 CLOSE

              		if(SuserRole!=null && SuserRole.equals("MATA")) // IF BLOCK FOR THE MATA WHEN MATA CANCEL THE REQUSITION
					{
						sSqlStr = "SELECT DISTINCT C_USER_ID AS ORIGINATOR_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND  STATUS_ID=10 AND APPLICATION_ID=1";
				
								rs = dbConBean.executeQuery(sSqlStr);         //get the result set
                                //System.out.println("sSqlStr========"+sSqlStr); 

								while(rs.next())
						          {
							           strMailUserId  = rs.getString("ORIGINATOR_ID"); 
							    %>
						<%-- 			<jsp:include page="T_requisitionMailOnCancel.jsp"> 
										<jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
										<jsp:param name="mailUserId" value="<%=//strMailUserId%>"/>
										<jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
										<jsp:param name="travelType" value="<%=//strTravelType%>"/>
									</jsp:include>  --%>
	                             <%
						          }
						          rs.close();
        				///// new change on 3/21/2007 open  mail for HR and AC person on cancelation on MATA  add by shiv on 3/22/2007 
           		  
									if(strTravelType.equals("I"))
									{
										strTableName=" T_TRAVEL_detail_INT";
									}
									else
									{
										strTableName=" T_TRAVEL_detail_DOM";
									}
				
								   sSqlStr	=	"SELECT BILLING_CLIENT  FROM "+strTableName+"  WHERE  TRAVEL_ID="+strRequisitionId+"  AND STATUS_ID=10 AND APPLICATION_ID=1";
                 
									rs = dbConBean.executeQuery(sSqlStr);
									while(rs.next())
									{
										strUserBillingClient  = rs.getString("BILLING_CLIENT"); 
										//System.out.println("case of self finance");							
									}
									rs.close();  
					
									if(strUserBillingClient!=null && strUserBillingClient.equals("self"))
									{
										//System.out.println("self vala case ");  
									}
									else //if (!flage.equals("yes"))
						              {
							  
											/*		sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' ) AND  STATUS_ID=10   AND  SITE_ID = (SELECT  SITE_ID  FROM m_userinfo  WHERE USERID="+strMailUserId+"  AND STATUS_ID=10 AND APPLICATION_ID=1)";
																	*/	
														sSqlStr = "";
														if(strTravelType!=null && strTravelType.equals("I"))
														{
															sSqlStr = "select site_id,traveller_id from t_travel_Detail_Int where travel_id="+strRequisitionId+" and status_id=10";
														}
														else if(strTravelType!=null && strTravelType.equals("D"))
														{
															sSqlStr = "select site_id,traveller_id from t_travel_Detail_Dom where travel_id="+strRequisitionId+" and status_id=10";
														}
														rs = dbConBean.executeQuery(sSqlStr);         //get the result set
														if(rs.next())
														{
															strTravllerSiteId = rs.getString("site_id");
															strTravellerId	   = rs.getString("traveller_id");
														}
														rs.close();
																	////
														
														sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' )  AND  STATUS_ID=10   AND  SITE_ID ="+strTravllerSiteId+" ";	
														//System.out.println("-----------------------1-5------------------------------"+sSqlStr);
														rs = dbConBean.executeQuery(sSqlStr);         //get the result set
														while(rs.next())
														 {
															strUserSiteID  = rs.getString("USERID"); 
																  %>	
																
														<%--  			  <jsp:include page="T_requisitionMailOnCancel.jsp"> 
																		<jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
																		<jsp:param name="mailUserId" value="<%=//strUserSiteID%>"/>    
																		<jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
																		<jsp:param name="travelType" value="<%=//strTravelType%>"/>
																	</jsp:include>  --%>
																
																<%
														 }
														rs.close();
											}
 					         }//////  case close when mata cancel the request   
					         else    // ELSE BLOCK FOR THE ORIGINATOR WHEN ORIGINATOR CANCEL THE REQUSITION
							  {
											//Changes by Vijay Singh @18/04/2007 for generating the right workflow in case of cancel
											sSqlStr = "SELECT DISTINCT C_USER_ID AS ORIGINATOR_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND  STATUS_ID=10 AND APPLICATION_ID=1";
											rs = dbConBean.executeQuery(sSqlStr);         //get the result set

											//System.out.println("sSqlStr2========"+sSqlStr);
										   while(rs.next())
											{
											strMailUserId  = rs.getString("ORIGINATOR_ID"); 
												%>
											<%-- 			<jsp:include page="T_requisitionMailOnCancel.jsp"> 
														<jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
														<jsp:param name="mailUserId" value="<%=//strMailUserId%>"/>
														<jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
														<jsp:param name="travelType" value="<%=//strTravelType%>"/>
														</jsp:include>  --%>
												<%
											}
											rs.close();
											///// new change on 3/21/2007 open  mail for HR and AC person on cancelation by self
																  
											if(strTravelType.equals("I"))
												{
												    strTableName=" T_TRAVEL_detail_INT";
												}
											else
											   {
													strTableName=" T_TRAVEL_detail_DOM";
												}
													
											  sSqlStr	=	"SELECT BILLING_CLIENT  FROM "+strTableName+"  WHERE  TRAVEL_ID="+strRequisitionId+"  AND STATUS_ID=10 AND APPLICATION_ID=1";
																 
											rs = dbConBean.executeQuery(sSqlStr);
											while(rs.next())
												{
													strUserBillingClient  = rs.getString("BILLING_CLIENT"); 
											    }
											rs.close();  
																
											if(strUserBillingClient!=null && strUserBillingClient.equals("self"))
												{
												//System.out.println("self vala case ");  
												 }
											else //if (!flage.equals("yes"))
												{
											String maxOrderId="";
											String minOrderId="";
											 //System.out.println("18/04/2007 strMailUserId  ----"+strMailUserId);
										   /*			sSqlStr	=	"SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC') AND  STATUS_ID=10   AND  SITE_ID = (SELECT  SITE_ID  FROM m_userinfo  WHERE USERID="+strMailUserId+"  AND STATUS_ID=10 AND APPLICATION_ID=1)";
										   */
							   sSqlStr = "";
								if(strTravelType!=null && strTravelType.equals("I"))
										 {
										sSqlStr = "select site_id,traveller_id from t_travel_Detail_Int where travel_id="+strRequisitionId+" and status_id=10";
										  }
								else if(strTravelType!=null && strTravelType.equals("D"))
										{
										sSqlStr = "select site_id,traveller_id from t_travel_Detail_Dom where travel_id="+strRequisitionId+" and status_id=10";
										}
								 rs = dbConBean.executeQuery(sSqlStr);         //get the result set
								 if(rs.next())
										{
											strTravllerSiteId = rs.getString("site_id");
											strTravellerId	   = rs.getString("traveller_id");
										}
										rs.close();
								  
                                /// case  when cancle by  origanator when pending with MATA  11-May-2007    

								  sSqlStr="SELECT USERID FROM M_USERINFO WHERE  ROLE_ID IN ('HR','AC' )  AND  STATUS_ID=10  AND  SITE_ID="+strTravllerSiteId+"";	
								// System.out.println("sSqlStr3========"+sSqlStr);

									rs = dbConBean.executeQuery(sSqlStr);         //get the result set
								
									while(rs.next())
										{
											strUserSiteID  = rs.getString("USERID"); 
												//System.out.println("-----------------------1.6------------------------------"+sSqlStr);																
											%>	
									<%-- 		<jsp:include page="T_requisitionMailOnCancel.jsp"> 
												<jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
												<jsp:param name="mailUserId" value="<%=//strUserSiteID%>"/>    
												<jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
												<jsp:param name="travelType" value="<%=//strTravelType%>"/>
											</jsp:include>   --%>
										   <%
											}
									rs.close();
											
										//@ Vijay Singh added on 18/04/2007
								  sSqlStr = "SELECT MAX(ORDER_ID) AS Expr1 FROM T_APPROVERS WHERE TRAVEL_ID ="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"'";				
								   
								   rs = dbConBean.executeQuery(sSqlStr);
									if(rs.next())
									{
										maxOrderId=rs.getString(1);
									}	
									rs.close();
									
									sSqlStr = "SELECT DISTINCT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND ROLE NOT IN('MATA') AND APPROVE_STATUS = '0' AND  STATUS_ID=10 AND APPLICATION_ID=1";
									rs = dbConBean.executeQuery(sSqlStr);         //get the result set
									
										if(rs.next())
											{
												strMailUserId    =     rs.getString("APPROVER_ID"); 
											
											  %>
								<%-- 				<jsp:include page="T_requisitionMailOnCancel.jsp">
												  <jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
												  <jsp:param name="mailUserId" value="<%=//strMailUserId%>"/>
												  <jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
												  <jsp:param name="travelType" value="<%=//strTravelType%>"/>
												</jsp:include>  --%>
											 <%
											}
										rs.close();
									sSqlStr="SELECT  MIN(ORDER_ID) AS Expr1 FROM T_APPROVERS WHERE APPROVE_STATUS = '0' AND TRAVEL_ID = "+strRequisitionId	+" AND  TRAVEL_TYPE='"+strTravelType+"'";
							
									rs = dbConBean.executeQuery(sSqlStr);
									if(rs.next())
									{
										minOrderId=rs.getString(1);
									}
									rs.close();
									
									if(maxOrderId.equals(minOrderId))
										{

										sSqlStr = "SELECT DISTINCT APPROVER_ID FROM T_APPROVERS WHERE TRAVEL_ID="+strRequisitionId+" AND TRAVEL_TYPE='"+strTravelType+"' AND ROLE='MATA' AND  STATUS_ID=10 AND APPLICATION_ID=1";
									
										  rs = dbConBean.executeQuery(sSqlStr);         //get the result set
											if(rs.next())
													{
															strMailUserId    =     rs.getString("APPROVER_ID"); 
															
																%>
												<%-- 			   <jsp:include page="T_requisitionMailOnCancel.jsp">
															  <jsp:param name="purchaseRequisitionId" value="<%=//strRequisitionId%>"/>
															  <jsp:param name="mailUserId" value="<%=//strMailUserId%>"/>
															  <jsp:param name="CancelComments" value="<%=//strComments.trim()%>"/>
															  <jsp:param name="travelType" value="<%=//strTravelType%>"/>
															</jsp:include>  --%>
																<%
													}
											rs.close();
											}
																 
										//END MODIFICATION
												}

							}//case  close when  originator cancle the request   
		}//end of third else

	}//end of second else
}//end of else first
}
}
catch(Exception e)
{
   System.out.println("Error in T_Travel_Requisition_Cancel_Post.jsp====="+e);
}

//String strUrl = strWhichPage+"?travelType="+strTravelType;
String strUrl = strWhichPage+"?"+strfinalUrl;
dbConBean.close();  //close All Connection
%>
<html>
<head>
<Script>
	function win()
	{
		window.opener.location.href="<%=strUrl%>";
		self.close();
	}
</Script>
<head>
	<body onload="win();">
	<form >
	</form>
	<body>
</html>

