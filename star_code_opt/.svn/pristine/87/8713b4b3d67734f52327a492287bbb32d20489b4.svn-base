<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:12 September 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp file is for updating the SITE in the STAR Database
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		: By Shiv Sharma on  15-02-2007
									  1. Added three more fields under Frequent Flyer Details,
                                      2 .Added  Current Address  text area in contact detail 
									  3. Change label of 'Emigration Status ECNR' to  'Emigration Clearance  Required' 
									    as per RFC.
						By Sanjeet Kumar on 20-July-07 to display message incase page not uploaded.
						By Sanjeet Kumar on 25-July-07 to solve attachment problem.
 *Editor				:Editplus
 
 *Modified By			:Manoj Chand
 *Date of Modification	:21 Oct 2011
 *Modification			:childwindowSubmit() added to close attachment screen.
 
 *Modified By			:Manoj Chand
 *Date of Modification	:22 Oct 2013
 *Modification			:javascript validation to stop from typing --,'  symbol is added.
 *******************************************************/
%>
<%@ page import = "java.sql.*" pageEncoding="UTF-8"%>
<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<%@ include  file="importStatement.jsp" %>
<%-- include remove cache  --%>
<%@ include  file="cacheInc.inc" %>
<%-- include header  --%>
<%@ include  file="headerIncl.inc" %>
<%-- include page with all application session variables --%>
<%@ include  file="application.jsp" %> 
<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
<%@ include file="M_InsertProfile.jsp"  %>
<script language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></script>
<SCRIPT language=JavaScript src="ScriptLibrary/validation.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<!-- <SCRIPT language="JavaScript" src="LocalScript/M_InsertProfile.js?buildstamp=2_0_0"></SCRIPT> -->
 
<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
<script>
function MM_openBrWin(theURL,winName,features)
 { 
		   window.open(theURL,winName,features); 
 }
 </script>
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
	<title>User Registration Screen</title>
</head>

<!--Create the DbConnectionBean object for createConnection-->
<% 
       String strTravelReqId        =  "";
       String strTravelId			=  "";
	   String strTravellerId		=  "";
       String strTravelReqNo        =  "";
       String strTravellerSiteId    =  "";
       String strTravellerIdPost	=  ""; 
	   String strInterimId 			=  "";
   	   strInterimId 				=	request.getParameter("interimId")== null ? "" : request.getParameter("interimId");
	   strTravelReqId               =  request.getParameter("travelReqId");    
       strTravelId                  =  request.getParameter("travelId");       
       strTravelReqNo               =  request.getParameter("travelReqNo");    
       strTravellerSiteId           =  request.getParameter("travellerSiteId");    
	   strTravellerId	        	=  request.getParameter("travellerId");

		String fullname				="";
		String passport_No			= "";
		String passport_issuePlace 	= "";
		String passport_issue		= "";
		String passport_expire		= "";
		String passport_ECNR		= "";
		String passport_DOB			= "";
		String passport_contactNo	= "";
		String passport_Address		= "";
		String passport_FNo			= "";
		String passport_FNo1		= "";
		String passport_FNo2		= "";


//new 16-02-2007
		String strCurrentAddress	=	"";
		String strAirLineName		=	"";
		String strAirLineName1		=	"";
		String strAirLineName2		=	"";
		String strFirstName         =   "";
		String strLastName          =   "";
		String LastLetter			=	"";

		// Code added by Sanjeet Kumar on 16-july-2007 for giving a proper information incase site not uploaded
		//SpolicyPath variable used on 07 jan 2013 for getting company policy path
   		//String Path	=application.getInitParameter("companyPolicyPath");
		File UploadFile=new File(SpolicyPath+"/"+strSiteFullName+"/"+strSiteFullName+".html");



