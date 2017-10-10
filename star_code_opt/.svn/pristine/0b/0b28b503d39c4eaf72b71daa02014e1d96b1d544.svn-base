<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:07 March 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for approve both type (International and domestic) Travel Requisition in the STAR Database
 *Modification 			: 1.Added a line for color coding of International & domestice requision & showing  line at the top of page  
                            "Blue denotes International Travel Requisition & Green denotes Domestic Travel Requisition"  on 28-May-07 by shiv sharma  
					      2 .added code for  showing group travel in case of group travel inspite on traveler Name on 06-Mar-08 by shiv sharma 
					      3 . Code added for showing requisiton to Mr Vaaman which is pending with VC Sehgal on 04-11-2008 by shiv shiv sharma     
					      4:  added code for showing travel class of journey on 29 march 2010 by shiv sharma 

Project 				:STAR
Name					:Manoj Chand
Dated					:16/12/2010	
Modification			:To disable approve button after first click and show process bar during processing

Modified By				:Manoj Chand
Date of Modification	:22 JULY 2011	
Modification			:ADD childwindowSubmit() to close the comments screen and refreshing this page.

*Modified By			:Pankaj Dubey
*Date of Modification	:26 Dec 2011
*Modification			:to show hyperlink on against group travel requests to show travellers.

Modified By				:Manoj Chand
Date of Modification	:14 Feb 2012	
Modification			:Disable checkboxes for those both type of request for which local price is entered.

Modified By				:Manoj Chand
Date of Modification	:02 May 2012	
Modification			:Showing requests to reviewers for taking needed action and also a link to view reviewer commnets.					      

*Modified by				:Manoj Chand
*Date of Modification		:24 May 2012
*Modification				:Multilingual functionality added

*Modified by				:Manoj Chand
*Date of Modification		:24 Sept 2012
*Modification				:showing page refresh time at the bottom of the page and placed approve button at the bottom of the page
							 to approve both domestic and international request in one approve button click.
							 
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
*Description			:Display Return date column in approval screen for both type of request.
*******************************************************/

%>

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
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

<script language="JavaScript" src="Mobile_Survey/js/dyna.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="Mobile_Survey/js/jquery.js?buildstamp=2_0_0"></script>
<script language="JavaScript" src="Mobile_Survey/js/prettyCheckboxes.js?buildstamp=2_0_0"></script>
<link href="Mobile_Survey/css/prettyCheckboxes.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">


<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
// Variables declared and initialized

String strTravelType      =  "";
String strTravelTypeFlag  =  "";
String strTemp="";
strTravelType   =  request.getParameter("travel_type"); 
strTemp=request.getParameter("flag");
String strShowflag=dbLabelBean.getLabel("label.login.showflag",strsesLanguage);
//System.out.println("strShowflag--->"+strShowflag);
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}

strTravelType = "I";

String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");

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
String strGroupTravelFlag	="";
String strTravelAgencyTypeId	="";



String	strSiteName			=  "";
String	strDivName			=  "";
int iCls				    =  0;
String strStyleCls			=  "";
String strTitle				=  "";
String strShowBut="yes";
String strShowBut1="yes";
int expTrvReqWeeks = 0;
%>


<script language=JavaScript >

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
		//var xpos = screen.availHeight/2+90;
		//var ypos = findPos(buttonobj);
		//alert(dv.innerHTML);
			
			//dv.style.display="block";       		
			//dv.style.left=(xpos+10)+"px";
			//dv.style.top=(ypos-180)+"px";
			//dv.style.left=(xpos+10)+"px";
			//dv.style.top=(ypos)+"px";
			dv.style.zIndex=1;
			
			dv.style.visibility='visible';
}

function closeDivRequest()
{
	document.getElementById("waitingData").style.visibility="hidden";	
}
function closeDivRequest1()
{
	document.getElementById("waitingData1").style.visibility="hidden";	
}
var enb=false;      
var subd=false;   

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
function check(flag)
{
	if(flag == 0)
	{
		openWaitingProcess();
		for (i = 0; i < document.frm.length; i++)
		{
			if ( document.frm[i].checked == true)
				return true;
		}
	}
	
	closeDivRequest();
	alert('<%=dbLabelBean.getLabel("alert.approverequest.errormessage",strsesLanguage)%>');
	
	enb=true;
	enable();
	return false; 
}

function childwindowSubmit(){
	document.frm.action='T_approveTravelRequisitions_All.jsp';
	document.frm.submit();
}

//added by manoj chand on 05 feb 2013 to refresh this window
function refreshParent(suburl){
	document.frm.action=suburl;
	document.frm.submit();
}

