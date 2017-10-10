<%
/****************************************************************************************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author							:SACHIN GUPTA
 *Date of Creation 					:04 September 2006
 *Copyright Notice 					:Copyright(C)2000 MIND.All rights reserved
 *Project	  						:STAR
 *Operating environment	:Tomcat, sql server 2000 
 *Description 						:This is first jsp file  for attach the document in TRAVEL_ATTACHMENT in the 	STAR Database
 *Modification 						: 1. Add function for confirmation when user click on "Delete" link
 *Reason of Modification			: 1. Function use for asking confirmation when user click on "Delete" link 
                                                  2: commented  for not sending target page, by shiv on 06-Jul-07
								                  3. @Sanjeet Kumar on 27-July-2007 for solving attachment problem.
												  4.code added for new page of Domestice group travel  on 02-Jul-08 by shiv sharma  
									  
 *Date of Modification				: 1. 3/13/2007
 *Modified By						: 1. SAMIR RANJAN PADHI
 *Revision History					:
 *Editor							:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:05 July 2011
 *Modification			:add winclose() function to close the window and refreshing parent window.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:07 Sept 2011
 *Modification			:bug fix donot allow to delete file after request submit to workflow or approved by all.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:21 Oct 2011
 *Modification			:modify the download link.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:09 Nov 2011
 *Modification			:implement validation for files applicable for uploading and change file size exceeding msg.
 						 processing image implement during uplaoding attachment
 						 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
 ***********************************************************************************************************************************/
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
<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<jsp:useBean id="securityUtilityBean" scope="page" class="src.connection.SecurityUtilityMethods" />
<SCRIPT language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>
<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
		function showMessage()
		{
			alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseclickonbrowsebuttontoupload",strsesLanguage)%>');
		}

/**

 CHANGE BY SAMIR RANJAN PADHI ON (3/13/2007)
 FUNCTION USE FOR ASKING CONFIRMATION WHEN USER CLICK ON "Delete" LINK 

*/

function confDelete()
{
if(confirm('<%=dbLabelBean.getLabel("alert.global.deleterecord",strsesLanguage)%>'))
	{
		openWaitingProcess();
		return true;
	}
	else
	{
		return false;
	}
}

// END OF confDelete() FUNCTION ON 3/13/2007


