<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Shiv sharma 
 *Date of Creation 		:31 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			: This is the jsp page to show the list of versions of STARS application.
 *Modification 			: By KAVERI GARG
 *Reason of Modification: Functionality added to add, update and delete versions of STARS in database.
 *Date of Modification  : 29 August, 2012
 *Editor				: Eclipse
 *******************************************************/
%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8"%>
<!--  errorPage="error.jsp"  -->
<%@page import="java.net.URLDecoder"%>
<HTML>
<HEAD>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include page styles  --%>
	<%--<%@ include  file="systemStyle.jsp" %>--%>	
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
 	<script type="text/javascript" language="JavaScript1.2" src="menu/stm31.js?buildstamp=2_0_0"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script>
	//rightClick(); 
	function deleteConfirm(ver_id)
	{
		var strReleaseId=ver_id;
		if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage) %>'))
    	{
	    	 document.frm.action="T_VersionPost.jsp?action1=delete&ReleaseVersionId="+strReleaseId;
	    	 document.frm.submit();
	    	return true;
	    	}
	    else
	    {
	    	return false;
		}
	}
	</script>
	
	<style type="text/css">
	.linkout {
		font-family:Arial, Helvetica, sans-serif;
		font-size:11px;
		BACKGROUND:#E7F2F8;
		COLOR:#147CAF;
		line-height:17px; 
		text-align:left;
		} 
    .linkover {
		font-family:Arial, Helvetica, sans-serif;
		font-size:11px;
		BACKGROUND:#F0F8FB; 
		COLOR:#147CAF; 
		font-weight:normal; 
		line-height:21px;
		text-align:left;
} 
	
	</style>
	
	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	
	<%
	String	strMsg	=	URLDecoder.decode((request.getParameter("strMsg")==null)?"":request.getParameter("strMsg"), "UTF-8");
	%>
	<base target="middle">
	</head>
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<form name="frm" action="" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  
	   <tr>
    <td height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.version.versionhistory",strsesLanguage) %>   &nbsp;&nbsp;</li><font color='red'><%=strMsg%></font>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td align="right" >
      <ul id="list-nav">
            <li><a href="T_addVersion.jsp"><%=dbLabelBean.getLabel("button.global.new",strsesLanguage) %></a></li>
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      </ul>
      </td>
       </tr>
    </table>
	</td>
  </tr>
	  
	 
	  </table>
	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	<tr align="left" class="formhead"> 
	    <td width="3%" nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.sno",strsesLanguage) %></td>
	    <td width="8%"><%=dbLabelBean.getLabel("label.version.releasedate",strsesLanguage) %></td>
	    <td width="9%"><%=dbLabelBean.getLabel("label.version.releaseversion",strsesLanguage) %></td>
		<td width="10%" ><%=dbLabelBean.getLabel("label.version.releaseby",strsesLanguage) %></td>
	    <td width="8%"><%=dbLabelBean.getLabel("label.version.releasetype",strsesLanguage) %></td>
		<td width="24%"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
	    <td width="8%"><%=dbLabelBean.getLabel("label.administration.createdby",strsesLanguage)%></td>
	    <td width="8%"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td> 
	    <td width="7%"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage)%></td>
	</tr>
	
	
	
	
	<%
	String strUserId    =   null;
	ResultSet rs,rs1	=	null;
	
	
	
		int					intSno					=  1 ;
		String			    strReleaseId			=  "";		
		String				strReleaseDate			=  "";			// release date
		String				strReleaseVersion		=  "";          // release version
		String				strReleaseBy			=  "";          // release by
		String				strReleaseType			=  "";          // release type
		String				strRemarks				=  "";          // remarks
		String				strCUser				=  "";          // created by
		String				strCDate				=  "";          // created date
		String				strUUser				=  "";          // updated by
		String				strUDate				=  "";          // updated on
		String				strAction				=  "";          // action taken
		String strStyleCls		=""; 
		int iCls = 0;
		
	String strSql="";
	strSql  =" SELECT VER_REL_LOG_ID,CONVERT(VARCHAR(11),RELEASE_DATE,100) AS RELEASE_DATE, "+
		     " RELEASE_VERSION,RELEASE_BY,RELEASE_TYPE,REMARKS,.DBO.USER_NAME(C_USER) AS C_USER, " +
		     " CONVERT(VARCHAR(20),C_DATE,100) AS C_DATE FROM VERSION_RELEASE_LOG  ORDER BY VER_REL_LOG_ID DESC,APP_NAME DESC";
	
	
	rs = dbConBean.executeQuery(strSql);         //get the result set
	
	while(rs.next())
	{
		strReleaseId                        = rs.getString("VER_REL_LOG_ID");
		strReleaseDate						= rs.getString("RELEASE_DATE");       // RELEASE_DATE
		strReleaseVersion				    = rs.getString("RELEASE_VERSION");       //RELEASE_VERSION
		strReleaseBy						= rs.getString("RELEASE_BY");       // RELEASE_BY
		strReleaseType						= rs.getString("RELEASE_TYPE");       // RELEASE_TYPE
		strRemarks							= rs.getString("REMARKS");       // REMARKS
		strCUser							= rs.getString("C_USER");       // C_USER
		strCDate							= rs.getString("C_DATE");       // C_DATE
    
	if (iCls%2 == 0) 
	{ 
		strStyleCls="formtr2";
    } 
	else 
	{ 
		strStyleCls="formtr1";
    } 


	  iCls++;
%>
   <tr  class="<%=strStyleCls %>"  ><!-- onmouseover="this.className='linkover'" onmouseout="this.className='linkout'" --> 
    <td width="3%" valign="top"><%=intSno%></td>
    <td width="8%" valign="top"><%=strReleaseDate.trim()%></td>
    <td width="9%" valign="top"><%=strReleaseVersion.trim()%></td>
	<td width="10%" valign="top" ><%=strReleaseBy.trim()%></td>
	<td width="8%" valign="top"><%=strReleaseType.trim()%></td>
	<td width="24%" valign="top"><%=strRemarks%></td>
	<td width="8%" valign="top" ><%=strCUser.trim()%></td>
	<td width="8%" valign="top" ><%=strCDate.trim()%></td> 
	<td width="7%" valign="top" ><a href="T_EditVersion.jsp?ReleaseVersionId=<%=strReleaseId%>"><%=dbLabelBean.getLabel("link.createrequest.edit",strsesLanguage)%></a> | <a href="#" onClick="deleteConfirm(<%=strReleaseId%>);"><%=dbLabelBean.getLabel("link.createrequest.delete",strsesLanguage)%></a></td>
  </tr>
<%
intSno++;				
}
	rs.close();
	dbConBean.close();
	%>
	
	
	  <input type="hidden" name="strReleaseVersion" value="<%=strReleaseVersion%>">
	</table>
	<br>
	</form>
	</body>
	</html>
