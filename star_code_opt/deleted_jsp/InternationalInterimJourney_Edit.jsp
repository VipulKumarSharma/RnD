<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:SACHIN GUPTA
 *Date of Creation 		:15 Nov 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This is first jsp file  for Intrim Journey of Trravel Request
 *Modification 			:
 *Reason of Modification:
 *Date of Modification  :
 *Modified By	        :
 *Editor				:Editplus
 *******************************************************/
%>
<%@ page buffer="5kb" language="java"
	import="java.sql.*,java.io.*,java.util.*,java.io.*,java.math.*,java.text.*"%>
<HTML>
<HEAD>
<%-- include remove cache  --%>
<%@ include file="cacheInc.inc"%>
<%-- include header  --%>
<%@ include file="headerIncl.inc"%>
<%-- include page with all application session variables --%>
<%@ include file="application.jsp"%>
<%-- include page styles  --%>
<%--<%@ include  file="systemStyle.jsp" %>--%>

<!--Create the DbConnectionBean object for createConnection-->
<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />

<%		
			ResultSet rs 			= null;
			String strSql 			= null;
			String strMode			= "";
			String strDCity			= "";	
			String strACity			= "";
			String strDDate			= "";
			String strAirline		= "";

        //New Change Start
			String strVisaRequired  = "";     
            String strVisaComment   = "";     
		//New Change End
			String strInterimId		= "";

			String strAcualTravelId = "";
			String strUpdateFlag    = "";

			strAcualTravelId        =  request.getParameter("actualTravelId");
			if(strAcualTravelId != null && !strAcualTravelId.equals("null") && !strAcualTravelId.equals("") && !strAcualTravelId.equals("new"))
			{
				strUpdateFlag = "yes";     
			}
			else
				strUpdateFlag = "no"; 
//System.out.println("strAcualTravelId=="+strAcualTravelId);
//System.out.println("strUpdateFlag  4444=="+strUpdateFlag);
				
			strDCity				=	request.getParameter("strDeptCity")== null ? "" :request.getParameter("strDeptCity");
			strACity				=	request.getParameter("strArrCity") == null ? "" :request.getParameter("strArrCity");
			strDDate				=	request.getParameter("strDeptDate")== null ? "" :request.getParameter("strDeptDate");
			strAirline				=	request.getParameter("strAirlineName") == null ? "" : request.getParameter("strAirlineName");
			strMode 			    =   request.getParameter("strMode") == null? "1":request.getParameter("strMode");

        //New Change Start
			strVisaRequired         =   request.getParameter("visa")==null?"1":request.getParameter("visa");; 
            strVisaComment          =   request.getParameter("visaComment")==null?"":request.getParameter("visaComment");
		//New Change End


			strInterimId			=	request.getParameter("interimTravelId") == null ? "":  request.getParameter("interimTravelId") ;



//System.out.println("strInterimId=2222======"+strInterimId);


		 // get the current date for checking the departureDate 
		  java.util.Date currentDate = new java.util.Date();
		  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  String strCurrentDate = (sdf.format(currentDate)).trim();
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<SCRIPT language="JavaScript" src="scripts/CommonValida.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="ScriptLibrary/date-picker.js?buildstamp=2_0_0"></SCRIPT>
<SCRIPT language="JavaScript" src="style/pupdate.js?buildstamp=2_0_0"></SCRIPT> 
<script>
function MM_openBrWin(theURL,winName,features)
 { 
		   window.open(theURL,winName,features);
 }
 </script>
