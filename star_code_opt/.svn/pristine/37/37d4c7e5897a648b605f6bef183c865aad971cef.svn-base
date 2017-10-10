<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:shiv Sharma 
 *Date of Creation 		:23 Jan 2009
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:Database
 *Modification 			:
 *Reason of Modification: 
 *Date of Modification  :
 *Modified By			:
 *Revision History		:
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8"%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<title>WELCOME TO STARS : Lerms  Details </title>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
function CheckDataSave()
{
	var a=document.frm.comments.value;
	if(a=="")
	{
		alert("Please Enter the Comments");
		document.frm.comments.focus();
		return false;
	}
	else
	{
		if(confirm('Are you Sure you want to post this comments!'))
			document.frm.submit();
		else
			return false;
	}
}
function CheckDataNext()
{
	document.frm.buttonData.value=1;
	document.frm.submit();
}

function CheckDataCriteria()
{
	window.location.href="sanctionCriteria.jsp";
}
function goback()
{
    history.go(-1);
}

function submitParent()
{
  window.opener.location = window.opener.location;
  window.close();
}

</script>
</head>
<%
// Variables declared and initialized

String strTravelType   =  "";
String strWhichPage    =  "";
String strTargetFrame  =  "";
String strTargetFlag   =  "";
strTravelType   =  request.getParameter("travel_type");
//System.out.println("Vijay.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+strTravelType);
strWhichPage    =  request.getParameter("whichPage"); 
//System.out.println("which page is=========="+strWhichPage);

if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

if(strWhichPage == null)
   strWhichPage = "#";

strTargetFlag    =  request.getParameter("targetFrame"); 
if(strTargetFlag !=null && strTargetFlag.equals("yes"))
{
     strTargetFrame="middle";  
}
else
   	strTargetFrame = "";


// Variables declared and initialized
Connection con	=	null;			    // Object for connection
Statement stmt	=	null;			   // Object for Statement
ResultSet rs	=	null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

String	sSqlStr                             =   ""; // For sql Statements
String strRequisitionId                		=	"";
strRequisitionId                        	=	request.getParameter("purchaseRequisitionId");
//System.out.println("--------------------testing testing --------------"+strRequisitionId);
int iCls = 0;
String strStyleCls                          =   "";
String	strNewReqNo		    				= 	"";
String	strName								=	"";
String	strAmount							=	"";
String	strCurrency							=	"";
String	strOriginatedBy		     			=	"";
String	strOriginatedOn			    		=	"";
String	strTravel_From						=	"";
String	strTravel_To						=	"";
String strGroupTravelFlag				="";

String  strTravelerName			=   "";
String	strPASSPORT_NO			=   "";
String	strIssuedate			=	"";
String  strCurrentAddress		=	""; 
String	StringstrDesgName		=   ""; 
String	strPlaceIssue           =   "";
String strDesgName				=  "";
String strReqNo					=  "";	
%>

</head>

<body>
<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><b>Liberalised Exchange Rate Management System (LERMS)  Details</b></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
        <td>
     <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<BR>
<table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

  
	 <td  colspan="10" class="formtr1">
	 <TABLE border="0" width="100%">
	 <TR class="formhead">
	 	<TD class="formtr1">To,</TD>
	 	<TD width="15%" class="formtr1"   >Date:</TD>
	 </TR>
	 </TABLE>
      

	       
	&nbsp;The Manager (F.E.D), <br>
     &nbsp;Motherson Air Travel Agencies Ltd, <br>
     &nbsp;Noida.
	 <br> 
	 <br>
	 <U><B>SUB:  RELEASE OF FOREIGN EXCHANGE UNDER BUSINESS TRIP</B></U><br>  <br>  
  We wish to draw Foreign Exchange under the new Liberalised Exchange Rate Management System (LERMS) for our personal as per the following details: <br></td>
 </tr>


 
 

<tr class="formhead">

	 <td  colspan="2" class="listdata">Lerms  Details</td>
 </tr>
         
