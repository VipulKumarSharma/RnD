<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Kaveri Garg 
 *Date of Creation 		:29 August 2012
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is jsp page to update or edit previous added versions in database of STARS application.
 *Editor				:Eclipse
 
 *Modified By			:	Manoj Chand
 *Date of Modification	:	22 Oct 2013
 *Modification			:	stop entering -- special character in remark textarea
 *******************************************************/
%>
<%@ page buffer="5kb" language="java"  import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*" pageEncoding="UTF-8" %>
<!--  errorPage="error.jsp"  -->
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
		<!--  errorPage="error.jsp"  -->
		
		<html>
		<head>
		<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
		<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" /> 
		<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
		<%@ include file="M_InsertProfile.jsp"  %>
		<script type="text/javascript" language="JavaScript1.2" src="menu/stm31.js?buildstamp=2_0_0"></script>
		
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	 <!-- 	<SCRIPT language="JavaScript" src="scripts/RightClickDisableee.js?buildstamp=2_0_0"></SCRIPT>  -->  
		<!-- <script type="text/javascript" language="text/javaScript" src="scripts/shortcut.js?buildstamp=2_0_0"></script>  --> 
		
		
		
		
		<script>
		//rightClick();
		</script>
		<script language="javaScript">
		/*
			shortcut.add("Ctrl+P",function() {
			alert("For Security Reasons, Ctrl+P Key is Disabled");
		}
		);
		*/
			
		</script>
		
		
		
		<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
		
		
		<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
		<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
		<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
		<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
		
		<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
		<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script> 
		<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
		
		<script language=JavaScript >
		
		function validateMyForm()
		{
			if(document.frm.release_date.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.version.releasedatecannotbeblank",strsesLanguage)%>');
				document.frm.release_date.focus();
				return false;
			}
			if(document.frm.release_version.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.version.releaseversioncannotbeblank",strsesLanguage)%>');
				document.frm.release_version.focus();
				return false;
			}
		
			var version=document.frm.release_version.value;	//getting the whole version value 9.99.999
		var verPartFirst=version.substring(0,1);						//first part of the version before the first dot 9
		var verPartDotFirst=version.substring(1,2);				//first dot of version
		var verPartSecond=version.substring(2,4);				//second part of the version before the second dot 99
		var verPartDotSecond=version.substring(4,5);			//second dot of version
		var verPartThird=version.substring(5,8);					//last part of the version 
		//check whether dot is available in the version or not
		if(verPartDotFirst!='.' || verPartDotSecond!='.')
		{
			alert('<%=dbLabelBean.getLabel("alert.version.releaseversionisnotinproperformat",strsesLanguage)%>');
			document.frm.release_version.focus();
			return false;
		}
		//check the first part that is it digit or not
		if(isDigit(verPartFirst)==false)
		{
			alert('<%=dbLabelBean.getLabel("alert.version.releaseversionisnotinproperformat",strsesLanguage)%>');
			document.frm.release_version.focus();
			return false;
		}
		//check the scond part that is it digit or not and length is two or not
		if(verPartSecond.length!=2)
		{
			alert('<%=dbLabelBean.getLabel("alert.version.releaseversionisnotinproperformat",strsesLanguage)%>');
			document.frm.release_version.focus();
			return false;
		}
		else
		{
			for (start = 0; start < verPartSecond.length; start++)
			{
				
				if(isDigit(verPartSecond.substring(start,start+1))==false)
				{
					alert('<%=dbLabelBean.getLabel("alert.version.releaseversionisnotinproperformat",strsesLanguage)%>');
					document.frm.release_version.focus();
					return false;
				}
			}
		}
		//check the last part that is it digit or not and length is three or not
		if(verPartThird.length!=3)
		{
			alert('<%=dbLabelBean.getLabel("alert.version.releaseversionisnotinproperformat",strsesLanguage)%>');
			document.frm.release_version.focus();
			return false;
		}
		else
		{
			for (start = 0; start < verPartThird.length; start++)
			{
				
				if(isDigit(verPartThird.substring(start,start+1))==false)
				{
					alert('<%=dbLabelBean.getLabel("alert.version.releaseversionisnotinproperformat",strsesLanguage)%>');
					document.frm.release_version.focus();
					return false;
				}
			}
		}
		//end of format checking script
		
		
		
		if(document.frm.release_by.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.version.releasebycannotbeblank",strsesLanguage)%>');
				document.frm.release_by.focus();
				return false;
			}
		if(document.frm.release_type.value=='-1')
			{
				alert('<%=dbLabelBean.getLabel("alert.version.pleaseselectreleasetype",strsesLanguage)%>');
				document.frm.release_type.focus();
				return false;
			}
		if(document.frm.remarks.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.version.remarkscannotbeblank",strsesLanguage)%>');
				document.frm.remarks.focus();
				return false;
			}
		
		//CHECK OF RELEASE DATE IT SHOULD BE GREATER THAN 1ST APR 2009
		var start_date_meeting_current='02/04/2009';
		var meeting_start_date_new_1=document.forms[0].release_date.value;
		var d2=meeting_start_date_new_1.substr(6,4);
		var d12=d2;
		var a2 =meeting_start_date_new_1.substr(3,2);
		var a12=a2;
		var c2 =meeting_start_date_new_1.substr(0,2);
		var c12=c2;
		//var startdate=document.forms[0].dateFrom.value
		var f2=start_date_meeting_current.substr(6,4);
		var f12=f2;
		var b2=start_date_meeting_current.substr(3,2);
		var b12=b2;
		var h2=start_date_meeting_current.substr(0,2);
		var h12=h2;
		if(d12<f12)
		{
			alert('<%=dbLabelBean.getLabel("alert.version.releasedateshouldbegreaterthanfirstapril",strsesLanguage)%>');
			 document.forms[0].release_date.focus();
			 return false;
		}//end of if
		
		if((d12==f12)&&
		(a12<b12))
		{
			alert('<%=dbLabelBean.getLabel("alert.version.releasedateshouldbegreaterthanfirstapril",strsesLanguage)%>');
			 document.forms[0].release_date.focus();
			 return false;
		}//end of elseif
		
		if((d12==f12)&&
		(a12==b12)&&(c12<h12))
		{		
			alert('<%=dbLabelBean.getLabel("alert.version.releasedateshouldbegreaterthanfirstapril",strsesLanguage)%>');
			 document.forms[0].release_date.focus();
			 return false;
		}//end of elseif
		
		//END
		
		if(confirm('<%=dbLabelBean.getLabel("alert.version.areyousurewanttochangeversiondetails",strsesLanguage)%>'))
		{
			document.frm.submit();
			return true;	
		}
		else
		{
			return false;
		}
		
		}
		
		
		function checkField(obj1, length, str)
		{	
		var obj; 
		if(obj1=='release_version')
		{
			obj = document.frm.release_version;
		}
		if(obj1=='release_by')
		{
			obj = document.frm.release_by;
		}
		if(obj1=='remarks')
		{
			 obj = document.frm.remarks;
			 upToTwoHyphen(obj); 
		}	
		
		charactercheck(obj,str);
		limitlength(obj, length);
		spaceChecking(obj);

	
						}

		function ReplaceAll1(source,from,to)
		{
			 var temp = source;
			    var index = temp.indexOf(from);
			        while(index != -1){
			            temp = temp.replace(from,to);
			            index = temp.indexOf(from);
			        }
			        return temp;
		}


		<%

