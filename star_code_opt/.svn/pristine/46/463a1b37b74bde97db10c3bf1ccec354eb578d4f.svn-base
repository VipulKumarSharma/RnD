<%
/***************************************************
*Copyright (C) 2000 MIND 
*All rights reserved.
*The information contained here in is confidential and 
*proprietary to MIND and forms the part of the MIND 
*CREATED BY			:	Rohit Ganjoo
*Date				:   02/09/2006
*Description		:	Transfer Mechanism Main Screen
*Project			:   STAR
*Modification		:	Report is not display correct in case of MATA.
                            :   Query Commented by shiv on 28-Mar-08 for not showing recived requisition 
*Modification Date	:	09/04/2007
*Modified By		:	Vijay Singh

*Modification		:   add if conditions to check from which page request is coming.
*Modified By		:	Manoj Chand
*Date 				:   24 jan 2011

*Modification		:   Add HandOver History for admin and write jquery for dropdown population
*Modified By		:	Manoj Chand 
*Date 				:   31 jan 2011

*Modification		:	Replace handover remarks taken from dropdown to textbox.
*Modified By		:	Manoj Chand	
*Date 				:   02 mar 2011

*Modification		:	future requests pending for approver is shown,so that super admin can also handover them
*Modified By		:	Manoj Chand
*Date				:	16 Mar 2012

*Modified By					: Manoj Chand
*Date of Modification			: 16 May 2012
*Modification					: resolve error of crashing when admin mark out of office

*Modified By					:Manoj Chand
*Date of Modification			:22 Oct 2013
*Modification					:javascript validation to stop from typing --,'  symbol is added.
**********************************************************/
%>

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>

<%@page import="java.net.URLEncoder"%><HTML>
<%@page import="java.net.URLDecoder"%>

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
<jsp:useBean id="dbConBean2" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>

<SCRIPT language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
// Variables declared and initialized
request.setCharacterEncoding("UTF-8");
String strTravelType		=  "";
String strTravelTypeFlag	=  ""; 
String strDispalyString		=  "";
String strTravelTypeTemp	=  "";

String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
	
//strTravelType   =  request.getParameter("travel_type"); 
strTravelType   =  (request.getParameter("travel_type")==null)?"":request.getParameter("travel_type");
//System.out.println("strTravelType--->"+strTravelType);
strTravelTypeTemp=strTravelType;
//System.out.println("strUserid====ss==="+strTravelType);
if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";

}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType 	= "D";
   
}
//strTravelType = "I";
if (strTravelType.equals("I")){
	   strDispalyString=dbLabelBean.getLabel("label.report.international",strsesLanguage);
}
if (strTravelType.equals("D")){
	strDispalyString =dbLabelBean.getLabel("label.report.domestic",strsesLanguage);	
}
if (strTravelType.equals("A")){
	
	strDispalyString =dbLabelBean.getLabel("label.handover.internationalanddomestic",strsesLanguage);	
}
 
//System.out.println("strDispalyString====>>>>>>"+strDispalyString);
//System.out.println("strUserid====ss==="+strTravelType);
ResultSet rs,rs1,rs2	=	null;			  // Object for ResultSet

int intSerialNo				=  1;
int intSerialNo1				=  1;
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
String	strSiteName			=  "";
String	strDivName			=  "";
int iCls				    =  0;
//int iiCls					=  0;
String strStyleCls			=  "";
String strTitle				=  "";
String strButtonDisabled	=  "";
String strTravelAmount		=  "";
String strTravelCurrency    =  "";
String strProcessType		= "";
String strUserid		    = (request.getParameter("userid")==null)?"+Suser_id+":request.getParameter("userid");
String strMsg				= URLDecoder.decode((request.getParameter("Msg")==null)?"":request.getParameter("Msg").trim(), "UTF-8");
String strMsg1				= URLDecoder.decode((request.getParameter("strmsg2")==null)?"":request.getParameter("strmsg2").trim(), "UTF-8");
//added by manoj
String strFlag				= (request.getParameter("flag")==null)?"":request.getParameter("flag").trim();
String strpageFlag			= (request.getParameter("pageflag")==null)?"":request.getParameter("pageflag").trim();
String Site_ID	     		= (request.getParameter("SelectUnit")==null)?"-1":request.getParameter("SelectUnit"); 

String  strSite=(String)session.getAttribute("siteforOutFOrmark");	

String url	="";
String flage="";

//added by manoj for handover history on 28 jan 2011
String strReqno="";
String strHandoverTo="";
String strHandoverOn="";
String strHandoverReason="";

if(strMsg.equals("false"))
		{
	url="T_outOfOffice.jsp?travel_type="+strTravelType+"&userid="+strUserid+"&strMsg="+URLEncoder.encode(strMsg1,"UTF-8");
	response.sendRedirect(url);
	}else{
		flage="false";
	}
%>

<script language=JavaScript >

function test1(obj1, length, str)
{	
	var obj;
	
	if(obj1=='handover_remarks')
	{
		obj = document.frm.handover_remarks;
	}
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
	upToTwoHyphen(obj);
}

