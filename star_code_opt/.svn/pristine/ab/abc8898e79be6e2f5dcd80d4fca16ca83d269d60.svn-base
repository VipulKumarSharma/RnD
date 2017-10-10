<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp is used to show provide more details about the originator
 *Modification 			: 
 *Reason of Modification: Requirement 
 *Date of Modification  :04/04/2007
 *Modified by			:Vijay Singh
 *Revision History		:
 *Editor				:Editplus
*******************************************************/
%>

<%@ include file="importStatement.jsp" %>

<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript1.2" src="ScriptLibrary/main.js?buildstamp=2_0_0"type="text/javascript"></SCRIPT>

<script type="text/javascript" language="JavaScript1.2" src="scripts/div.js?buildstamp=2_0_0"></script> <!--Vijay 04/04/2007-->
</head>


 <body onLoad=""><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script> 
<%
// Variables declared and initialized
Connection con				=		null;			    // Object for connection
Statement stmt				=		null;			   // Object for Statement
ResultSet rs				=		null;			  // Object for ResultSet
CallableStatement cstmt		=		null;			// Object for Callable Statement
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	 sSqlStr						=	""; // For sql Statements
String strTravelId			=	""; // Object to store Sanction ID
strTravelId					=	request.getParameter("strTravelId");
String ReqTyp				=	request.getParameter("ReqTyp");
//String ToOriginator="";
if(ReqTyp.equalsIgnoreCase("D"))
{
ReqTyp	=	"Domestic Travel";
}
else
{
ReqTyp	=	"International Travel";
}
String strToName					=	"";
String strToEmail					=	"";

// Code to show - (-) when form is loaded initially

if(ReqTyp.equals("International Travel"))
{
	sSqlStr = "select dbo.user_name(userid),dbo.USEREMAIL(userid) from m_userinfo where userid = (select c_userid from t_travel_mst where travel_req_id = (select TRAVEL_REQ_ID from t_travel_detail_int where TRAVEL_ID="+ strTravelId +"))"; 
}
if(ReqTyp.equals("Domestic Travel"))
{
	sSqlStr = "select dbo.user_name(userid),dbo.USEREMAIL(userid) from m_userinfo where userid = (select c_userid from t_travel_mst where travel_req_id = (select TRAVEL_REQ_ID from t_travel_detail_DOM where TRAVEL_ID="+ strTravelId +"))"; 
}

stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
if(rs.next())
{
		strToName	 =	rs.getString(1);
		strToEmail	 =	rs.getString(2);
		//System.out.println("strToEmail in request more info :; "+strToEmail + "Name is :: "+strToName);

}

rs.close();
stmt.close();

// Code ends

%>

<SCRIPT LANGUAGE="JavaScript">

function submitConfirm()
{

 //---------add for email check  on  3/9/2007 by shiv----

 var com1=document.frm.toMail.value;

if(com1=='')
{
alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseaddtheemail",strsesLanguage)%>');
document.frm.toMail.focus();
return false;
}

//----add for email check  3/9/2007  end----------- 

var com=document.frm.COMMENTS.value;
if(com=='')
{
alert('<%=dbLabelBean.getLabel("alert.approverequest.yourcomments",strsesLanguage)%>');
document.frm.COMMENTS.focus();
return false;
}
if(confirm('<%=dbLabelBean.getLabel("label.requestdetails.mailwillbesendtoinformselectedpersons",strsesLanguage)%>'))
	   return true;
	else
	return false;
	
}

/*function splitString () 
{
		var stringToSplit=new String();
		stringToSplit=document.frm.toMail.value;
		alert(stringToSplit);
		var samicolan=";";
		
		var arrayOfStrings= stringToSplit.split(samicolan);
		
	  
		document.write ('<P>The original string is: "' + stringToSplit + '"');
		document.write ('<BR>The separator is: ;');
		document.write ("<BR>The array has " + arrayOfStrings.length + " elements: ");
		for (var i=0; i < arrayOfStrings.length; i++) 
		{      
			document.write (arrayOfStrings[i] + "/////");  
		}
}*/




