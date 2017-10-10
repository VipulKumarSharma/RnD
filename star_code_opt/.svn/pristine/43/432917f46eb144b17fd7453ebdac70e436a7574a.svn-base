
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Kaveri Garg
 *Date of Creation 		:21 Aug 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2008 
 *Description 			:This jsp list the Cost Centres.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<html>
<head>
<%@ include  file="importStatement.jsp" %>
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
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />

<%
// Variables declared and initialized
ResultSet objRs			=		null;			  // Object for ResultSet
ResultSet rs 			=		null;	
String	strSqlStr	=	""; // For sql Statements
int iCls = 0;
String strStyleCls = "";
String strsiteid	 ="";
String strMessage = URLDecoder.decode((request.getParameter("strMsg") == null) ? "" : request.getParameter("strMsg"), "UTF-8");
%>
<script language=JavaScript >

function deleteConfirm(cc_code,site_id)
{

	var p_cc_code=cc_code;
	var p_site_id=site_id;
	var p_flag="delete";
//jquery added by Kaveri garg on 21 Aug 2012 to solve the problem of check before deleting a cost centre.
	jQuery.noConflict();
	jQuery(document).ready(function($) {
		
				var urlParams = "flag="+p_flag+"&cc_code="+p_cc_code+"&site_id="+p_site_id;
					$.ajax({
		            type: "post",
		            url: "AjaxMaster.jsp",
		            data: urlParams,
		            success: function(result){
		            var res=jQuery.trim(result);
		            if(res=='1')
		            {
		 		           	if(confirm('<%=dbLabelBean.getLabel("label.costcentre.referencecostcentreexistareyousure",strsesLanguage) %>'))
					{
		    		document.forms[0].costCentreCode.value=cc_code;
		    		document.forms[0].sitedivId.value=site_id;
		    		//document.forms[0].action1.value="Delete";
		    		//alert("document.forms[0].costCentreCode.value-->"+document.forms[0].costCentreCode.value);
		    		//alert("doument.frm.sitedivId.value-->"+document.forms[0].sitedivId.value);
		    		 document.frm.action="M_CostCentreAddPost.jsp?action1=Delete";
		    		 document.frm.submit();
		    		return true;
					}
				    else
				    {
		        	return false;	
		            }
		            }
		            else
					{
			        if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage) %>'))
			    	{
			    	document.forms[0].costCentreCode.value=cc_code;
			    	document.forms[0].sitedivId.value=site_id;
			    	//document.forms[0].action1.value="Delete";
			    	//alert("document.forms[0].costCentreCode.value-->"+document.forms[0].costCentreCode.value);
			    	//alert("doument.frm.sitedivId.value-->"+document.forms[0].sitedivId.value);
			    	document.frm.action="M_CostCentreAddPost.jsp?action1=Delete";
			    	 document.frm.submit();
			    	return true;
			    	}
			    else
			    	return false;

			    } 
					},
					error: function(){
						alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage) %>');
		            }
      		          });
	});
	}
</script>
<base target="middle">
</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<form name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage) %>   </li><font color='red'><%=strMessage%></font>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td align="right" >
      <ul id="list-nav">
            <li><a href="M_CostCentreAdd.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></a></li>
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      </ul>
      </td>
       </tr>
    </table>
	</td>
  </tr>
</table>
<br>
<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left" class="formhead"> 
    <td width="4%"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
    <td width="5%"><%=dbLabelBean.getLabel("label.costcentre.ccid",strsesLanguage) %></td>
	<td width="17%"><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage) %></td>
    <td width="13%"><%=dbLabelBean.getLabel("label.costcentre.costcentrecode",strsesLanguage) %></td>
    <td width="23%"><%=dbLabelBean.getLabel("label.costcentre.costcentredescription",strsesLanguage) %></td>
    <td width="13%"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage) %></td>
    <td width="12%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %></td>

  </tr>
  <%
		
	int		intSno		=	1;
	String strSiteName  =   ""; 
	String strCostCentreCode =   "";
	String strCostCentreDesc =   "";
	String strCreatedDate = "";
	String strCostCentreId	=	"";
	
	//Sql to get the the site list  from site table

	strSqlStr="SELECT  CC_ID,SITE_ID,DBO.SITEDETAILS(SITE_ID) AS SITE, CC_CODE,CC_DESC, DBO.CONVERTDATE(C_DATE) AS CREATEDDATE FROM M_COST_CENTRE WHERE STATUS_ID=10 ORDER BY C_DATE DESC";
      objRs				= dbConBean.executeQuery(strSqlStr);
	  