function defaultApproverListINT(strTravelId, strTravelRequestNo)
{
	var url = 'T_ShowTravellerFromGroupReqs.jsp?traveltype=INT&strTravelId='+strTravelId+'&strTravelRequestNo='+strTravelRequestNo;
	window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=400,height=350');
}

function defaultApproverListDOM(strTravelId , strTravelRequestNo )
{
	var url = 'T_ShowTravellerFromGroupReqs.jsp?traveltype=DOM&strTravelId='+strTravelId+'&strTravelRequestNo='+strTravelRequestNo;
	window.open(url,'DefaultApprovers','scrollbars=yes,resizable=no,width=400,height=350');
}
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
<%if(strShowflag!=null && strShowflag.equals("yes")){ %>
<body onload="creatediv();" style="overflow-y:hidden; ">
<%}else{ %>
<body style="overflow-y:hidden; ">
<%} %>

<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<div id="dv" style="width:100%; left:0px; height:92%; position: absolute; overflow: auto;" >
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="45">
  <tr>  <!-- This code  is  added by shiv on 28-May-07 open -->
        <td width="60%" height="20"  >
        <%if(ssflage.equals("3")) {%>
	           <p class="pageHead"> <font size='2' color='blue'>&nbsp; &nbsp;&nbsp;<%=dbLabelBean.getLabel("label.approverequest.blue",strsesLanguage)%> </font><font  size='1'><%=dbLabelBean.getLabel("label.approverequest.intercont.message",strsesLanguage)%> </font><font size='2' color='#00CC00'><%=dbLabelBean.getLabel("label.approverequest.green",strsesLanguage)%></font><font size='1'> <%=dbLabelBean.getLabel("label.approverequest.domesticeurope.message",strsesLanguage)%></font></p>
	    <%}else{ %>
	    		<p class="pageHead"> <font size='2' color='blue'>&nbsp; &nbsp;&nbsp;<%=dbLabelBean.getLabel("label.approverequest.blue",strsesLanguage)%> </font><font  size='1'><%=dbLabelBean.getLabel("label.approverequest.international.message",strsesLanguage)%> </font><font size='2' color='#00CC00'><%=dbLabelBean.getLabel("label.approverequest.green",strsesLanguage)%></font><font size='1'> <%=dbLabelBean.getLabel("label.approverequest.domestic.message",strsesLanguage)%></font></p>
	    <%} %> 
       </td>
  </tr>  <!-- This code is  added by shiv on 28-May-07 closed -->
  <tr>
    <td width="60%" height="26" class="bodyline-top">
	<ul class="pagebullet">
      
      <%if(ssflage.equals("3")) {%>
	           <li class="pageHead" id="int-req-header"> <%=dbLabelBean.getLabel("label.approverequest.interconttravelrequest",strsesLanguage)%></li>
	    <%}else{ %>
	    		<li class="pageHead" id="int-req-header"> <%=dbLabelBean.getLabel("label.approverequest.internationaltravelrequest",strsesLanguage)%></li>
	    <%} %> 
    </ul>
    </td>
  </tr>
</table>

<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <form method=post name=frm action="T_approveTravelRequisitions_Post.jsp" onsubmit=" do_disable();  return check(0);">
  <tr class="formhead"> 
	<td class="listhead" width="1%" align="center"><img src="images/tick2.gif?buildstamp=2_0_0" border=0></td>	
	<td class="listhead" width="3%" align="center">#</td>	
 	<td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.approverequest.viewandapprove",strsesLanguage)%></td>
    <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>

<%-- 	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)%></td> --%>
<%-- 	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%></td> --%>
	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.global.itineraryinfo",strsesLanguage)%></td>
	
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%></td><!-- 2/26/2007 -->
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.createrequest.finalreturndate",strsesLanguage)%></td><!-- 2/26/2007 -->
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.travelclass",strsesLanguage)%> </td><!--  added on 29 march 2010 by shiv sharma  -->
	<td class="listhead" width="16%" align="center"><%=dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverequest.nextwith",strsesLanguage)%></td>	
	<td class="listhead" width="15%" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>
<%

strSql  = "SELECT CAST(FUNCTION_VALUE AS INT) FROM functional_ctl WHERE FUNCTION_KEY='@ExpTrvReqCutOffWeekForApproval'";
rs = dbConBean.executeQuery(strSql);
if(rs.next())
{
	expTrvReqWeeks = rs.getInt(1);
}
rs.close();