<link href="style/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css">
<script language="JavaScript">

		function SubmitForm() {
			document.frm.action = "InternationalInterimJourney_Edit.jsp";
			document.frm.submit();
		}

		function checkData(f1) {

			if (document.frm.strDeptCity.value == ""){
				alert("Please enter departure city");
				document.frm.strDeptCity.focus();
				return false;
			}

			if (document.frm.strArrCity.value == ""){
				alert("Please enter arrival city");
				document.frm.strArrCity.focus();
				return false;
			}

			if (document.frm.strDeptDate.value == ""){
				alert("Please enter Reaching Date at Destination");
				document.frm.strDeptDate.focus();
				return false;
			}

			if (document.frm.strAirlineName.value == ""){
				alert("Please enter name of Airline");
				document.frm.strAirlineName.focus();
				return false;
			}
			if(document.frm.visa[1].checked)
			{
			   if(document.frm.visaComment.value=="")
				{
				  alert("Please fill the Visa Comment");
				  document.frm.visaComment.focus();
				  return false;
				}
          	}
	
				var todayDate  =  f1.todayDate.value;      // for current page
				var depDate    =  f1.strDeptDate.value;    // for current page
				var openerPageDepDate	 = window.opener.frm.depDate.value;       //parent page departure date
				var openerPageReturnDate = window.opener.frm.returnDate.value;  //parent page return date	
				
				var flag = checkDate(f1,todayDate,depDate,f1.todayDate,f1.strDeptDate,'Departure Date can not be smaller than the Today\'s Date ','no');
				if(flag == false) 
				{
				  return flag;
				}
				if(openerPageDepDate != null && openerPageDepDate != "")
				{
					flag = checkDate(f1,openerPageDepDate,depDate,f1.strDeptDate,f1.strDeptDate,'Intermediate Departure Date can not be smaller than the Actual  Departure Date ','no');
					if(flag == false) {
					  return flag;
					}
				}
				if(openerPageReturnDate != null && openerPageReturnDate != "")
				{
					var flag = checkDate(f1,depDate,openerPageReturnDate,f1.strDeptDate,f1.strDeptDate,'Intermediate Departure Date can not be grater than the Actual Departure Date ','no');
					if(flag == false) {
					  return flag;
					}
				}			
			return true;
		}


		function test1(obj1, length, str)
		{	
			var obj;

			if(obj1=='strDeptCity')
			{
				obj = document.frm.strDeptCity;
			}

			if(obj1=='strArrCity')
			{
				obj = document.frm.strArrCity;
			}

			if(obj1=='strAirlineName')
			{
				obj = document.frm.strAirlineName;
			}
			if(obj1=='visaComment')
          	{
         		 obj = document.frm.visaComment;
          	}

			charactercheck(obj,str);
			limitlength(obj, length);
			//zeroChecking(obj); //function for checking leading zero and spaces
			spaceChecking(obj);
		}

	function closeWindow(){
			window.opener.setId("<%= strInterimId%>");  
			window.opener.frm.action = "T_IntTrv_Details_Edit.jsp";
			window.opener.frm.submit();
			window.close();							
		}

