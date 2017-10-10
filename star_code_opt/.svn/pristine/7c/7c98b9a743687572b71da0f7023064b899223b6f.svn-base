 	
	<%@ include file="importStatement.jsp" %>
	<!-- Header -->
	<%
	/***************************************************
	*Copyright (C) 2000 MIND 
	*All rights reserved.
	*The information contained here in is confidential and 
	*proprietary to MIND and forms the part of the MIND 
	*CREATED BY		:	ROHIT GANJOO
	*Date			:   06/09/2006
	*Description	:	APPROVAL SCREEN
	*Modified By	:	****************
	*Project		: 	STAR
	**********************************************************/
	 /******************************************************
	 Project 				:STAR
	 Name					:Manoj Chand
	 Dated					:16/12/2010	
	 Modification			:To disable Submit button after first click and show process bar during processing
	 
	 Name					:Manoj Chand
	 Dated					:12/05/2011	
	 Modification			:To change color of ) symbol from red to blue
	 
	 Name					:Manoj Chand
	 Dated					:23/11/2011	
	 Modification			:To resolve problem of price details shown to creater of request when he is also in first level approver
	 
	 Name					:Manoj Chand
	 Dated					:12/01/2012	
	 Modification			:To allow return and reject without asking to enter airline and price details
	 						 in case on pricing through to non-mata resource enable
	 						 
	 Modified By			:Manoj Chand
	 Date of Modification	:02 May 2012	
	 Modification			:Showing international/domestic requests for reviewers to either view or take action
	 *******************************************************/
	%>
	<%@ page pageEncoding="UTF-8"  %>
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
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"></jsp:useBean>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<Script>
	function isLegal(txt) {
	var invalids = "~"
	for(i=0; i<invalids.length; i++) {
	if(txt.indexOf(invalids.charAt(i)) >= 0 ) {
	return false;
	}
	        }
	return true;
	}
	</Script>
	<SCRIPT LANGUAGE="JavaScript">
	
	/*@Gaurav 27-Feb-2007 changes for making Comments (textarea) should persist the value of new added comments*/
	var comment_chng_flag=0;
	function changeTxtArea(obj){
		var commentTxt = obj.value;
		commentTxt = commentTxt.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		if(commentTxt != "" && (commentTxt == '<%=dbLabelBean.getLabel("message.approverequest.approvedby",strsesLanguage)%> <%=sUserFirstName%> <%=sUserLastName%>' 
				|| commentTxt == '<%=dbLabelBean.getLabel("message.approverequest.returnedby",strsesLanguage)%> <%=sUserFirstName%> <%=sUserLastName%>' 
				|| commentTxt == '<%=dbLabelBean.getLabel("message.approverequest.rejectedby",strsesLanguage)%> <%=sUserFirstName%> <%=sUserLastName%>')) {
			comment_chng_flag=0;
		} else {
			comment_chng_flag=1;
		}
	
	return comment_chng_flag ; // New flag added Sanjay Mishra on 16/02/07 for traking changes in textarea 
	}
	
	function typeData(revFlag,revName)
	{
	//@Gaurav 27-Feb-2007
	if(comment_chng_flag==0)
		{
		if(revFlag=='Y')
			document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("message.approverequest.approvedby",strsesLanguage)%> '+ revName;
		else
		document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("message.approverequest.approvedby",strsesLanguage)%> <%=sUserFirstName%> <%=sUserLastName%>';
		}
	}
	
	function typeData1()
	{
	if(comment_chng_flag==0)
		{
		document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("message.approverequest.returnedby",strsesLanguage)%> <%=sUserFirstName%> <%=sUserLastName%>';
		}
	
	}
	
	function typeData2()
	{
	if(comment_chng_flag==0)
		{
			document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("message.approverequest.rejectedby",strsesLanguage)%> <%=sUserFirstName%> <%=sUserLastName%>';
		}
	}