String strItems       			 =  "";
String strNewReqNo    			 =  "";
String strApproverRole 			 =  "";
String strCheckBoxDisabled	     =  "";
String strDetailPageUrl			 =  "";	

//Query for Finding the role of approver
strSql  = "SELECT DISTINCT TA.ROLE FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND TS.TRAVEL_STATUS_ID=2          AND TA.TRAVEL_TYPE='I'           AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID  AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";
rs = dbConBean.executeQuery(strSql);         //get the result set
if(rs.next())
{
    strApproverRole = rs.getString(1);
}
rs.close();

// Query change  for showing requisiton to Mr Vaaman which is pending with VC Sehgal on 04-11-2008 by shiv shiv sharma     
/*strSql="SELECT DISTINCT   TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER ,"+ 
	"ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY , " +  
	" ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'I', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'I') " +
	" AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'I') AS COMMENT, td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG,'Y' AS FLAG  " +
	" FROM         T_APPROVERS TA, T_TRAVEL_STATUS TS, T_TRAVEL_DETAIL_INT TD WHERE    TA.TRAVEL_ID = TS .TRAVEL_ID AND "+
	" TD.TRAVEL_ID = TS .TRAVEL_ID AND TS .TRAVEL_STATUS_ID = 2 AND TS .TRAVEL_TYPE = 'I' AND "+
	" TA.APPROVE_STATUS = 0 AND TA.APPROVER_ID = "+Suser_id+"  AND TA.TRAVEL_TYPE = 'I' AND "+
	" ORDER_ID =(SELECT     MIN(ORDER_ID) FROM  T_APPROVERS   WHERE    TRAVEL_ID = TS .TRAVEL_ID "+ 
	" AND TRAVEL_TYPE = 'I' AND APPROVE_STATUS = 0 AND STATUS_ID = 10) UNION SELECT DISTINCT "+
	" TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER, "+ 
	" ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY, "+ 
	" ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'I', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'I') "+
	" AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'I') AS COMMENT, td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG,'N' AS FLAG "+
	" FROM T_APPROVERS TA, T_TRAVEL_STATUS TS, T_TRAVEL_DETAIL_INT TD WHERE     TA.TRAVEL_ID = TS .TRAVEL_ID AND TD.TRAVEL_ID = TS .TRAVEL_ID "+ 
	" AND TS .TRAVEL_STATUS_ID = 2 AND TS .TRAVEL_TYPE = 'I' AND  TA.APPROVE_STATUS = 0 AND TA.APPROVER_ID in( select pendingwithuser from "+
	" PAGE_ACCESS_PERMISSION where viewtouser ="+Suser_id+" )AND TA.TRAVEL_TYPE = 'I' AND ORDER_ID =  (SELECT     MIN(ORDER_ID) "+
	"  FROM   T_APPROVERS     WHERE      TRAVEL_ID = TS .TRAVEL_ID AND TRAVEL_TYPE = 'I' AND APPROVE_STATUS = 0 AND STATUS_ID = 10) ";
*/
//change in query done by manoj chand on 02 may 2012 to implement special approval
strSql="SELECT DISTINCT  TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO,"+
		" ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER,  "+
		" ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE,"+
		" ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY,"+ 
		" ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'I', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH,"+ 
		" DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'I')  AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'I') AS COMMENT,"+
		" td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id,'Y' AS FLAG,TA.PAP_FLAG,  "+
		" RTRIM(LTRIM(DBO.SITENAME(TD.SITE_ID)))+CASE WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
		" LIKE '%@MINDID.COM%' THEN '-Design' WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
		" LIKE '%@MIND%' THEN '-SW' else '' end AS TRAVELSITE FROM   T_APPROVERS TA INNER JOIN"+
		" T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID INNER JOIN"+
		" T_TRAVEL_DETAIL_INT TD  on TD.TRAVEL_ID = TS .TRAVEL_ID "+
		" WHERE TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND TS.TRAVEL_STATUS_ID = 2 "+
		" AND TS.TRAVEL_TYPE = 'I'"+ 
		" AND  TA.APPROVE_STATUS = 0 "+
		" AND TA.APPROVER_ID ="+Suser_id+
		" AND TA.TRAVEL_TYPE = 'I' "+
		" AND ORDER_ID = (SELECT   MIN(ORDER_ID)  FROM  T_APPROVERS"+   
		" WHERE  TRAVEL_ID = TS .TRAVEL_ID AND TRAVEL_TYPE = 'I' AND APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)"+   
		" AND ((TA.PAP_APPROVER = 0) OR (TA.PAP_APPROVER <> 0 AND TA.PAP_FLAG <> '' ))"+
		" union"+
		" SELECT DISTINCT   TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO,"+ 
		" ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)), 'NA') AS TRAVELLER,"+  
		" ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME), '-') AS C_DATE, "+
		" ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)), 'NA') AS CREATED_BY,"+ 
		" ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID, 'I', TA.TRAVELLER_ID)), 'NA') AS NEXTWITH,"+
		" DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID, 'I') AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID, 'I') AS COMMENT,"+
		" td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id, case when access_level='full' then 'S' else 'N' end AS FLAG,TA.PAP_FLAG,  "+
		" RTRIM(LTRIM(DBO.SITENAME(TD.SITE_ID)))+CASE WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
		" LIKE '%@MINDID.COM%' THEN '-Design' WHEN TD.SITE_ID IN (86,297) AND DBO.USEREMAIL(TA.TRAVELLER_ID) "+
		" LIKE '%@MIND%' THEN '-SW' else '' end AS TRAVELSITE FROM  T_APPROVERS TA inner join"+
		" T_TRAVEL_STATUS TS on TA.TRAVEL_ID = TS .TRAVEL_ID inner join"+
		" T_TRAVEL_DETAIL_INT TD on TD.TRAVEL_ID = TS .TRAVEL_ID inner join"+ 
		" PAGE_ACCESS_PERMISSION PAP on PAP.pendingwithuser =  case when TA.ORIGINAL_APPROVER =0 then TA.APPROVER_ID else TA.ORIGINAL_APPROVER end "+
		" WHERE	TS.STATUS_ID=10 AND TD.STATUS_ID=10 AND TS.TRAVEL_STATUS_ID = 2 "+
		" AND		TS.TRAVEL_TYPE = 'I' "+
		" AND		TA.APPROVE_STATUS = 0 "+
		" AND		PAP.STATUS =10"+    
		" AND		(TA.PAP_APPROVER  ="+Suser_id+" or PAP.viewtouser="+Suser_id+")"+
		" AND TA.PAP_FLAG ='' AND TA.TRAVEL_TYPE = 'I'"+  
		" AND		ORDER_ID =(SELECT     MIN(ORDER_ID) FROM  T_APPROVERS  WHERE    TRAVEL_ID = TS .TRAVEL_ID"+ 
		" AND TRAVEL_TYPE = 'I' AND  APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";
