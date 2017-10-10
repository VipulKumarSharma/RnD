<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:30 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for approve the Travel Requisition in the STAR Database
 *Modification 			: Add Cancel link .
                        :1 Code Is Changed  For Not Showing Recieved Option For Mata Person  As They Don't  Wants To See This 
                         2 code Is Hidding Just Changing Query   Status As( Ts.travel_status_id=80) So This Will Not Display On The Page    
                      	 3 Added new flage for vaman sehgal to view him requisition on 04-11-2008 by shiv sharma 
                      	 4  added code for showing travel class of journey on 29 march 2010 by shiv sharma 
*Reason of Modification : change suggested by MATA
*Date of Modification   :07 Nov 2006 
*Modified By	        :SACHIN GUPTA
 *Editor				:Editplus
 
*Modified By			:Manoj Chand
*Date of Modification	:10 feb 2011
*Modification			:increases the size of search page.

*Modified By			:Manoj Chand
*Date of Modification	:12 May 2011
*Modification			:Image changed to Handover Requisitions

*Modified By			:Manoj Chand
*Date of Modification	:07 Sept 2011
*Modification			:add function childwindowSubmit() to refresh this page after closing attachment screen.

*Modified By			:Pankaj Dubey
*Date of Modification	:26 Dec 2011
*Modification			:to show hyperlink on against group travel requests to show travellers.

Modified By			    :Manoj Chand
Date of Modification	:14 Feb 2012	
Modification			:Disable checkboxes for those domestic type of request for which local price is entered.

*Modified By			:Manoj Chand
*Date of Modification	:09 Apr 2012	
*Modification			:Disable Approve button after one click

*Modified By			:Manoj Chand
*Date of Modification	:02 May 2012	
*Modification			:Showing domestic requests for reviewers to either view or take action

*Modified by			:Manoj Chand
*Date of Modification	:24 May 2012
*Modification			:Multilingual functionality added

*Modified by			:Manoj Chand
*Date of Modification	:25 Sept 2012
*Modification			:showing page refresh time at the bottom of the page with approve button.

*Modified by			:Manoj Chand
*Date of Modification	:10 Oct 2012
*Modification			:resolve issue coming on chrome and safari. Mr. vaaman is not able to scroll or check the checkbox

*Modified by			:Manoj Chand
*Date of Modification	:01 Feb 2013
*Modification			:showing requested value in comma separated way if multiple currency exist in the request.

*Modified By	        :MANOJ CHAND
*Date of Modification   :07 Feb 2013
*Description			:IE Compatibility Issue related to page not refreshing after action taken in inner page.

*Modified By	        :MANOJ CHAND
*Date of Modification   :21 May 2013
*Description			:Display Return date column in approval screen.
 *******************************************************/
%>

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8" %>
<HTML>
<HEAD>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
// Variables declared and initialized

String strTravelType      =  "";
String strTravelTypeFlag  =  "";
strTravelType   =  request.getParameter("travel_type"); 

if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelTypeFlag = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelTypeFlag = "D";
}

ResultSet rs,rs1	=	null;			  // Object for ResultSet

int intSerialNo				=  0;
String	strSql				=  ""; // For sql Statements
String	strTravelId	    	=  "";
String	strTravelRequestNo 	=  "";
String	strTravellerId   	=  "";
String	strTraveller	    =  "";
String	strOriginatorName	=  "";
String	strOriginatedDate 	=  "";
String	strNextApprover 	=  "";

String  strFrom             =  "";
String  strTo               =  "";
String  strTravelDate       =  "";
String  strTravelAmount     =  "";  
String  strTravelCurrency   =  "";  
String strGroupTravelFlag   ="";
String strTravelAgencyTypeId   ="";


String	strSiteName			=  "";
String	strDivName			=  "";
int iCls				    =  0;
String strStyleCls			=  "";
String strTitle				=  "";
String strShowBut="yes";
int expTrvReqWeeks = 0;
%>

<script language=JavaScript >
//added by manoj chand on 09 April 2012 to show processing image.
function findPos(obj) {
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft;
		curtop = obj.offsetTop;
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		}
	}
	return curtop;
}

function openWaitingProcess()
{
		var dv = document.getElementById("waitingData");
		var buttonobj = document.getElementById("CheckAll");
		/*if(dv != null)
		{
			var xpos = screen.availHeight/2+90;
			var ypos = findPos(buttonobj);
			dv.style.display="block";       		
			dv.style.left=(xpos+10)+"px";
			dv.style.top=(ypos-180)+"px";
			document.getElementById("waitingData").style.visibility="";
		}*/
		dv.style.zIndex=1;
		dv.style.visibility='visible';
}

