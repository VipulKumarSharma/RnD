<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Abhinav Ratnawat
 *Date of Creation 		:24 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STARS
 *Operating environment :Tomcat, sql server 2000 
 *Description 		 	          :This is first jsp file  for updating the SITE in the STAR Database
 *Modification 		           	  :Add a new field for userName .epmcode char & numeric
										 2. Add the secret question combobox 
										 3. Secret Question field is Mendatory 
										 4.Restricting the entry of quotes(', ", \) in the fields
										 5.Add the  gender field .
										 6.change the calender icon(converted it to drop down selection for date)  by  shiv  on 07-Jun-07. 
										 7. Fixed the bug related to mismatch in password  by Gaurav Aggarwal on 22-Jun-2007
    
 *Reason of Modification: Email-id not be an userid(login name ) for the user 
 *Date of Modification      : 07-12-2006 , 3/20/2007 ,14/04/2007,16/04/2007,20/04/2007
 *Modified By			        : Vijay Singh
 *Modified By	                :   SACHIN GUPTA,shiv sharma,Vijay Singh,Vijay Singh
 *Editor				            :Editplus
 *******************************************************/
%>
<%@ page import = "java.sql.*" %>
<%@ page import = "src.connection.DbConnectionBean" %>
<%@ include  file="importStatement.jsp" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<% 
	String strSql       = ""; 
    String strCloseFlag = request.getParameter("closeFlag")==null?"outside":request.getParameter("closeFlag");
	//System.out.println("----------------------------"+strCloseFlag);
    
	DbConnectionBean bean = new DbConnectionBean(); 
//	Declare global variables
	//System.out.println("inside M_UserRegister.jsRegisterUser.java");
	String  txtFirstName 				= (request.getParameter("firstName")==null)?"":request.getParameter("firstName");
	String  txtLastName 				= (request.getParameter("lastName")==null)?"":request.getParameter("lastName");


	///2/28/2007
		String  txtEmpcode 				= (request.getParameter("empcode")==null)?"":request.getParameter("empcode");
    ///2/28/2007

	String  txtPassword 				= (request.getParameter("password")==null)?"":request.getParameter("password");
	String txtCnfmPassword 		= (request.getParameter("cnfmPassword")==null)?"":request.getParameter("cnfmPassword");

	String strUserName  		= (request.getParameter("userName")==null)?"":request.getParameter("userName");
	String  txtEMail 							= (request.getParameter("eMail")==null)?"":request.getParameter("eMail");
	String Divison_ID 					= (request.getParameter("division")==null)?"-1":request.getParameter("division");
	String Site_ID 							= (request.getParameter("site")==null)?"-1":request.getParameter("site");
	String Dept_ID 							= (request.getParameter("department")==null)?"-1":request.getParameter("department");
	String Desig_ID 						= (request.getParameter("designation")==null || request.getParameter("designation").equals("null"))?"-1":request.getParameter("designation");
	String strReportTo 					=	(request.getParameter("report_To")==null)?"":request.getParameter("report_To");
	String strQuestionSecret 		=  (request.getParameter("quest_secret")==null)?"":request.getParameter("quest_secret");
	String strAnswerSecret 			= (request.getParameter("ans_secret")==null)?"":request.getParameter("ans_secret");
	String passport_No 				= (request.getParameter("passport_No")==null)?"":request.getParameter("passport_No");
	String passport_ECNR 			= (request.getParameter("passport_ECNR")==null)?"":request.getParameter("passport_ECNR");
	String passport_issue 			= (request.getParameter("passport_issue_date")==null)?"":request.getParameter("passport_issue_date");
	String passport_FNo	 			= (request.getParameter("passport_flight_No")==null)?"":request.getParameter("passport_flight_No");
	String passport_FNo1	 		= (request.getParameter("passport_flight_No1")==null)?"":request.getParameter("passport_flight_No1");
    String passport_FNo2	 		= (request.getParameter("passport_flight_No2")==null)?"":request.getParameter("passport_flight_No2");
	String passport_expire 			= (request.getParameter("passport_expire_date")==null)?"":request.getParameter("passport_expire_date");


//new 16-02-2007
	String strCurrentAddress	=	request.getParameter("current_address")== null ? "" : request.getParameter("current_address");
	String strAirLineName		=	request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
	String strAirLineName1		=	request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
	String strAirLineName2		=	request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");

//
	String gender=(request.getParameter("gender")==null)?"-1":request.getParameter("gender");//Add by Vijay Singh on 20/04/2007
	String passport_DOB	 			= (request.getParameter("passport_DOB")==null)?"":request.getParameter("passport_DOB");
	String passport_issuePlace = (request.getParameter("passport_issue_place")==null)?"":request.getParameter("passport_issue_place");
	String passport_contactNo 	= (request.getParameter("passport_Contact_No")==null)?"":request.getParameter("passport_Contact_No");
	String passport_Address 		= (request.getParameter("passport_address")==null)?"":request.getParameter("passport_address");;
	String  strFlag 							= request.getParameter("flag");
	String[] arrayRadio 					= {"Unit ID","Across the Unit"};

	// get the current date for checking the expiryDate and DateOfBirth
  	Date currentDate = new Date();
  	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  	String strCurrentDate = (sdf.format(currentDate)).trim();
%>

<html>
	<head>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%--<%@ include  file="application.jsp" %>--%>
	<title>User Registration Screen</title>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT>
	<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></SCRIPT><!-- added by shiv on 07-Jun-07  -->

	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" /><BASE>
<script>
//Added By Vijay Singh ON 14/04/2007 TO ENABLE AND DISABLE THE FUNCTIONALITY
		 function questOther()
		{

			if(document.frm.quest_secret1.value=="Others")
			{
				document.frm.quest_secret.disabled=false;
				document.frm.ans_secret.value="";
				document.frm.quest_secret.focus();
			}
			else
			{
				document.frm.quest_secret.value="";
				document.frm.ans_secret.value="";
				document.frm.quest_secret.disabled=true;
			}
		}
//END MODIFICATION

function MM_openBrWin(theURL,winName,features)
 { 
		   window.open(theURL,winName,features);
 }
 </script>
		<script language="JavaScript">
		

		  function checkData(f1)
		  {
			if(f1.firstName.value=='')
			{
				alert("Please fill the first name");
				f1.firstName.focus();
				return false;
			}
			if(f1.lastName.value=='')
			{
				//alert("Please fill the last name"); commented by shiv on 3/19/2007
				//f1.lastName.focus();
				//return false;
			}
			if(f1.userName.value=='')
			{
				alert("Please fill the user name");
				f1.userName.focus();
				return false;
			}

			if(f1.password.value=='')
			{
				alert("Please fill the password");
				f1.password.focus();
				return false;
			}

			if(f1.cnfmPassword.value=='')
			{
				alert("Please fill the confirm password");
				f1.cnfmPassword.focus();
				return false;
			}
			
//new
			if (f1.password.value.length < 8) 
			{
				alert("The length for Password must be minimum 8 characters");
				f1.password.focus();
				return false;		
			}
			if (f1.cnfmPassword.value.length < 8) 
			{
				alert("The length for Confirm Passowrd must be minimum 8 characters");
				f1.cnfmPassword.focus();
				return false;		
			}
			if(f1.userName.value == f1.password.value)
			{
				alert("Username and Password can not be same");
				f1.password.value="";
				f1.cnfmPassword.value="";
				f1.password.focus();
				return false;
			 }
//
			if (f1.password.value != f1.cnfmPassword.value) 
			{
				alert("Password Mismatch, Please reenter");
				f1.password.focus();
				return false;		
			}

			if(f1.eMail.value=='')
			{
				alert("Please fill the Email");
				f1.eMail.focus();
				return false;
			}
			// add by vijay on 20/04/2007 to select the gender 
			if(f1.gender.value=='-1')
			{
				alert("Please select your gender");
				f1.gender.focus();
				return false;
			}

			var flag = echeck(window.document.frm.eMail.value);
			if (flag == false){
			f1.eMail.focus();
			return flag;
			}
			if(f1.site.value == -1 || f1.site.value == '')
			{
		       alert("Please select the site");
			   f1.site.focus();
			   return false;  
			}
			if(f1.department.value == -1 || f1.department.value == '')
			{
		       alert("Please select the department");
			   f1.department.focus();
			   return false;  
			}
		
			if(f1.designation.value == -1 || f1.designation.value == '')
			{
		       alert("Please select the designation");
			   f1.designation.focus();
			   return false;  
			}
           ///
		   
			if( f1.empcode.value == '')
			{
		       alert("Please Enter your  Employee Code");
			   f1.empcode.focus();
			   return false;  
			}
			//Added By Vijay Singh on 14/04/2007 check for secret Question and Answer 

			 if(f1.quest_secret1.value=='-1'||f1.quest_secret1.value=='')
			 {
				 alert("Please Select Your Secret Question");
				 f1.quest_secret1.focus();
				 return false;
			 }
			
			  if(f1.quest_secret1.value=='Others' &&f1.quest_secret.disabled==false && f1.quest_secret.value=='')
			  {

				alert("Please Enter Your  Secret Question");
				f1.quest_secret.focus();
				return false;
			  }
			   if(f1.ans_secret.value=='')
			 {
				 alert("Please Enter Your Secret Answer");
				 f1.ans_secret.focus();
				 return false;
			 }
			   if(f1.quest_secret.disabled==false && f1.quest_secret.value!='')
			  {
				f1.question_other.value=f1.quest_secret.value;
				//alert(f1.quest_other_ans.value);
				//return false;
			  }
			  else
			  {
			  f1.question_other.value = '-';
				//alert(f1.quest_other_ans.value);
				//return false;
			  }
	    	 
		//END MODIFICATION   
			 
			if(f1.passport_DOB.value == '')
			{
		       alert("Please fill the Date of Birth");
			   f1.passport_DOB.focus();
			   return false;  
			}
			
			
		    var flag = checkPassportInfo(frm); //checking if any passport informations are filled.
			if(flag == false)
				return flag;
			flag =  checkDOB(frm);
			if(flag == false)
				return flag;
     ///code added by shiv  sharma on 17-02-07  open

           var flag = CheckFFDetail(frm); 
			if(flag == false)
				{
				return flag;
			    }
    ///code added by shiv  sharma on 17-02-07  close

             
            encryption(); 
			return true;
		  }

			function getDivisonID()
			{
				var gender1=document.frm.gender.value;
				document.frm.action="M_UserRegisterByAdmin.jsp?&gender="+gender1+""; //change by vijay on 20/04/2007
				document.frm.designation.value="-1";
				document.frm.department.value="-1";
				document.frm.submit();
			}

		// fuction for get the value from the ReportTo Link
            function ReportToWindowOpen(filename) 
            {
            	designation = showModalDialog(filename+"?DIV_ID="+document.frm.division.value+"&DEPT_ID="+document.frm.department.value+
     			"&DESIG_ID="+document.frm.designation.value+
	        	"&SITE_ID="+document.frm.site.value,
       			"Win","scrollbars=no,resizable=no,menubar=no,width=350,height=350");

            	if(designation==null)
            	{
                	document.frm.report_To.value="";
             		document.frm.repToUserId.value ="0";
				}
             	else
            	{
               		document.frm.report_To.value =designation.flag;
              		var userid = designation.userid;
             		document.frm.repToUserId.value =designation.userid;
            		//alert(userid);
               	}
 			}


		function MM_closeBrWindow(closeFlag) 
		{
		   if(closeFlag != null && closeFlag != "" && closeFlag == "inside")
		   {
			  location.href="M_userList.jsp";
		   }
		   else
		   {
			  window.close();
		   }
		}

		function test1(obj1, length, str)
		{	
			var obj;
			if(obj1=='firstName')
			{
				obj = document.frm.firstName;
			}
			if(obj1=='lastName')
			{
				 obj = document.frm.lastName;
			}	

			if(obj1=='password')
			{
				 obj = document.frm.password;
			}	

			if(obj1=='cnfmPassword')
			{
				 obj = document.frm.cnfmPassword;
			}	
			if(obj1=='userName')
			{
				 obj = document.frm.userName;
			}	

             //2/28/2007

           if(obj1=='empcode')
			{
				 obj = document.frm.empcode;
			}	

			 //2/28/2007
              
			if(obj1=='eMail')
			{
				 obj = document.frm.eMail;
			}	

			if(obj1=='quest_secret')
			{
				 obj = document.frm.quest_secret;
			}	
			if(obj1=='ans_secret')
			{
				 obj = document.frm.ans_secret;
			}	
			if(obj1=='passport_No')
			{
				 obj = document.frm.passport_No;
			}	
			if(obj1=='passport_ECNR')
			{
				 obj = document.frm.passport_ECNR;
			}	
			if(obj1=='passport_flight_No')
			{
				 obj = document.frm.passport_flight_No;
			}
			
			if(obj1=='passport_flight_No1')
			{
				 obj = document.frm.passport_flight_No1;
			}	

			if(obj1=='passport_flight_No2')
			{
				 obj = document.frm.passport_flight_No2;
			}	


			if(obj1=='passport_issue_place')
			{
				 obj = document.frm.passport_issue_place;
			}	
			if(obj1=='passport_address')
			{
				 obj = document.frm.passport_address;
			}	
			if(obj1=='passport_Contact_No')
			{
				 obj = document.frm.passport_Contact_No;
			}	

			//new 16-02-2007 sachin
			if(obj1=='current_address')
			{
				 obj = document.frm.current_address;
			}
			if(obj1=='airLineName')
			{
				 obj = document.frm.airLineName;
			}	
			if(obj1=='airLineName1')
			{
				 obj = document.frm.airLineName1;
			}	
			if(obj1=='airLineName2')
			{
				 obj = document.frm.airLineName2;
			}	
//
		
		    
			//var obj11 = document.frm.obj1.value;
			//alert(""+obj11);
			charactercheck(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj); //function for checking leading zero and spaces
			spaceChecking(obj);
		}
		
		function report_to(filename,k)
		{
		reportto = showModalDialog(filename+"?site_id="+document.frm.reportto[k].value+"&i="+k,"Win","scrollbars=yes,resizable=no,menubar=no,width=350,height=350");
		if(reportto==null)
			{
			document.frm.report.value="";
			}
		else
			{
			document.frm.report.value=reportto.flag;
			document.frm.repToUserId.value=reportto.userid;
			}
		}



         function encryption()
         {
            var password=document.frm.password.value;
            var newPassword=encrypt(password);
            document.frm.password.value=newPassword;
            //alert("Encrypted pwd with key is being sent to request "+newPassword);
            return true;
         }

		 function checkMinLength()
		 {

		 }
         
		 // added  on 07-Jun-07  by  shiv   
		 function button_onclick(obj) 
	     {
		  popUpCalendar(obj,obj,"dd/mm/yyyy");
		 }

		

		</script>
	</head>

<!-- Start of body -->
	<body >
	<table width="100%" border="0" cellspacing="0" cellpadding="10">
      <tr>
        <td width="77%" class="bodyline-top"><ul class="pagebullet">
            <li class="pageHead">New User Registration Form</li>
        </ul></td>
      </tr>
    </table>

	<table width="100%" border="0" cellspacing="0" cellpadding="10">
    </table><form name="frm" method="post" action = "RegisterUser">
      <table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
    <tr align="left">
      <td  colspan="4" class="selectedmenubg"><ul class="pagebullet">
        <% if (strFlag == null){ %>
          <Font color='red'><li class="pageHead">Register Yourself </li></Font>
        <% } else {%>
        </ul>
        <% if (strFlag.equals("redundantEmail")){ %>
          <li class="pageHead"><Font color='red'>User with same E-MailId already exists; Please Try again.</Font> </li>
        <% } %>
		<% if (strFlag.equals("redundantUserName")){ %>
          <li class="pageHead"><Font color='red'>User with same User Name already exists; Please Try again.</Font></li>
        <% } %>
		<% if (strFlag.equals("redundantEmpcode")){ %>
          <li class="pageHead"><Font color='red'>User with same Employee code  already exists; Please Try again.</Font></li>
        <% } %>
        <% if (strFlag.equals("new")){ %>
          <li class="pageHead">Register User </li>
        <% } %>
          <% if (strFlag.equals("failure")){ %>
          <li class="pageHead"><Font color='red'>Error has been occured during registration.Kindly contact the STARS administrator</Font> </li>
        <% } %>
          <% } %> 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;<span class="formTit" style="text-align:right"><img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" onClick="MM_openBrWin('help.html','','scrollbars=yes,resizable=yes,width=700,height=300')"></td>
    </tr>
    <tr align="left">
      <td colspan="4" class="dataLabel">Create Your User ID!</td>
    </tr>
    <tr align="left">
      <td colspan="4" class="formtr1">Fields marked with an asterisk<font color="#FF3300"> (*) </font>are mandatory</td>
    </tr>
    <tr align="left">
      <td width="116" class="formtr1"><font size="" color="#FF3300">*</font>First Name<br> 
      (As per passport)</td>
      <td width="220" class="formtr1"><input type="text" name="firstName" size="25" onKeyUp="return test1('firstName', 29, 'c')" maxlength="30" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.firstName.value ="<%=txtFirstName%>";
			</script>
      <td width="120" class="formtr1"><font size="" color="#FF3300"></font>Last Name<br> 
      (As per passport) </td>
      <td width="328" class="formtr1"><input type="text" name="lastName" size="25" onKeyUp="return test1('lastName', 29, 'c')" maxlength="30" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.lastName.value ="<%=txtLastName%>";
			</script>
    </tr>
	 <tr align="left">
      <td class="formtr1"><font size="" color="#FF3300">*</font>User Name </td>
      <td class="formtr1"><input name="userName" type="text" class="textBoxCss" onKeyUp="return test1('userName', 50, 'an')" size="34" maxlength="50" /></td>
	  <script language="javascript">
			document.frm.userName.value ="<%=strUserName%>";
			</script>
  	 <% if (strFlag!= null && strFlag.equals("redundantUserName")){ %>
      <script language = "JavaScript">
			window.document.frm.userName.focus();
			window.document.frm.userName.select();
			</script>
      <% } %>	
	  
      <td class="formtr1"><font size="" color="#FF3300">*</font> Email</td>
      <td class="formtr1"><input type="text" name="eMail" size="34" onKeyUp="return test1('eMail', 50, 'an')" maxlength="50" class="textBoxCss" /></td>
	  <script language="javascript">
			document.frm.eMail.value ="<%=txtEMail%>";
			</script>
      <% if (  strFlag!= null && strFlag.equals("redundantEmail")){ %>
      <script language = "JavaScript">
			window.document.frm.eMail.focus();
			window.document.frm.eMail.select();
			</script>
      <% } %>
      <% 
				ResultSet rs = bean.executeQuery("SELECT  DIV_ID FROM M_SITE WHERE APPLICATION_ID=1 AND STATUS_ID = 10 and SITE_ID="+Site_ID); 
				while(rs.next())
				{
				 Divison_ID=rs.getString(1);
				}
				rs.close();
				%>
      <input type="hidden" name="division">
      <script language="javascript">
			document.frm.division.value ="<%=Divison_ID%>";
			</script>	
    </tr>
    <tr align="left">
      <td class="formtr1"><font size="" color="#FF3300">*</font>Password</td>
      <td class="formtr1"><input type="password" name="password" size="15" onKeyUp="return test1('password', 15, 'pwd')" maxlength="15" class="textBoxCss" /></td>
      <script language="javascript">
			//Bug related to mismatch in password  by Gaurav Aggarwal on 22-Jun-2007
			//document.frm.password.value ="<%=txtCnfmPassword%>";
			document.frm.password.value ="<%=txtPassword%>";
			// @Gaurav End of code
			
			</script>

      <td class="formtr1"><font size="" color="#FF3300">*</font>Confirm Password </td>
      <td class="formtr1"><input type="password" name="cnfmPassword" size="15" onKeyUp="return test1('cnfmPassword', 15, 'pwd')" maxlength="15" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.cnfmPassword.value ="<%=txtCnfmPassword%>";
			</script>
    </tr>
   <!-- @ Vijay Singh changes on 20/04/2007 for Adding the gender-->
	<tr align="left">
	  <td class="formtr1" colspan='2'><font size='1' color='red'>minimum of 8 character are required for Password and Confirm.</font>
	  </td>
	  <td  class="formtr1"><font size="" color="#FF3300">*</font>Gender </td>
	 
	  <td class="formtr1">
			<select name="gender" class="textBoxCss">
				<option value="-1">Gender</option>
				<option value="Male">Male</option>
				<option value="Female">Female</option>
			</select>
			<script>
				document.frm.gender.value="<%=gender%>";
	 
			 </script>
	</td>
	
	</tr>
   <!--End Modification-->
      
    <tr align="left">
      <td class="formtr1"><font size="" color="#FF3300">*</font> Unit</td>
      <td class="formtr1">
	    <select name="site" class="textBoxCss" onChange="getDivisonID()">
		<option value="-1">Select Your Unit </option>
<% 
//////--------------------change done by shiv on 20/04/2007 open------------------------------------------s
//New Check for local administrator  
		if((SuserRole.trim().equals("AD")))
		{
		 strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE  APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME";	
		  rs = bean.executeQuery(strSql); 
		}
		else
		{
                strSql="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
			    rs = bean.executeQuery(strSql);    
				if(!rs.next())
				{
						strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE SITE_ID="+strSiteIdSS+" AND  APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME";
						 rs = bean.executeQuery(strSql); 
				}
				else
			    {

						strSql="SELECT  SITE_ID,dbo.SITENAME(SITE_ID) FROM  M_USERROLE WHERE STATUS_ID=10 AND USERID="+Suser_id+" ORDER BY 1";
						 rs = bean.executeQuery(strSql); 
					     %>
								  
						<%
								 while(rs.next()) 
								 { 
						%>
								  <option value ="<%=rs.getString(1)%>" > <%= rs.getString(2) %></option>
						<%
								 }
								 //rs.close(); 
						%>
							    
           <%
				}

 		

		  /*strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE SITE_ID="+strSiteIdSS+" AND  APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME";	
		  */
		}
//
		// rs = bean.executeQuery(strSql); 

/////  --------------------------------change done by shiv on 20/04/2007 close ------------------------------------------------
%>
	      <!-- <option value="-1">Select Your Unit </option> -->
<%
 		 while(rs.next()) 
		 { 
%>
          <option value ="<%=rs.getString(1)%>" > <%= rs.getString(2) %></option>
<%
		 }
		 rs.close(); 
%>
	    </select>
	  </td>
	  <script language="javascript">
			document.frm.site.value ="<%=Site_ID%>";
		</script>
      <td class="formtr1"><font size="" color="#FF3300">*</font> Department</td>
      <td class="formtr1">
	    <select name="department" class="textBoxCss">
<% 
		String query = "SELECT DEPT_ID,DEPT_NAME from M_DEPARTMENT WHERE SITE_ID ="+Site_ID+" AND APPLICATION_ID=1 AND STATUS_ID = 10 AND DIV_ID=(select DIV_ID from M_SITE where site_id="+Site_ID+" AND STATUS_ID=10 AND APPLICATION_ID=1 )ORDER BY DEPT_NAME";
//		System.out.println("himanshu--->> "+query);
		rs = bean.executeQuery(query); 
%>
          <option value="-1"> Select  Your Department</option>
<%
		while(rs.next()) 
		{ 
%>
          <option value = <%=rs.getString(1)%> > <%= rs.getString(2) %></option>
<%
		}
		rs.close();
%>
        </select></td>
	    <script language="javascript">
			document.frm.department.value ="<%=Dept_ID%>";
		</script>
    </tr>
    <tr align="left">
      <td class="formtr1"><font size="" color="#FF3300">*</font> Designation </td>
      <td class="formtr1">
	    <select name="designation" class="textBoxCss">
<% 
 		rs = bean.executeQuery("SELECT DESIG_ID,DESIG_NAME  FROM M_DESIGNATION where site_id="+Site_ID+" AND APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY DESIG_NAME"); 
%>
          <option value="-1"> Select Your Designation </option>
<%
		while(rs.next()) 
	    { 
%>
          <option value = <%=rs.getString(1)%> > <%= rs.getString(2) %></option>
<%
		}
		rs.close();
%>
        </select>
	  </td>
	  <script language="javascript">
			document.frm.designation.value ="<%=Desig_ID%>";
	  </script>
      
      <td class="formtr1"><font size="" color="#FF3300">*</font> Employee Code</td><!-- 2/28/2007 -->            
	  <td class="formtr1"><input type="text" name="empcode" value="<%=txtEmpcode%>" size="15" onKeyUp="return test1('empcode', 15, 'cn')" maxlength="15" class="textBoxCss" />
      </td>
	  <!--  3/2/2007 emp code open-->
	  <% if (  strFlag!= null && strFlag.equals("redundantEmpcode")){ %>
      <script language = "JavaScript">
			window.document.frm.empcode.focus();			
		</script>
      <% } %>
       
	  <!-- 3/2/2007 emp code -->
       
      
    </tr>
    <tr align="center">
      <td colspan="4" align="left" class="dataLabel">Select the Person you Report To!</td>
    </tr>
    <tr align="center">
      <% for(int i=0;i<=1;i++) { %>
      <td class="formtr1"><input type="radio" value=<%=Site_ID%> name="reportto" onClick="report_to('report_to.jsp','<%=i%>');">
          <%=arrayRadio[i]%></td>
      <% } %>
      <td class="formtr1"><input name="report" type="text" class="textBoxCss" size="34" maxlength="25" readonly >
    <td class="formtr1">    </tr>
    <tr align="center">
      <td colspan="4" align="left" class="dataLabel">If You Forget Your Password!</td>
    </tr>
   	  <tr align="center">
      <td class="formtr1"><font size="" color="#FF3300">*</font> Secret Question </td>
	  <!--@ Vijay Singh 11/04/2007 add the option for secret question -->
      <td class="formtr1">
			<select name="quest_secret1" class="textBoxCss" onChange="questOther();">
				<option value="-1">Select Your Question</option>
				<option value="Your college Name">Your college Name</option>
				<option value="Your Mother's Maiden Name">Your Mother's Maiden Name</option>
				<option value="Your Native Place">Your Native Place</option>
				<option value="Your Pet Name">Your Pet Name</option>
				<option value="Others">Others</option>
			</select>
	</td>
	   <!--@ END MODIFICATION-->
	<td class="formtr1">
	  <input type="text" name="quest_secret" size="34" onKeyUp="return test1('quest_secret', 100, 'an')" maxlength="100" class="textBoxCss" disabled/>
	</td>
					<td class="formtr1">
					</td>
	</tr>
      <script language="javascript">
			document.frm.quest_secret.value ="<%= strQuestionSecret %>";
	</script>
    <tr>
	  <td class="formtr1"><font size="" color="#FF3300">*</font>Secret Answer </td>
      <td class="formtr1"><input type="password" name="ans_secret" size="34" onKeyUp="return test1('ans_secret', 15, 'pwd')" maxlength="15" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.ans_secret.value ="<%= strAnswerSecret %>";
	  </script>
				<td class="formtr1">
				</td>
				<td class="formtr1">
				</td>
    </tr>
    <tr align="center">
      <td colspan="4" align="left" class="formtr1"><span style="font-family:Arial; font-size:8.5pt; color:black; "> Please provide a complex answer hard to crack.</span></td>
    </tr>
    <tr align="center">
      <td colspan="4" align="left" class="dataLabel">Feed Your Passport Details!</td>
    </tr>
    <tr align="center">
      <td width="116" class="formtr1">Passport No</td>
      <td width="220" class="formtr1"><input type="text" name="passport_No" size="25" onKeyUp="return test1('passport_No', 49, 'all')" maxlength="10" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.passport_No.value ="<%= passport_No %>";
			</script>
      <td width="120" class="formtr1">Emigration Clearance Required</td>
      <td width="328" class="formtr1"> 
  	    <input name="passport_ECNR" type="radio" value="1" />Yes 
        <input name="passport_ECNR" type="radio" checked = "checked"  value="2"/>
        No</td>
        <script language="javascript">
			document.frm.passport_ECNR.value ="<%= passport_ECNR %>";
			if (document.frm.passport_ECNR.value == 1) {
				document.frm.passport_ECNR[0].checked = true;
			} else if (document.frm.passport_ECNR.value == 2) {
				document.frm.passport_ECNR[1].checked = true;		
		    }
		</script>
    </tr>
    <tr align="left">
      <td class="formtr1">Date of Issue(DD/MM/YYYY)</td>
      <td class="formtr1"><input type="text" name="passport_issue_date" size="10" maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
        <!--<a href="javascript:show_calendar('frm.passport_issue_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
           <!-- 	<img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> -->
			
				<!-- added by shiv on 07-Jun-07  open-->
				<a onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"  onclick="button_onclick(document.frm.passport_issue_date);">
       		    <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17>
				 </a> </td>
		<!-- added by shiv on 07-Jun-07  close-->
      <script language="javascript">
			document.frm.passport_issue_date.value ="<%= passport_issue %>";
			</script>
      <td class="formtr1">Frequent Flyer Number</td>
      <td class="formtr1">&nbsp;</td>
    </tr>
    <tr align="left">
      <td class="formtr1">&nbsp;</td>
      <td class="formtr1">&nbsp;</td>
      <td colspan="2" class="formtr1"><table width="177" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="left" valign="bottom" class="formtr1"><span class="label2">Airline Names &nbsp;</span></td>
          <td align="left" valign="bottom" class="formtr1"><span class="label2">Airline Number</span></td>
        </tr>
        <tr>
  		  <td width="88" align="center" class="formtr1"><input type="text" name="airLineName" size="12"  onKeyUp="return test1('airLineName', 20, 'cn')" maxlength="12" class="textBoxCss" /></td>
          <td width="89" align="center" class="formtr1"><input type="text" name="passport_flight_No" size="12"  onKeyUp="return test1('passport_flight_No', 20, 'cn')" maxlength="12" class="textBoxCss" />          </td>
		</tr>
        <tr>
          
          <td align="center" class="formtr1"><input type="text" name="airLineName1" size="12"  onKeyUp="return test1('airLineName1', 20, 'cn')" maxlength="12" class="textBoxCss" /></td>
		  <td align="center" class="formtr1"><input type="text" name="passport_flight_No1" size="12"  onKeyUp="return test1('passport_flight_No1', 20, 'cn')" maxlength="12" class="textBoxCss" /></td>
          </tr>
        <tr>
	    	<td align="center" class="formtr1"><input type="text" name="airLineName2" size="12"  onKeyUp="return test1('airLineName2', 20, 'cn')" maxlength="12" class="textBoxCss" /></td>
            <td align="center" class="formtr1"><input type="text" name="passport_flight_No2" size="12"  onKeyUp="return test1('passport_flight_No2', 20, 'cn')" maxlength="12" class="textBoxCss" /></td>
          
          </tr>
        <script language="javascript">
			document.frm.passport_flight_No.value ="<%= passport_FNo %>";
			document.frm.passport_flight_No1.value ="<%= passport_FNo1 %>";
			document.frm.passport_flight_No2.value ="<%= passport_FNo2 %>";
			
			document.frm.airLineName.value ="<%= strAirLineName %>";
			document.frm.airLineName1.value ="<%= strAirLineName1 %>";
			document.frm.airLineName2.value ="<%= strAirLineName2 %>";
			</script>
      </table></td>
      </tr>
    <tr align="left">
      <td class="formtr1">Date of Expiry &nbsp;&nbsp;(DD/MM/YYYY) </td>
      <td class="formtr1"><input type="text" name="passport_expire_date" size="10" maxlength="50" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
          <!-- <a href="javascript:show_calendar('frm.passport_expire_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
		   <!-- <img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> -->
		   
		   <!-- added by shiv on 07-Jun-07 -->
            	   <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;" onclick="button_onclick(document.frm.passport_expire_date);">
		          <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17>
		  <!-- added by shiv on 07-Jun-07 close -->
		  
		  </a><script language="javascript">document.frm.passport_expire_date.value ="<%= passport_expire %>";
			</script></td>
      <td class="formtr1">DOB<font size="" color="#FF3300">*</font>(DD/MM/YYYY)</td>
      <td class="formtr1"><input type="text" name="passport_DOB" size="10" maxlength="50" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">

        <!--<a href="javascript:show_calendar('frm.passport_DOB','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><!-- <img src="images/calender.png?buildstamp=2_0_0" name="imageField" width="26" height="19" border="0" align="absmiddle">  -->
             
			   <!-- added by shiv  on 07-Jun-07 open -->

                 <a  onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;" onclick="button_onclick(document.frm.passport_DOB);">
 		        <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17>
			 <!-- added by shiv on 07-Jun-07 close-->
		
		
		</a> </td>
      <script language="javascript">
			document.frm.passport_DOB.value ="<%= passport_DOB %>";
			</script>
    </tr>
    <tr align="left">
      <td class="formtr1"> Place of issue </td>
      <td class="formtr1"><input type="text" name="passport_issue_place" size="34" onKeyUp="return test1('passport_issue_place', 99, 'c')" maxlength="25" class="textBoxCss" /></td>
	      <script language="javascript">
			document.frm.passport_issue_place.value ="<%= passport_issuePlace %>";
			</script>
      <td class="formtr1"> Mobile Number</td>
      <td class="formtr1"><input type="text" name="passport_Contact_No" size="12" onKeyUp="return test1('passport_Contact_No', 19, 'phone')" maxlength="19" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.passport_Contact_No.value ="<%= passport_contactNo %>";
			</script>
    </tr>
    <tr align="left">
      <td class="formtr1"> Permanent Address</td>
      <td class="formtr1"><span class="label2">
        <textarea name="passport_address" rows="5" cols="30" id="passport_address"></textarea>
      </span></td>
      <script language="javascript">
			document.frm.passport_address.value ="<%= passport_Address %>";
			</script>
      <td class="formtr1">Current Address</td>
      <td class="formtr1"><span class="label2">
        <textarea name="current_address" rows="5" cols="30" id="textarea"></textarea>
         </span>
	  </td>
	  <script language="javascript">
			document.frm.current_address.value ="<%= strCurrentAddress %>";
	  </script>
    </tr>
    <tr align="center">
      <td colspan="4" class="formBottom"><input type="submit" name="Submit" value="Register" class="formButton" onClick="return checkData(this.form)">
          <input type="Reset" name="Submit2" value="Reset "class="formButton"  >
          <input type="button" name="Submit2" value="Close "class="formButton"  onClick="MM_closeBrWindow('<%=strCloseFlag%>')">      </td>
			 <tr>
      <input type="hidden" name="status_id" value="10" >  <!--  HIDDEN FIELD  -->
      <input type="hidden" name="repToUserId" >      <!--  HIDDEN FIELD  -->
      <input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/>      <!--  HIDDEN FIELD  -->
      <input type="hidden" name="closeFlag" value="<%=strCloseFlag%>"/>      <!--  HIDDEN FIELD  -->
	  <input type="hidden" name="question_other" value="" ><!-- Add by Vijay on 14/04/2007  for other secret question-->
    </tr>
			</table>
</form>
	<!-- End of Form  -->
	</body>
</html>