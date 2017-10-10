<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Abhinav Ratnawat
	 *Date of Creation 		:30 August 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This is first jsp file  for display the workflow detail.
	 *Modification 			:1. Show the Name of Approver and add the Name of Chairman in Combo
	                         2. code changed by shiv for findind username & user Designation  on26-Sep-07
							 3 function added by shiv on 25-Mar-08 for enabling the text on order id =10 
							 4 Change the query for multiple site user on 16 Nov 2009 by shiv sharma
	   
	 *Reason of Modification: change suggested by MATA 
	                                          show Global approval with there Site name
	
	 *Date of Modification  :9 Nov 2006 
	                                     : 26/3/2007 
	 *Modified By	        : SACHIN GUPTA
	                                 Shiv Sharma
	 *Editor				:Editplus
							:By Vaibhav on sep 22 2010 to add cc mails on request origination passed wftype in query string.
	 
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 05 August 2011
	 *Modification			: implementing Remark in workflow screen
	 
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 19 Sept 2011
	 *Modification			: Imlementing Remarks in workflow screen of local admin also.
	 
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 01 March 2012
	 *Modification			: change in queries to resolve issue of showing old designation in both workflow list.
	 
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 05 March 2012
	 *Modification			: Change in query to resolve hard coded values.
	 
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 09 July 2012
	 *Modification			: Add feature to Export workflow in excel file.
	 
	 *Modified By			: Manoj Chand
	 *Date of Modification	: 14 August 2012
	 *Modification			: implement multiple workflow for non smr site also.
	 
	 *Modified By	        : MANOJ CHAND
	 *Date of Modification  : 04 Feb 2013
	 *Description			: IE Compatibility Issue resolved
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:22 Oct 2013
	 *Modification			:javascript validation to stop from typing --,'  symbol is added.
	 *******************************************************/ 
	%>
	<%@ page pageEncoding="UTF-8" %>
	<%@page import="java.net.URLDecoder"%>
	
	<%-- Import Statements  --%>
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
	<%@page import="src.dao.starDaoImpl"%>
	<%@page import="src.beans.WorkflowApprovalMatrix" %>
	<%
	String strSiteId 	= request.getParameter("ID");
	
	String strMessg 	= URLDecoder.decode((request.getParameter("strMessg")==null) ? "" : request.getParameter("strMessg"), "UTF-8");
	String strUserID 	= (request.getParameter("UINFO")== null) ? "-1" : request.getParameter("UINFO");
	//System.out.println("site id of user=============="+strSiteIdSS);
	String strVal	 	= (request.getParameter("VAL")==null)?"0":request.getParameter("VAL");
	String strWKType 	= request.getParameter("TYPE");
	String strLabel	 	= "";
	String strSql 		= "";
	String strSiteID	= "";
	String strUserid	= "";
	
	
	
	
	String strStyleCls = "";
	int iCls = 0;
	ResultSet objRs = null;
	ResultSet objRs1 = null;
	
	String strsmrsiteflag="";
	String strDivName="";
	String strSiteName="";
	String strSiteTravelAgencyID="";
	
	//System.out.println("strSiteId================="+strSiteId);
	
	//To Find the SMR SITE Flag from SMR       
	
	
	strSql="select isnull(SMR_SITE_FLAG,'n') as SMR_SITE_FLAG from m_site where site_id="+strSiteId+" and status_id=10";
	
    objRs = dbConBean.executeQuery(strSql);
	
	  while(objRs.next())
	  {      
		  strsmrsiteflag= objRs.getString("SMR_SITE_FLAG");
	  }
	  
	 //System.out.println("strsmrsiteflage================="+strsmrsiteflag);
	
	if(strWKType.equals("1"))
	{
		//strLabel=dbLabelBean.getLabel("label.administration.production",strsesLanguage);
	}
	
	int iLoop=1;
	%>
	
	<SCRIPT LANGUAGE="JavaScript">
	
	//function added by shiv on 25-Mar-08 for enabling the text on order id =10 
	function  enabletext()
	 {
		 var orderid=document.frm.ORD.value;
		 
		       if('<%=SuserRole.equalsIgnoreCase("AD")%>'=='true') 
		             { 
	                   	 	 if (orderid=='10')
		                           { 
	                                    document.frm.mail_ids.disabled=false;
		                           }
		                      else
		                        { 
								  document.frm.mail_ids.disabled=true;
		                    }
					 }
	}
	
	
	function funConf()
	{
	if(confirm('<%=dbLabelBean.getLabel("alert.master.areyousurewanttodeletethisrecord",strsesLanguage)%>'))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	
	</SCRIPT>
	<SCRIPT LANGUAGE="JavaScript">
	function moveBack()
	{
	
		if(document.frm.TYPE.value == 1)
		{
			window.location.href="M_WorkFlowDisplay.jsp";
		}
	}
	function ChekData()
	{
	var v=document.frm.UINFO.value;
	if(v=='-1')
		{
			document.frm.UINFO.focus();
			alert('<%=dbLabelBean.getLabel("alert.master.areyousurewanttodeletethisrecord",strsesLanguage)%>');
			return false;
		}
	var u=document.frm.ORD.value;
	if(u=='0')
		{
			alert('<%=dbLabelBean.getLabel("alert.administration.pleaseselectorderofapproval",strsesLanguage)%>');
			document.frm.ORD.focus();
			return false;
		}
	
	var m=document.frm.TTYPE.value;
	if(m=='0')
		{
			alert('<%=dbLabelBean.getLabel("alert.administration.pleaseselecttraveltype",strsesLanguage)%>');
			document.frm.TTYPE.focus();
			return false;
		}

	var w=document.frm.sprole.value;
	if(w=='')
		{
			alert('Information ::: Please enter workflow number\n');
			document.frm.sprole.focus();
			return false;
		}
	

	var rmk=document.frm.remark.value;
	if(rmk==''){
		alert('<%=dbLabelBean.getLabel("alert.global.remarks",strsesLanguage)%>');
		document.frm.remark.focus();
		return false;
	}

	
	    //validating  Email id  of mata associate with semicolon  --added by shiv sharma on 26-Mar-08  --open
		
		if('<%=SuserRole.equalsIgnoreCase("AD")%>'=='true') 
	         { 
			if (document.frm.mail_ids.value!='')
			  {
				  var arrayOfStrings = new Array(70);
				
				  var email_ids=document.frm.mail_ids.value;
	
					  if (email_ids.indexOf(";")==-1)  //case of  single  mail   
					   {
							 var flag = echeckMultple(window.document.frm.mail_ids.value);
								if (flag == false)
								 {
										  document.frm.mail_ids.focus();
										   return false;
								 }
					   
					   }
					   else{  //case of multpiltpe mail id  
							 
								 arrayOfStrings=email_ids.split(";");
								  for(i=0;i<arrayOfStrings.length;i++) 
									  { 
										  var flag = echeckMultple(arrayOfStrings[i]);
										   if (flag == false)
												   {
														document.frm.mail_ids.focus();
														return false;
													 }
									   } 
					   } 
				}	
	}
	
	document.frm.submit();
	
	}
	
	function getUserID()
	{
	document.frm.action="M_WorkFlowAddApprover.jsp";
	document.frm.submit();
	}
	
	</SCRIPT>
	
	<SCRIPT LANGUAGE="JavaScript">
	 
	function submitEnableApproverLevelForm(){
		document.approvalLevelForm.submit();
	}
	
	function MM_openBrWindow(theURL,winName,features) 
	{ 
		//alert(theURL);
	window.open(theURL,winName,features);
	}
	 </script>
	
	<script type="text/javascript">

    function childwindowSubmit(type,siteid){
    	window.location.href="M_WorkFlowAddApprover.jsp?TYPE="+type+"&ID="+siteid;
    	//document.frm.action="M_WorkFlowAddApprover.jsp?TYPE="+type+"&ID="+siteid;
    	document.frm.submit();
    }
//function added by manoj chand on 14 August 2012 to make integer check on workflow number textbox
    function test1(obj1, length, str)
    {	
				var obj;
				if(obj1=='sprole')
				{
					obj = document.frm.sprole;
				}
				if(obj1 == 'remark'){
					obj = document.frm.remark;
					upToTwoHyphen(obj);
				}
				if(obj1 == 'mail_ids'){
					obj = document.frm.mail_ids;
					upToTwoHyphen(obj);
				}
				charactercheck(obj,str);
				limitlength(obj, length);
				spaceChecking(obj);
    }

	</script>
	
	
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<base target="middle"> 
	</head>
	
	
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="70%" height="35" class="bodyline-top">  
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.administration.administratorproductionworkflow",strsesLanguage)%> >
	      <%
		if(strWKType.equals("1"))
		{
	%>
	
		<% 
		objRs = dbConBean.executeQuery("SELECT .DBO.DIVISIONNAME(DIV_ID) AS DIV,SITE_NAME, TRAVEL_AGENCY_ID FROM M_SITE WHERE SITE_ID="+strSiteId+" AND APPLICATION_ID = 1 ORDER BY 1,2");
		while (objRs.next()) {
			strDivName=objRs.getString("DIV");
			strSiteName=objRs.getString("SITE_NAME");
			strSiteTravelAgencyID=objRs.getString("TRAVEL_AGENCY_ID");
		%>
		<%=strDivName %> \ <%=strSiteName%>  &nbsp;&nbsp;<%=strMessg%>
		<% } %>
	
	<%
		}
	%>
		  </li>
	    </ul>    </td>
	    <td width="30%" align="right" valign="bottom" class="bodyline-top">
		  <table align="right" border="0" cellspacing="0" cellpadding="0">
	      <tr align="right">
	      <td>
	      <ul id="list-nav">
	      <!-- export to excel link added by manoj chand on 09 july 2012 -->
				<li><a href="#" onclick="window.open('./ExportWorkflowToExcel?site_id=<%=strSiteId %>&site_name=<%=strSiteName %>&lang=<%=strsesLanguage %>','_self','scrollbars=yes, resizable=yes,top=280,left=350,width=1,height=1');"><%=dbLabelBean.getLabel("label.report.exporttoexcel",strsesLanguage)%></a></li>
				<li><a href="#" onClick="MM_openBrWindow('M_searchInitial.jsp','USER','scrollbars=yes,width=975,height=00,resizable=yes')"><%=dbLabelBean.getLabel("button.global.search",strsesLanguage)%></a></li>
				<li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage)%></a></li>
		  </ul>
	      </td>
	      </tr>
	    </table>
	    </td></tr>
		</table>
	<br>
	<form method=post name="frm" action="M_WorkFlowAddNewApprover.jsp">
	<input type=hidden name="ID" value="<%=strSiteId%>">
	<input type=hidden name="TYPE" value="<%=strWKType%>">
	<table width="70%" align="center" cellspacing="1" border=0 cellpadding="5" style="margin:0 auto;">
		<tr class="formhead"> 
			<td colspan=2 ><%=dbLabelBean.getLabel("label.administration.workflowdetails",strsesLanguage)%></td>
		</tr>
	
	<% 
		String strDisButton="";
		if(strVal.equals("0"))
		{
			strDisButton="DISABLED";
		//No data
		}
	%>
		<tr> 
			<td align="left" class="formtr1"><%=dbLabelBean.getLabel("label.administration.approversname",strsesLanguage)%></td>
			<td align="left" class="formtr1"> 
			  <select class="action" name="UINFO" onChange="getUserID()">
				<option VALUE="-1"><%=dbLabelBean.getLabel("label.administration.select",strsesLanguage)%></option>
	            <% 
	
				/* 
				SELECT  USERID AS UID,.DBO.USER_NAME(USERID) AS UNAME,DESIG_ID,SITE_ID FROM M_USERINFO WHERE SITE_ID ="+strSiteId+" AND ROLE_ID<>'MATA' AND ROLE_ID<>'CHAIRMAN'  AND APPROVER_level = '3' AND APPLICATION_ID = 1 AND STATUS_ID=10 ORDER BY 2"
				*/
	            
				/// @shiv sharma on 26/3/2007 to show Global approval with there Site name- Open 
				String strsql="";
				//strsql="SELECT  USERID AS UID,.DBO.USER_NAME(USERID) AS UNAME,DESIG_ID FROM M_USERINFO WHERE SITE_ID ="+strSiteId+" AND ROLE_ID<>'MATA' AND ROLE_ID<>'CHAIRMAN' and APPROVER_level<>3 AND APPLICATION_ID = 1 AND STATUS_ID=10 ORDER BY 2" ;
				
				
				strsql="SELECT  USERID AS UID,.DBO.USER_NAME(USERID) AS UNAME,DESIG_ID "+
					  " FROM M_USERINFO WHERE SITE_ID ="+strSiteId+" AND ROLE_ID<>'MATA' AND ROLE_ID<>'CHAIRMAN' " +
					  " and APPROVER_level<>3 AND APPLICATION_ID = 1 AND STATUS_ID=10 " +
					 " union select M_USERINFO.userid, .DBO.USER_NAME(M_USERINFO.userid) AS UNAME,DESIG_ID "  +
				 	" from user_site_access inner join M_USERINFO  on M_USERINFO.userid =  user_site_access.userid WHERE user_site_access.SITE_ID = "+strSiteId+" "+ 
					" AND M_USERINFO.APPLICATION_ID = 1 AND M_USERINFO.STATUS_ID=10 and user_site_access.STATUS_ID=10 "+
					" ORDER BY 2  ";
				
					
			    objRs = dbConBean.executeQuery(strsql);		
				
	   			while (objRs.next()) {
	              %>
				<option VALUE=<%=objRs.getInt("UID") %>><%= objRs.getString("UNAME") %></option>
				<% }
			   objRs.close();
			   
	
	           
			   strsql="SELECT USERID, .DBO.USER_NAME(USERID) AS UNAME FROM M_USERINFO WHERE ROLE_ID='MATA'AND STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY 2";	
			   
			   objRs = dbConBean.executeQuery(strsql);
			   while(objRs.next()){
				%>
				<option VALUE=<%=objRs.getInt("USERID") %>><%= objRs.getString("UNAME") %></option>
				<% }
			   objRs.close();
	
			   
			   strsql="SELECT USERID, .DBO.USER_NAME(USERID) AS UNAME,.DBO.SITENAME_FROM_USERID(USERID) AS SNAME FROM M_USERINFO WHERE ROLE_ID='CHAIRMAN'AND STATUS_ID=10 AND APPLICATION_ID=1";
			   
			   objRs = dbConBean.executeQuery(strsql);
			   while(objRs.next()){
				%>
				<option VALUE=<%=objRs.getInt("USERID") %>><%= objRs.getString("UNAME") %> -<%= objRs.getString("SNAME") %>-<B>(<%=dbLabelBean.getLabel("label.administration.chairman",strsesLanguage)%>)</B></option>
				<% }
			   objRs.close();
	
			   strsql="SELECT USERID, .DBO.USER_NAME(USERID) AS UNAME,.DBO.SITENAME_FROM_USERID(USERID) AS SNAME FROM M_USERINFO WHERE                                   		     APPROVER_level=3 AND ROLE_ID<>'CHAIRMAN' AND   STATUS_ID=10 AND APPLICATION_ID=1  order  by UNAME ";     
			   
			   objRs = dbConBean.executeQuery(strsql);
			  while(objRs.next())
				  {
				 	%>
				<option VALUE=<%=objRs.getInt("USERID") %>><%= objRs.getString("UNAME") %>-<%= objRs.getString("SNAME") %><B>(<%=dbLabelBean.getLabel("label.administration.global",strsesLanguage)%>)</B></option>
				<% 
					}
			   objRs.close();
			   %>
			   
	             <!-- // @shiv sharma on 26/3/2007 to show Global approval with there Site name--closed    -->
	
				 <%
	
				   strSql="SELECT ISNULL(USERID,'') AS USERID ,ISNULL(SITE_ID,'') AS  SITE_ID FROM  USER_MULTIPLE_ACCESS  WHERE site_id="+strSiteId+"  and unit_head=1  and status_id=10 ";
	
	                objRs = dbConBean.executeQuery(strSql);
			
				  while(objRs.next())
				  {      
					     
						strUserid=objRs.getString("USERID");
					   strSql="SELECT ISNULL(USERID,'') AS USERID, ISNULL(.DBO.USER_NAME(USERID),'') AS UNAME,ISNULL(.DBO.SITENAME_FROM_USERID(USERID),'') AS SNAME FROM M_USERINFO WHERE   userid="+strUserid+" and   STATUS_ID=10 AND APPLICATION_ID=1  ";
	
			       objRs1 = dbConBean1.executeQuery(strSql);
			       
				     while(objRs1.next())
					  {  
						     
						  %>
						<option VALUE=<%=strUserid%>><%= objRs1.getString("UNAME") %>(<%=dbLabelBean.getLabel("label.requestdetails.unithead",strsesLanguage)%>)</option>
							<%
	
					  }//objRs1.close();
	
	
				  }
	             objRs.close();
	
				 %> 
	
			</select>
			<script language = JavaScript>
			window.document.frm.UINFO.value = "<%= strUserID %>";
			</script>
			</td>
		</tr>
	
		<tr> 
			<td align="left" class="formtr1"><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%></td>
			<td align="left" class="formtr1"> 
			<input type = "text" name = "DESIGNINFO1" size = "30" value = "" readonly>
				<% 
				String strDesigID = "-1";
				objRs = dbConBean.executeQuery("SELECT DESIG_ID FROM M_USERINFO WHERE USERID = "+strUserID);
				while(objRs.next()){ 
					 strDesigID = objRs.getString("DESIG_ID");
				}
					 //			objRs = dbConBean.executeQuery("SELECT  RTRIM(ISNULL(DESIG_ID ,'')) AS DESIGID,RTRIM(ISNULL(DESIG_DESC,'')) AS DESIGNAME FROM M_DESIGNATION WHERE  DESIG_ID = "+strDesigID+"STATUS_ID=10 AND APPLICATION_ID = 1 ORDER BY 2");
				objRs = dbConBean.executeQuery("SELECT  RTRIM(ISNULL(DESIG_ID ,'')) AS DESIGID,RTRIM(ISNULL(DESIG_DESC,'')) AS DESIGNAME FROM M_DESIGNATION WHERE  DESIG_ID = "+strDesigID+"AND APPLICATION_ID = 1 ORDER BY 2");
				while (objRs.next()){	
				%>
				<input type = "hidden" name = "DESIGINFO" value = "<%= objRs.getString("DESIGID") %>">
			<script language = JavaScript>
			window.document.frm.DESIGNINFO1.value = "<%= objRs.getString("DESIGNAME") %>";
			</script>
	
				<% }%>
			 
			</td>
		</tr>
	
	
		<tr> 
			<td align="left" class="formtr1"><%=dbLabelBean.getLabel("label.administration.orderofapproval",strsesLanguage)%></td>
			<td align="left" class="formtr1"> 
			<select class="action" name="ORD" onchange="enabletext();">
				
				<option VALUE="0"><%=dbLabelBean.getLabel("label.administration.select",strsesLanguage)%></option>
				<option value="1">1.00</option>	
				<option value="2">2.00</option>	
				<option value="3">3.00</option>	
				<option value="4">4.00</option>							
				<option value="5">5.00</option>				
				<option value="6">6.00</option>				
				<option value="7">7.00</option>	
				<option value="8">8.00</option>	
				<option value="9">9.00</option>	
				<option value="10">10.00</option>							
			</select>
			</td>
		</tr>
	
		<tr> 
			<td align="left" class="formtr1"><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%></td>
			<td align="left" class="formtr1"> 
			<select class="action" name="TTYPE">			
				<option VALUE="0"><%=dbLabelBean.getLabel("label.report.selecttraveltype",strsesLanguage)%></option>
				<option VALUE="D"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage)%></option>
				<option VALUE="I"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%></option> 
			</select>
			</td>
		</tr>
		
		<%//change by manoj remove && SuserRole.equals("AD")
		//if(strsmrsiteflag.equalsIgnoreCase("y"))
		//{
	    %>
		
		<tr> 
			<td align="left" class="formtr1"><%=dbLabelBean.getLabel("label.administration.workflownumber",strsesLanguage) %></td>
			<td align="left" class="formtr1"> 
			<input name="sprole"  size="1" maxlength="2" onKeyUp="return test1('sprole', 2, 'n')" >
			</td>
		</tr>
		<%//}
		%>
		<!-- added by manoj -->	
						<tr>
						<td align="left" class="formtr1"><%=dbLabelBean.getLabel("label.administration.remark",strsesLanguage)%></td>
			               <td align="left" class="formtr1">  
			                   <INPUT TYPE="text" NAME="remark" size="40" maxlength="200" onKeyUp="test1('remark',300,'all');">
			        	</td>
						</tr>
		<!-- code added by shiv for addding CC mail for MATA associate on 27-Mar-08 -->
	        <% if(SuserRole.equalsIgnoreCase("AD")) 
		             {  
						%> 
					
						
					<tr> <td align="left" class="formtr1"><%=dbLabelBean.getLabel("label.administration.entermailidofmataassociate",strsesLanguage)%></td>
			               <td align="left" class="formtr1">  
			                   <INPUT TYPE="text" NAME="mail_ids" size="40" maxlength="200"  onKeyUp="test1('mail_ids',300,'all');">
			        </td>
		             </tr>
			<%
				  }
		%>
		<tr> 
			<td colspan="4" align="center" class="formhead"> 
			<input type="button" name="Submit32" value="<%=dbLabelBean.getLabel("button.administration.back",strsesLanguage)%>" class="formButton" onClick="moveBack();">
			<input type="button" name="Submit3" value="<%=dbLabelBean.getLabel("label.master.add",strsesLanguage)%>"  class="formButton" onClick="ChekData();">
			</td>
		</tr>
	</table>
	</form>
	
	<!--  This only block only shown for those Unit's whose TRAVEL_AGENCY_ID is 2 (Belongs to MATA GmbH...) added by Sandeep Malik on 12/08/2015 --> 
	<% if(strSiteTravelAgencyID != null && "2".equals(strSiteTravelAgencyID.trim())){
	
			Map dataMap = (Map)new starDaoImpl().getMATA_GmbH_WorkflowMatrixData(strSiteId);
			
			WorkflowApprovalMatrix matrixWithFlightDom 		= null;
			WorkflowApprovalMatrix matrixWithoutFlightDom 	= null;
			WorkflowApprovalMatrix matrixWithFlightInt 		= null;
			
			if(dataMap != null && !dataMap.isEmpty()){
				matrixWithFlightDom 		=	dataMap.get("D-1") != null ? (WorkflowApprovalMatrix)dataMap.get("D-1") : null;
				matrixWithoutFlightDom		=	dataMap.get("D-0") != null ? (WorkflowApprovalMatrix)dataMap.get("D-0") : null;
				matrixWithFlightInt			=	dataMap.get("I-1") != null ? (WorkflowApprovalMatrix)dataMap.get("I-1") : null;
			}
			
	%>
	
	<script type="text/javascript">
		var message = '<%=request.getParameter("message")%>';
		if(message != null && message != '' && message != 'null' ){
			alert(message);
		}
	</script>
	<div style="margin:0 auto;">
	<form method=post name="approvalLevelForm" action="approvalworkflow">
		<input type=hidden name="ID" value="<%=strSiteId%>">
		<input type=hidden name="TYPE" value="<%=strWKType%>">
		<input type="hidden" name="actionType" id="actionType" value="enableApproverLevels"/>
		<table width="58%" border="0" align="center" cellpadding="2" cellspacing="1" style="padding-bottom: 15px;margin:0 auto;">
			<tr class="formhead"> 
				<td colspan="7"><%=dbLabelBean.getLabel("label.global.travelworkflowmatrixheading",strsesLanguage)%></td> 
		  </tr>
		  <tr> 
			<td class="formhead" ><b><%=dbLabelBean.getLabel("label.report.traveltype",strsesLanguage)%></b></td> 
			<td class="formhead" ><b><%=dbLabelBean.getLabel("label.global.approverlevel1",strsesLanguage)%></b></td>
			<td class="formhead"><%=dbLabelBean.getLabel("label.global.approverlevel2",strsesLanguage)%></td>
			<td class="formhead"><%=dbLabelBean.getLabel("label.user.defaultapprover",strsesLanguage)%></td>
			<%-- <td class="formhead"><%=dbLabelBean.getLabel("label.requestdetails.billingapprover",strsesLanguage)%></td> --%>
		  </tr>
		  <tr> 
			<td class="formtr2" ><b><%=dbLabelBean.getLabel("label.global.domesticwithflight",strsesLanguage)%></b></td> 
			<td class="formtr2" ><input type="checkbox" name="domWithFlightLevel1" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isApproverLevel_1_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" name="domWithFlightLevel2" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isApproverLevel_2_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" name="domWithFlightDefault" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isDefaultApproversEnable()) ? "checked" : ""  %>/></td>