function closeDivRequest()
{
	document.getElementById("waitingData").style.visibility="hidden";	
}
 //end here


function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}
function check()
{
	openWaitingProcess();
	for (i = 0; i < document.frm.length; i++)
	{
	if ( document.frm[i].checked == true)
		return true;
	}
	closeDivRequest();
alert('<%=dbLabelBean.getLabel("alert.approverequest.errormessage",strsesLanguage)%>');
enb=true;
enable();
return false; 
}

//added by manoj on 07 sept 2011 to refresh this page on closing attachment window.
function childwindowSubmit(){
	document.frm.action='T_approveTravelRequisitions_D.jsp';
	document.frm.submit();
}

//added by manoj chand on 05 feb 2013 to refresh this window
function refreshParent(suburl){
	document.frm.action=suburl;
	document.frm.submit();
}

function defaultApproverListDOM(strTravelId , strTravelRequestNo )
{
	var url = 'T_ShowTravellerFromGroupReqs.jsp?traveltype=DOM&strTravelId='+strTravelId+'&strTravelRequestNo='+strTravelRequestNo;
	window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=400,height=350');
}

//added by manoj chand on 09 april 2012 to disable submit button after one click
var enb=false;
var subd=false;   
var domSub = false;

function disable(){		//disable function 
	if(subd==true){
		document.getElementById("sub").disabled=true;	
	}
}
	
function do_disable()	 
{
	subd=true;
	disable();
}

function enable()		//enable function 
{
	if(enb==true){
		document.getElementById("sub").disabled=false;
	}
}
//end here

//GET CLIENT MACHINE DATE AND TIME done by manoj chand on 28 sept 2012
function getClientDateTime(){
var d=new Date();
//document.write(d);
var m_names = new Array("Jan", "Feb", "Mar","Apr", "May", "Jun", "Jul", "Aug", "Sep","Oct", "Nov", "Dec");
var d = new Date();
var curr_date = d.getDate();
var curr_month = d.getMonth();
var curr_year = d.getFullYear();
var curr_hours=d.getHours();
var curr_mins=d.getMinutes();
if(curr_hours<10)
{
	curr_hours = "0"+curr_hours;
}
if(curr_mins<10)
{
	curr_mins = "0"+curr_mins;
}
document.getElementById("spn").innerHTML=curr_date + " " + m_names[curr_month] + " " + curr_year +" "+curr_hours+":"+curr_mins;
}
</script>
</HEAD>

<body style="overflow-y:hidden; " onfocus="MM_winParentDisable();" onclick="MM_winParentDisable();"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
	<% if(ssflage.equals("3")){%>
      <li class="pageHead" id="dom-req-header"> <%=dbLabelBean.getLabel("label.approverequest.domesticeuropetravelrequest",strsesLanguage)%></li>
    <%}else{ %>
    <li class="pageHead" id="dom-req-header"> <%=dbLabelBean.getLabel("label.approverequest.domestictravelrequest",strsesLanguage)%></li>
    <%} %> 
     
    </ul></td>
     <td align="right"valign="bottom" class="bodyline-top">
	   <table align="right" border="0" cellspacing="0" cellpadding="0">
    <tr align="right" valign="bottom"> 


	<td>
<ul id="list-nav">
<%
	if(SuserRole!=null &&  !SuserRole.equals("MATA") ){
	%>
<li><a href="#" onClick="MM_openBrWindow('T_MyReturns_D.jsp?flag=1&travel_type=D','REQUISITIONSRETURNED','scrollbars=yes,resizable=yes,width=900,height=500');"><%=dbLabelBean.getLabel("button.approverequest.requisitionsreturned",strsesLanguage) %></a></li>
<%}%>
<li><a href="#" onClick="MM_openBrWindow('MyApproved_D.jsp?flag=1&travel_type=D','REQUISITIONSAPPROVED','scrollbars=yes,resizable=yes,width=900,height=500');"><%=dbLabelBean.getLabel("button.approverequest.requisitionsapproved",strsesLanguage) %></a></li>
<li><a href="T_transferMain_D.jsp?travel_type=D" ><%=dbLabelBean.getLabel("button.approverequest.handoverrequisitions",strsesLanguage) %></a></li>
<li><a href="#" onClick="MM_openBrWindow('T_searchTravelRequisitions.jsp?travel_type=D','SEARCH','scrollbars=yes,resizable=yes,top=0,left=0,width=1000,height=565');"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage) %></a></li>
<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
</ul>
</td>
   </tr>
	</table>
    </td>
  </tr>
