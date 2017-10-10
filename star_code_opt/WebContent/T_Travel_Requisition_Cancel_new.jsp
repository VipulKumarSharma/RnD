<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Manoj 
 *Date of Creation 		:12 Jan 2011
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file for Cancel the Requisition from requisition movement report by the admin.
 *Editor				:Eclipse
 
 *Modification			:modification in the design and comment box
 *Modification Date		:18-jan-2011
 *Created by			:Manoj Chand
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" %>
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
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>

<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
function CheckDataSave()
{
	var a=document.frm.comments.value;
	if(a=="")
	{ 
		alert('<%=dbLabelBean.getLabel("alert.approverequest.yourcomments",strsesLanguage) %>');
		document.frm.comments.focus();
		return false;
	}
	else
	{
		if(confirm('<%=dbLabelBean.getLabel("alert.cancelrequest.cancelrecord",strsesLanguage) %>'))
			document.frm.submit();
		else
			return false;
	}
}
function CheckDataNext()
{
	document.frm.buttonData.value=1;
	document.frm.submit();
}

function CheckDataCriteria()
{
	window.location.href="sanctionCriteria.jsp";
}
function goback()
{
    history.go(-1);
}

function submitParent()
{
  window.opener.location = window.opener.location;
  window.close();
}

</script>
</head>
<%
// Variables declared and initialized
request.setCharacterEncoding("UTF-8");
String strTravelType   =  "";
String strWhichPage    =  "";
String strTargetFrame  =  "";
String strTargetFlag   =  "";
String strfinalUrl="";
strTravelType   =  request.getParameter("travelType"); 
strWhichPage    =  request.getParameter("whichPage"); 
//strfinalUrl   =  request.getParameter("final_url");
//System.out.println("strTravelType----*------>"+strTravelType);
//System.out.println("strWhichPage-----*----->"+strWhichPage);


Map params = request.getParameterMap();
    Iterator itr = params.keySet().iterator();
    //System.out.println("chandddddddddddddddddddd");
    String finalUrl="";
    while ( itr.hasNext() )
      {
        String key = (String) itr.next();
        String value = ((String[]) params.get( key ))[ 0 ];
        
        finalUrl += key+"="+value+"&";
        
      }
   // System.out.println("finalUrl 10= "+finalUrl);
    finalUrl = finalUrl.substring(0 ,  (finalUrl.length()-1) );
    //System.out.println("finalUrl 20= "+finalUrl);



if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
{
   strTravelType = "I";
}
if(strTravelType != null && strTravelType.equals("DOM"))   
{
   strTravelType = "D";
}

if(strWhichPage == null)
   strWhichPage = "#";

strTargetFlag    =  request.getParameter("targetFrame"); 
if(strTargetFlag !=null && strTargetFlag.equals("yes"))
{
     strTargetFrame="middle";  
}
else
   	strTargetFrame = "";


// Variables declared and initialized
Connection con	=	null;			    // Object for connection
Statement stmt	=	null;			   // Object for Statement
ResultSet rs	=	null;			  // Object for ResultSet
//Create Connection
Class.forName(Sdbdriver);
con=DriverManager.getConnection(Sdburl,Sdbuser,Sdbpwd);

String	sSqlStr                             =   ""; // For sql Statements
String strRequisitionId                		=	"";
strRequisitionId                        	=	request.getParameter("purchaseRequisitionId");
//System.out.println("strRequisitionId------------>"+strRequisitionId);

int iCls = 0;
String strStyleCls                          =   "";
String	strNewReqNo		    				= 	"";
String	strName								=	"";
String	strAmount							=	"";
String	strCurrency							=	"";
String	strOriginatedBy		     			=	"";
String	strOriginatedOn			    		=	"";
String	strTravel_From						=	"";
String	strTravel_To						=	"";
String strGroupTravelFlag				="";
%>

</head>

<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><b><%=dbLabelBean.getLabel("label.report.cancelrequest",strsesLanguage) %></b></li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
         <td align="right" >
      <ul id="list-nav">
      <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
      <li><a href="#" onClick="javascript:top.window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
      </ul>
      </td>
      </tr>
    </table>
	</td>
  </tr>
</table>

 <form name=frm action="T_Travel_Requisition_Cancel_Post_new.jsp" method=post>
  <input type=hidden name=purchaseRequisitionId value="<%=strRequisitionId%>">
  <input type="hidden" name=travelType value="<%=strTravelType%>"/>      
  <input type="hidden" name=whichPage value="<%=strWhichPage%>"/>      
  <input type="hidden" name=targetFrame value="<%=strTargetFlag%>"/>  
      <input type="hidden" name=final_url value="<%=finalUrl%>"/>
<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
         
		  <tr class="formhead">
          <td width="175px" align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.requisitionnumber",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.traveller",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.travelfrom",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.travelto",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.totalamount",strsesLanguage) %>  </td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.global.currency",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.approverequest.originatedby",strsesLanguage) %></td>
		  <td align="center" class="listdata"><%=dbLabelBean.getLabel("label.approverrequest.originatedon",strsesLanguage) %></td>
          </tr>