//		check value retrived for checking that value is inserted or updated 
		String strStatus="";
		String	strMsg=	(request.getParameter("strMsg")==null)?"":request.getParameter("strMsg");
			%>
		</script>
		</head>
		<body><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  
		     <tr>
    <td height="38" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=dbLabelBean.getLabel("label.version.versiondetails",strsesLanguage) %>   &nbsp;&nbsp;</li><font color='red'><%=strMsg%></font>
    </ul></td>
    <td align="right" valign="bottom" class="bodyline-top">
	<table align="right" border="0" cellspacing="0" cellpadding="0">
      <tr align="right">
      <td align="right" >
      <ul id="list-nav">
            <li><a href="M_VersionList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage) %></a></li>
            </ul>
      </td>
       </tr>
    </table>
	</td>
  </tr>
  		</table>
		

		<%
		String strReleaseDate			=	"";
		String strReleaseVersion		=	"";
		String strReleaseBy				=	"";
		String strReleaseType			=	"-1";
		String strRemarks				=	"";
		int checkFlag					=	0;
		
		String  sSqlStr 				=	"";
		String  stmt  					=	"";
		String strUserId    			=	null;
		ResultSet rs,rs1				=	null; 
	    String ReleaseVersionId        = "";
	    ReleaseVersionId=request.getParameter("ReleaseVersionId");
	    //System.out.println("ReleaseVersionId---->"+ReleaseVersionId);
		sSqlStr="SELECT CONVERT(VARCHAR(11),RELEASE_DATE,103) AS RELEASE_DATE,RELEASE_VERSION,RELEASE_BY,RELEASE_TYPE,REMARKS FROM VERSION_RELEASE_LOG  WHERE VER_REL_LOG_ID="+ReleaseVersionId;
		rs = dbConBean.executeQuery(sSqlStr);  
		if(rs.next())
		{
			strReleaseDate			=	rs.getString("RELEASE_DATE");
			strReleaseVersion		=	rs.getString("RELEASE_VERSION");
			strReleaseBy			=	rs.getString("RELEASE_BY");
			strReleaseType			=	rs.getString("RELEASE_TYPE");
			strRemarks				=	rs.getString("REMARKS").trim();
			strRemarks= strRemarks.replaceAll("\\n","##");
			strRemarks= strRemarks.replaceAll("\\r","***");
			}
	
		%>
		
		<form method=post name=frm action="T_VersionPost.jsp?action1=update&ReleaseVersionId=<%=ReleaseVersionId%>" onSubmit="return checkData();">
			<table width="70%" align="center" cellspacing="2" cellpadding="2">
					<tr align="left"> 
						<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.version.releasedate",strsesLanguage)%></td>
						<td width="63%" class="formtr1">
						<input type=text name="release_date"  size='10' maxlength="10" class="textBoxCss" 
						onFocus="javascript:vDateType='DD/MM/YYYY'" 
						onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" 
						onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"   
						onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" tabIndex="1" >
						<a href="javascript:show_calendar('frm.release_date','a','a','DD/MM/YYYY');"
						onMouseOver="window.status='Date Picker';return true;" 
						onMouseOut="window.status='';return true;">
						<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle" width="18" height="18"> 
						</a>
						<script>
						document.forms[0].release_date.value='<%=strReleaseDate%>';
						</script>
						</td>
						
					</tr>
		
					<tr align="left"> 
						<td class="formtr2" width="37%" ><%=dbLabelBean.getLabel("label.version.releaseversion",strsesLanguage)%></td>
						<td width="63%" class="formtr1"><input type=text size=20 maxlength=8  name=release_version class="textBoxCss" onKeyDown="return checkField('release_version',8, 'n.')" onKeyUp="return checkField('release_version',8, 'n.')" tabIndex=2>
						<script>
						document.forms[0].release_version.value='<%=strReleaseVersion%>';
						</script>
						</td>
						
					</tr>
		
					<tr align="left"> 
						<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.version.releaseby",strsesLanguage)%></td>
						<td  align="left" valign="top" class="formtr1" >
						<input type=text size=20 maxlength=50  name=release_by class="textBoxCss" onKeyDown="return checkField('release_by',150, 'c')" onKeyUp="return checkField('release_by',150, 'c')" tabIndex=3>
						<script>
						document.forms[0].release_by.value='<%=strReleaseBy%>';
						</script>
						</td>
						
					</tr>
		
					<tr align="left"> 
						<td class="formtr2" width="37%"><%=dbLabelBean.getLabel("label.version.releasetype",strsesLanguage)%></td>
						<td  align="left" valign="top" class="formtr1" >
						<select name="release_type"  class="textBoxCss" tabIndex=4>
							<OPTION VALUE="-1" ><%=dbLabelBean.getLabel("label.handover.select",strsesLanguage)%></option>
							<OPTION VALUE="Minor"><%=dbLabelBean.getLabel("label.version.minor",strsesLanguage)%></option>
							<OPTION VALUE="Medium"><%=dbLabelBean.getLabel("label.version.medium",strsesLanguage)%></option>
							<OPTION VALUE="Major"><%=dbLabelBean.getLabel("label.version.major",strsesLanguage)%></option>
						</select>
						<script>
						document.forms[0].release_type.value='<%=strReleaseType%>'; 
						</script>
						</td>
						
					</tr>
		
					<tr align="left"> 
						<td class="formtr2" width="37%" valign="top"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
						<td width="63%" class="formtr1">
							<textarea class="textBoxCss" cols=80 rows=8 id="remarks" name=remarks tabIndex=5 title="Release Remarks"
								onKeyDown="return checkField('remarks',550, 'else')" onKeyUp="return checkField('remarks',550, 'else')">
							</textarea>
							<script>
								var mystring='<%=strRemarks.trim()%>';
								mystring=ReplaceAll1(mystring,'##', '\n');
								mystring=ReplaceAll1(mystring,'***', '\r');
								document.forms[0].remarks.value=mystring;
							</script>
						</td>
					</tr>
				
				<tr align="center"> 
					<td class="formbottom" colspan="2">
						<input type="button" name="Submit" value=" <%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%> " class="formButton" onClick="validateMyForm();" tabIndex=6>
						<input type="Reset" name="Submit2" value=" <%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%> " class="formButton" tabIndex=7>
					</td>
				</tr>
		<tr>
		    <td height="1" colspan="2" align="center" class="bodyline-bottom"></td>
		  
		 		</tr>
			</table>
		</form>
		
		</body>
		</html>
