<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:VIJAY SINGH
 *Date of Creation 		:11/04/2007
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This page is used for get the password when the user forget his/her password
 *Modification 			:
 *Reason of Modification:For Direct accessing the database parameters by Gaurav Aggarwal on 04-Jun-2007
 *Date of Modification  :
 *Modified By	        :
 *Editor				:Editplus
 
 *Modification			:To allow user to get the username and password when the user forget his/her username and password
 *Modified By			:ManojChand
 *Date of Modification	:01 Mar 2011
 
 *Modification Date		:04-August-2011
 *Modification			:fetch path of STAR.properties file from web.xml 
 *Modified By			:Manoj Chand
 
 *Modified By			:Manoj Chand
 *Modification 			:Create Database connection from stars.properties located outside STARS application.
 *Modification Date		:02 Jan 2013
 
  *Modification Date	:18-Jan-2013
 *Modification			:remove inclusion of application.jsp from this file 
 *Modified By			:Manoj Chand
 
 *Modified By					:Manoj Chand
 *Date of Modification			:22 Oct 2013
 *Modification					:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%>
<%@ page pageEncoding="UTF-8" import="src.connection.PropertiesLoader" %>
<%@ include  file="importStatement.jsp" %>

<html>
<!--HEAD BLOCK START-->
<head>
	<title>User  forget password screen</title>
	
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%
	String strsesLanguage=request.getParameter("lang1")== null ? "en_US" : request.getParameter("lang1");
	%>
	
	
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
	<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/CTRLDisable.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/RightClickDisable.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/BackSpaceDisable.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></SCRIPT>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
	
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<%@ include file="M_InsertProfile.jsp"  %>
<%
request.setCharacterEncoding("UTF-8");
Connection conn								=	null;		 // Object for connection
Statement stmt								=	null;		 // Object for Statement
ResultSet rs								=	null;		 // Object for ResultSet
String strSqlStr							=	"";			// string for sql query
String strSecretQues						=	"";		// add for getting secret question form database
String strUserId							=	"";	//to get the userid from the database
String strButtonDisble						=	"enabled";
String strEmail								=	"";//to get email id from database.
String strmsg								=	"";
String strflag								=	"userexists";

String UserName = (request.getParameter("uname")==null)?"":request.getParameter("uname").trim();
String strInformation						=(request.getParameter("info")==null)?"":request.getParameter("info").trim();

//By @Gaurav Aggarwal on 04-Jun-2007 for Direct accessing the database parameters

//String contextdbDriver= application.getInitParameter("dbDriver");
//String contextdbUrl= application.getInitParameter("dbUrl");
//String contextdbUser=application.getInitParameter("dbUser");
//String contextdbPwd=application.getInitParameter("dbPwd");

//End of code

//Added by manoj chand on 04 august 2011
String contextdbDriver= "";
String contextdbUrl= "";
String contextdbUser= "";
String contextdbPwd= "";

//changed by manoj chand on 02 jan 2013 to fetch db connection parameters from outside STARS application.
	contextdbDriver     = PropertiesLoader.config.getProperty("dbdriver")==null?"":PropertiesLoader.config.getProperty("dbdriver");
	contextdbUrl 	    = PropertiesLoader.config.getProperty("dburl")==null?"":PropertiesLoader.config.getProperty("dburl");
	contextdbUser		= PropertiesLoader.config.getProperty("dbuser")==null?"":PropertiesLoader.config.getProperty("dbuser");
	contextdbPwd 		= PropertiesLoader.config.getProperty("dbpwd")==null?"":PropertiesLoader.config.getProperty("dbpwd");

%>
<script language="JavaScript">
// function for encryption ans_secret
function encryption()
         {
           
			//var ans_secret=document.forget_frm.ans_secret.value;
			//var newans_secret=encrypt(ans_secret);
           // document.forget_frm.ans_secret.value=newans_secret;
			
            return true;
         }
// end of encryption() function
function test1(obj1, length, str)
  {	
	var obj;
	if(obj1=='quest_secret')
	{
		obj = document.forget_frm.quest_secret;
		upToTwoHyphen(obj);
	}
	if(obj1=='ans_secret')
	{
		obj = document.forget_frm.ans_secret;
		upToTwoHyphen(obj);
	}
	if(obj1=='uName'){
		obj = document.forget_frm.uName;
		upToTwoHyphen(obj);
	}
	if(obj1=='regis_email'){
		obj = document.forget_frm.regis_email;
		upToTwoHyphen(obj);
	}
	charactercheck(obj,str);
	limitlength(obj, length);
	spaceChecking(obj);
  }