function Open_Mail()
{		
	var toAppend		= document.frm.toMail.value;		
	var toappendName	= document.frm.mailToName.value;
	
	
MM_openBrWindow('mailUserPicker.jsp?id=1&purchaseRequisitionId=<%=strTravelId%>&Travel_Type=<%=ReqTyp%>&toAppend='+toAppend +'&toappendName='+toappendName,'PICKAPPROVERS','scrollbars=yes,resizable=yes,width=410,height=150');

	
}


function Open_Approvers()
{	
	var toAppend = document.frm.toMail.value;
	var toappendName = document.frm.mailToName.value;


MM_openBrWindow('mailUserPicker.jsp?id=2&purchaseRequisitionId=<%=strTravelId%>&Travel_Type=<%=ReqTyp%>&toAppend='+toAppend+'&toappendName='+toappendName,'PICKAPPROVERS','scrollbars=yes,resizable=yes,width=410,height=150');	
		
}
function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='COMMENTS')
	{
		obj = document.frm.COMMENTS;
		upToTwoHyphen(obj);
	}
	charactercheck(obj,str);
    limitlength(obj, length);
	spaceChecking(obj);
  }	
</SCRIPT>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<form method=post action="reqRequestMoreInfoSubmit.jsp" name=frm target=_parent>
	<input type=hidden name="purchaseId" value="<%=strTravelId%>">
	<input type=hidden name="mailTo" value="<%=strToEmail%>">
	<input type=hidden name="mailToName" value="<%=strToName%>">
	<input type=hidden name="mailFrom" value="<%=sUserFirstName%> <%=sUserLastName%>">
	<input type=hidden name="ReqTyp" value="<%=ReqTyp%>">
	<tr align="left" valign="top" > 
	<td class="formhead" valign="middle" align="center" colspan=3><%=dbLabelBean.getLabel("label.requestdetails.requestmoreinformation",strsesLanguage) %></td>
	</tr>
	<tr align="left" valign="top" > 
	<td class="formtr2"  valign="top" align="left" width="60%">
	<!--Vijay 04/04/2007-->
	<div id="sub5" style="display:none">
	<A HREF="#" onClick=" return Open_Mail();" ><%=dbLabelBean.getLabel("label.requestdetails.tooriginator",strsesLanguage) %></A></div><!--END -->
	<A HREF="#" onClick="return Open_Approvers();" >&nbsp;<%=dbLabelBean.getLabel("label.requestdetails.approvers",strsesLanguage) %></A> 
	</td>
	<td class="formtr1" align="left" width="40%">
	
	<textarea name=toMail cols="32" rows="4" size=34 class="textBoxCss" readonly ></textarea></TD>
	<script language="javascript">
				document.frm.toMail.value ="<%= strToEmail.trim() %>";
	</script>
	</tr>
	<tr align="left" valign="top" > 
	<td class="formtr2"  valign="top" align="left" width="60%"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %>
	</td>
	<td class="formtr1" align="left" width="40%"><%=sUserFirstName%> <%=sUserLastName%></td>
	</tr>
	<tr align="left" valign="top" > 
	<td class="formtr2"  valign="top" align="left" width="30%"><%=dbLabelBean.getLabel("label.requestdetails.requestdetails",strsesLanguage) %>
	</td>
	<td class="formtr1" align="left" width="60%"><textarea cols=50 class="textBoxCss" rows=8 NAME="COMMENTS" onKeyUp="test1('COMMENTS',500,'txt');"></textarea></td>
	</tr>
	<tr align="left" valign="top" class="formbottom"> 
	<td class="frmlabelswhite" valign="middle" align="center" colspan=3> <input class="formbutton" type=reset name=sub value=<%=dbLabelBean.getLabel("label.requestdetails.clear",strsesLanguage) %> onClick="displaySubs('sub5')"> <input class="formbutton" type=Submit name=sub value=<%=dbLabelBean.getLabel("button.approverequest.submit",strsesLanguage) %> onClick="return  submitConfirm();"> <input class="formbutton" type=button name=sub value=<%=dbLabelBean.getLabel("button.approverequest.closewindow",strsesLanguage) %> onClick="window.close();">
	</tr>
		<tr align="left" valign="top"> 
	<td class="frmlabelswhite" valign="middle" align="center" colspan=3><font color=red> <%=dbLabelBean.getLabel("label.requestdetails.amailwillbesenttoselectedpersonsbydefaulttooriginator",strsesLanguage) %></font></td>
	</tr>
</form>
</table>
</body>
</html>

