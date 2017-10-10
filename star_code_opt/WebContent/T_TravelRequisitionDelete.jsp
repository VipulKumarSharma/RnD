<%@ include  file="importStatement.jsp" %>
<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	Sachin Gupta
*Date			:   21/09/2006
*Description	:	Travel Requisition Delete from List
modification     :  code added to delete from  T_USER_Groupinfo T_GROUP_USERINFO  added by shiv sharma       
                            Code modified for Domestice Group travel requisition  on 02-Jul-08  by shiv sharma 
*
*Project		:   STARS
**********************************************************/
%>
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
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<base target="middle">
</head>
<%
// Variables declared and initialized
Connection objCon				=		null;			    // Object for connection
CallableStatement cstmt			=		null;			// Object for Callable Statement
CallableStatement objCstmt			=		null;			// Object for Callable Statement

String strTravelId	            =       "" ;           // Object to store Requisition ID
String strTravelReqId	        =       "" ;           
String strTravelType            =       "";   


strTravelId     				=	request.getParameter("travelId");
strTravelReqId                  =	request.getParameter("travelReqId");
strTravelType     				=	request.getParameter("travelType");
//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";
strUserAccessCheckFlag = securityUtilityBean.validateAuthCancelTravelReq(strTravelId, strTravelType, Suser_id);
if(strUserAccessCheckFlag.equals("420")){
	dbConBean.close();  
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_TravelRequisitionDelete.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");
	return;
} else {


try
{
  
	   objCon                        =  dbConBean.getConnection(); 		//Get Connection Object

   cstmt                         =  objCon.prepareCall("{?=call PROC_DELETE_TRAVEL_REQUISITION(?,?,?)}");
   cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
   cstmt.setString(2, strTravelId);
   cstmt.setString(3, strTravelReqId);
   cstmt.setString(4, strTravelType);
   cstmt.executeUpdate();
    cstmt.close();   


 

  // delete from   T_USER_Groupinfo T_GROUP_USERINFO    

 try {
       objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?,     ?,?,?,?,   ?,?,?,?,     ?,?,?,?,    ?,?,?,?,   ?,?,?, ?,?,?,?,?,?,?,?,?)}");
	     objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);


	     objCstmt.setString(2,"-1");											   //set  G_userid
		 objCstmt.setString(3,strTravelId);								   //travel_id 
		 objCstmt.setString(4, "");						   //t ravel_type	
		 objCstmt.setString(5, "");		 	    //first Name	of traveler
		 objCstmt.setString(6, "");              //last name  of traveler 
		 objCstmt.setString(7,"");									  //site id of traveler   
		 objCstmt.setString(8, "");								  //desig id of  traveler 
		 objCstmt.setString(9, "50");											 //status_id of requsition 10 					
		 objCstmt.setString(10, "");						     //passport no of user 
		 objCstmt.setString(11, "");        //strPassport_issue_date
		 objCstmt.setString(12, "");       // lace of passport Issue  
		 objCstmt.setString(13, "");		 //strPassport_expire_date
		 objCstmt.setString(14, "");									//age of  	traveler
		  objCstmt.setString(15, "");									 //ECR  value		
		  objCstmt.setString(16, "");							 //strDOB       
		  objCstmt.setString(17, "");                                    //visa required 
		  objCstmt.setString(18, "");											//record type I/U 				 
		  objCstmt.setString(19, "");								//gender 
		  objCstmt.setString(20, "");                                                   //identity _id 
		  objCstmt.setString(21, "");											//identity no	
		  objCstmt.setString(22, "");				//mael prefrence
	       objCstmt.setString(23, "");   //float set  strTotalAmount
	      objCstmt.setString(24, ""); 
		  objCstmt.setString(25, Suser_id);             //set the current user Login UserId
		  objCstmt.setString(26, "DELETE");                                 //operation for procedure 
		   objCstmt.setString(27, "");
		   objCstmt.setString(28, "");
		   objCstmt.setString(29, "");//operation for procedure
		   objCstmt.setString(30, "");//operation for procedure
		   objCstmt.setString(31, "");
		   objCstmt.setString(32, "");
          objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
   		   	  
		   boolean procSuccess=objCstmt.execute();		   
		      }catch(Exception e)
	{
	   System.out.println("Error in T_travelRequsition Delete ------------------------>>>>"+e);
   }

 


   dbConBean.close(); //Close Connection
}
catch(Exception e)
{
	System.out.println("Error in T_TravelRequisitionDelete.jsp======="+e);
}

	if (strTravelType.equals("I")) {
		response.sendRedirect("T_TravelRequisitionList.jsp?purchaseRequisitionId="+strTravelId);
	} else if (strTravelType.equals("D")) {   //Code modified for Domestice Group travel requisition  on 02-Jul-08  by shiv sharma 
		response.sendRedirect("T_TravelRequisitionList_D.jsp?purchaseRequisitionId="+strTravelId);
	}

}
%>

