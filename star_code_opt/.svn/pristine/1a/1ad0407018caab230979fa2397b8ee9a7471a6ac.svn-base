<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:30 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for deleting the USERS from the STAR database ******
 *Modification 			:1.   changed code for changing the color of text   on 09-Jul-07 by shiv 
                                  2.// new bolck added for Domestice travel type on 20-Jun-08  by shiv sharma                                         

 *Reason of Modification: 1. Without Revoking the LA/UH roles system should not allow to deactivate the user.
 *Date of Modification  : 1. 02-Apr-2007
 *Revision History		:1. Gaurav Aggarwal
 *Editor				:Editplus
 *******************************************************/
%>

<%@ include  file="importStatement.jsp" %>

<%@page import="java.net.URLEncoder"%><html>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<base target="middle">
</head>
<%
request.setCharacterEncoding("UTF-8");
// Variables declared and initialized
Connection objCon					=		null;			  // Object for connection
CallableStatement objCstmt  			=		null;		      // Object for Callable Statement
objCon                              =       dbConBean.getConnection(); 
 
String strGUserId	    			="";
String strTravel_id				    ="";
String strQuery						= null;
ResultSet rs						    = null;
String strMessage					=	"";
String strTravel_type               ="";
int  intSuccess1  =0;
int intSuccess2  =0;

strGUserId	 	 		    	   	    = request.getParameter("G_userId");
strTravel_id	 	 		    		    = request.getParameter("travel_id");
strTravel_type	 	 		    		    = request.getParameter("travel_type");

//System.out.println("strGUserId================"+strGUserId);
//System.out.println("strTravel_id================"+strTravel_id);
//System.out.println("strTravel_type================"+strTravel_type);
		try
		{

			  objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?,?,?,     ?,?,?,?,   ?,?,?,?,     ?,?,?,?,    ?,?,?,?,   ?,?,?, ?,?,?      ,?,?,?,?)}");
		       objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);


	     objCstmt.setString(2,strGUserId);											   //set  G_userid
		 objCstmt.setString(3,strTravel_id);								   //travel_id 
		 objCstmt.setString(4, "");						   //t ravel_type	
		 objCstmt.setString(5, "");		 	               //first Name	of traveler
		 objCstmt.setString(6, "");                           //last name  of traveler 
		 objCstmt.setString(7,"");						     //site id of traveler   
		 objCstmt.setString(8, "");						      //desig id of  traveler 
		 objCstmt.setString(9, "50");						 //status_id of requsition 10 					
		 objCstmt.setString(10, "");						     //passport no of user 
		 objCstmt.setString(11, "");                         //strPassport_issue_date
		 objCstmt.setString(12, "");                        // place of passport Issue  
		 objCstmt.setString(13, "");		                    //strPassport_expire_date
		 objCstmt.setString(14, "");						   //age of  	traveler
		  objCstmt.setString(15, "");						 //ECR  value		
		  objCstmt.setString(16, "");						 //strDOB       
		  objCstmt.setString(17, "");                          //visa required 
		  objCstmt.setString(18, "");							//record type I/U 				 
		  objCstmt.setString(19, "");							//gender 
		  objCstmt.setString(20, "");                            //identity _id 
		  objCstmt.setString(21, "");							//identity no	
		  objCstmt.setString(22, "");				           //mael prefrence
	       objCstmt.setString(23, "");                         //float set  strTotalAmount
	      objCstmt.setString(24, ""); 
		  objCstmt.setString(25, Suser_id);             //set the current user Login UserId
		  objCstmt.setString(26, "DELETE");          //operation for procedure 
  	      objCstmt.setString(27, "");                          //added for mobile no..  
  	      objCstmt.setString(28, ""); 
  	      objCstmt.setString(29, "N");
  	      objCstmt.setString(30, "");
  	    	objCstmt.setString(31, "");
  	  		objCstmt.setString(32, "");
          objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
   		   

		  	  
		   boolean procSuccess=objCstmt.execute();	
		   
		
		 ///  System.out.println("procSuccess===:"+procSuccess);
 
       //IF USER IS DELETED THE FORM THE TRAVELLER LIST THE ALSO DELETE FROM FOREX TABLE 

if (strTravel_type.equals("i"))
	{
       objCstmt =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_Group(?,?,?)}");
        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
        objCstmt.setString(2, strTravel_id);
		objCstmt.setString(3, strGUserId);
		objCstmt.setString(4, strTravel_type);
      intSuccess1   =  objCstmt.executeUpdate();
        objCstmt.close();   

		 //System.out.println("intSuccess1===07-Mar-08=122=="+intSuccess1);
	   //procedure that update  expenditure in T_travel_details _int   table     

        objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_INT_UPDATE_GROUP(?)}");
        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	    objCstmt.setString(2, strTravel_id);
    	 intSuccess2   =  objCstmt.executeUpdate();
		objCstmt.close();	
		 
		
	}
	else {  // new bolck added for Domestice travel type on 20-Jun-08  by shiv sharma  

	 

		 objCstmt =  objCon.prepareCall("{?=call PROC_DELETE_FOREX_DETAIL_TABLES_Group(?,?,?)}");
        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
        objCstmt.setString(2, strTravel_id);
		objCstmt.setString(3, strGUserId);
		objCstmt.setString(4, strTravel_type);
         intSuccess1   =  objCstmt.executeUpdate();
        objCstmt.close();   

		 //System.out.println("intSuccess1===07-Mar-08=122=="+intSuccess1);


		 //procedure that update  expenditure in T_travel_details _DOM   table     
        objCstmt             =  objCon.prepareCall("{?=call PROC_T_TRAVEL_EXPENDITURE_DOM_UPDATE_GROUP(?)}");
        objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	    objCstmt.setString(2, strTravel_id);
	    intSuccess2   =  objCstmt.executeUpdate();
		objCstmt.close();	
	
	}

		if(!procSuccess  &&   intSuccess1>0 ){
				strMessage=dbLabelBean.getLabel("label.createrequest.userdeletedsuccessfully",strsesLanguage);	
		   }else{
		   		strMessage=dbLabelBean.getLabel("label.createrequest.unsuccessfulattempttodelete",strsesLanguage);	
		   }

	   objCstmt.close();
		}
		catch(Exception e)
		{
			System.out.println("Error in G_userDelete.jsp ==="+e);
		}

//rs.close();
//Connection Close
dbConBean.close();
 
 
if (strTravel_type.equals("i"))

	{
    response.sendRedirect("Group_T_IntTrv_Details.jsp?travelId="+strTravel_id+"&strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"");

	}
else{
	response.sendRedirect("Group_T_TravelDetail_Dom.jsp?travelId="+strTravel_id+"&strMessage="+URLEncoder.encode(strMessage,"UTF-8")+"");
}
%>

