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
									    10.change the size of  maxlength from 12 to 20 in Frequent Flyer Number of Airline Names,Airline Number on 04-Jul-07      by shiv  
										11. Added  New identity  proof on user Registration  on 22-Oct-07   by Shiv Sharma  
										12 Added  new fields for windows user id,domian id flag on 05-02-2009 by shiv sharma
										13: change text domian name to network domain name on 25 feb 2010  by shiv sharma 
    
 *Reason of Modification: Email-id not be an userid(login name ) for the user 
 *Date of Modification      : 07-12-2006 , 3/20/2007 ,14/04/2007,16/04/2007,20/04/2007
 *Modified By			        : Vijay Singh
 *Modified By	                :   SACHIN GUPTA,shiv sharma,Vijay Singh,Vijay Singh
 *Editor				            :Editplus
 
 *Modified BY					:Manoj Chand
 *Date of Modification			:02 May 2011
 *Modification 					:implement mandatory selection check on fields windows userid and network domain name
 
 *Modified BY					:Manoj Chand
 *Date of Modification			:01 June 2011
 *Modification 					:retain fields value like secret questinon, secret answer, windows userid, network domain name and
 								 making password and confirm password field blank when username already exits.
 								 
*Modified By					:Manoj Chand
*Date of Modification			:28 July 2011
*Modification					:change query to add passport as identity proof 

*Modified By					:Manoj Chand
*Date of Modification			:03 July 2011
*Modification					:change query to remove closed unit from unit dropdown

*Modified By					:Manoj Chand
*Date of Modification			:23 Aug 2012
*Modification					:showing across the unit in japanese also by sending language. 	

*Modified By					:Manoj Chand
*Date of Modification			:17 Jan 2013
*Modification					:add alert if duplicate user is register based on their firstname,lastname and dob.

*Modified By					:Manoj Chand
*Date of Modification			:22 Oct 2013
*Modification					:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%> 
<%@ page import = "java.sql.*" pageEncoding="UTF-8" %>
<%@ page import = "src.connection.DbConnectionBean" %>
<%@ include  file="importStatement.jsp" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %>
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<% 
request.setCharacterEncoding("UTF-8");
	String strSql       = ""; 
    String strCloseFlag = request.getParameter("closeFlag")==null?"outside":request.getParameter("closeFlag");
	//System.out.println("----------------------------"+strCloseFlag);
    
	DbConnectionBean bean = new DbConnectionBean(); 
//	Declare global variables
	//System.out.println("inside M_UserRegister.jsRegisterUser.java");
	String  txtFirstName 				= (request.getParameter("firstName")==null)?"":request.getParameter("firstName");
	
	String  txtmiddleName 				= (request.getParameter("middleName")==null)?"":request.getParameter("middleName");
	
	String  txtLastName 				= (request.getParameter("lastName")==null)?"":request.getParameter("lastName");
	//Added by manoj chand on 01 june 2011
	String strWindowsUserId		= (request.getParameter("winUserID")==null)?"":request.getParameter("winUserID");
	String strNetworkDomainName	= (request.getParameter("domainname")==null)?"":request.getParameter("domainname");
	String strSecretQuestion	= (request.getParameter("quest_secret1")==null)?"-1":request.getParameter("quest_secret1");
	
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
	String passportIssuCountry 		= request.getParameter("pp_issu_Country")==null?"0":request.getParameter("pp_issu_Country").trim();
	String nationality 				= (request.getParameter("nationality")==null)?"":request.getParameter("nationality");
	String passport_ECNR 			= (request.getParameter("passport_ECNR")==null)?"":request.getParameter("passport_ECNR");
	String passport_issue 			= (request.getParameter("passport_issue_date")==null)?"":request.getParameter("passport_issue_date");
	String passport_FNo	 			= (request.getParameter("passport_flight_No")==null)?"":request.getParameter("passport_flight_No");
	String passport_FNo1	 		= (request.getParameter("passport_flight_No1")==null)?"":request.getParameter("passport_flight_No1");
    String passport_FNo2	 		= (request.getParameter("passport_flight_No2")==null)?"":request.getParameter("passport_flight_No2");
	String passport_expire 			= (request.getParameter("passport_expire_date")==null)?"":request.getParameter("passport_expire_date");
 //Mukesh Mishra
     String passport_FNo3	 		= (request.getParameter("passport_flight_No3")==null)?"":request.getParameter("passport_flight_No3");
     String passport_FNo4	 		= (request.getParameter("passport_flight_No4")==null)?"":request.getParameter("passport_flight_No4");


//new 16-02-2007
	String strCurrentAddress	=	request.getParameter("current_address")== null ? "" : request.getParameter("current_address");
	String strAirLineName		=	request.getParameter("airLineName")== null ? "" : request.getParameter("airLineName");
	String strAirLineName1		=	request.getParameter("airLineName1")== null ? "" : request.getParameter("airLineName1");
	String strAirLineName2		=	request.getParameter("airLineName2")== null ? "" : request.getParameter("airLineName2");
	//Mukesh Mishra
	String strAirLineName3		=	request.getParameter("airLineName3")== null ? "" : request.getParameter("airLineName3");
	String strAirLineName4		=	request.getParameter("airLineName4")== null ? "" : request.getParameter("airLineName4");
	String hotelChain				=request.getParameter("hotelChain")== null ? "" : request.getParameter("hotelChain");
	String hotelChain1				=request.getParameter("hotelChain1")== null ? "" : request.getParameter("hotelChain1");
	String hotelChain2				=request.getParameter("hotelChain2")== null ? "" : request.getParameter("hotelChain2");
	String hotelChain3				=request.getParameter("hotelChain3")== null ? "" : request.getParameter("hotelChain3");
	String hotelChain4				=request.getParameter("hotelChain4")== null ? "" : request.getParameter("hotelChain4");
	String hotelNumber				=request.getParameter("hotelNumber")== null ? "" : request.getParameter("hotelNumber");
	String hotelNumber1				=request.getParameter("hotelNumber1")== null ? "" : request.getParameter("hotelNumber1");
	String hotelNumber2				=request.getParameter("hotelNumber2")== null ? "" : request.getParameter("hotelNumber2");
	String hotelNumber3				=request.getParameter("hotelNumber3")== null ? "" : request.getParameter("hotelNumber3");
	String hotelNumber4				=request.getParameter("hotelNumber4")== null ? "" : request.getParameter("hotelNumber4");

	
