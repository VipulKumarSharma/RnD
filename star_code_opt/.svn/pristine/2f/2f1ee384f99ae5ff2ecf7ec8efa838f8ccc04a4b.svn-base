	
<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:24 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for updating the M_USERINFO in the STAR Database
 *Modification 			: empcode char & numeric
								  2.Change the query for display the user info in edit form
								  3.Add the  secret question combobox  and answer field
								  4.SELECT THE APPROPRIATE QUESTION IN COMBOBOX
								  5.Add the  gender field .
								  6. code added for updating the user those are in deactivated user List,  by shiv sharma on 23-May-07
								  7. status_id  is removed  for showing "report to person" for deactivted user. by shiv on 24-May-07. 
								  8 change the calender icon(converted it to drop down selection for date)  by  shiv  on 07-Jun-07.    
 *Reason of Modification: 
 *Date of Modification  : 19/03/2007, 20/03/2007 by Shiv Sharma,09/04/2007
									  11/04/2007,
									  14/04/2007
									  17/04/2007
									  20/04/2007

 *Modified By			: 1.Vijay Singh
								  2.Vijay Singh
								  3.VIJAY SINGH
								  4.Vijay Singh
								  5.Vijay Singh
 *Revision History		:Last name is not mendatory 
 *Editor				:Editplus
 *******************************************************/
%>
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
<jsp:useBean id="dbUtility" scope="page" class="src.connection.DbUtilityMethods" />
<SCRIPT language="JavaScript" src="ScriptLibrary/popcalendar.js?buildstamp=2_0_0"></SCRIPT>  <!-- added by shiv on 07-Jun-07 -->
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="LocalScript/M_UpdateProfile.js?buildstamp=2_0_0"></SCRIPT>
 <link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" /><BASE>


<%
// Global Variables declared and initialized

String strSql                   =  null;              // String for Sql String
ResultSet rs,rs1,rs2            =  null;              // Object for ResultSet
String FIRSTNAME                =  "";
String LASTNAME                 =  "";
/// 

String EMP_CODE                =  "";
////
String PIN                      =  "";
String EMAIL                    =  "";
String SITE_ID                  =  "";
String DIV_ID                   =  "";
String DEPT_ID                  =  "";
String DESIG_ID                 =  "";
String REPORT_TO                =  "";
String SECRET_QUESTION          =  "";
String SECRET_ANSWER            =  "";
String PASSPORT_NO              =  "";
String DATE_ISSUE               =  "";
String ECNR                     =  "";
String EXPIRY_DATE              =  "";
String FF_NUMBER                =  "";
String FF_NUMBER1                =  "";
String FF_NUMBER2                =  "";


//new 16-02-2007
String strCurrentAddress	=	"";
String strAirLineName		=	"";
String strAirLineName1		=	"";
String strAirLineName2		=	"";
String SECRET_ANSWER_decrypt="";
//



String PLACE_ISSUE              =  "";
String DOB                      =  "";
String ADDRESS                  =  "";
String CONTACT_NUMBER           =  "";
String strMessage               =  "";
String[] arrayRadio 			= {"Unit ID","Across the Unit"};


String strEmailIDAccess         =	"readOnly";
String strGender					=	""; //add by vijay on 20/04/2007


//added  new code on 23-May-07 open  
String strDeactiveflag="";
strDeactiveflag= request.getParameter("Deactiveflag"); 
//added  new code on 23-May-07 open 

if((SuserRoleOther.trim().equals("LA")) || (SuserRole.trim().equals("AD")))
{
	strEmailIDAccess  =  "";
}


strMessage          =  (request.getParameter("strMessage")==null || request.getParameter("strMessage")=="")?"Update                       Profile":request.getParameter("strMessage"); 


String strDivNameId	= (request.getParameter("division")==null ||                                                                         request.getParameter("division")=="")?"-1":request.getParameter("division");

String	strSiteNameId		=  (request.getParameter("site")==null || request.getParameter("site")=="")?"-1":request.getParameter("site");

String		strDeptNameId		=  (request.getParameter("department")==null || request.getParameter("department")=="")?"-1":request.getParameter("department");

String		strDesigNameId		=  (request.getParameter("designation")==null || request.getParameter("designation")=="")?"-1":request.getParameter("designation");