function checkData()
{
	var a= document.myform.file.value;
	if(a=="")
	{
	alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseselectfile",strsesLanguage)%>');
	document.myform.file.focus();
	return false;
	}

//added by manoj chand on 02 november 2011 to check file extension before uploading file. 
	
	var var_index=a.lastIndexOf(".");
	//alert('var_index--->'+var_index);
	var var_substring=a.substring(var_index+1,a.length);
	//alert('var_substring--->'+var_substring);
	var_substring = var_substring.toLowerCase();
	if(var_substring=='pdf' || var_substring=='doc' || var_substring=='docx' || var_substring=='xls' || var_substring=='xlsx' || var_substring=='ppt' || var_substring=='pptx' || var_substring=='txt' || var_substring=='gif' || var_substring=='jpeg' || var_substring=='jpg' || var_substring=='html' || var_substring=='zip')
	{
		
	}else{
		//alert('Invalid File');
		alert('<%=dbLabelBean.getLabel("label.requestdetails.pleaseuploadfileswithdocxlspptgiftxtziponly",strsesLanguage)%>');
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
	openWaitingProcess();
	return true;
	//document.myform.rBUTT.disabled=true;

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
//added by manoj chand on 05 july 2011
function winclose()
{
	window.opener.childwindowSubmit();
	window.close();
}


/*ADDED BY MANOJ CHAND ON 09 NOV 2011 TO SHOW PROCESSING IMAGE DURING UPLOADING FILE*/
function closeDivRequest()
{
	document.getElementById("waitingData").style.visibility="hidden";	
}


function openWaitingProcess()
{
		var dv = document.getElementById("waitingData");
		if(dv != null)
		{
			//var xpos = screen.availHeight/2+90;
			//var ypos = screen.availWidth/2-350;
			var xpos = screen.availHeight/2+10;
			var ypos = screen.availWidth/2-240;   
			
			dv.style.position="absolute";       		
			dv.style.left=(xpos+10)+"px";
			dv.style.top=(ypos)+"px";
			document.getElementById("waitingData").style.display="";
			document.getElementById("waitingData").style.visibility="";	
		}
}

/*END HERE*/

</script>

</head>
<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script> 
<%
// Variables declared and initialized
ResultSet rs					=		null;			  // Object for ResultSet
String	sSqlStr=""; // For sql Statements
String	sql	=	"";
int iCls = 0;
String strStyleCls = "";
String	strOriginator	=	"";
String strReqStatus="";
String strbutDisabled="enabled";
%>
<%
	String sSanctionId=""; // Object to store Sanction ID
	sSanctionId	=	request.getParameter("purchaseReqID");

	String strTravelType   =  "";
    strTravelType   =  request.getParameter("travel_type"); 

    if(strTravelType != null && strTravelType.equals("INT"))   //set  the flag for international 'I'or domestic 'D'
    {
       strTravelType = "I";
    }
    if(strTravelType != null && strTravelType.equals("DOM"))   
    {
       strTravelType = "D";
	}



    String strWhichPage    =  "";
    String strTargetFrame  =  "";
	String strTargetFlag   =  "";
	//changed by shiv on 06-Jul-07
    strWhichPage    =  request.getParameter("whichPage")==null ? "":request.getParameter("whichPage"); 

	if(strWhichPage == null)
       strWhichPage = "#";
          
    strTargetFlag    =  request.getParameter("targetFrame"); 
	if(strTargetFlag !=null && strTargetFlag.equals("yes"))
    {
      /// strTargetFrame="middle";  //commented by shiv on  06-Jul-07 
    }
	else
	{
	 /// strTargetFrame="";   
	}
	
	//Added By Gurmeet Singh
	String strUserAccessCheckFlag = "";
	strUserAccessCheckFlag = securityUtilityBean.validateAuthCommentsTravelReq(sSanctionId, strTravelType, Suser_id);

	if(strUserAccessCheckFlag.equals("420")){	
		dbConBean.close();  
		dbConBean1.close();		
		securityUtilityBean.registerUnauthAccessLog(Suser_id, request.getRemoteAddr(), "requisitionAttachment.jsp", "Unauthorized Access");
		response.sendRedirect("UnauthorizedAccess.jsp");		
	} else {

%>

<form  enctype="multipart/form-data" name="myform" method="post" action="requisitionUploadData.jsp"  onSubmit="return checkData();">

<!-- ADDED BY MANOJ CHAND ON 09 NOV 2011 TO SHOW PROCESSING IMAGE DURING UPLOADING OF FILE -->
<div id="waitingData" style="display:none;"> 	  
	    
	 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
	 	<br>      
	 	<font color="#000080" class="pageHead"><center> <%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage) %> </center></font>    
	</div>

<input type=hidden name=sanctionId value="<%=sSanctionId%>">
<input type="hidden" name=travel_type value="<%=strTravelType%>"/>
<input type="hidden" name=whichPage value="<%=strWhichPage%>"/>  
<input type="hidden" name=targetFrame value="<%=strTargetFlag%>"/> 
<input type="hidden" name=purchaseReqID value="<%=sSanctionId%>"/> 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.requestdetails.uploaddocument",strsesLanguage) %> </li>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
        <td>
        <ul id="list-nav">
        <li><a href="#" onClick="window.print();"><%=dbLabelBean.getLabel("button.search.print",strsesLanguage) %></a></li>
        <!-- code start @Sanjeet on 27-July-2007 for solving the attachment problem.   -->
        <% // code added for new page of Domestice grpup travel  on 02-Jul-08 by shiv sharma 
 	//if(strWhichPage.equals("T_IntPassport_Details.jsp")|| strWhichPage.equals("T_IntForex_Details.jsp")  || strWhichPage.equals("T_TravelDetail_Dom_Forex.jsp")  || strWhichPage.equals("Group_itinerary_details.jsp") || strWhichPage.equals("Group_itinerary_details_DOM.jsp"))
 	//change by manoj chand on 02 nov 2011 to remove scripting error coming during close button click on upload document window.
 	  
 	if(strWhichPage.equals("T_IntPassport_Details.jsp")|| strWhichPage.equals("T_IntForex_Details.jsp")  || strWhichPage.equals("T_TravelDetail_Dom_Forex.jsp"))
		{
			%>
	
      <li><a href="<%=strWhichPage%>?travel_type=<%=strTravelType%>&purchaseReqID=<%=sSanctionId%>&targetFrame=<%=strTargetFrame%>&travelId=<%=sSanctionId%>" onClick="javascript:winclose();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
    

		<%} else

		{			
			%>

<li><a href="#" onClick="javascript:window.close();"><%=dbLabelBean.getLabel("button.global.close",strsesLanguage) %></a></li>
<%}%> 


</ul>
</td></tr>	 
    </table>
	</td>
  </tr>
    <tr> 
      <td class="formhead" align=center colspan="2"><%=dbLabelBean.getLabel("label.requestdetails.thedocumentyouareuploadingwillbe",strsesLanguage) %>  <b><%=dbLabelBean.getLabel("label.requestdetails.written",strsesLanguage) %> </b><%=dbLabelBean.getLabel("label.requestdetails.tostarsserverandcanbereferencedanytime",strsesLanguage) %>  <br><font color=red><%=dbLabelBean.getLabel("label.requestdetails.thefilenameyouuploadingnotcontainspaces",strsesLanguage) %> </font><br><font color="green">( <%=dbLabelBean.getLabel("label.requestdetails.pleaseuploadfileswithdocxlspptgiftxtziponly",strsesLanguage) %> )</font></td>

    </tr>
  </table>

  	<%
	if (sSanctionId != null && !"".equals(sSanctionId)) 
	{
		sql	=	"SELECT DISTINCT C_USER_ID FROM   T_APPROVERS WHERE  (TRAVEL_ID = "+sSanctionId+") AND (TRAVEL_TYPE = '"+strTravelType+"' ) ";
		rs = dbConBean.executeQuery(sql);
		if(rs.next())
		{
			strOriginator	=	rs.getString(1);
				
		}
		rs.close();
	}
  	
  	//added by manoj on 06 sept 2011 to get the status the request
  	
  	sql="SELECT TRAVEL_STATUS_ID FROM T_TRAVEL_STATUS WHERE TRAVEL_ID="+sSanctionId+" AND TRAVEL_TYPE='"+strTravelType+"'";
  	//System.out.println("sql------>"+sql);
  	rs = dbConBean.executeQuery(sql);
  	if(rs.next()){
  		strReqStatus=rs.getString(1);
  	}
  	rs.close();
  		
  	if(strOriginator.equals(Suser_id) && (strReqStatus.equalsIgnoreCase("10") || strReqStatus.equalsIgnoreCase("4") || strReqStatus.equalsIgnoreCase("6") ))
  	{
  		strbutDisabled="disabled";
  	}
	%>

   <table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
    <tr> 
      <td class="formtr2" width="28%" align="left" valign="top"><%=dbLabelBean.getLabel("label.requestdetails.selectdocument",strsesLanguage) %> </td><!--SELECT DOCUMENT -->
      <td  width="24%" align="left" valign="top"><input type=file onKeyPress="blur();" onKeyDown="showMessage();" name="file" class="formButton1"></td>
      <td class="formtr2" width="16%" align="left" valign="top"> <%=dbLabelBean.getLabel("label.requestdetails.documentreference",strsesLanguage) %> </td>
      <td class="formtr1" width="24%"> 
        <textarea cols=25 rows=5 name="doc_ref" class=textBoxCss onKeyDown="textCounter1(myform.doc_ref,500);" onKeyUp="textCounter2(myform.doc_ref,500);test1('doc_ref',500,'all');"></textarea>      </td>
      <td class="formbottom" width="8%" align="left" valign="top"> 

		<input type=submit value=<%=dbLabelBean.getLabel("label.requestdetails.upload",strsesLanguage) %> name="rBUTT" CLass="formButton"  <%=strbutDisabled %>  >      </td>
		<% if(strOriginator.equals("") || (strOriginator != null && strOriginator.equals(Suser_id))) { %>
		<td class="formbottom" width="8%" align="left" valign="top"> &nbsp;</td>
		<% } %>

	</tr>
    <tr class="formhead"> 
      <td class="listhead" width="28%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.documentreference",strsesLanguage) %> </td>
      <td class="listhead" width="24%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.filename",strsesLanguage) %> </td>
      <td class="listhead" width="16%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.requestdetails.uploadedby",strsesLanguage) %> </td>
      <td class="listhead" width="24%" valign="top" colspan=2 nowrap="nowrap"><%=dbLabelBean.getLabel("label.global.postedon",strsesLanguage) %> </td>
	  <%
	  //System.out.println("strOriginator--->"+strOriginator);
	  //System.out.println("Suser_id--->"+Suser_id);
	  //added strOriginator.equals("") by manoj chand on 28 june 2012 to resolve issue of delete link was not showing for group temp request.