//	


    String strSql = "select FIRSTNAME,LASTNAME,PASSPORT_NO,PLACE_ISSUE,convert(varchar(20),DATE_ISSUE,103) as DATE_ISSUE ,convert(varchar(20),EXPIRY_DATE,103) as EXPIRY_DATE ,ECNR,convert(varchar(20),DOB,103) as DOB,CONTACT_NUMBER,ADDRESS,FF_NUMBER,FF_NUMBER1,FF_NUMBER2,  ISNULL(CURRENT_ADDRESS,'') AS CURRENT_ADDRESS, ISNULL(FF_AIR_NAME,'') AS FF_AIR_NAME, ISNULL(FF_AIR_NAME1,'') AS FF_AIR_NAME1, ISNULL(FF_AIR_NAME2,'') AS FF_AIR_NAME2 from m_userinfo where userid="+strTravellerId+" and	APPLICATION_ID=1 AND STATUS_ID=10";
	ResultSet rs = dbConBean.executeQuery(strSql);
	while(rs.next())
	{
		strFirstName = rs.getString("FIRSTNAME");
		strLastName  = rs.getString("LASTNAME");

		//System.out.println(strFirstName+" " +strLastName);


		fullname = strFirstName+ " "+strLastName ;

		if((fullname== "") || (fullname==null))
		{
			fullname="";
		}
		else
		{
			int s = fullname.indexOf(" ",0);
			String FirstLetter = fullname.substring(0,1).toUpperCase() + fullname.substring(1,s);
			
			if(!strLastName.equals(""))
			{
			  LastLetter = fullname.substring(s+1,s+2).toUpperCase() +fullname.substring(s+2,fullname.length()) ; 
			//	LastLetter = fullname.substring(0,1).toUpperCase() +fullname.substring(s+2,fullname.length()) ;
			}
			fullname = FirstLetter+" "+LastLetter;
		}
	
		passport_No			= rs.getString("PASSPORT_NO");				//?" ":rs.getString("PASSPORT_NO");
		if((passport_No== "") || (passport_No==null))
		{
			passport_No="";
		}
		passport_issuePlace	= rs.getString("PLACE_ISSUE");			//==null	//?"":rs.getString("PLACE_ISSUE");
		if((passport_issuePlace== "") || (passport_issuePlace==null))
		{
			passport_issuePlace="";
		}

		passport_issue		= rs.getString("DATE_ISSUE");				//==null	//?"":rs.getString("DATE_ISSUE");
		if((passport_issue== "") || (passport_issue==null))
		{
			passport_issue="";
		}
		if( passport_issue != null && (passport_issue.equals("") || passport_issue.equalsIgnoreCase("01/01/1900")) )
		{
			passport_issue = "";
		}	

		passport_expire		= rs.getString("EXPIRY_DATE");				//==null	//?"":rs.getString("EXPIRY_DATE");
		if( passport_expire != null && (passport_expire.equals("") || passport_expire.equalsIgnoreCase("01/01/1900")) )
		{
			passport_expire = "";
		}	
		if((passport_expire== "") || (passport_expire==null))
		{
		   passport_expire="";
		}
		passport_ECNR		= rs.getString("ECNR");	//==null	?"":rs.getString("ECNR");
		if((passport_ECNR== "") || (passport_ECNR==null))
		{
		passport_ECNR="";
		}
		passport_DOB		= rs.getString("DOB");						//==null	?"":rs.getString("DOB");
		if( passport_DOB != null && (passport_DOB.equals("") || passport_DOB.equalsIgnoreCase("01/01/1900")) )
		{
			passport_DOB = "";
		}		
		if((passport_DOB==null) || (passport_DOB== "") )
		{			
			passport_DOB="";
		}
		passport_contactNo	= rs.getString("CONTACT_NUMBER");			//==null?"":rs.getString("CONTACT_NUMBER");
		if((passport_contactNo== "") || (passport_contactNo==null))
		{
		passport_contactNo="";
		}
		
		passport_Address	= rs.getString("ADDRESS");//==null		//?"":rs.getString("ADDRESS");
		if((passport_Address== "") || (passport_Address==null))
		{
		passport_Address="";
		}
		passport_FNo		= rs.getString("FF_NUMBER");		//?"":rs.getString("FF_NUMBER");	
		
		if((passport_FNo== "") || (passport_FNo==null))
		{
		passport_FNo="";
		}
	
	
	
	passport_FNo1		= rs.getString("FF_NUMBER1");		//?"":rs.getString("FF_NUMBER");	
		
		if((passport_FNo1== "") || (passport_FNo1==null))
		{
		passport_FNo1="";
		}

		
		passport_FNo2		= rs.getString("FF_NUMBER2");		//?"":rs.getString("FF_NUMBER");	
		
		if((passport_FNo2== "") || (passport_FNo2==null))
		{
			passport_FNo2="";
		}

		//NEW 16-02-2007 SACHIN
		strCurrentAddress	=	rs.getString("CURRENT_ADDRESS");
		strAirLineName		=	rs.getString("FF_AIR_NAME");
		strAirLineName1		=	rs.getString("FF_AIR_NAME1");
		strAirLineName2		=	rs.getString("FF_AIR_NAME2");
		//
	
	}
	rs.close();
	dbConBean.close();

	// get the current date for checking the expiryDate and DateOfBirth
  	Date currentDate = new Date();
  	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  	String strCurrentDate = (sdf.format(currentDate)).trim();

