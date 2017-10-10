<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY		:	SACHIN GUPTA
*Date			:   27/09/2006
*Description	:	first Screen for APPROVAL
*Modified By	:	****************
*Project		: 	STAR
**********************************************************/
%>


<html>
<head>
<%@ include file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<Script>
function isLegal(txt) {
var invalids = "~"
for(i=0; i<invalids.length; i++) {
if(txt.indexOf(invalids.charAt(i)) >= 0 ) {
return false;
}
        }
return true;
}
</Script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function typeData()
{
document.frm.COMMENTS.value="Received by <%=sUserFirstName%> <%=sUserLastName%>"
}

function typeData1()
{
document.frm.COMMENTS.value="Confirmed by <%=sUserFirstName%> <%=sUserLastName%>"
}

function typeData2()
{
document.frm.COMMENTS.value="Rejected by <%=sUserFirstName%> <%=sUserLastName%>"
}

function submitConfirm()
{
var com=document.frm.COMMENTS.value;
if(isLegal(com)) {
}

else {

alert("Invalid Character, Please avoid using non alphabetic text such as :-\n ~'\n in the comments box");
return false;

}


var com=document.frm.COMMENTS.value;
if(com=='')
{
alert("Please Enter Your Comments");
document.frm.COMMENTS.focus();
return false;
}
else
{
if(confirm('On submitting you agree to the status of this Requisition.\nMailers will be generated to inform the Approvers and the Originator about the present status of the Requisition.\nOnce submitted the Requisition Status cannot be reversed !'))
	return true;
else
	return false;
	}
}


//-->
</SCRIPT>
<script>
function MM_openBrWindow(theURL,winName,features) 
{ 
window.open(theURL,winName,features);
}
 function CheckData()
 {
	 if(document.frm1.TRANSCOMMENTS.value=="")
	 {
		 alert("Please enter comments");		
		 document.frm1.TRANSCOMMENTS.focus();
		 return false;
	 }
	 else if(document.frm1.delName.value=="")
	 {
		 alert("Please select the delegate");		 
		 document.frm1.delName.focus();
		 return false;
	 }
	 else
	{
		if(confirm('On submitting you agree to the status of this Requisition.\nThe requisition will be transfered to selected delegate and will be available to you after his approval.\nOnce submitted the Requisition Status cannot be reversed !'))
		return true;
		else
		return false;
	}
}
</script>

</head>
 <body onLoad="typeData1();"> 

<%
String strTravelId		= request.getParameter("purchaseRequisitionId");
String strTravellerId	= request.getParameter("traveller_Id");
String strTravelType    = request.getParameter("travel_type");

// Variables declared and initialized
Connection con				=		null;			    // Object for connection
Statement stmt				=		null;			   // Object for Statement
ResultSet rs				=		null;			  // Object for ResultSet

//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	 sSqlStr	=	""; // For sql Statements
String strTransFlag				=	"";
String strDisabled				=	"";
String strApproveLabel			=	"Receive";


sSqlStr="SELECT  DISTINCT ISNULL(RTRIM(TRANSFLAG),' ') FROM T_APPROVERS WHERE ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE APPROVE_STATUS=0 AND STATUS_ID=10 AND TRAVEL_TYPE='"+strTravelType+"' AND TRAVEL_ID='"+strTravelId+"' AND TRAVELLER_ID='"+strTravellerId+"') AND TRAVEL_TYPE='"+strTravelType+"'AND TRAVEL_ID='"+strTravelId+"'AND TRAVELLER_ID='"+strTravellerId+"'";

	stmt = con.createStatement(); 
	rs = stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
			strTransFlag	 =	rs.getString(1);
	}
	rs.close();
	stmt.close();

	if(strTransFlag.equals("Y"))
	{
		strDisabled="disabled";
		strApproveLabel="Return this requisition to the next Approver<br>who forwarded it to you";
	}

%>
 <!--For Section 1 First half--> 
<table width="90%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <form method=post action="T_ConfirmRequisitions_MATA_Post.jsp" name=frm target=_parent>
  <input type=hidden name="purchaseRequisitionId" value="<%=strTravelId%>">
  <input type=hidden name="traveller_Id" value="<%=strTravellerId%>">
  <input type=hidden name="travel_type" value="<%=strTravelType%>">
  <tr align="left" valign="top" > 
    <td class="formtr2"  valign="top" align="left" width="30%"><!--<input type=radio name=rad value="RECEIVED"  onClick="typeData();"> <%=strApproveLabel%> 
	--></td>
    <td class="formtr1" align="center" width="40%"><textarea cols=53 class="textBoxCss" rows=3 NAME=COMMENTS></textarea></td>  
	<td class="formtr2" align="left" width="30%"> 
<%
	if(strTransFlag.equals("Y"))
	{
	}
	else
	{
%>
	 <input type=radio name=rad value="CONFIRM" checked onClick="typeData1();" <%=strDisabled%>> Confirm   
<%
	}
%>
	 </td>
  </tr>

    <tr align="left" valign="top" colorPink> 
    <td class="formbottom" valign="middle" align="center" colspan=3>
	<input class="formbutton" type=button name=close value="Close Window" onClick="javascript:top.window.close();">
	<input class="formbutton" type=button name=sub value="Request More Info" onClick="MM_openBrWindow('reqRequestMoreInfo.jsp?strTravelId=<%=strTravelId%>&ReqTyp=<%=strTravelType%>','REQUESTMOREINFO','scrollbars=yes,resizable=yes,width=775,height=250')">
	<input class="formbutton" type=Submit name=sub value="Submit" onClick="return  submitConfirm();"></td>
	</tr>
</form>
</table>
<br>
