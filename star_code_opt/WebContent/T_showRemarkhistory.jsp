<%
	/***************************************************
	 *The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
	 *Author				:Manoj Chand
	 *Date of Creation 		:04 August 2011
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat 6.0, sql server 2005 
	 *Description 			:This is first jsp file for showing history in workflow screen
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:15 Sept 2011
	 *Modification			:Show workflow history to local admin also.
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:07 Feb 2012
	 *Modification			:resolve error of designation and order id becomes blank.
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:14 Aug 2012
	 *Modification			:show workflow number for all site.
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:22 Oct 2013
	 *Modification			:javascript validation to stop from typing --,',>,<,&  symbol is added.
	 *******************************************************/ 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include  file="application.jsp" %>
<%@ page import="java.sql.ResultSet"%><html>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" %>
<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8" %>
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script>
<script type="text/javascript">
//function added by manoj chand on 21 oct to block single appostrophe and double hyphen symbol
function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='txtremarks')
	{
		obj = document.frm.txtremarks;
		upToTwoHyphen(obj); 
	}
	charactercheck(obj,str);
	spaceChecking(obj);
}
</script>
<%
String strfromPage= request.getParameter("fromlink")==null?"":request.getParameter("fromlink"); 
String siteid= request.getParameter("site_id")==null?"":request.getParameter("site_id");

String strTitle="";
if(strfromPage.equalsIgnoreCase("delete"))
	strTitle=dbLabelBean.getLabel("message.administration.workflowdeleteremark",strsesLanguage);
else
	strTitle=dbLabelBean.getLabel("message.administration.workflowremarkhistory",strsesLanguage);

%>
<head>
<title><%=strTitle %></title>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %> 
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>

<script type="text/javascript">

function ReplaceAll(Source,stringToFind,stringToReplace){
	  var temp = Source;
	    var index = temp.indexOf(stringToFind);
	        while(index != -1){
	            temp = temp.replace(stringToFind,stringToReplace);
	            index = temp.indexOf(stringToFind);
	        }
	        return temp;
	}

/*ADDED BY MANOJ CHAND ON 07 FEB 2012 TO CONVERT SPECIAL CHARACTER TO THEIR RESPECTIVES CODES*/
function convertSpecialChar(str)
{
	for(var i=0;i<str.length;i++){
		str = str.replace('%', '~');
	}
for(var i=0;i<str.length;i++){
  str = str.replace('!', '%21');
  str = str.replace('@', '%40');
  str = str.replace('#', '%23');
  str = str.replace('$', '%24');
  str = str.replace('^', '%5E');
  str = str.replace('&', '%26');
  str = str.replace('*', '%2A');
  str = str.replace('(', '%28');
  str = str.replace(')', '%29');
  str = str.replace('{', '%7B');
  str = str.replace('}', '%7D');
  str = str.replace(',', '%2C');
}
  return str;
}

</script>

<script type="text/javascript">

function addRemark(siteid,value,delid,type,sprole,wftype,order,desig){

var remark=document.frm.txtremarks.value;
document.frm.remark.value=convertSpecialChar(remark);
if(remark=='<%=dbLabelBean.getLabel("label.administration.pleaseenterremarks",strsesLanguage)%>'){
	alert('<%=dbLabelBean.getLabel("alert.administration.pleaseenterremarkdefaultremark",strsesLanguage)%>');
	document.getElementById("txtremarks").select();
	document.getElementById("txtremarks").focus();
	return false;
}
if(remark==''){
	alert('<%=dbLabelBean.getLabel("alert.administration.pleaseenterremark",strsesLanguage)%>');
	document.getElementById("txtremarks").focus();
	return false;
}


if(confirm('<%=dbLabelBean.getLabel("alert.administration.areyousureyouwanttodeletetheapprover",strsesLanguage)%>')){
	//alert(window.location.href="M_WorkFlowDeleteApprove.jsp?Sprole="+sprole+"&wftype="+wftype+"&TYPE="+type+"&ID="+siteid+"&VAL="+value+"&DELID="+delid+"&order="+order+"&designation="+desig+"&remark="+remark);
//window.location.href="M_WorkFlowDeleteApprove.jsp?Sprole="+sprole+"&wftype="+wftype+"&TYPE="+type+"&ID="+siteid+"&VAL="+value+"&DELID="+delid+"&order="+order+"&designation="+desig+"&remark="+remark.replace("#", "%23").replace("&","%26");
//window.location.href="M_WorkFlowDeleteApprove.jsp?Sprole="+sprole+"&wftype="+wftype+"&TYPE="+type+"&ID="+siteid+"&VAL="+value+"&DELID="+delid+"&order="+order+"&designation="+desig+"&remark="+convertSpecialChar(remark);
document.frm.action="M_WorkFlowDeleteApprove.jsp?Sprole="+sprole+"&wftype="+wftype+"&TYPE="+type+"&ID="+siteid+"&VAL="+value+"&DELID="+delid+"&order="+order+"&designation="+desig;
document.frm.submit();
winclose(type,siteid);

}
}
function winclose(strtype,strsiteid){
	window.opener.childwindowSubmit(strtype,strsiteid);
	window.close();
}


