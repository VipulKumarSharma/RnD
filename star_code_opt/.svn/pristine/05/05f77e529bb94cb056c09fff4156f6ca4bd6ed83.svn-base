	<%@page import="sun.net.www.protocol.mailto.MailToURLConnection"%>
<%
	/***************************************************
	 *The information contained here in is confidential and 
	 * proprietary to MIND and forms the part of the MIND 
	 *Author				:Himanshu Jain
	 *Date of Creation 		:28 August 2006
	 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
	 *Project	  			:STAR
	 *Operating environment :Tomcat, sql server 2000 
	 *Description 			:This jsp file updates the SITE in M_SITE table of STAR database
	 *Modification 			: 
	 *Reason of Modification: 
	 *Date of Modification  : make site name editable  by shv sharma on 12-Aug-09
	 						:Added new flag for  showing MATA for Ticket is optional on 02 dec-2009 by shiv sharma 
	 *Revision History		:
	 *Editor				:Editplus
	 :By vaibhav on oct 16 2010 to add mailid of reporting person in cc

	 *Modified By			: MANOJ CHAND
	 *Modification			: Update closed unit remarks.
	 *Date of Modification	: 08 feb 2012
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:17 Dec 2012
	 *Modification			:web service url textbox and site currency combo box updated.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:06 Mar 2013
	 *Modification			:add company combobox and remove web service url textbox.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:29 Apr 2013
	 *Modification			:To update tes request thresold count in site master.
	 
	 *Modified By 			:Manoj Chand
	 *Modification Date		:29 May 2013
	 *Modification			:add two field REMINDER INTERVAL & REMINDER FREQUENCY
	*******************************************************/%>