if(strOriginator.equals("") || strOriginator.equals(Suser_id))
{	  %>
    <td class="listhead" width="8%" align="left" valign="top" nowrap="nowrap"><%=dbLabelBean.getLabel("label.approverequest.action",strsesLanguage) %> </td>
	<%}%>
    </tr>
    <tr class="colorPink"> 
      <td class="colorPink" colspan="5" align="center" valign="top">
	  <%
	  String strError="";
	  strError=request.getParameter("err") == null ?  "" :  request.getParameter("err");
	 //System.out.println("Hello Origenator>>>>>>>>>><<<<<<<<<<<"+strError);
	  if(strError.equals("0"))
	  {
		  
	  strError="";
	  }
	  	  if(strError.equals(""))
	  {
	  strError="";
	  }

	  if(strError.equals("1"))
	  {
	  strError= dbLabelBean.getLabel("label.requestdetails.filewiththisnamealreadyexists",strsesLanguage);
	  }
	 if(strError.equals("4"))
	 {
		strError=dbLabelBean.getLabel("label.requestdetails.fileuploadedsuccessfully",strsesLanguage);
	 }
     if(strError.equals("3"))
	 {
		//strError="File Size is too big";
		//changed by manoj on 02 nov 2011
    	 strError=dbLabelBean.getLabel("label.requestdetails.filesizeshouldnotmorethan5mb",strsesLanguage) ;
	 }
	 if(strError.equals("99"))
	 {
		strError=dbLabelBean.getLabel("label.requestdetails.filedeletedsuccessfully",strsesLanguage);
	 }
	 if(strError.equals("5")){
		 strError=dbLabelBean.getLabel("message.user.filecouldnotbeuploaded",strsesLanguage);
	 }
	  %>	  </td>
    </tr>
	
