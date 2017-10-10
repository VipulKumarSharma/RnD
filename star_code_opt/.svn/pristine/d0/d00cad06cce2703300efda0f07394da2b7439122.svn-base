<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:29 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is the first JSP to show originator and mail to whom. 
                    
 *Modification 			: 1 Change code for showing user of  workflow if user selects billing site other than his    
								      own site by Shiv Sharma on  5th Nov in order by. 
  *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
*******************************************************/
%>
<html>
<head>
<%@ page pageEncoding="UTF-8" %>
<%@ include file="importStatement.jsp" %>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<%-- include page styles  --%>
<%-- <%@ include  file="systemStyle.jsp" %> --%>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript1.2" src="ScriptLibrary/main.js?buildstamp=2_0_0"type="text/javascript"></SCRIPT>
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
</head>
 <body>
<%

// code added

StringBuffer  strEmailAppend = new StringBuffer(50);
StringBuffer  strNameAppend	= new StringBuffer(50);
String strTextValue="";
String strTextName="";

// code ends

// Variables declared and initialized

Connection con				=		null;			    // Object for connection
Statement stmt				=		null;			   // Object for Statement
ResultSet rs				=		null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);
String	 sSqlStr					=	""; // For sql Statements
String strTravelId		=	""; // Object to store Sanction ID
strTravelId				=	request.getParameter("purchaseRequisitionId"); //getting travel id for taking out orignator name
//System.out.println("strTravelId ********* "+strTravelId);

String strToAppend 				=	request.getParameter("toAppend");
String strToappendName			= request.getParameter("toappendName");
//System.out.println("1111111111111111 "+strToappendName);
if(strToappendName.equals(null))
{
strToappendName="";
}
//System.out.println("toappendName "+strToappendName);


if(strToAppend.equals("-") || strToAppend.equals("") )
{
	strToAppend="";
}
else
{
strEmailAppend.append(strToAppend);
strEmailAppend.append(";");
strTextValue = strEmailAppend.toString();
}


if(strToappendName.equals("-"))
{
	strToappendName="";
}
else
{
	strNameAppend.append(strToappendName);
	strNameAppend.append(";");
	strTextName = strNameAppend.toString();
}
String strToName					=	"";
String strToEmail					=	"";
String strToID						=	"";
int iCls							=	0;
String strStyleCls					=	"";
String strTypeID					=	"";
strTypeID							=	request.getParameter("id"); // to get wheather to show approvers or originators

String Travel_Type = request.getParameter("Travel_Type");

if(strTypeID.trim().equals("1"))
{
	if(Travel_Type.equals("International Travel"))
	{
		sSqlStr = "select dbo.user_name(userid),dbo.USEREMAIL(userid) from m_userinfo where userid = (select c_userid from t_travel_mst where travel_req_id = (select TRAVEL_REQ_ID from t_travel_detail_int where TRAVEL_ID="+ strTravelId +"))"; 
	}	
	else
	{
		sSqlStr = "select dbo.user_name(userid),dbo.USEREMAIL(userid) from m_userinfo where userid = (select c_userid from t_travel_mst where travel_req_id = (select TRAVEL_REQ_ID from t_travel_detail_DOM where TRAVEL_ID="+ strTravelId +"))"; 
		//System.out.println(" in domestic of mailuserpicker sSqlStr --> "+sSqlStr);
	}
//System.out.println(" in domestic of mailuserpicker sSqlStr --> "+sSqlStr);
}

else if(strTypeID.trim().equals("2"))
{
	//System.out.println("strTypeID ********* "+strTypeID);
	// changed query by shiv on 06-Nov-07
	
	if(Travel_Type.equals("International Travel"))
	{
	 sSqlStr="SELECT dbo.USER_NAME(APPROVER_ID) as APPROVER_NAME ,dbo.USEREMAIL(APPROVER_ID),order_id FROM T_APPROVERS WHERE TRAVEL_ID ='"+strTravelId +"' AND TRAVEL_TYPE='I' order by 3" ;
	//System.out.println("sSqlStr -00000->"+sSqlStr);
	}
	else
	{
   // changed query by shiv on 06-Nov-07
	sSqlStr="SELECT dbo.USER_NAME(APPROVER_ID) as APPROVER_NAME ,dbo.USEREMAIL(APPROVER_ID),order_id FROM  T_APPROVERS WHERE TRAVEL_ID ='"+strTravelId +"' AND TRAVEL_TYPE='D'  order by 3";
	///System.out.println("sSqlStr -----> "+sSqlStr);
	}
}	

stmt = con.createStatement(); 

rs = stmt.executeQuery(sSqlStr);

%>
<table width="90%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left" valign="top" class="formhead"> 
<td>#</td>
<td><%=dbLabelBean.getLabel("label.requestdetails.name",strsesLanguage)%></td>
<td><%=dbLabelBean.getLabel("label.global.emailid",strsesLanguage)%></td>
</tr>
<%
int i=1;
while(rs.next())
{
	//System.out.println("5678 *********  ");
	strToName	 =	rs.getString(1);
	strToEmail	 =	rs.getString(2);

%>
<%
	if (iCls%2 == 0) { 
		strStyleCls="formtr2";
    } else { 
		strStyleCls="formtr1";
    } 


	  iCls++;
%>
<tr align="left" valign="top" class="<%=strStyleCls%>"> 
<td><%=i++%></td>


<td><A HREF="#" onClick="opener.frm.mailTo.value='<%=strToEmail.trim()%>';opener.frm.mailToName.value='<%=strTextName.trim()+strToName.trim()%>';opener.frm.toMail.value='<%=strTextValue.trim()+strToEmail.trim()%>';window.close();"><%=strToName%></A></td>
<td><%=strToEmail%></td>

</tr>
<%
	
}
rs.close();
stmt.close();
%>

</table>


