/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY			:	Manoj Chand
*Date				:	14 March 2013
*Description		:	CLIENT TO RE-CALL WEB SERVICE.
*Project			:	STARS
*
*Modified By		: 	Manoj Chand
*Modification Date  :   05 April 2013
*Modification   	:   Functional_ctl table used in case of recalling empro webservice.
*
*Modified By		: 	Manoj Chand
*Modification Date  :   27 August 2013
*Modification   	:   pass one more parameter paramxml in erp webservice method.
**********************************************************/ 

package wsclient.wsrecall;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONException;
import org.json.JSONObject;

import src.connection.PropertiesLoader;
import wsclient.WSClient;
import wsclient.matawebservice.TicketingServiceSoapProxy;
import wsclient.wslogging.ResponseObject;
import wsclient.wslogging.WSLoggingUtility;

public class WSRecall {
	
	public static void main(String args[]){
		
		String	 dbdriver =	null;
		String	 dburl	  =  null;
		String	 dbuser	  =  null;
		String	 dbpwd	  =  null;
		Connection con	= null;
		ResultSet rs,rs1 = null;
		Statement stmt,stmt1 = null;
		String strSql = null;
		String strLogid = null;
		String strRequestData = null;
		String strSiteId = null;
		String strMethodName = null;
		String strSourceSys = null;
		String strWSUrl = null;
		String strXML = null;
		String strWSParamXML = null;
		String strCompany = null;
		dbdriver			=	PropertiesLoader.config.getProperty("dbdriver");
		dburl				=	PropertiesLoader.config.getProperty("dburl");
		dbuser				=	PropertiesLoader.config.getProperty("dbuser");
		dbpwd				=	PropertiesLoader.config.getProperty("dbpwd");
		
		
		
		
		try{
			JSONObject jObj;
			Class.forName(dbdriver);
	    	con	=DriverManager.getConnection(dburl,dbuser,dbpwd);
	    	//strSql = "select ID,REQ,SITE_ID,METHOD_NAME,ltrim(rtrim(rrd.SOURCE_SYSTEM)) as SOURCE_SYSTEM,DBO.FN_GET_WSURL (SITE_ID,SOURCE_SYSTEM) as WS_URL,DBO.FN_GET_WSPARAMXML(SITE_ID) as WS_PARAMXML from dbo.REQ_RESP_DATA rrd WHERE rrd.CALLING_STATUS='Failed' and RESEND_FLAG='NEW'";
	    	
	    	strSql = " select * from (select ID,REQ,RRD.SITE_ID,METHOD_NAME,ltrim(rtrim(rrd.SOURCE_SYSTEM)) as SOURCE_SYSTEM,"
	    			+ " DBO.FN_GET_WSURL (RRD.SITE_ID,SOURCE_SYSTEM) as WS_URL,CM.ERP_XML as WS_PARAMXML ,"
	    			+ " CM.COMPANY_NAME from dbo.REQ_RESP_DATA rrd"
	    			+ "	INNER JOIN M_SITE SM ON RRD.SITE_ID=SM.SITE_ID"
	    			+ " INNER join M_COMPANY CM ON SM.COMPANY_ID=CM.CID	"
	    			+ " WHERE rrd.CALLING_STATUS='Failed' and RESEND_FLAG='NEW'"
	    			+ " AND rrd.C_DATE >= SM.TES_CUTTOFF_DATE)drv where WS_URL not in ('temp','temp1')";
	    	//test or manual recall query
	    	//strSql = "select ID,REQ,SITE_ID,METHOD_NAME,ltrim(rtrim(rrd.SOURCE_SYSTEM)) as SOURCE_SYSTEM,DBO.FN_GET_WSURL (SITE_ID,SOURCE_SYSTEM) as WS_URL,DBO.FN_GET_WSPARAMXML(SITE_ID) as WS_PARAMXML from dbo.REQ_RESP_DATA rrd WHERE rrd.id in (3416)";
	    	stmt = con.createStatement(); 
			rs	   = stmt.executeQuery(strSql);
			while(rs.next())
			{
			
			WSClient ObjClient = null;
			TicketingServiceSoapProxy objWSMata = null;
			strLogid = rs.getString("ID");
			strRequestData = rs.getString("REQ");
			strSiteId = rs.getString("SITE_ID");
			strMethodName = rs.getString("METHOD_NAME");
			strSourceSys = rs.getString("SOURCE_SYSTEM");
			strWSUrl = rs.getString("WS_URL");
			strWSParamXML = rs.getString("WS_PARAMXML");
			strCompany = rs.getString("COMPANY_NAME");
			
			jObj=null;
			try {
				jObj = new JSONObject(strRequestData);
			} catch (JSONException e1) {
				e1.printStackTrace();
			}
			strXML = (String) jObj.get("xmlstring");
 			String reply="",responseBeanResponse="";
 			ResponseObject responseObject = new ResponseObject();
 			
 			
			if(strMethodName.equalsIgnoreCase("sendStarsReqDetailToERP") && strSourceSys.equalsIgnoreCase("MATA") && !strWSUrl.equals("")){
				try{
				ObjClient	=	new WSClient();
				objWSMata	=	new TicketingServiceSoapProxy();
				objWSMata.setEndpoint(strWSUrl);
				reply = objWSMata.sendStarsReqDetailToERP(strXML);
				responseObject.setStrErrorMessage(reply);
	 			JSONObject jRespObj = new JSONObject();
				jRespObj.put("ResponseObject", responseObject.toString());
				System.out.println("reply 11 "+reply);
				responseBeanResponse=jRespObj.toString();
				if(reply!=null && reply.substring(0, reply.indexOf("|")).equalsIgnoreCase("true")){
					WSLoggingUtility.updateStatusOnRecall(strLogid,responseBeanResponse);
				}
				}catch(Exception e){
					System.out.println("Error occured while recalling sendStarsReqDetailToERP method of MATA"+e.getMessage());
				}
			}
			else if(strMethodName.equalsIgnoreCase("sendSiteDetailToERP") && strSourceSys.equalsIgnoreCase("MATA") && !strWSUrl.equals("")){
				try{
					ObjClient	=	new WSClient();
					objWSMata	=	new TicketingServiceSoapProxy();
					objWSMata.setEndpoint(strWSUrl);
					reply = objWSMata.sendSiteDetailToERP (strXML);
					responseObject.setStrErrorMessage(reply);
		 			JSONObject jRespObj = new JSONObject();
					jRespObj.put("ResponseObject", responseObject.toString());
					responseBeanResponse=jRespObj.toString();
					if(reply!=null && reply.substring(0, reply.indexOf("|")).equalsIgnoreCase("true")){
						WSLoggingUtility.updateStatusOnRecall(strLogid,responseBeanResponse);
					}
				}catch(Exception e){
					System.out.println("Error occured while recalling sendSiteDetailToERP method of MATA"+e.getMessage());
				}
			}
			else if(strMethodName.equalsIgnoreCase("sendStarsReqDetailToERP") && strSourceSys.equalsIgnoreCase("eMPro") && !strWSUrl.equals("") && !strWSUrl.equals("temp") && !strWSUrl.equals("temp1")){
				try{
					String strFunctionVal = null , strSql2 = null;
					strSql2="SELECT ltrim(rtrim(FUNCTION_VALUE)) FROM dbo.functional_ctl fc WHERE fc.FUNCTION_KEY='@SITE_FOR_EMPRO_WEBSERVICE'";
					stmt1 = con.createStatement(); 
					rs1	  = stmt1.executeQuery(strSql2);
					if(rs1.next()){
						strFunctionVal = rs1.getString(1);
					}
					rs1.close();
					if(strFunctionVal!=null && !strFunctionVal.equals("")){
						strSql2="select 1 from dbo.REQ_RESP_DATA rrd where rrd.ID="+strLogid+" and rrd.SITE_ID in ("+strFunctionVal+")";
						rs1= null;
						stmt1 = con.createStatement(); 
						rs1	  = stmt1.executeQuery(strSql2);
						if(rs1.next()){
							ObjClient	=	new WSClient();
							
							if(strCompany.equalsIgnoreCase("MATE")){
								wsclient.erpwebservice.mate.ServiceSoapProxy objWSErp	=	new wsclient.erpwebservice.mate.ServiceSoapProxy();
								objWSErp.setEndpoint(strWSUrl);
								reply = objWSErp.sendStarsReqDetailToERP(strXML,strWSParamXML);
							}
							if(strCompany.equalsIgnoreCase("MIND") || strCompany.equalsIgnoreCase("MAL") || strCompany.equalsIgnoreCase("SMIL")|| strCompany.equalsIgnoreCase("CKM")){
								wsclient.erpwebservice.mind.ServiceSoapProxy objWSErp	=	new wsclient.erpwebservice.mind.ServiceSoapProxy();
								objWSErp.setEndpoint(strWSUrl);
								reply = objWSErp.sendStarsReqDetailToERP(strXML,strWSParamXML);
							}
							System.out.println("reply  "+reply);
							responseObject.setStrErrorMessage(reply);
				 			JSONObject jRespObj = new JSONObject();
							jRespObj.put("ResponseObject", responseObject.toString());
							responseBeanResponse=jRespObj.toString();
							if(reply!=null && reply.substring(0, reply.indexOf("¤")).equalsIgnoreCase("Y")){
								WSLoggingUtility.updateStatusOnRecall(strLogid,responseBeanResponse);
							}
						}
					}
					
				}catch(Exception e){
					System.out.println("Error occured while recalling sendStarsReqDetailToERP method of eMPro"+e.getMessage());
				}
			}
			else if(strMethodName.equalsIgnoreCase("sendSiteDetailToERP") && strSourceSys.equalsIgnoreCase("eMPro") && !strWSUrl.equals("") && !strWSUrl.equals("temp") && !strWSUrl.equals("temp1")){
				try{
					ObjClient	=	new WSClient();
					
					if(strCompany.equalsIgnoreCase("MATE")){
						wsclient.erpwebservice.mate.ServiceSoapProxy objWSErp	=	new wsclient.erpwebservice.mate.ServiceSoapProxy();
						objWSErp.setEndpoint(strWSUrl);
						reply = objWSErp.sendSiteDetailToERP(strXML,strWSParamXML);
						responseObject.setStrErrorMessage(reply);
					}
					if(strCompany.equalsIgnoreCase("MIND") || strCompany.equalsIgnoreCase("MAL") || strCompany.equalsIgnoreCase("SMIL")|| strCompany.equalsIgnoreCase("CKM")){
						wsclient.erpwebservice.mind.ServiceSoapProxy objWSErp	=	new wsclient.erpwebservice.mind.ServiceSoapProxy();
						objWSErp.setEndpoint(strWSUrl);
						reply = objWSErp.sendSiteDetailToERP(strXML,strWSParamXML);
					}
					
					responseObject.setStrErrorMessage(reply);
		 			JSONObject jRespObj = new JSONObject();
					jRespObj.put("ResponseObject", responseObject.toString());
					responseBeanResponse=jRespObj.toString();
					if(reply!=null && reply.substring(0, reply.indexOf("¤")).equalsIgnoreCase("Y") && reply.substring(reply.indexOf("¤")+1,reply.length()).equalsIgnoreCase("SAVED")){
						WSLoggingUtility.updateStatusOnRecall(strLogid,responseBeanResponse);
					}
					else if(reply!=null && reply.substring(0, reply.indexOf("¤")).equalsIgnoreCase("N") && reply.substring(reply.indexOf("¤")+1,reply.length()).equalsIgnoreCase("Already Saved")){
						WSLoggingUtility.updateStatusOnRecall(strLogid,responseBeanResponse);
					}
				}catch(Exception e){
					System.out.println("Error occured while recalling sendSiteDetailToERP method of eMPro"+e.getMessage());
				}
			}
			
			//System.out.println("reply------wsrecall------>"+reply);
			}
		}catch(Exception ex){
			System.out.println("Error occured in WSRecall java file...");
			ex.printStackTrace();
		}finally{
			if(con!=null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}
}