<%


if (sSanctionId != null && !sSanctionId.equals("null")) {
//Sql to get the the sanction list
sSqlStr="SELECT ISNULL(DOC_REF,'-'),RTRIM(ISNULL(FILE_LOCATION,'-')),ISNULL(FILES_NAME,'-'),DBO.USER_NAME(UPLOADED_BY), DBO.CONVERTDATEDMY1(UPLOADED_ON),UPLOADED_BY,ATTACHMENT_ID FROM TRAVEL_ATTACHMENTS WHERE TRAVEL_ID= '"+sSanctionId+"'  AND TRAVEL_TYPE='"+strTravelType+"' ORDER BY UPLOADED_ON DESC";

//System.out.println("sSqlStr==============="+sSqlStr);

rs = dbConBean.executeQuery(sSqlStr);
String strDocRef="";
String strFilePath="";
String strFileName="";
String strPostedBy="";
String strPostedOn="";
String strUploadedId="";
String strActionType="";
String strAttachmentid="";
if(rs.next())
{
	do
	{
       strDocRef=rs.getString(1);
       strFilePath=rs.getString(2);     
       strFileName=rs.getString(3);
       strPostedBy=rs.getString(4);
       strPostedOn=rs.getString(5);
       strUploadedId=rs.getString(6);
       if(strUploadedId.trim().equals(Suser_id.trim()))
       {
         strActionType="...";
       }
       else
       {
         strActionType="...";
       }
       strAttachmentid=rs.getString(7);	
%>
<%
	    if (iCls%2 == 0) { 
		  strStyleCls="formtr2";
        } 
		else { 
	      strStyleCls="formtr1";
        } 
  	    iCls++;
  	    
  	   
%>
	
      <tr class="<%=strStyleCls%>"> 
      <td class="listdata" width="28%" align="left" valign="top"><%=strDocRef%></td>
      <!-- change in download link by manoj chand on 21 Oct 2011 -->
      <td class="listdata" width="24%" align="left" valign="top"><a href="javascript:void(0);" onclick="window.open('./DownloadStarsFile?attachmentid=<%=strAttachmentid %>&traveltype=<%=strTravelType %>','mywindow','menubar=0,resizable=yes,width=1000,height=450,scrollbars=yes');"> <%=strFileName%></a></td>
      <td class="listdata" width="16%" align="left" valign="top"><%=strPostedBy%></td>
      <td class="listdata" width="24%" colspan=2 valign="top"><%=strPostedOn%></td>
	  	  <%
if(strOriginator.equals(Suser_id) && (strReqStatus.equalsIgnoreCase("10") || strReqStatus.equalsIgnoreCase("2") || strReqStatus.equalsIgnoreCase("4") || strReqStatus.equalsIgnoreCase("6") ))
{	
%>
<td class="listdata" width="8%" align="left" valign="top"><a href="T_deleteSanctionAttachments.jsp?attId=<%=strAttachmentid%>&path=<%=strFileName%>&sanctionId=<%=sSanctionId%>&TravelType=<%=strTravelType%>&whichPage=<%=strWhichPage%>&targetFrame=<%=strTargetFlag%>" onClick="return false;" disabled><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %> </a></td>
<!--
CHANGE BY SAMIR RANJAN PADHI ON (3/13/2007)
ADD FUNCTION FOR CONFIRMATION OF DELETE i.e "confDelete()"
FUNCTION USE FOR ASKING CONFIRMATION WHEN USER CLICK ON "Delete" LINK 
-->

  <%}else if((strOriginator.equals("") || strOriginator.equals(Suser_id)) && !strReqStatus.equalsIgnoreCase("10") && !strReqStatus.equalsIgnoreCase("2") ){%>
  <td class="listdata" width="8%" align="left" valign="top"><a href="T_deleteSanctionAttachments.jsp?attId=<%=strAttachmentid%>&path=<%=strFileName%>&sanctionId=<%=sSanctionId%>&TravelType=<%=strTravelType%>&whichPage=<%=strWhichPage%>&targetFrame=<%=strTargetFlag%>" onClick="return confDelete();"><%=dbLabelBean.getLabel("link.createeditlist.delete",strsesLanguage) %> </a></td>
  <%} %>
    </tr>
	<%
	}while(rs.next());
 rs.close();
}
}
dbConBean.close();
%>
    <tr class="<%=strStyleCls%>">  
		  	  <%
if(strOriginator.equals("") || strOriginator.equals(Suser_id))
{	  %>
      <td class="listdata" width="100%" colspan=6 align="left" valign="top"><font color='red'><b><%=strError%></b></font></td>   	
<%	  }
	  else
	  {%>
      <td class="listdata" width="100%" colspan=5 align="left" valign="top"><font color='red'><b><%=strError%></b></font></td>   	
<%
	  }
	  }%>
    </tr>
  </table>

</form>


<script language="javaScript">
		closeDivRequest();
	</script>

</body>
</html>
