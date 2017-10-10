<%@ include file="importStatement.jsp" %>
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
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function checkFrm()
{
	var a= document.frm.criteria.value;
	if(a=='')
	{
		alert("Please enter your keyword");
		document.frm.criteria.select();
		return false;
	}
	else
	{
	document.frm.submit();
return true;
	}
}
//-->
</SCRIPT>
</head>
<body onLoad="document.frm.criteria.select();">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="77%" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead">Search Purchase Requisitions</li>
    </ul></td>	
  </tr>
  </table>

<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1"  class="formborder">
  <form method=post name=frm action="T_purchaseReqSearchResults.jsp" target="footer_11">
    <tr align="left" valign="top"> 
      <td class="formhead" colspan="2" align="center">Search by <FONT COLOR=BLUE> >></FONT> <input type=radio name=rad value="purchase_req_no" checked> Requisition Number 
        <input type=radio name=rad value="justification">
        Justification 
         <input type=radio name=rad value="RTRIM(SERS.DBO.PURITEMDESC(PURCHASE_REQ_ID))">
         <FONT COLOR=BLUE>Items</FONT>
		       <input type=radio name=rad value="SUPPLIER_NAME">
			Suppliers
         <input type=radio name=rad value="SERS.DBO.USER_NAME(PURCHASE_REQ_MST.C_USER_ID)">
        Originator <font color=green>View By Status >></font>
		<select name="status" class="textBoxCss">
		<option value="-999">---All</option>
		<option value="<font color=green>COMPLETED</font>">---Completed</option>
		<option value="<font color=red>PENDING FROM PO</font>">---Pending</option>
		</select>
               <a href="#" onClick="MM_openBrWindow('reqSearchHelp.htm#1','ONLINEHELP','scrollbars=yes,resizable=yes,width=775,height=250')"><img src="images/help.png?buildstamp=2_0_0" height=20 border=0></a> 
      </td>
    </tr>
    <tr align="left" valign="top"> 
      <td class="formtr2" align="center" width="100%" colspan=2>Enter your Key Words
        <Input type=text name="criteria" size=50 max length=40 class="textBoxCss">
        <font color=red>For a faster search please select your search criteria</font>
    </tr>
    <tr align="center" valign="top"> 
      <td class="formbottom" colspan="2"> 
        <input type=button value="Search" class="formbutton" onClick="return checkFrm();">
      </td>
    </tr>
  </form>
</table>
</body>
</html>
