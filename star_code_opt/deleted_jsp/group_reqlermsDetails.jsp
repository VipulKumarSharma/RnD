<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv Sharma 
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
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<title>WELCOME TO STARS : Lerms  Details of Group/Guest Travel </title>
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
int iCls =1;
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
<table width="98%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<%

sSqlStr="SELECT  TRAVEL_REQ_NO FROM T_TRAVEL_DETAIL_INT WHERE  (TRAVEL_ID = "+strRequisitionId+") AND (STATUS_ID = 10)";
 
	 //stmt = con.createStatement(); 
 rs = dbConBean.executeQuery(sSqlStr);

	 while(rs.next())
	 {
		strReqNo=rs.getString(1);   
	 }


%>


<tr class="formhead"  colspan="8">
     
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
	 
	 <U><B>SUB:  RELEASE OF FOREIGN EXCHANGE UNDER BUSINESS TRIP</B></U><br> <br> 
  We wish to draw Foreign Exchange under the new Liberalised Exchange Rate Management System (LERMS) for our personal as per the following details: <br></td>
 </tr>


<tr class="formhead"  colspan="8">

	 <td  colspan="10" class="listdata">Lerms  Details for Group/Guest Requisiton No.  <%=strReqNo%></td>
 </tr>

 <tr class="formhead">
		  <td width="3%" class="listdata">S.No.</td> 
		  <td width="20%" class="listdata">Traveler Name </td>
		  <td width="13%" class="listdata">Passport No.  </td>
		  <td width="14%" class="listdata">Date of issue </td>
		  <td width="15%" class="listdata">Place of issue </td>
		  <td width="15%" class="listdata">Designation</td>
		  <td width="15%" class="listdata">Nationality </td>
		  <td width="20%" class="listdata">Nature of visit </td>
	      <td width="20%" class="listdata">Exchange Required </td>
		  <td width="20%" class="listdata">Duration/Country of visit</td>

</tr>

 <%		 
		sSqlStr="SELECT TGUD.FIRST_NAME + ' ' + TGUD.LAST_NAME AS travelername, TGUD.PASSPORT_NO, DBO.CONVERTDATEDMY1(TGUD.DATE_OF_ISSUE) as DATE_ISSUE, '-' AS CURRENT_ADDRESS,M_DESIGNATION.DESIG_NAME AS DESIG_NAME, TGUD.PLACE_OF_ISSUE AS PLACE_ISSUE FROM T_TRAVEL_DETAIL_INT TTD INNER JOIN T_GROUP_USERINFO TGUD ON TTD.TRAVEL_ID = TGUD.TRAVEL_ID INNER JOIN M_DESIGNATION ON TGUD.DESIG_ID = M_DESIGNATION.DESIG_ID WHERE (TTD.TRAVEL_ID = "+strRequisitionId+")";
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
			   //strReqNo		  	        =   rs.getString("TRAVEL_REQ_NO"); 

			   if (iCls%2 == 0) { 
	  	     strStyleCls="formtr2";
       } else { 
		strStyleCls="formtr1";
      } 

			   %>
			      <tr  valign="top" class="<%=strStyleCls%>"> 
				   <td width="3%" class="listdata"> <%=iCls%></td>
			     <td width="20%" class="listdata"><%=strTravelerName%></td>
				 <td width="13%" class="listdata"><%=strPASSPORT_NO%></td>
				  <td width="14%" class="listdata"><%=strIssuedate%></td>
				  <td width="15%" class="listdata"><%=strPlaceIssue%></td> 
				  <td width="15%" class="listdata"><%=strDesgName%> </td>
				  <td width="15%" class="listdata">   </td>
				  <td width="20%" class="listdata">   </td>
				  <td width="20%" class="listdata">   </td>
				    <td width="20%" class="listdata">   </td>
				 

				    
				  </tr>

			 <%
				 iCls++; 
     }

rs.close(); 
 %>    
    <tr class="formhead">
<td colspan="10" class="listdata">  &nbsp;
</td>
</tr>     
 
	 <tr class="formtr1">
<td colspan="10"> <BR>  <B>Declaration : </B>  It is certified that the expenses for the above trip are being met by the company.We further undertake that the foreign exchange withdrawn will be used for the purpose stated above.We also declare that we have not submitted and do not intend to submit any application for the same trip to any other bank or authorized dealer..


<BR>
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
<td colspan="10" align="center"> <INPUT TYPE="button" value="<%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %>" class="formbutton" onClick="javascript:top.window.close();" >
</td>
</tr>


</table>
 



  
</body>
</html>
