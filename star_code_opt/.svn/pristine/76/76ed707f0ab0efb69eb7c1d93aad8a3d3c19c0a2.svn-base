<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Abhinav Ratnawat
 *Date of Creation 		:31 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for show the approved Travel Requisition in the STAR Database
 *Modification 			: 1. Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on  02-Jul-08
						  2. Changes the  Query for faster response bby shiv sharma on 01/10/2008	
						   	
 *Reason of Modification:  
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified by			:Manoj Chand
 *Date of Modification	:19 Dec 2011
 *Modification			:add function childwindowSubmit() to remove scripting error coming on close button of add comment screen.
 *******************************************************/
%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
<!--  errorPage="error.jsp"  -->
<HTML>
<HEAD>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<script language=JavaScript >

function checkForm()
{

var a= document.frm.chkData.value;
if(document.frm.chkData.value=='2')
{
		if((document.frm.from.value)=='')
		{
		alert('<%=dbLabelBean.getLabel("alert.report.pleaseselectfromdate",strsesLanguage) %>');
		document.frm.from.focus();
		return false;
		}

		if((document.frm.to.value)=='')
		{
		alert('<%=dbLabelBean.getLabel("alert.report.pleaseselecttilldate",strsesLanguage) %>');
		document.frm.to.focus();
		return false;
		}
		openWaitingProcess();
}
else if(document.frm.chkData.value=='1')

	{
			if(confirm('<%=dbLabelBean.getLabel("label.report.youhaveoptedviewallrequisitionstaketime",strsesLanguage) %>'))
			{
				openWaitingProcess();
				//document.frm.submit();
				return true;
			}
			else
			{
				return false;
			}
	}
}
</script>
<SCRIPT>
function MM_openBrWin(theURL,winName,features)
 { 
		   window.open(theURL,winName,features);
 }

//funtion added by manoj chand on 19 dec 2011 to remove scripting error coming on close button of add comments screen.
function childwindowSubmit(){
	
}

//function added by manoj chand on 06 june 2012
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

//ADDED BY MANOJ CHAND ON 25 JUNE 2012 TO SHOW AND CLOSE PROGRESS IMAGE
function closeDivRequest()
{
	document.getElementById("waitingData").style.visibility="hidden";	
}


//added by manoj on 25 JUNE 2012 to show processing image
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

</SCRIPT>
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<script language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></script>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
</head>
<%
// Variables declared and initialized

String strTravelType   =  "";
strTravelType   =  request.getParameter("travel_type"); 
String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");
//System.out.println("000000000000000====="+strTravelType);

String strUserId=null;
ResultSet rs,rs1	=	null;			  // Object for ResultSet

String	strSql				=  ""; // For sql Statements
String	strTravelId	    	=  "";
String	strTravelRequestNo 	=  "";
String  strTraveller        =  "";
String  strTravelDate       =  "";
String	strTravelTo         =  "";
String	strTravelFrom       =  ""; 
String  strTravelAmount     =  "";



String	strOriginatorName	=  "";
String	strOriginatedDate 	=  "";
String	strPresentApprover 	=  "";

String	strTravellerId   	=  "";

String	strSiteName			=  "";
String  strAttachment		=  "";
String  strWorkFlowStatus   =  "";

int loadFlag=Integer.parseInt(request.getParameter("flag"));
if(loadFlag==1)
{
	strUserId="99999";
}
else
{
	strUserId=Suser_id;
}
int intSerialNo             =   1;
String	sSqlStr             =   ""; // For sql Statements
String	strRequisitionId	=	"";
String	strRequisitionNo	=	"";
String	strApproverName		=	"";
String	strJustification	=	"";
int	intApproveStatus    	=	0;
String	strOrderId       	=	"";
int iCls                    =   0;
String strStyleCls          =   "";
int flag                    =   0;
String strImage             =   "";
int count                   =   0;

//added by manoj chand on 06 june 2012 to show default date in date range
String  stroldDate="";
String strFromDate=request.getParameter("from")==null?"":request.getParameter("from");
String strToDate=request.getParameter("to")==null?"":request.getParameter("to");
String strCheckType=request.getParameter("chkData")==null?"2":request.getParameter("chkData");