function checkData(flag)
{
	if(document.forget_frm.secret_ques.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.entersecretquestion",strsesLanguage)%>');
		document.forget_frm.secret_ques.focus();
		return false;
	}
	if(document.forget_frm.ans_secret.value=='')
	{
		alert('<%=dbLabelBean.getLabel("alert.mylinks.entersecretanswer",strsesLanguage)%>');
		document.forget_frm.ans_secret.focus();
		return false;
	}
	encryption(); 
	return true;
}

function focuscontrol(flag){

	if(flag=='userexists'){
		document.forget_frm.uName.readOnly=true;
		document.forget_frm.regis_email.readOnly=true;
		document.forget_frm.ans_secret.focus();
	}
	else if(flag=='userdeactivated'){
		document.forget_frm.uName.readOnly=true;
		document.forget_frm.regis_email.readOnly=true;
		
		}
	else{
		document.forget_frm.uName.focus();
		document.forget_frm.quest_secret.readOnly=false;
		}
}


function blankdiv(){
	document.getElementById("dv"). innerHTML = "";
	}



function check(){
	
var x=document.forget_frm.regis_email.value;
if(x=='')
{
}
else{
	
			var email=$("#reg_email").val();
			var urlParams = "strflag=CheckEmailId&emailflag="+email;
			$.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            success: function(result){
	            var res=result.trim();
					            
	            if(res=='N'){
		             var email=$("#reg_email").val();
		             if(email!=''){
		             document. getElementById("dv"). innerHTML = '<%=dbLabelBean.getLabel("label.forgetpassword.wronginfo",strsesLanguage)%>';
		             document.forget_frm.uName.value="";
		             document.forget_frm.regis_email.value="";
		             document.forget_frm.regis_email.focus();
		             }
		             return false;
	             }
	            else if(res=='D'){
	            	 var email=$("#reg_email").val();
		             if(email!=''){
			             document. getElementById("dv"). innerHTML = '<%=dbLabelBean.getLabel("label.forgetpassword.yournameindeactivateduser",strsesLanguage)%>';
			             document.forget_frm.uName.value="";
			             document.forget_frm.regis_email.value="";
			             document.forget_frm.uName.readOnly=true;
				         document.forget_frm.regis_email.readOnly=true;
				         document.forget_frm.secret_ques.readOnly=true;
				         document.forget_frm.ans_secret.readOnly=true;
			             document.forget_frm.close.focus();
		             }
		             return false;
		            }
	             else{
	            	 	var mystring=res;
					 	var myArray=mystring.split(',');
		                document.forget_frm.uName.value='';
		                document.forget_frm.secret_ques.value=myArray[1];
		                document. getElementById("dv"). innerHTML = "";
		                if(myArray[1]==""){
		                	document. getElementById("dv").innerHTML = '<%=dbLabelBean.getLabel("label.forgetpassword.usernotcontaininformation",strsesLanguage)%>';  
		                }
		                document.forget_frm.ans_secret.focus();
		             }
	            },
				error: function(){
					//alert('JQuery error');
	            }
	          });

}
}
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};