<%
if(strTravelType.equalsIgnoreCase("I"))
{
  sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER, ISNULL(CONVERT(decimal(20,0),t.TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(t.TA_CURRENCY,'-') AS TA_CURRENCY,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,DBO.CONVERTDATEDMY1(t.C_DATETIME),j.travel_from,j.travel_to,t.GROUP_TRAVEL_FLAG FROM T_TRAVEL_DETAIL_INT t,T_JOURNEY_DETAILS_INT j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and    T.TRAVEL_ID=S.TRAVEL_ID   AND S.TRAVEL_TYPE='I' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10 AND t.TRAVEL_ID="+strRequisitionId+"  ORDER BY T.C_DATETIME DESC";
}
else
{

 sSqlStr="SELECT t.travel_id,t.TRAVEL_REQ_NO, DBO.USER_NAME(t.TRAVELLER_ID) AS TRAVELLER, ISNULL(CONVERT(decimal(20,0),t.TOTAL_AMOUNT),'0') AS  TOTAL_AMOUNT, ISNULL(t.TA_CURRENCY,'-') AS TA_CURRENCY,DBO.USER_NAME(t.C_USERID)AS ORIGINATOR,DBO.CONVERTDATEDMY1(t.C_DATETIME),j.travel_from,j.travel_to,t.GROUP_TRAVEL_FLAG  FROM T_TRAVEL_DETAIL_DOM t,T_JOURNEY_DETAILS_DOM j,T_TRAVEL_STATUS S WHERE t.travel_id=j.travel_id and  T.TRAVEL_ID=S.TRAVEL_ID  AND S.TRAVEL_TYPE='D' AND J.JOURNEY_ORDER=1 AND T.STATUS_ID=10 AND t.TRAVEL_ID="+strRequisitionId+"  ORDER BY T.C_DATETIME DESC";

}

stmt = con.createStatement(); 
rs = stmt.executeQuery(sSqlStr);
//Suser_id
	while(rs.next())
	  {
	strRequisitionId				=	rs.getString(1);
	strNewReqNo						= 	rs.getString(2);
	strName							=	rs.getString(3);
	strAmount						=	rs.getString(4);
	strCurrency						=	rs.getString(5);
	strOriginatedBy					=	rs.getString(6);
	strOriginatedOn					=	rs.getString(7);	
	strTravel_From					=	rs.getString(8);
	strTravel_To					=	rs.getString(9);

	///added a code for showing Group travele  in case of group travel  inspite of traveler name on 06-Mar-08 
	
	if(strTravelType.equalsIgnoreCase("I"))
    {
		                        strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
								
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
							    strName="Group/Guest Travel";  
									
  							    }
								
     }else   ///  added  for showing group travel in case of group travel instead of traveler name on 18-Jun-08 by shiv sharma 
		  {
		     strGroupTravelFlag       =   rs.getString("GROUP_TRAVEL_FLAG"); 
								
								if(strGroupTravelFlag==null) 
								{
									strGroupTravelFlag="N";
								}
								if(strGroupTravelFlag!=null  &&  (strGroupTravelFlag.trim().equals("Y")))   
								{		
							    strName="Group/Guest Travel";  
									
  							    }
								
	 }

%>
<%
         	if (iCls%2 == 0) { 
        		strStyleCls="formtr1";
                } else { 
       	       	strStyleCls="formtr2";
             } 


	  iCls++;
%>
		  <tr class="<%=strStyleCls%>">
			<td width="175px" align="center" class="listdata"><%=strNewReqNo%></td>
			<td align="center"  class="listdata"><%=strName%></td>
			<td align="center"  class="listdata">&nbsp;<%=strTravel_From%></td>
			<td align="center"  class="listdata">&nbsp;<%=strTravel_To%></td>
			<td align="center"  class="listdata"><%=strAmount%></td>
			<td align="center"  class="listdata"><%=strCurrency%></td>
			<td align="center"  class="listdata"><%=strOriginatedBy%></td>
			<td align="center"  class="listdata"><%=strOriginatedOn%></td>

		  </tr>
	<%
	
		  }
		  rs.close();
		  stmt.close();
	%>
   </table>    

<table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">

          <tr valign="middle"> 
            <td width="175px" class="formtr2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<%=dbLabelBean.getLabel("label.comments.yourcomments",strsesLanguage) %></td>
            <td class="formtr1" colspan="6"> 
              <textarea name="comments" cols=107 rows=3 class="textBoxCss"><%if(strNewReqNo.contains("GR/")){%><%=dbLabelBean.getLabel("label.report.cancelledbyadministratoronbehalfof",strsesLanguage) %> <%=strOriginatedBy %>
<%}else{%><%=dbLabelBean.getLabel("label.report.cancelledbyadministratoronbehalfof",strsesLanguage) %> <%=strName %><%} %> </textarea>
            </td>
          </tr>

          <tr> 
            <td colspan="7" class="formbottom" align=center> 
			  <input type=hidden name=buttonData>
              <input type="button" name="save" value=" <%=dbLabelBean.getLabel("label.report.cancelrequest",strsesLanguage) %>" class="formbutton" onClick="CheckDataSave();">
              <input type="reset" name="reset" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage) %>" class="formbutton">
            </td>
          </tr>
        
   </table>		
      
</form>
  
</body>
</html>
