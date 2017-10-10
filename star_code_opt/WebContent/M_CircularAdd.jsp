<%
/***************************************************
 *The information contained here in is confidential and 
 *proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj Chand
 *Date of Creation 		:24 Jan 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is for adding a new Circular
 
 *Modified By					:Manoj Chand
 *Date of Modification			:25 Oct 2013
 *Modification					:javascript validation to stop from typing --,',<,>,& symbol is added.
*******************************************************/%>

<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

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
	if(obj1=='doc_ref')
	{
		obj = document.myform.doc_ref;
		upToTwoHyphen(obj);
	}
	charactercheck(obj,str);
    limitlength(obj, length);
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
	var x=document.myform.doc_ref.value;
	var y=document.myform.circulatedby.value;
	var z=document.myform.file.value;
	
	if(x==''){
	alert('<%=dbLabelBean.getLabel("label.circulars.pleaseentercircularname",strsesLanguage) %>');
	document.myform.doc_ref.focus();
	return false;
	}
	if(y==''){
		alert('<%=dbLabelBean.getLabel("label.circulars.pleaseentercirculatedby",strsesLanguage) %>');
		document.myform.circulatedby.focus();
		return false;
		}
	if(z==''){
		alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseselectfile",strsesLanguage) %>');
		document.myform.file.focus();
		return false;
		}
	
	var var_index=z.lastIndexOf(".");
	var var_substring=z.substring(var_index+1,z.length);
	var_substring = var_substring.toLowerCase();
	if(var_substring=='pdf' || var_substring=='doc' || var_substring=='docx' || var_substring=='xls' || var_substring=='xlsx' || var_substring=='ppt' || var_substring=='pptx' || var_substring=='txt' || var_substring=='gif' || var_substring=='jpeg' || var_substring=='jpg' || var_substring=='html')
	{
		
	}else{
		alert('Please upload files with .pdf, .doc, .docx, .xls, .xlsx, .ppt, .pptx, .txt, .gif, .jpeg, .jpg, .html extension only');
		return false;
	}
	if(confirm('<%=dbLabelBean.getLabel("label.requestdetails.areyousurewanttouploadthisdocument",strsesLanguage) %>'))
	{
	//document.myform.rBUTT.disabled=true;
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
String strmessage		= URLDecoder.decode((request.getParameter("message")==null) ?"":request.getParameter("message"), "UTF-8");

%>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td height="32" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.circulars.addcircular",strsesLanguage) %><center><%=strmessage %></center></li>
    </ul></td>	
	<td height="32" align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td align="right">
       <ul id="list-nav">
       <li><a href="M_CircularList.jsp" ><%=dbLabelBean.getLabel("label.global.list",strsesLanguage) %></a></li>
       </ul>
       </td>
      </tr>
    </table>
	</td>
  </tr>
</table>
<form enctype="multipart/form-data" name="myform" method="POST" action="M_CircularPost.jsp" onsubmit="return checkdata();">
<div id="waitingData" style="display:none;"> 	  
	    
	 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 	<br>      
	 	<center><font color="#000080" class="pageHead"><%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage) %> </font></center>    
	</div>
  <table width="101%" align="center" border="0" cellspacing="0" cellpadding="0">
     <tr align="left">
      <td class="formtr2" width="10%"><%=dbLabelBean.getLabel("label.circulars.circularname",strsesLanguage) %></td>
      <td width="20%" class="formtr1">
      <textarea cols=25 rows=3 name="doc_ref" class=textBoxCss onKeyDown="textCounter1(myform.doc_ref,500);" onKeyUp="textCounter2(myform.doc_ref,500);test1('doc_ref',500,'txt');"></textarea>
      <td class="formtr2" width="10%"><%=dbLabelBean.getLabel("label.circulars.circulatedby",strsesLanguage) %></td>
      <td width="20%" class="formtr1"><input type="text" size=25 maxlength=50 name="circulatedby" onKeyUp="return test1('circulatedby', 50, 'c')" value="" class="textBoxCss"></td>
      <td class="formtr2" width="10%"><%=dbLabelBean.getLabel("label.requestdetails.selectdocument",strsesLanguage) %></td>
      <td width="20%" class="formtr1"><input type=file onKeyPress="blur();" onKeyDown="showMessage();" name="file" class="formButton1"></td>
      <td width="20%" class="formtr1"><input type=submit value="<%=dbLabelBean.getLabel("label.requestdetails.upload",strsesLanguage) %> " id="upload_but" name="but_upload" Class="formButton" ></td> 
    </tr>
  </table>
 </form>
 <script language="javaScript">
		closeDivRequest();
	</script>
</body>
</html>