<%-- 			<td class="formtr2" ><input type="checkbox" name="domWithFlightBillingApp" <%=(matrixWithFlightDom != null && matrixWithFlightDom.isBillingApproversEnable()) ? "checked" : ""  %>/></td>
 --%>		  </tr>
		  <tr> 
			<td class="formtr2" ><b><%=dbLabelBean.getLabel("label.global.domesticwithoutflight",strsesLanguage)%></b></td> 
			<td class="formtr2" ><input type="checkbox" name="domWithoutFlightLevel1" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isApproverLevel_1_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" name="domWithoutFlightLevel2" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isApproverLevel_2_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" name="domWithoutDefault" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isDefaultApproversEnable()) ? "checked" : ""  %>/></td>
<%-- 			<td class="formtr2" ><input type="checkbox" name="domWithoutFlightBillingApp" <%=(matrixWithoutFlightDom != null && matrixWithoutFlightDom.isBillingApproversEnable()) ? "checked" : ""  %>/></td>
 --%>		  </tr>
		  <tr> 
			<td class="formtr2" ><b><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%></b></td> 
			<td class="formtr2" ><input type="checkbox" name="interLevel1" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isApproverLevel_1_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" name="interLevel2" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isApproverLevel_2_Enable()) ? "checked" : ""  %>/></td>
			<td class="formtr2" ><input type="checkbox" name="interDefault" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isDefaultApproversEnable()) ? "checked" : ""  %>/></td>