//JQUERY DROPDOWN FILLING IMPLEMENTAION STARTS
$.noConflict();
jQuery(document).ready(function($) {
	$("#SelectUnit").change(
		function() {
			var siteId = $("#SelectUnit option:selected").val();
			var urlParams2 = '<%="&travel_type="+strTravelType+"&userid="+strUserid+"&reqpage=abc"%>';
			var urlParams = "siteId="+siteId+urlParams2;
			//alert(urlParams);
			$.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            success: function(result){
	            	 $("#delName").html(result);
	            },
				error: function(){
					alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
	            }
	          });
		}
	);
});
//JQUERY DROPDOWN FILLING IMPLEMENTAION ENDS


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
	var x=false;
	for (i = 0; i < document.frm.length; i++){
		if(document.frm[i].checked)
			x=true;
	}
	//alert(document.frm.length);
	if(document.frm.length==14)
		x=false;
	
	if(x==false){
		alert('<%=dbLabelBean.getLabel("alert.handover.errorselectatleastonerequest",strsesLanguage)%>');
		return false;
	}

	var unitval=document.frm.SelectUnit.value;
	if(unitval=='-1')
		{
	alert('<%=dbLabelBean.getLabel("alert.handover.pleaseselectsite",strsesLanguage)%>');
	document.frm.SelectUnit.focus();
	return false;
		}


	
var aa=document.frm.delName.value;
if(aa=='')
	{
alert('<%=dbLabelBean.getLabel("alert.handover.selectthenameofauthoritytohandover",strsesLanguage)%>');
document.frm.delName.focus();
return false;
	}


var a=document.frm.handover_remarks.value;
if(a=='')
	{
alert('<%=dbLabelBean.getLabel("alert.handover.pleasegiverreasonforhandover",strsesLanguage)%>');
document.frm.handover_remarks.focus();
return false;
	}

/*for (i = 0; i < document.frm.length; i++)
	{
	if ( document.frm[i].checked == true)
		return true;
	}
alert("Error!!Please select atleast one of the option(s).");
return false; */
}

function CheckOOO(){
		 var OOOuser 		=	eval("document.frm.delName")[eval("document.frm.delName").selectedIndex].getAttribute('alt');	
	     var Delegatuser	=	eval("document.frm.delName")[eval("document.frm.delName").selectedIndex].text;
	     if(OOOuser!='-'){
	     		  		document.frm.Submit.disabled="true"; 
	     		  		alert('<%=dbLabelBean.getLabel("label.createrequest.currently",strsesLanguage)%>'+" "+Delegatuser+" "+'<%=dbLabelBean.getLabel("alert.outofoffice.isooo",strsesLanguage)%>');
	     		}else{
	     			document.frm.Submit.disabled="";
     	}
}


function UnitValue(frm)
{
 	document.frm.action="T_HandOverRequest.jsp?travel_type=<%=strTravelType%>&userid=<%=strUserid%>&Msg=<%=strMsg%>&strmsg2=<%=strMsg1%>&flag=<%=strFlag%>&pageflag=<%=strpageFlag%>";
	document.frm.submit();
}
</script>
</HEAD>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" class="bodyline-top">
    <ul class="pagebullet">
	<li class="pageHead"><%=dbLabelBean.getLabel("button.handover.handover",strsesLanguage) %> <%=strDispalyString %> <%=dbLabelBean.getLabel("label.handover.requisitions",strsesLanguage) %> </li>
    </ul></td>
     <td align="right" valign="bottom" class="bodyline-top">

	   <table border="0" align="right" cellpadding="0" cellspacing="0">
    <tr align="right">    
<%
  if(SuserRole!=null && SuserRole.equals("MATA") )
  {}
  else
  {		 
%>
	  <td height="20" align="right" class="date2"> </td>	  
      <%}%>
	 <td height="20" align="right" class="date2"> </td>	  
	     <td>
     <ul id="list-nav">
     <li><a href="#" onClick="MM_openBrWindow('T_searchTravelRequisitions.jsp?travel_type=I','SEARCH','scrollbars=yes,resizable=yes,top=110,left=0,width=1017,height=565');"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage) %></a></li>
     <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
     </ul>
       </td>
    </tr>
	</table>
    </td>
  </tr>
</table>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <form method=post name="frm" action="T_HandOverPost.jsp" onSubmit="return check(0);">
    <input type="hidden" name="pType" value="<%=strProcessType.trim()%>">
    <input type="hidden" name="travel_type" value="I">

	<tr class="formhead">
	<td colspan="12" class="listhead"><%=dbLabelBean.getLabel("label.handover.currentrequestsinworkflow",strsesLanguage) %></td>
	</tr>
	
    <tr class="formhead">
      <td class="listhead" width="1%" align="center"><img src="images/tick2.gif?buildstamp=2_0_0" border=0></td>
      <td class="listhead" width="7%" align="center">#</td>
      <td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.approverequest.viewandapprove",strsesLanguage)%></td>
      <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)%></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%></td>
      <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%></td> <!-- 2/26/2007 -->
      <td class="listhead" width="6%" align="center"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></td>
      <td class="listhead" width="6%" align="center"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
      <td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
      <td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage)%></td>
      <td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.approverequest.nextwith",strsesLanguage)%></td>
      <!--<td class="listhead" width="17%" align="center">Action</td>  -->
    </tr>
    <%