function checkvalue(uflag)
{
var y=document.forget_frm.regis_email.value;
var x=document.forget_frm.username.value;
if(x=='')
	{
	return false;
	}
else if(x==uflag){
	
	}
else{
	
	var y=document.forget_frm.regis_email.value;
	////if(y=='' || y!=''){
			var username=$("#username").val();
			var urlParams = "strflagID=CheckUserId&uNameflag="+username;
			
			$.ajax({
	            type: "post",
	            url: "AjaxMaster.jsp",
	            data: urlParams,
	            success: function(result){
	            var res=result.trim();
	                        
	            if(res=='N'){
		            var uname=$("#username").val();
		            var email=$("#reg_email").val();
		     		if(uname!=''){
			           document. getElementById("dv"). innerHTML = '<%=dbLabelBean.getLabel("label.forgetpassword.wronginfo",strsesLanguage)%>';
			           document.forget_frm.uName.value="";
			           document.forget_frm.regis_email.value="";
			           document.forget_frm.uName.focus();
		     		 }
		             return false;
	             }
	            else if(res=='D'){
						var uname=$("#username").val();
		            
		           		var email=$("#reg_email").val();
		     			if(uname!=''){
			            //alert('blank email-->'+email);
		           //document. getElementById("dv"). innerHTML = "Wrong Username";
		           document. getElementById("dv"). innerHTML = '<%=dbLabelBean.getLabel("label.forgetpassword.yournameindeactivateduser",strsesLanguage)%>';
		           document.forget_frm.uName.value="";
		           document.forget_frm.regis_email.value="";
		           document.forget_frm.uName.readOnly=true;
		           document.forget_frm.regis_email.readOnly=true;
		           document.forget_frm.secret_ques.readOnly=true;
		           document.forget_frm.ans_secret.readOnly=true;
		           document.forget_frm.close.focus();
		     			}
		            	
		             return false;  
	            }
	             else{
	            	 	var mystring=res;
					 	var myArray=mystring.split(',');
		                document.forget_frm.regis_email.value='';
		                document.forget_frm.secret_ques.value=myArray[1];
		                document. getElementById("dv").innerHTML = "";
		                	if(myArray[1]==""){
			                	document. getElementById("dv").innerHTML = '<%=dbLabelBean.getLabel("label.forgetpassword.usernotcontaininformation",strsesLanguage)%>';  
			                }
		                document.forget_frm.ans_secret.focus();
		             }
	            },
				error: function(){
					//alert('JQuery error');
	            }
	          });
////	}
}//

	}




function enablebutton()
{
	var x=document.forget_frm.uName.value;
	var y=document.forget_frm.regis_email.value;
	var z=document.forget_frm.secret_ques.value;
	
	if((x!='' || y!='') && z!=''){
		document.forget_frm.Submit.disabled=false;
	}else{
		document.forget_frm.Submit.disabled=true;		
	}
}

function enablebutton1()
{
	var x=document.forget_frm.uName.value;
	var y=document.forget_frm.regis_email.value;
	var z=document.forget_frm.ans_secret.value;
	
	if(x!='' && y!='' && z!=''){
document.forget_frm.Submit.disabled=false;
	}else{
		document.forget_frm.Submit.disabled=true;		
	}
}

//forgetPassword_post.jsp

</script>

</head>
<%

/*Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
              conn = DriverManager.getConnection("jdbc:odbc:star","wfp","#mind@pms9211");
*/
// @Gaurav Aggarwal on 04-Jun-2007 To make all the dbsettings in Deployment Descriptor
			  Class.forName(contextdbDriver);
              conn = DriverManager.getConnection(contextdbUrl,contextdbUser,contextdbPwd);
// End of code

strSqlStr="SELECT SECRET_QUESTION,USERID,EMAIL FROM M_USERINFO WHERE USERNAME=N'"+UserName+"' AND STATUS_ID=10";
//System.out.println("strSqlStr---->"+strSqlStr);

				stmt		= conn.createStatement(); 
				rs			= stmt.executeQuery(strSqlStr);
	
				if(rs.next())
				{
					strSecretQues			= rs.getString(1);
					strUserId				=rs.getString(2);
					strEmail				=rs.getString(3);
				}
				else{
					strSqlStr="SELECT SECRET_QUESTION,USERID,EMAIL FROM M_USERINFO WHERE USERNAME=N'"+UserName+"' AND STATUS_ID=30";
					//System.out.println("strSqlStr----for deactivated-->"+strSqlStr);
					stmt		= conn.createStatement(); 
					rs			= stmt.executeQuery(strSqlStr);
		
					if(rs.next())
					{
					/*	strSecretQues			= rs.getString(1);
						strUserId				=rs.getString(2);
						strEmail				=rs.getString(3);*/
						strmsg=dbLabelBean.getLabel("label.forgetpassword.yournameindeactivateduser",strsesLanguage);	
						strflag="userdeactivated";
					}else{
					//strmsg="User Not Found ";
					strmsg=dbLabelBean.getLabel("label.forgetpassword.wronginfo",strsesLanguage);
					
					strflag="usernotexists";
					}
				}
		try{
				if(strUserId.equals(""))
				{
					if(!strInformation.equals(""))
					strmsg=strInformation;
				%>
					
<!--					<marquee behavior="alternate" direction="left" truespeed  onMouseover="this.scrollAmount=0" onMouseout="this.scrollAmount=6" ><font size='3' color='red'><%//out.print(strInformation);%></font></marquee>-->
				
				<% strButtonDisble="disabled";
				}
				else if(strSecretQues.equals(""))
				{strmsg=dbLabelBean.getLabel("label.forgetpassword.usernotcontaininformation",strsesLanguage);
				%>
					
<!--					<marquee behavior="alternate" direction="left" truespeed  onMouseover="this.scrollAmount=0" onMouseout="this.scrollAmount=6" ><font size='3' color='red'><%//out.print("User does not contain any information");%></font></marquee>-->
				<%  strButtonDisble="disabled";
				}}
				catch(Exception ex){%>
			<%System.out.println("Exception in forgetPassword.jsp--"+ex);
			strSecretQues="";
			strButtonDisble="disabled";
		}
		rs.close();
		conn.close();
				%>
