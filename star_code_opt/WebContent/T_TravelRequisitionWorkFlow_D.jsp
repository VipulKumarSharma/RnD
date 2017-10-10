<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:ABHINAV RATNAWAT
 *Date of Creation 		:05 SEPTEMBER 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for approve the Travel Requisition in the STAR Database
 *Modification 			: added code for show traveller name as group travel  in case of group travel on 02-Jul-08 by shiv sharna   
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:10 feb 2011
 *Modification			:increases the size of search page.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:30 June 2011
 *Modification			:Implementing from date and to date selection to show records and
 						 Adding Export to Excel tab in check requistion status.
 						 
 *Modified By	        :MANOJ CHAND
 *Date of Modification  :12 Feb 2013
 *Description			:IE Compatibility Issue resolved.
 *******************************************************/
%>

<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8" %>
<%@ page import = "src.connection.DbConnectionBean" %>
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

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
<script type="text/javascript">
function showData(){
	var fromval=document.getElementById("from").value;
	var toval=document.getElementById("to").value;
	var checkval=document.getElementById("chkData").value;
	
	if(checkval=='2')
		{
				if(fromval=='')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate",strsesLanguage) %>');
				document.frm.from.focus();
				return false;
				}
		
				if(toval=='')
				{
				alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttilldate",strsesLanguage) %>');
				document.frm.to.focus();
				return false;
				}
				openWaitingProcess();
		}
	else if(checkval=='1')
		{
				if(confirm('<%=dbLabelBean.getLabel("label.report.youhaveoptedviewallrequisitionstaketime",strsesLanguage) %>'))
				{
					openWaitingProcess();
					return true;
				}
				else
				{
					return false;
				}
		}
}

function blankTextBox(fromdate,todate){
	var checkval=document.getElementById("chkData").value;
	if(checkval==1){
		document.frm.from.value='';
		document.frm.to.value='';
		document.frm.from.disabled=true;
		document.frm.to.disabled=true;
		document.getElementById("datepickfrom").href='#';
		document.getElementById("datepickto").href='#';
	}else{
		document.frm.from.value=fromdate;
		document.frm.to.value=todate;
		document.frm.from.disabled=false;
		document.frm.to.disabled=false;
		document.getElementById("datepickfrom").href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY')";
		document.getElementById("datepickto").href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY')";
	}
}

//added by manoj chand on 01 july 2011 to implement export to excel 
function write1(loadflag)
{
	var info='';
	var checkflag=document.getElementById("chkData").value;
	if(checkflag!=1){
		info='<font size=2>'+'<%=dbLabelBean.getLabel("label.checkstatus.domesticrequisitionsfrom",strsesLanguage)%>'+ '<b>'+ document.frm.from.value +'</b>'+'<%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%>' +'<b>'+ document.frm.to.value+'</b></font>';
	}else{
		info='<b>'+'<%=dbLabelBean.getLabel("label.checkstatus.alldomesticrequisitions",strsesLanguage)%>'+'</b>';
	}

	var txt='';	
	if(loadflag==2){
	txt= "<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms.excel; charset=UTF-8\"><table border=1>"+info+ document.getElementById("main").innerHTML+"</table>";
	document.frm.va.value='';
	document.frm.va.value=txt;
	document.frm.action="issue_exlWrite.jsp";
	document.frm.submit();
	}else
		alert('<%=dbLabelBean.getLabel("alert.report.nodataforexporttoexcel",strsesLanguage) %>');
}

function closeDivRequest()
{
	document.getElementById("waitingData").style.visibility="hidden";	
}

//added by manoj chand on 04 july 2011 to show processing image

function openWaitingProcess()
{
		var dv = document.getElementById("waitingData");
		if(dv != null)
		{
			var xpos = screen.availHeight/2+90;
			var ypos = screen.availWidth/2-350;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos+10)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
}


function childwindowSubmit(){
	document.frm.action='T_TravelRequisitionWorkFlow_D.jsp';
	document.frm.submit();
}

