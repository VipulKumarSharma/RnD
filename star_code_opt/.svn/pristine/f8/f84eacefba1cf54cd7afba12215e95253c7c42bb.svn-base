	<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Manoj Chand
	 *Date of Creation 		:07 Mar 2013
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STARS
	 *Operating environment :Tomcat 6.0, sql server 2008 
	 *Description 			:This is first jsp file  for edit the COMPANY in M_COMPANY table of STAR database
	 *Modified By			:Manoj Chand
	 *Date of Modification	:23-Aug-2013
	 *Modification			:add textarea to add xml parameter string for ERP web service
	 
	 *Modified By			:Manoj Chand
	 *Date of Modification	:22 Oct 2013
	 *Modification			:javascript validation to stop from typing --,'  symbol is added.
	*******************************************************/%>
	<%-- Import Statements  --%>
	<%@ include  file="importStatement.jsp" %>
	<%@ page import = "src.connection.DbConnectionBean" pageEncoding="UTF-8" %>
	
	<html>
	<head>
	<%-- include remove cache  --%>
	<%@ include  file="cacheInc.inc" %>
	<%-- include header  --%>
	<%@ include  file="headerIncl.inc" %>
	<%-- include page with all application session variables --%>
	<%@ include  file="application.jsp" %>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	
	<script language=Javascript src="scriptLibrary/FormCheck.js?buildstamp=2_0_0"></script>
	<script language="Javascript" src="scriptLibrary/date-picker.js?buildstamp=2_0_0"></script>
	<link href="scripts/main.css?buildstamp=2_0_0" rel="stylesheet" type="text/css" />
	<script language=JavaScript src="ScriptLibrary/jQueryMaster.js?buildstamp=2_0_0"></script>
	<script>
	//this function is added by manoj chand on 22 oct 2013 to implement javascript validation.
	function test1(obj1, length, str)
	{	
		var obj;
		if(obj1=='Companyname')
		{
			obj = document.frm.Companyname;
		}
		if(obj1=='wsurl')
		{
			obj = document.frm.wsurl;
			upToTwoHyphen(obj);
		}
		if(obj1=='erpwsurl')
		{
			obj = document.frm.erpwsurl;
			upToTwoHyphen(obj);
		}
		if(obj1=='erpxmldata')
		{
			obj = document.frm.erpxmldata;
			upToTwoHyphen(obj);
		}
		charactercheck(obj,str);
		zeroChecking(obj);
	}
	
	function checkData()
	{
		var strCompName= document.frm.Companyname.value;
		if(strCompName=='')
		{
		alert('<%=dbLabelBean.getLabel("alert.company.pleaseentercompanyname",strsesLanguage)%>');
		document.frm.Companyname.focus();
		return false;
		}
		else
		{
			var var_erpxml = document.frm.erpxmldata.value;
			if(var_erpxml!=''){
				var flag = validateXML(document.frm.erpxmldata.value);
				return flag;
			}
			return true;
		}
		
	 }

	//function adde by manoj chand on 05 feb 2013 to test web service status
	function checkWS(flagval)
	{
		var path='';
		if(flagval=='MATA'){
			path=document.frm.wsurl.value;
		}else{
			path=document.frm.erpwsurl.value;	
		}
		if(path.trim()==''){
			//alert('Please enter web service url before test');
		}else{
		var urlAjax = "AjaxMaster.jsp";
		var param = 'strFlag=testWS&path='+path.trim()+'?wsdl';
		 jQuery.ajax({  
	         type: "post",           
	         url:  urlAjax,    
	         data: param,
	         success: function(result){
	        	 var rslt = result.replace(/^\s+|\s+$/g,"");
	        	 if(rslt == "Y")
	        	 {
	        		 alert('<%=dbLabelBean.getLabel("alert.company.webservicework",strsesLanguage)%>'); 
	        	 }
	        	 else
	        	 {
	        		 alert('<%=dbLabelBean.getLabel("alert.company.webservicenotwork",strsesLanguage)%>');
	        	 }
	         },    
		    error: function(result){  
		     	alert("Error ...");
		     }
		 });
		}
	}
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	};
	</script>

<script>
	var xt="",h3OK=1;
	function checkErrorXML(x)
	{
	xt="";
	h3OK=1;
	checkXML(x);
	}
	 
	function checkXML(n)
	{
	var l,i,nam;
	nam=n.nodeName;
	if (nam=="h3")
	    {
	    if (h3OK==0)
	        {
	        return;
	        }
	    h3OK=0;
	    }
	if (nam=="#text")
	    {
	    xt=xt + n.nodeValue + "\n";
	    }
	l=n.childNodes.length;
	for (i=0;i<l;i++)
	    {
	    checkXML(n.childNodes[i]);
	    }
	}
	 
	function validateXML(txt)
	{
		var output = false;
	// code for IE
	if (window.ActiveXObject)
	  {
	  var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
	  xmlDoc.async="false";
	  xmlDoc.loadXML(txt);
	 
	  if(xmlDoc.parseError.errorCode!=0)
	    {
	    txt="Error Code: " + xmlDoc.parseError.errorCode + "\n";
	    txt=txt+"Error Reason: " + xmlDoc.parseError.reason;
	    txt=txt+"Error Line: " + xmlDoc.parseError.line;
	    alert(txt);
	    }
	  else
	    {
	    //alert("No errors found");
	    output = true;
	    }
	  }
	// code for Mozilla, Firefox, Opera, etc.
	else if (document.implementation.createDocument)
	  {
	var parser=new DOMParser();
	var text=txt;
	var xmlDoc=parser.parseFromString(text,"text/xml");
	 
	if (xmlDoc.getElementsByTagName("parsererror").length>0)
	    {
	    checkErrorXML(xmlDoc.getElementsByTagName("parsererror")[0]);
	    alert(xt)
	    }
	  else
	    {
	    //alert("No errors found");
	    output = true;
	    }
	  }
	else
	  {
	  alert('Your browser cannot handle XML validation');
	  }
	return output;
	}
