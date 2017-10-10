<%
/***************************************************
 *The information contained here in is confidential and 
 * proprietary to MIND and forms the part of the MIND 
 *Author				:Himanshu Jain
 *Date of Creation 		:28 August 2006
 *Copyright Notice 		:Copyright(C)2000 MIND.All rights reserved
 *Project	  			:STAR
 *Operating environment :Tomcat, sql server 2000 
 *Description 			:This jsp updates the M_SITE table of STAR Database.
 *Modification 			: 
 *Reason of Modification: 
 *Date of Modification  : 
 *Revision History		:
 *Editor				:Editplus
 
 *Modified By 			:Manoj Chand
 *Modification Date		:17 Dec 2012
 *Modification			:web service url textbox and site currency combo box added.
 
 *Modified By 			:Manoj Chand
 *Modification Date		:06 Mar 2013
 *Modification			:add company combobox and remove web service url textbox.
 
 *Modified By 			:Manoj Chand
 *Modification Date		:29 Apr 2013
 *Modification			:add tes request thresold count.
 
 *Modified By 			:Manoj Chand
 *Modification Date		:29 May 2013
 *Modification			:add two field REMINDER INTERVAL & REMINDER FREQUENCY
 
 *Modified By 			:Manoj Chand
 *Modification Date		:27 Aug 2013
 *Modification			:pass one parameter xmlparam string to erp webservice method. 
*******************************************************/%>


<%@ include  file="importStatement.jsp" %>
<%@ page import = "src.connection.DbUtilityMethods,src.connection.PropertiesLoader" pageEncoding="UTF-8"%>
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
Connection objCon					=		null;			    // Object for connection
Statement objStmt					=		null;			   // Object for Statement
ResultSet objRs						=		null;			  // Object for ResultSet
CallableStatement objCstmt			=		null;			// Object for Callable Statement

objCon = dbConBean.getConnection();  //Get the Conneciton
DbUtilityMethods utilitymethod = new DbUtilityMethods(); // getNewID method defined in this file
String	strSqlStr	=	""; // For sql Statements
int intsiteid = utilitymethod.getNewId("M_SITE"); //Getting unique SITE_ID from the bean
String Record_type="I"; // Setting Record Type to I in case if insert
//objCon.setAutoCommit(false);
%>

<%
String strDivision			=""; // Object to store Division ID
String strSite				=""; //object to store Site Name
String strDesc				=""; //object to store Description
String strStatusId			=""; //object to store Statusid	
String U_DATE  				=""; //object to store U_date
String strBaseCur			="";
String strCompanyId			="";
String strMATAWsUrl			="";
String strERPWsUrl			="";
String strTESCount 			="0";
String strAgencyId			="0";

String strReminderInterval 	= null;
String strReminderFrequency = null;