function funConf()
{
if(confirm("Are you Sure you want to Delete This Record "))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function checkDate(form1,firstDate,secondDate,firstDateName,secondDateName,message1,message2)
{

	var todayDate=firstDate;                //today date
	//alert("firstDate is=="+todayDate);
	var dDate=secondDate;
	//alert("dob is"+DOB);

	var d=todayDate.substr(6,4);
	var year=parseInt(d,10);

	var a =todayDate.substr(3,2);
	var month=parseInt(a,10);

	var c =todayDate.substr(0,2);
	var day=parseInt(c,10);

    //get departure date information
	var f=dDate.substr(6,4);
	var year1=parseInt(f,10);

	var b=dDate.substr(3,2);
	var month1=parseInt(b,10);

	var h=dDate.substr(0,2);
	var day1=parseInt(h,10);
	
	if(year>year1)
	{
		 alert(message1);
		 secondDateName.value="";
		 secondDateName.focus();
		 return false;
	}//end of if
	
	if((year==year1)&&(month>month1))
	{
		 alert(message1);
		 secondDateName.value="";
		 secondDateName.focus();
		 return false;
	}//end of elseif
	
	if((year==year1)&&(month==month1)&&(day>day1))
	{		
		 alert(message1);
		 secondDateName.value="";
		 secondDateName.focus();
		 return false;
	}//end of elseif
}

function visaOnClick(f1)
{
	if(f1.visa[0].checked)
	{
		f1.visaComment.value="";
		f1.visaComment.disabled=true;
	}
	if(f1.visa[1].checked)
	{
		f1.visaComment.disabled=false;
		f1.visaComment.focus();
	}
}


</script>






</head>
<body> 


<form name="frm"  method="post" action="InternationalInterimJourney_Edit_Post.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="77%" class="bodyline-top">
	<ul class="pagebullet">
      <li class="pageHead">International Intermediate Destinations</li>
    </ul></td>	
  </tr>
</table>
<div align="center">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
       <td width="14" background="images/index_03.png?buildstamp=2_0_0"></td>
    </tr>
    
   </table>
  </td>
 </tr>
   <tr>
      <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
      <td height="20" colspan="2" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
      <td width="3" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
    </tr>
    <tr>
      <td height="20">&nbsp;</td>
      <td height="20" colspan="2">
	    <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
    <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0">
	<img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" />
	<span class="formTit">	Intermediate Destinations</span></td>
        <td align="right" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/help.png?buildstamp=2_0_0" width="44" height="16" border="0" onClick="MM_openBrWin('helpintrimjourneyinternational.html#100a','','scrollbars=yes,resizable=no,location=no,directories=no,toolbar=no,menubar=no,width=400,height=300,status=no,location=no')" />&nbsp;</td>
        <br>
            <td background="images/index_03.png?buildstamp=2_0_0"></td>
          </tr>
          <tr>
            <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
            <td colspan="2" valign="top" bgcolor="#ffffff">
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="0" bgcolor="#ffffff">
				    <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                                                                       <!--ITINERARY INFORMATION -->
                    <tr>
                      <td width="2%" align="left" valign="bottom" class="label1">&nbsp;</td>
                      <td width="28%" height="25" align="left" valign="bottom" class="label1">Departure City</td>
                      <td width="41%" height="25" align="left" valign="bottom" class="label1">Arrival City</td>
                      <td width="29%" align="left" valign="bottom" class="label1">Reaching Date <br />
                      at Destination</td>
                    </tr>
                    <tr>
                      <td align="left" valign="top">&nbsp;</td>
                      <td height="30" align="left" valign="top">
					    <input name="strDeptCity" type="text" class="textBoxCss" size="16"  value = "<%= strDCity %>" onKeyUp="return test1('strDeptCity', 16, 'c')" maxlength="30" />					  </td>
                      <td align="left" valign="top"><span class="label2">
                        <input name="strArrCity" type="text" class="textBoxCss" size="16" value="<%=strACity %>" onKeyUp="return test1('strArrCity', 16, 'c')" maxlength="30" />
                        </span>					  </td>
                      <td align="left" valign="top">
					    <input name="strDeptDate" type="text" class="textBoxCss" id="test2" size="6" onFocus="javascript:vDateType='DD/MM/YYYY'"
           				onkeyup="DateFormat(this,this.value,event,false,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
			        	onblur="DateFormat(this,this.value,event,true,'DD/MM/YYYY','Invalid Date.Please Re-Enter')"
          				onchange="javascript:while(''+this.value.charAt(this.value.length-1)==' ')this.value=this.value.substring(0,this.value.length-1);" />
                        <a href="javascript:show_calendar('frm.strDeptDate','a','a','DD/MM/YYYY');"
		            		onmouseover="window.status='Date Picker';return true;"
               				onmouseout="window.status='';return true;"><img src="images/calender.png?buildstamp=2_0_0"
				            name="imageField" border="0" align="absmiddle" id="imageField" /></a>
                       </input>
                       <script language="JavaScript" type="text/javascript">
			           	document.frm.strDeptDate.value = "<%= strDDate %>";
       				   </script>					  </td>
                    </tr>
                    <tr>
                      <td align="left" valign="bottom" class="label1">&nbsp;</td>
                      <td height="25" align="left" valign="bottom" class="label1">Mode</td>
                      <td height="25" align="left" valign="bottom" class="label1">Name of Airline/Train</td>
                      <td height="25" align="left" valign="bottom" class="label1">Class</td>
                    </tr>
                    <tr>
                      <td align="left" valign="top" class="label2">&nbsp;</td>
                      <td height="30" align="left" valign="top" class="label2">
					    <select name="strMode"   class="textBoxCss" onChange="javascript:SubmitForm();">
                          <option  value ="1" selected="selected">Air</option>
                          <option value="2">Train</option>
                        </select></td>
						<script>
						  document.frm.strMode.value="<%=strMode%>";
						</script>
                      <td height="30" align="left" valign="top" class="label2">
					    <input name="strAirlineName" type="text" class="textBoxCss" size="16" value="<%= strAirline %>" onKeyUp="return test1('strAirlineName', 16, 'cn')" maxlength="30" />					  </td>
                      <td height="30" align="left" valign="top" class="label2">
					    <select name="strClass" class="textBoxCss">
                          <% if (strMode.equals("1")) 
							strSql = "SELECT DISTINCT AIR_ID, ELIGIBILITY FROM M_AIRLINE_CLASS WHERE STATUS_ID=10";
							if (strMode.equals("2"))							
	                        strSql =   "SELECT DISTINCT TRAIN_ID, ELIGIBILITY FROM M_TRAIN_CLASS WHERE STATUS_ID=10";
							rs = dbConBean.executeQuery(strSql);
							while (rs.next()) {
						
						  %>
                           <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                          <%
                            }
		                    rs.close();	  
						  %>
                        </select>					  </td>
                    </tr>
					
					
					<tr>
                      <td align="left" valign="bottom" class="label1">&nbsp;</td>
                      <td height="25" align="left" valign="bottom" class="label1">Visa Required</td>
					  <!--<td height="25" align="left" valign="bottom" class="label1">Visa Comments</td>-->
                    </tr>
                    <tr>
					    <td >&nbsp;</td><td>&nbsp;</td>
                        <td height="25" align="left" valign="bottom"><span class="label2">Visa Comments</span></td>
                    </tr>
                    <tr>                                         
                      <td align="left" valign="top" class="label2" >                <!--VISA REQUIRED--></td>
                      <td valign="top" align="left" class="label2">
					    <input name="visa" type="radio" value="1" checked="checked" onClick="visaOnClick(this.form)"/>
					    Yes
					    <input name="visa" type="radio" value="2" onClick="visaOnClick(this.form)"/>No					  </td>
                      <td height="45" align="left" valign="top" class="label2"><!--VISA COMMENT-->
					    <textarea name="visaComment" disabled onKeyUp="return test1('visaComment', 100, 'all')" maxlength="200"><%=strVisaComment%></textarea>					  </td>
					  <script language="javascript">
                            var aa ="<%=strVisaRequired%>";
							if(aa != null && aa == "2")
							{
							  // alert("visa value no is=="+aa);
							   document.frm.visa[1].checked=true;
							   document.frm.visaComment.disabled=false;							   
							}							
                      </script>
                    </tr> 





                    <tr>
                      <td align="left" valign="top" class="label2">&nbsp;</td>
                      <td height="30" align="left" valign="top" class="label2">&nbsp;</td>
                      <td height="30" align="left" valign="top" class="label2">&nbsp;</td><br />
                      <td height="30" align="left" valign="top" class="label2">&nbsp;</td>
                    </tr>
	    			<tr align="center">	
		    		  <td height="30" colspan="4" align="center" class="label2">
					    <input name="add" type="submit" class="formbutton"  value="ADD" onclick ="return checkData(this.form);"/>					  </td>
					</tr>
                  </table>				</td>
              </tr>
            </table>	      </td>
          <td width="11" background="images/index_03.png?buildstamp=2_0_0"></td>
        </tr>
        <tr>
          <td width="14" height="20" background="images/index_04.png?buildstamp=2_0_0"><img src="images/index_04.png?buildstamp=2_0_0" width="14" height="20" /></td>
          <td height="20" colspan="2" background="images/index_05.png?buildstamp=2_0_0">&nbsp;</td>
          <td width="11" height="20" background="images/index_06.png?buildstamp=2_0_0"></td>
        </tr>
      </table>
	</td>
    <td height="20"></td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
    <td height="20" colspan="2">
	  <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
          <td height="29" align="left" background="images/headerBG.png?buildstamp=2_0_0"><img src="images/formTitIcon.png?buildstamp=2_0_0" width="30" height="29" align="absmiddle" /><span class="formTit">Intermediate Destinations Details </td>
          <td background="images/index_03.png?buildstamp=2_0_0"></td>
        </tr>
        <tr>
          <td width="14" background="images/index_01.png?buildstamp=2_0_0"></td>
          <td valign="top" bgcolor="#ffffff">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="0" bgcolor="#ffffff">
				  <table width="100%" border="0" cellspacing="1" cellpadding="3">
                    <tr class="formtr2">
                      <td class="formhead"><b>S.No</b></td>
                      <td class="formhead">Departure City</td>
                      <td class="formhead">Arrival City </td>
                      <td class="formhead">Departure Date </td><!-- 25/02/2007 -->
                      <td class="formhead">Mode</td>
                      <td class="formhead">Name of Airline/Train </td>
                      <td class="formhead">Class </td>
					  <td class="formhead">Visa Required </td>
					  <td class="formhead">Visa Comment </td>
                      <td class="formhead">Action </td>
                    </tr>

				<% 
				if(strUpdateFlag.equals("yes"))
				{
					strSql = "SELECT TRAVEL_FROM, TRAVEL_TO, TRAVEL_DATE,.DBO.TRAVEL_MODE_NAME(TRAVEL_MODE) AS TRAVELMODENAME, MODE_NAME,.DBO.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS) AS TRAVELCLASSNAME,VISA_REQUIRED,VISA_COMMENT,JOURNEY_ORDER FROM T_JOURNEY_DETAILS_INT  WHERE JOURNEY_ORDER>1 AND  TRAVEL_ID='"+strAcualTravelId+"' AND STATUS_ID=10 AND APPLICATION_ID = 1";
				}
				else
				{
				   strSql = "SELECT TRAVEL_FROM, TRAVEL_TO, TRAVEL_DATE, .DBO.TRAVEL_MODE_NAME(TRAVEL_MODE) AS TRAVELMODENAME, MODE_NAME,.DBO.TRAVEL_CLASS_NAME(TRAVEL_MODE,TRAVEL_CLASS) AS TRAVELCLASSNAME,VISA_REQUIRED,VISA_COMMENT, INTERIM_ID,PARENT_ID FROM T_INTERIM_JOURNEY  WHERE PARENT_ID ='"+strInterimId+"' AND APPLICATION_ID = 1";
				}
				String strVisaReq = "";      
				String strVisaCom = ""; 
				int intCount = 1;
				rs = dbConBean.executeQuery(strSql);
				while (rs.next()) {
				%>
                    <tr class="formtr2">
                      <td width="2%" class="formtr1"><%=intCount++%></td>
                      <td class="formtr1"><%= rs.getString("TRAVEL_FROM")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVEL_TO")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVEL_DATE")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVELMODENAME")%></td>
                      <td class="formtr1"><%= rs.getString("MODE_NAME")%></td>
                      <td class="formtr1"><%= rs.getString("TRAVELCLASSNAME")%></td>
                      <%
					     strVisaReq = rs.getString("VISA_REQUIRED");   
				         strVisaCom = rs.getString("VISA_COMMENT");
						 if(strVisaReq != null && strVisaReq.equals("1"))
					     {
					         strVisaReq = "Yes";
							 strVisaCom = "-";
						 }
						 else if(strVisaReq != null && strVisaReq.equals("2"))
					         strVisaReq = "No";
						 
						 
					  %>  
				     
					  <td class="formtr1"><%= strVisaReq%></td>
					  <td class="formtr1"><%= strVisaCom%></td>
<%
					if(strUpdateFlag.equals("yes"))
					{
%>
                      <td class="formtr1" onClick="return funConf();"> <A HREF="T_DeleteInterim.jsp?actualTravelId=<%=strAcualTravelId%>&journeyOrder=<%=rs.getString("JOURNEY_ORDER")%>&travelType=I">Delete </A></td>
<%                  }else
					{%>
                      <td class="formtr1" onClick="return funConf();"> <A HREF="T_DeleteInterim.jsp?interimID=<%= rs.getString("INTERIM_ID")%>&travelID=<%= rs.getString("PARENT_ID") %>&travelType=I">Delete </A></td>
                    <%}%>
                    </tr>
				<% 
				 }
				 rs.close();
				%>
				
                </table></td>
              </tr>
              <tr>
                <td align="center" bgcolor="#ffffff" class="newformbot"><span class="label2">
                  <input name="add2" type="button" class="formbutton"  value="Close" onclick ="closeWindow();"/>
                </span></td>
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
      <td height="20"></td>
    </tr>
  </table>
<INPUT type = "hidden" name = "travel_id" value="<%= strInterimId%>"/>
<input type="hidden" name="todayDate" value="<%=strCurrentDate%>"/> <!--  HIDDEN FIELD  -->
<INPUT TYPE = "hidden" name = "interimTravelId" value = "<%= strInterimId %>" />
<INPUT TYPE = "hidden" name = "actualTravelId" value = "<%= strAcualTravelId %>" />

</form>
</body>
</form>
</div>
</html>