</script>



</head>

<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />

<%
String strtrvType=request.getParameter("traveltype");

ResultSet rs=null;
Connection con	=	null;			    // Object for connection
Statement stmt	=	null;	
String strSql="";
int count=1;

/* for delete approver    */ 
String strSiteId = request.getParameter("ID")==null?"":request.getParameter("ID");
String strVal	 = request.getParameter("VAL")==null?"":request.getParameter("VAL");
String strDelId	 = request.getParameter("DELID")==null?"":request.getParameter("DELID");
String strWKType = request.getParameter("TYPE")==null?"":request.getParameter("TYPE");
String strSprole = request.getParameter("Sprole");
//System.out.println("strSprole--->"+strSprole);
String strwftype = request.getParameter("wftype")==null?"":request.getParameter("wftype");
String strorder  = request.getParameter("ORDER")==null?"":request.getParameter("ORDER");
String strdesignation  = request.getParameter("DESIG")==null?"":request.getParameter("DESIG");
String strsmrsite		=request.getParameter("smrsite")==null?"":request.getParameter("smrsite");

String strMinOrderId="";
String strMaxOrderId="";
String strMailids="";
String strMailidsOnOriginating="";
String btnDisabled = "";

int size=240;
if(strfromPage.equalsIgnoreCase("history")){
	size=290;
}

/* end here */

%>