strSql="SELECT  convert(varchar(20),getdate()-30,103) as date"; 
rs = dbConBean.executeQuery(strSql); 
if (rs.next())
    {
	stroldDate=rs.getString(1); 
     }
 rs.close();
 
 SimpleDateFormat sdf=  new java.text.SimpleDateFormat("dd/MM/yyyy");
 String strCurrDate= sdf.format(new java.util.Date());
 
 rs=null;
%>
<body>

<div id="waitingData" style="display:none;"> 	  
	    
	 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 	<br>      
	 	<font color="#000080" class="pageHead"><center><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%> </center></font>    
	</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
	<% if(ssflage.equals("3")){%>
      <li class="pageHead"> <b><%=dbLabelBean.getLabel("label.approverequest.domesticeuroperequisitionsreturnedbyme",strsesLanguage)%></b></li>
      <%}else{ %>
       <li class="pageHead"> <b><%=dbLabelBean.getLabel("label.approverequest.domesticrequisitionsreturnedbyme",strsesLanguage)%></b></li>
       <%} %>
    </ul></td>
	<td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
        <td align="right" >
      <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
      </ul>
      </td>
      </tr>
    </table>
	</td>
  </tr>
</table>

<table width="100%" align="center" border="0" cellpadding="5" cellspacing="0"  class="formborder">  
 <form method=post name=frm action="T_MyReturns_D.jsp" onSubmit="return checkForm();">
   <input type="hidden" name="flag" value="2">
   <tr> 
     <td class="formhead" width="70%" align="Left"><span class="formTit"><%=dbLabelBean.getLabel("label.report.selectpreference",strsesLanguage) %></span></td>
     <td class="formhead" width="30%" align="center"><img src="images/help.gif?buildstamp=2_0_0" width="44" height="16" border="0" onClick="MM_openBrWin('help_ReturnedBy Me.html#300a','','scrollbars=yes,resizable=yes,width=700,height=300')"></td>
   </tr>
   <tr> 
     <td class="formtr3" align=center colspan="2">
	   <select name="chkData" id="chkData" class="textboxCSS" onchange="blankTextBox('<%=stroldDate %>','<%=strCurrDate %>');">
 	     <option value="1"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
	     <option value="2" selected><%=dbLabelBean.getLabel("label.report.selectedperiod",strsesLanguage) %></option>
	   </select>
	   <%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %>       <input type="text" name="from" value="<%=stroldDate %>" size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
        <a id="datepickfrom" href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> 
        </a>		<%=dbLabelBean.getLabel("label.report.till",strsesLanguage) %>   <input type="text" name="to" value="<%=strCurrDate %>"  size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >        <a id="datepickto" href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> <input type=submit name="submit" value="<%=dbLabelBean.getLabel("label.report.generatereport",strsesLanguage) %>" class=formbutton>
     
        <%
     if(loadFlag==2){
     
     %> 
        
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
<input type="hidden" name=travel_type value="<%=strTravelType%>"/>
 </form>
</table>
<br>
<%
if(loadFlag!=1)
{
%>
 <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
   <tr class="formhead"> 
      <td class="listhead" width="8%" align="center">#</td>
      <td class="listhead" width="13%" align="center"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage)%></td>
      <td class="listhead" width="15%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage)%></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage)%></td>
	  <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage)%></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%></td><!-- 2/26/2007 -->
	  <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage)%></td>
	  <td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage)%></td>
      <td class="listhead" width="14%" align="center"><%=dbLabelBean.getLabel("label.checkstatus.workflowstatus",strsesLanguage)%></td>
      <td width="10%" class="listhead" align="center"><%=dbLabelBean.getLabel("label.checkstatus.nowwith",strsesLanguage)%></td>
      <td class="listhead" width="20%" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
   </tr>
   
<%
   String strApproverRole               =   "";      //For getting the approver role
   String strTravelComments       	    =	"";
   String strImagePrint		         	=	"";
   String strCheck                      =   request.getParameter("chkData");  //fetch the value of selected option 1 for all and 2 for                                                                               selected period

   String strGroupTravelFlag  ="";
   String strTravelAgencyTypeId  ="";
   String strPageUrl ="";


