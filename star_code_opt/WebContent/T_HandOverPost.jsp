<%
/***************************************************
**** The information contained here in is confidential and ******
**** proprietary to MIND and forms the part of the MIND ****** 
*Author			  :Shiv Sharma
*Date of Creation : 29/09/2008

**** Copyright Notice :Copyright(C)2000 MIND.All rights reserved. ******
**** Project	  : STAR ****** 
**** Operating environment :Tomcat, sql server 2000 ******
**** Description : This is the second jsp file for transferng reqs  ******
**** Modification : ******
**** Reason of Modification :  
							: 
**** Date of Modification   : on 3/21/2007,14/04/2007
**** Modified By			: Vijay Singh
**** Revision History		: none******
**** Editor					:Editplus ******

**** Date of Modification   : 24 jan 2011
**** Modified By			: Manoj Chand
**** Editor					: Eclipse

**** Date of Modification   : 02 mar 2011
**** Modified By			: Manoj Chand
**** Modification			: insert handover remarks from textbox. 

**** Date of Modification   : 02 NOV 2012
**** Modified By			: Manoj Chand
**** Modification			: ONLY CURRENTLY PENDING REQUISITION NUMBER WILL GONE IN HANDOVER EMAIL. NO MAIL WILL SEND FOR
							  HANDOVER OF FUTURE REQUESTS.
**********************************************************/
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
</head>
<%
request.setCharacterEncoding("UTF-8");
//added by manoj on 24 jan 2011
String strFlag				= (request.getParameter("strflag")==null)?"":request.getParameter("strflag").trim();

//String strFlag				= (request.getParameter("flag")==null)?"":request.getParameter("flag").trim();

String strpageFlag				= (request.getParameter("strpageflag")==null)?"":request.getParameter("strpageflag").trim();
//String strwhichpage="n";

/*System.out.println("strwhichpage-->"+strFlag);
System.out.println("strpageflag-->"+strpageFlag);*/
// Variables declared and initialized
Connection con					=		null;			    // Object for connection
Statement stmt					=		null;			   // Object for Statement
ResultSet rs					=		null;			  // Object for ResultSet
CallableStatement cstmt			=		null;			// Object for Callable Statement

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	strSqlStr=""; // For sql Statements
String strCount					=	""; //object to store no of rows selected
int	   intCount					=	0;
String strCheck				    =	"";
String strDelegateName			=	"";
String strCheckValue            =   "";
String strTravelId              =   "";
String strTravellerId           =   "";
String strAutoTransferMechanism =   "";
String strTraveltype            =   "";
String	strTravel	            =   "";

String strAllRequsitionNo       =   "";  //new fields
String strTempRequsitionNo      =   "";  //new fields
String strCreationDate			="";  //Added by shiv on 3/21/2007
String strDelegateTOName		="";
String strReason				="";
String strTraveltypeTemp		="";
String strTravelTypeTemp		="";

String strSite					="";

strDelegateName					=	request.getParameter("DelegatefromUserid");
strDelegateTOName				=	request.getParameter("delName"); 
		//strReason						=   request.getParameter("reasons");
strReason						=   request.getParameter("handover_remarks");//created by manoj on 02 mar 2011
//System.out.println("strReason----->"+strReason);
strTraveltype					=   request.getParameter("Travel_type");

strTraveltypeTemp				=   request.getParameter("Travel_type_temp");


String strTraveIdS				="-1";

strSite							= request.getParameter("SelectUnit");

strCount	 					=	request.getParameter("count");	// GET COUNT

intCount						=	Integer.parseInt(strCount);	//get int value for count
int intOutflag=0;