</table>
<div id="dv" style="width:100%; left:0px; height:83%; position: absolute; overflow: auto;" >
<table width="100%" align="center" border="0" cellpadding="4" cellspacing="1" class="formborder">
    <form method=post name=frm action="T_approveTravelRequisitions_Post.jsp" onsubmit=" do_disable(); return check(0);">

  <tr class="formhead"> 
	<td class="listhead" width="1%" align="center"><img src="images/tick2.gif?buildstamp=2_0_0" border=0></td>	
	<td class="listhead" width="3%" align="center">#</td>	
 	<td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.approverequest.viewandapprove",strsesLanguage)%></td>
    <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>

<%-- 	<td class="listhead" width="11%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)%></td>  --%>
<%-- 	<td class="listhead" width="11%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%></td> --%>
	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.global.itineraryinfo",strsesLanguage)%></td>

	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%></td><!-- 26/02/2007 -->
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.createrequest.finalreturndate",strsesLanguage)%></td>
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.travelclass",strsesLanguage)%> </td><!--  added on 29 march 2010 by shiv sharma  -->
	<td class="listhead" width="16%" align="center"><%=dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)%></td>
	<td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverequest.nextwith",strsesLanguage)%></td>	
	<td class="listhead" width="15%" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>
<%if(SuserRole!=null && SuserRole.equals("MATA")) {%>
  <tr>
    <td colspan="15" class="formhead" ><%=dbLabelBean.getLabel("label.approverequest.newrequest",strsesLanguage)%></td>
  </tr>
<%}%>
     

<%

strSql  = "SELECT CAST(FUNCTION_VALUE AS INT) FROM functional_ctl WHERE FUNCTION_KEY='@ExpTrvReqCutOffWeekForApproval'";
rs = dbConBean.executeQuery(strSql);
if(rs.next())
{
	expTrvReqWeeks = rs.getInt(1);
}
rs.close();


String strItems        =  "";
String strNewReqNo     =  "";
String strApproverRole =  "";
String strOrderID	   =  "";	
String strViewflage	   =  "";	
String  strPAPflag	 ="";
//Query for Finding the role of approver
strSql  = "SELECT DISTINCT TA.ROLE,order_id FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND TS.TRAVEL_STATUS_ID=2   AND TA.TRAVEL_TYPE='D'  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID  AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";

rs = dbConBean.executeQuery(strSql);         //get the result set
if(rs.next())
{
    strApproverRole = rs.getString(1);
    strOrderID		= rs.getString(2);	
}
rs.close();




	/*strSql="SELECT DISTINCT  TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER, "+ 
	      " ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY, "+ 
	      " ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'D', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'D') "+
	      " AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'D') AS COMMENT, td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG,'Y' AS FLAG "+
	      " FROM         T_APPROVERS TA, T_TRAVEL_STATUS TS, T_TRAVEL_DETAIL_DOM TD "+
		  " WHERE     TA.TRAVEL_ID = TS .TRAVEL_ID AND TD.TRAVEL_ID = TS .TRAVEL_ID AND TS .TRAVEL_STATUS_ID = 2 AND TS .TRAVEL_TYPE = 'D' AND "+ 
	      " TA.APPROVE_STATUS = 0 AND TA.APPROVER_ID ="+Suser_id+" AND TA.TRAVEL_TYPE = 'D' AND ORDER_ID = (SELECT   MIN(ORDER_ID) "+
	      " FROM  T_APPROVERS   WHERE  TRAVEL_ID = TS .TRAVEL_ID AND TRAVEL_TYPE = 'D' AND APPROVE_STATUS = 0 AND STATUS_ID = 10) "+
		  "	UNION 	SELECT DISTINCT   TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER, "+ 
	      " ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY, "+ 
	      " ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'D', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'D')"+
	      " AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'D') AS COMMENT, td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG,'N' AS FLAG "+
	      " FROM         T_APPROVERS TA, T_TRAVEL_STATUS TS, T_TRAVEL_DETAIL_DOM TD WHERE   TA.TRAVEL_ID = TS .TRAVEL_ID AND TD.TRAVEL_ID = TS .TRAVEL_ID "+ 
	      " AND TS .TRAVEL_STATUS_ID = 2 AND TS .TRAVEL_TYPE = 'D' AND  TA.APPROVE_STATUS = 0 AND TA.APPROVER_ID "+
	      " in( select pendingwithuser from PAGE_ACCESS_PERMISSION where viewtouser ="+Suser_id+") AND TA.TRAVEL_TYPE = 'D' "+ 
   	      " AND ORDER_ID =(SELECT     MIN(ORDER_ID) FROM  T_APPROVERS   WHERE    TRAVEL_ID = TS .TRAVEL_ID AND TRAVEL_TYPE = 'D' AND " + 
   	      " APPROVE_STATUS = 0 AND STATUS_ID = 10) ";*/