String strApproverRole =  "";

//Query for Finding the role of approver
if (strTravelType.equals("I"))
{
strSql="SELECT DISTINCT TA.ROLE FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TS.TRAVEL_STATUS_ID=2 AND TA.TRAVEL_TYPE='I'AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I' AND APPROVE_STATUS=0 AND STATUS_ID=10)";
//System.out.println("strsql----I-->"+strSql);
}
else
	{
strSql="SELECT DISTINCT TA.ROLE FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TS.TRAVEL_STATUS_ID=2 AND TA.TRAVEL_TYPE='D'AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10)";
//System.out.println("strsql----else-->"+strSql);
}


rs = dbConBean.executeQuery(strSql);         //get the result set
if(rs.next())
{
    strApproverRole = rs.getString(1);
}
rs.close();

//if(strApproverRole!=null && strApproverRole.equals("CHAIRMAN"))
/*if(SuserRole!=null && (SuserRole.equals("CHAIRMAN") || SglobalApproverRole.equals("global")) )
{*/
//@ Vija Singh 03/04/2007 Change logic 

        if (strTravelType.equals("I")){
		strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
		//System.out.println("*************INT************"+strSql);
        } 
        if (strTravelType.equals("D"))
         { 
          strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND	TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserid+"  AND TA.TRAVEL_TYPE='D' AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
     	 //System.out.println("*************DOM************"+strSql);
         }
		if (strTravelType.equals("A")){
			strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE) union "+
				" SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND	TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserid+"  AND TA.TRAVEL_TYPE='D' AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
			 //System.out.println("*************ALL************"+strSql);
		}
		

//}
		
		if(SuserRole!=null && SuserRole.equals("MATA") )
		{ 	 
			 if (strTravelType.equals("I")){
		strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
		//System.out.println("***********MATA**INT**2**********"+strSql);
			 }
			 if (strTravelType.equals("D")){
  	          strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT,TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='D' AND ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)"; 
			 }
			 if (strTravelType.equals("A")){
				 
				 strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag ,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE) union "+
				       " SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT,TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='D' AND ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
			 }
		}
		//System.out.println("strSql===2==90=>>>>>>>"+strSql);
String strColor="";
rs = dbConBean.executeQuery(strSql);
String strFinalApprovalStatus="";
String strAttachment="0";
String strComment   ="0";
String strGroupTravelFlag	="";
String strTravelAgencyTypeId	="";
String urlpage				="";
String strDetailPageUrl		="";
if(rs.next())
{	
	do
	{
	strTravelType			=   rs.getString(1);	
	strTravelId     		=	rs.getString(2);
	strTravellerId          =	rs.getString(3);
	strTravelRequestNo		=	rs.getString(4);
	strTraveller        	= 	rs.getString(5);	
	strOriginatorName		=	rs.getString(6);
	strOriginatedDate		=	rs.getString(7);	
	strNextApprover 		=	rs.getString(8);	
	strAttachment			=	rs.getString(9);
	strComment				=	rs.getString(10);
	strGroupTravelFlag      =   rs.getString("GROUP_TRAVEL_FLAG"); 
	strTravelAgencyTypeId	=	rs.getString("TRAVEL_AGENCY_ID");

	//System.out.println("strTravelType====)))))--->"+strTravelType);	
	if(strGroupTravelFlag==null) 
			{
		strGroupTravelFlag="N";
	 	}
	          
		if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
			{ // block for group travel 
			  urlpage ="Group_T_IntTrv_Details.jsp";
			  if (strTravelType.equals("I")){
				  
						  if(SuserRole!=null && SuserRole.equals("MATA") ){
							  strDetailPageUrl="Group_MATA_Report_INT.jsp";
						    }
						  else{
							strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
							if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
								strDetailPageUrl="Group_T_TravelRequisitionDetails_GmbH.jsp";
							}
						   }
			  }
			  else{
				  
					  if(SuserRole!=null && SuserRole.equals("MATA") ){
						  strDetailPageUrl="Group_MATA_Report_DOM.jsp";
					    }else{
						strDetailPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
							if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
								strDetailPageUrl="Group_T_TravelRequisitionDetails_GmbH.jsp";
							}
				  		}	
				 }			  
			  strTraveller="Group/Guest Travel";  

		}
		else
			{   // block for group travel 
				if (strTravelType.equals("I"))
						{
							 if(SuserRole!=null && SuserRole.equals("MATA") ){
					 		 	strDetailPageUrl="MATA_Report_INT.jsp";
					    		}
							 else{
								strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
								if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
									strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
								}
					          }
			  			}
			  else{
				  		if(SuserRole!=null && SuserRole.equals("MATA") ){
			 		 			strDetailPageUrl="MATA_Report_DOM.jsp";
			    		  }
					 	else{
				  				strDetailPageUrl = "T_TravelRequisitionDetails_D.jsp";
				  				if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
									strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
								}
					 		}
			  }	
				
		}

	 if (strTravelType.equals("I")){
    	strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'I'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'I'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_INT TD WHERE TD.TRAVEL_ID="+strTravelId ;   
    }else{
    	strSql="SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId; 
    	} 
    
    //System.out.println("strSql===for to ===wer===="+strSql);
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString(2);
        strTravelCurrency   =   rs1.getString(3);

		strFrom             =   rs1.getString(4);
		strTo               =   rs1.getString(5);	
		
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

	strColor	=   "";
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
    iCls++;