//System.out.println("strSql===all=I==>>>>>"+strSql);   

String strColor="";
String strFinalApprovalStatus="";
String strAttachment="0";
String strComment   ="0";
String strNoRecFoundFlag = "no";
String  strViewflage	 ="";
String  strPAPflag	 ="";
String strPageUrl			="";
String strTravel_classes	="";	
String strTkProviderFlag	= "";
String strTkProviderFlag1	= "";
String strCreator		="";
String strCreator1		="";


rs = dbConBean.executeQuery(strSql);
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

	//added code for  showing group travel in case of group travel inspite on traveler Name on 06-Mar-08 by shiv sharma    
	strGroupTravelFlag		=	rs.getString("GROUP_TRAVEL_FLAG");
	strTravelAgencyTypeId	=	rs.getString("travel_agency_id");
	strSiteName 			=	rs.getString("TRAVELSITE");

          if(strGroupTravelFlag==null) 
			{
					     strGroupTravelFlag="N";
	         }
  			if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
				{
					strTraveller ="Group/Guest Travel";
					if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
						strTraveller ="Guest Travel";
					}
	            }
	       


    //strSql =  "SELECT ISNULL(DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY, ISNULL(DBO.TRAVEL_FROM("+strTravelId+",'I'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'I'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'I') as travel_class FROM T_TRAVEL_DETAIL_INT TD WHERE TD.TRAVEL_ID="+strTravelId ;
    //query change by manoj chand on 14 feb 2012 to fetch tk_provider_flag
    //query change by manoj chand on 01 feb 2013 to show multiple currency amount
    //strSql =  "SELECT ISNULL(DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE("+strTravelId+",'I') AS Expenditure, ISNULL(DBO.TRAVEL_FROM("+strTravelId+",'I'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'I'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'I') as travel_class ,c_userid, tk_provider_flag FROM T_TRAVEL_DETAIL_INT TD WHERE TD.TRAVEL_ID="+strTravelId ;
    
    strSql =  "SELECT ISNULL(DBO.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'), dbo.FN_GET_EXPENDITURE("+strTravelId+",'I') AS Expenditure, [dbo].[FN_GetJourneyDetailsINT]("+strTravelId+") AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'I'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'I') as travel_class ,c_userid, tk_provider_flag FROM T_TRAVEL_DETAIL_INT TD WHERE TD.TRAVEL_ID="+strTravelId ;
    
    //System.out.println("strSql -t_approvertravelReq_all--->"+strSql );
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
	
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
    iCls++;

	strColor = "Blue"; // color changed by shiv shiv on 28-May-07  
	
	strViewflage       =   rs.getString("FLAG");
	strPAPflag         =   rs.getString("PAP_FLAG");