//change in query done by manoj chand on 02 may 2012 to implement special approval	   
strSql="SELECT DISTINCT  TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO,"+
	    " ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER,"+  
	    " ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE,"+
	    " ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY,"+ 
	    " ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'D', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH,"+ 
	    " DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'D')  AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'D') AS COMMENT,"+
	    " td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id,'Y' AS FLAG ,TA.PAP_FLAG, "+  
	    " RTRIM(LTRIM(DBO.SITENAME(TD.SITE_ID)))+CASE WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
	    " LIKE '%@MINDID.COM%' THEN '-Design' WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
	    " LIKE '%@MIND%' THEN '-SW' else '' end AS TRAVELSITE FROM   T_APPROVERS TA INNER JOIN"+
        " T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID INNER JOIN"+
        " T_TRAVEL_DETAIL_DOM TD  on TD.TRAVEL_ID = TS .TRAVEL_ID"+ 
		" WHERE TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND TS.TRAVEL_STATUS_ID = 2 AND TS.TRAVEL_TYPE = 'D' AND  TA.APPROVE_STATUS = 0 AND TA.APPROVER_ID ="+Suser_id+ 
		" AND TA.TRAVEL_TYPE = 'D' AND ORDER_ID = (SELECT   MIN(ORDER_ID)  FROM  T_APPROVERS"+   
		" WHERE  TRAVEL_ID = TS .TRAVEL_ID AND TRAVEL_TYPE = 'D' AND APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)"+   
		" AND ((TA.PAP_APPROVER = 0) OR (TA.PAP_APPROVER <> 0 AND TA.PAP_FLAG <> '' ))"+
		" union "+
		" SELECT DISTINCT   TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO,"+ 
		" ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER,"+  
		" ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE,"+
		" ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY,"+ 
		" ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'D', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH,"+
		" DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'D') AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'D') AS COMMENT,"+
		" td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id, case when access_level='full' then 'S' else 'N' end AS FLAG,TA.PAP_FLAG, "+  
		" RTRIM(LTRIM(DBO.SITENAME(TD.SITE_ID)))+CASE WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
		" LIKE '%@MINDID.COM%' THEN '-Design' WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
		" LIKE '%@MIND%' THEN '-SW' else '' end AS TRAVELSITE FROM  T_APPROVERS TA inner join"+
		" T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID inner join"+
		" T_TRAVEL_DETAIL_DOM TD on TD.TRAVEL_ID = TS .TRAVEL_ID inner join"+ 
		" PAGE_ACCESS_PERMISSION PAP on PAP.pendingwithuser =  case when TA.ORIGINAL_APPROVER =0 then TA.APPROVER_ID else TA.ORIGINAL_APPROVER end "+
		" WHERE	TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND TS.TRAVEL_STATUS_ID = 2"+ 
		" AND TS.TRAVEL_TYPE = 'D'"+ 
		" AND TA.APPROVE_STATUS = 0"+ 
		" AND PAP.STATUS =10"+
		" AND TA.PAP_FLAG ='' AND	(TA.PAP_APPROVER   ="+Suser_id+" or PAP.viewtouser="+Suser_id+")"+ 
		" AND TA.TRAVEL_TYPE = 'D'"+  
		" AND ORDER_ID =(SELECT     MIN(ORDER_ID) FROM  T_APPROVERS  WHERE    TRAVEL_ID = TS .TRAVEL_ID"+
		" AND TRAVEL_TYPE = 'D' AND  APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";	

//System.out.println("strSql====D==>>>>>"+strSql);

String strColor="";
 
rs = dbConBean.executeQuery(strSql);
String strFinalApprovalStatus	="";
String strAttachment			="0";
String strComment				="0";
String strDetailPageUrl 		="";
String strCheckBoxDisabled 		="";	
String strTravel_classes		="";
String strTkProviderFlag    	="";  
String strCreator		=		"";
String strNoRecFoundFlag 	= "no";