//ADDED BY MANOJ CHAND ON 02 MAY 2012 TO SHOW COMMENT FOR PASS ACTION 
	function typeData3()
	{
	if(comment_chng_flag==0)
		{
			document.frm.COMMENTS.value='<%=dbLabelBean.getLabel("message.approverequest.passedby",strsesLanguage) %> <%=sUserFirstName%> <%=sUserLastName%>';
		}
	}

	
	function submitConfirm()
	{
	var com=document.frm.COMMENTS.value;
	
	if(isLegal(com)) {
	}else{
	alert('<%=dbLabelBean.getLabel("alert.approverequest.invalidcharactermsg",strsesLanguage)%>');
	return false;
	}
 	 
 //document.getElementById("rad").checked is added by manoj chand on 12 jan 2012 to prevent validation for return and reject
	if(document.frm.ISgridshow.value=='y' && document.getElementById("rad").checked==true){ 

		 if(document.frm.finalAirline.value=='')
		 	{ 
		 	alert('<%=dbLabelBean.getLabel("alert.global.airlinename",strsesLanguage)%>'); 
		 	document.frm.finalAirline.focus();
		 	return false;
		 }
		 if(document.frm.finalPrice.value=='')
		 	{ 
		 	alert('<%=dbLabelBean.getLabel("alert.approverrequest.finalprice",strsesLanguage)%>');
		 	document.frm.finalPrice.focus();
		 	return false;
		 }
		 if(document.frm.finalremarks.value=='')
		 	{ 
		 	alert('<%=dbLabelBean.getLabel("alert.approverrequest.yourremarks",strsesLanguage)%>');
		 	document.frm.finalremarks.focus(); 
		 	return false;
		 }
	 }
	
	var com=document.frm.COMMENTS.value;
	if(com=='')
	{
	alert('<%=dbLabelBean.getLabel("alert.approverequest.yourcomments",strsesLanguage)%>');
	document.frm.COMMENTS.focus();
	return false;
	}
	else
	{
	if(confirm('<%=dbLabelBean.getLabel("alert.approverequest.onsubmitmessage",strsesLanguage)%>')){
		return true;
	}else 
		return false;
	}
	}

	function openWaitingProcess()
	{
			var dv = document.getElementById("waitingData");
			if(dv != null)
			{
				var xpos = screen.availHeight/2+90;
				var ypos = screen.availWidth/2-490;   
				
				dv.style.display="block";       		
				dv.style.left=(xpos+10)+'px';
				dv.style.top=(ypos)+'px';
				document.getElementById("waitingData").style.visibility="";
			}
	}

	function closeDivRequest()
	{
		document.getElementById("waitingData").style.visibility="hidden";	
	}

	function disablebut()//added by manoj
	{			
		var a = submitConfirm();
		if ( a == false ) 
		{
		    return false; 
		} 
		else 
		{	
			openWaitingProcess();
			document.getElementById("sub1").disabled=true;
			document.frm.action="T_fmRequisitionApproveByUser.jsp";
			document.frm.submit();
		} 
	}

	
	//-->
	</SCRIPT>
	<script>
	function MM_openBrWindow(theURL,winName,features) 
	{ 
	window.open(theURL,winName,features);
	}
	 function CheckData()
	 {
		 if(document.frm1.TRANSCOMMENTS.value=="")
		 {
			 alert('<%=dbLabelBean.getLabel("alert.global.pleaseenterthecomments",strsesLanguage)%>');		
			 document.frm1.TRANSCOMMENTS.focus();
			 return false;
		 }
		 else if(document.frm1.delName.value=="")
		 {
			 alert('<%=dbLabelBean.getLabel("alert.approverequest.delegate",strsesLanguage)%>');		 
			 document.frm1.delName.focus();
			 return false;
		 }
		 else
		{

			if(confirm('On submitting you agree to the status of this Requisition.\nThe requisition will be transfered to selected delegate   and will be available to you after his approval.\nOnce submitted the Requisition Status cannot be reversed !'))
			{
				return true;
			}
			else{
				return false;
			}

		
			
		}
	}
	
	function test1(obj1, length, str)
	{
		var obj;
	 	if(obj1=='COMMENTS')
	 	{
	 		obj = document.frm.COMMENTS;
	 		upToTwoHyphen(obj);
	 	}
		charactercheck(obj,str);
		limitlength(obj, length);
		//zeroChecking(obj);
		spaceChecking(obj);//added for preventing starting spaces on 05-Jul-07 by shiv  
	}
	</script>
	
	</head>
	<%
	String strTravelId		= request.getParameter("purchaseRequisitionId");
	String strTravellerId	= request.getParameter("traveller_Id");
	String strTravelType    = request.getParameter("travel_type");
	Connection con				=		null;			    // Object for connection
	Statement stmt				=		null;			   // Object for Statement
	ResultSet rs				=		null;			  // Object for ResultSet
	con=dbConBean.getConnection();
	String	 sSqlStr	=	"";
	String strApproverName		=  "";
	String strReveiwFlag="N";
	//added by manoj chand on 08 may 2012 to show original approver name in comment box during request approve by reviewer.	
	sSqlStr="SELECT DBO.[user_name](APPROVER_ID) AS APPROVER FROM T_APPROVERS WHERE T_APPROVERS.PAP_APPROVER='"+Suser_id+"' AND T_APPROVERS.TRAVEL_ID='"+strTravelId+"' AND T_APPROVERS.TRAVEL_TYPE='"+strTravelType+"' AND TRAVELLER_ID='"+strTravellerId+"' AND APPROVE_STATUS=0";
	stmt = con.createStatement(); 
	rs = stmt.executeQuery(sSqlStr);
	if(rs.next())
	{
		strApproverName	 =	rs.getString("APPROVER");
		strReveiwFlag="Y";
	}
	rs.close();
	stmt.close();
	
	%>
	
	 <body onLoad="typeData('<%=strReveiwFlag %>','<%=strApproverName %>');" scroll="yes"> 
	
	<div id="waitingData" style="visibility:hidden;padding: 0px ;