<%-- 			<td class="formtr2" ><input type="checkbox" name="interBillingApp" <%=(matrixWithFlightInt != null && matrixWithFlightInt.isBillingApproversEnable()) ? "checked" : ""  %>/></td>
 --%>		  </tr>
		  <tr> 
			<td colspan="5" align="center" class="formhead" > 
			<input type="button" name="Submit11" value="<%=dbLabelBean.getLabel("label.global.travelmatrixBtn",strsesLanguage)%>"  class="formButton" style="margin: 3px 0 3px 0;" onClick="submitEnableApproverLevelForm();"/>
			</td>
			</tr>
		</table>
	</form>
	</div>
	<%} %>
	
	<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" style="margin:0 auto;">
	  <tr class="formhead"> 
		<td colspan="7"><%=dbLabelBean.getLabel("label.administration.workflowdetails",strsesLanguage)%></td> 
	  </tr>
	  <tr > 
		<td class="formhead" ><b>S.No</b></td> 
		<td class="formhead" ><b>Name</b></td>
		<td class="formhead">Designation</td>
		<td class="formhead">Order of Approval</td>
		<td class="formhead">Workflow Number</td>
		<td class="formhead">Travel Type</td>
		<td align="left" class="formhead" colspan="2">Action</td>
	  </tr>
	
	<%
	String strListParam="";
	strListParam=" AND M_DEFAULT_APPROVERS.SITE_ID='"+strSiteId.trim()+"' ";
	%>
	
	<% 
	String strMaxOrderId	=	"";
		//change in queries by manoj chand on 01 mar 2012 to resolve issue of showing old designation in domestic workflow	
	strSql="SELECT  DA_ID , .DBO.USER_NAME(APPROVER_ID) AS APP , .DBO.DESIGNATIONNAME(MU.DESIG_ID) AS DESIGNAME ,"+ 
		" .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE , ORDER_ID , M_DEFAULT_APPROVERS.sp_role , RTRIM(TRV_TYPE) AS TRV_TYPE ,"+
		" CASE WHEN order_id= ( SELECT  max(order_id) FROM    M_DEFAULT_APPROVERS MDA"+
		" WHERE   MDA.APPLICATION_ID = M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID"+
		" AND MDA.SITE_ID = M_DEFAULT_APPROVERS.SITE_ID AND MDA.TRV_TYPE = M_DEFAULT_APPROVERS.TRV_TYPE AND MDA.sp_role = M_DEFAULT_APPROVERS.sp_role )"+
		" THEN 'y' ELSE 'n' END AS FLAG"+
		" FROM    M_DEFAULT_APPROVERS INNER JOIN M_USERINFO MU ON M_DEFAULT_APPROVERS.APPROVER_ID=MU.USERID"+
		" WHERE   M_DEFAULT_APPROVERS.APPLICATION_ID= 1 AND M_DEFAULT_APPROVERS.STATUS_ID= 10 AND MU.STATUS_ID=10 "+strListParam+" AND TRV_TYPE= 'd'"+
		" ORDER BY sp_role , ORDER_ID";	
		//System.out.println("strSql---dm if smr--->"+strSql);

	// code changed by shiv on 26-Sep-07  
	String strtextforCC ="";
	String strApprovername="";
	String strApproverDesgName="";
	String strApproverRole="";
	String strOrderId="";
	String strSprole="0";
	String strremarks = "";
	String strremarksflag = "";
	objRs = dbConBean.executeQuery(strSql); 
	
	while (objRs.next()) {
		String strID = 	objRs.getString(1);  
	    strApprovername=objRs.getString("APP");
		strApproverDesgName=objRs.getString("DESIGNAME").trim();
		strApproverRole	= objRs.getString("APPROVER_ROLE");
		strOrderId	= objRs.getString("ORDER_ID");
		strSprole	=objRs.getString("sp_role");
		String strTrvID = objRs.getString("TRV_TYPE");
		String strMaxorder=objRs.getString("FLAG");
		/*if(strOrderId!=null && strOrderId.trim().equals(strMaxOrderId)){ 
			strtextforCC="Email";
		}else{
			strtextforCC="";
		}*/
		if(strOrderId!=null && strMaxorder.trim().equals("y")){ 
			strtextforCC=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage);
		}else{
			strtextforCC="";
		}
		
		%>
	
		<tr> 
	
			<td class="formtr2"><%=iLoop++%></td>
			
	        <td class="formtr2"><%= strApprovername%></td> 
			<td class="formtr2"><%= strApproverDesgName%></td> 
			<td class="formtr2"><%= strOrderId %></td>	
	    	<td class="formtr2"><%= strSprole %></td>		 
			<%	//String strTrvID = objRs.getString("TRV_TYPE"); %>
			<%if (strTrvID.equals("I")){ %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%></td>
			<% } else if(strTrvID.equals("D")){  %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage)%></td>
			<% } %> 
			
	 		<td  align="center" class="formtr2"> <a href="#" onclick="MM_openBrWindow('T_showRemarkhistory.jsp?Sprole=<%= strSprole%>&wftype=1&TYPE=<%= strWKType%>&ID=<%=strSiteId%>&VAL=<%=strVal%>&DELID=<%= strID %>&ORDER=<%=strOrderId %>&DESIG=<%=strApproverDesgName %>&site_id=<%=strSiteId%>&smrsite=<%=strsmrsiteflag %>&traveltype=D&fromlink=delete','DELETE',' top=200,left=55, scrollbars=no,resizable=no,width=895,height=370')" ><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%></a>
	 		<%if(SuserRole.equalsIgnoreCase("AD") && !strtextforCC.equals(""))  
	        { %>
			  | <a href="#" class="datacell" onClick="MM_openBrWindow('T_showMataassociate.jsp?strSprole=<%= strSprole%>&wftype=1&site_id=<%=strSiteId%>','SEARCH',' top=223,left=170 scrollbars=yes,resizable=yes,width=565,height=270')">  
			<%=strtextforCC%>
			</a>
			<%} %>
			<%if(!strtextforCC.equals("")) {%>
	 		| <a href="#" class="datacell" onClick="MM_openBrWindow('T_showRemarkhistory.jsp?Sprole=<%= strSprole%>&site_id=<%=strSiteId%>&smrsite=<%=strsmrsiteflag %>&traveltype=D&fromlink=history','HISTORY',' top=200,left=55 scrollbars=no,resizable=no,width=895,height=290')" > <%=dbLabelBean.getLabel("label.approverequest.history",strsesLanguage)%> </a>
	 		<%} %>
	 		</td>  
		</tr>
	<%  } %>
		<tr>	
			<td colspan="8" align="center" class="formhead">  
			<br>
			<br>
			</td>
		</tr>
		
		<% 
		iLoop=1;

		strSql="SELECT  DA_ID , .DBO.USER_NAME(APPROVER_ID) AS APP , .DBO.DESIGNATIONNAME(MU.DESIG_ID) AS DESIGNAME , "+
			" .DBO.USER_ROLE(APPROVER_ID) AS APPROVER_ROLE , ORDER_ID , M_DEFAULT_APPROVERS.sp_role ,  RTRIM(TRV_TYPE) AS TRV_TYPE ,"+
			" CASE  WHEN order_id = ( SELECT  max(order_id) FROM    M_DEFAULT_APPROVERS MDA"+
			" WHERE   MDA.APPLICATION_ID = M_DEFAULT_APPROVERS.APPLICATION_ID AND MDA.STATUS_ID = M_DEFAULT_APPROVERS.STATUS_ID"+
			" AND MDA.SITE_ID = M_DEFAULT_APPROVERS.SITE_ID AND MDA.TRV_TYPE = M_DEFAULT_APPROVERS.TRV_TYPE"+
			" AND MDA.sp_role = M_DEFAULT_APPROVERS.sp_role ) THEN 'y' ELSE 'n' END AS FLAG"+
			" FROM    M_DEFAULT_APPROVERS INNER JOIN M_USERINFO MU ON M_DEFAULT_APPROVERS.APPROVER_ID=MU.USERID"+
			" WHERE   M_DEFAULT_APPROVERS.APPLICATION_ID= 1 AND M_DEFAULT_APPROVERS.STATUS_ID= 10 AND MU.STATUS_ID=10 "+strListParam+" AND TRV_TYPE= 'i'"+
			" ORDER BY sp_role , ORDER_ID";

	 
	objRs = dbConBean.executeQuery(strSql); 
	while (objRs.next()) {
		String strID = 	objRs.getString(1);  
	    strApprovername=objRs.getString("APP");
		strApproverDesgName=objRs.getString("DESIGNAME").trim();
		strApproverRole	= objRs.getString("APPROVER_ROLE");
		strOrderId	= objRs.getString("ORDER_ID");
		strSprole    = objRs.getString("sp_role");
		String strTrvID = objRs.getString("TRV_TYPE");
		String strMaxorder=objRs.getString("FLAG");
		/*if(strOrderId!=null && strOrderId.trim().equals(strMaxOrderId)){ 
			strtextforCC="Email"; 
		}else{
			strtextforCC="";
		}*/
		if(strOrderId!=null && strMaxorder.trim().equals("y")){ 
			strtextforCC=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage); 
		}else{
			strtextforCC="";
		}