%>
    <tr valign="TOP" class="<%=strStyleCls%>">
      <td width="3%" align="Left" bgcolor="<%=strColor%>">
      <input class="<%=strStyleCls%>" type=checkbox name="chk<%=intSerialNo%>" value="<%=strTravelId%>;<%=strTravellerId%>;<%=strTravelType%>"></td>
      <input class="colorpink" type=hidden name="transType<%=intSerialNo%>" value="REQS">
      <td class="listhead" width="3%" align="Left"><%=intSerialNo%>
      <a href="#" title="Comments" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=<%=strTravelType%>&whichPage=T_HandOverRequest.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strComment%></a> 
      <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=<%=strTravelType%>&whichPage=T_HandOverRequest.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strAttachment%></a>
          <!--<a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strAttachment%></a>-->
      </td>

	 <%
    if(SuserRole!=null && SuserRole.equals("MATA") )
    {
%>  
	  <td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=I&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
	  </td>
<%  }
	else
	{
%>	
	<td class="listdata" width="5%" align="center">
		<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travelType=<%=strTravelType %>','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strTravelRequestNo%></a> 
		
	</td>
<%
	}
%>
      <td class="listdata" width="10%" align="center"><%=strTraveller%></td>
      <td class="listdata" width="10%" align="center"><%=strFrom%></td>
      <td class="listdata" width="10%" align="center"><%=strTo%></td>
      <td class="listdata" width="10%" align="center"><%=strTravelDate%></td>
      <td class="listdata" width="10%" align="center"><%=strTravelAmount%></td>
      <td class="listdata" width="10%" align="center"><%=strTravelCurrency%></td>
      <td class="listdata" width="27%" align="center">&nbsp;<%=strOriginatedDate%></td>
      <td class="listdata" width="10%" align="center"><%=strOriginatorName%></td>
      <td class="listdata" width="13%" align="center"><b><%=strNextApprover%></b></td>
      <!--  <td class="listhead" width="19%" align="center"><a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I&whichPage=T_HandOverRequest.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="Add Attachments">Attach</a> | <a href="#" title="Add Comments" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I&whichPage=T_HandOverRequest.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')">
        Comments</a> </td>-->
    </tr>
    <%
	intSerialNo++;
	}while(rs.next());				
}

else
{
	
	if(strpageFlag.equalsIgnoreCase("t")){
	}
	else{
	if(strFlag.equalsIgnoreCase("y")){
	}
	else{
	strMsg1="<font color=red>"+dbLabelBean.getLabel("label.handover.currentlynothavependingrequisitions",strsesLanguage)+"</font>,<font color=green>"+dbLabelBean.getLabel("label.handover.outofofficemarkedsuccessfully",strsesLanguage)+"</font>";
	url="T_outOfOffice.jsp?travel_type="+strTravelType+"&userid="+strUserid+"&strMsg="+URLEncoder.encode(strMsg1,"UTF-8");
	 if (flage.equals("false") && !SuserRole.equalsIgnoreCase("AD")){
	response.sendRedirect(url);
	 }
	}
	}

%>
    <tr>
      <td colspan="15" class="formtr1"><%=dbLabelBean.getLabel("label.handover.notravelrequisitionsforhandover",strsesLanguage) %></td>
    </tr>
    
    <%}%>
  </table><br>  
<%    
rs.close();

//added by manoj chand on 14 March 2012 to show future requests pending with approvers.

strTravelType   =  (request.getParameter("travel_type")==null)?"":request.getParameter("travel_type");
//System.out.println("SuserRole----2-->"+SuserRole);
//System.out.println("strTravelType---2-->"+strTravelType);
if(SuserRole!=null && SuserRole.equalsIgnoreCase("AD")){
%>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

<!-- start from here-->

<tr class="formhead">
	<td colspan="12" class="listhead"><%=dbLabelBean.getLabel("label.handover.otherrequestsinworkflow",strsesLanguage) %></td>
	</tr>
	
    <tr class="formhead">
      <td class="listhead" width="1%" align="center"><img src="images/tick2.gif?buildstamp=2_0_0" border=0></td>
      <td class="listhead" width="7%" align="center">#</td>
      <td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.approverequest.viewandapprove",strsesLanguage)%></td>
      <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)%></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%></td>
      <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%></td> <!-- 2/26/2007 -->
      <td class="listhead" width="6%" align="center"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></td>
      <td class="listhead" width="6%" align="center"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage)%></td>
      <td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
      <td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage)%></td>
      <td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.checkstatus.nowwith",strsesLanguage)%></td>
      <!--<td class="listhead" width="17%" align="center">Action</td>  -->
    </tr>