while(rs.next())
{
	strNoRecFoundFlag       =   "yes";
	strTravelId     		=	rs.getString(1);
	strTravellerId          =	rs.getString(2);
	strTravelRequestNo		=	rs.getString(3);
	strTraveller        	= 	rs.getString(4);	
	strOriginatorName		=	rs.getString(5);
	strOriginatedDate		=	rs.getString(6);	
	strNextApprover 		=	rs.getString(7);	
	strAttachment			=	rs.getString(8);
	strComment				=	rs.getString(9);


	strGroupTravelFlag      =   rs.getString("GROUP_TRAVEL_FLAG"); 
	strTravelAgencyTypeId	=	rs.getString("travel_agency_id");
	strSiteName 			=	rs.getString("TRAVELSITE");

   //  Added by shiv for showing Group Travel_DOM  in case of group travel inspite of traveller Name on18-Jun-08;  
 
if(strGroupTravelFlag==null) 
		{
	strGroupTravelFlag="N";
 	}
          
	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
		{
		 
		strTraveller="Group/Guest Travel ";  
		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
			strTraveller ="Guest Travel";
		}

	}
	else
		{
			///
	}
     
	//query modified by manoj chand on 14 feb 2012 to get tk_provider_flag
    //strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'D') as travel_class,c_userid,tk_provider_flag FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;
	
    strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure, [dbo].[FN_GetJourneyDetailsDOM]("+strTravelId+") AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'D') as travel_class,c_userid,tk_provider_flag FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;
    
  	//System.out.println("strSql====FTES==>>>>>"+strSql);
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString("Expenditure");
		//strTravelCurrency   =   rs1.getString(3);
		strFrom             =   rs1.getString("TRAVEL_FROM");
		strTo               =   rs1.getString("TRAVEL_TO");	
		strTravel_classes   =    rs1.getString("travel_class");
		strCreator			=	rs1.getString("c_userid");
		strTkProviderFlag   =    rs1.getString("tk_provider_flag");
		if(strTravelAmount != null && strTravelAmount.equals("0"))
	    { 
	    	strTravelAmount = "-";
	    }	



		
	}
	rs1.close();


	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0>";
	}

		if(strComment.equals("0"))
	{
		strComment="";
	}
	else
	{
		strComment="<img src=images/group1.gif border=0>";
	}
    
	//Added new flage for vaman sehgal to view him requisition on 04-11-2008  by shiv sharma  	
	strViewflage       =   rs.getString("FLAG");
	strPAPflag         =   rs.getString("PAP_FLAG");
%>

<%
	if(SuserRole!=null && SuserRole.equals("MATA"))
	{
	  strColor                =   "red";
	}	

	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
    iCls++;
	
  //added by manoj chand to show return date on 21 May 2013
    String strReturnDate="";
    strSql =  "SELECT ISNULL(DBO.CONVERTDATEDMY1(trjdi.TRAVEL_DATE),'-') from dbo.T_RET_JOURNEY_DETAILS_DOM trjdi WHERE trjdi.TRAVEL_ID="+strTravelId;
    rs1=null;
    rs1 = dbConBean1.executeQuery(strSql);
    if(rs1.next()){
    	strReturnDate = rs1.getString(1);
    }
    if(strReturnDate.equals(""))
    	strReturnDate="-";
    rs1.close();  
    
%>

  <tr VALIGN="TOP" class="<%=strStyleCls%> dom-req-rows"> 
   <td width="3%" align="Left" bgColor="<%=strColor%>">
   <% //Added new Code  for vaman sehgal to view him requisition on 04-11-2008  by shiv sharma
    if (strViewflage.equals("N")){ 
   	 	strCheckBoxDisabled="disabled";
      }
   else{
	   strCheckBoxDisabled="enabled";
   } 
   if(strTkProviderFlag.trim().equalsIgnoreCase("n")  && (strCreator.trim().equalsIgnoreCase(Suser_id) || SuserRole.equalsIgnoreCase("MATA"))){
 	  strCheckBoxDisabled="disabled";
   }
   %>
   <input class="<%=strStyleCls%>" type=checkbox name="chk<%=intSerialNo++%>" value="<%=strTravelId%>;<%=strTravellerId%>;D"  <%=strCheckBoxDisabled%>></td>
    <td class="listhead" width="3%" align="Left"><%=intSerialNo%>
    <% if (strViewflage.equals("Y")){ %>
    <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strComment%></a> <a href="#" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a> </td>	
     <%}%>
