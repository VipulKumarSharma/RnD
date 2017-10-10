<%
/****************************************************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author									:SACHIN GUPTA
 *Date of Creation 				:04 September 2006
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  								:STAR
 *Operating environment	:Tomcat, sql server 2000 
 *Description 						:This is first jsp file  for attach the document in TRAVEL_ATTACHMENT in the STAR Database
 *Modification 						: 
 *Reason of Modification	: 
 *Date of Modification			: 
 *Revision History				:
 *Editor									:Editplus
 
 *Modified By 		: Manoj Chand
 *Modification 	    : implement javascript check to upload only .html extension file.
 *Date of Modification : 21 Oct 2013
 ***********************************************************************************************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder"%>

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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
function showMessage()
{
	alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseclickonbrowsebuttontoupload",strsesLanguage)%>');
}
function checkData()
{
	var a= document.myform.file.value;
	if(a=="")
	{
	alert('<%=dbLabelBean.getLabel("label.requestdetails.selectdocument",strsesLanguage)%>');
	document.myform.file.focus();
	return false;
	}

//added by manoj chand on 21 october 2013 to check file extension before uploading file. 
	var var_index=a.lastIndexOf(".");
	var var_substring=a.substring(var_index+1,a.length);
	var_substring = var_substring.toLowerCase();
	if(var_substring=='html')
	{
		
	}else{
		alert('<%=dbLabelBean.getLabel("label.uploadpolicy.pleaseuploadfileswithhtmlonly",strsesLanguage)%>');
		return false;
	}
//end here
	
	var aa= document.myform.doc_ref.value;
	if(aa=="")
	{
	alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseenterdocumentdescription",strsesLanguage)%>');
	document.myform.doc_ref.focus();
	return false;
	}

	if(confirm('<%=dbLabelBean.getLabel("label.requestdetails.areyousurewanttouploadthisdocument",strsesLanguage)%>'))
	{
	document.myform.rBUTT.disabled=true;
	return true;
	document.myform.rBUTT.disabled=true;

	}
else
	{
	return false;
	}
} 

function textCounter1(field, maxlimit)
{
 if (field.value.length > maxlimit) // if too long...trim it!
 field.value = field.value.substring(0, maxlimit);
}//end of function
 
function textCounter2(field, maxlimit)
{
 if (field.value.length > maxlimit) // if too long...trim it!
 field.value = field.value.substring(0, maxlimit);
}//end of function
function test1(obj1, length, str)
{	
	var obj;
	if(obj1=='doc_ref')
	{
		obj = document.myform.doc_ref;
		upToTwoHyphen(obj); 
	}
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
}

</script>

</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script> 
<%
// Variables declared and initialized
String strMessage = "";
strMessage = URLDecoder.decode((request.getParameter("message")== null) ?"" : request.getParameter("message"), "UTF-8");
 
%>

<form  enctype="multipart/form-data" name="myform" method="post" action="requisitionUploadData_Policy.jsp"  onSubmit="return checkData();">

	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td width="77%" height="38" class="bodyline-top">
		  <ul class="pagebullet">
			<li class="pageHead"><%=dbLabelBean.getLabel("label.user.uploadpolicydocument",strsesLanguage)%> <font color='red'><%=strMessage%></font></li>
		  </ul>
		</td>
		<td width="23%" align="right" valign="bottom" class="bodyline-top">
		  <table align="right" border="0" cellspacing="0" cellpadding="0">
			<tr align="right">
			<td>
			<ul id="list-nav">
			<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
			<li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage)%></a></li>
			</ul>
			</td>
				
			  
			</tr>	 
		  </table>
		</td></tr>
	  <tr> 
		<td class="formhead" align=center colspan="2"><%=dbLabelBean.getLabel("label.user.thepolicydocumentyouareuploading",strsesLanguage)%><br><font color=red><%=dbLabelBean.getLabel("label.requestdetails.thefilenameyouuploadingnotcontainspaces",strsesLanguage)%></font><br><font color="green">(<%=dbLabelBean.getLabel("label.user.pleaseuploadfileswithyourunitname",strsesLanguage)%>)</font>
		</td>
	  </tr>
	</table>

	
	<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	  <tr> 
		<td class="formtr2" width="28%" align="left" valign="top"><%=dbLabelBean.getLabel("label.user.selectpolicydocument",strsesLanguage)%></td><!--SELECT DOCUMENT -->
		<td  width="24%" align="left" valign="top">
		  <input type=file onKeyPress="blur();" onKeyDown="showMessage();" name="file" class="formButton1">
		</td>
		<td class="formtr2" width="16%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.documentreference",strsesLanguage)%></td>
		<td class="formtr1" width="24%"> 
		  <textarea cols=25 rows=5 name="doc_ref" class=textBoxCss onKeyDown="textCounter1(myform.doc_ref,500);" onKeyUp="textCounter2(myform.doc_ref,500);test1('doc_ref',500,'all');"></textarea>      
		</td>
		<td class="formbottom" width="8%" align="left" valign="top"> 
		  <input type=submit value="<%=dbLabelBean.getLabel("label.requestdetails.upload",strsesLanguage)%>" name="rBUTT" CLass="formButton">      
		</td>
	  </tr>	  
	</table>

</form>