</script>
	
	
</head>
	<%
	// Variables declared and initialized
	ResultSet objRs			=		null;			  // Object for ResultSet
	String	strCompanyName			=	null;	// Variable for storing site name
	String	strSqlStr	=	""; // For sql Statements
	String  strCompanyId	="";	
	strCompanyId			=	request.getParameter("cmpId"); // GET SITE ID
	String strImplDate ="";
	String strMATAWsUrl	="";
	String strERPWsUrl ="";
	String strERPxml ="";
	strSqlStr="SELECT CID,COMPANY_NAME,MATA_WS_URL,ERP_WS_URL,dbo.CONVERTDATE(C_DATE) AS C_DATE,ISNULL(ERP_XML,'') AS ERP_XML from dbo.M_COMPANY mc WHERE mc.STATUS_ID=10 and mc.CID="+strCompanyId;
		objRs	 = dbConBean.executeQuery(strSqlStr);
		if(objRs.next())
		{
				strCompanyName=objRs.getString("COMPANY_NAME");
				strMATAWsUrl		= objRs.getString("MATA_WS_URL");
				strERPWsUrl		= objRs.getString("ERP_WS_URL");
				strERPxml		= objRs.getString("ERP_XML");
		}
	objRs.close();
	
	%>
	<body><script type="text/javascript" language="Javascript1.2" src="menu/menu_cnt.js?buildstamp=2_0_0"></script>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="77%" height="38" class="bodyline-top">
		<ul class="pagebullet">
	      <li class="pageHead"><%=dbLabelBean.getLabel("label.company.company",strsesLanguage)%></li>
	    </ul></td>	
		<td width="23%" height="38" align="right" valign="bottom" class="bodyline-top">
		<table align="right" border="0" cellspacing="0" cellpadding="0">
	      <tr align="right">
	      <td>
	      <ul id="list-nav">
	      <li><a href="M_companyList.jsp"><%=dbLabelBean.getLabel("label.global.list",strsesLanguage)%></a></li>
	      </ul>
	      </td>             
	      </tr>
	    </table>
		</td>
	  </tr>
	</table>
	<!-- Start of Form -->
	<form method="post" name="frm" action="M_companyEditPost.jsp" onSubmit="javascript:return checkData();">
	<table width="70%" align="center" style="margin-left: auto;margin-right: auto;" border="0" cellpadding="5" cellspacing="1" class="formborder">
		
	<tr align="left"> 
	<td class="formtr2" width="24%"><%=dbLabelBean.getLabel("label.global.companyname",strsesLanguage)%></td>	<!-- SITE NAME -->
	<td width="76%"class="formtr1"><input type="text" size="30" maxlength="200" name="Companyname" value="<%=strCompanyName%>" class="textBoxCss" onKeyUp="return test1('Companyname', 30, 'c')"> </td>
	</tr>
    <tr align="left">
      <td class="formtr2" width="24%">MATA <%=dbLabelBean.getLabel("label.master.webserviceurl",strsesLanguage)%></td>
      <td width="76%" class="formtr1">
      	<input type="text" size="60" maxlength="250" name="wsurl" value="<%=strMATAWsUrl %>" class="textBoxCss" onKeyUp="return test1('wsurl',200, 'all')">&nbsp;<a href="#" onclick="checkWS('MATA')"><%=dbLabelBean.getLabel("label.company.testservice",strsesLanguage) %></a>
      </td>
    </tr>
    <tr align="left">
      <td class="formtr2" width="24%"><%=dbLabelBean.getLabel("label.master.erpwebserviceurl",strsesLanguage)%></td>
      <td width="76%" class="formtr1">
      	<input type="text" size="60" maxlength="250" name="erpwsurl" value="<%=strERPWsUrl %>" class="textBoxCss" onKeyUp="return test1('erpwsurl',200, 'all')">&nbsp;<a href="#" onclick="checkWS('ERP')"><%=dbLabelBean.getLabel("label.company.testservice",strsesLanguage) %></a>
      </td>
    </tr>
    <tr align="left">
      <td class="formtr2" width="24%"><%=dbLabelBean.getLabel("label.company.erpxmldata",strsesLanguage)%></td>
      <td width="76%" class="formtr1">
      	<span style="float: left;">
      	<textarea rows="3" cols="44" name="erpxmldata" onKeyUp="return test1('erpxmldata',300, 'xml')"><%=strERPxml %></textarea>
      	</span>
      	<span style="text-align: left;width: 20px;line-height: 13px;float: left;margin-left: 3px;">
   		&lt;root&gt;
      		&lt;Param1&gt;Value&lt;/Param1&gt;
      	&lt;/root&gt;
      	</span>
      </td>
    </tr>

  <tr align="center"> 
    <td class="formBottom" colspan="2">
      <input type="submit" name="Submit" value="<%=dbLabelBean.getLabel("label.suggestions.update",strsesLanguage)%>" class="formButton" >
      <input type="Reset" name="Submit2" value="<%=dbLabelBean.getLabel("button.global.reset",strsesLanguage)%>" class="formButton" >
    </td>
  </tr>
	</table>
	<input type="hidden" name="strCompanyId" value="<%=strCompanyId%>">
	</form>
	</body>
	</html>