<%  //Added new Code  for vaman sehgal to view him requisition on 04-11-2008  by shiv sharma
if(strViewflage.equals("Y")){
    if(SuserRole!=null && SuserRole.equals("MATA")) 
    {
	//T_TravelRequisitionDetails_D.jsp
%>
	  <td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('T_reqFrame_Receive_MATA.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=650')"><%=strTravelRequestNo%></a> 
	  </td>
<%  }
	else
	{
%>	
	<td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a>
		<%if(strPAPflag.equals("P") || strPAPflag.equals("A")){ %>
		<br><a href="#" onClick="MM_openBrWindow('T_reviewerComments.jsp?travelRequisitionId=<%=strTravelId%>&approverId=<%=strTravellerId%>&reqNo=<%=strTravelRequestNo%>&papFlag=<%=strPAPflag %>','SEARCH','scrollbars=yes,resizable=no,width=850,height=350')"><%=dbLabelBean.getLabel("stars.approve.reviewercomments",strsesLanguage)%></a> 
	</td>
<%	}
	}
}
//else if message added by manoj chand to implement special workflow
else if(strViewflage.equals("S")){%>
	 <td class="listdata" width="5%" align="center">
	<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D&spFlag=y','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
	</td>
<%}else { //Added new Code  for vaman sehgal to view him requisition on 04-11-2008  by shiv sharma 
				if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))	{	
					strDetailPageUrl="Group_T_TravelRequisitionDetails_D.jsp";
					if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
						strDetailPageUrl="Group_T_TravelRequisitionDetails_GmbH.jsp";
					}
				} else{
					strDetailPageUrl="T_TravelRequisitionDetails_D.jsp"; 
					String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
					if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
						strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
					}
				}  
	    %>
	    
	<td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=600')"><%=strTravelRequestNo%></a> 
	</td>
	<%
} 
%>
    <td class="listdata" width="8%" align="center">
    	<%//=strTraveller%>
	<!-- by Pankaj on 26 Dec 2011-  introduced hyperlink to show travellers for group travel request. -->
<%
if(strTraveller.trim().equalsIgnoreCase("Group/Guest Travel")
		|| strTraveller.trim().equalsIgnoreCase("Guest Travel")){
%>
<a href="#" onClick="return defaultApproverListDOM(<%=strTravelId%>, '<%=strTravelRequestNo.replaceAll("/","~")%>');"><%=strTraveller%></a>	
<%
} else {
%>
	<p><span style="display: block;"><%=strTraveller %></span><span style="display: block;">[<%=strSiteName %>]</span></p>
<%
 }
%>    	
    </td>
    <td class="listdata" width="11%" align="center"><%=strFrom%></td>
<%--     <td class="listdata" width="11%" align="center"><%=strTo%></td> --%>
    <td class="listdata" width="10%" align="center"><%=strTravelDate%></td>   
     <td class="listdata" width="10%" align="center"><%=strReturnDate%></td>
    <td class="listdata" width="10%" align="center"><%=strTravel_classes%></td>
    <td class="listdata" width="16%" align="center"><%=strTravelAmount%></td>
   <!--<td class="listdata" width="5%" align="center"><%//=strDivName%>&nbsp;<b>/</b>&nbsp;<%//=strSiteName%></td>-->
	<!-- <td class="listdata" width="12%" align="Left">&nbsp;<//%=strTitle%></td>-->
    <td class="listdata" width="10%" align="center">&nbsp;<%=strOriginatedDate%></td>
	<td class="listdata" width="12%" align="center"><%=strOriginatorName%></td>
	<td class="listdata" width="13%" align="center"><B><%=strNextApprover%></B></td>
    
    <td class="listhead" width="19%" align="center" nowrap="nowrap">
	  <!--<a  href="T_TravelDetail_Dom_Edit.jsp?travelId=<%=strTravelId%>&flag=save">Edit</a>  |-->   
    <%if(strViewflage.equals("Y")){ %> 
      <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><!--<img src="images/clip123.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage)%></a> | <br>
      <a href="#" title="<%=dbLabelBean.getLabel("label.global.addcomments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><!--<img src="images/group1.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a>
      <%} %>
<%
     if(SuserRole!=null && SuserRole.equals("MATA") )
	 {
%>
       | <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage) %>" onClick="MM_openBrWindow('T_Travel_Requisition_Cancel.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','CANCEL','scrollbars=yes,resizable=yes,width=900,height=260')"><%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage) %></a>	   
<%
	 }

%>
	</td>
  </tr>
    <%
}
rs.close(); 
if(strNoRecFoundFlag != null && strNoRecFoundFlag.equals("no"))
{
	strShowBut="no";
%>
  <tr>
    <td colspan="15" class="formtr2"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage)%></td>
  </tr>