%>

 <tr VALIGN="TOP" class="<%=strStyleCls%> int-req-rows"> 
 
  <%   if (strViewflage.equals("N")){ 
   	 	strCheckBoxDisabled="disabled";
      }
   else{
	   strCheckBoxDisabled="enabled";
   }
	  if(strTkProviderFlag.trim().equalsIgnoreCase("n") && (strCreator.trim().equalsIgnoreCase(Suser_id) || SuserRole.equalsIgnoreCase("MATA"))){
		  strCheckBoxDisabled="disabled";
	  }

	//added by manoj chand to show return date on 21 May 2013
	  String strReturnDate="";
	  strSql =  "SELECT ISNULL(DBO.CONVERTDATEDMY1(trjdi.TRAVEL_DATE),'-') from dbo.T_RET_JOURNEY_DETAILS_INT trjdi WHERE trjdi.TRAVEL_ID="+strTravelId;
	  rs1=null;
	  rs1 = dbConBean1.executeQuery(strSql);
	  if(rs1.next()){
	  	strReturnDate = rs1.getString(1);
	  }
	  if(strReturnDate.equals(""))
			strReturnDate="-";
	  rs1.close();    
	  
  
  %>
    <td width="3%" align="Left" bgColor="<%=strColor%>"><input class="<%=strStyleCls%>" type=checkbox name="chk<%=intSerialNo++%>" value="<%=strTravelId%>;<%=strTravellerId%>;I"  <%=strCheckBoxDisabled%>></td>
    <td class="listhead" width="3%" align="Left"><%=intSerialNo%>
     <% if (strViewflage.equals("Y")){ %>
     <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strComment%></a> <a href="#" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a></td>	
   
     <%} %>
      <% if (strViewflage.equals("Y")){ %>
      <td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=I&AllTravelPageFlag=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a>
		<%if (strPAPflag.equals("P") || strPAPflag.equals("A")){ %>
		<br><a href="#" onClick="MM_openBrWindow('T_reviewerComments.jsp?travelRequisitionId=<%=strTravelId%>&approverId=<%=strTravellerId%>&reqNo=<%=strTravelRequestNo%>&papFlag=<%=strPAPflag %>','SEARCH','scrollbars=yes,resizable=no,width=850,height=350')"><%=dbLabelBean.getLabel("stars.approve.reviewercomments",strsesLanguage)%></a> 
	  </td>
	  <%}}
    //else if message added by manoj chand to implement special workflow
      else if(strViewflage.equals("S")){%>
     	 <td class="listdata" width="5%" align="center">
  		<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=I&AllTravelPageFlag=yes&spFlag=y','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
  		</td>
      <%}else{ //Code added for showing requisiton to Mr Vaaman which is pending with VC Sehgal on 04-11-2008 by shiv  sharma     
		  	if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
				{
		  		strPageUrl = "Group_T_TravelRequisitionDetails.jsp";
		  		if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  			strPageUrl="Group_T_TravelRequisitionDetails_GmbH.jsp";
				}
				}
		  	else{
		  	  	strPageUrl = "T_TravelRequisitionDetails.jsp";
		  	  if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  		strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
		  	}
		  	
	  %>
	  
	  <td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('<%=strPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=I&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=850,height=650')"><%=strTravelRequestNo%></a> 
	  </td>
	  
	  <%} %>

	<td class="listdata" width="8%" align="center">
	<!-- by Pankaj on 26 Dec 2011-  introduced hyperlink to show travellers for group travel request. -->
<%
if(strTraveller.equalsIgnoreCase("Group/Guest Travel") || strTraveller.equalsIgnoreCase("Guest Travel")){
%>
<a href="#" onClick="return defaultApproverListINT(<%=strTravelId%>, '<%=strTravelRequestNo.replaceAll("/","~")%>');"><%=strTraveller%></a>	
<%
} else {
%>
	<p><span style="display: block;"><%=strTraveller %></span><span style="display: block;">[<%=strSiteName %>]</span></p>
<%
 }
%> 
	</td>
    <td class="listdata" width="12%" align="center"><%=strFrom%></td>