<%		 
		sSqlStr="SELECT dbo.user_name(TTD.TRAVELLER_ID)as travelername , UMST.PASSPORT_NO, DBO.CONVERTDATEDMY1(UMST.DATE_ISSUE) as DATE_ISSUE, UMST.CURRENT_ADDRESS, M_DESIGNATION.DESIG_NAME,UMST.PLACE_ISSUE, TTD.TRAVEL_REQ_NO  FROM T_TRAVEL_DETAIL_INT TTD INNER JOIN M_USERINFO UMST ON TTD.TRAVELLER_ID = UMST.USERID INNER JOIN M_DESIGNATION ON UMST.DESIG_ID = M_DESIGNATION.DESIG_ID WHERE (TTD.TRAVEL_ID = "+strRequisitionId+")";
		//out.print(sSqlStr);
	 //stmt = con.createStatement(); 

      
	 rs = dbConBean.executeQuery(sSqlStr);
	 int intSno=1;
	 while(rs.next())
	 {
		
			   strTravelerName			=	rs.getString("travelername");
			   strPASSPORT_NO			=   rs.getString("PASSPORT_NO");
			   strIssuedate				=	rs.getString("DATE_ISSUE");
			   strCurrentAddress		=	rs.getString("CURRENT_ADDRESS"); 
			   strDesgName				=   rs.getString("DESIG_NAME"); 
			   strPlaceIssue			=   rs.getString("PLACE_ISSUE"); 
			   strReqNo		  	        =   rs.getString("TRAVEL_REQ_NO"); 


     }

rs.close(); 
 %>    

	     
<tr class="formtr1">



		  <td width="40%" class="listdata"><B>Requisition No. </B> </td><td   class="listdata"><%=strReqNo%></td>
	    </tr>
		<tr class="formtr1">
		  <td width="40%" class="listdata"><B>Traveler Name</B> </td><td   class="listdata"><%=strTravelerName%></td>
	    </tr>
		<tr class="formtr1">
		  <td width="40%" class="listdata"><B>Passport No.</B> </td><td   class="listdata"><%=strPASSPORT_NO%> </td>
	    </tr><tr class="formtr1">
		  <td width="40%" class="listdata"><B>Date of issue</B> </td><td   class="listdata"><%=strIssuedate%> </td>
	    </tr><tr class="formtr1">
		  <td width="40%" class="listdata"><B>Place of issue</B> </td><td   class="listdata"><%=strPlaceIssue%> </td>
	    </tr>
		<tr class="formtr1">
		  <td width="20%" class="listdata"><B>Address</B> </td><td   class="listdata"><%=strCurrentAddress%> </td>
	    </tr>
		<tr class="formtr1">
		  <td width="40%" class="listdata"><B>Designation </B></td><td   class="listdata"><%=strDesgName%> </td>
	    </tr><tr class="formtr1">
		  <td width="40%" class="listdata"><B>Nationality </B></td><td    class="listdata"> </td>
	    </tr>
		<tr class="formtr1">
		  <td width="40%" class="listdata"><B>Nature of Visit</B> </td><td   class="listdata"> </td>
	    </tr>
		<tr class="formtr1">
		  <td width="40%" class="listdata"><B>Exchange Required</B> </td><td   class="listdata"> </td>
	    </tr>
		<tr class="formtr1">
		  <td width="40%" class="listdata"><B>Duration/Country of Visit</B></td><td   class="listdata"> </td>
	    </tr>
		  <tr class="formhead">
<td colspan="2" class="listdata">  &nbsp;
</td>
</tr> 
	
			
		 
    <tr class="formtr1">   
			  <td width="10%" colspan ="2" class="listdata"> <B>Declaration : </B>  It is certified that the expenses for the above trip are being met by the company.We further undertake that the foreign exchange withdrawn will be used for the purpose stated above.We also declare that we have not submitted and do not intend to submit any application for the same trip to any other bank or authorized dealer. 
			  
			  
			  
 
<BR>
<BR>


Thanking You,<BR>
Yours truly,<BR>
For <BR>
<BR><BR>


Authorized Signatory

</td>



			  </tr>

        <tr class="formtr1">

		      
<td  colspan ="2" align="center">
<INPUT TYPE="button" value="<%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %>" class="formbutton" onClick="javascript:top.window.close();" > </td>
	   </tr>
</table>




  
</body>
</html>