//function created by manoj chand on 01-oct-2013 to call erp or mata can cancel request web service
function fun_callwebservice(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
	openWaitingProcess();
 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancancelrequest&travel_id='+travelid+'&site_id='+siteid;
    var urlParams=Params;
	$.ajax({
            type: "post",
            url: "CancelTrip",
            data: urlParams,
            success: function(result){
			var res = jQuery.trim(result);
			if(res == 'yes'){
				if(confirm('<%=dbLabelBean.getLabel("alert.search.areyousure",strsesLanguage)%>')){
					var finalresult = fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype);
					if(finalresult == 'TT'){
						alert('<%=dbLabelBean.getLabel("alert.search.requesthasbeencancelled",strsesLanguage)%>');
						top.main_11.frm.submit();
					}else if(finalresult == 'Error'){
						alert('Error!');
					}else{
						alert(finalresult);
					}
				}
			}else{
				alert(res);
			}
        },
        complete: function(){
        	closeDivRequest();
        	},
		error: function(){
			alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
        }
      });
}		
//function created by manoj chand on 01-oct-2013 to call erp or mata cancel request web service 
function fun_callwebservice1(erpwsurl,matawsurl,cid,reqno,travelid,siteid,traveltype){
	openWaitingProcess();
	var flag = '';
 	var Params='requestnumber='+reqno+'&erpurl='+erpwsurl+'&mataurl='+matawsurl+'&cid='+cid+'&actionflag=cancelrequest&travel_id='+travelid+'&site_id='+siteid+'&travel_type='+traveltype;
    var urlParams=Params;
	$.ajax({
            type: "post",
            url: "CancelTrip",
            data: urlParams,
            async: false,
            success: function(result){
			var res = jQuery.trim(result);
			flag = res;
        },
        complete: function(){
        	closeDivRequest();
        	},
		error: function(){
			alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
        }
      });
    return flag;
}

</script>


<%
// Variables declared and initialized

String strTravelType      =  "";
String strTravelTypeFlag  =  "";
strTravelType   =  request.getParameter("travel_type");
String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");

if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelTypeFlag = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelTypeFlag = "D";
}

Connection con	=	null;			    // Object for connection
Statement stmt	=	null;			   // Object for Statement
ResultSet rs,rs1	=	null;			  // Object for ResultSet
//Create Connection
//Class.forName(Sdbdriver);
//con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

//added by manoj on 06 july 2011 to scroll resultset
con=dbConBean.getConnection();
stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

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
String strTravelCurrency     ="";
String strWorkflowStatus    = "";
String strImagePrint			=	"";


String	strSiteName			=  "";
String	strDivName			=  "";
int iCls				    =  0;
String strStyleCls			=  "";
String strTitle				=  "";
//added by manoj
String loadFlag=request.getParameter("flag")==null?"":request.getParameter("flag");
String strFromDate=request.getParameter("from")==null?"":request.getParameter("from");
String strToDate=request.getParameter("to")==null?"":request.getParameter("to");
String strCheckType=request.getParameter("chkData")==null?"2":request.getParameter("chkData");

String  stroldDate="";
strSql="SELECT  convert(varchar(20),getdate()-30,103) as date"; 
rs = dbConBean.executeQuery(strSql); 
while (rs.next())
    {
	stroldDate=rs.getString(1); 
     }
 rs.close();

SimpleDateFormat sdf=  new java.text.SimpleDateFormat("dd/MM/yyyy");
String strCurrDate= sdf.format(new java.util.Date());

/*System.out.println("stroldDate--->"+stroldDate);
System.out.println("strCurrDate--->"+strCurrDate);
System.out.println("loadFlag--->"+loadFlag);*/
%>


</HEAD>

<body onfocus="MM_winParentDisable();" onclick="MM_winParentDisable();">

<div id="waitingData" style="display:none;"> 	  
	    
	 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 	<br>      
	 	<font color="#000080" class="pageHead"><center><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%> </center></font>    
	</div>

<script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
	<% if(ssflage.equals("3")){%>
      <li class="pageHead"> <%=dbLabelBean.getLabel("label.checkstatus.domesticeuropetravelrequisitionworkflow",strsesLanguage)%></li>
      <%}else{ %>
      <li class="pageHead"> <%=dbLabelBean.getLabel("label.checkstatus.domestictravelrequisitionworkflow",strsesLanguage)%></li>
      <%} %>
    </ul></td>
     <td height="40" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
    <tr align="right">
    <td>
     <ul id="list-nav">
     <li><a href="#" onClick="MM_openBrWindow('T_searchTravelRequisitions.jsp?travel_type=<%=strTravelTypeFlag%>','SEARCH','scrollbars=yes,resizable=yes,top=110,left=0,width=1017,height=565');"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage) %></a></li>
      <li><a href="#" onClick="write1('<%=loadFlag %>');"><%=dbLabelBean.getLabel("label.report.exporttoexcel",strsesLanguage) %></a></li>
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
     </ul>
       </td>
       </tr>
	</table>
	 </td>
  </tr>