<%--     <td class="listdata" width="12%" align="center"><%=strTo%></td> --%>
    <td class="listdata" width="10%" align="center"><%=strTravelDate%></td>
    <td class="listdata" width="10%" align="center"><%=strReturnDate%></td>                 
     <td class="listdata" width="10%" align="center"  ><%=strTravel_classes%></td> 
    <td class="listdata" width="16%" align="center"><%=strTravelAmount%></td>
    <td class="listdata" width="10%" align="center">&nbsp;<%=strOriginatedDate%></td>
	<td class="listdata" width="10%" align="center"><%=strOriginatorName%></td>
	<td class="listdata" width="13%" align="center"><B><%=strNextApprover%></B></td>
    
    <td class="listhead" width="19%" align="center" nowrap="nowrap">
  <% if (strViewflage.equals("Y")){ %>
      <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><!--<img src="images/clip123.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage)%></a> | <br>
      <a href="#" title="<%=dbLabelBean.getLabel("label.global.addcomments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><!--<img src="images/group1.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a>
<%} %>
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
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="35">
  <tr>
    <td width="45%" class="bodyline-top">
	<ul class="pagebullet">
      <%if(ssflage.equals("3")) {%>
	           <li class="pageHead" id="dom-req-header"> <%=dbLabelBean.getLabel("label.approverequest.domesticeuropetravelrequest",strsesLanguage)%></li>
	    <%}else{ %>
	    		<li class="pageHead" id="dom-req-header"> <%=dbLabelBean.getLabel("label.approverequest.domestictravelrequest",strsesLanguage)%></li>
	    <%} %> 
    </ul>
    </td>
    <td width="55%" class="bodyline-top">&nbsp;</td>
  </tr>
</table>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <tr class="formhead"> 
	<td class="listhead" width="1%" align="center"><img src="images/tick2.gif?buildstamp=2_0_0" border=0></td>	
	<td class="listhead" width="3%" align="center">#</td>	
 	<td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.approverequest.viewandapprove",strsesLanguage)%></td>
    <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>

<%-- 	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)%></td> --%>
<%-- 	<td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%></td> --%>
    <td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.global.itineraryinfo",strsesLanguage)%></td>
    
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%></td><!-- 2/26/2007 -->
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.createrequest.finalreturndate",strsesLanguage)%></td><!-- 2/26/2007 -->
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.travelclass",strsesLanguage)%> </td><!-- 2/26/2007 -->
	<td class="listhead" width="16%" align="center"><%=dbLabelBean.getLabel("label.mail.amountrequested",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverequest.nextwith",strsesLanguage)%></td>	
	<td class="listhead" width="15%" align="center" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>

<%

//Domestic Travel Requisitions
    //intSerialNo             =  0;   
	strNoRecFoundFlag       =   "no";
	String strTravel_classes1 ="";
	int intSerialNo1=1; 
//	 Query change  for showing requisiton to Mr Vaaman which is pending with VC Sehgal on 04-11-2008 by shiv shiv sharma     

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
	    " td.GROUP_TRAVEL_FLAG AS GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id,'Y' AS FLAG,TA.PAP_FLAG, "+  
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
		" AND		TS.TRAVEL_TYPE = 'D'"+ 
		" AND		TA.APPROVE_STATUS = 0"+ 
		" AND		PAP.STATUS =10"+
		" AND		(TA.PAP_APPROVER  ="+Suser_id+" or PAP.viewtouser="+Suser_id+")"+ 
		" AND TA.PAP_FLAG ='' AND TA.TRAVEL_TYPE = 'D'"+  
		" AND		ORDER_ID =(SELECT     MIN(ORDER_ID) FROM  T_APPROVERS  WHERE    TRAVEL_ID = TS .TRAVEL_ID"+
		" AND TRAVEL_TYPE = 'D' AND  APPROVE_STATUS = 0 AND STATUS_ID = 10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";		   

//System.out.println("strSql===all=D==>>>>>"+strSql);
rs = dbConBean.executeQuery(strSql);
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

	strGroupTravelFlag		=	rs.getString("GROUP_TRAVEL_FLAG");
	strTravelAgencyTypeId	=	rs.getString("travel_agency_id");
	strSiteName 			=	rs.getString("TRAVELSITE");

          if(strGroupTravelFlag==null) 
			{
					     strGroupTravelFlag="N";
	         }
  			if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
				{
					strTraveller ="Group/Guest Travel";
					if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
						strTraveller ="Guest Travel";
					}
	            }

   // strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'D') as travel_class FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;
   //query changed by manoj chand on 14 feb 2012 to get TK_PROVIDER_FLAG
   //query change by manoj chand on 01 feb 2013 to show multiple currency amount
    //strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'D') as travel_class,c_userid,tk_provider_flag FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;
   
    strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),dbo.FN_GET_EXPENDITURE('"+strTravelId+"','D') AS Expenditure, [dbo].[FN_GetJourneyDetailsDOM]("+strTravelId+") AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO,dbo.FN_TRAVEL_CLASS("+strTravelId+",'D') as travel_class,c_userid,tk_provider_flag FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;
    //System.out.println("strSql--->"+strSql);
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString("Expenditure");
		//strTravelCurrency   =   rs1.getString(3);
		strFrom             =   rs1.getString("TRAVEL_FROM");
		strTo               =   rs1.getString("TRAVEL_TO");	
		strTravel_classes1  =   rs1.getString("travel_class");
		strCreator1			=	rs1.getString("c_userid");
		strTkProviderFlag1  =	rs1.getString("tk_provider_flag");
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

	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
    iCls++;
	strColor = "#00CC00";  //color changed by shiv on  28-May-07 
	strViewflage       =   rs.getString("FLAG");
	strPAPflag         =   rs.getString("PAP_FLAG");