<%@ page pageEncoding="UTF-8" import="src.connection.PropertiesLoader"%>
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
	<%@ include  file="systemStyle.jsp" %>
	<!--Create the DbConnectionBean object for createConnection-->
	<jsp:useBean id="dbConBean" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbConBean1" scope="page" class="src.connection.DbConnectionBean" />
	<jsp:useBean id="dbLabelBean" scope="page" class="src.connection.LabelRepository"/>
	<jsp:useBean id="wsClientObj" scope="page" class="wsclient.WSClient" />

	<SCRIPT language=JavaScript src="ScriptLibrary/FormCheck.js?buildstamp=2_0_0"></SCRIPT>
	<base target="middle">
	</head>


	<%
	request.setCharacterEncoding("UTF-8");
	// Variables declared and initialized
	Connection objCon= null;			    // Object for connection
	CallableStatement objCstmt			=		null;			// Object for Callable Statement
	String strSqlStr	=	""; // For sql Statements
	String strDesc				=""; //object to store Description
	String strStatusId			=""; //object to store Statusid	
	String strSiteId			=""; //object to store site id
	String Record_type			="U";
	String strSiteName			="";	
	ResultSet objRs=null;
	
	String strSmrSite			="";	
	String strMailToR			="";	
	String strPriceForInt		="";
	String strPriceForDom		="";
	//VARIABLE ADDED BY MANOJ CHAND ON 08 FEB 2012 TO GET UNITCLOSE CHECKBOX VALUE
	String strCheckUnit			="";
	String strClosedRemark		="";
	String strImplDate			="";
	String strBaseCur			="";
	String strMATAWsUrl				="";
	String strERPWsUrl			="";
	String strCompanyId			="";
	String strAgencyId			="0";
	String mailToMATA			="N";
	//String strMsg = "";
	String strTESCount ="0";
	String strReminderInterval = null;
	String strReminderFrequency = null;
   strSmrSite			=request.getParameter("SMRSITE");
   strMailToR			=request.getParameter("MailToR"); //by vaibhav on 13 oct 2010
   strPriceForInt		=request.getParameter("PriceforInt");
   strPriceForDom		=request.getParameter("PriceforDom");
   strCheckUnit			=request.getParameter("CheckUnit")==null?"":request.getParameter("CheckUnit");
   strClosedRemark		=request.getParameter("Closed_remark")==null?"":request.getParameter("Closed_remark");
   strImplDate			=request.getParameter("impldate")==null?"":request.getParameter("impldate");
   //added by manoj chand on 14 dec 2012 to get base currency and web service url
   strBaseCur	 		=	request.getParameter("baseCurrency")==null?"":request.getParameter("baseCurrency");
   strCompanyId	 		=	request.getParameter("company")==null?"":request.getParameter("company");
   strTESCount			=	request.getParameter("TESreqcount")==null?"0":request.getParameter("TESreqcount");
   strReminderInterval	=	request.getParameter("ReminderInterval")==null?"0":request.getParameter("ReminderInterval");
   strReminderFrequency	=	request.getParameter("ReminderFrequency")==null?"0":request.getParameter("ReminderFrequency");
   strAgencyId			=   request.getParameter("agencyId") ==null ? "0" : request.getParameter("agencyId").trim();
   mailToMATA			=   request.getParameter("mailToMATA") ==null ? "N" : request.getParameter("mailToMATA").trim();
   //System.out.println("strClosedRemark--post-->"+strClosedRemark);
   //System.out.println("strImplDate--post-->"+strImplDate);
	  
	  
	  if(strPriceForInt==null){ 
		  strPriceForInt="n";
	  }
	  
	  if(strPriceForInt.equals("I")){ 
		  strPriceForInt="y";
	  }
	  
	  
	  if(strPriceForDom==null){
		  strPriceForDom="n";
	  }
	  
	  if(strPriceForDom.equalsIgnoreCase("D")){
		  strPriceForDom="y";
	  }
	  
	  if(strAgencyId.equals("0")) {
		  mailToMATA = "N";
	  }
	

	strDesc	 					=	request.getParameter("Description")==null?"":request.getParameter("Description");	// GET DESCRIPTION
	strStatusId					=	request.getParameter("status_id");	// GET STATUS
	strSiteId	 	 			=	request.getParameter("strSiteId"); // GET SITE ID 
	 // added on 12-Aug-09  by shiv sharma 
	strSiteName					=	request.getParameter("Sitename")==null?"":request.getParameter("Sitename"); // GET SITE NAME
	objCon = dbConBean.getConnection();   //Get Connection
	//objCon.setAutoCommit(false);
			
	//Procedure for Nominal Code
	objCstmt=objCon.prepareCall("{?=call PROC_SITE_EDIT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE TO update THE site IN SITE TABLE
	objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	objCstmt.setString(2, strSiteId);
	objCstmt.setString(3, strDesc);
	objCstmt.setString(4, Suser_id);
	objCstmt.setString(5,Record_type);
	objCstmt.setString(6,strSiteName);  // added on 12-Aug-09  by shiv sharma 
	objCstmt.setString(7,strSmrSite);  // added on 12-Aug-09  by shiv sharma 
	objCstmt.setString(8,strPriceForInt);  // added on 12-Aug-09  by shiv sharma 
	objCstmt.setString(9,strPriceForDom);  // added on 12-Aug-09  by shiv sharma 
	objCstmt.setString(10,strMailToR);  // added By vaibhav on 13 aug 2010
	objCstmt.setString(11,strCheckUnit);  // added By Manoj Chand on 08 feb 2012
	objCstmt.setString(12,strClosedRemark);  // added By Manoj Chand on 08 feb 2012
	objCstmt.setString(13,strImplDate);  // added By Manoj Chand on 03 JULY 2012
	objCstmt.setString(14,strBaseCur);  // added By Manoj Chand on 08 feb 2012
	objCstmt.setString(15,strCompanyId.trim());
	objCstmt.setInt(16,Integer.parseInt(strTESCount.trim()));
	objCstmt.setInt(17,Integer.parseInt(strReminderInterval.trim()));
	objCstmt.setInt(18,Integer.parseInt(strReminderFrequency.trim()));
	objCstmt.setString(19,strAgencyId.trim());
	objCstmt.setString(20,mailToMATA.trim());
	objCstmt.registerOutParameter(21,java.sql.Types.INTEGER);
	objCstmt.execute();
	int resOut	= objCstmt.getInt(21);
	objCstmt.close();
	
	
	//added by manoj chand on 06 feb 2013 to push data to web services.
	String strCallFlag=PropertiesLoader.config.getProperty("wscallflag");
	String strWSMATAResponse="",strWSERPResponse="",strMATAXml="",strERPXml="",strMsg="",strFlag1="",strFlag2="",strERPXmlParam="";
	String strCompanyName ="";
	
	if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
		if(strSiteId!=null && !strSiteId.equals(""))
		{
		strSqlStr="SELECT COMPANY_NAME,MATA_WS_URL,ERP_WS_URL,ISNULL(ERP_XML,'') AS ERP_XML FROM DBO.M_COMPANY MC WHERE MC.CID="+strCompanyId+" AND MC.STATUS_ID=10";
		objRs		= dbConBean.executeQuery(strSqlStr);
		if(objRs.next())
		{
			strCompanyName = objRs.getString("COMPANY_NAME");
			strMATAWsUrl=objRs.getString("MATA_WS_URL");
			strERPWsUrl=objRs.getString("ERP_WS_URL");
			strERPXmlParam = objRs.getString("ERP_XML").trim();
		}
		
		//System.out.println("strMATAWsUrl--------sa--->"+strMATAWsUrl);
		//System.out.println("strERPWsUrl---------sa--->"+strERPWsUrl);
		
		String strConID=PropertiesLoader.config.getProperty("conid");
		if(strConID!=null && !strConID.equalsIgnoreCase("")){
			strMATAXml="<record><ConID>"+strConID+"</ConID><StarSiteID>"+strSiteId+"</StarSiteID><StarSiteName>"+strSiteName.trim()+"</StarSiteName><StarSiteDesc>"+strDesc.trim()+"</StarSiteDesc></record>";
		}
		if(!strMATAWsUrl.trim().equals("") && !strMATAWsUrl.trim().equals("temp") && !strMATAXml.equals("") && !strMATAXml.equals("temp")){
			strWSMATAResponse=wsClientObj.pushSiteDetailToMATAERP(strMATAWsUrl,strMATAXml,"sendSiteDetailToERP",strSiteId+"");
			if(!strWSMATAResponse.equals("") && strWSMATAResponse.substring(0,strWSMATAResponse.indexOf("|")).equalsIgnoreCase("true")){
				strFlag1="Y";
			}else{
				strFlag1="N";
			}
		}
// 		if(!strERPWsUrl.trim().equals("") && !strERPWsUrl.trim().equals("temp")){
// 			strERPXml="<Root><Star_Unit>"+strSiteId+"</Star_Unit><Star_Unit_Desc>"+strSiteName.trim()+"</Star_Unit_Desc></Root>";
// 			strWSERPResponse=wsClientObj.pushSiteDetailToEMPROERP(strCompanyName,strERPWsUrl,"sendSiteDetailToERP",Integer.parseInt(strSiteId),strERPXml,strERPXmlParam);
// 			if(!strWSERPResponse.equals("") && strWSERPResponse.substring(0,strWSERPResponse.indexOf("¤")).equalsIgnoreCase("Y") && strWSERPResponse.substring(strWSERPResponse.indexOf("¤")+1,strWSERPResponse.length()).equalsIgnoreCase("SAVED")){
// 				strFlag2="Y";
// 			}else{
// 				strFlag2="N";
// 			}
// 		}
		
		}//if strSiteId
		}//if resOut
		
		if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