<%
if (strTravelType.equals("I")){
	//strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND ORDER_ID!=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10)";
	strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I'  AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
	//System.out.println("*************INT**2**********"+strSql);
    } 
    if (strTravelType.equals("D"))
     { 
      //strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND	TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserid+"  AND TA.TRAVEL_TYPE='D' AND ORDER_ID!=(SELECT MIN(ORDER_ID) FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10)";
      strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserid+"  AND TA.TRAVEL_TYPE='D' AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
 	 //System.out.println("*************DOM**2**********"+strSql);
     }
	if (strTravelType.equals("A")){
		/*strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND ORDER_ID!=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) union "+
			" SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND	TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserid+"  AND TA.TRAVEL_TYPE='D' AND ORDER_ID!=(SELECT MIN(ORDER_ID) FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10)";*/
			strSql=" SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I'  AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE) union "+
				   " SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(DBO.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT,DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND	TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0	AND TA.APPROVER_ID="+strUserid+"  AND TA.TRAVEL_TYPE='D' AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
		// System.out.println("*************ALL**2**********"+strSql);
	}
	
	
	//start
	
	if(SuserRole!=null && SuserRole.equals("MATA") )
		{ 	 
			 if (strTravelType.equals("I")){
	strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
		//System.out.println("***********MATA**INT**2**********"+strSql);
			 }
			 if (strTravelType.equals("D")){
  	strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT,TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='D' AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)"; 
			 }
			 if (strTravelType.equals("A")){
				 
			  strSql="SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'I') AS COMMENT, TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='I' AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE) union "+
				       " SELECT DISTINCT TA.TRAVEL_TYPE,TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, DBO.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.TRAVEL_ID,'D') AS COMMENT,TD.Group_Travel_Flag,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as TRAVEL_AGENCY_ID FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+strUserid+" AND TA.TRAVEL_TYPE='D' AND  ORDER_ID!=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D' AND APPROVE_STATUS=0 AND STATUS_ID=10) and TD.TRAVEL_DATE >= CAST(DATEADD(WK,-1,GETDATE()) AS DATE)";
			 }

		}
	//end
	
	
	strColor="";
	rs = dbConBean.executeQuery(strSql);
	strFinalApprovalStatus="";
	strAttachment="0";
	strComment   ="0";
	strGroupTravelFlag	="";
	strTravelAgencyTypeId="";
	urlpage				="";
	strDetailPageUrl		="";
	if(rs.next())
	{	
		do
		{
		strTravelType			=   rs.getString(1);	
		strTravelId     		=	rs.getString(2);
		strTravellerId          =	rs.getString(3);
		strTravelRequestNo		=	rs.getString(4);
		strTraveller        	= 	rs.getString(5);	
		strOriginatorName		=	rs.getString(6);
		strOriginatedDate		=	rs.getString(7);	
		strNextApprover 		=	rs.getString(8);	
		strAttachment			=	rs.getString(9);
		strComment				=	rs.getString(10);
		strGroupTravelFlag      =   rs.getString("GROUP_TRAVEL_FLAG");
		strTravelAgencyTypeId			=	rs.getString("TRAVEL_AGENCY_ID");
		
		if(strGroupTravelFlag==null) 
				{
			strGroupTravelFlag="N";
		 	}
		          
			if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))
				{ // block for group travel 
				  urlpage ="Group_T_IntTrv_Details.jsp";
				  if (strTravelType.equals("I")){
					  
							  if(SuserRole!=null && SuserRole.equals("MATA") ){
								  strDetailPageUrl="Group_MATA_Report_INT.jsp";
							    }
							  else{
								strDetailPageUrl = "Group_T_TravelRequisitionDetails.jsp";
							   }
				  }
				  else{
					  
						  if(SuserRole!=null && SuserRole.equals("MATA") ){
							  strDetailPageUrl="Group_MATA_Report_DOM.jsp";
						    }else{
							strDetailPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
					  		}	
					 }			  
				  strTraveller="Group/Guest Travel";  

			}
			else
				{   // block for group travel 
					if (strTravelType.equals("I"))
							{
								 if(SuserRole!=null && SuserRole.equals("MATA") ){
						 		 	strDetailPageUrl="MATA_Report_INT.jsp";
						    		}
								 else{
									strDetailPageUrl = "T_TravelRequisitionDetails.jsp";
									if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
									}
						          }
				  			}
				  else{
					  		if(SuserRole!=null && SuserRole.equals("MATA") ){
				 		 			strDetailPageUrl="MATA_Report_DOM.jsp";
				    		  }
						 	else{
					  				strDetailPageUrl = "T_TravelRequisitionDetails_D.jsp";
					  				if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
									}
						 		}
				  }	
					
			}

		 if (strTravelType.equals("I")){
	    	strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'I'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'I'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_INT TD WHERE TD.TRAVEL_ID="+strTravelId ;   
	    }else{
	    	strSql="SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),ISNULL(CONVERT(decimal(20,0),TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(TA_CURRENCY,'-') AS TA_CURRENCY,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId; 
	    	} 
	    
	    //System.out.println("strSql===for to ===wer=2==="+strSql);
	    rs1 = dbConBean1.executeQuery(strSql);
		if(rs1.next())
		{
			strTravelDate       =   rs1.getString(1);
			strTravelAmount     =   rs1.getString(2);
	        strTravelCurrency   =   rs1.getString(3);

			strFrom             =   rs1.getString(4);
			strTo               =   rs1.getString(5);	
			
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

		strColor	=   "";
		if (iCls%2 == 0) { 
			strStyleCls="formtr1";
	    } else { 
			strStyleCls="formtr2";
	    } 
	    iCls++;

	%>
	    <tr valign="TOP" class="<%=strStyleCls%>">
	      <td width="3%" align="Left" bgcolor="<%=strColor%>">
	      <input class="<%=strStyleCls%>" type=checkbox name="chk<%=intSerialNo%>" value="<%=strTravelId%>;<%=strTravellerId%>;<%=strTravelType%>"></td>
	      <input class="colorpink" type=hidden name="transType<%=intSerialNo%>" value="REQS">
	      <td class="listhead" width="3%" align="Left"><%=intSerialNo1++%>
	      <a href="#" title="Comments" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=<%=strTravelType%>&whichPage=T_HandOverRequest.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strComment%></a> 
	      <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=<%=strTravelType%>&whichPage=T_HandOverRequest.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strAttachment%></a>
	          <!--<a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strAttachment%></a>-->
	      </td>

		 <%
	   //if(SuserRole!=null && SuserRole.equals("MATA") )
	   // {
	%>  
	<!--  	  <td class="listdata" width="5%" align="center">
			<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=850')"><%=strTravelRequestNo%></a> 
		  </td> -->
	<%//  }
		//else
		//{
			//System.out.println("strDetailPageUrl====="+strDetailPageUrl);
	%>	
		<td class="listdata" width="5%" align="center">
			<a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travelType=<%=strTravelType %>','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strTravelRequestNo%></a> 
			
		</td>
	<%
		//}
	%>
	      <td class="listdata" width="10%" align="center"><%=strTraveller%></td>
	      <td class="listdata" width="10%" align="center"><%=strFrom%></td>
	      <td class="listdata" width="10%" align="center"><%=strTo%></td>
	      <td class="listdata" width="10%" align="center"><%=strTravelDate%></td>
	      <td class="listdata" width="10%" align="center"><%=strTravelAmount%></td>
	      <td class="listdata" width="10%" align="center"><%=strTravelCurrency%></td>
	      <td class="listdata" width="27%" align="center">&nbsp;<%=strOriginatedDate%></td>
	      <td class="listdata" width="10%" align="center"><%=strOriginatorName%></td>
	      <td class="listdata" width="13%" align="center"><b><%=strNextApprover%></b></td> 
	    </tr>
	    <%
		intSerialNo++;
		}while(rs.next());				
	}
	else
	{
		
		if(strpageFlag.equalsIgnoreCase("t")){
		}
		else{
		if(strFlag.equalsIgnoreCase("y")){
		}
		else{
		strMsg1="<font color=red>"+dbLabelBean.getLabel("label.handover.currentlynothavependingrequisitions",strsesLanguage)+"</font>,<font color=green>"+dbLabelBean.getLabel("label.handover.outofofficemarkedsuccessfully",strsesLanguage)+"</font>";
		
		url="T_outOfOffice.jsp?travel_type="+strTravelType+"&userid="+strUserid+"&strMsg="+URLEncoder.encode(strMsg1,"UTF-8");
		 if (flage.equals("false")){
		response.sendRedirect(url);
		 }
		}
		}

	%>
	    <tr>
	      <td colspan="15" class="formtr1"><%=dbLabelBean.getLabel("label.handover.notravelrequisitionsforhandover",strsesLanguage) %></td>
	    </tr>
	    <%
	}
	rs.close();