margin : 0px ;
border: 0px ;
position : absolute ;
overflow-x : auto ;
overflow-y : none ;
width: 40% ;
height: 40% ;
left: 317px ;
top: 70px ;"> 	 
		 	<img src="images/loading16.gif?buildstamp=2_0_0" width="50" height="51" border="0" /> 
		 	<br>     
	 	<font color="#000080" class="pageHead">'<%=dbLabelBean.getLabel("label.global.pleasewait",strsesLanguage)%>'</font>    
		</div>
	
	<%
	
	
	String strTransFlag				=	"";
	String strDisabled				=	"";
	String strApproveLabel			=	dbLabelBean.getLabel("label.approverequest.approve",strsesLanguage);
	String strApproverId			="";
	String strTempflag				="no";
	
	//Added by sachin on 7 th March 2007
	String strFlag = request.getParameter("AllTravelPageFlag")==null ?"no" : request.getParameter("AllTravelPageFlag");
	//Added by manoj chand on 02 May 2012
	String strspFlag=request.getParameter("spflag")==null ?"n" : request.getParameter("spflag");
	//System.out.println("strspFlag--approvereturnrequistion.jsp-->"+strspFlag);
	if(strspFlag.trim().equals("y")){
		strDisabled="disabled";
	}
	
	
	rs=null;
	sSqlStr="SELECT  DISTINCT ISNULL(RTRIM(TRANSFLAG),' ') FROM T_APPROVERS WHERE ORDER_ID=(SELECT MIN(ORDER_ID) FROM T_APPROVERS WHERE APPROVE_STATUS=0 AND STATUS_ID=10 AND TRAVEL_ID='"+strTravelId+"' AND TRAVELLER_ID='"+strTravellerId+"') AND TRAVEL_ID='"+strTravelId+"'AND TRAVELLER_ID='"+strTravellerId+"'";
	
		stmt = con.createStatement(); 
		rs = stmt.executeQuery(sSqlStr);
		if(rs.next())
		{
				strTransFlag	 =	rs.getString(1);
		}
		rs.close();
		stmt.close();
	
		if(strTransFlag.equals("Y"))
		{
			strDisabled="disabled";
			strApproveLabel=dbLabelBean.getLabel("message.approverequest.returnthisrequest",strsesLanguage);
		}
		
		//code added by manoj chand on 23 Nov 2011 to resolve problem of price list showing to creater of request when he is in first approval level
		sSqlStr="select approver_id from T_APPROVERS where T_APPROVERS.TRAVEL_ID="+strTravelId+" and T_APPROVERS.STATUS_ID=10 and T_APPROVERS.APPROVE_STATUS=0 and T_APPROVERS.ORDER_ID=1 and T_APPROVERS.TRAVEL_TYPE='"+strTravelType+"'";
		//System.out.println("sSqlStr-23-->"+sSqlStr);
		stmt = con.createStatement(); 
		rs = stmt.executeQuery(sSqlStr);
		if(rs.next())
		{
			strApproverId	 =	rs.getString(1);
		}
		rs.close();
		stmt.close();
		if(strApproverId.equalsIgnoreCase(Suser_id)){
			strTempflag="yes";
		}
		
	
	%>
	 <!--For Section 1 First half--> 
	<table width="90%" align="center" style="margin:0 auto;" border="0" cellpadding="5" cellspacing="1" class="formborder">
	  <form method=post action="T_fmRequisitionApproveByUser.jsp" name=frm target=_parent>
	  <input type=hidden name="purchaseRequisitionId" value="<%=strTravelId%>">
	  <input type=hidden name="traveller_Id" value="<%=strTravellerId%>">
	  <input type=hidden name="travel_type" value="<%=strTravelType%>">
	
	  <input type="hidden" name="AllTravelPageFlag" value="<%=strFlag%>"/><!--Flag for finding the page-->
		<%
		String flag			="";
		String table		="";
		String strCreatorid ="";
		String strISgridshow	="";
		if(strTravelType.equals("I")){
			table="T_TRAVEL_DETAIL_INT";
		}else{
			table="T_TRAVEL_DETAIL_DOM";
		}
		
		sSqlStr=" SELECT   ISNULL(TK_PROVIDER_FLAG,'y') as  TK_PROVIDER_FLAG,c_userid"+
		" FROM         "+table+" 		WHERE     (TRAVEL_ID = "+strTravelId+")";
		stmt = con.createStatement();  
		rs = stmt.executeQuery(sSqlStr);
		
		while(rs.next()){ 
			flag			=	rs.getString("TK_PROVIDER_FLAG").trim();
			strCreatorid	=	rs.getString("c_userid").trim();
		}rs.close();
		stmt.close();
		
	//	System.out.println("flag================"+flag);

	
		 if(flag.equalsIgnoreCase("n") && ( strCreatorid.equals(Suser_id) || SuserRole.equals("MATA")) && strTempflag.equalsIgnoreCase("no")) 	
			 {

            strISgridshow="y";    
		 }
		
		//System.out.println("flag--->"+flag);
		//System.out.println("strCreatorid--->"+strCreatorid);
		//System.out.println("Suser_id--->"+Suser_id);
		//System.out.println("SuserRole--->"+SuserRole);
		 
		 
	if(flag.equalsIgnoreCase("n") && ( strCreatorid.equals(Suser_id) || SuserRole.equals("MATA")) && strTempflag.equalsIgnoreCase("no")){	 
		 
	%>
	<input type="hidden" name="flagforMataprice" value="<%=flag%>" />
 	<tr align="left" valign="top" class="formtr2">   
	<td colspan="4"> 
	<table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="formborder">
	  <tr width="100%" class="formhead">
	    <td colspan=11 align="left" valign="top"  height="2"><%=dbLabelBean.getLabel("label.requestdetails.pricedetails",strsesLanguage) %></td>
	  </tr>	
	  <tr class="formhead">
	    <td class="listhead" width="2%" align="left" valign="top" height="3">#</td>
		<td class="listhead" width="10%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.airlinename",strsesLanguage)%></td>
		<td class="listhead" width="24%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%></td>
		<td class="listhead" width="24%"><%=dbLabelBean.getLabel("label.createrequest.remarks",strsesLanguage)%></td>
	  </tr>
	<%
			String strCommentId		=	null;
			String strAirline		=	null;
			String strCurrency		=	null;
			String strAmount		=	null;
		    String strRemarks			=	""; 
			String strOriginatedUserId=	"";
			
			//System.out.println("strTravelType======"+strTravelType);
			
			if(strTravelType.equals("I")){ 
	
			sSqlStr=" SELECT   TK_AIRLINE_NAME, TK_CURRENCY, TK_AMOUNT, TK_REMARKS "+
					" FROM         T_TRAVEL_DETAIL_INT 		WHERE     (TRAVEL_ID = "+strTravelId+")";
			}else{
				sSqlStr=" SELECT   TK_AIRLINE_NAME, TK_CURRENCY, TK_AMOUNT, TK_REMARKS "+
				" FROM         T_TRAVEL_DETAIL_DOM 		WHERE     (TRAVEL_ID = "+strTravelId+")";
				
			}
 		//System.out.println("strTravelType==1===="+sSqlStr);
		 String strStyleCls="";
		 int iCls=0;

		 
		stmt = con.createStatement();  
		rs = stmt.executeQuery(sSqlStr);
		 int intSno=1;
		 if(rs.next())
		 {
			do
			 {
				 strAirline			=	rs.getString("TK_AIRLINE_NAME").trim();
				 strCurrency		=	rs.getString("TK_CURRENCY");
				 strAmount			=	rs.getString("TK_AMOUNT");
				 strRemarks			=	rs.getString("TK_REMARKS");
				 
				 
	         	 if (iCls%2 == 0) { 
	        		strStyleCls="formtr2"; 
	             } else { 
	    		 strStyleCls="formtr1";
	             } 
	      	     iCls++;
	      	     String strCurrency1=""; 
	      	   if(strAirline.equals("")){  
	      		     strCurrency1=""; 
	      			 strAmount="";
	 		    }
				%>
					<tr class="<%=strStyleCls%>">  
						
						<td class="listdata" width="8%" align="left" valign="top"><%=dbLabelBean.getLabel("label.global.localprice",strsesLanguage)%></td>
						<td class="listdata" width="10%" align="left" valign="top"><%=strAirline%></td>
						<td class="listdata" width="24%" align="left" valign="top"><%=strCurrency1%>  &nbsp;<%=strAmount%></td>
						 
						<td class="listdata" width="24%"><%=strRemarks%></td> 
					</tr>
				<%
			 }while(rs.next());
		 }
		 rs.close();          // close the result set 	 
	%>
	 </tr>
	<%
			 
			String strAirlineMATA		=	null;
			String strCurrencyMATA		=	null;
			String strAmountMATA		=	null;
		    String strRemarksMATA			=	""; 
			 
			
			//System.out.println("strTravelType======"+strTravelType);
			
			if(strTravelType.equals("I")){ 
	
			sSqlStr=" SELECT   TK_AIRLINE_NAME_MATA,   TK_AMOUNT_MATA, TK_REMARKS_MATA "+
					" FROM         T_TRAVEL_DETAIL_INT 		WHERE     (TRAVEL_ID = "+strTravelId+")";
			}else{
				sSqlStr=" SELECT   TK_AIRLINE_NAME_MATA,   TK_AMOUNT_MATA, TK_REMARKS_MATA "+
				" FROM         T_TRAVEL_DETAIL_DOM 		WHERE     (TRAVEL_ID = "+strTravelId+")";
				
			}
		 
		 
			 //System.out.println("sSqlStr===222==="+sSqlStr);
		 int iCls1=0;

		 
		stmt = con.createStatement();  
		rs = stmt.executeQuery(sSqlStr);
		 int intSno1=1;
		 if(rs.next())
		 {
			do
			 {
				strAirlineMATA			=	rs.getString("TK_AIRLINE_NAME_MATA");
				//strCurrencyMATA		=	rs.getString("TK_CURRENCY_MATA");
				strAmountMATA			=	rs.getString("TK_AMOUNT_MATA");
				strRemarksMATA			=	rs.getString("TK_REMARKS_MATA");
				 
				 
	         	 if (iCls%2 == 0) { 
	        		strStyleCls="formtr2";
	             } else {  
	    		 strStyleCls="formtr1";
	             } 
	      	     iCls++;
	      	      
				%>
					<tr class="<%=strStyleCls%>">  
						
						<td class="listdata" width="8%" align="left" valign="top"><%=dbLabelBean.getLabel("label.requestdetails.mataprice",strsesLanguage)%></td>
						<td class="listdata" width="10%" align="left" valign="top"><%=strAirlineMATA%></td>
						<td class="listdata" width="24%" align="left" valign="top"><%=strCurrency%>  &nbsp;<%=strAmountMATA%></td>
						 
						<td class="listdata" width="24%"><%=strRemarksMATA%></td>
					</tr>
				<%
			 }while(rs.next());
		 }
		 rs.close();          // close the result set 	 
	%>
	 
	  <tr class="<%=strStyleCls%>">    
						
						<td class="listdata" width="8%" align="left" valign="top"><%=dbLabelBean.getLabel("label.requestdetails.finalprice",strsesLanguage)%></td>    
						<td class="listdata" width="10%" align="left" valign="top"  ><input type="text" name="finalAirline" size="15" class="textBoxCss" onKeyUp="return test1(this, 30, 'cn')"></td>
						<td class="listdata" width="27%" align="left" valign="top"><%=strCurrency%>  &nbsp;<input type="text" name="finalPrice" size="10" class="textBoxCss" onKeyUp="return test1(this, 30, 'n')">
						&nbsp; &nbsp;<%=dbLabelBean.getLabel("label.approverequest.buyfrom",strsesLanguage)%> &nbsp; &nbsp;<select name="finalbuyer"  class="textBoxCss">
						<option value="MATA" ><%=dbLabelBean.getLabel("label.createrequest.mata",strsesLanguage)%></option>
						<option value="Locally" ><%=dbLabelBean.getLabel("label.approverequest.locally",strsesLanguage)%></option>
						</select>
						
						
						</td> 
						 
						<td class="listdata" width="24%"><input type="text" name="finalremarks" size="30" class="textBoxCss"  onKeyUp="return test1(this, 100, 'cn')"></td> 
					</tr>  
						<!-- <td class="listdata" width="24%" colspan="4" align="center"><input type="button" value="submit"   ></td> -->
		</table>
	</td>
	  
	</tr>
	<%} %>	
	<input type="hidden"  name="ISgridshow" value="<%=strISgridshow%>" >
	<input type="hidden" name="flagforthis" value="<%=flag%>" />
	  <tr align="left" valign="top" > 
	    <td class="formtr2"  valign="top" align="left" width="30%">
	    <input type=radio name=rad value="APPROVE" checked onClick="typeData('<%=strReveiwFlag %>','<%=strApproverName %>');"> <%=strApproveLabel%>
	    <%if(strspFlag.trim().equals("y")){ %>
		<hr><input type=radio name=rad value="PASS" onClick="typeData3();"> <%=dbLabelBean.getLabel("label.approverequest.pass",strsesLanguage)%>
		<%} %>
		</td>
	    <td class="formtr1" align="center" width="40%">
	    	<textarea cols=53 class="textBoxCss" rows=3 NAME=COMMENTS onChange="changeTxtArea(this);" onKeyUp="test1('COMMENTS',500,'txt');"></textarea>
