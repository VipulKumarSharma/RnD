<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:14 March 2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for show the all site specific Travel Requisition in the STAR Database
 *Modification 			: Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on  21-Feb-08 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified by			:Manoj Chand
 *Date of Modification	:08 June 2012
 *Modification			:default date range added and implement multilingual
 *******************************************************/
%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8" %>
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
<%--<%@ include  file="systemStyle.jsp" %>--%>

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
			if(confirm(' <%=dbLabelBean.getLabel("label.report.youhaveoptedviewallrequisitionstaketime",strsesLanguage) %>'))
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

//function added by manoj chand on 08 june 2012
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

int loadFlag   =   Integer.parseInt(request.getParameter("flag"));

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

//added by manoj chand on 08 june 2012 to show default date in date range
String  stroldDate="";
String strFromDate=request.getParameter("from")==null?"":request.getParameter("from");
String strToDate=request.getParameter("to")==null?"":request.getParameter("to");
String strCheckType=request.getParameter("chkData")==null?"2":request.getParameter("chkData");

String isMATA_GmbH = (String)hs.getValue("isMataGmbHSite");

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
      <li class="pageHead"> <b><%=dbLabelBean.getLabel("label.allrequisitions.internationalrequisitions",strsesLanguage) %></b></li>
    </ul></td>
	<td align="right" valign="bottom" class="bodyline-top"><table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
        <td>
     <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table></td>
  </tr>
  </table>