%>

<%} %>

<!-- End Here -->

 
</table>
<br>

   
<%

int iSno=intSerialNo;

%>
<table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" class="formborder">
<input type=hidden name="count" value="<%=iSno-1%>">

<TR >
		<TD class="formhead" width="7%" align="Left"><%=dbLabelBean.getLabel("label.handover.selectsite",strsesLanguage) %></TD> 
		<TD class="formhead"  width="8%" align="Left"><%=dbLabelBean.getLabel("label.handover.selectdelegate",strsesLanguage) %></TD>
		<TD class="formhead" width="9%" align="Left" colspan="2" ><%=dbLabelBean.getLabel("label.handover.handoverremarks",strsesLanguage) %></TD>
</TR>

<tr>
<% if(SuserRole!=null &&  !SuserRole.equals("MATA") )
{ 
	%>
<td class="formhead" width="7%" align="Left" valign="top">
<select name="SelectUnit" id="SelectUnit"  class="textboxCSS" onChange="">
			<option value="-1" ><%=dbLabelBean.getLabel("label.handover.selectsite",strsesLanguage) %></option>
			<%
			strSql="SELECT  site_id, Site_name FROM  M_site WHERE (STATUS_ID = 10) order by 2";
			rs = dbConBean.executeQuery(strSql);
            while(rs.next())			
			{  
			%>
			<option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%></option>
	<% 
			}
					 
				   
	%> 
	</select>
	 <%
	      if(SuserRole.equals("AD")) {
		   %>
		    <script language="javascript">
		    
				document.frm.SelectUnit.value ="<%=Site_ID%>";
			</script>
	      <%
			}
			else{
			%>
			<script language="javascript">
				document.frm.SelectUnit.value ="<%=Site_ID%>";
			</script>
	       <%}
			%>
</td>
<td class="formhead" width="7%" align="Left" valign="top">
<Select id="delName" name="delName" class="textBoxCSS" onChange="return CheckOOO();">
			<option value=""><%=dbLabelBean.getLabel("label.handover.selectdelegate",strsesLanguage) %></option>
</select>
</td>
			

<% } %>