<body onLoad="focuscontrol('<%=strflag %>');" >
<form method="post" name="forget_frm" action="forgetPassword_post.jsp?flag=<%=strflag %>&lang=<%=strsesLanguage %>">
<table width="100%">
<tr class="bodyline-top">
        <td width="40%%"><ul class="pagebullet">
            <li class="pageHead"><%=dbLabelBean.getLabel("label.forgetpassword.forgetpasswordscreen",strsesLanguage)%></li>
        </ul></td>
		<td width="60%"> <div id="dv" style="color: red; height:100%;width:100%"> <%=strmsg %> </div></td>
</tr>
<tr>
<td>

</td></tr>
</table>
<hr></hr>
<table width="100%">
<tr align="left">
  	<td width="30%" class="formtr1"><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%> </td>
	<td width="70%" class="formtr1"><input type="text" name="uName" id="username" class="textBoxCss" onkeyup="test1('uName', 50, 'all');Javascript: if (event.keyCode == '13'){ checkvalue('<%=UserName %>');}"  width="30" size="50"></td>
	<script language="JavaScript">
			document.forget_frm.uName.value ="<%=UserName%>";
	</script>
</tr>





<tr align="left">
<td colspan="2" class="formtr1" width="100%"> <center><%=dbLabelBean.getLabel("label.forgetpassword.or",strsesLanguage)%></center></td>
 </tr>
<tr align="left">
<td class="formtr1" width="200"> <%=dbLabelBean.getLabel("label.forgetpassword.registeredemail",strsesLanguage)%> </td>
    <td class="formtr1" width="300">
		<input type="text" name="regis_email"  id="reg_email" class="textBoxCss" onfocus="checkvalue('<%=UserName %>');" onkeyup="test1('regis_email',100, 'all');Javascript: if (event.keyCode == '13'){ check();}"  width="30" size="50" class="textBoxCss">	
</td>
	<script language="JavaScript">
	document.forget_frm.regis_email.value ="<%=strEmail%>";	
	</script>
</tr>







<tr align="left">
<td class="formtr1" width="30%"> <%=dbLabelBean.getLabel("label.mylinks.secretquestion",strsesLanguage)%> </td>
    <td class="formtr1" width="70%">
		<input type="text" id="secret_ques" name="quest_secret" class="textBoxCss" onfocus="check();" onKeyUp="return test1('quest_secret',100, 'all')" width="30" size="50" class="textBoxCss" Readonly >	
</td>
<script language="JavaScript">
			document.forget_frm.quest_secret.value ="<%=strSecretQues%>";
	</script>
</tr>
<tr align="left">
	<td width="30%" class="formtr1"><%=dbLabelBean.getLabel("label.mylinks.secretanswer",strsesLanguage)%></td>
	<td width="70%" class="formtr1"><input type="password" name="ans_secret" onfocus="enablebutton();" class="textBoxCss" maxlength="15" size="22" onKeyUp="return test1('ans_secret', 15, 'pwd')"> </td>
</tr>
<tr align="center">
    <td colspan="2" width="100%" class="formBottom"><input type="submit" name="Submit"  value="<%=dbLabelBean.getLabel("button.approverequest.submit",strsesLanguage)%>" class="formButton" onClick="return checkData('<%=strflag %>');" <%=strButtonDisble%> >
          <input type="Button" name="close" value="<%=dbLabelBean.getLabel("button.global.close",strsesLanguage)%> "class="formButton" onclick="window.close();">
      </td>  
</tr>
</table>
</form>
</body>
</html>