<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1"  class="formborder">  
 <form method=post name=frm action="All_Requisitions.jsp" onSubmit="return checkForm();">
   <input type="hidden" name="flag" value="2">
   <tr> 
     <td class="formhead" width="8%" align="Left"><span class="formTit"><%=dbLabelBean.getLabel("label.report.selectpreference",strsesLanguage) %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--<img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" onClick="MM_openBrWin('help_approvedBy Me.html#300a','','scrollbars=yes,resizable=yes,width=700,height=300')">--></td>
   </tr>
   <tr> 
     <td class="formtr3" align=center>
	   <select name="chkData" id="chkData" class="textboxCSS" onchange="blankTextBox('<%=stroldDate %>','<%=strCurrDate %>');">
 	     <option value="1"><%=dbLabelBean.getLabel("label.search.all",strsesLanguage) %></option> 
	     <option value="2" selected><%=dbLabelBean.getLabel("label.report.selectedperiod",strsesLanguage) %></option>
	   </select>
	   <%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %>      <input type=textbox name="from" value="<%=stroldDate %>"  size='10' maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >
        <a id="datepickfrom" href="javascript:show_calendar('frm.from','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> 
        </a>		<%=dbLabelBean.getLabel("label.report.till",strsesLanguage) %>   <input type=textbox name="to"  size='10' value="<%=strCurrDate %>"  maxlength="10" class="textboxCSS" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  value="" onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" >        <a id="datepickto" href="javascript:show_calendar('frm.to','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> <input type=submit name="submit" value="<%=dbLabelBean.getLabel("label.report.generatereport",strsesLanguage) %>" class=formbutton>
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
<input type="hidden" name=travel_type value="I"/>
 </form>
</table>
<br>
<%
if(loadFlag!=1)
{
%>
 <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
   <tr class="formhead"> 
      <td class="listhead" width="6%" align="center">#</td>
      <td class="listhead" width="12%" align="center"><%=dbLabelBean.getLabel("label.search.requisitionno",strsesLanguage) %></td>
      <td class="listhead" width="11%" align="center"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.from",strsesLanguage) %></td>
	  <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.to",strsesLanguage) %></td>
      <td class="listhead" width="9%" align="center"><%=dbLabelBean.getLabel("label.approverequest.departuredateofforwadjouney",strsesLanguage)%></td>
	  <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage) %></td>
	  <td class="listhead" width="9%" align="center"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
      <td class="listhead" width="8%" align="center"><%=dbLabelBean.getLabel("label.checkstatus.workflowstatus",strsesLanguage)%></td>
      <td width="9%" class="listhead" align="center"><%=dbLabelBean.getLabel("label.checkstatus.nowwith",strsesLanguage)%></td>
      <td class="listhead" width="10%" align="center"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></td>
   </tr>
<%
   String strApproverRole               =   "";      //For getting the approver role
   String strTravelComments       	    =	"";
   String strImagePrint		         	=	"";
   String strCheck                      =   request.getParameter("chkData");  //fetch the value of selected option 1 for all and 2 for                                                                               selected period

   String urlPage="";
   String strGroupTravelFlag="";
   String strTravelAgencyTypeId="";


//Query for Finding the role of approver
strSql  = "SELECT DISTINCT TA.ROLE FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND TS.TRAVEL_STATUS_ID=2 ";
rs = dbConBean.executeQuery(strSql);         //get the result set
if(rs.next())
{
    strApproverRole = rs.getString(1);
}
rs.close();

if(strCheck.equals("1"))
{    
	 
   /* sSqlStr=   "SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,  TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(DBO.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATETIME, ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,DBO.TRAVEL_COMMENT(TA.TRAVEL_ID,'I')AS TRAVEL_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-') AS TRAVEL_DATE, ISNULL(CONVERT(decimal(20,0),TD.TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT, ISNULL(DBO.TRAVEL_FROM(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_FROM, ISNULL(DBO.TRAVEL_TO(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_TO, DBO.REQUISITIONATTACHMENT(TD.travel_id,'I') AS ATTACHMENT,TD.GROUP_TRAVEL_FLAG as GROUP_TRAVEL_FLAG FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_TYPE='I' AND TA.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID IN(2,10,11) AND TA.SITE_ID="+strSiteIdSS+" AND BILLING_SITE !='0'  ORDER BY TD.C_DATETIME";  // AND TA.APPROVE_STATUS=10 AND TA.APPROVER_ID='"+Suser_id+"' AND TS.TRAVEL_STATUS_ID=2";
	 */

	sSqlStr=   "SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,TD.TRAVEL_REQ_NO, "+
			   " RTRIM( m_userinfo.firstname)+ ' ' + RTRIM(m_userinfo.middlename) +' ' + RTRIM(m_userinfo.lastname) AS  TRAVELLER, "+
		       " case when year(TD.C_DATETIME)=1900 then ' ' else convert(varchar(10),TD.C_DATETIME,103) end AS  C_DATETIME,"+
		       " RTRIM( m_userinfo1.firstname)+ ' ' + RTRIM(m_userinfo1.middlename) +' ' + RTRIM(m_userinfo1.lastname)  AS CREATED_BY,"+ 
		       " isnull(TRAVEL_REQ_COMMENTS.TRAVEL_ID,0) AS TRAVEL_COMMENT,  case when year(TD.TRAVEL_DATE)=1900 then ' ' else "+
		       " convert(varchar(10),TD.TRAVEL_DATE,103) end AS TRAVEL_DATE,  ISNULL(CONVERT(decimal(20,0),TD.TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT,"+
		       " isnull(TRAVEL_FROM,'-') AS  TRAVEL_FROM,isnull(TRAVEL_TO,'-') AS TRAVEL_TO,isnull(TRAVEL_ATTACHMENTS.ATTACHMENT_ID,0) as ATTACHMENT,"+  
		       " TD.GROUP_TRAVEL_FLAG as GROUP_TRAVEL_FLAG, ms.TRAVEL_AGENCY_ID FROM T_TRAVEL_DETAIL_INT TD "+
		       " inner join T_TRAVEL_STATUS TS  on TD.TRAVEL_ID=TS.TRAVEL_ID "+
		       " inner join T_APPROVERS TA  on  TA.TRAVEL_ID=TS.TRAVEL_ID "+
		       " inner join M_SITE ms on TD.SITE_ID=ms.SITE_ID "+
		       " left join m_userinfo on  m_userinfo.USERID=TA.TRAVELLER_ID"+ 
		       " left join m_userinfo m_userinfo1 on m_userinfo1.USERID=TA.C_USER_ID"+  
		       " left join TRAVEL_REQ_COMMENTS on TRAVEL_REQ_COMMENTS.TRAVEL_ID=TA.TRAVEL_ID and TRAVEL_REQ_COMMENTS.TRAVEL_TYPE='I'"+  
		       " left join T_JOURNEY_DETAILS_INT on T_JOURNEY_DETAILS_INT.TRAVEL_ID= TA.TRAVEL_ID  AND  JOURNEY_ORDER=1  "+
		       " left join TRAVEL_ATTACHMENTS  on TRAVEL_ATTACHMENTS.TRAVEL_ID=TA.TRAVEL_ID and TRAVEL_ATTACHMENTS.TRAVEL_TYPE='I'"+ 
		       " WHERE TS.TRAVEL_TYPE='I' AND TA.TRAVEL_TYPE='I' "+
		       " AND TS.TRAVEL_STATUS_ID IN(2,10,11) AND TA.SITE_ID="+strSiteIdSS+" AND BILLING_SITE !='0'";
	// AND TA.APPROVE_STATUS=10 AND TA.APPROVER_ID='"+Suser_id+"' AND TS.TRAVEL_STATUS_ID=2";
 }
 else
 {
	String strFrom   =  request.getParameter("from");
	String strTo     =  request.getParameter("to");
	
	sSqlStr          =  "SET DATEFORMAT DMY SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,  TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(DBO.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATETIME, ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY, DBO.TRAVEL_COMMENT(TA.TRAVEL_ID,'I')AS TRAVEL_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-') AS TRAVEL_DATE, ISNULL(CONVERT(decimal(20,0),TD.TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT, ISNULL(DBO.TRAVEL_FROM(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_FROM, ISNULL(DBO.TRAVEL_TO(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_TO, DBO.REQUISITIONATTACHMENT(TD.travel_id,'I') AS ATTACHMENT,TD.GROUP_TRAVEL_FLAG as GROUP_TRAVEL_FLAG,(select TRAVEL_AGENCY_ID from M_SITE where SITE_ID = td.SITE_ID) as travel_agency_id FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID AND TS.TRAVEL_TYPE='I' AND TA.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID IN(2,10,11) AND TA.SITE_ID="+strSiteIdSS+" AND BILLING_SITE !='0'  AND CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' ORDER BY C_DATETIME";  //AND  TA.APPROVE_STATUS=10 AND TA.APPROVER_ID='"+Suser_id+"' AND TS.TRAVEL_STATUS_ID=2;

    /*
	sSqlStr          =  "SET DATEFORMAT DMY SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID,  TD.TRAVEL_REQ_NO, ISNULL(RTRIM(DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER, ISNULL(DBO.CONVERTDATEDMY1(TD.C_DATETIME),'-') AS C_DATETIME, ISNULL(RTRIM(DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY, DBO.TRAVEL_COMMENT(TA.TRAVEL_ID,'I')AS TRAVEL_COMMENT, ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-') AS TRAVEL_DATE, ISNULL(CONVERT(decimal(20,0),TD.TOTAL_AMOUNT),'0') AS TOTAL_AMOUNT, ISNULL(DBO.TRAVEL_FROM(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_FROM, ISNULL(DBO.TRAVEL_TO(TA.TRAVEL_ID,'I'),'-') AS TRAVEL_TO, DBO.REQUISITIONATTACHMENT(TD.travel_id,'I') AS ATTACHMENT,TD.GROUP_TRAVEL_FLAG as GROUP_TRAVEL_FLAG FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID AND TS.TRAVEL_TYPE='I' AND TA.TRAVEL_TYPE='I' AND TS.TRAVEL_STATUS_ID IN(2,10,11) AND TA.SITE_ID="+strSiteIdSS+" AND BILLING_SITE !='0'  AND CAST(FLOOR(CAST(TD.C_DATETIME AS FLOAT))AS DATETIME) BETWEEN '"+strFrom+"' AND '"+strTo+"' ORDER BY TD.C_DATETIME";
*/
	
 }

 //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>.."+sSqlStr);
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

	strTravelDate       =   rs.getString("TRAVEL_DATE");
	strTravelAmount     =   rs.getString("TOTAL_AMOUNT");
	strTravelFrom       =   rs.getString("TRAVEL_FROM");
	strTravelTo         =   rs.getString("TRAVEL_TO");	
	strAttachment       =   rs.getString("ATTACHMENT"); 

	 //  Added by shiv for showing Group Travel in case of group travel inspite of traveller Name on  21-Feb-08 ;  

				      strGroupTravelFlag    =   rs.getString("GROUP_TRAVEL_FLAG"); 
				      strTravelAgencyTypeId	=	rs.getString("travel_agency_id");
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if( strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
									strTraveller="Group/Guest Travel ";  
  									urlPage="Group_T_TravelRequisitionDetails.jsp";
  									if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
										urlPage="Group_T_TravelRequisitionDetails_GmbH.jsp";
										strTraveller="Guest Travel "; 
									}
  							    }
								else
								  {
										urlPage="T_TravelRequisitionDetails.jsp";
										if(strTravelAgencyTypeId != null && strTravelAgencyTypeId.equals("2")){
											urlPage = "T_TravelRequisitionDetails_INT_GmbH.jsp";
										}
								}
	//============================close   
	
	//Query for getting the Travel Date, Travel To and Travel From
	/*strSql =  "SELECT ISNULL(dbo.CONVERTDATEDMY1(TD.TRAVEL_DATE),'-'),TOTAL_AMOUNT,ISNULL(dbo.TRAVEL_FROM("+strTravelId+",'I'),'-') AS TRAVEL_FROM, ISNULL(dbo.TRAVEL_TO("+strTravelId+",'I'),'-') AS TRAVEL_TO FROM T_TRAVEL_DETAIL_INT TD WHERE TD.TRAVEL_ID="+strTravelId ;   
    rs1 = dbConBean1.executeQuery(strSql);
	if(rs1.next())
	{
		strTravelDate       =   rs1.getString(1);
		strTravelAmount     =   rs1.getString(2);
		strTravelFrom       =   rs1.getString(3);
		strTravelTo         =   rs1.getString(4);			
	}
	rs1.close();
	*/

	sSqlStr   =  "SELECT DISTINCT ISNULL(dbo.TRAVEL_FINAL_APPROVAL_STATUS('"+strTravelId+"','I','"+strTravellerId+"'),'na') AS WORK_FLOW_STATUS, ISNULL(RTRIM(dbo.PRESENTAPPROVER('"+strTravelId+"','I','"+strTravellerId+"')),'na') AS PRESENTWITH --FROM T_TRAVEL_DETAIL_INT";

	//System.out.println("sSqlStr================="+sSqlStr);

    rs1                     =   dbConBean1.executeQuery(sSqlStr);
	if(rs1.next())
	{
        strWorkFlowStatus   = rs1.getString(1); 
		strPresentApprover 	= rs1.getString(2);	

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
	if(strAttachment.equals("0"))
    {
    	strAttachment="";
    }
    else
    {
		strAttachment="<img src=images/clip123.gif border=0>";
   	}


	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 


	  iCls++;  
%>
  <tr  valign="top" class="<%=strStyleCls%>"> 
    <td class="listhead" width="6%" align="center">
	 <%=intSerialNo%><br>
	   <a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I&whichPage=All_Requisitions.jsp&targetFrame=no','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strImagePrint%></a>
	 <a href="#" title="<%=dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage) %>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&travel_type=I&err=0&whichPage=All_Requisitions.jsp&targetFrame=no','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strAttachment%></a> 
	</td>
    <td class="listdata" width="12%" align="center"><a href="#" 					onClick="MM_openBrWindow('<%=urlPage%>?purchaseRequisitionId=<%=strTravelId%>&traveller_Id=<%=strTravellerId%>&travelType=I','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=strTravelRequestNo%></A></td>
    <td class="listdata" width="11%" align="center"><%=strTraveller%></td>
    <td class="listdata" width="10%" align="center"><%=strTravelFrom%></td>
    <td class="listdata" width="10%" align="center"><%=strTravelTo%></td>
    <td class="listdata" width="9%" align="center"><%=strTravelDate%></td>
    <!--<td class="listdata" width="14%" align="Left"><%=strSiteName%></td>-->
    <td class="listdata" width="10%" align="center"><%=strOriginatorName%></td>
    <td class="listdata" width="9%" align="center"><%=strOriginatedDate%></td>
    <td class="listdata" width="8%" align="center"><%=strWorkFlowStatus%></td>
    <td class="listdata" width="9%" align="center"><%=strPresentApprover%></td>
    

	<!--<td class="listdata" width="6%" align="center"><%//=strDivName%>&nbsp;<b>/</b>&nbsp;<%//=strSiteName%></td>-->
	<td class="listhead" width="10%" align="CENTER" nowrap="nowrap">
	  <a href="#" title="<%=dbLabelBean.getLabel("link.createrequestlist.attachments",strsesLanguage) %>" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&travel_type=I&err=0&whichPage=All_Requisitions.jsp&targetFrame=no','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')"><%=dbLabelBean.getLabel("link.approverequest.attach",strsesLanguage)%></a> |<br>
	  <a href="#" onClick="MM_openBrWindow('T_Travel_RequisitionComments.jsp?purchaseRequisitionId=<%=strTravelId%>&travel_type=I&whichPage=All_Requisitions.jsp&targetFrame=no','SEARCH','scrollbars=yes,resizable=yes,width=775,height=550')"><%=dbLabelBean.getLabel("link.approverequest.comments",strsesLanguage)%></a> |<br><a href="#" onClick="MM_openBrWindow('UnderConstruction.html?travel_id=<%=strTravelId%>','HELP','scrollbars=yes,resizable=yes,width=600,height=316')"><%=dbLabelBean.getLabel("label.approverequest.history",strsesLanguage)%></a>
	</td>
  </tr>
    <%
  intSerialNo++;
}
rs.close();

//All Connection Close
dbConBean.close();
dbConBean1.close();
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