%>

  <tr VALIGN="TOP" class="<%=strStyleCls%> dom-req-rows"> 
  
   <%   if (strViewflage.equals("N")){ 
   	 	strCheckBoxDisabled="disabled";
      }
   else{
	   strCheckBoxDisabled="enabled";
   } 
   if(strTkProviderFlag1.trim().equalsIgnoreCase("n") && (strCreator1.trim().equalsIgnoreCase(Suser_id) || SuserRole.equalsIgnoreCase("MATA"))){
	   strCheckBoxDisabled="disabled";
   }
   
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
<td width="3%" align="Left" bgColor="<%=strColor%>"><input class="<%=strStyleCls%>" type=checkbox name="chk<%=intSerialNo++%>" value="<%=strTravelId%>;<%=strTravellerId%>;D" <%=strCheckBoxDisabled%>></td>
    <td class="listhead" width="3%" align="Left"><%=intSerialNo1++%>
    <% if (strViewflage.equals("Y")){ %>
    <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage) %>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strComment%></a> <a href="#" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a> </td>	
     <%} %>
     
     <% if (strViewflage.equals("Y")){ %>
		<td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D&AllTravelPageFlag=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a>
		<% if (strPAPflag.equals("P") || strPAPflag.equals("A")){%>
		<br><a href="#" onClick="MM_openBrWindow('T_reviewerComments.jsp?travelRequisitionId=<%=strTravelId%>&approverId=<%=strTravellerId%>&reqNo=<%=strTravelRequestNo%>&papFlag=<%=strPAPflag %>','SEARCH','scrollbars=yes,resizable=no,width=850,height=350')"><%=dbLabelBean.getLabel("stars.approve.reviewercomments",strsesLanguage)%></a>
		</td>
	 <%}}
     //else if message added by manoj chand to implement special workflow
     else if(strViewflage.equals("S")){%>
    	 <td class="listdata" width="5%" align="center">
 		<a href="#" onClick="MM_openBrWindow('T_reqFrame.jsp?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D&AllTravelPageFlag=yes&spFlag=y','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
 		</td>
     <%}else{ //Code added for showing requisiton to Mr Vaaman which is pending with VC Sehgal on 04-11-2008 by shiv  sharma     
		 if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))	{	
			strDetailPageUrl="Group_T_TravelRequisitionDetails_D.jsp";
		} else{
			strDetailPageUrl="T_TravelRequisitionDetails_D.jsp"; 
			if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
				strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
				}
		} %>
	 <td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=D&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=850,height=650')"><%=strTravelRequestNo%></a> 
	</td>
	 <%} %>
	
    <td class="listdata" width="10%" align="center">
    	<%//=strTraveller%>
    		<!-- by Pankaj on 26 Dec 2011-  introduced hyperlink to show travellers for group travel request. -->
<%
if(strTraveller.equalsIgnoreCase("Group/Guest Travel") || strTraveller.equalsIgnoreCase("Guest Travel")){
%>
<a href="#" onClick="return defaultApproverListDOM(<%=strTravelId%>, '<%=strTravelRequestNo.replaceAll(",","~")%>');"><%=strTraveller%></a>	
<% 
} else {
%>
	<p><span style="display: block;"><%=strTraveller %></span><span style="display: block;">[<%=strSiteName %>]</span></p>
<%
 }
%> 
    </td>
    <td class="listdata" width="12%" align="center"><%=strFrom%></td>