//New Check for local administrator
	if((SuserRoleOther.trim().equals("LA")))
	{
 		
		  strSqlStr="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
                objRs = dbConBean.executeQuery(strSqlStr);
				if(!objRs.next())
		           {
		
					strSqlStr="SELECT  CC_ID,DBO.SITEDETAILS(SITE_ID) AS SITE, CC_CODE,CC_DESC, DBO.CONVERTDATE(C_DATE) AS CREATEDDATE FROM M_COST_CENTRE WHERE SITE_ID="+strSiteIdSS+" AND STATUS_ID=10 ORDER BY C_DATE DESC";
					objRs = dbConBean.executeQuery(strSqlStr);
		           }
				   else 
		          {
				   strSqlStr="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
                   objRs = dbConBean.executeQuery(strSqlStr);

				   while(objRs.next())
					    {
					     strsiteid=objRs.getString("SITE_ID");
                           strSqlStr="SELECT  CC_ID,DBO.SITEDETAILS(SITE_ID) AS SITE, CC_CODE,CC_DESC, DBO.CONVERTDATE(C_DATE) AS CREATEDDATE FROM M_COST_CENTRE WHERE SITE_ID="+strsiteid+" AND STATUS_ID=10 ORDER BY C_DATE DESC";
						   rs = dbConBean1.executeQuery(strSqlStr);
						   while (rs.next())
							{
							                    strCostCentreId				= rs.getString("CC_ID");
												strSiteName             = rs.getString("SITE"); 
												strCostCentreCode			= rs.getString("CC_CODE");
												strCostCentreDesc			= rs.getString("CC_DESC");
												strCreatedDate   		= rs.getString("CREATEDDATE");

												if (iCls%2 == 0) { 
												strStyleCls="formtr2";
												} else { 
												strStyleCls="formtr1";
												} 
												iCls++;
										%>
											<tr class="<%=strStyleCls%>"> 
											<td width="4%"><%=intSno%></td>
											<td width="5%"><%=strCostCentreId%></td>
											<td width="17%"><%=strSiteName%></td>
											<td width="13%"><%=strCostCentreCode%></td>
											<td width="23%"><%=strCostCentreDesc%></td>
											<td width="13%" ><%=strCreatedDate%></td>
											<td width="12%" align="left" class="rep-txt"><a href="M_CostCentreEdit.jsp?CostCentreId=<%=strCostCentreId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="#" onClick="deleteConfirm('<%=strCostCentreCode %>','<%=strsiteid%>');"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
										  </tr>
										  <%
														intSno++;				
							}rs.close();
 
						   
				      }   
				   
				   }
				   //  close of else 
	}  //  close of if
//

	//objRs				= dbConBean.executeQuery(strSqlStr);
	while(objRs.next())
	{
		strCostCentreId				= objRs.getString("CC_ID");
		strsiteid				= objRs.getString("SITE_ID");
		strSiteName             = objRs.getString("SITE"); 
		strCostCentreCode			= objRs.getString("CC_CODE");
		strCostCentreDesc			= objRs.getString("CC_DESC");
		strCreatedDate   		= objRs.getString("CREATEDDATE");

		if (iCls%2 == 0) { 
		strStyleCls="formtr2";
	    } else { 
		strStyleCls="formtr1";
		} 
	    iCls++;
%>
    <tr class="<%=strStyleCls%>"> 
    <td width="4%"><%=intSno%></td>
    <td width="5%"><%=strCostCentreId%></td>
	<td width="17%"><%=strSiteName%></td>
    <td width="13%"><%=strCostCentreCode%></td>
	<td width="23%"><%=strCostCentreDesc%></td>
	<td width="13%" ><%=strCreatedDate%></td>
    <td width="12%" align="left" class="rep-txt"><a href="M_CostCentreEdit.jsp?CostCentreId=<%=strCostCentreId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="#" onClick="deleteConfirm('<%=strCostCentreCode %>','<%=strsiteid%>');"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
  <%
				intSno++;				
	
	}
	objRs.close();
	dbConBean.close();   //Close All Connection
   

%>
 <tr>
    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
     <input type="hidden" name="sitedivId" value="" >
       <input type="hidden" name="costCentreCode" value="" >
              </tr>
</table>
<br>
</form>
</body>
</html>
