<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Abhinav Ratnawat
 *Date of Creation 		:04 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is jsp file  for inoforming requistion status corresponding to approval.
 *Modification 			:  1. The title appearing should  blink
						   2. Only one link to show for both international and domestic request except role MATA . 
						   3.CODE TO FIND THE CURRENT LOGIN USER OUT OF OFFICE OR NOT added by shiv on 23/09/2008 
 *Reason of Modification:  1. change suggested by MATA
						   2. change suggested by Mr. Rakesh Khurana	
						   
 *Date of Modification  :  1. 02/Nov/2006
						   2. 16 May 2007 	
 *Modified By			:  1. Deepali Dhar
						   2. Sachin Gutpa	
 *Editor				:Editplus
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
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<%
Connection con	=		null;			    // Object for connection
Statement stmt	=		null;			   // Object for Statement
ResultSet rs	=		null;			  // Object for ResultSet
//Create Connection
//Class.forName(Sdbdriver);
//con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	strSqlStr	=	""; // For sql Statements
String strCheckAlert		="";
String strApproverRole 		= "";
String strSql				= "";	
String strAllReqFlag 		= "no";
String strOutOFOfficestatus	="";
int intFlag = 0;          // flag for finding when rs have no value then we check the recieved request for mata in pending task.
int expTrvReqWeeks = 0;
%>

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<!-- added for blink -->
<SCRIPT LANGUAGE="JavaScript">
 
<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->
<!-- Original:  Premshree Pillai (premshree@hotmail.com ) -->
<!-- Web Site:  http://www.qiksearch.com -->
<!-- Begin
 
window.onerror = null;
 var bName = navigator.appName;
 var bVer = parseInt(navigator.appVersion);
 var NS4 = (bName == "Netscape" && bVer >= 4);
 var IE4 = (bName == "Microsoft Internet Explorer" 
 && bVer >= 4);
 var NS3 = (bName == "Netscape" && bVer < 4);
 var IE3 = (bName == "Microsoft Internet Explorer" 
 && bVer < 4);
 var blink_speed=300;
 var i=0;
 
if (NS4 || IE4) {
 if (navigator.appName == "Netscape") {
 layerStyleRef="layer.";
 layerRef="document.layers";
 styleSwitch="";
 }else{
 layerStyleRef="layer.style.";
 layerRef="document.all";
 styleSwitch=".style";
 }
}
 
//BLINKING
function Blink(layerName){
 if (NS4 || IE4) { 
 if(i%2==0)
 {
 eval(layerRef+'["'+layerName+'"]'+
 styleSwitch+'.visibility="visible"');
 }
 else
 {
 eval(layerRef+'["'+layerName+'"]'+
 styleSwitch+'.visibility="hidden"');
 }
 } 
 if(i<1)
 {
 i++;
 } 
 else
 {
 i--
 }
 setTimeout("Blink('"+layerName+"')",blink_speed);
}
//  End -->
</script>
</head>

<%
String s1="";
String s2="";
strSql="select dbo.user_name(dbo.FinalOOO("+Suser_id+",getdate(),'I'))";

rs = dbConBean.executeQuery(strSql);
if (rs.next()) 
	{
	if (!rs.getString(1).equals("-")){
		 s1="1";
	}else {
		 s1="0";
	} 

}
	
strSql="select dbo.user_name(dbo.FinalOOO("+Suser_id+",getdate(),'D'))";
rs = dbConBean.executeQuery(strSql);
		if (rs.next()) 
		{ 
		if (!rs.getString(1).equals("-")){
				 s2="1";
			} 
		else {
			s2="0";
		}

}

if(s1=="1" || s2=="1")
	{
	strOutOFOfficestatus=dbLabelBean.getLabel("message.footer.currentlyoutofoffice",strsesLanguage);
	}
	

%>
<body onBlur="self.focus();">
<table width="96%" border="0" cellspacing=1 cellpadding="3" align=center class="formborder">
<!-- added for blinking -->
<%if(!strOutOFOfficestatus.equals("")){ %>
<tr >
<td align="center" class="formtr1"> 
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<a href="T_outOfOffice.jsp" target="middle" onClick="window.close();"><%=strOutOFOfficestatus %></a>
 
</td>
</tr>
<%} %>
<tr align=center>
<div id="prem_hint" style="position:relative; left:0; visibility:hidden" class="prem_hint" align=center>
    <font color="FF0000"><b><%=dbLabelBean.getLabel("label.mytask.taskfor",strsesLanguage)%> <%=sUserFirstName.trim()%>  
    
        <%=sUserLastName.trim()%>  </b></font> </td>