String      changeCombo         =  (request.getParameter("changeCombo")==null || request.getParameter("changeCombo")=="")?"no":request.getParameter("changeCombo");


String strUserId                =  request.getParameter("userId");  // get the user id if admin update the profile 
if(strUserId == null)
{
   strUserId = Suser_id;    // Suser_id is login person userid
}
        
    //sql for getting the information for display from M_UserInfo Table
	//@ Vijay Singh 09/04/2007 changes in database query
	// change database query to select the gender
    strSql="SELECT FIRSTNAME,LASTNAME,PIN,LTRIM(RTRIM(EMAIL)) AS EMAIL,SITE_ID,DIV_ID,DEPT_ID,DESIG_ID,ISNULL(REPORT_TO,'') AS REPORT_TO,ISNULL(SECRET_QUESTION,'') AS SECRET_QUESTION,ISNULL(SECRET_ANSWER,'') AS SECRET_ANSWER,ISNULL(PASSPORT_NO,'') AS PASSPORT_NO,ISNULL(.DBO.CONVERTDATEDMY1(DATE_ISSUE),'') AS DATE_ISSUE,ISNULL(ECNR,'') AS ECNR,ISNULL(.DBO.CONVERTDATEDMY1(EXPIRY_DATE),'') AS EXPIRY_DATE, ISNULL(FF_NUMBER,'') AS FF_NUMBER,ISNULL(FF_NUMBER1,'') AS FF_NUMBER1, ISNULL(FF_NUMBER2,'') AS FF_NUMBER2,ISNULL(PLACE_ISSUE,'') AS PLACE_ISSUE,ISNULL(.DBO.CONVERTDATEDMY1(DOB),'') AS DOB, ISNULL(ADDRESS,'') AS ADDRESS,ISNULL(CONTACT_NUMBER,''),                 ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2,EMP_CODE, GENDER FROM M_USERINFO WHERE USERID='"+strUserId+"' and  application_id=1";                                                      //2/28/2007
//System.out.println("1 strSql======="+strSql);

    rs = dbConBean.executeQuery(strSql);
	if(rs.next())
	{
		FIRSTNAME        = rs.getString(1);
		LASTNAME         = rs.getString(2);
		PIN              = rs.getString(3);
		EMAIL            = rs.getString(4);
		
		if(changeCombo !=null && changeCombo.equals("yes"))
        {
	    	
		}
		else
		{
           strSiteNameId    = rs.getString(5);
    	   strDivNameId     = rs.getString(6);
	       strDeptNameId    = rs.getString(7);
		   strDesigNameId   = rs.getString(8);
		}
		
		REPORT_TO        = rs.getString(9);
		SECRET_QUESTION  = rs.getString(10);
		
		SECRET_ANSWER   = rs.getString(11);
		PASSPORT_NO     = rs.getString(12);
		DATE_ISSUE      = rs.getString(13);
		ECNR            = rs.getString(14);
		EXPIRY_DATE     = rs.getString(15);
		FF_NUMBER       = rs.getString(16);
		FF_NUMBER1      = rs.getString(17);
		FF_NUMBER2      = rs.getString(18);
		PLACE_ISSUE     = rs.getString(19);
		DOB             = rs.getString(20);
		ADDRESS         = rs.getString(21);
		CONTACT_NUMBER  = rs.getString(22);
		


		//NEW 16-02-2007 SACHIN
		strCurrentAddress	=	rs.getString("CURRENT_ADDRESS");
		strAirLineName		=	rs.getString("FF_AIR_NAME");
		strAirLineName1		=	rs.getString("FF_AIR_NAME1");
		strAirLineName2		=	rs.getString("FF_AIR_NAME2");
		EMP_CODE         = rs.getString("EMP_CODE");
		//
		
		strGender		= rs.getString("GENDER"); //add by vijay on 20/04/2007
			//System.out.println("---------------------20/04/2007--------gender-----"+strGender);
		}
	
	rs.close();
//SECRET_ANSWER=dbUtility.decryptFromDecimalToString(SECRET_ANSWER);
   //Get the name of Report_To Person
   String strReportPersonName = "";                      //define the variable for getting the name of reporting person
   //query for the getting the name for reporting person 

   //status_id  removed  by shiv on 24-May-07 open
   strSql = "select ISNULL(star.dbo.user_name(Report_to),'-') from M_userInfo where USERID='"+strUserId+"' and  application_id=1";
   //status_id  removed  by shiv on 24-May-07 close
   
   rs     = dbConBean.executeQuery(strSql);    //Get the resultset form the M_UserInfo
   if(rs.next())
   {
         strReportPersonName = rs.getString(1);
   }
   rs.close();

  // get the current date for checking the expiryDate and DateOfBirth
  Date currentDate = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  String strCurrentDate = (sdf.format(currentDate)).trim();
  