//Query for Finding the role of approver
strSql  = "SELECT DISTINCT TA.ROLE FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='D'  AND   TA.TRAVEL_TYPE='D'  AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND TS.TRAVEL_STATUS_ID=2 ";
rs = dbConBean.executeQuery(strSql);         //get the result set
if(rs.next())
{
    strApproverRole = rs.getString(1);
}
rs.close();

  if(strCheck.equals("1"))
  {    
	 /*if(strApproverRole!=null && strApproverRole.equals("CHAIRMAN"))
     {*/
       sSqlStr=   "SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,  TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATETIME, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,dbo.TRAVEL_COMMENT(TA.TRAVEL_ID,'D')AS TRAVEL_COMMENT,TD.GROUP_TRAVEL_FLAG as GROUP_TRAVEL_FLAG FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=3 AND TS.TRAVEL_TYPE='D' AND  TA.TRAVEL_TYPE='D'  AND TA.APPROVE_STATUS=3 AND TA.APPROVER_ID='"+Suser_id+"' AND TS.TRAVEL_STATUS_ID=3";
	 /*
		 }
	 else
	 {
		 sSqlStr=   "SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,  TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATETIME, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,dbo.TRAVEL_COMMENT(TA.TRAVEL_ID,'D')AS TRAVEL_COMMENT FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=3 AND TS.TRAVEL_TYPE='D' AND  TA.TRAVEL_TYPE='D'  AND TA.APPROVE_STATUS=3 AND TA.APPROVER_ID='"+Suser_id+"'  AND TA.SITE_ID="+strSiteIdSS ;
	 }*/
	
   //out.println("sql is==="+sSqlStr); 	   
 }
 else
 {
	String strFrom   =  request.getParameter("from");
	String strTo     =  request.getParameter("to");
	
	/*if(strApproverRole!=null && strApproverRole.equals("CHAIRMAN"))
    {*/
	  sSqlStr          =  "SET DATEFORMAT DMY SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,  TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATETIME, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,dbo.TRAVEL_COMMENT(TA.TRAVEL_ID,'D')AS TRAVEL_COMMENT,TD.GROUP_TRAVEL_FLAG as GROUP_TRAVEL_FLAG, (select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=3 AND TS.TRAVEL_TYPE='D' AND  TA.TRAVEL_TYPE='D'  AND TA.APPROVE_STATUS=3 AND TA.APPROVER_ID='"+Suser_id+"' AND CAST(FLOOR(CAST(APPROVE_DATE AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"'";
	/*}
	else
	{
       sSqlStr          =  "SET DATEFORMAT DMY SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,  TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATETIME, ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,dbo.TRAVEL_COMMENT(TA.TRAVEL_ID,'D')AS TRAVEL_COMMENT FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=3 AND TS.TRAVEL_TYPE='D' AND  TA.TRAVEL_TYPE='D'  AND TA.APPROVE_STATUS=3 AND TA.APPROVER_ID='"+Suser_id+"' AND TA.SITE_ID="+strSiteIdSS+" AND CAST(FLOOR(CAST(APPROVE_DATE AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"'";
	}*/	
 }