</table>


<form method=post name=frm action="T_TravelRequisitionWorkFlow_D.jsp" style="display: inline; margin: 0; " onsubmit="return showData();">
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder" >

<input type="hidden" name="flag" value="2">
<input type="hidden" name="va">
   <tr> 
     <td class="formhead" width="8%" align="Left" colspan="14"><span class="formTit"><%=dbLabelBean.getLabel("label.report.selectpreference",strsesLanguage) %></span></td>
   </tr>
   <tr> 
     <td class="formtr3" align=center colspan="14">
	   <select name="chkData" id="chkData"  class="textboxCSS" onchange="blankTextBox('<%=stroldDate %>','<%=strCurrDate %>');">
 	     <option value="1"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
	     <option value="2" selected><%=dbLabelBean.getLabel("label.report.selectedperiod",strsesLanguage) %></option>
	   </select>
	   <%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %> <input type="text" name="from" id="from" size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=stroldDate %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
        <a id="datepickfrom" href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
        <%=dbLabelBean.getLabel("label.report.till",strsesLanguage) %> <input type="text" name="to" id="to"  size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="<%=strCurrDate %>" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >        <a id="datepickto" href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a>
       &nbsp;&nbsp;<input type=submit name="Gobutton" value=" <%=dbLabelBean.getLabel("button.search.go",strsesLanguage) %> " class=formbutton onclick="document.frm.action='T_TravelRequisitionWorkFlow_D.jsp';">
       
       <%if(loadFlag.equalsIgnoreCase("2"))
    	   {%> 
        <script type="text/javascript">
	        document.getElementById("chkData").value='<%=strCheckType%>';
	        document.getElementById("from").value='<%=strFromDate%>';
	        document.getElementById("to").value='<%=strToDate%>';
        </script>
        <%} %>
        
         <% if(strCheckType.equalsIgnoreCase("1")){%>
		<script type="text/javascript">
			document.frm.from.disabled=true;
			document.frm.to.disabled=true;
			document.getElementById("datepickfrom").href='#';
			document.getElementById("datepickto").href='#';
		</script>	
		<%} %>
        
        
        
     </td>
   </tr>

<%
if(loadFlag.equals("2"))
{
%>
<span id="main"> 
  <tr class="formhead"> 
	<td class="listhead" width="3%" align="center">#</td>	
 	<td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage)%> </td>
    <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>

	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)%></td>
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%></td>
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%> </td>
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage)%></td>

	
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
	<td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage)%></td>
	<td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.checkstatus.nowwith",strsesLanguage)%></td>	
	<td class="listhead" width="19%" align="center"><%=dbLabelBean.getLabel("label.checkstatus.workflowstatus",strsesLanguage)%></td>	
	<td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
  </tr>
     

<%
String strItems        =  "";
String strNewReqNo     =  "";
String strGroupTravelFlag="";

String strDetailPageUrl  ="";