<% if(SuserRole!=null &&  SuserRole.equals("MATA"))
		{
	%>
<td class="formhead" width="7%" align="Left" valign="top">
	<Select name="delName" id="delName" class="textBoxCSS" onchange="return CheckOOO();">
			<option value=""><%=dbLabelBean.getLabel("label.handover.selectdelegate",strsesLanguage) %></option>
			</Select>
	</td>
	<td class="formhead"  width="7%" align="Left" valign="top">
	<Select name="delName" class="textBoxCSS">
			<option value=""><%=dbLabelBean.getLabel("label.handover.selectdelegate",strsesLanguage) %></option>
			<%
			strSql="SELECT dbo.user_name(dbo.finalooo(USERID,getdate(),'"+strTravelType+"')),USERID,.DBO.USER_NAME(USERID) FROM M_USERINFO WHERE STATUS_ID=10 AND SITE_ID='"+Site_ID+"' and userid != '" + strUserid +"' and role_id = 'MATA' ORDER BY 3";
			rs = dbConBean.executeQuery(strSql);
			while(rs.next())
			{
			%>
				<option alt="<%=rs.getString(1)%>"  value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option>
			<%
			}
			rs.close();
			%>
			</select>

		</td>
		<%	} %>
	<td class="formhead" width="7%" align="Left" colspan="2" valign="top">
<!--	<input type="text" name="handover_remarks" size="35" maxlength="500"/>-->
<TEXTAREA NAME="handover_remarks" COLS=35 ROWS=2 onkeyup="test1('handover_remarks', 500, 'txt');"></TEXTAREA>	
	</td>
</tr>

<tr class="formbottom">
	<td colspan="4">
	  <center>
	    <input type="submit" name="Submit" 	 	value="<%=dbLabelBean.getLabel("button.handover.handover",strsesLanguage) %>"  class="formbutton"  >
	    <input type="button" name="CheckAll" 	value="<%=dbLabelBean.getLabel("button.approverequest.checkall",strsesLanguage) %>"   onClick="checkAll(document.frm)" class="formbutton" >
	    <input type="button" name="UnCheckAll" 	value="<%=dbLabelBean.getLabel("button.approverequest.uncheckall",strsesLanguage) %>" onClick="uncheckAll(document.frm)" class="formbutton" > 
	    </center>
     </td>
  </tr>
  <input type="hidden" name="DelegatefromUserid" value="<%=strUserid%>" > 
    <input type="hidden" name="Travel_type" value="<%=strTravelType%>" >
    <input type="hidden" name="Travel_type_temp" value="<%=strTravelTypeTemp%>" >
    
    <input type="hidden" name="strflag" value="<%=strFlag %>"></input>
    <input type="hidden" name="strpageflag" value="<%=strpageFlag %>"></input>
</form>

</table>
<br>
<%
Connection con	=	null;			    // Object for connection
Statement stmt	=	null;			   // Object for Statement
//Create Connection

//System.out.println("Suser_id==========================================="+Suser_id);

Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
strSql="SELECT  OFFICER_ID,.DBO.USER_NAME(TRANSFER_TO),.DBO.CONVERTDATE(TRANSFER_STARTDATE),.DBO.CONVERTDATE(TRANSFER_ENDDATE),RTRIM(COMMENTS) FROM APP_REQ_JOBS_TRANSFER WHERE OFFICER_ID='"+strUserid+"'AND TRAVEL_TYPE='I'  ORDER BY 3 DESC";

 //System.out.println("strSQL-->"+strSql);