<!--	    	<center><div id="waitingData" style="visibility:hidden;"> 	  -->
<!--		 	<img src="images/loading16.gif?buildstamp=2_0_0" width="40" height="41" border="0" /> -->
<!--		 	<br>      -->
<!--		 	<font color="#000080" class="pageHead">Please wait ...</font>    -->
<!--		</div></center>-->
	    	
	    	</td>  
		<td class="formtr2" align="left" width="30%"> 
	<%
		if(strTransFlag.equals("Y"))
		{
		}
		else
		{
	%>
		 <input type=radio name=rad value="RETURNED FROM WORKFLOW" onClick="typeData1();" <%=strDisabled%>> <%=dbLabelBean.getLabel("label.approverequest.return",strsesLanguage)%> ( <%=dbLabelBean.getLabel("label.approverequest.forreview",strsesLanguage)%> )  <hr>	 <input type=radio name=rad value="REJECT" onClick="typeData2();" <%=strDisabled%>><%=dbLabelBean.getLabel("label.approverequest.reject",strsesLanguage)%> ( <font color=red><b><%=dbLabelBean.getLabel("label.approverequest.permanently",strsesLanguage)%></b></font> )
	<%
		}
	%>
		 </td>  
	  </tr>
	
	    <tr align="left" valign="top" colorPink> 
	    <td class="formbottom" valign="middle" align="center" colspan=3>
		<input class="formbutton" type=button name=close value="<%=dbLabelBean.getLabel("button.approverequest.closewindow",strsesLanguage)%>" onClick="javascript:top.window.close();">
		<input class="formbutton" type=button name=sub value="<%=dbLabelBean.getLabel("button.approverequest.requestmoreinfo",strsesLanguage)%>" <%=strDisabled%> onClick="MM_openBrWindow('reqRequestMoreInfo.jsp?strTravelId=<%=strTravelId%>&ReqTyp=<%=strTravelType%>','REQUESTMOREINFO','scrollbars=no,resizable=no,width=775,height=350')">
		<input class="formbutton" type=Submit id="sub1" name=sub value="<%=dbLabelBean.getLabel("button.approverequest.submit",strsesLanguage)%>" onClick=" return  disablebut();">
		
		</td>
		</tr>

	</table>
	<br>
</form>
 