if(strCheckType.equalsIgnoreCase("1"))
{
	//query for finding requistion status 
	strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH,ISNULL(RTRIM(.DBO.WORKFLOWSTATUS(TD.TRAVEL_ID,'D')),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.travel_id,'D') AS COMMENT,TD.GROUP_TRAVEL_FLAG,"
			+" ISNULL(CASE WHEN TS.TRAVEL_STATUS_ID=10 AND TS.TES_FLAG='N' AND DATEDIFF(DD,TD.TRAVEL_DATE,GETDATE())>0 AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null)  THEN  CM.CID ELSE 0 END,0) AS CID, ISNULL(CASE WHEN TS.TRAVEL_STATUS_ID=10 AND TS.TES_FLAG='N' AND DATEDIFF(DD,TD.TRAVEL_DATE,GETDATE())>0 AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null) THEN  CM.ERP_WS_URL ELSE '' END,'') AS ERP_WS_URL, ISNULL(CASE WHEN TS.TRAVEL_STATUS_ID=10 AND TS.TES_FLAG='N' AND DATEDIFF(DD,TD.TRAVEL_DATE,GETDATE())>0 AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null)  THEN  CM.MATA_WS_URL ELSE '' END,'') AS MATA_WS_URL, TD.SITE_ID AS SITE_ID, SM.TRAVEL_AGENCY_ID"
			+" FROM T_APPROVERS TA INNER JOIN T_TRAVEL_STATUS TS ON TA.TRAVEL_ID=TS.TRAVEL_ID INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TD.TRAVEL_ID=TS.TRAVEL_ID INNER JOIN M_SITE SM ON SM.SITE_ID=TD.SITE_ID LEFT OUTER JOIN M_COMPANY CM ON SM.COMPANY_ID=CM.CID WHERE TS.TRAVEL_STATUS_ID !=1 AND TS.TRAVEL_TYPE='D' AND TA.TRAVEL_TYPE='D' AND  TD.C_USERID  = "+Suser_id+" AND TD.STATUS_ID=10 AND TS.STATUS_ID=10";
}else{
	strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.PRESENTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH,ISNULL(RTRIM(.DBO.WORKFLOWSTATUS(TD.TRAVEL_ID,'D')),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT, DBO.TRAVEL_COMMENT(TD.travel_id,'D') AS COMMENT,TD.GROUP_TRAVEL_FLAG,"
			+" ISNULL(CASE WHEN TS.TRAVEL_STATUS_ID=10 AND TS.TES_FLAG='N' AND DATEDIFF(DD,TD.TRAVEL_DATE,GETDATE())>0 AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null)  THEN  CM.CID ELSE 0 END,0) AS CID, ISNULL(CASE WHEN TS.TRAVEL_STATUS_ID=10 AND TS.TES_FLAG='N' AND DATEDIFF(DD,TD.TRAVEL_DATE,GETDATE())>0 AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null) THEN  CM.ERP_WS_URL ELSE '' END,'') AS ERP_WS_URL, ISNULL(CASE WHEN TS.TRAVEL_STATUS_ID=10 AND TS.TES_FLAG='N' AND DATEDIFF(DD,TD.TRAVEL_DATE,GETDATE())>0 AND (CM.ERP_WS_URL<>'' AND CM.ERP_WS_URL <>'temp' and cm.ERP_WS_URL is not null)  THEN  CM.MATA_WS_URL ELSE '' END,'') AS MATA_WS_URL, TD.SITE_ID AS SITE_ID, SM.TRAVEL_AGENCY_ID"
			+" FROM T_APPROVERS TA INNER JOIN T_TRAVEL_STATUS TS ON TA.TRAVEL_ID=TS.TRAVEL_ID INNER JOIN T_TRAVEL_DETAIL_DOM TD ON TD.TRAVEL_ID=TS.TRAVEL_ID INNER JOIN M_SITE SM ON SM.SITE_ID=TD.SITE_ID LEFT OUTER JOIN M_COMPANY CM ON SM.COMPANY_ID=CM.CID WHERE TS.TRAVEL_STATUS_ID !=1 AND TS.TRAVEL_TYPE='D' AND TA.TRAVEL_TYPE='D' AND  TD.C_USERID  = "+Suser_id+" AND TD.STATUS_ID=10 AND TS.STATUS_ID=10 AND convert(varchar(10), TA.C_DATETIME, 20) BETWEEN convert(varchar(10),  convert(datetime, '"+strFromDate+"',103), 20)  AND convert(varchar(10), convert(datetime, '"+strToDate+"',103), 20)";
}
//System.out.println("strSql--------D---->"+strSql);

String strColor="";
//rs = dbConBean.executeQuery(strSql);
//added by manoj on 06 july to 2011 to scroll resultset
rs =stmt.executeQuery(strSql);

String strFinalApprovalStatus="";
String strAttachment="0";
String strComments = "0";
String strERPWS_URL = "";
String strMATAWS_URL="";
String strCID="";
String strSiteId="";
String strTravelAgencyTypeId = ""; 

if(!rs.next()){
%>
<tr>
<td colspan="13" class="formtr3"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage)%></td>
</tr>
<%	}
rs.beforeFirst();
while(rs.next())
{
	strTravelId     		=	rs.getString(1);
	strTravellerId          =	rs.getString(2);
	strTravelRequestNo		=	rs.getString(3);
	strTraveller        	= 	rs.getString(4);	
	strOriginatorName		=	rs.getString(5);
	strOriginatedDate		=	rs.getString(6);	
	strNextApprover 		=	rs.getString(7);	
	strWorkflowStatus		= 	rs.getString(8);
	strAttachment			=	rs.getString(9);
	strComments             =	rs.getString(10);   

	 //added code for show traveller name as group travel  in case of group travel on 02-Jul-08 by shiv sharna   
			strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
			strTravelAgencyTypeId	 =	rs.getString("travel_agency_id");
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
									strTraveller="Group/Guest Travel ";
									//strPageUrl = "Group_T_TravelRequisitionDetails.jsp";
									strDetailPageUrl="Group_T_TravelRequisitionDetails_D.jsp";
									 if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										 strDetailPageUrl = "Group_T_TravelRequisitionDetails_GmbH.jsp";
										 strTraveller="Guest Travel ";
									}
  							    }
								else {
									strDetailPageUrl = "T_TravelRequisitionDetails_D.jsp";
									if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										strDetailPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
									}
								}
	
	strCID = rs.getString("CID");
	strERPWS_URL = rs.getString("ERP_WS_URL");
	strMATAWS_URL= rs.getString("MATA_WS_URL");	
	strSiteId = rs.getString("SITE_ID");

    strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),TOTAL_AMOUNT, TA_CURRENCY,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;   
	//System.out.println("strSql is=="+strSql);
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString(2);
		strTravelCurrency	=	rs1.getString(3);
		strFrom             =   rs1.getString(4);
		strTo               =   rs1.getString(5);	
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
	
	if(strComments.equals("0"))
	{
		strImagePrint="";
	}
	else
	{
		strImagePrint="<img src=images/group1.gif border=0>";
	}
