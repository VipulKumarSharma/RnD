	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Himanshu Jain
	 *Date of Creation 		:06 September 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This jsp is used to Display information about the travel approver to the User.
	 *Modification 			: 
	 *Reason of Modification: 
	 *Date of Modification  : 
	 *Revision History		:
	 *Editor				:Editplus
	 
	 *Modified By	        :MANOJ CHAND
	 *Date of Modification  :17 Apr 2013
	 *Description			:add status_id=10 condition existing query 
	*******************************************************/%>
	
	<%@ page import = "src.connection.DbConnectionBean" %>
	<%@ include  file="importStatement.jsp" %>
	<html>
	<head>
	<%@ page pageEncoding="UTF-8" %>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<%-- include page styles  --%>
	<%--<%@ include  file="systemStyle.jsp" %>--%>
	
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="bean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<!-- <link rel="stylesheet" href="styles/fonts.css?buildstamp=2_0_0" type="text/css">
	<link rel="stylesheet" href="styles/links.css?buildstamp=2_0_0" type="text/css"> -->
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />  
	</head>
	<body class="body">
	<span id=main> </span>
	<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	<table width="90%"  align="center" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="50" class="bodyline-top">
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.global.myunitaccessiblelist",strsesLanguage)%></li> 
	    </ul></td>
	    <td align="right" valign="bottom" class="bodyline-top">
		<table align="right" border="0" cellspacing="0" cellpadding="0">  
	  <tr align ="right">
	  <td>
          <ul id="list-nav">
          <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
          </ul>
      </td>
	  </tr>
	  </table>
	</td>
	</tr>
	</table>
	
	<%
	// Variables declared and initialized
	//Connection con		=		null;			    // Object for connection
	//Statement stmt		=		null;			   // Object for Statement
	ResultSet rs		=		null;			  // Object for ResultSet
	int iCls = 0;
	String strStyleCls = "";
	//Create Connection
	//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	//con = DriverManager.getConnection("jdbc:odbc:star","sa","");
	
	String	sSqlStr					=	"";			// For sql Statements
	String strtravelRequisitionId	=	"";			//For holding Purchase Requisition Id
	String strTravellerId			=	"";
	String strTRAVEL_ID				=	"4211";
	strTravellerId					=	request.getParameter("userId");
	 
	 
	String strAPPROVE_ID			=	"";
	String strAPPROVER_Desig		=	"";
	String strAPPROVE_STATUS		=	"";
	String strAPPROVE_DATE			=	"";
	String strCreatedon				=	"";
	String strSiteName				=	"";
	String strDesigdesc				=	"";
	String sSqlStruser				=	"";
	int iLoop						=	1;
	//String travelReqno				=	"";
	//and M_SITE.STATUS_ID=10 and usa.STATUS_ID=10 condition added by manoj chand on 17 apr 2013
	sSqlStr="SELECT    M_SITE.SITE_NAME, dbo.CONVERTDATE(usa.C_DATE) AS c_date "+
	         " FROM USER_SITE_ACCESS AS usa INNER JOIN "+
			" M_SITE ON usa.SITE_ID = M_SITE.SITE_ID WHERE  (usa.USERID = "+strTravellerId+") and M_SITE.STATUS_ID=10 and usa.STATUS_ID=10";
	
	//SELECT dbo.USER_NAME(APPROVER_ID) as APPROVER_NAME ,ISNULL(dbo.DESIG_FROM_USERID(APPROVER_ID),'-') AS DESIGN_DESC ,ISNULL(dbo.CONVERTDATEDMY1(APPROVE_DATE),'-') AS APPROVE_DATE, APPROVE_STATUS FROM T_APPROVERS WHERE TRAVEL_ID ='"+strTravelId +"'AND TRAVELLER_ID ='"+ strTravellerId +"' AND TRAVEL_TYPE='I'  ORDER BY order_ID
	
	//System.out.println("sSqlStr--->"+sSqlStr);
	
	//System.out.println("********************************************************************************");
	%>
	<table width="90%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	  <tr class="formhead"> 
	    <td colspan="5" class="listhead"><%=dbLabelBean.getLabel("link.global.accessibleunits",strsesLanguage)%></td>
	  </tr>
	  <tr class="formhead"> 
	     <td width="3%" class="listhead">#</td>
	     <td width="25%" class="listhead"><%=dbLabelBean.getLabel("label.global.unitname",strsesLanguage)%></td> 
	     <td width="25%" class="listhead"><%=dbLabelBean.getLabel("label.global.createdon",strsesLanguage)%></td>
	    
	  </tr>
	
	<%	
		//System.out.println("sSqlStr --> "+sSqlStr);
	
			 
			
		rs = bean.executeQuery(sSqlStr);
	
	if(rs.next())
	{	 
		do{	 
		  strSiteName		=	rs.getString("SITE_NAME"); //C_DATE   
		  strCreatedon		=	rs.getString("C_DATE");
			   %>
				  <tr valign="top" class="formtr2"> 
			      <td width="3%" class="listdata"><%=iLoop++%></td>
			      <td width="25%"  class="listdata"><%=strSiteName%> </td> 
			      <td width="25%"  class="listdata"><%=strCreatedon%> </td> 
			 </tr>
			
			    <% 
		
		
			 
		}while(rs.next());
	}
	else{
		   %>
			  <tr valign="top" class="formtr2"> 
		      <td   colspan="3" class="listdata"><%=dbLabelBean.getLabel("label.approverequest.norecordfound",strsesLanguage)%> </td>   
		 </tr>
		
		    <% 
	
		
	}
		
	bean.close();
	//System.out.println("***********************************************************************************************************");
	%>
		 
	</body>
	  </html>