<%
}
strNoRecFoundFlag = "no";  //Again set the flag no
%>
<%
///  ----------------------------------------------------CODE NO FOR DISPLAY  ON THE PAGE------------------------------------------------------- 
///  ------------------------FOLLOWING CODE IS COMMENTED----MATA RECIEVIED OPTION ----by shiv Sharma on 28-Mar-08-------------------->> 
///  ------------------------FOLLOWING CODE IS COMMENTED----MATA RECIEVIED OPTION ----by shiv Sharma on 28-Mar-08-------------------->> 
///  ------------------------FOLLOWING CODE IS COMMENTED----MATA RECIEVIED OPTION ----by shiv Sharma on 28-Mar-08-------------------->> 
///  ------------------------FOLLOWING CODE IS COMMENTED----MATA RECIEVIED OPTION ----by shiv Sharma on 28-Mar-08-------------------->> 
///  Code Is Changed  For Not Showing Recieved Option For Mata Person  As They Don't  Wants To See This 
/// Code Is Hidding Just Changing Query   Status As( Ts.travel_status_id=80) So This Will Not Display On The Page     
if(SuserRole!=null && SuserRole.equals("MATA") )
{
%>
  <tr>
    <td colspan="15" class="formhead" ><!-- Received Request (s) --></td>
  </tr>
<%
 strFinalApprovalStatus="";
 strAttachment="0";
 strComment	=	"0";
 int intCount1 = 1; 
// strSql="SELECT DISTINCT TD.TRAVEL_ID, TD.TRAVELLER_ID, TD.TRAVEL_REQ_NO,ISNULL(RTRIM(.DBO.USER_NAME(TD.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATE, ISNULL(RTRIM(.DBO.USER_NAME(TD.C_USERID)),'NA') AS CREATED_BY, ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TD.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT,dbo.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT  FROM T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID=TS.TRAVEL_ID  AND TD.STATUS_ID=10  AND TS.TRAVEL_STATUS_ID=10 AND TS.TRAVEL_TYPE='D'";

strSql ="SELECT DISTINCT TD.TRAVEL_ID, TD.TRAVELLER_ID, TD.TRAVEL_REQ_NO,ISNULL(RTRIM(.DBO.USER_NAME(TD.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATE, ISNULL(RTRIM(.DBO.USER_NAME(TD.C_USERID)),'NA') AS CREATED_BY, ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TD.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT,dbo.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT,ta.approver_id  FROM T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD,T_APPROVERS TA WHERE TD.TRAVEL_ID=TS.TRAVEL_ID  AND TD.TRAVEL_ID=TA.TRAVEL_ID AND TD.STATUS_ID=10  AND TS.TRAVEL_STATUS_ID=80 AND TS.TRAVEL_TYPE='D'  and ta.travel_type='D'  and ta.approve_status=10 and ta.approver_id="+Suser_id;
 
 rs = dbConBean.executeQuery(strSql);

while(rs.next())
{
	strTravelId     		=	rs.getString(1);
	strTravellerId          =	rs.getString(2);
	strTravelRequestNo		=	rs.getString(3);
	strTraveller        	= 	rs.getString(4);	
	strOriginatorName		=	rs.getString(5);
	strOriginatedDate		=	rs.getString(6);	
	strNextApprover 		=	rs.getString(7);	
	strAttachment			=	rs.getString(8);
	strComment				=	rs.getString(9);

    //strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;
    
    strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure, [dbo].[FN_GetJourneyDetailsDOM]("+strTravelId+") AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;
    
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString("Expenditure");
		//strTravelCurrency   =   rs1.getString(3);
		strFrom             =   rs1.getString("TRAVEL_FROM");
		strTo               =   rs1.getString("TRAVEL_TO");	
		if(strTravelAmount != null && strTravelAmount.equals("0"))
	    { 
	    	strTravelAmount = "-";
	    }	

		
	}
	rs1.close();


	if(strAttachment.equals("0"))
	{
		strAttachment="";
	}
	else
	{
		strAttachment="<img src=images/clip123.gif border=0>";
	}

		if(strComment.equals("0"))
	{
		strComment="";
	}
	else
	{
		strComment="<img src=images/group1.gif border=0>";
	}

	
%>

<%
	strColor   =   "blue";
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
    iCls++;
	

%>

  <tr VALIGN="TOP" class="<%=strStyleCls%>"> 
    <td width="3%" align="Left" bgColor="<%=strColor%>"></td>
    <td class="listhead" width="3%" align="Left"><%=intCount1++%><a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strComment%></a> <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a> </td>	

<%
    if(SuserRole!=null && SuserRole.equals("MATA") )
    {
%><!--@ Vijay 27/Mar/2007 Change the file T_reqFrame_MATA.jsp-->
	  <td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('T_reqFrame_MATA.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
	  </td>
<%  }
	else
	{
%>	
	<td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
	</td>
<%
	}
%>
    <td class="listdata" width="10%" align="center"><%=strTraveller%></td>
    <td class="listdata" width="11%" align="center"><%=strFrom%></td>
<%--     <td class="listdata" width="11%" align="center"><%=strTo%></td> --%>
    <td class="listdata" width="10%" align="center"><%=strTravelDate%></td>
    <td class="listdata" width="16%" align="center"><%=strTravelAmount%></td>
   <!--<td class="listdata" width="5%" align="center"><%//=strDivName%>&nbsp;<b>/</b>&nbsp;<%//=strSiteName%></td>-->
	<!-- <td class="listdata" width="12%" align="Left">&nbsp;<//%=strTitle%></td>-->
    <td class="listdata" width="10%" align="center">&nbsp;<%=strOriginatedDate%></td>
	<td class="listdata" width="12%" align="center"><%=strOriginatorName%></td>
	<td class="listdata" width="13%" align="center"><B><%=strNextApprover%></B></td>
    
    <td class="listhead" width="19%" align="center">
   	  <!--<a  href="T_TravelDetail_Dom_Edit.jsp?travelId=<%=strTravelId%>&flag=save">Edit</a>  |   -->
      <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><!--<img src="images/clip123.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage)%></a> | 
      <a href="#" title="<%=dbLabelBean.getLabel("label.global.addcomments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><!--<img src="images/group1.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a>
<%
     if(SuserRole!=null && SuserRole.equals("MATA") )
	 {
%>
       | <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage) %>" onClick="MM_openBrWindow('T_Travel_Requisition_Cancel.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_D.jsp&targetFrame=yes','CANCEL','scrollbars=yes,resizable=yes,width=900,height=260')"><%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage)%></a>	   
<%
	 }

%>		  
	</td>
  </tr>
    <%
}
rs.close();

}//END IF FOR MATA