//
	String gender=(request.getParameter("gender")==null)?"-1":request.getParameter("gender");//Add by Vijay Singh on 20/04/2007
	String passport_DOB	 			= (request.getParameter("passport_DOB")==null)?"":request.getParameter("passport_DOB");
	String passport_issuePlace = (request.getParameter("passport_issue_place")==null)?"":request.getParameter("passport_issue_place");
	String passport_contactNo 	= (request.getParameter("passport_Contact_No")==null)?"":request.getParameter("passport_Contact_No");
	String passport_Address 		= (request.getParameter("passport_address")==null)?"":request.getParameter("passport_address");;
	String  strFlag 							= request.getParameter("flag")==null?"":request.getParameter("flag");
	//System.out.println("flag is --->"+strFlag);
	
	if(!strFlag.equalsIgnoreCase("")){
		txtPassword="";
		txtCnfmPassword="";
	}
	
		
	String[] arrayRadio 					= {dbLabelBean.getLabel("label.mylinks.unitid",strsesLanguage),dbLabelBean.getLabel("label.mylinks.acrosstheunit",strsesLanguage)};


	String strIdentityProof		= (request.getParameter("identityProof")==null)?"-1":request.getParameter("identityProof");
	String strIdentityProofNo = (request.getParameter("identityProofno")==null)?"":request.getParameter("identityProofno");
	String strTravelAgencyCode	= "1";
	String strSAPUserSyncFlag	= "N";
	
	ResultSet rSet	=	null;
    strSql 			=   "SELECT TRAVEL_AGENCY_ID, SAP_USER_SYNC_FLAG FROM M_SITE WHERE SITE_ID="+Site_ID+" AND STATUS_ID = 10";
    rSet     		=   bean.executeQuery(strSql);
    if(rSet.next()) {
    	strTravelAgencyCode = rSet.getString("TRAVEL_AGENCY_ID");
    	strSAPUserSyncFlag	= rSet.getString("SAP_USER_SYNC_FLAG");
    }
    rSet.close();

	// get the current date for checking the expiryDate and DateOfBirth
  	Date currentDate = new Date();
  	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  	String strCurrentDate = (sdf.format(currentDate)).trim();

	
String strWinUserID             =""; 
String strDomainName			="";
%>

<html>
	<head>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>


<%@ include file="M_InsertProfile.jsp"  %>
	<title>User Registration Screen</title>
	<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
	<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
	<SCRIPT language="JavaScript" src="ScriptLibrary/date-pickers.js?buildstamp=2_0_0"></SCRIPT>
	<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
	<script language="JavaScript" src="scripts/CommonValida1.js?buildstamp=2_0_0"></script>
	<script language="JavaScript" src="scripts/Encryption.js?buildstamp=2_0_0"></script>
	<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar-div.js?buildstamp=2_0_0"></SCRIPT><!-- added by shiv on 07-Jun-07  -->
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" /><BASE>
	
<script>
	var SAPUserSyncFlag = '<%=strSAPUserSyncFlag%>';
	
	$(document).ready(function() {
		if(SAPUserSyncFlag == 'Y') {
			$('[name=Submit]').attr('disabled',true);
			alert('<%=dbLabelBean.getLabel("alert.sapusersync.cannotregisteruser",strsesLanguage)%>');
		} else {
			$('[name=Submit]').attr('disabled',false);
		}
	});
	
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
		
		var travelAgencyCode ='<%=strTravelAgencyCode%>';  
		
		  function checkData(f1)
		  {
			if(f1.firstName.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.global.firstname",strsesLanguage)%>');
				f1.firstName.focus();
				return false;
			}
			if(f1.lastName.value=='' && travelAgencyCode == '2')
			{
				alert("Please fill the last name"); 
				f1.lastName.focus();
				return false;
			}
			
			if(f1.middleName.value=='')
			{
				//alert("Please fill the last name"); commented by shiv on 3/19/2007
				//f1.lastName.focus();
				//return false;
			}
			if(f1.gender.value=='-1')
			{
				alert('<%=dbLabelBean.getLabel("alert.global.gender",strsesLanguage)%>');
				f1.gender.focus();
				return false;
			}
			if(f1.userName.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.login.entertheusername",strsesLanguage)%>');
				f1.userName.focus();
				return false;
			}
			if(f1.eMail.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.mylinks.enteremail",strsesLanguage)%>');
				f1.eMail.focus();
				return false;
			}
		
			var flag = echeck(window.document.frm.eMail.value);
			if (flag == false){
			f1.eMail.focus();
			return flag;
			}
			
			if(f1.password.value=='')
			{
				alert('<%=dbLabelBean.getLabel("alert.login.enterthepassword",strsesLanguage)%>');
				f1.password.focus();
				return false;
			}

			if(f1.cnfmPassword.value=='')
			{
				alert('<%=dbLabelBean.getLabel("label.register.pleasefillconfirmpassword",strsesLanguage)%>');
				f1.cnfmPassword.focus();
				return false;
			}
			
//new
			if (f1.password.value.length < 8) 
			{
				alert('<%=dbLabelBean.getLabel("alert.mylinks.lengthofpassword",strsesLanguage)%>');
				f1.password.focus();
				return false;		
			}
			if (f1.cnfmPassword.value.length < 8) 
			{
				alert('<%=dbLabelBean.getLabel("label.register.lengthconfirmpasswordminimum",strsesLanguage)%>');
				f1.cnfmPassword.focus();
				return false;		
			}
			if(f1.userName.value == f1.password.value)
			{
				alert('<%=dbLabelBean.getLabel("alert.mylinks.usernameandpasswordnotsame",strsesLanguage)%>');
				f1.password.value="";
				f1.cnfmPassword.value="";
				f1.password.focus();
				return false;
			 }
//
			if (f1.password.value != f1.cnfmPassword.value) 
			{
				alert('<%=dbLabelBean.getLabel("label.register.passwordmismatchreenter",strsesLanguage)%>');
				f1.password.focus();
				return false;		
			}

			
			if(f1.site.value == -1 || f1.site.value == '')
			{
		       alert('<%=dbLabelBean.getLabel("alert.global.unitname",strsesLanguage)%>');
			   f1.site.focus();
			   return false;  
			}
			if(f1.department.value == -1 || f1.department.value == '')
			{
				if(travelAgencyCode =='2') {
					alert('<%=dbLabelBean.getLabel("alert.global.costcentre",strsesLanguage)%>');
				} else {
					alert('<%=dbLabelBean.getLabel("alert.mylinks.selectdepartment",strsesLanguage)%>');
				}
			   f1.department.focus();
			   return false;  
			}
		
			if(f1.designation.value == -1 || f1.designation.value == '')
			{
		       alert('<%=dbLabelBean.getLabel("alert.global.designation",strsesLanguage)%>');
			   f1.designation.focus();
			   return false;  
			}
           ///
		   
			if( f1.empcode.value == '')
			{
		       alert('<%=dbLabelBean.getLabel("alert.mylinks.enteremployeecode",strsesLanguage)%>');
			   f1.empcode.focus();
			   return false;  
			}


			 ///added by shiv sharma on 22 -oct -2007  for adding IDENTITy proof 

			if(f1.identityProof.value!="-1")
				  {
					
					if (f1.identityProofno.value=='')
					  {
						alert('<%=dbLabelBean.getLabel("alert.createrequest.identityproofnumber",strsesLanguage)%>');
						f1.identityProofno.focus();
						 return false;  

					}
				}
				
				//added by shiv sharma  on 03-02-2009
				//winUserID domainname
				//ADDED BY MANOJ ON 20 APRIL 2011
				if(f1.winUserID.value=='')
				  {
						alert('<%=dbLabelBean.getLabel("label.register.pleasefillwindowsuserid",strsesLanguage)%>');
						f1.winUserID.focus();
						return false;  
				  }
				
				
				
				if(f1.winUserID.value!='')
				  {
					if (f1.domainname.value=='')
					  {
						alert('<%=dbLabelBean.getLabel("alert.mylinks.enternetworkdomainname",strsesLanguage)%>');
						f1.domainname.focus();
						return false;  

					}
				}

	
			//Added By Vijay Singh on 14/04/2007 check for secret Question and Answer 

			 if(f1.quest_secret1.value=='-1'||f1.quest_secret1.value=='')
			 {
				 alert('<%=dbLabelBean.getLabel("alert.mylinks.selectsecretquestion",strsesLanguage)%>');
				 f1.quest_secret1.focus();
				 return false;
			 }
			
			  if(f1.quest_secret1.value=='Others' &&f1.quest_secret.disabled==false && f1.quest_secret.value=='')
			  {

				alert('<%=dbLabelBean.getLabel("alert.mylinks.entersecretquestion",strsesLanguage)%>');
				f1.quest_secret.focus();
				return false;
			  }
			   if(f1.ans_secret.value=='')
			 {
				 alert('<%=dbLabelBean.getLabel("alert.mylinks.entersecretanswer",strsesLanguage)%>');
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
		       alert('<%=dbLabelBean.getLabel("alert.global.dob",strsesLanguage)%>');
			   f1.passport_DOB.focus();
			   return false;  
			}

			if(f1.repToUserId.value == '' || f1.report.value == '')
			{
		       alert('<%=dbLabelBean.getLabel("alert.global.reportto",strsesLanguage)%>');
			   f1.report.focus();
			   return false;  
			}
			if(f1.deptHeadUserId.value == '' || f1.deptHead.value == '')
			{
		       alert('<%=dbLabelBean.getLabel("alert.global.deptHead",strsesLanguage)%>');
			   f1.deptHead.focus();
			   return false;  
			}

			
			var flag;
			if(travelAgencyCode == '2') {
				flag = checkPassportInfoGmbH(f1);
			} else {
				flag = checkPassportInfo(f1); //checking if any passport informations are filled.
			}
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

			//code added by manoj chand on 17 dec 2012 to check duplicate user.
			var result=checkDuplicateUser();
			if(result==false){
				return false;
			}
    ///code added by shiv  sharma on 17-02-07  close             
            encryption(); 
			return true;
		  }