%>
	
		<tr> 
	   
			<td class="formtr2"><%=iLoop++%></td>
			
	        <td class="formtr2"><%= strApprovername%></td> 
			<td class="formtr2"><%= strApproverDesgName%></td> 
			<td class="formtr2"><%= strOrderId %></td>
			<td class="formtr2"><%= strSprole %></td>
			<%	//String strTrvID = objRs.getString("TRV_TYPE"); %>
			<%if (strTrvID.equals("I")){ %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.international",strsesLanguage)%></td>
			<% } else if(strTrvID.equals("D")){  %>
			<td class="formtr2"><%=dbLabelBean.getLabel("label.report.domestic",strsesLanguage)%></td>
			<% } %> 
	 		<td  align="center" class="formtr2"><a href="#"  onclick="MM_openBrWindow('T_showRemarkhistory.jsp?Sprole=<%= strSprole%>&wftype=2&TYPE=<%= strWKType%>&ID=<%=strSiteId%>&VAL=<%=strVal%>&DELID=<%= strID %>&ORDER=<%=strOrderId %>&DESIG=<%=strApproverDesgName %>&site_id=<%=strSiteId%>&smrsite=<%=strsmrsiteflag %>&traveltype=I&fromlink=delete','DELETE','top=200,left=55,scrollbars=no,resizable=no,width=895,height=370')"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage)%></a>
	 		<%if(SuserRole.equalsIgnoreCase("AD") && !strtextforCC.equals(""))  
	        { %>
			  | <a href="#" class="datacell" onClick="MM_openBrWindow('T_showMataassociate.jsp?strSprole=<%= strSprole%>&wftype=2&site_id=<%=strSiteId%>','SEARCH',' top=223,left=200 scrollbars=yes,resizable=yes,width=565,height=270')">  
			<%=strtextforCC%>
			</a>
			<%}%>
			<%if(!strtextforCC.equals("")){ %>
	 		  | <a href="#" class="datacell" onClick="MM_openBrWindow('T_showRemarkhistory.jsp?Sprole=<%= strSprole%>&site_id=<%=strSiteId%>&smrsite=<%=strsmrsiteflag %>&traveltype=I&fromlink=history','HISTORY',' top=200,left=55 scrollbars=no,resizable=no,width=895,height=290');"> <%=dbLabelBean.getLabel("label.approverequest.history",strsesLanguage)%> </a>
	 		  <%} %>
	 		</td>  
		</tr>
	<%  } %>
		<tr>	
			<td colspan="8" align="center" class="formhead"> 
			<br>
			<br>
			</td>
		</tr>
	</table>
	</body>
	</html>