</div>
</tr>
<script language="javascript">Blink('prem_hint');</script>
 
<%

strSql  = "SELECT CAST(FUNCTION_VALUE AS INT) FROM functional_ctl WHERE FUNCTION_KEY='@ExpTrvReqCutOffWeekForApproval'";
rs = dbConBean.executeQuery(strSql);
if(rs.next())
{
	expTrvReqWeeks = rs.getInt(1);
}
rs.close();

	 //Query for Finding the role of approver
strSql  ="SELECT ROLE_ID FROM M_USERINFO WHERE USERID = "+Suser_id+"  AND STATUS_ID=10 AND APPLICATION_ID = 1";
//System.out.println("sqlStr ==1="+strSql);
rs = dbConBean.executeQuery(strSql);         //get the result set
if(rs.next())
{
    strApproverRole = rs.getString(1);
}
rs.close();



//7th march start---  All requisition show at once
if(strApproverRole!=null && !strApproverRole.trim().equals("MATA"))
{
%>
	<!-- <tr> 
	   <td align="center" class="formtr1"><div align="center">You have Travel requisition(s) to approve<br>
	    <a href="T_approveTravelRequisitions_All.jsp?travel_type=INT" target="middle" onClick="window.close();">   Please click here</a>
		   &nbsp; To view the details</div></td> 
	</tr>	  -->
<%	
}


//7th march end
//CODE TO FIND THE CURRENT LOGIN USER OUT OF OFFICE OR NOT added by shiv on 23/09/2008 
// For Internation Travel Requistion
if(strApproverRole!=null && !strApproverRole.trim().equals("MATA"))
{
	strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+"      AND TA.TRAVEL_TYPE='I'  AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";

	//System.out.println("sqlStr ==="+strSql);
	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) 
	{
	   intFlag = 1;
	   strCheckAlert	=	"yes";
	   strAllReqFlag  =  "yes";
	%>
		<!--Commented by Sachin  on 16 May 2007 start-->
		<!--<tr> 
		  <td align="center" class="formtr1"><div align="center">You have  International Travel requisition(s) to approve<br>
			  <a href="T_approveTravelRequisitions.jsp?travel_type=INT" target="middle" onClick="window.close();">   Please click here</a> 
		   &nbsp; To view the details</div></td>
		</tr>-->
		<!--Commented by Sachin  on 16 May 2007 end-->
	<%
	}
	rs.close();
}

//In Case MATA, show the task in task window when received task pending for approving
if(strApproverRole!=null && strApproverRole.trim().equals("MATA"))
{
	if(intFlag == 0)
	{
		strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'I',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'I')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_INT TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2 AND TS.TRAVEL_TYPE='I' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+"      AND TA.TRAVEL_TYPE='I' AND ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='I'  AND APPROVE_STATUS=0 AND STATUS_ID=10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";  
		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) 
		{
		   strCheckAlert	=	"yes";
	%>
			<tr> 
			  <td align="center" class="formtr1"><div align="center"><%=dbLabelBean.getLabel("label.mytask.haveintreq",strsesLanguage)%><br>
				  <a href="T_approveTravelRequisitions.jsp?travel_type=INT" target="middle" onClick="window.close();">   <%=dbLabelBean.getLabel("label.mytask.clickhere",strsesLanguage)%></a> 
			   &nbsp; <%=dbLabelBean.getLabel("label.mytask.viewdetail",strsesLanguage)%></div></td>
			</tr>
	<%
		}
		rs.close();
	}//end of if
}


intFlag = 0;    //reset the value

// For Domestic Travel Requistion
if(strApproverRole!=null && !strApproverRole.trim().equals("MATA"))
{
	strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2         AND TA.TRAVEL_TYPE='D'          AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";

	rs = dbConBean.executeQuery(strSql);
	if (rs.next()) 
	{
		intFlag = 1;
		strCheckAlert	=	"yes";
		strAllReqFlag  =  "yes";

%>	
	<!--Commented by Sachin  on 16 May 2007 start-->
		<!--<tr> 
		  <td align="center" class="formtr1"><div align="center">You have  Domestic Travel requisition(s) to approve<br>
			  <a href="T_approveTravelRequisitions_D.jsp?travel_type=DOM" target="middle" onClick="window.close();">   Please click here</a> &nbsp; To view the details </div></td>
		</tr>-->
	<!--Commented by Sachin  on 16 May 2007 end-->
<%
	}
	rs.close();
}


