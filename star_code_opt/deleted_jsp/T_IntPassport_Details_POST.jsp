<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:12 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file is for updating the SITE in the STAR Database
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page import = "java.sql.*" %>
<%@ include  file="importStatement.jsp" %>
<%@ include  file="application.jsp" %>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
	<title>Untitled Document</title>
</head>

<!--Create the DbConnectionBean object for createConnection-->
<% 
		request.setCharacterEncoding("UTF-8");
		String strSql                   =  null; 
		ResultSet rs                    =  null; 
		String strTravelReqId           =	"";
        String strTravelId				=	"";
        String strTravelReqNo           =	"";
		String strTravellerSiteId       =	"";
		String strTravellerId			=	"";

	    String strInterimId 			=	"";
   	    strInterimId 					=	request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
	  
        
		strTravelReqId                  =	request.getParameter("travelReqId");    
        strTravelId                     =	request.getParameter("travelId");       
        strTravelReqNo                  =	request.getParameter("travelReqNo");    
        strTravellerSiteId              =	request.getParameter("travellerSiteId");  
		strTravellerId	        	    =	request.getParameter("travellerId");
		
		
		String radioEcnr				=	request.getParameter("ecnrradio");
		String flag						=	request.getParameter("flag");
		String passport_No				=	request.getParameter("passport_No");	
		String passport_issuePlace		=	request.getParameter("passport_issue_place");	
		String passport_issue			=	request.getParameter("passport_issue_date");		
		String passport_expire			=	request.getParameter("passport_expire_date");		
		String passport_DOB				=	request.getParameter("passport_DOB");		
		String passport_contactNo		=	request.getParameter("passport_Contact_No");		
		String passport_Address			=	request.getParameter("passport_address");
		String passport_FNo				=	request.getParameter("passport_flight_No")== null ? "" : request.getParameter("passport_flight_No");
		String passport_FNo1			=	request.getParameter("passport_flight_No1")== null ? "" : request.getParameter("passport_flight_No1");
		String passport_FNo2			=	request.getParameter("passport_flight_No2")== null ? "" : request.getParameter("passport_flight_No2");
//new 16-02-2007
		String strCurrentAddress	=	request.getParameter("current_address")== null ? "" : request.getParameter("current_address");
		String strAirLineName		=	request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
		String strAirLineName1		=	request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
		String strAirLineName2		=	request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");

	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";	
	
	strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(Suser_id, strTravellerSiteId, "0");
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strTravellerId, strTravellerSiteId, "0");
	}	
	if(!strUserAccessCheckFlag.equals("420")){	
		strUserAccessCheckFlag = securityUtilityBean.validateAuthEditTravelReq(strTravelId, "I", Suser_id);		
	}
	if(strUserAccessCheckFlag.equals("420")){
		dbConBean.close();  
		dbConBean1.close();	
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_IntPassport_Details_POST.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");	
	} else {
//
		
	
	Connection objCon,objCon1              =  null;            //Object for Connection 
	objCon               =  dbConBean.getConnection(); 
	objCon1				 =	dbConBean1.getConnection();

	//System.out.println("passport_No---->"+passport_No);
	//System.out.println("strAirLineName--->"+strAirLineName);
	
	CallableStatement proc = 
	objCon.prepareCall("{?=call PROC_TRANSFER_PASSPORTUSERINFO(?,?,?,?,?,?,?,?,?,?,?,?,     ?,?,?,?)}");
	{
		proc.registerOutParameter(1,java.sql.Types.INTEGER);
		proc.setString(2,strTravellerId.trim());
		proc.setString(3, passport_No.trim());
		proc.setString(4, passport_issuePlace.trim());
		proc.setString(5, passport_issue.trim());
		proc.setString(6, passport_expire.trim());
		proc.setString(7, radioEcnr);
		proc.setString(8, passport_DOB.trim());
		proc.setString(9, passport_contactNo.trim());
		proc.setString(10, passport_Address.trim());
		proc.setString(11, passport_FNo.trim());
		proc.setString(12,passport_FNo1.trim());
		proc.setString(13,passport_FNo2.trim());

	//NEW 16-02-2007 SACHIN
		proc.setString(14,strCurrentAddress.trim());
		proc.setString(15,strAirLineName.trim());
		proc.setString(16,strAirLineName1.trim());
		proc.setString(17,strAirLineName2.trim());
//


		proc.execute();
		proc.close();
  } 
 
// connection closed
objCon.close();

if(flag.equals("SaveandProceed"))
{
	CallableStatement proc1 = objCon1.prepareCall("{?=call PROC_TRANSFER_USERINFO_TO_AUDIT_USERINFO(?)}");
	proc1.registerOutParameter(1,java.sql.Types.INTEGER);
	proc1.setString(2,strTravellerId.trim());
	proc1.execute();
	proc1.close();
	objCon1.close();
	response.sendRedirect("T_IntForex_Details.jsp?travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravellerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimId);

}
if(flag.equals("SaveandExit"))
{
response.sendRedirect("T_TravelRequisitionList.jsp?travel_type=INT"); 
}
if(flag.equals("onlySave"))
{
response.sendRedirect("T_IntPassport_Details.jsp?ecnr="+radioEcnr+"&travelId="+strTravelId+"&travelReqId="+strTravelReqId+"&travellerId="+strTravellerId+"&travellerSiteId="+strTravellerSiteId+"&travelReqNo="+strTravelReqNo+"&interimId="+strInterimId); 
}
}%>	

	