//function added by manoj chand on 17 dec 2012 to check for duplicate user.
			function checkDuplicateUser(){
				var var_dob= $("#dob").val();
				var var_firstname=$("#fname").val();
				var var_lastname=$("#lname").val();
				var flag;
				var urlParams = "strFlag=CheckDuplicateUser&dob="+var_dob+"&firstname="+var_firstname+"&lastname="+var_lastname;
				//alert(urlParams);
				$.ajax({
			           type: "post",
			           url: "AjaxMaster.jsp",
			           async: false,
			           data: urlParams,
			           success: function(result){
			           res = result.trim();
			           if(res!='N'){
				           var narr=res.split("##"); 
				           if(confirm('<%=dbLabelBean.getLabel("alert.registration.yourarealreadyregister",strsesLanguage)%> "'+narr[0]+'" <%=dbLabelBean.getLabel("alert.registration.unitas",strsesLanguage)%> "'+narr[1]+'" <%=dbLabelBean.getLabel("alert.registration.kindlyloginwithyourexisting",strsesLanguage)%>')){
					           flag=true;
				           }else{
					        	flag=false;   
				           }
			           }
				},
					error: function(){
						alert('<%=dbLabelBean.getLabel("label.global.jqueryerror",strsesLanguage)%>');
			           }
			         });
		        return flag;
				}

			String.prototype.trim = function() {
				return this.replace(/^\s+|\s+$/g,"");
			};