//In Case MATA, show the task in task window when received task pending for approving
if(strApproverRole!=null && strApproverRole.trim().equals("MATA"))
{
	if(intFlag == 0)
	{
		strSql="SELECT DISTINCT TA.TRAVEL_ID, TA.TRAVELLER_ID, TD.TRAVEL_REQ_NO, ISNULL(RTRIM(.DBO.USER_NAME(TA.TRAVELLER_ID)),'NA') AS TRAVELLER,ISNULL(dbo.CONVERTDATEDMY1(TA.C_DATETIME),'-') AS C_DATE,ISNULL(RTRIM(.DBO.USER_NAME(TA.C_USER_ID)),'NA') AS CREATED_BY,ISNULL(RTRIM(.DBO.NEXTAPPROVER(TD.TRAVEL_ID,'D',TA.TRAVELLER_ID)),'NA') AS NEXTWITH, dbo.REQUISITIONATTACHMENT(TD.TRAVEL_ID,'D')AS ATTACHMENT  FROM T_APPROVERS TA, T_TRAVEL_STATUS TS,T_TRAVEL_DETAIL_DOM TD WHERE TA.TRAVEL_ID=TS.TRAVEL_ID AND TD.TRAVEL_ID=TS.TRAVEL_ID  AND TS.TRAVEL_STATUS_ID=2         AND TA.TRAVEL_TYPE='D'          AND TS.TRAVEL_TYPE='D' AND TA.APPROVE_STATUS=0 AND TA.APPROVER_ID="+Suser_id+" AND  ORDER_ID=(SELECT MIN(ORDER_ID)FROM T_APPROVERS  WHERE TRAVEL_ID=TS.TRAVEL_ID AND TRAVEL_TYPE='D'  AND APPROVE_STATUS=0 AND STATUS_ID=10) AND TD.TRAVEL_DATE>=CAST(DATEADD(WK,-"+expTrvReqWeeks+",GETDATE()) AS DATE)";  
		rs = dbConBean.executeQuery(strSql);
		if (rs.next()) 
		{
		   strCheckAlert	=	"yes";
	%>
			<tr> 
			  <td align="center" class="formtr1"><div align="center"><%=dbLabelBean.getLabel("label.mytask.havedomreq",strsesLanguage)%><br>
				  <a href="T_approveTravelRequisitions_D.jsp?travel_type=INT" target="middle" onClick="window.close();">   <%=dbLabelBean.getLabel("label.mytask.clickhere",strsesLanguage)%></a>
			   &nbsp; <%=dbLabelBean.getLabel("label.mytask.viewdetail",strsesLanguage)%></div></td>
			</tr>
	<%
		}
		rs.close();
	}//end of if
}


//add by Sachin  on 16 May 2007 start
if(strAllReqFlag.trim().equals("yes"))
{
%>
	<tr> 
	   <td align="center" class="formtr1"><div align="center"><%=dbLabelBean.getLabel("label.mytask.havetravelreq",strsesLanguage)%><br>
	    <a href="T_approveTravelRequisitions_All.jsp?travel_type=INT" target="middle" onClick="window.close();">   <%=dbLabelBean.getLabel("label.mytask.clickhere",strsesLanguage)%></a>
		   &nbsp;<%=dbLabelBean.getLabel("label.mytask.viewdetail",strsesLanguage)%></div></td> 
	</tr>	
<%
}
//add by Sachin  on 16 May 2007 end

if(!strCheckAlert.trim().equals("yes"))
{
%>

 <tr> 
      <td align="center" class="formtr1"> <div align="center"><%=dbLabelBean.getLabel("label.mytask.nopendingtask",strsesLanguage)%></div></td>
  </tr>
	<%
}
	%>

<tr> 
		 <td align="center" class="formtr1"> <div align="center"><a href="#" onClick="window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage)%></a></div></td>

  </tr>
</table>

</body>
</html>
