<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Abhinav Ratnawat
 *Date of Creation 		:07-Feb-2011
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is jsp file  for inoforming Exchange rate to admin.
 *Editor				:Editplus
 *******************************************************/
%>

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
	strOutOFOfficestatus="Currently you are Out of Office";
	}
	

%>
<body onBlur="self.focus();">
<table width="96%" border="0" cellspacing=1 cellpadding="3" align=center class="formborder">
<!-- added for blinking -->


<tr align=center>
<div id="prem_hint" style="position:relative; left:0; visibility:hidden" class="prem_hint" align=center>
    <font color="FF0000"><b>Alert for <%=sUserFirstName.trim()%>  
    
        <%=sUserLastName.trim()%>  </b></font> </td>
</div>
</tr>
<script language="javascript">Blink('prem_hint');</script>
 


 <tr> 
      <td align="center" class="formtr1"> <div align="center">Please define exchange rates for next month.</div></td>
  </tr>
	
<tr> 
		 <td align="center" class="formtr1"> <div align="center"><a href="#" onClick="window.close();">Close</a></div></td>

  </tr>
</table>

</body>
</html>