//end here
		  
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
			if(obj1=='middleName')
			{
				 obj = document.frm.middleName;
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
				 upToTwoHyphen(obj);
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
				 upToTwoHyphen(obj);
			}	

			if(obj1=='quest_secret')
			{
				 obj = document.frm.quest_secret;
				 upToTwoHyphen(obj);
			}	
			if(obj1=='ans_secret')
			{
				 obj = document.frm.ans_secret;
			}	
			if(obj1=='passport_No')
			{
				 obj = document.frm.passport_No;
				 upToTwoHyphen(obj);
			}
			if(obj1=='nationality')
			{
				 obj = document.frm.nationality;
				 upToTwoHyphen(obj);
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

			//Mukesh Mishra
			if(obj1=='passport_flight_No3')
			{
				 obj = document.frm.passport_flight_No3;
			}	
			if(obj1=='passport_flight_No4')
			{
				 obj = document.frm.passport_flight_No4;
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
				 upToTwoHyphen(obj);
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
			
			// Mukesh Mishra
			if(obj1=='airLineName3')
			{
				 obj = document.frm.airLineName3;
			}
			if(obj1=='airLineName4')
			{
				 obj = document.frm.airLineName4;
			}
			if(obj1=='hotelChain')
			{
				 obj = document.frm.hotelChain;
			}
			if(obj1=='hotelChain1')
			{
				 obj = document.frm.hotelChain1;
			}
			if(obj1=='hotelChain2')
			{
				 obj = document.frm.hotelChain2;
			}
			if(obj1=='hotelChain3')
			{
				 obj = document.frm.hotelChain3;
			}
			if(obj1=='hotelChain4')
			{
				 obj = document.frm.hotelChain4;
			}
			if(obj1=='hotelNumber')
			{
				 obj = document.frm.hotelNumber;
			}
			if(obj1=='hotelNumber1')
			{
				 obj = document.frm.hotelNumber1;
			}
			if(obj1=='hotelNumber2')
			{
				 obj = document.frm.hotelNumber2;
			}
			if(obj1=='hotelNumber3')
			{
				 obj = document.frm.hotelNumber3;
			}
			if(obj1=='hotelNumber4')
			{
				 obj = document.frm.hotelNumber4;
			}
			
			// addded new by shiv sharma 
			//winUserID domainname
			if(obj1=='identityProofno')
			{
				 obj = document.frm.identityProofno;
				 upToTwoHyphen(obj);
			}
			if(obj1=='winUserID')
			{
				 obj = document.frm.winUserID;
				 upToTwoHyphen(obj);
			}	

			if(obj1=='domainname')
			{
				 obj = document.frm.domainname;
				 upToTwoHyphen(obj);
			}	
			if(obj1=='passport_address')
			{
				 obj = document.frm.passport_address;
				 upToTwoHyphen(obj);
			}	

			if(obj1=='current_address')
			{
				 obj = document.frm.current_address;
				 upToTwoHyphen(obj);
			}	
			//var obj11 = document.frm.obj1.value;
			//alert(""+obj11);
			charactercheck(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj); //function for checking leading zero and spaces
			spaceChecking(obj);
		}
		
		function report_to(filename,k)
		{
			reportto = showModalDialog(filename+"&site_id="+document.frm.reportto[k].value+"&i="+k,"Win","scrollbars=yes,resizable=no,menubar=no,width=350,height=350");
			if(reportto==null)
			{	document.frm.report.value="";
			}
			else
			{	document.frm.report.value=reportto.flag;
				document.frm.repToUserId.value=reportto.userid;
			}
		}
		
		function dept_Head(filename,k)
		{
			deptHead = showModalDialog(filename+"&site_id="+document.frm.reportto[k].value+"&selectHod=Y"+"&i="+k,"Win","scrollbars=yes,resizable=no,menubar=no,width=350,height=350");
			if(deptHead==null)
			{	document.frm.deptHead.value="";
			}
			else
			{	document.frm.deptHead.value=deptHead.flag;
				document.frm.deptHeadUserId.value=deptHead.userid;
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
		 
		 var inputTxtBox = "";
         
		 // added  on 07-Jun-07  by  shiv   
		 function button_onclick(obj) 
	     { 
			 inputTxtBox = obj;
		  popUpCalendar(obj,obj,"dd/mm/yyyy");
		 }

		 jQuery(function($) {
				$("#targetDiv").scroll(function() {
					if ($('#calendar').css('visibility') == 'visible')
					{   
						var txtBoxPosition = "";
						var txtBoxTop = "";
						var txtBoxLeft = "";
						
						var txtBoxName = inputTxtBox.name;	
						var txtBox =  $("input[name="+txtBoxName+"]");
						
						txtBoxPosition = txtBox.position();							
						txtBoxTop = txtBoxPosition.top;
						txtBoxLeft = txtBoxPosition.left;						
						$("#calendar").css({'top': txtBoxTop+19, 'left': txtBoxLeft, 'position':'absolute'});
						
						isOnView = isElementVisible("input[name="+txtBoxName+"]");
					       if(isOnView){
					    	   $("#calendar").css({'visibility':'hidden'});
					    	   $('body').css('overflow','hidden')
					       }else{ 
					    	   $("#calendar").css({'visibility':'visible'});
					       }
					}					
				});
				
				$("input[name=passport_DOB]").focus(function(){
					var y = $("#targetDiv").scrollTop();
					$("#targetDiv").scrollTop(y+152);
				});
				
				$("input[name=passport_issue_date]").focus(function(){
					var y = $("#targetDiv").scrollTop();
					$("#targetDiv").scrollTop(y+152);
				});
				
				$("input[name=passport_expire_date]").focus(function(){
					var y = $("#targetDiv").scrollTop();
					$("#targetDiv").scrollTop(y+152);
				});
				
				$("select[name=quest_secret1]").focus(function(){
					var y = $("#targetDiv").scrollTop();
					$("#targetDiv").scrollTop(y+152);
				});
				
				$("a#dobCal").click(function(){
					var y = $("#targetDiv").scrollTop();
					$("#targetDiv").scrollTop(y+152);
				});
				
				$("a#passportCalIss").click(function(){
					var y = $("#targetDiv").scrollTop();
					$("#targetDiv").scrollTop(y+152);
				});
				
				$("a#passportCalExp").click(function(){
					var y = $("#targetDiv").scrollTop();
					$("#targetDiv").scrollTop(y+152);					
				});					
				
				function isElementVisible(elementToBeChecked)
				{
				    var TopView = $("#targetDiv").scrollTop();
				    var BotView = TopView + $("#targetDiv").height();
				    var TopElement = $(elementToBeChecked).offset().top;
				    var BotElement = TopElement + $(elementToBeChecked).height();
				    return ((BotElement <= BotView) && (TopElement >= TopView));
				}				
			});

		</script>
	</head>

<!-- Start of body -->
	<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="10">
      <tr>
        <td width="77%" class="bodyline-top"><ul class="pagebullet">
            <li class="pageHead"><%=dbLabelBean.getLabel("label.register.newuserregistrationform",strsesLanguage)%></li>
        </ul></td>
      </tr>
    </table>

	<table width="100%" border="0" cellspacing="0" cellpadding="10">
    </table><form name="frm" method="post" action = "RegisterUser">
      <table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
    <tr align="left">
      <td  colspan="4" class="selectedmenubg"><ul class="pagebullet">
        <% if (strFlag == null){ %>
          <Font color='red'><li class="pageHead"><%=dbLabelBean.getLabel("label.register.registeryourself",strsesLanguage)%> </li></Font>
        <% } else {%>
        </ul>
        <% if (strFlag.equals("redundantEmail")){ %>
          <li class="pageHead"><Font color='red'><%=dbLabelBean.getLabel("label.register.userwithsameemailidexists",strsesLanguage)%></Font> </li>
        <% } %>
		<% if (strFlag.equals("redundantUserName")){ %>
          <li class="pageHead"><Font color='red'><%=dbLabelBean.getLabel("label.register.userwithsameusernameexists",strsesLanguage)%></Font></li>
        <% } %>
		<% if (strFlag.equals("redundantEmpcode")){ %>
          <li class="pageHead"><Font color='red'><%=dbLabelBean.getLabel("label.register.userwithsameemployeecodeexists",strsesLanguage)%></Font></li>
        <% } %>
        <% if (strFlag.equals("new")){ %>
          <li class="pageHead"><%=dbLabelBean.getLabel("label.register.registeruser",strsesLanguage)%> </li>
        <% } %>
          <% if (strFlag.equals("failure")){ %>
          <li class="pageHead"><Font color='red'><%=dbLabelBean.getLabel("label.register.erroroccuredkindlycontact",strsesLanguage)%></Font> </li>
        <% } %>
          <% } %> </td>	

    <td width="7%" class="selectedmenubg" align="center"><span class="formTit" style="text-align:right"><img src="images/help.gif?buildstamp=2_0_0" width="44" height="16" border="0" onClick="MM_openBrWin('help.html','','scrollbars=yes,resizable=yes,width=700,height=300')"></td>
    </tr>
    </table>
    
    <div style="text-align: center; clear: both;">
	<div id="targetDiv" style="margin:0 auto; width:95%; height:275px; overflow-y:scroll; vertical-align: top;">
    <table width="100%" align="center" border="0" cellpadding="2" cellspacing="1" class="formborder" id="divTable"> 
    <tr align="left">
      <td colspan="4" class="dataLabel"><%=dbLabelBean.getLabel("label.register.createyouruserid",strsesLanguage)%></td>
    </tr>
    <tr align="left">
      <td colspan="4" class="formtr1"><%=dbLabelBean.getLabel("label.global.fieldsmarkedwithanasterisk",strsesLanguage)%><font color="#FF3300"> (*) </font><%=dbLabelBean.getLabel("label.global.aremandatory",strsesLanguage)%></td>
    </tr>
    <tr align="left">
      <td width="180" class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.global.firstname",strsesLanguage)%></td>
      <td width="420" class="formtr1"><input type="text" name="firstName" id="fname" size="25" onKeyUp="return test1('firstName', 29, 'c')" maxlength="30" class="textBoxCss" /> <%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%></td>  
      <script language="javascript">
			document.frm.firstName.value ="<%=txtFirstName%>";
			</script>
      <td width="180" class="formtr1"><font size="" color="#FF3300"></font>&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.middlename",strsesLanguage)%> </td> 
      <td width="420" class="formtr1"><input type="text" name="middleName" size="25" onKeyUp="return test1('middleName', 29, 'c')" maxlength="30" class="textBoxCss" />
       <%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%></td>
      <script language="javascript">
			document.frm.middleName.value ="<%=txtmiddleName%>";	
			</script> 
    </tr>
    
      <tr align="left">
     
      <td width="180" class="formtr1">
	<% 		if(strTravelAgencyCode.equals("2")) { %>				   		
		   		<FONT SIZE="" COLOR="#FF3300">* </FONT>
	<% 		} else { %>
				&nbsp;&nbsp;&nbsp;
	<%		} %>	
		<%=dbLabelBean.getLabel("label.global.lastname",strsesLanguage)%> </td>
      <td width="420" class="formtr1"><input type="text" name="lastName" id="lname" size="25" onKeyUp="return test1('lastName', 29, 'c')" maxlength="30" class="textBoxCss" />
       <%=dbLabelBean.getLabel("label.mylinks.asperpassport",strsesLanguage)%></td>
      <script language="javascript">
			document.frm.lastName.value ="<%=txtLastName%>";
			</script>
	<td width="180" class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></td>		
	<td width="420" class="formtr1">
	
	<select name="gender" class="textBoxCss">
				<option value="-1"><%=dbLabelBean.getLabel("label.global.gender",strsesLanguage)%></option>
				<option value="Male"><%=dbLabelBean.getLabel("label.global.male",strsesLanguage)%></option>
				<option value="Female"><%=dbLabelBean.getLabel("label.global.female",strsesLanguage)%></option>
			</select>
			<script>
				document.frm.gender.value="<%=gender%>";
	 
			 </script>
	
	
	</td>		
    </tr>
	 <tr align="left">
      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mail.username",strsesLanguage)%> </td>
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
	  
      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.email",strsesLanguage)%></td>
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
      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.login.password",strsesLanguage)%></td>
      <td class="formtr1"><input type="password" name="password" size="15" onKeyUp="return test1('password', 15, 'pwd')" maxlength="15" class="textBoxCss" /><br><font size='1' color='red'><%=dbLabelBean.getLabel("label.register.minimum8characterrequired",strsesLanguage)%></font></td>
      <script language="javascript">
			//Bug related to mismatch in password  by Gaurav Aggarwal on 22-Jun-2007
			//document.frm.password.value ="<%=txtCnfmPassword%>";
			document.frm.password.value ="<%=txtPassword%>";
			// @Gaurav End of code
			
			</script>

      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.register.conformpassword",strsesLanguage)%> </td>
      <td class="formtr1"><input type="password" name="cnfmPassword" size="15" onKeyUp="return test1('cnfmPassword', 15, 'pwd')" maxlength="15" class="textBoxCss" /><br><font size='1' color='red'><%=dbLabelBean.getLabel("label.register.minimum8characterrequired",strsesLanguage)%></font></td>
      <script language="javascript">
			document.frm.cnfmPassword.value ="<%=txtCnfmPassword%>";
			</script>
    </tr>
   <!-- @ Vijay Singh changes on 20/04/2007 for Adding the gender-->
	<tr align="left">
	  <td class="formtr1" colspan='2'><font size='1' color='red'> </font>
	  </td>
	  <td  class="formtr1"> </td>
	 
	  <td class="formtr1">
			
	</td>
	
	</tr>
   <!--End Modification-->
      
    <tr align="left">
      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.requestdetails.unit",strsesLanguage)%></td>
      <td class="formtr1">
	    <select name="site" class="textBoxCss" onChange="getDivisonID()">
		<option value="-1"><%=dbLabelBean.getLabel("label.createrequest.selectunit",strsesLanguage)%> </option>
<% 
//////--------------------change done by shiv on 20/04/2007 open------------------------------------------s
//New Check for local administrator  
		if((SuserRole.trim().equals("AD")))
		{
		 strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE  APPLICATION_ID=1 AND STATUS_ID = 10 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='') ORDER BY SITE_NAME";	
		  rs = bean.executeQuery(strSql); 
		}
		else
		{
                strSql="SELECT  SITE_ID FROM M_USERROLE  WHERE STATUS_ID=10 AND USERID="+Suser_id+" order by 1";
			    rs = bean.executeQuery(strSql);    
				if(!rs.next())
				{
						strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE SITE_ID="+strSiteIdSS+" AND  APPLICATION_ID=1 AND STATUS_ID = 10 AND (M_SITE.CLOSED_UNIT_FLAG is null or M_SITE.CLOSED_UNIT_FLAG='')  ORDER BY SITE_NAME";
						 rs = bean.executeQuery(strSql); 
				}
				else
			    {

						strSql="SELECT  M_USERROLE.SITE_ID,dbo.SITENAME(M_USERROLE.SITE_ID) FROM  M_USERROLE LEFT JOIN M_SITE MS ON M_USERROLE.SITE_ID=MS.SITE_ID  WHERE M_USERROLE.STATUS_ID=10 AND USERID="+Suser_id+" AND (MS.CLOSED_UNIT_FLAG is null or MS.CLOSED_UNIT_FLAG='') ORDER BY 1";
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
      <td class="formtr1"><font size="" color="#FF3300">* </font>
	<%	if(strTravelAgencyCode.equals("2")) { %>
		<%=dbLabelBean.getLabel("label.createrequest.costcentre",strsesLanguage)%>
		
	<%	} else { %>
		<%=dbLabelBean.getLabel("label.requestdetails.department",strsesLanguage)%>
		
	<% 	} %>
	  </td>
      <td class="formtr1">
	    <select name="department" class="textBoxCss">
<% 
		String query = "SELECT DEPT_ID,DEPT_NAME from M_DEPARTMENT WHERE SITE_ID ="+Site_ID+" AND APPLICATION_ID=1 AND STATUS_ID = 10 AND DIV_ID=(select DIV_ID from M_SITE where site_id="+Site_ID+" AND STATUS_ID=10 AND APPLICATION_ID=1 )ORDER BY DEPT_NAME";
//		System.out.println("himanshu--->> "+query);
		rs = bean.executeQuery(query); 

        if(strTravelAgencyCode.equals("2")) { 
%>			<option value="-1" selected><%=dbLabelBean.getLabel("label.createrequest.selectcostcentre",strsesLanguage)%></option>
<%		} else { %>
			<option value="-1" selected><%=dbLabelBean.getLabel("label.mylinks.selectdepartment",strsesLanguage)%></option>
<%	 	}
		while(rs.next()) 
		{ 
%>          <option value = <%=rs.getString(1)%> > <%= rs.getString(2) %></option>
<%		}
		rs.close();
%>      </select></td>
	    <script language="javascript">
			document.frm.department.value ="<%=Dept_ID%>";
		</script>
    </tr>
    <tr align="left">
      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.global.designation",strsesLanguage)%> </td>
      <td class="formtr1">
	    <select name="designation" class="textBoxCss">
<% 
 		rs = bean.executeQuery("SELECT DESIG_ID,DESIG_NAME  FROM M_DESIGNATION where site_id="+Site_ID+" AND APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY DESIG_NAME"); 
%>
          <option value="-1"> <%=dbLabelBean.getLabel("label.global.selectyourdesignation",strsesLanguage)%> </option>
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
      
      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.employeecode",strsesLanguage)%></td><!-- 2/28/2007 -->            
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
	<!-- adding identity proof open 10/18/2007 -->
	 <tr align="left">
      <td class="formtr1">&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.global.proofofidentity",strsesLanguage)%> </td>
      <td class="formtr1"><select name="identityProof" class="textBoxCss">
										   <option value="-1"> <%=dbLabelBean.getLabel("label.createrequest.proofofidentity",strsesLanguage)%></option>
							<%	
								query = "SELECT IDENTITY_ID, IDENTITY_NAME FROM m_IDENTITY_PROOF WHERE STATUS_ID=10 ORDER BY ORDER_ID";
									rs = bean.executeQuery(query); 
							%>
									 
							<%
									while(rs.next()) 
									{ 
							%>
									  <option value = <%=rs.getString(1)%> > <%= rs.getString(2) %></option>
							<%
									}
									rs.close();
							%>
        </select>	 </td>
		<script language="javascript">
			document.frm.identityProof.value ="<%=strIdentityProof%>";
			</script>
	 
      
      <td class="formtr1">&nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.identityproofnumber",strsesLanguage)%> </td>          
	  <td class="formtr1">
	  <input type='text' name='identityProofno' onKeyUp="return test1('identityProofno', 30, 'All')" value="<%=strIdentityProofNo%>"  class="textBoxCss"/></td>
   </tr>
	<!--adding identity proof close   10/18/2007-->


	<!-- adding window user id and domain name on 2/3/2009 by shiv sharma  -->
	   <tr>
<!--10/18/2007 by shiv  open-->
<td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.windowsuserid",strsesLanguage)%></td>
<td width="420" class="formtr1">
	<input type='text' name='winUserID' value="<%=strWindowsUserId%>"  class="textBoxCss" onKeyUp="return test1('winUserID', 30, 'All')"/></td> 

		<script language="javascript">
	 					document.frm.winUserID.value="<%=strWindowsUserId%>"; 
	    </script>    

 
 <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.networkdomainname",strsesLanguage)%></td>
		  <td class="formtr1">
				<input type='text' name='domainname' value="<%=strNetworkDomainName%>"  class="textBoxCss" onKeyUp="return test1('domainname', 30, 'All')" /></td>

		<script language="javascript">
	 					document.frm.domainname.value="<%=strNetworkDomainName%>";
	    </script>
 	
   <!--End Modification-->


</tr>


    <tr align="center">
      <td colspan="4" align="left" style="font-size: 15px;"><font color="#FF3300">* </font><span class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.selectthepersonreportto",strsesLanguage)%>(<%=dbLabelBean.getLabel("label.global.approverlevel1",strsesLanguage)%>)</span></td>
    </tr>
    <tr align="center">
      <% for(int i=0;i<=1;i++) { %>
      <td class="formtr1"><input type="radio" value=<%=Site_ID%> name="reportto" onClick="report_to('report_to_container.jsp?lang=<%=strsesLanguage %>','<%=i%>');">
          <%=arrayRadio[i]%></td>
      <% } %>
      <td class="formtr1"><input name="report" type="text" class="textBoxCss" size="34" maxlength="25" readonly >
    <td class="formtr1">    </tr>
    
      <!-- Section to Select HOD is added on 17/8/2015 by Sandeep Malik -->
    <tr align="center">
      <td colspan="4" align="left" style="font-size: 15px;"><font color="#FF3300">* </font><span class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.selectthepersondepthead",strsesLanguage)%>(<%=dbLabelBean.getLabel("label.global.approverlevel2",strsesLanguage)%>)</span></td>
    </tr>
    <tr align="center">
      <% for(int i=0;i<=1;i++) { %>
      <td class="formtr1"><input type="radio" value=<%=Site_ID%> name="deptHeadId" onClick="dept_Head('report_to_container.jsp?lang=<%=strsesLanguage %>','<%=i%>');">
          <%=arrayRadio[i]%></td>
      <% } %>
      <td class="formtr1"><input name="deptHead" type="text" class="textBoxCss" size="34" maxlength="25" readonly >
    <td class="formtr1">    </tr>
     <!-- Section to Select HOD is Ended -->
    
    <tr align="center">
      <td colspan="4" align="left" class="dataLabel"><%=dbLabelBean.getLabel("label.mylinks.ifyouforgetyourpassword",strsesLanguage)%></td>
    </tr>
   	  <tr align="center">
      <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.secretquestion",strsesLanguage)%> </td>
	  <!--@ Vijay Singh 11/04/2007 add the option for secret question -->
      <td class="formtr1">
			<select name="quest_secret1" class="textBoxCss" onChange="questOther();">
				<option value="-1"><%=dbLabelBean.getLabel("label.mylinks.selectyourquestion",strsesLanguage)%></option>
				<option value="Your college Name"><%=dbLabelBean.getLabel("label.mylinks.collegename",strsesLanguage)%></option>
				<option value="Your Mothers Maiden Name"><%=dbLabelBean.getLabel("label.mylinks.mothersmaidenname",strsesLanguage)%></option>
				<option value="Your Native Place"><%=dbLabelBean.getLabel("label.mylinks.nativeplace",strsesLanguage)%></option>
				<option value="Your Pet Name"><%=dbLabelBean.getLabel("label.mylinks.petname",strsesLanguage)%></option>
				<option value="Others"><%=dbLabelBean.getLabel("label.mylinks.others",strsesLanguage)%></option>
			</select>
			 <script language="javascript">
			document.frm.quest_secret1.value ="<%= strSecretQuestion %>";
	</script>
	</td>
	   <!--@ END MODIFICATION-->
	<td class="formtr1">
	  <input type="text" name="quest_secret" size="34" onKeyUp="return test1('quest_secret', 100, 'all')" maxlength="100" class="textBoxCss" disabled/>
	</td>
					<td class="formtr1">
					</td>
	</tr>
      <script language="javascript">
			document.frm.quest_secret.value ="<%= strQuestionSecret %>";
	</script>
    <tr>
	  <td class="formtr1"><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.secretanswer",strsesLanguage)%> </td>
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
      <td colspan="4" align="left" class="formtr1"><span style="font-family:Arial; font-size:8.5pt; color:black; "><%=dbLabelBean.getLabel("label.mylinks.providecomplexanswer",strsesLanguage)%></span></td>
    </tr>
    <tr align="center">
      <td colspan="4" align="left" class="dataLabel"><%=dbLabelBean.getLabel("label.register.feedyourpassportdetails",strsesLanguage)%></td>
    </tr>
    <tr align="center">
      <td width="180" class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.passportnumber",strsesLanguage)%></td>
      <td width="420" class="formtr1"><input type="text" name="passport_No" size="25" onKeyUp="return test1('passport_No', 49, 'all')" maxlength="10" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.passport_No.value ="<%= passport_No %>";
			</script>
      <td width="180" class="formtr1"><%=dbLabelBean.getLabel("label.user.nationality",strsesLanguage)%></td>
      <td width="420" class="formtr1"><input type="text" name="nationality" size="25" onKeyUp="return test1('nationality', 50, 'all')" maxlength="50" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.nationality.value ="<%= nationality %>";
	  </script>
    </tr>
    
    <tr align="left">
      <td class="formtr1"><%=dbLabelBean.getLabel("label.visa.passportissuingcountry",strsesLanguage)%></td>
	  <td class="formtr1">
	  	<select name="pp_issu_Country" id="pp_issu_Country" class="textBoxCss" style="width: 173px;">
	  		<option value="0"><%=dbLabelBean.getLabel("label.createrequest.visacountry",strsesLanguage)%></option>
	<%		rs = dbConBean.executeQuery("SELECT COUNTRY_ID, COUNTRY_CODE, COUNTRY_NAME FROM M_COUNTRY WHERE STATUS_ID=10 AND APPLICATION_ID=1 ORDER BY COUNTRY_NAME");  
		    while(rs.next()) {
	%>		<option value="<%=rs.getString("COUNTRY_ID")%>"><%=rs.getString("COUNTRY_NAME")%></option>
	<% 		}
    		rs.close();	
	%>  </select>
		<script language="javascript">
      		document.frm.pp_issu_Country.value="<%=passportIssuCountry%>";
		</script>
	  </td>
      
      <td class="formtr1"> <%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%> </td>
      <td class="formtr1"><input type="text" name="passport_issue_place" size="34" style="width: 171px;" onKeyUp="return test1('passport_issue_place', 99, 'c')" maxlength="25" class="textBoxCss" /></td>
	  <script language="javascript">
			document.frm.passport_issue_place.value ="<%= passport_issuePlace %>";
	  </script>
    </tr>
    
    <tr align="left">
       <td class="formtr1"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%> <%=dbLabelBean.getLabel("label.mylinks.ddmmyyyy",strsesLanguage)%></td>
       <td class="formtr1"><input type="text" name="passport_issue_date" size="10" maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
		<a id="passportCalIss" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"  onclick="button_onclick(document.frm.passport_issue_date);">
       	 <IMG   height=14 alt="<%=dbLabelBean.getLabel("label.register.calender",strsesLanguage)%>" src="images/calender.png?buildstamp=2_0_0"   width=17></a>
       	 <script language="javascript">
			document.frm.passport_issue_date.value ="<%= passport_issue %>";
			</script>
       	</td>
      
      <td class="formtr1"><%=dbLabelBean.getLabel("label.global.expirydate",strsesLanguage)%> &nbsp;&nbsp;<%=dbLabelBean.getLabel("label.mylinks.ddmmyyyy",strsesLanguage)%> </td>
      <td class="formtr1"><input type="text" name="passport_expire_date" size="10" maxlength="50" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
         <a id="passportCalExp" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;" onclick="button_onclick(document.frm.passport_expire_date);">
		  <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17></a>
		  <script language="javascript">
		  	document.frm.passport_expire_date.value ="<%= passport_expire %>";
		   </script>
	  </td>      
    </tr>
    
    <tr align="left">
      <td class="formtr1"><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%><font size="" color="#FF3300">* </font><%=dbLabelBean.getLabel("label.mylinks.ddmmyyyy",strsesLanguage)%></td>
      <td class="formtr1"><input type="text" name="passport_DOB" id="dob" size="10" maxlength="50" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
         <a  id="dobCal" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;" onclick="button_onclick(document.frm.passport_DOB);">
 		 <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17></a>
 	  </td>
      <script language="javascript">
			document.frm.passport_DOB.value ="<%= passport_DOB %>";
	  </script>
      
      <td class="formtr1"> <%=dbLabelBean.getLabel("label.global.contactno",strsesLanguage)%></td>
      <td class="formtr1"><input type="text" name="passport_Contact_No" size="20" onKeyUp="return test1('passport_Contact_No', 19, 'phone')" maxlength="19" class="textBoxCss" /></td>
      <script language="javascript">
			document.frm.passport_Contact_No.value ="<%= passport_contactNo %>";
	  </script>
    </tr>
    
    <tr align="left">
      <td class="formtr1"><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%></td>
      <td class="formtr1" colspan="3"> 
  	    <input name="passport_ECNR" type="radio" value="1" /><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%> 
        <input name="passport_ECNR" type="radio" checked = "checked"  value="2"/><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%>
        <input name="passport_ECNR" type="radio" value="3"/><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%>
      </td>
        <script language="javascript">
			document.frm.passport_ECNR.value ="<%= passport_ECNR %>";
			if (document.frm.passport_ECNR.value == 1) {
				document.frm.passport_ECNR[0].checked = true;
			} else if (document.frm.passport_ECNR.value == 2) {
				document.frm.passport_ECNR[1].checked = true;		
		    } else if (document.frm.passport_ECNR.value == 3) {
				document.frm.passport_ECNR[2].checked = true;		
		    }
		</script>
    </tr>
    
    <tr align="left">      
      <td class="formtr1"><%=dbLabelBean.getLabel("label.register.frequentflyernumber",strsesLanguage)%></td>
      <td class="formtr1">
      	<table width="258" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.createrequest.airlinenames",strsesLanguage)%></span></td>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.createrequest.airlinenumber",strsesLanguage)%></span></td>
	        </tr>
	        <tr>
	  		  	<td width="128" align="center" class="formtr1"><input type="text" name="airLineName" size="15"  onKeyUp="return test1('airLineName', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td width="130" align="center" class="formtr1"><input type="text" name="passport_flight_No" size="20"  onKeyUp="return test1('passport_flight_No', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input type="text" name="airLineName1" size="15"  onKeyUp="return test1('airLineName1', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="passport_flight_No1" size="20"  onKeyUp="return test1('passport_flight_No1', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input type="text" name="airLineName2" size="15"  onKeyUp="return test1('airLineName2', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="passport_flight_No2" size="20"  onKeyUp="return test1('passport_flight_No2', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input type="text" name="airLineName3" size="15"  onKeyUp="return test1('airLineName3', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="passport_flight_No3" size="20"  onKeyUp="return test1('passport_flight_No3', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	  		  	<td align="center" class="formtr1"><input type="text" name="airLineName4" size="15"  onKeyUp="return test1('airLineName4', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="passport_flight_No4" size="20"  onKeyUp="return test1('passport_flight_No4', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
	     </table>
	     <script language="javascript">
			document.frm.airLineName.value ="<%= strAirLineName %>";
			document.frm.airLineName1.value ="<%= strAirLineName1 %>";
			document.frm.airLineName2.value ="<%= strAirLineName2 %>";
			document.frm.airLineName3.value ="<%= strAirLineName3 %>";
			document.frm.airLineName4.value ="<%= strAirLineName4 %>";
			
			document.frm.passport_flight_No.value ="<%= passport_FNo %>";
			document.frm.passport_flight_No1.value ="<%= passport_FNo1 %>";
			document.frm.passport_flight_No2.value ="<%= passport_FNo2 %>";
			document.frm.passport_flight_No3.value ="<%= passport_FNo3 %>";
			document.frm.passport_flight_No4.value ="<%= passport_FNo4 %>";
		</script>
      </td>
      
      <td class="formtr1"><%=dbLabelBean.getLabel("label.global.hotelrewardcard",strsesLanguage)%></td>
      <td class="formtr1">
      	<table width="258" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.global.hotelchain",strsesLanguage)%></span></td>
	          	<td align="left" valign="bottom" class="formtr1"><span class="label2">&nbsp;<%=dbLabelBean.getLabel("label.requestdetails.number",strsesLanguage)%></span></td>
	        </tr>
	        <tr>
	          	<td width="128" align="center" class="formtr1"><input type="text" name="hotelChain" size="15"  onKeyUp="return test1('hotelChain', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td width="130" align="center" class="formtr1"><input type="text" name="hotelNumber" size="20"  onKeyUp="return test1('hotelNumber', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	          	<td align="center" class="formtr1"><input type="text" name="hotelChain1" size="15"  onKeyUp="return test1('hotelChain1', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="hotelNumber1" size="20"  onKeyUp="return test1('hotelNumber1', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	          	<td align="center" class="formtr1"><input type="text" name="hotelChain2" size="15"  onKeyUp="return test1('hotelChain2', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="hotelNumber2" size="20"  onKeyUp="return test1('hotelNumber2', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	          	<td align="center" class="formtr1"><input type="text" name="hotelChain3" size="15"  onKeyUp="return test1('hotelChain3', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="hotelNumber3" size="20"  onKeyUp="return test1('hotelNumber3', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
			<tr>
	          	<td align="center" class="formtr1"><input type="text" name="hotelChain4" size="15"  onKeyUp="return test1('hotelChain4', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
	          	<td align="center" class="formtr1"><input type="text" name="hotelNumber4" size="20"  onKeyUp="return test1('hotelNumber4', 20, 'cn')" maxlength="20" class="textBoxCss" /></td>
			</tr>
	     </table>
	        <script language="javascript">
			document.frm.hotelChain.value ="<%= hotelChain %>";
			document.frm.hotelChain1.value ="<%= hotelChain1 %>";
			document.frm.hotelChain2.value ="<%= hotelChain2 %>";
			document.frm.hotelChain3.value ="<%= hotelChain3 %>";
			document.frm.hotelChain4.value ="<%= hotelChain4 %>";
			
			document.frm.hotelNumber.value ="<%= hotelNumber %>";
			document.frm.hotelNumber1.value ="<%= hotelNumber1 %>";
			document.frm.hotelNumber2.value ="<%= hotelNumber2 %>";
			document.frm.hotelNumber3.value ="<%= hotelNumber3 %>";
			document.frm.hotelNumber4.value ="<%= hotelNumber4 %>";
		</script>
      </td>
    </tr>
    
    <%
	if(!strTravelAgencyCode.equals("2")) {
	%>
    <tr align="left">
      <td class="formtr1"> <%=dbLabelBean.getLabel("label.createrequest.permanentaddress",strsesLanguage)%></td>
      <td class="formtr1"><span class="label2">
        <textarea name="passport_address" rows="5" cols="30" id="passport_address" onKeyUp="return test1('passport_address', 149, 'all')"></textarea>
      </span></td>
      <script language="javascript">
			document.frm.passport_address.value ="<%= passport_Address %>";
			</script>
      <td class="formtr1"><%=dbLabelBean.getLabel("label.createrequest.currentaddress",strsesLanguage)%></td>
      <td class="formtr1"><span class="label2">
        <textarea name="current_address" rows="5" cols="30" id="textarea" onKeyUp="return test1('current_address', 149, 'all')"></textarea>
         </span>
	  </td>
	  <script language="javascript">
			document.frm.current_address.value ="<%= strCurrentAddress %>";
	  </script>
    </tr>
    <%} %>
    </table> 	        
	</div>
	</div>
    
   <div style="position: relative;">
    <table width="95%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder" style="position: relative; background-color: #d4d0c8;">
    <tr align="center">
      	<td colspan="4" class="formBottom">
      		<input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.register.register",strsesLanguage)%>" class="formButton" onClick="return checkData(this.form)">
          	<input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%> " class="formButton"  >
          	<input type="button" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.close",strsesLanguage)%> "class="formButton"  onClick="MM_closeBrWindow('<%=strCloseFlag%>')">      
        </td>
	<tr>
     <input type="hidden" name="status_id" value="10" >  <!--  HIDDEN FIELD  -->
     <input type="hidden" name="repToUserId" >      <!--  HIDDEN FIELD  -->
     <input type="hidden" name="deptHeadUserId" >      <!--  HIDDEN FIELD  -->
     <input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/>      <!--  HIDDEN FIELD  -->
     <input type="hidden" name="closeFlag" value="<%=strCloseFlag%>"/>      <!--  HIDDEN FIELD  -->
	 <input type="hidden" name="question_other" value="" ><!-- Add by Vijay on 14/04/2007  for other secret question-->
	 <input type="hidden" name="langselected" value="<%= strsesLanguage %>" >
    </tr>
	</table>
	</div>
</form>
	<!-- End of Form  -->
	</body>
</html>