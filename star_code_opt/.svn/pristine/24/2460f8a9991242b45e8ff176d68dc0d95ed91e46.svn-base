<%
/***************************************************
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:20 June 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for adding a new Circular
*******************************************************/%>
<%@ page pageEncoding="UTF-8" %>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%@ include  file="cacheInc.inc" %>
<%@ include  file="headerIncl.inc" %>
<%@ include  file="application.jsp" %>

<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>

function showMessage()
{
	alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseclickonbrowsebuttontoupload",strsesLanguage) %>');
}

function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='circulatedby')
	{
		obj = document.myform.circulatedby;
	}
	 spaceChecking(obj);
  }


 function textCounter1(field, maxlimit)
 {
  if (field.value.length > maxlimit) // if too long...trim it!
  field.value = field.value.substring(0, maxlimit);
 }
  
 function textCounter2(field, maxlimit)
 {
  if (field.value.length > maxlimit) // if too long...trim it!
  field.value = field.value.substring(0, maxlimit);
 }

function checkdata(){

	var z=document.myform.file.value;
	if(z==''){
		alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseselectfile",strsesLanguage) %>');
		document.myform.file.focus();
		return false;
		}

	var var_index=z.lastIndexOf(".");
	var var_substring=z.substring(var_index+1,z.length);
	if(var_substring=='pdf' || var_substring=='doc' || var_substring=='docx' || var_substring=='xls' || var_substring=='xlsx' || var_substring=='ppt' || var_substring=='pptx' || var_substring=='txt' || var_substring=='gif' || var_substring=='jpeg' || var_substring=='jpg' || var_substring=='html' || var_substring=='zip')
	{
		
	}else{
		alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseuploadfileswithdocxlspptgiftxtziponly",strsesLanguage)%>');
		return false;
	}
	
	if(confirm('<%=dbLabelBean.getLabel("label.requestdetails.areyousurewanttouploadthisdocument",strsesLanguage) %>'))
	{
	document.getElementById("upload_but").disabled=true;
	openWaitingProcess();
	return true;
	}
	else
	{
	return false;
	}
	
	//document.getElementById("upload_but").disabled=true;
	//return true;
}

function closeDivRequest()
{
	document.getElementById("waitingData").style.visibility="hidden";	
}


function openWaitingProcess()
{
		var dv = document.getElementById("waitingData");
		if(dv != null)
		{
			var xpos = screen.availHeight/2+100;
			var ypos = screen.availWidth/2-340;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos+10)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
}



</script>
</head>
<!-- Start of body -->

<%
request.setCharacterEncoding("UTF-8");
String sSqlStr			= "";
String strDivisionName  = "";
String strDivId			= "";
ResultSet rs			=  null;
String strmessage= request.getParameter("message")==null?"":request.getParameter("message");
String strflag= request.getParameter("flag")==null?"no":request.getParameter("flag");
String strUserId  =  request.getParameter("userid")==null?Suser_id:request.getParameter("userid"); 
//System.out.println("strUserId---m_uploadpassport--->"+strUserId);
%>

<!-- ADDED BY MANOJ CHAND ON 20 JUNE 2012 TO SHOW VIEW PASSPORT LINK ON UPDATE PROFILE PAGE -->
<script>
function showlink(var_flag){
	if(var_flag=='yes'){
		window.opener.showpassportlink();
	}
}
</script>

<body onunload="showlink('<%=strflag %>')"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td height="32" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.updateprofile.uploadpassport",strsesLanguage) %></li>
    </ul></td>	
	<td height="32" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td align="right">
       <ul id="list-nav">
       <li><a href="#" onclick="window.close();" ><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
       </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
  <tr>
  <td colspan="2" class="formhead" align=center><font color=red>( <%=dbLabelBean.getLabel("label.requestdetails.pleaseuploadfileswithdocxlspptgiftxtziponly",strsesLanguage).trim()%> )</font></td>
  </tr>
</table>
<form enctype="multipart/form-data" name="myform" method="POST" action="M_UploadPassportPost.jsp?userid=<%=strUserId %>" onsubmit="return checkdata();">
	<div id="waitingData" style="display:none;"> 	  
	    
	 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 	<br>      
	 	<center><font color="#000080" class="pageHead"><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage) %> </font></center>    
	</div>
	
  <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
     <tr align="left">
      <td class="formtr2" width="20%" style="text-align: center;"><%=dbLabelBean.getLabel("label.requestdetails.selectdocument",strsesLanguage) %></td>
      <td width="55%" class="formtr2" style="text-align: center;"><input type=file size="30" onKeyPress="blur();" onKeyDown="showMessage();" name="file" class="formButton1"></td>
      <td width="25%" class="formtr2"><input type=submit value="<%=dbLabelBean.getLabel("label.requestdetails.upload",strsesLanguage) %> " id="upload_but" name="but_upload" Class="formButton" ></td> 
    </tr>
    <tr>
    <td colspan="3" style="color: red;font-family:arial,helvetica,sans-serif;font-size: 11px;font-weight: bold;"><%=strmessage %></td>
    </tr>
  </table>
 </form>
 
 	<script language="javaScript">
		closeDivRequest();
	</script>
	
</body>
</html>