%>
	<script language="JavaScript">
		  
		function checkData(frm) 
		{
			if(frm.passport_No.value == '')
			{
				alert('<%=dbLabelBean.getLabel("alert.global.passportnumber",strsesLanguage)%>');
	            frm.passport_No.focus();
				return false;
			}
			var flag = CheckPassportInfo_ffno(frm); //checking if any passport informations are filled. LocalScript/M_InsertProfile.js
			if(flag == false)
			{
				return flag;
			}
			flag =  checkDOB(frm);
			if(flag == false)
			{
				return flag;
			}

			if(frm.current_address.value == '')
			{
				alert('<%=dbLabelBean.getLabel("alert.global.currentaddress",strsesLanguage)%>');
	            frm.current_address.focus();
				return false;
			}

            ///code added by shiv  sharma on 17-02-07  open
			var flag = CheckFFDetail(frm); 
			if(flag == false)
			{
				return flag;
			}
			 		 
           ///code added by shiv  sharma on 17-02-07  close
			return true;
		  }
	       function test1(obj1, length, str)
			{	
				var obj;

				if(obj1=='passport_No')
				{
					 obj = document.frm.passport_No;
					 upToTwoHyphen(obj);
				}	
				
				if(obj1=='passport_issue_place')
				{
					 obj = document.frm.passport_issue_place;
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
				if(obj1=='passport_Contact_No')
				{
					 obj = document.frm.passport_Contact_No;
					 upToTwoHyphen(obj);
				}
				if(obj1=='passport_expire_date')
				{
					obj	=  document.frm.passport_expire_date; 
				}
				if(obj1=='passport_issue_date')
				{
					obj	=  document.frm.passport_issue_date; 
				}
				if(obj1=='passport_DOB')
				{
					obj	=  document.frm.passport_DOB; 
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
				
			//var obj11 = document.frm.obj1.value;
			//alert(""+obj11);
			charactercheck(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj); //function for checking leading zero and spaces
			spaceChecking(obj);
		}

		function backPage(frm)
		{
           //alert("aa");
		   document.frm.action="T_IntTrv_Details.jsp";
		   //alert("bb=="+document.frm.action);
     	   document.frm.submit();
		}
		function onlySave(frm)
			{
			var flag = checkData(frm);
			if(flag==true)
				{
				document.frm.flag.value="onlySave";
				document.frm.action="T_IntPassport_Details_POST.jsp";
				document.frm.submit();
				}
			}

		function SaveandExit(frm)
			{
			var flag = checkData(frm);
			if(flag==true)
				{
				document.frm.flag.value="SaveandExit";
				document.frm.action="T_IntPassport_Details_POST.jsp";
				document.frm.submit();
				}
			}

		function SaveandProceed(frm)
			{
			var flag = checkData(frm);
			if(flag==true)
				{
				document.frm.flag.value="SaveandProceed";
				document.frm.action="T_IntPassport_Details_POST.jsp";
				document.frm.submit();
				}
			}

		function testResults(i)
		{
		document.frm.ecnr.value=document.frm.radiobutton[i].value;
		}
		
		
		function test(frm)
		{
			if(document.frm.ecnrradio[0].checked)
			{
				document.frm.ecnrhidden.value=document.frm.ecnrradio[0].value;
			}
			if(document.frm.ecnrradio[1].checked)
			{
				document.frm.ecnrhidden.value=document.frm.ecnrradio[1].value;
			}
			if(document.frm.ecnrradio[2].checked)
			{
				document.frm.ecnrhidden.value=document.frm.ecnrradio[2].value;
			}
		}
//added by manoj chand on 21 oct 2011 to close attachment screen.
		function childwindowSubmit(){
			
		}

</SCRIPT>


<body>
<form name="frm" action="T_IntPassport_Details_POST.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="85%" height="36" class="bodyline-top"><img src="images/headerTIT3.png?buildstamp=2_0_0"  /></td>
    <td width="15%" align="center" class="bodyline-top"><img src="images/BigIcon.gif?buildstamp=2_0_0" width="46" height="31" /></td>
  </tr> 
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px; padding-top:0px;">
  

    <td><div align="center"><img src="images\newTabs\2.png?buildstamp=2_0_0" width="486" height="43" /></div></td>

  <tr>
    <td align="center" style="padding-top:5px;"><table width="88%" border="0" cellpadding="0" cellspacing="0">
      <tr><tr>
    <td align="center" style="padding-top:5px;"></td>
      <tr>
        <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
        <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" /><span class="formTit"><%=dbLabelBean.getLabel("label.createrequest.passport",strsesLanguage)%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Company Policy" onClick="<% 
			  // code by sanjeet kumar on 16-july-2007 for giving proper information if site not uploaded.
			  if(UploadFile.exists()) {	%> MM_openBrWin('Companies_Policies/<%=strSiteFullName%>/<%=strSiteFullName%>.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%; } else{%> MM_openBrWin('Companies_Policies/notexist.html','','scrollbars=yes,resizable=yes,width=700,height=300')<%;} %>" ><img src="images/IconPolicy.png?buildstamp=2_0_0" width="69" height="16" border="0" /></a><span class="formTit" style="text-align:right">
		  <a href="#" onClick="MM_openBrWin('helpinternational travel.html#200a','','scrollbars=yes,resizable=yes,width=700,height=300')">
		    <img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0">
          </a>
		</td>
        <td background="images/index_03.png?buildstamp=2_0_0"></td>
      </tr>
      <tr>
        <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
        <td valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="25" colspan="2" valign="bottom" bgcolor="#FFFFFF" class="formfirstfield"><%=dbLabelBean.getLabel("label.createrequest.passportdetails",strsesLanguage)%> &quot;<%=fullname.trim()%>&quot; </td>
          </tr>
          <tr>
            <td colspan="2" bgcolor="#FFFFFF" class="formtxt"><%=dbLabelBean.getLabel("label.global.foryourconvenience",strsesLanguage)%> <%=dbLabelBean.getLabel("label.global.fieldsmarkedwithanasterisk",strsesLanguage)%> (<span class="starcolour">*</span>) <%=dbLabelBean.getLabel("label.global.arerequired",strsesLanguage)%></td>
          </tr>
          <tr>
            <td width="51%" height="34" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30" class="label1"><%=dbLabelBean.getLabel("label.global.passportnumber",strsesLanguage)%><span class="starcolour">*</span> </td>
                </tr>
                <tr>
                  <td height="25" valign="top">
				  <input type="text" name="passport_No" size="25" onKeyUp="return test1('passport_No', 49, 'all')" maxlength="49" class="textBoxCss" /></td>
				  <script language="javascript">
					document.frm.passport_No.value ="<%= passport_No.trim() %>";
				 </script>	
				</tr>
                <tr>
                  <td></td>
                </tr>
            </table></td>
            <td width="49%" height="34" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30" colspan="3" class="label1"> <%=dbLabelBean.getLabel("label.global.issuedetails",strsesLanguage)%><span class="starcolour">*</span> </td>
              </tr>
              <tr>
                <td height="25" valign="bottom" class="label2" ><%=dbLabelBean.getLabel("label.createrequest.placeofissue",strsesLanguage)%></td>
                <td height="0" valign="bottom"  class="label2"><%=dbLabelBean.getLabel("label.global.dateofissue",strsesLanguage)%> <span class="formtxt2">(dd/mm/yyyy)</span></td>
                <td height="0" valign="bottom" class="label2"><%=dbLabelBean.getLabel("label.global.dateofexpiry",strsesLanguage)%><span class="formtxt2">(dd/mm/yyyy)</span></td>
                </tr>
              <tr>
                <td width="34%" height="30" valign="top" >
                <input type="text" name="passport_issue_place" size="10" onKeyUp="return test1('passport_issue_place', 99, 'c')" maxlength="99" class="textBoxCss" /></td>
				<script language="javascript">
					document.frm.passport_issue_place.value ="<%= passport_issuePlace.trim() %>";
				</script>
                
				<td height="0" valign="top" >
				  <input type="text" name="passport_issue_date" size="6" maxlength="50" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
			      <a href="javascript:show_calendar('frm.passport_issue_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><b><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle" ></b></a></td>
				<script language="javascript">
					document.frm.passport_issue_date.value ="<%= passport_issue.trim() %>";
				</script>

                <td height="0" valign="top" >
				  <input type="text" name="passport_expire_date" size="6" maxlength="50" class="textBoxCss" onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);">
			
				  <a href="javascript:show_calendar('frm.passport_expire_date','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><b><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle" ></b>

				</a>
			
				</td>
				<script language="javascript">
					document.frm.passport_expire_date.value ="<%= passport_expire.trim() %>";
				</script>	
				</tr>

            </table></td>
          </tr>
          <tr>
           <td height="34" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
           <table width="100%" border="0" cellspacing="0" cellpadding="0" id="ecnrTbl">
                <tr>
                  <td height="25" colspan="2" class="label1"><%=dbLabelBean.getLabel("label.global.emigrationclearancerequired",strsesLanguage)%><span class="starcolour">*</span> </td>
                </tr>
                <tr>
                  
				
					<td width="15%" height="30" valign="top" ><span class="label2">
                    <input name="ecnrradio" type="radio" value="1" onClick="test(frm)" /><span class="label2"><%=dbLabelBean.getLabel("label.global.yes",strsesLanguage)%></span></td>
					<td width="15%" height="0" valign="top" >
					<input name="ecnrradio" type="radio" value="2" onClick="test(frm)"/><span class="label2"><%=dbLabelBean.getLabel("label.global.no",strsesLanguage)%></span></td>
					<td width="70%" height="0" valign="top" >
					<input name="ecnrradio" type="radio" value="3" onClick="test(frm)"/><span class="label2"><%=dbLabelBean.getLabel("label.global.na",strsesLanguage)%></span></td>
					
					
				</tr>				
            </table>
            <script language ="javascript">
					//window.document.frm.ecnrradio.value= '<%=passport_ECNR%>'
					var flag1   = '<%=passport_ECNR%>';
					if(flag1 == 1)
					{
						document.frm.ecnrradio[0].checked=true;
						document.getElementById("ecnrTbl").style.display="";
					}
					else if(flag1 == 2)
					{
						document.frm.ecnrradio[1].checked=true;
						document.getElementById("ecnrTbl").style.display="";
					}
					else if(flag1 == 3)
					{
						document.frm.ecnrradio[2].checked=true;
						document.getElementById("ecnrTbl").style.display="none";
					}
				
			</script>
            </td>
            <td height="34" bgcolor="#FFFFFF" class="forminnerbrdff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25" class="label1"><%=dbLabelBean.getLabel("label.global.dob",strsesLanguage)%><span class="starcolour">*</span></td>
				<tr><td><span class="formtxt2">(dd/mm/yyyy)</span></td></tr>
				</tr>
                 <tr>                
				 <td height="30" valign="top" >
				     <input name="passport_DOB" type="text" class="textBoxCss" id="test2" size="6"  onFocus="javascript:vDateType='DD/MM/YYYY'" onKeyUp="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')" onBlur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"  onChange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);"  />
						<a href="javascript:show_calendar('frm.passport_DOB','a','a','DD/MM/YYYY');"onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img border="0" name="imageField" src="images/calender.png?buildstamp=2_0_0" align="absmiddle"></a> 
				</td>
				<script language="javascript">
					document.frm.passport_DOB.value ="<%= passport_DOB.trim() %>";
				</script>		
				</tr>
            </table></td>
          </tr>

          <tr>
            <td align="right" bgcolor="#FFFFFF" class="forminnerbrdff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25" colspan="2" class="label1"><%=dbLabelBean.getLabel("label.global.contactdetails",strsesLanguage)%><span class="starcolour">*</td>
              </tr>
              <tr>
                <td height="25" valign="bottom" ><span class="label2"><%=dbLabelBean.getLabel("label.global.mobilenumber",strsesLanguage)%> </td>
                <td height="25" valign="bottom" ><span class="label2">&nbsp; <%=dbLabelBean.getLabel("label.createrequest.permanentaddress",strsesLanguage)%> </td>
				<td height="25" valign="bottom" ><span class="label2">&nbsp; <%=dbLabelBean.getLabel("label.createrequest.currentaddress",strsesLanguage)%> </span></td>
              </tr>
              <tr>
                <td height="30" valign="top" ><input type="text" name="passport_Contact_No" size="12" onKeyUp="return test1('passport_Contact_No', 19, 'phone')" maxlength="20" class="textBoxCss"></td>
				<script language="javascript">
				  document.frm.passport_Contact_No.value ="<%= passport_contactNo.trim() %>";
				</script>
				 <td valign="top" ><span class="label2">&nbsp;	
				<textarea name="passport_address"   cols="28" rows="4" size="34"  onkeyup="return test1('passport_address', 149, 'all')" maxlength="149" class="textBoxCss"><%= passport_Address%></textarea></td>
				
				<td valign="top" ><span class="label2">&nbsp;	
				<textarea name="current_address" cols="28"  rows="4" size="34"  onkeyup="return test1('current_address', 149, 'all')" maxlength="149" class="textBoxCss"><%= strCurrentAddress%></textarea></td>
									
				
				</span></td>
              </tr>
            </table></td>
            <td align="right" valign="top" bgcolor="#FFFFFF" class="forminnerbrdff">
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25" class="label1"><%=dbLabelBean.getLabel("label.createrequest.frequentflyerdetails",strsesLanguage)%></td>
              </tr>
			  <!-- @shiv sharma on  date 15-02-2007 -->
              <tr>
                <td height="30" valign="bottom" class="label2" ><%=dbLabelBean.getLabel("label.createrequest.airlinenames",strsesLanguage)%> &nbsp;&nbsp;&nbsp;<%=dbLabelBean.getLabel("label.createrequest.airlinenumber",strsesLanguage)%></td>
              </tr>
              <tr>
			    
                <td height="30" valign="top" >
				<input type="text" name="airLineName" size="13" onKeyUp="return test1('airLineName', 20, 'cn')" maxlength="20" class="textBoxCss" />
				<script language="javascript">
				document.frm.airLineName.value ="<%= strAirLineName.trim() %>";
				</script>
					 		
				<input type="text" name="passport_flight_No" size="13" onKeyUp="return test1('passport_flight_No', 20, 'cn')" maxlength="20" class="textBoxCss" />
				<script language="javascript">
				document.frm.passport_flight_No.value ="<%= passport_FNo .trim() %>";
				</script>				</td>
			 </tr>
			 
		     <tr>
			    
                <td height="30" valign="top" >
				<input type="text" name="airLineName1" size="13" onKeyUp="return test1('airLineName1', 20, 'cn')" maxlength="20" class="textBoxCss" />
				<script language="javascript">
				document.frm.airLineName1.value ="<%= strAirLineName1.trim() %>";
				</script>
		 	 
				<input type="text" name="passport_flight_No1" size="13" onKeyUp="return test1('passport_flight_No1', 20, 'cn')" maxlength="20" class="textBoxCss" />
				<script language="javascript">
				document.frm.passport_flight_No1.value ="<%= passport_FNo1.trim() %>";
				</script>		  		</td>		
			 </tr>
   <tr>   
                <td height="30" valign="top" >
				<input type="text" name="airLineName2" size="13" onKeyUp="return test1('airLineName2', 20, 'cn')" maxlength="20" class="textBoxCss" />
				<script language="javascript">
				document.frm.airLineName2.value ="<%= strAirLineName2.trim() %>";
				</script>
		 	 
				<input type="text" name="passport_flight_No2" size="13" onKeyUp="return test1('passport_flight_No2', 20, 'cn')" maxlength="20" class="textBoxCss" />
				<script language="javascript">
				document.frm.passport_flight_No2.value ="<%= passport_FNo2.trim() %>";
				</script> </td>
			 </tr>
		 <!-- my code close on date 15-02-2007 -->
            </table>
	</td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF" class="newformbot">
			<!-- @Sanjeet kumar on 26-July-2007 for solving attaching problem. -->
			<a href="#" onClick="MM_openBrWindow('requisitionAttachment.jsp?purchaseReqID=<%=strTravelId%>&err=0&travel_type=I&whichPage=T_IntPassport_Details.jsp&targetFrame=yes','Attachments','scrollbars=yes,resizable=yes,width=775,height=550')" title="<%=dbLabelBean.getLabel("label.global.addattachments",strsesLanguage)%>"><img src="images/AttachFile.gif?buildstamp=2_0_0" width="94" height="24" border="0" /></a>
			</td>
            <td align="right" bgcolor="#FFFFFF" class="newformbot" nowrap="nowrap">
			  <input type="button" class="formButton" name="back" value="<%=dbLabelBean.getLabel("button.global.back",strsesLanguage).trim()%>" onClick="backPage(frm)"/> 
			  <input type="button" class="formButton" name="saveExit" value="<%=dbLabelBean.getLabel("button.global.saveandexit",strsesLanguage).trim()%>" onClick="SaveandExit(frm)"/> 
   		      <input type="button" class="formButton" name="save" value="<%=dbLabelBean.getLabel("button.global.save",strsesLanguage).trim()%>" onClick="onlySave(frm)"/> 
		      <input type="button" class="formButton" name="saveProceed" value="<%=dbLabelBean.getLabel("button.global.saveandnext",strsesLanguage).trim()%>" onClick="SaveandProceed(frm)"/> 	
			</td>
          </tr>
        </table></td>
        <td width="11" background="images/index_03.png?buildstamp=2_0_0"></td>
      </tr>
      <tr>
        <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
        <td height="20" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
        <td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
      </tr>
    </table></td>
  </tr>
  
</table>
<input type="hidden" name="flag">
<input type="hidden" name="UserID">
<input type="hidden" name="ecnrhidden">
<input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->

   <input type="hidden" class="formButton" name="travelId" value="<%=strTravelId%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" class="formButton" name="travelReqId" value="<%=strTravelReqId%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden"  class="formButton" name="travelReqNo" value="<%=strTravelReqNo%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" class="formButton" name="travellerSiteId" value="<%=strTravellerSiteId%>"/> <!--  HIDDEN FIELD  -->
   <input type="hidden" class="formButton" name="travellerId" value="<%=strTravellerId%>"/> <!--  HIDDEN FIELD  -->
   <INPUT TYPE = "hidden" class="formButton" name = "interimId" value = "<%= strInterimId %>" />
</form>
</body>