int iLoop=1;
stmt			 = con.createStatement(); 
rs				 = stmt.executeQuery(strSql);
String strRowColor="";
if(rs.next())
{
	%>

<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
  <!--
  <tr>
    <td align="center" class="formtr3" colspan=10>Hand Over History </td>
  </tr> 
  <tr class="formbottom">
    <td align="left" class="formtr1">#</td>
    <td align="left" class="formtr1">Hand Over To</td>
    <td align="left" class="formtr1">Hand Over on</td>
     <td align="left" class="formtr1">Hand Over Reason</td>
  </tr>
   -->
         
<%
do
	{
%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr1";
    } else { 
		strStyleCls="formtr2";
    } 

	  iCls++;
%>
<!-- 
<tr class="<%//=strStyleCls%>">

<td><%//=iLoop++%></td>
<td><%//=rs.getString(2)%></td>
<td><%//=rs.getString(3)%></td>
<td><%//=rs.getString(5)%></td>
</tr> -->
<%
	}
while(rs.next());

}
con.close();

//Close All Connection

dbConBean.close();
dbConBean1.close();

//System.out.println("strUserid====="+strUserid);
%>

</table>
</body>

<!-- Added By Manoj on 28 jan for Handover History -->

<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr>
<td class="formhead" width="100%" align="Left" colspan="5"><center><font size="2"><%=dbLabelBean.getLabel("label.handover.handoverhistory",strsesLanguage)%></font></center></td>
</tr>
<tr>
<td class="formhead" width="3%" align="center">#</td>
<td class="formhead" width="17%" align="center"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage)%></td>
<%--<td class="formhead" width="15%" align="center">Handover To</td> --%>
<td class="formhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.handover.handoveron",strsesLanguage)%></td>
<td class="formhead" width="65%" align="center"><%=dbLabelBean.getLabel("label.handover.handoverreason",strsesLanguage)%></td>
</tr>

<%

//added by manoj chand on 16 March 2012 to display handover history based on travel type.
strTravelType   =  (request.getParameter("travel_type")==null)?"":request.getParameter("travel_type");

if (strTravelType.equals("I")){
	strSql="SELECT TD.TRAVEL_REQ_NO,TRC.POSTED_ON,TRC.COMMENTS FROM TRAVEL_REQ_COMMENTS TRC INNER JOIN T_TRAVEL_DETAIL_INT TD ON  TD.TRAVEL_ID = TRC.TRAVEL_ID and TRAVEL_TYPE = 'I' WHERE POSTED_BY = "+strUserid+" and TRC.COMMENTS like '%HANDOVER%' order by TD.TRAVEL_REQ_NO, TRC.POSTED_ON";
}else if(strTravelType.equals("D")){
	strSql="SELECT TD.TRAVEL_REQ_NO,TRC.POSTED_ON,TRC.COMMENTS FROM TRAVEL_REQ_COMMENTS TRC INNER JOIN T_TRAVEL_DETAIL_DOM TD ON  TD.TRAVEL_ID = TRC.TRAVEL_ID and TRAVEL_TYPE = 'D' WHERE POSTED_BY = "+strUserid+" and TRC.COMMENTS like '%HANDOVER%' order by TD.TRAVEL_REQ_NO, TRC.POSTED_ON";
}else{
	strSql="SELECT TD.TRAVEL_REQ_NO,TRC.POSTED_ON,TRC.COMMENTS FROM TRAVEL_REQ_COMMENTS TRC INNER JOIN T_TRAVEL_DETAIL_INT TD ON  TD.TRAVEL_ID = TRC.TRAVEL_ID and TRAVEL_TYPE = 'I' WHERE POSTED_BY = "+strUserid+" and TRC.COMMENTS like '%HANDOVER%' UNION SELECT TD.TRAVEL_REQ_NO,TRC.POSTED_ON,TRC.COMMENTS FROM TRAVEL_REQ_COMMENTS TRC INNER JOIN T_TRAVEL_DETAIL_DOM TD ON  TD.TRAVEL_ID = TRC.TRAVEL_ID and TRAVEL_TYPE = 'D' WHERE POSTED_BY = "+strUserid+" and TRC.COMMENTS like '%HANDOVER%' order by TD.TRAVEL_REQ_NO, TRC.POSTED_ON";
}

int strint=1;
rs2 = dbConBean2.executeQuery(strSql);
if(rs2.next()){
	do{
		strReqno=rs2.getString(1);	
		//strHandoverTo=rs2.getString(2);	
		strHandoverOn=rs2.getString(2);	
		strHandoverReason=rs2.getString(3);
		if (iCls%2 == 0) { 
			strStyleCls="formtr2";
	    } else { 
			strStyleCls="formtr1";
	    } 
	    iCls++;
%>	
<tr valign="TOP" class="<%=strStyleCls%>">
<td class="listdata" width="3%" align="Left"><%=strint %></td>
<td class="listdata" width="17%" align="Left"><%=strReqno%></td>
<%--<td class="listdata" width="15%" align="Left"><%=strHandoverTo%></td> --%>
<td class="listdata" width="15%" align="Left"><%=strHandoverOn%></td>
<td class="listdata" width="65%" align="Left"><%=strHandoverReason%></td>
</tr> 
<%
strint++;
	}while(rs2.next());
}else{%>
	<tr>
	<td colspan="5" height="2px" class="formtr2"><%=dbLabelBean.getLabel("label.handover.nohistoryforhandover",strsesLanguage)%></td>
	</tr>
<%}




rs2.close();
dbConBean2.close();
%>

</table>

</HTML>