%>

<!--Java Script -->
<script language=JavaScript>
  function setValue()
  {
	 document.frm.action="M_UpdateProfile.jsp?changeCombo=yes";
	 document.frm.designation.value="-1";
	 document.frm.department.value="-1";
	 document.frm.submit();

	 /* var div  = document.frm.division.value;
	  var site = document.frm.site.value;
	  var dept = document.frm.department.value;
	  if(div == "S")
	  {
		site = "S";
		dept = "S";
	  }
	  if(site == "S")
	  {
		dept = "S"
	  }	
	  //alert("div is =="+ div+"  site is=="+site+"  dept is=="+dept );
	  window.location.href = "M_UpdateProfile.jsp?division="+div+"&site="+site+"&department="+dept+"&changeCombo=yes&"+"userId="+<%=strUserId%>;*/
  }

  //Added By Vijay Singh ON 11/04/2007 TO ENABLE AND DISABLE THE FUNCTIONALITY
		 function questOther()
		{

			if(document.frm.quest_secret1.value=="Others")
			{
				document.frm.secretQuestion.disabled=false;
				document.frm.secretAnswer.value="";
				document.frm.secretQuestion.focus();
			}
			else
			{
				document.frm.secretQuestion.value="";
				document.frm.secretAnswer.value="";
				document.frm.secretQuestion.disabled=true;
			}
		}
		//END MODIFICATION
		//Added By Vijay Singh ON 17/04/2007 FOR SELECTING THE QUESTION FROM THE OPTION LIST
		function optionValue()
		{
			var question;
			for(var i=0;i<document.frm.quest_secret1.length;i++)
			{
				question=document.frm.quest_secret1[i].value;
								
				if(question=="<%=SECRET_QUESTION%>")
				{
					document.frm.quest_secret1.value="<%=SECRET_QUESTION%>";
					document.frm.secretQuestion.value="";
					document.frm.secretQuestion.disabled=true;
					break;
				}
				else  
				{
					document.frm.secretQuestion.disabled=false;
					document.frm.quest_secret1.value="Others";
					document.frm.secretQuestion.value="<%=SECRET_QUESTION%>";
					if(document.frm.secretQuestion.value=='')
					{
						document.frm.quest_secret1.value="-1";
						document.frm.secretQuestion.disabled=true;
					}
				}
			}
				
		}
//END MODIFICATION
//Added By Vijay Singh ON 20/04/2007 FOR SELECTING THE GENDER FROM THE OPTION LIST

		function gender()
		{
			var gender;
			for(var j=0;j<document.frm.gender.length;j++)
			{
				gender=document.frm.gender[j].value;
				if(gender=="<%=strGender%>")
				{
					document.frm.gender.value="<%=strGender%>";
					break;
				}
				else
				{
					document.frm.gender.value="-1";
				}
			}

		}