// 			if((strMATAWsUrl.equals("") || strMATAWsUrl.equals("temp")) && (strERPWsUrl.equals("") || strERPWsUrl.equals("temp"))){
// 					strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
// 			}else if((strMATAWsUrl.equals("") || strMATAWsUrl.equals("temp")) && !strERPWsUrl.equals("") && !strERPWsUrl.equals("temp")){
// 				if(strFlag2.equals("Y")){
// 					strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
// 				}
// 				else if(strFlag2.equals("N")){
// 					strMsg="Error occured in ERP web service calling.";
// 				}
					
// 			}else if(!strMATAWsUrl.equals("") && !strMATAWsUrl.equals("temp") && (strERPWsUrl.equals("") || strERPWsUrl.equals("temp"))){
// 				if(strFlag1.equals("Y")){
// 					strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
// 				}
// 				else if(strFlag1.equals("N")){
// 					strMsg="Error occured in MATA web service calling.";
// 				}
// 			}else if(!strMATAWsUrl.equals("") && !strMATAWsUrl.equals("temp") && !strERPWsUrl.equals("") && !strERPWsUrl.equals("temp")){
// 				if(strFlag1.equals("Y") && strFlag2.equals("Y")){
// 					strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
// 				}else if(strFlag1.equals("Y") && strFlag2.equals("N")){
// 					strMsg="Error occured in ERP web service calling.";
// 				}else if(strFlag1.equals("N") && strFlag2.equals("Y")){
// 					strMsg="Error occured in MATA web service calling.";
// 				}else{
// 					strMsg="Error occured in MATA and ERP web service calling.";
// 				}
// 			}

			if(!strMATAWsUrl.equals("") && !strMATAWsUrl.equals("temp")){
				if(strFlag1.equals("Y")){
					strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
				}
				else if(strFlag1.equals("N")){
					strMsg="Error occured in MATA web service calling.";
				}
			}else if(!strMATAWsUrl.equals("") && !strMATAWsUrl.equals("temp")){
				if(strFlag1.equals("Y")){
					strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
				}else if(strFlag1.equals("N")){
					strMsg="Error occured in MATA web service calling.";
				}else{
					strMsg="Error occured in MATA web service calling.";
				}
			}
		}
		else if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("no")){
			strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
		}
		else{
			strMsg=dbLabelBean.getLabel("message.unit.erroroccured",strsesLanguage);
		}
	
	//added by manoj chand on 06 feb 2013 to push data to web services.
	//String strCallFlag=PropertiesLoader.config.getProperty("wscallflag");
	//String strWSMATAResponse="",strWSERPResponse="",strMATAXml="",strERPXml="",strMsg="",strFlag1="",strFlag2="";
	/*if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes"))
	{	
	if(strSiteId!=null && !strSiteId.equals(""))
	{
	strSqlStr="SELECT MATA_WS_URL,ERP_WS_URL FROM DBO.M_COMPANY MC WHERE MC.CID="+strCompanyId+" AND MC.STATUS_ID=10";
	objRs		= dbConBean.executeQuery(strSqlStr);
	if(objRs.next())
	{
		strMATAWsUrl=objRs.getString("MATA_WS_URL");
		strERPWsUrl=objRs.getString("ERP_WS_URL");
	}
	
	System.out.println("strMATAWsUrl--------se--->"+strMATAWsUrl);
	System.out.println("strERPWsUrl---------se--->"+strERPWsUrl);
	
	String strConID=PropertiesLoader.config.getProperty("conid");
	if(strConID!=null && !strConID.equalsIgnoreCase("")){
		strMATAXml="<record><ConID>"+strConID+"</ConID><StarSiteID>"+strSiteId+"</StarSiteID><StarSiteName>"+strSiteName.trim()+"</StarSiteName><StarSiteDesc>"+strDesc.trim()+"</StarSiteDesc></record>";
	}
    System.out.println("strMATAXml----------se--->"+strMATAXml);
	if(!strMATAWsUrl.trim().equals("") && !strMATAXml.equals("")){
		strWSMATAResponse=wsClientObj.pushSiteDetailToMATAERP(strMATAWsUrl,strMATAXml,"sendSiteDetailToERP",strSiteId);
		if(!strWSMATAResponse.equals("") && strWSMATAResponse.substring(0,strWSMATAResponse.indexOf("|")).equalsIgnoreCase("true")){
			strFlag1="Y";
		}else{
			strFlag1="N";
		}
		System.out.println("strWSMATAResponse----1-sedit--->"+strWSMATAResponse);
	}
	if(!strERPWsUrl.trim().equals("")){
		strERPXml="<Root><Star_Unit>"+strSiteId+"</Star_Unit><Star_Unit_Desc>"+strSiteName.trim()+"</Star_Unit_Desc></Root>";
		strWSERPResponse=wsClientObj.pushSiteDetailToEMPROERP(strERPWsUrl,"sendSiteDetailToERP",Integer.parseInt(strSiteId),strERPXml);
		System.out.println("strERPXml----------se--->"+strERPXml);
		if(!strWSERPResponse.equals("") && strWSERPResponse.substring(0,strWSERPResponse.indexOf("¤")).equalsIgnoreCase("Y") && strWSERPResponse.substring(strWSERPResponse.indexOf("¤")+1,strWSERPResponse.length()).equalsIgnoreCase("SAVED")){
			strFlag2="Y";
		}else{
			strFlag2="N";
		}
		System.out.println("strWSERPResponse----2-sedit--->"+strWSERPResponse);
	}
	
	}//if strSiteId
	}//if resOut*/

	/*if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
		if(strMATAWsUrl.equals("") && strERPWsUrl.equals("")){
				strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
		}else if(strMATAWsUrl.equals("") && !strERPWsUrl.equals("")){
			if(strFlag2.equals("Y")){
				strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
			}
			else if(strFlag2.equals("N")){
				strMsg="Error occured in ERP web service calling.";
			}
				
		}else if(!strMATAWsUrl.equals("") && strERPWsUrl.equals("")){
			if(strFlag1.equals("Y")){
				strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
			}
			else if(strFlag1.equals("N")){
				strMsg="Error occured in MATA web service calling.";
			}
		}else if(!strMATAWsUrl.equals("") && !strERPWsUrl.equals("")){
			if(strFlag1.equals("Y") && strFlag2.equals("Y")){
				strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
			}else if(strFlag1.equals("Y") && strFlag2.equals("N")){
				strMsg="Error occured in ERP web service calling.";
			}else if(strFlag1.equals("N") && strFlag2.equals("Y")){
				strMsg="Error occured in MATA web service calling.";
			}else{
				strMsg="Error occured in MATA and ERP web service calling.";
			}
		}
	}
	else if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("no")){
		strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
	}
	else{
		strMsg="Error occured during data updation.";
	}*/
// 	if(resOut==0){
// 		strMsg=dbLabelBean.getLabel("alert.unit.siteupdatedsuccess",strsesLanguage);
// 	}
	response.sendRedirect("M_siteList.jsp?message="+strMsg);
	

	dbConBean.close();  //CLOSE ALL CONNECTIONS
	//response.sendRedirect("M_siteList.jsp");
	%>
	