// stmt                           = con.createStatement(); 
 rs                             = dbConBean.executeQuery(sSqlStr);
 String strFinalApprovalStatus  = "";
 String strDivName              = "";
 while(rs.next())
 {
    strTravelId     		=	rs.getString(1);
	strTravellerId         	= 	rs.getString(2);
	strTravelRequestNo		=	rs.getString(3);
	strTraveller            =	rs.getString(4);
	
	strOriginatedDate		=	rs.getString(5);	
	strOriginatorName		=	rs.getString(6);
	strTravelComments    	=	rs.getString(7);
	//strSiteName           =   rs.getString(6);  

	 //  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on 02-Jul-08 ;  

				      strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
				      strTravelAgencyTypeId			=	rs.getString("travel_agency_id");
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
									strTraveller="Group/Guest Travel ";  
									strPageUrl = "Group_T_TravelRequisitionDetails_D.jsp";
									if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										strPageUrl="Group_T_TravelRequisitionDetails_GmbH.jsp";
										strTraveller="Guest Travel ";  
									}
  							    }
								else
	                                  {
										strPageUrl = "T_TravelRequisitionDetails_D.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											strPageUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
										}

								}
	//============================close   




	
	//Query for getting the Travel Date, Travel To and Travel From
	strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),TOTAL_AMOUNT,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'D'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'D'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_DOM TD WHERE TD.TRAVEL_ID="+strTravelId ;   
	//System.out.println("strSql is=="+strSql);
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString(2);
		strTravelFrom       =   rs1.getString(3);
		strTravelTo         =   rs1.getString(4);			
	}
	rs1.close();

	//sSqlStr   =  "SELECT DISTINCT ISNULL(dbo.TRAVEL_FINAL_APPROVAL_STATUS('"+strTravelId+"','D','"+strTravellerId+"'),'NA') AS WORK_FLOW_STATUS, ISNULL(RTRIM(dbo.PRESENTAPPROVER('"+strTravelId+"','D','"+strTravellerId+"')),'NA') AS PRESENTWITH FROM T_TRAVEL_DETAIL_DOM";
	// Changes the  Query for faster response bby shiv sharma on 01/10/2008

	sSqlStr   ="SELECT  CASE WHEN COUNTALL=COUNTAPP THEN 'APPROVED BY ALL' WHEN " + 
				" COUNTAPP=0 THEN 'APPROVAL PROCESS NOT STARTED' WHEN COUNTALL<>COUNTAPP  THEN 'NOT APPROVED BY ALL'" +
				" WHEN TRAVEL_STATUS_ID=3  THEN 'RETURNED FROM WORKFLOW' WHEN TRAVEL_STATUS_ID=4  THEN 'REJECTED'  END " + 
				" AS WORK_FLOW_STATUS, ISNULL(DBO.USER_NAME(PRESENTAPPROVER),'NA') AS PRESENTWITH "+ 
				" FROM (SELECT DISTINCT     T_TRAVEL_DETAIL_DOM.TRAVEL_ID, T_TRAVEL_STATUS.TRAVEL_TYPE, T_TRAVEL_DETAIL_DOM.TRAVELLER_ID,"+
				" (SELECT COUNT(1) FROM T_APPROVERS TA(NOLOCK) WHERE TA.TRAVEL_ID=T_TRAVEL_DETAIL_DOM.TRAVEL_ID  AND "+ 
				" TA.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE AND TA.TRAVELLER_ID=T_TRAVEL_DETAIL_DOM.TRAVELLER_ID) AS COUNTALL,"+
				" (SELECT COUNT(1) FROM T_APPROVERS TA(NOLOCK) WHERE TA.TRAVEL_ID=T_TRAVEL_DETAIL_DOM.TRAVEL_ID  AND "+
				" TA.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE AND TA.TRAVELLER_ID=T_TRAVEL_DETAIL_DOM.TRAVELLER_ID" +
				" AND TA.APPROVE_STATUS=10) AS COUNTAPP, TRAVEL_STATUS_ID, (SELECT TOP 1 APPROVER_ID FROM T_APPROVERS "+
				" TA (NOLOCK)INNER JOIN T_TRAVEL_STATUS TS(NOLOCK) ON  TA.TRAVEL_ID = TS.TRAVEL_ID WHERE "+
				" TA.TRAVEL_ID=T_TRAVEL_DETAIL_DOM.TRAVEL_ID	AND TA.TRAVELLER_ID=T_TRAVEL_DETAIL_DOM.TRAVELLER_ID "+
				" AND TA.STATUS_ID=10 AND TA.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE  AND TS.STATUS_ID = 10 "+  
				" AND TS.TRAVEL_TYPE=T_TRAVEL_STATUS.TRAVEL_TYPE AND TS.APPLICATION_ID = 1 AND APPROVE_STATUS =0 "+ 
				" AND TRAVEL_STATUS_ID = 2 ORDER BY ORDER_ID ) AS PRESENTAPPROVER,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = T_TRAVEL_DETAIL_DOM.SITE_ID) as travel_agency_id FROM   T_TRAVEL_DETAIL_DOM(NOLOCK)"+
				" INNER JOIN T_TRAVEL_STATUS(NOLOCK) ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID = T_TRAVEL_STATUS.TRAVEL_ID INNER "+
				" JOIN T_APPROVERS(NOLOCK) ON T_TRAVEL_DETAIL_DOM.TRAVEL_ID = T_APPROVERS.TRAVEL_ID "+ 
				" WHERE     (T_TRAVEL_DETAIL_DOM.TRAVEL_ID = '"+strTravelId+"') AND (T_TRAVEL_STATUS.TRAVEL_TYPE = 'D')"+ 
				" AND (T_TRAVEL_DETAIL_DOM.TRAVELLER_ID = '"+strTravellerId+"') AND (T_APPROVERS.TRAVEL_TYPE = 'D') )APPROVER_STATUS ";

	//System.out.println("sql==========="+sSqlStr);
    rs1                     =   dbConBean1.executeQuery(sSqlStr);
	if(rs1.next())
	{
        strWorkFlowStatus   = rs1.getString(1); 
		strPresentApprover 	= rs1.getString(2);
		strTravelAgencyTypeId			=	rs.getString("travel_agency_id");

	}
    rs1.close();


    if(!strTravelComments.trim().equals("0"))
	{
    	strImagePrint   =  "<img src=images/group1.gif border=0>";
	}
	else
	{
    	strImagePrint   =  "";
	}