%>
</table>
</div>


<!-- div added by manoj chand on 09 april 2012 to show processing image -->
<div id="waitingData" style="visibility:hidden;padding: 0px ;
margin : 0px ;
border: 0px ;
position : absolute ;
overflow-x : auto ;
overflow-y : none ;
width: 40% ;
height: 40% ;
left: 459px ;
top: 250px ;
">
<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
<br>
<font color="#000080" class="pageHead"><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%></font>
</div>
<!-- change in code by manoj chand on 25 sept 2012 to place approve button at the bottom of the page also show page refresh time. -->
<%
if(strShowBut.equalsIgnoreCase("yes"))
{
%>
<div>
<table width="100%" style="position: absolute;bottom:0%;" align="center" border="0" cellpadding="4" cellspacing="0" class="formborder">
 <tr align="right"> 
 <td colspan="1" style="font-family:Arial, Helvetica, sans-serif;font-weight:bold;color:#373737;BACKGROUND:#efefef;text-align:right;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
    <td class="listhead" colspan="12" align="right" style="font-family:Arial, Helvetica, sans-serif;font-weight:bold;color:#373737;BACKGROUND:#efefef;">
<%	    if(SuserRole!=null && SuserRole.equalsIgnoreCase("MATA")){    %>
	      <input type="submit" id="sub" name="Submit" value="<%=dbLabelBean.getLabel("label.createrequest.receive",strsesLanguage)%>" class="formButton" >
<%      }else{   %>
          <input type="submit" id="sub" name="Submit" value="<%=dbLabelBean.getLabel("label.approverequest.approve",strsesLanguage)%>" class="formButton" >
<%	}%>
 	  <input type="button" name="CheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.checkall",strsesLanguage)%>" onClick="checkAll(document.frm)" class="formButton" >
	  <input type="button" name="UnCheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.uncheckall",strsesLanguage)%>" onClick="uncheckAll(document.frm)" class="formButton" >
	</td>
	<td align="right" colspan="2" style="font-family:Arial, Helvetica, sans-serif;font-weight:bold;color:#373737;BACKGROUND:#efefef;font-size: 11px;"><%=dbLabelBean.getLabel("label.approverequest.refreshat",strsesLanguage) %> : <span id="spn" style="padding-right: 5px;"></span></td>
  </tr> 
</table>
</div>
<script type="text/javascript">
getClientDateTime();
</script>
<%} %>
<input type=hidden name=count value="<%=intSerialNo-1%>">
<input type="hidden" name=travel_type value="D"/>
</form>
<br>
</body>
</HTML>
<%
dbConBean.close();
%>
<script type="text/javascript"> 

	$(document).ready(function(){
		
		$('#dom-req-header').append('<label style="position:absolute;left:278px;"><span class="greenBgCount">' + $('.dom-req-rows').length + '</span></label>');
		
		if($('.dom-req-rows').length==0){
			$('#dom-req-header').closest('tr').find('label').hide();
		}
		
		
	});
</script> 