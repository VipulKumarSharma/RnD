<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Gurmeet Singh
 *Date of Creation 		:21 May 2014
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file for manually update TES status with reason of Travel Request in T_TRAVEL_STATUS Table of the STAR Database
  *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
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
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>

<script>
function CheckDataSave()
{
	var reasonVal=document.frm.reason.value;
	if(reasonVal == "")
	{
		alert('<%=dbLabelBean.getLabel("alert.tesclose.tesreasonrequestclose",strsesLanguage) %>');
		document.frm.reason.focus();
		return false;
	}
	else
	{
		if(confirm('<%=dbLabelBean.getLabel("alert.tesclose.tesrequestclose",strsesLanguage) %>'))
		{
			document.frm.submit();
		} else {
			return false;
		}
	}
}
function untypeHyphen(el,commentValue){
	
	if(commentValue.length > 0){
		var hypenIndex = commentValue.indexOf('-');		
		if(hypenIndex > -1) {
			commentValue = commentValue.replace(/-/g, '');
			el.value = commentValue;
		}
	}
}
function test1(obj1, length, str)
{	
	var obj;
	
	if(obj1=='reason')
	{
		obj = document.frm.reason;
		upToTwoHyphen(obj);
	}
	charactercheck(obj,str);
    limitlength(obj, length);
	spaceChecking(obj);
  }
  
function winclose(){
	window.close();
}

</script>

<%
ResultSet rs            = null;
String strSql	        = ""; 
String strRequisitionId = "";
String strTravelType   	= "";
String strReason        = "";
String strWhichPage    	= "";
String strTargetFrame  	= "";
String strTargetFlag   	= "";
String strUpdateFlag    = "";

strRequisitionId        = request.getParameter("purchaseRequisitionId");
strTravelType   		= request.getParameter("travel_type");
strWhichPage    		= request.getParameter("whichPage"); 
strTargetFlag    		= request.getParameter("targetFrame"); 
strUpdateFlag			= request.getParameter("updateFlag")==null ? "":request.getParameter("updateFlag");

	if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
	{
	   strTravelType = "I";
	}
	if(strTravelType != null && strTravelType.equals("DOM"))   
	{
	   strTravelType = "D";
	}
	
	if(strWhichPage == null){
	   strWhichPage = "#";
	}
	
	if(strTargetFlag !=null && strTargetFlag.equals("yes"))
	{
	     strTargetFrame="middle";  
	}
	else{
	   	strTargetFrame = "";
	}


	strSql="SELECT TES_REMARKS FROM T_TRAVEL_STATUS WHERE TRAVEL_TYPE='"+strTravelType+"' AND TRAVEL_ID = "+strRequisitionId;
	rs = dbConBean.executeQuery(strSql);
	
	while (rs.next()) 
	     {
		strReason=rs .getString("TES_REMARKS");  
	     } 
	if(strReason == null){
		strReason = "";
	}
		rs.close();
%>

</head>

<body onload="document.frm.reason.focus();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%" height="40" class="bodyline-top">
	<ul class="pagebullet">
	<%if(!strReason.trim().equalsIgnoreCase("") && !strUpdateFlag.trim().equalsIgnoreCase("Y")) {%>
      	<li class="pageHead"><font color="red"><b><%=dbLabelBean.getLabel("label.tesclose.tesreqalreadyclosed",strsesLanguage) %></b></font></li>
    <%} else if(!strReason.trim().equalsIgnoreCase("") && strUpdateFlag.trim().equalsIgnoreCase("Y")) {%>
      	<li class="pageHead"><font color="Green"><b><%=dbLabelBean.getLabel("label.tesclose.tesreqsuccessfullyclosed",strsesLanguage) %></b></font></li>
    <%} else {%>
      	<li class="pageHead"><b><%=dbLabelBean.getLabel("label.tesclose.tesreqclose",strsesLanguage) %></b></li>
    <%}%>
    </ul></td>
    <td width="100%" align="right" valign="bottom" class="bodyline-top">
	<table  align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
       <td>
     <ul id="list-nav">
      <li><a href="#" onClick="javascript:winclose();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
     </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
</table>

<form name=frm action="T_TESStatus_RequestClose_Post.jsp" method=post>
	<input type=hidden name=purchaseRequisitionId value="<%=strRequisitionId%>">
	<input type="hidden" name=travel_type value="<%=strTravelType%>"/>      
	<input type="hidden" name=whichPage value="<%=strWhichPage%>"/>      
	<input type="hidden" name=targetFrame value="<%=strTargetFlag%>"/>      
	<table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
		<tr align="left" valign="top">
			<td width="30%" class="formtr2"><%=dbLabelBean.getLabel("label.reason.yourtesclosereason",strsesLanguage) %></td>
			<td class="formtr1">
				<textarea id="reasonTxtArea" name="reason" cols=70 rows=8 class="textBoxCss" onKeyUp="test1('reason',500,'txt');untypeHyphen(this,this.value);"><%=strReason%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="formbottom" align=center>				
				<input id="submitButton" type="button" name="save" value="<%=dbLabelBean.getLabel("button.tesclose.submit",strsesLanguage)%>" class="formbutton" onClick="CheckDataSave();">
				<input id="resetButton" type="reset" name="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton">
				<input id="cancelButton" type="button" name="cancel" value="<%=dbLabelBean.getLabel("button.tesclose.cancel",strsesLanguage)%>" class="formbutton" onClick="javascript:winclose();">
			</td>
		</tr>    
	</table>
</form>
<script>
 var tesClosedFlag = '<%=strReason%>';
 if(tesClosedFlag != ""){  
	document.getElementById("reasonTxtArea").disabled=true;
    document.getElementById("submitButton").disabled=true;
    document.getElementById("resetButton").disabled=true;
    document.getElementById("cancelButton").disabled=true;
	}
</script>
</body>
</html>