//END MODIFICATION

  function checkData(f1)
  {
      
			
	if(f1.firstName.value=='')
	{
		alert("Please fill the first name");
		f1.firstName.focus();
		return false;
	}
	/*if(f1.lastName.value=='')
	{
		alert("Please fill the last name"); //commented by shiv on 3/19/2007
		f1.lastName.focus();
	  return false;
	}*/
     
	//2/28/2007 
	/*
    if(f1.lastName.value=='')
	{
		alert("Please fill the last name");
		f1.lastName.focus();
		return false;
	}	
 */
	if(f1.gender.value=='-1')
	{
		alert("Please select your gender");
		f1.gender.focus();
		return false;
	}

	if(f1.email.value=='')
	{
		alert("Please fill the Email");
		f1.email.focus();
		return false;
	}
	var flag = echeck(window.document.frm.email.value);
	if (flag == false)
	{
		f1.email.focus();
		return flag;
	}
    if(f1.division.value == '-1' || f1.division.value == '')
	{
       alert("Please select the division");
	   f1.division.focus();
	   return false;  
	}
	if(f1.site.value == '-1' || f1.site.value == '')
	{
       alert("Please select the site");
	   f1.site.focus();  
	   return false;  
	}
	if(f1.department.value == '-1' || f1.department.value == '')
	{
       alert("Please select the department");
	   f1.department.focus();
	   return false;  
	}

	if(f1.designation.value == '-1' || f1.designation.value == '')
	{
       alert("Please select the designation");
	   f1.designation.focus();
	   return false;  
	}
	///2/28/2007 
 
	if(f1.empcode.value == '')
	{
       alert("Please Enter your Employee Code");
	   f1.empcode.focus();
	   return false;  
	}
	 //Added By Vijay Singh on 11/04/2007 check for secret Question and Answer 
			
			 if(f1.quest_secret1.value=='-1'&&f1.secretQuestion.value=='')
			 {
				 alert("Please Select Your Secret Question");
				 f1.quest_secret1.focus();
				 return false;
			 }
			 //@ Vijay Singh 14/04/2007 Change the functionality of secret question
			 if(f1.secretQuestion.disabled==false&&f1.secretQuestion.value=='')
			 {
				 alert("Please Enter Your Secret Question");
				 f1.secretQuestion.focus();
				 return false;
			 }
		/*	 if(f1.quest_secret1.value=='Others' &&f1.secretQuestion.disabled==false && f1.secretQuestion.value=='')
			 {

				alert("Please Enter Your  Secret Question");
				f1.secretQuestion.focus();
				return false;
			  }*/
			   if(f1.secretAnswer.value=='')
			 {
				 alert("Please Enter Your Secret Answer");
				 f1.secretAnswer.focus();
				 return false;
			 }
			   if(f1.secretQuestion.disabled==false && f1.secretQuestion.value!='')
			  {
				f1.question_other.value=f1.secretQuestion.value;
				
			  }
			  else
			  {
				  f1.question_other.value = '-';
			  }
	    	 //END MODIFICATION ON 11/04/2007.		  


		//empcode
				if(f1.dateOfBirth.value == 'S' || f1.dateOfBirth.value == '')
				{
			       alert("Please fill the Date of Birth");
				   f1.dateOfBirth.focus();
				   return false;  
				}  
			    var flag = checkPassportInfo(f1); //checking if any passport informations are filled.
	if(flag == false)
		return flag;
	flag =  checkDOB(f1);
	if(flag == false)
		return flag;

   var flag = CheckFFDetail(f1); 
       if(flag == false)
	  {
		return flag;
	  }
	//encryption();
	return true;
  }
  function encryption()
         {
			 //added the secret answer field for encript password @Vijay 11/04/2007
            var secret_answer="<%=SECRET_ANSWER%>";
			alert("Encrypted newSecret_answer with key is being sent to request "+secret_answer);
           // var newSecret_answer=encrypt(secret_answer);
			//document.form.secretAnswer.value=newSecret_answer;
					
            return true;
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
    	document.frm.reportTo.value="";
	}
	else
	{
		document.frm.reportTo.value =designation.flag;
		var userid = designation.userid;
		document.frm.repToUserId.value =designation.userid;
		//alert(userid);
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

     //2/28/2007
    
    if(obj1=='empcode')
	{
		 obj = document.frm.empcode;
		 //zeroChecking(obj);
	}	
	 
 
	 //2/28/2007


	if(obj1=='eMail')
	{
		 obj = document.frm.email;
	}	

	if(obj1=='secretQuestion')
	{
		 obj = document.frm.secretQuestion;
	}	
	if(obj1=='secretAnswer')
	{
		 obj = document.frm.secretAnswer;
	}	
	if(obj1=='passportNo')
	{
		 obj = document.frm.passportNo;
	}	
	if(obj1=='ffNo')
	{
		 obj = document.frm.ffNo;
	}
	if(obj1=='ffNo1')
	{
		 obj = document.frm.ffNo1;
	}	
	if(obj1=='ffNo2')
	{
		 obj = document.frm.ffNo2;
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


	
	if(obj1=='placeOfIssue')
	{
		 obj = document.frm.placeOfIssue;
	}	
	if(obj1=='address')
	{
		 obj = document.frm.address;
	}	
	if(obj1=='current_address')
	{
		 obj = document.frm.current_address;
	}	
	if(obj1=='contactNo')
	{
		 obj = document.frm.contactNo;
	}
	//add by Vijay on 20/04/2007 
	if(obj1=='gender')
	{
		obj = document.frm.gender;
	}
	

    
//	var obj11 = document.frm.obj.value;
//	alert(""+obj11);
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


 // added  on 07-Jun-07  by  shiv   
  function button_onclick(obj) 
	    {
	             popUpCalendar(obj,obj,"dd/mm/yyyy");
		}
		
</script>

</head>



<!-- Start of body -->

<body onload="optionValue();gender();"><script type="text/javascript" language="JavaScript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td height="50" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead"><%=strMessage%></li>
    </ul>	</td>	
  </tr>
</table>
<!-- Start of Form -->
<form method=post name=frm action="M_UpdateProfilePost.jsp" >
<table width="85%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
<tr align="left">
  <td colspan="4" class="selectedmenubg">&nbsp;</td>
  </tr>
<tr align="left">
  <td colspan="4" class="dataLabel">Update Your User ID! <font color='red' size=1> (In case you make any changes in the name, unit, designation, department,employee code or date of birth, your access on STARS would be disabled. Your access would be enabled only when your local administrator would made the verification.)</font></td>
  </tr>
<tr align="left">
  <td width="116" class="formtr1"><FONT SIZE="" COLOR="#FF3300">*</FONT>First Name<br> 
    (As per passport)</td>  
  <!--  FIRST NAME  -->
  <td width="220" class="formtr1"><input type="text" name="firstName" size="25" onKeyUp="return test1('firstName', 29, 'c')" maxlength="50"  class="textBoxCss" value="<%=FIRSTNAME%>"/></td>
  <td width="120" class="formtr1"> <FONT SIZE="" COLOR="#FF3300"></FONT>Last Name<br> 
    (As per passport) </td>  
  <!--  LAST NAME  -->
  <td width="328" class="formtr1"><input type="text" name="lastName" size="25" onKeyUp="return test1('lastName', 29, 'c')" maxlength="50" class="textBoxCss" value="<%=LASTNAME%>"/></td>
</tr>
<%
  strSql =   "select Div_id, Div_Name from M_Division where status_id=10 and application_id=1 order by 1";
  rs     =   dbConBean.executeQuery(strSql);  
  rs.close();
%>

<tr align="left">
  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">*</FONT> Email</td>  <!--  EMAIL  -->
  <td class="formtr1"><input type="text" name="email" size="25" maxlength="50" onKeyUp="return test1('eMail', 50, 'an')" class="textBoxCss" <%=strEmailIDAccess%> value="<%=EMAIL%>"/></td>
	<input type="hidden" name="division"> 
<% 
	rs = dbConBean.executeQuery("SELECT  DIV_ID FROM M_SITE WHERE APPLICATION_ID=1 and SITE_ID="+strSiteNameId); 
	while(rs.next())
	{
		strDivNameId=rs.getString(1);
	}
	rs.close();
%>
  
		<script language="javascript">
		document.frm.division.value="<%=strDivNameId%>";
		//alert(document.frm.division.value);
		</script>
   
  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">*</FONT>Unit</td>  <!--  Site  -->
  <td class="formtr1">
    <select name="site" onChange= "return setValue();"  class="textBoxCss">
      <option value="-1" selected>Select Your Unit</option>
<%
    //For Population of Site Combo according to the division
    if(strDivNameId != null && strDivNameId.equals("S"))
    {
      //strSql =   "select site_id, site_Name from M_Site where status_id=10 and application_id=1 order by 1";
    }
    else
    {
	  //New Check for local administrator
	  if((SuserRole.trim().equals("AD")))
	  {	
   			strSql =   "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE  APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME ";
	  }
	  else
	  {
		    strSql = "SELECT SITE_ID,SITE_NAME FROM M_SITE WHERE APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY SITE_NAME";	
	  }
	//
    
      rs       =   dbConBean.executeQuery(strSql);  
      while(rs.next())
      {
%>
        <option value="<%=rs.getString("SITE_ID")%>"><%=rs.getString("SITE_NAME")%></option>
<%
	  }
      rs.close();	  
	}
%>
    </select>
	<script language="javascript">
	  document.frm.site.value="<%=strSiteNameId%>";
	</script>  </td>
  </tr>


 <tr align="left">	
  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">*</FONT> Department</td>  <!--  Department  -->

  <td class="formtr1">
    <select name="department" class="textBoxCss">
      <option value="-1" selected>Select Your Department</option>
<%
       //For Population of Department Combo according to the site
       if(strSiteNameId != null && strSiteNameId.equals("S")) 
       {
        //strSql =   "select dept_id, dept_name from M_Department order by 1";
       }
       else
       {
    	 strSql =   "select dept_id, dept_name from M_Department where div_id="+strDivNameId+" and site_id="+strSiteNameId+" and status_id=10 and application_id=1  order by 1";
         rs       =   dbConBean.executeQuery(strSql);  
	     while(rs.next())
	     {
%>
	        <option value="<%=rs.getString("Dept_Id")%>"><%=rs.getString("Dept_Name")%></option>
<%
	     }
         rs.close();	  
	   }
%>
    </select>
	<script language="javascript">
      document.frm.department.value="<%=strDeptNameId%>";
	</script>  </td>

<%
  //For Population of Designation Combo 
  strSql =   "SELECT DESIG_ID,DESIG_NAME  FROM M_DESIGNATION where site_id="+strSiteNameId+" AND APPLICATION_ID=1 AND STATUS_ID = 10 ORDER BY DESIG_NAME";
  rs     =   dbConBean.executeQuery(strSql);  
%>


  <td class="formtr1"><FONT SIZE="" COLOR="#FF3300">*</FONT> Designation</td>  <!--  Designation  -->
  <td class="formtr1">
    <select name="designation"  class="textBoxCss">
      <option value="-1" selected>Select Your Designation</option>
<%
	  while(rs.next())
	  {
%>
	     <option value="<%=rs.getString("Desig_Id")%>"><%=rs.getString("Desig_Name")%></option>
<%
	  }
      rs.close();	  
%>
    </select>
	<script language="javascript">
      document.frm.designation.value="<%=strDesigNameId%>";
	</script>  </td>
  </tr>
  <tr>
<!-- 2/28/2007 by shiv -->
<td class="formtr1"><font size="" color="#FF3300">*</font>&nbsp;Employee Code</td><td width="328" class="formtr1">
<input type="text" name="empcode" size="15" maxlength="30" class="textBoxCss" onKeyUp="return test1('empcode', 30, 'cn')" value="<%=EMP_CODE%>"/></td>

<!-- @ Vijay Singh changes on 20/04/2007 for Adding the gender-->

<td  class="formtr1"><font size="" color="#FF3300">*</font>Gender </td>
	 
	  <td class="formtr1">
			<select name="gender" class="textBoxCss">
				<option value="-1">Gender</option>
				<option value="Male">Male</option>
				<option value="Female">Female</option>
			</select>
	</td>
   <!--End Modification-->


</tr>
<!-- 2/28/2007 by shiv-->


			<tr align="center">
			<td colspan="4" align="left" class="dataLabel">Select the Person you Report To!</td>
			</tr>
			<tr align="center">
			<% for(int i=0;i<=1;i++) { %>
			<td class="formtr1"><input type="radio" value=<%=strSiteNameId%> name="reportto" onClick="report_to('report_to.jsp','<%=i%>');"><%=arrayRadio[i]%></span></td>
			<% } %>
			<td class="formtr1"><input type="text" name="report" size="20" value="<%=strReportPersonName%>" readonly class="textBoxCss" >
			<td class="formtr1">			</tr>
  <tr align="center">
    <td colspan="4" align="left" class="dataLabel">If You Forget Your Password!</td>
  </tr>
  <tr align="center">
    <td class="formtr1"><font size="" color="#FF3300">*</font> Secret Question</td>  <!--  SECRET QUESTION  -->
	<!--@ Vijay Singh add the option for secret question -->
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
  <td class="formtr1"><input type="text" name="secretQuestion" size="30" onKeyUp="return test1('secretQuestion', 100, 'all')" maxlength="100" class="textBoxCss" value="" /></td>
					<td class="formtr1">
					</td>
	</tr>
	<tr>
  <td class="formtr1"><font size="" color="#FF3300">*</font> Secret Answer</span></td>  <!--  SECRET ANSWER  -->
  <td class="formtr1"><input type="password" name="secretAnswer" size="20" onKeyUp="return test1('secretAnswer', 16, 'pwd')" maxlength="15" class="textBoxCss" value="<%=SECRET_ANSWER%>"/><span></td>

				<td class="formtr1">
				</td>
				<td class="formtr1">
				</td>
</tr>
  <tr align="center">
    <td colspan="4" align="left" class="formtr1"><span style="font-family:Arial; font-size:8.5pt; color:black; ">Please provide a complex answer hard to crack.</span></td>
  </tr>
  <tr align="center">
    <td colspan="4" align="left" class="dataLabel">Update your Passport Details!</td>
  </tr>
  <tr align="center">
    <td width="116" class="formtr1">Passport No</td>  <!--  PASSPORT NO  -->
  <td width="220" class="formtr1"><input type="text" name="passportNo" size="25" onKeyUp="return test1('passportNo', 49, 'all')" maxlength="49" class="textBoxCss" value="<%=PASSPORT_NO%>"/></td>
  <td width="120" class="formtr1">Date of Issue (DD/MM/YYYY)</td>  <!--  DATE OF ISSUE  -->
  <td width="328" class="formtr1"><input type="text" name="dateOfIssue" size="10" maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" value="<%=DATE_ISSUE%>"/>
   <!--<a href="javascript:show_calendar('frm.dateOfIssue','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
      <!-- <img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> -->
             
			 
			 <!-- added by shiv on 07-Jun-07  OPEN-->
             <a   onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"  onclick="button_onclick(document.frm.dateOfIssue);">
           	 <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17></a>
             <!-- added by shiv on 07-Jun-07 CLOSE -->
   
   </a>  
   </td>

</tr>
  <tr align="left">
    <td class="formtr1">Emigration Clearance Required</td>  <!--  ECR  -->
    <td class="formtr1">
      <input name="ecnr" type="radio" value="1" />Yes 
      <input name="ecnr" type="radio" checked = "checked"  value="2"/>No
<!--	  <input type="text" name="ecnr" size="30" onkeyup="return test1('ecnr', 49, 'all')" maxlength="49" class="textBoxCss" value="<%=ECNR%>"/>-->	</td>
    <script language="javascript">
		document.frm.ecnr.value ="<%=ECNR%>";
		if (document.frm.ecnr.value == 1) 
		{
			document.frm.ecnr[0].checked = true;
		}
		else if (document.frm.ecnr.value == 2) 
		{
			document.frm.ecnr[1].checked = true;		
		}
	</script>

    <td class="formtr1">Expiry date &nbsp; &nbsp;(DD/MM/YYYY)</td>  <!--  EXPIRY DATE  -->
    <td class="formtr1"><input type="text" name="expireDate" size="10" maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  value="<%=EXPIRY_DATE%>"/>
	<!--<a href="javascript:show_calendar('frm.expireDate','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><!-- <img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> -->
	
	
	<!-- adddded by shiv on 07-Jun-07 -->
     <a onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;" onclick="button_onclick(document.frm.expireDate);">
	 <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17>
	<!-- added by shiv on 07-Jun-07 -->
		
	</a>	</td>
  </tr>
  <tr align="left">
  <td colspan="2" rowspan="2" class="formtr1">Frequent Flyer Detail <br>
    <table width="185" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="left" valign="bottom" class="formtr1" scope="row"> Airline Names &nbsp;&nbsp; </td>
        <td align="left" valign="bottom" class="formtr1">Airline Number</td>
      </tr>
      <tr>
        <th width="90" align="left" scope="row"><span class="label2">
          <input name="airLineName" type="text" value="<%=strAirLineName%>" class="textBoxCss" size="12" onKeyUp="return test1('airLineName', 20, 'cn')"/>
          <br>
          <input name="airLineName1" type="text" value="<%=strAirLineName1%>" class="textBoxCss" size="12" onKeyUp="return test1('airLineName1', 20, 'cn')"/>
          </span><span class="label2"> <br>
          <input name="airLineName2" type="text" value="<%=strAirLineName2%>" class="textBoxCss" size="12" onKeyUp="return test1('airLineName2', 20, 'cn')"/>
        </span></th>
        <td width="90" align="left"><span class="label2">
          <input name="ffNo" type="text"   class="textBoxCss" size="12" onKeyUp="return test1('ffNo', 20, 'cn')"/>
		  <script language="javascript">
				document.frm.ffNo.value ="<%= FF_NUMBER.trim() %>";
				</script>		  
          <br>
          <input name="ffNo1" type="text"  class="textBoxCss" size="12" onKeyUp="return test1('ffNo1', 20, 'cn')"/>
		  <script language="javascript">
				document.frm.ffNo1.value ="<%= FF_NUMBER1.trim() %>";
				</script>		  
          <br>
          <input name="ffNo2" type="text"  class="textBoxCss" size="12" onKeyUp="return test1('ffNo2', 20, 'cn')"/>
        </span><script language="javascript">
				document.frm.ffNo2.value ="<%= FF_NUMBER2.trim() %>";
				</script>		  </td>
      </tr>
      <tr>
        <th align="left" scope="row">&nbsp;</th>
        <td align="left">&nbsp;</td>
      </tr>
    </table></td>  <!--  FF NO  -->
  <td valign="top" class="formtr1">Place of issue </td>  <!--  PLACE OF ISSUE  -->
  <td valign="top" class="formtr1"><input type="text" name="placeOfIssue" size="10" onKeyUp="return test1('placeOfIssue', 99, 'c')"  maxlength="99" class="textBoxCss" value="<%=PLACE_ISSUE%>"/></td>
</tr>
  <tr align="left">
    <td valign="top" class="formtr1">Permanent Address</td>
    <td valign="top" class="formtr1"><textarea name="address" rows="5" cols="30" onKeyUp="return test1('address', 149, 'all')" id="address"><%=ADDRESS%></textarea></td>
  </tr>
  <!--@Vijay Singh 26/Mar/2007 DBO Remove the readonly check on DBO field -->
  <tr align="left">
  <td valign="top" class="formtr1"> DOB<font size="" color="#FF3300">*</font>&nbsp;&nbsp;(DD/MM/YYYY)</td>  <!--  DOB  -->
  <td valign="top" class="formtr1"><input type="text" name="dateOfBirth"  size="10" maxlength="10" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  value="<%=DOB%>"/>
  <!--<a href="javascript:show_calendar('frm.dateOfBirth','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><!-- <img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"> -->
  <!-- added by shiv on 07-Jun-07 open -->

    <a onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"  onclick="button_onclick(document.frm.dateOfBirth);">
     <IMG   height=14 alt=Calender src="images/calender.png?buildstamp=2_0_0"   width=17>
  <!-- added by shiv on 07-Jun-07 close -->
  
  
  </a>  </td>
  <td valign="top" class="formtr1">Current Address </td>  
  <!--  ADDRESS  -->
  <td valign="middle" class="formtr1"><textarea name="current_address" rows="5" cols="30" onKeyUp="return test1('current_address', 149, 'all')" id="textarea"><%=strCurrentAddress%></textarea></td>
</tr>
<tr align="left">
  <td class="formtr1"> Mobile Number </td>  <!--  CONTACT NO.  -->
  <td class="formtr1"><input type="text" name="contactNo" size="12" onKeyUp="return test1('contactNo', 19, 'phone')" maxlength="20" class="textBoxCss" value="<%=CONTACT_NUMBER%>"/></td>
  <td class="formtr1"></td>
  <td class="formtr1"></td>
</tr>
  <tr align="center"> 
    <td colspan="4" >
      <input type="submit" name="Submit" value="Update" class="formButton" onClick="return checkData(this.form)" >  <!--SUBMIT BUTTON-->
    <!--<input type="reset" name="reset" value="Reset" class="formButton"></td>-->  </tr>
        <input type="hidden" name="status_id" value="10" >                  <!--  HIDDEN FIELD  -->
		<input type="hidden" name="repTo" value=<%=REPORT_TO%>>             <!--  HIDDEN FIELD  -->
		<input type="hidden" name="repToUserId" value="s1">                 <!--  HIDDEN FIELD  -->
		<input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->
		<input type="hidden" name="userId" value="<%=strUserId%>"/>         <!--  HIDDEN FIELD  -->
		<input type="hidden" name="Deactiveflag" value="<%=strDeactiveflag%>"/>         <!--  HIDDEN FIELD  --><!-- added by shiv on 23-May-07 -->
		 <input type="hidden" name="question_other" value="" ><!-- Add by Vijay on 11/04/2007  for other secret question-->
</table>
</form>

<!-- End of Form -->
</body>
</html>
<%
   dbConBean.close();  // CLOSE ALL CONNECTION
%>