<%--     <td class="listdata" width="12%" align="center"><%=strTo%></td> --%>
    <td class="listdata" width="10%" align="center"><%=strTravelDate%></td>
    <td class="listdata" width="10%" align="center"><%=strReturnDate%></td>
    <td class="listdata" width="10%" align="center"  ><%=strTravel_classes1%></td>  
    <td class="listdata" width="16%" align="center"><%=strTravelAmount%></td>
   <!--<td class="listdata" width="5%" align="center"><%//=strDivName%>&nbsp;<b>/</b>&nbsp;<%//=strSiteName%></td>-->
	<!-- <td class="listdata" width="12%" align="Left">&nbsp;<//%=strTitle%></td>-->
    <td class="listdata" width="10%" align="center">&nbsp;<%=strOriginatedDate%></td>
	<td class="listdata" width="10%" align="center"><%=strOriginatorName%></td>
	<td class="listdata" width="13%" align="center"><B><%=strNextApprover%></B></td>
    
    <td class="listhead" width="19%" align="center" nowrap="nowrap">
	  <!--<a  href="T_TravelDetail_Dom_Edit.jsp?travelId=<%=strTravelId%>&flag=save">Edit</a>  |-->   
  <% if (strViewflage.equals("Y")){ %>
      <a href="#" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><!--<img src="images/clip123.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage)%></a> |<br> 
      <a href="#" title="<%=dbLabelBean.getLabel("label.global.addcomments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_approveTravelRequisitions_All.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><!--<img src="images/group1.gif?buildstamp=2_0_0" border=0>--><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a>
      <%}%>
	</td>
  </tr>
    <%
}
rs.close();
if(strNoRecFoundFlag != null && strNoRecFoundFlag.equals("no"))
{
	strShowBut1="no";
%>
  <tr>
    <td colspan="15" class="formtr2"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage)%></td>
  </tr>
<%
}
%>

</table>
</div>

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

<!-- change in code by manoj chand on 24 sept 2012 to place approve button at the bottom of the page also show page refresh time. -->
<%
if(strShowBut.equalsIgnoreCase("yes") || strShowBut1.equalsIgnoreCase("yes"))
{
%>

<div>

<table width="100%" style="position: absolute;bottom:0%;" align="center" border="0" cellpadding="5" cellspacing="0" class="formborder">

<tr align="right">

<td colspan="1" style="font-family:Arial, Helvetica, sans-serif;font-weight:bold;color:#373737;BACKGROUND:#efefef;text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
    <td class="listhead" colspan="12" align="right" style="font-family:Arial, Helvetica, sans-serif;font-weight:bold;color:#373737;BACKGROUND:#efefef;">
        <input type="submit" id="sub" name="Submit" value="<%=dbLabelBean.getLabel("label.approverequest.approve",strsesLanguage)%>" class="formButton">
 	  <input type="button" name="CheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.checkall",strsesLanguage)%>" onClick="checkAll(document.frm)" class="formButton" >
	  <input type="button" name="UnCheckAll" value="<%=dbLabelBean.getLabel("button.approverequest.uncheckall",strsesLanguage)%>" onClick="uncheckAll(document.frm)" class="formButton" >
	</td>
	<td colspan="2" align="right" style="font-family:Arial, Helvetica, sans-serif;font-weight:bold;color:#373737;BACKGROUND:#efefef;font-size: 11px;"><%=dbLabelBean.getLabel("label.approverequest.refreshat",strsesLanguage) %> : <span id="spn" style="padding-right: 5px;"></span></td>
  </tr> 
</table>
</div>
<script type="text/javascript">
getClientDateTime();
</script>
<%} %>

<input type="hidden" name="count" value="<%=intSerialNo-1%>">
<input type="hidden" name="AllTravelPageFlag" value="yes"/><!--Flag for finding the page-->
</form>
</body>
</HTML>
<%
dbConBean.close();
%>

<script type="text/javascript"> 

	$(document).ready(function(){
		
		$('#int-req-header').append('<label style="position:absolute;left:302px;"><span class="blueBgCount">' + $('.int-req-rows').length + '</span></label>');
		$('#dom-req-header').append('<label style="position:absolute;left:302px;"><span class="greenBgCount">' + $('.dom-req-rows').length + '</span></label>');
		
		
		if($('.int-req-rows').length==0){
			$('#int-req-header').closest('tr').find('label').hide();
		}
		
		if($('.dom-req-rows').length==0){
			$('#dom-req-header').closest('tr').find('label').hide();
		}

	
	});
    </script>     