//Added By Gurmeet Singh
String strUserAccessCheckFlag = "";
strUserAccessCheckFlag = securityUtilityBean.validateAuthSiteUserAccess(strDelegateTOName, strSite, "0");
if(strUserAccessCheckFlag.equals("420")){
	dbConBean.close(); 
	dbConBean1.close();
	securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_HandOverPost.jsp", "Unauthorized Access");
	response.sendRedirect("UnauthorizedAccess.jsp");	
} else {

for (int j=1;j<=intCount;j++ )
{
	strCheckValue =  "";  //set blank value;

	if((request.getParameter("chk"+j)!=null) && !(request.getParameter("chk"+j)).equals(""))
		
		strCheckValue = request.getParameter("chk"+j);
	    
        if(strCheckValue!=null && !strCheckValue.equals(""))
	     {
      		StringTokenizer token = new StringTokenizer(strCheckValue,";"); 
	  		while(token.hasMoreTokens())
	 		 {
		  		strTravelId     =  token.nextToken();
		  		strTravellerId  =  token.nextToken();		 
		  		strTravelTypeTemp  =  token.nextToken();	
		  		
	  		}  //--end of while
	 
	  boolean str=request.getParameter("transType"+j).trim().equals("REQS");
	  
	  //System.out.println(str);
	  if(str)
	  {
	
		try
		{
	 
			 //System.out.println(" **************** In transfer procedure **************************");
			cstmt=con.prepareCall("{?=call PROC_REQ_HANDOVER(?,?,?,?,?,?,?)}");
    		cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt.setString(2, strTravelId);
			cstmt.setString(3, strDelegateTOName);
			cstmt.setString(4, strDelegateName);
			cstmt.setString(5, strReason);	
			cstmt.setString(6, strTravelTypeTemp);
			cstmt.setString(7, Suser_id);
			cstmt.registerOutParameter(8,java.sql.Types.INTEGER);
			cstmt.executeUpdate();	
			intOutflag=cstmt.getInt(8);
			//System.out.println("intOutflag-->"+intOutflag);
			cstmt.close();
			//ADDED BY MANOJ CHAND ON 02 NOV 2012 TO CURRENTLY PENDING REQUISITION NUMBER IN HANDOVER MAIL
			if(intOutflag==420){
				securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "T_HandOverPost.jsp", "Unauthorized Access");
				response.sendRedirect("UnauthorizedAccess.jsp");
				return;
			}
			if(intOutflag==2){
			strTraveIdS=strTraveIdS+","+strTravelId;
			}
			//System.out.println("********************************* in Transfer Procedure Ends *********************");
			 
		}
		catch(Exception e_2)
		{
			System.out.println("Error in T_purchaseReqTransferPost.jsp =======0========"+e_2);
		}
	  } //end of third if
	}  //end of second if
} //end of for
%>
<%
if(!strTraveIdS.equals("-1")){ %>
	<jsp:include page="T_MailOnHandover.jsp">
		<jsp:param name="DelegateToUserId" value="<%=strDelegateTOName%>"/>
		<jsp:param name="DelegateFromUserId" value="<%=strDelegateName%>"/> 	
		<jsp:param name="TravelId" value="<%=strTraveIdS%>"/> 
		<jsp:param name="Traveltype" value="<%=strTraveltype%>"/> 
		<jsp:param name="Reason" value="<%=strReason%>"/> 
	</jsp:include>
<%  
}


%>
<input type="hidden" name="pType" value="<%//=strpType%>"> 
<input type="hidden" name="travel_type" value="<%=strTraveltype%>"> 
<input type="hidden" name="travel_id" value="<%=strTravelId%>"> 
<input type="hidden" name="traveller_id" value="<%=strTravellerId%>"> 

<%

strTraveltype=strTraveltypeTemp;

//String url="T_HandOverRequest.jsp?travel_type="+strTraveltype+"&userid="+strDelegateName;
//String url="T_HandOverRequest.jsp?travel_type="+strTraveltype+"&userid="+strDelegateName+"&whichpage="+strwhichpage;
String url="T_HandOverRequest.jsp?travel_type="+strTraveltype+"&userid="+strDelegateName+"&pageflag="+strpageFlag;
//session.setAttribute("siteforOutFOrmark","-1"); 
//System.out.println(" ----in T_handOverPost.jsp--- and strpageFlag="+strpageFlag);
response.sendRedirect(url);

}%>

</form>