%>

<%
	strColor                =   "";
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 
    iCls++;

%>

  <tr VALIGN="TOP" class="<%=strStyleCls%>"> 
    <td class="listhead" width="3%" align="Left"><%=++intSerialNo%><br> <a href="#" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_TravelRequisitionWorkFlow_D.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a> <a href="#" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_TravelRequisitionWorkFlow_D.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')"><%=strAttachment%></a> </td>	
   <td class="listdata" width="9%" align="center"><a href="#" onClick="MM_openBrWindow('<%=strDetailPageUrl%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travel_type=<%=strTravelTypeFlag%>&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=975,height=600')"><%=strTravelRequestNo%></a> </td>
    <td class="listdata" width="10%" align="center"><%=strTraveller%></td>
    <td class="listdata" width="6%" align="center"><%=strFrom%></td>
    <td class="listdata" width="6%" align="center"><%=strTo%></td>
    <td class="listdata" width="6%" align="center"><%=strTravelDate%></td>
    <td class="listdata" width="6%" align="center"><%=strTravelAmount%> / <%= strTravelCurrency %></td>
   <!--<td class="listdata" width="5%" align="center"><%//=strDivName%>&nbsp;<b>/</b>&nbsp;<%//=strSiteName%></td>-->
	<!-- <td class="listdata" width="12%" align="Left">&nbsp;<//%=strTitle%></td>-->
    <td class="listdata" width="7%" align="center">&nbsp;<%=strOriginatedDate%></td>
	<td class="listdata" width="7%" align="center"><%=strOriginatorName%></td>
	<td class="listdata" width="7%" align="center"><B><%=strNextApprover%></B></td>
    	<td class="listdata" width="12%" align="center"><a href="#" onClick="MM_openBrWindow('T_TravelRequisitionWorkFlowDiagram.jsp?travelRequisitionId=<%=strTravelId%>&strTravellerId=<%=strTravellerId%>&strTravelRequestNo=<%=strTravelRequestNo%>&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=775,height=250')" ><%=strWorkflowStatus%></a></td>
    <td class="listhead" width="21%" align="center" nowrap="nowrap">
      <a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=D&whichPage=T_TravelRequisitionWorkFlow_D.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=875,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage)%></a> |<br>
 		<a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=D&whichPage=T_TravelRequisitionWorkFlow_D.jsp&targetFrame=yes','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%>"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a>
 		<%
	if((strERPWS_URL!=null && !strERPWS_URL.equals("")) && (strMATAWS_URL!=null && !strMATAWS_URL.equals(""))){
	%>
	|<br><a href="#" onClick="fun_callwebservice('<%=strERPWS_URL %>','<%=strMATAWS_URL %>','<%=strCID %>','<%=strTravelRequestNo %>','<%=strTravelId %>','<%=strSiteId %>','D')">Cancel</a>
	<%}%>
</td>
  </tr>
<%
}
rs.close();
dbConBean.close();
}
%>
 </span>
   <tr align="center" class="formbottom"> 
    <td class="listhead" colspan="12" align="Left"><center>&nbsp;
	</center></td>
  </tr> 
  <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr> 
</table>
<input type=hidden name=count value="<%=intSerialNo-1%>">
<input type="hidden" name=travel_type value="<%=strTravelType%>"/>
</form>

<script language="javaScript">
		closeDivRequest();
	
	</script>

<br>
</body>
</HTML>
