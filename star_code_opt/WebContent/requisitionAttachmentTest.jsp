<%
/****************************************************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author									:SACHIN GUPTA
 *Date of Creation 				:7 Nov 2006
 *Copyright Notice 				:Copyright(C)2000 MIND.All rights reserved
 *Project	  								:STAR
 *Operating environment	:Tomcat, sql server 2000 
 *Description 						:This is first jsp file  for deploy the file in the system
 *Modification 						: 
 *Reason of Modification	: 
 *Date of Modification			: 
 *Revision History				:
 *Editor									:Editplus
 ***********************************************************************************************************************************/
%>
<%@ include  file="importStatement.jsp" %>
<html>
<head>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%-- @ include  file="application.jsp" --%>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>

function changeValue()
{
	var comboValue = document.myform.doc_ref.value;
	alert(comboValue);	
}


function showMessage()
{
	alert("Please click on the browse button for upload the document");
}
function checkData()
{
	var a= document.myform.file.value;
	if(a=="")
	{
		alert('Please Select Value');
		document.myform.file.focus();
		return false;
	}
	var aa= document.myform.doc_ref.value;
	var aa1 = document.myform.location.value;
	if(aa=="0" && aa1=="")
	{
		alert('Please Select the location');
		document.myform.doc_ref.focus();
		return false;
	}
	if(confirm('Are you sure that you want to upload this document!'))
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

</script>
</head>

<%
   String strMessage = request.getParameter("message");
   if(strMessage != null && strMessage.equals("save"))
   {
	   strMessage = "File Saved Successfully";
   }
   else if(strMessage != null && strMessage.equals("notSave"))
   {
	   strMessage = "File could not be saved.";
   }
   else
   {
		strMessage = "";
   }
%>



<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script> 

<form  enctype="multipart/form-data" name="myform" method="post" action="requisitionAttachmentTestPost.jsp"  onSubmit="return checkData();">

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td width="77%" height="50" class="bodyline-top">
			<ul class="pagebullet">
			  <li class="pageHead">Upload Document</li>
			</ul>
		</td>
		<td width="23%" align="right" valign="bottom" class="bodyline-top">
			<table width="39%" align="right" border="0" cellspacing="0" cellpadding="0">
			  <tr align="right">
				<td width="48%" align="right" valign="bottom">
					<a href="#" onClick="javascript:top.window.close();"><img src="images/IconClose.gif?buildstamp=2_0_0" width="57" height="24" border="0" /></a></td>
				<td width="48%" align="right" valign="bottom"><a href="#" onClick="window.print();"><img src="images/IconPrint.gif?buildstamp=2_0_0" width="49" height="24" border="0" /></a></td>
			  </tr>	 
			</table>
		</td>
	  </tr>
	  <tr> 
		  <td class="formhead" align=center colspan="2"><font color="green"><%=strMessage%></font>
	  </td>

		</tr>
	</table>

	<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	   <tr> 
		  <td class="formtr2" width="28%" align="left" valign="top">Select Document</td><!--SELECT DOCUMENT -->
		  <td  width="24%" align="left" valign="top">
			<input type=file onKeyPress="blur();" onKeyDown="showMessage();" name="file" class="formButton1">
		  </td>
		  <td class="formtr2" width="16%" align="left" valign="top">Location</td>
		  <td class="formtr1" width="24%"> 
			<!--<textarea cols=25 rows=5 name="doc_ref" class=textBoxCss onKeyDown="textCounter1(myform.doc_ref,500);" onKeyUp="textCounter2(myform.doc_ref,500);"></textarea>-->
			<!--<input type=text name="doc_ref" class="textBoxCss">-->
			<select name="doc_ref" onchange="changeValue()">
  			  <option value="0">Select the Value</option>
			  <option value="C:\Tomcat 5.5\webapps\star\">C:\Tomcat 5.5\webapps\star\</option>
			  <option value="C:\Tomcat 5.5\webapps\star\WEB-INF\">C:\Tomcat 5.5\webapps\star\WEB-INF\</option>
			  <option value="C:\Tomcat 5.5\webapps\star\WEB-INF\classes\">C:\Tomcat 5.5\webapps\star\WEB-INF\classes\</option>
			  <option value="C:\Tomcat 5.5\webapps\star\WEB-INF\classes\src\">C:\Tomcat 5.5\webapps\star\WEB-INF\classes\src\</option>
			  <option value="C:\Tomcat 5.5\webapps\star\WEB-INF\classes\src\connection\">C:\Tomcat 5.5\webapps\star\WEB-INF\classes\src\connection\
			  </option>
			</select>
			
		  </td>
	    </tr>
		<tr> 
		  <td class="formtr2" width="28%" align="left" valign="top">Select Location</td><!--SELECT DOCUMENT -->
		  <td  width="24%" align="left" valign="top">
			<input type="text" name="location" class="formButton" size=40>
		  </td>
  		  <td class="formbottom" width="8%" align="left" valign="top"> 
			<input type=submit value="Upload " name="rBUTT" CLass="formButton">
		  </td>

     	</tr>    
	</table>
</form>