<body>
<form name="frm" action="" method="post" >
<%if(strfromPage.equalsIgnoreCase("delete")){ 
	
	strSql = " select min(order_id) as min_order_id, max(order_id) as max_order_id from M_DEFAULT_APPROVERS MA "+
			 " where MA.site_id='"+strSiteId+"' and MA.STATUS_ID=10 and TRV_TYPE='"+strtrvType+"' and sp_role='"+strSprole+"'";
	
	rs = dbConBean.executeQuery(strSql);
	if(rs.next()) {
		strMinOrderId=rs.getString("min_order_id"); 
		strMaxOrderId=rs.getString("max_order_id"); 
	}
	rs.close();
	
	
	if(strorder.equals(strMaxOrderId)) {
		strSql = "SELECT MDA.MATA_CC_MAIL as MATA_CC_MAIL , MDA.SITE_ID, MDA.TRV_TYPE, MDA.DESIG_ID FROM M_DEFAULT_APPROVERS AS MDA "+  
				" WHERE MDA.APPLICATION_ID = 1 AND MDA.STATUS_ID = 10 AND MDA.SITE_ID = '"+strSiteId+"' AND MDA.TRV_TYPE = '"+strtrvType+"' AND "+
				" MDA.ORDER_ID=(select max(order_id) from M_DEFAULT_APPROVERS MA where MA.site_id='"+strSiteId+"' and MA.STATUS_ID=10 and TRV_TYPE='"+strtrvType+"' and "+
				" sp_role='"+strSprole+"') and sp_role='"+strSprole+"' ORDER BY MATA_CC_MAIL";
		rs=null;	
		rs = dbConBean.executeQuery(strSql);
		while(rs.next()) {
			 strMailids=rs.getString("MATA_CC_MAIL");   
		}
		 
		 if(strMailids==null) {
			 strMailids="";
		 }
		 
		 rs.close();
		 
		 
		 strSql = "SELECT MDA.MATA_CC_MAIL as MATA_CC_MAIL , MDA.SITE_ID, MDA.TRV_TYPE, MDA.DESIG_ID FROM M_DEFAULT_APPROVERS AS MDA "+  
			" WHERE MDA.APPLICATION_ID = 1 AND MDA.STATUS_ID = 10 AND MDA.SITE_ID = '"+strSiteId+"' AND MDA.TRV_TYPE = '"+strtrvType+"' and "+
		 	" sp_role='"+strSprole+"' AND MDA.ORDER_ID=(select min(order_id) from M_DEFAULT_APPROVERS MA where MA.site_id='"+strSiteId+"' and "+ 
			" MA.STATUS_ID=10 and TRV_TYPE='"+strtrvType+"' and sp_role='"+strSprole+"') ORDER BY MATA_CC_MAIL";
		 	rs=null;	
			rs = dbConBean.executeQuery(strSql);		
			while(rs.next()) {
				 strMailidsOnOriginating=rs.getString("MATA_CC_MAIL");   
			}
			
			 if(strMailidsOnOriginating==null) {
				 strMailidsOnOriginating="";
			 }
		rs.close();
		
		if(!"".equals(strMailids) || !"".equals(strMailidsOnOriginating)) {
			btnDisabled = "disabled";	
		}
	}
	

%>
<div id="dv" style="width: 875px; height: 130px; overflow: auto;">
<table width="100%" border="0" cellpadding="5" cellspacing="1"> 
<tr>
<td></td>
</tr>
<tr>
<td width="60%" class="formtr2">&nbsp;<textarea id="txtremarks" name="txtremarks" rows="6" cols="64" onKeyUp="return test1('txtremarks',200,'txt');" onclick="this.select();" <%=btnDisabled%> ><%=dbLabelBean.getLabel("label.administration.pleaseenterremarks",strsesLanguage) %></textarea>
</td>

<td width="40%" class="formtr2">
<table>
<tr> <td><input type="button" value="<%=dbLabelBean.getLabel("button.administration.confirm",strsesLanguage)%>" class="formButton" onclick="addRemark('<%=strSiteId %>','<%=strVal %>','<%=strDelId %>','<%=strWKType %>','<%=strSprole %>','<%=strwftype %>','<%=strorder %>','<%=strdesignation %>');" <%=btnDisabled%> /></td> </tr>
<tr><td>&nbsp;</td></tr>
<tr> <td><input type="button" align="left" class="formButton" value=" <%=dbLabelBean.getLabel("link.approverequest.cancel",strsesLanguage)%> " onclick="window.close();"/></td> </tr>
</table>

</td>


</tr>

</table>
</div>
<%} %>

<div style="width: 895px; height: <%=size %>px; overflow: auto;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" >
<tr class="formhead">
<td colspan="10" align="center"><%=dbLabelBean.getLabel("message.administration.workflowremarkhistory",strsesLanguage)%></td>
</tr>
<tr class="formhead">
<td align="left" width="4%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage)%></td>
<td width="15%"><%=dbLabelBean.getLabel("label.report.approvername",strsesLanguage)%></td>
<td width="20%"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
<td width="5%" align="left" nowrap="nowrap"><%=dbLabelBean.getLabel("label.administration.orderno",strsesLanguage)%></td>
<%
//if(strsmrsite.equalsIgnoreCase("Y")){%>
<td width="5%">Workflow Number</td>
<%//} %>