strDivision	 				=	request.getParameter("Division");	//	GET DIVISION
strSite	 					=	request.getParameter("Sitename")==null?"":request.getParameter("Sitename");	// GET SITE
strDesc	 					=	request.getParameter("Description")==null?"":request.getParameter("Description");	// GET DESCRIPTION
strStatusId					=	request.getParameter("status_id");	// GET STATUS
//added by manoj chand on 14 dec 2012 to get base currency and web service url
strBaseCur	 				=	request.getParameter("baseCurrency")==null?"":request.getParameter("baseCurrency");
strCompanyId				=	request.getParameter("company")==null?"":request.getParameter("company");
strTESCount				    =	request.getParameter("TESreqcount")==null?"0":request.getParameter("TESreqcount");
strReminderInterval			=	request.getParameter("ReminderInterval")==null?"0":request.getParameter("ReminderInterval");
strReminderFrequency		=	request.getParameter("ReminderFrequency")==null?"0":request.getParameter("ReminderFrequency");
strAgencyId					=   request.getParameter("agencyId") ==null ? "0" : request.getParameter("agencyId");


		strSqlStr	=	"SELECT SITE_ID FROM M_SITE WHERE SITE_NAME=N'"+strSite+"' AND DIV_ID='"+strDivision+"' AND  STATUS_ID="+strStatusId+"";
		//objStmt		= objCon.createStatement(); 
		objRs		= dbConBean.executeQuery(strSqlStr);
		if(objRs.next())
		{
				response.sendRedirect("M_siteDataResult.jsp?Type=Add&Error=2");
		}
		else
		{
			//Procedure for Nominal Code
			objCstmt=objCon.prepareCall("{?=call PROC_SITE_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");//PROCEDURE TO ADD THE USER IN SITE TABLE
			objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			objCstmt.setString(2, strDivision);
			objCstmt.setString(3, strSite.trim());
			objCstmt.setString(4, strDesc.trim());
			objCstmt.setString(5, strStatusId);
			objCstmt.setString(6, Suser_id);
			objCstmt.setInt(7,intsiteid);
			objCstmt.setString(8,Record_type);
			objCstmt.setString(9,U_DATE);
			objCstmt.setString(10,strBaseCur);
			objCstmt.setString(11,strCompanyId.trim());
			objCstmt.setInt(12,Integer.parseInt(strTESCount.trim()));
			objCstmt.setInt(13,Integer.parseInt(strReminderInterval.trim()));
			objCstmt.setInt(14,Integer.parseInt(strReminderFrequency.trim()));
			objCstmt.setString(15,strAgencyId.trim());
			objCstmt.setString(16,"N");
			objCstmt.registerOutParameter(17,java.sql.Types.INTEGER);
			objCstmt.execute();
			int resOut	= objCstmt.getInt(17);
			objCstmt.close();
			
			//added by manoj chand on 06 feb 2013 to push data to web services.
			String strCallFlag=PropertiesLoader.config.getProperty("wscallflag");
			String strWSMATAResponse="",strWSERPResponse="",strMATAXml="",strERPXml="",strMsg="",strFlag1="",strFlag2="",strERPXmlParam="";
			String strCompanyName ="";

			if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
			if(intsiteid>1)
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
				strMATAXml="<record><ConID>"+strConID+"</ConID><StarSiteID>"+intsiteid+"</StarSiteID><StarSiteName>"+strSite.trim()+"</StarSiteName><StarSiteDesc>"+strDesc.trim()+"</StarSiteDesc></record>";
			}
			if(!strMATAWsUrl.trim().equals("") && !strMATAWsUrl.trim().equals("temp") && !strMATAXml.equals("") && !strMATAXml.equals("temp")){
				strWSMATAResponse=wsClientObj.pushSiteDetailToMATAERP(strMATAWsUrl,strMATAXml,"sendSiteDetailToERP",intsiteid+"");
				if(!strWSMATAResponse.equals("") && strWSMATAResponse.substring(0,strWSMATAResponse.indexOf("|")).equalsIgnoreCase("true")){
					strFlag1="Y";
				}else{
					strFlag1="N";
				}
			}
			if(!strERPWsUrl.trim().equals("") && !strERPWsUrl.trim().equals("temp")){
				strERPXml="<Root><Star_Unit>"+intsiteid+"</Star_Unit><Star_Unit_Desc>"+strSite.trim()+"</Star_Unit_Desc></Root>";
				strWSERPResponse=wsClientObj.pushSiteDetailToEMPROERP(strCompanyName,strERPWsUrl,"sendSiteDetailToERP",intsiteid,strERPXml,strERPXmlParam);
				if(!strWSERPResponse.equals("") && strWSERPResponse.substring(0,strWSERPResponse.indexOf("¤")).equalsIgnoreCase("Y") && strWSERPResponse.substring(strWSERPResponse.indexOf("¤")+1,strWSERPResponse.length()).equalsIgnoreCase("SAVED")){
					strFlag2="Y";
				}else{
					strFlag2="N";
				}
			}
			
			}//if intsiteid
			}//if resOut

			if(resOut==0 && strCallFlag!=null && strCallFlag.equalsIgnoreCase("yes")){
				if((strMATAWsUrl.equals("") || strMATAWsUrl.equals("temp")) && (strERPWsUrl.equals("") || strERPWsUrl.equals("temp"))){
						strMsg=dbLabelBean.getLabel("alert.unit.siteaddedsuccess",strsesLanguage);
				}else if((strMATAWsUrl.equals("") || strMATAWsUrl.equals("temp")) && !strERPWsUrl.equals("") && !strERPWsUrl.equals("temp")){
					if(strFlag2.equals("Y")){
						strMsg=dbLabelBean.getLabel("alert.unit.siteaddedsuccess",strsesLanguage);
					}
					else if(strFlag2.equals("N")){
						strMsg="Error occured in ERP web service calling.";
					}
						
				}else if(!strMATAWsUrl.equals("") && !strMATAWsUrl.equals("temp") && (strERPWsUrl.equals("") || strERPWsUrl.equals("temp"))){
					if(strFlag1.equals("Y")){
						strMsg=dbLabelBean.getLabel("alert.unit.siteaddedsuccess",strsesLanguage);
					}
					else if(strFlag1.equals("N")){
						strMsg="Error occured in MATA web service calling.";
					}
				}else if(!strMATAWsUrl.equals("") && !strMATAWsUrl.equals("temp") && !strERPWsUrl.equals("") && !strERPWsUrl.equals("temp")){
					if(strFlag1.equals("Y") && strFlag2.equals("Y")){
						strMsg=dbLabelBean.getLabel("alert.unit.siteaddedsuccess",strsesLanguage);
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
				strMsg=dbLabelBean.getLabel("alert.unit.siteaddedsuccess",strsesLanguage);
			}
			else{
				strMsg=dbLabelBean.getLabel("message.unit.erroroccured",strsesLanguage);
			}
			response.sendRedirect("M_siteList.jsp?message="+strMsg);
		}

objRs.close();
dbConBean.close();       //CLOSE ALL CONNECTIONS

%>