%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 


	  iCls++;
	  String travelRequestDetailUrl = "T_TravelRequisitionDetails_D.jsp";
	  if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
		  travelRequestDetailUrl = "T_TravelRequisitionDetails_INT_GmbH.jsp";
		}
%>
  <tr  valign="top" class="<%=strStyleCls%>"> 
    <td class="listhead" width="8%" align="Left"><a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=<%=strTravelType%>','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a><%=intSerialNo%></td>
    <td class="listdata" width="13%" align="center"><a href="#" onClick="MM_openBrWindow('<%=travelRequestDetailUrl %>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travelType=D','SEARCH','scrollbars=yes,resizable=yes,width=975,height=550')"><%=strTravelRequestNo%></A></td>
    <td class="listdata" width="15%" align="center"><%=strTraveller%></td>
    <td class="listdata" width="15%" align="center"><%=strTravelFrom%></td>
    <td class="listdata" width="15%" align="center"><%=strTravelTo%></td>
    <td class="listdata" width="15%" align="center"><%=strTravelDate%></td>
    <!--<td class="listdata" width="14%" align="Left"><%=strSiteName%></td>-->
    <td class="listdata" width="14%" align="center"><%=strOriginatorName%></td>
    <td class="listdata" width="14%" align="center"><%=strOriginatedDate%></td>
    <td class="listdata" width="14%" align="center"><%=strWorkFlowStatus%></td>
    <td class="listdata" width="14%" align="center"><%=strPresentApprover%></td>
    

	<!--<td class="listdata" width="6%" align="center"><%//=strDivName%>&nbsp;<b>/</b>&nbsp;<%//=strSiteName%></td>-->
	 <td class="listhead" width="20%" align="CENTER" nowrap="nowrap">  
        <a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=<%=strTravelType%>','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a> <br>  <a href="#" onClick="MM_openBrWindow('UnderConstruction.html','HELP','scrollbars=yes,resizable=no,width=600,height=316')"> <%=dbLabelBean.getLabel("label.approverequest.history",strsesLanguage)%></a>  </td>
  </tr>
    <%
  intSerialNo++;
}
rs.close();
dbConBean.close();            //All Connection Close
%>

  <tr> 
  
  </tr>
<tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
  </tr>
</table>
<input type=hidden name=count value="<%=intSerialNo%>">
<%
	} //end of loadFlagloop
%>

<script language="javaScript">
		closeDivRequest();
	</script>

</body>
</html>