<td width="9%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%></td>
<td width="5%"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage) %></td>
<td width="6%" align="left" nowrap="nowrap"><%=dbLabelBean.getLabel("label.administration.remarktype",strsesLanguage) %></td>
<td width=""  nowrap="nowrap"><%=dbLabelBean.getLabel("label.administration.createdby",strsesLanguage)%></td>
<td width="36%"><%=dbLabelBean.getLabel("label.administration.workflowremark",strsesLanguage)%></td>
</tr>
<%

    String strApprovername="";
	String strDesignation="";
	float fltOrder;
	String strTraveltype="";
	String spRole ="";
	String strRemarks="";
	String strDate="";
	String strRemarkType="";
	String strcheck="no";
	String strAddedby="";
	//if(SuserRole.equalsIgnoreCase("AD")){
		//strSql="SELECT DBO.USER_NAME(USERID) AS APPROVERNAME,Order_of_Approval,Designation,Travel_Type,spRole,ISNULL(Remark_Type,'') AS Remark_Type,REMARK,CONVERT(VARCHAR(12),C_date,103) AS DATE FROM M_WORKFLOW_REMARK WHERE TRAVEL_TYPE='"+strtrvType+"' and site='"+siteid.trim()+"' and spRole='"+strSprole+"' order by C_date DESC";
	//}else{
		//strSql="SELECT DBO.USER_NAME(USERID) AS APPROVERNAME,Order_of_Approval,Designation,Travel_Type,spRole,ISNULL(Remark_Type,'') AS Remark_Type,REMARK,CONVERT(VARCHAR(12),C_date,103) AS DATE FROM M_WORKFLOW_REMARK WHERE TRAVEL_TYPE='"+strtrvType+"' and site='"+siteid.trim()+"' and spRole='"+strSprole+"' AND C_userid='"+Suser_id+"' order by C_date DESC";
		
	//}

	strSql="SELECT dbo.user_name(UserId) AS APPROVERNAME, Order_of_Approval, Designation, Travel_Type, spRole, ISNULL(Remark_Type, '') AS Remark_Type,Remark, CONVERT(VARCHAR(12), C_date, 103) AS DATE, dbo.user_name(c_userid) as username FROM M_WORKFLOW_REMARK"+
	       " WHERE (Travel_Type = '"+strtrvType+"') AND (Site = '"+siteid.trim()+"') AND (spRole = '"+strSprole+"') ORDER BY C_date DESC";
//System.out.println("strSql--show remarks-->"+strSql);
con=dbConBean.getConnection();
stmt=con.createStatement();
rs=stmt.executeQuery(strSql);

while(rs.next()){
	strcheck="yes";
	strApprovername=rs.getString("APPROVERNAME");
	fltOrder=rs.getFloat("Order_of_Approval");
	strDesignation=rs.getString("Designation");
	strTraveltype=rs.getString("Travel_Type");
	spRole = rs.getString("spRole");
	strRemarkType=rs.getString("Remark_Type");
	strRemarks=rs.getString("REMARK");
	strDate =rs.getString("DATE");
	strAddedby=rs.getString("username");
%>
<tr>
<td class="formtr2" align="center" width="4%"><%=count++%> </td>
<td class="formtr2" width="15%"> <%=strApprovername%> </td>
<td class="formtr2" width="20%"><%=strDesignation%></td>
<td class="formtr2" width="5%"> <%=fltOrder %> </td>

<%//if(strsmrsite.equalsIgnoreCase("Y")) { %>
<td class="formtr2" width="5%"> <%=spRole %> </td>
<%//} %>




<%if (strTraveltype.equals("I")){ %>
			<td class="formtr2" width="9%"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%></td>
			<% } else if(strTraveltype.equals("D")){  %>
			<td class="formtr2" width="9%"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage)%></td>
			<% } %> 
<td class="formtr2" width="5%"> <%=strDate %> </td>
<td class="formtr2" width="6%"> <%=strRemarkType %> </td>
<td class="formtr2" width=""><%=strAddedby %></td>				
<td class="formtr2" width="36%"><%=strRemarks %></td>
</tr>
<%}if(strcheck.equalsIgnoreCase("no")){%>
<tr>
<td colspan="10" class="formtr1"><%=dbLabelBean.getLabel("label.administration.noremarkhistoryfound",strsesLanguage) %></td>
</tr>

<%} 

%>

</table>
</div>
<input type="hidden" name="remark" value="" />
</form>
</body>
</html>
<script type="text/javascript">
$(document).ready(function() {	
	
	var chkReadyState = setInterval(function() {
	    if (document.readyState == "complete") {
	        clearInterval(chkReadyState);
	        var btnDisableFlag = '<%=btnDisabled%>';
	    	if(btnDisableFlag === 'disabled') {
	    		alert('<%=dbLabelBean.getLabel("alert.administration.approvercouldnotbedeleted",strsesLanguage) %>');
	    	}  
	        
	    }
	}, 200);	
	
});
</script>	