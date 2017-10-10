/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY		:	Manoj Chand
*Date			:	15 January 2013
*Description	:	CLIENT TO CALL WEB SERVICE.
*Project		:	STARS
*
*Modified By		: 	Manoj Chand
*Modification Date  :   05 April 2013
*Modification   	:   pass siteid as parameter in senderrormail method.
*
*Modified By		: 	Manoj Chand
*Modification Date  :   13 June 2013
*Modification   	:   prevent sending error mail when ERP URL contain temp.
**********************************************************/ 
package wsclient;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONException;
import org.json.JSONObject;

import src.connection.DbConnectionBean;

import wsclient.errormail.WSerrormail;
import wsclient.matawebservice.TicketingServiceSoapProxy;
import wsclient.wslogging.*;

public class WSClient {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		/*String xmlstring="<record><ConID>1</ConID><StarSiteID>102</StarSiteID><StarSiteName>MATE (NOIDA)</StarSiteName><StarSiteDesc>MATE, NOIDA</StarSiteDesc></record>";
		System.out.println("xmlstring-------->"+xmlstring);
		WSClient obj=new WSClient();
		String response=obj.pushSiteDetailToMATAERP("http://172.29.57.139/empronet/services/TicketingService.asmx",xmlstring,"sendSiteDetailToERP","102");
		System.out.println("response is :-------->"+response);	*/
	}

	//this method is to send information on request is received by last approver i.e MATA
	public String pushStarsReqDetailsToMATA(String endpoint,String xmlstring,String methodname,String strTravelId,String strSiteId){
		java.lang.String reply="";
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", xmlstring);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			//TicketingServiceSoapProxy obj=new TicketingServiceSoapProxy();
			//obj.setEndpoint(endpoint);
			//reply = obj.sendStarsReqDetailToERP(xmlstring);
			//responseObject.setStrErrorMessage(reply);
			//logging
			//JSONObject jRespObj = new JSONObject();
			//jRespObj.put("ResponseObject", responseObject.toString());
			//responseBeanResponse=jRespObj.toString();
			//if(reply!=null && !reply.substring(0, reply.indexOf("|")).equalsIgnoreCase("True")){
			//	WSerrormail objerrormail=new WSerrormail();
			//	objerrormail.sendErrorMail(endpoint,reply,methodname,strTravelId,"",strSiteId);
			//	WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "sendStarsReqDetailToERP", "Failed",strSiteId);
			//}
			//else{
			//	WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "sendStarsReqDetailToERP", "Success",strSiteId);
			//}
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "sendStarsReqDetailToERP", "Failed",strSiteId);
		}catch(Exception ex){
			System.out.println("*********Error occurred pushStarsReqDetailsToMATA() method of MATA in WSClient.java********");
			if(endpoint!=null && !endpoint.equals("temp")){
				WSerrormail objerrormail=new WSerrormail();
				objerrormail.sendErrorMail(endpoint,ex.getMessage(),methodname,strTravelId,"",strSiteId);
			}
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "sendStarsReqDetailToERP", "Failed",strSiteId);
		}
		return reply;
	}
	
	//method added by manoj chand on 05 feb 2013 to test web service running or not.
	public String testWSConnection(String path)
	{
		String status= "N";
		URL url;
		InputStream is = null;
		DataInputStream dis;
		String line;
		try {
		    url = new URL(path);
		    is = url.openStream();  // throws an IOException
		    dis = new DataInputStream(new BufferedInputStream(is));
		    boolean check =false;
		    while ((line = dis.readLine()) != null) {
		        if(line.contains("wsdl:definitions") ){
		        	check = true;
		        	break;
		        }
		    }
		    if(check){
		    	//System.out.println("Web Service Found.");
		    	status = "Y";
		    }else{
		    	//System.out.println("Web Service not Found.");
		    }
		} catch (MalformedURLException mue) {	
			System.out.println("Web Service not Found.");
			System.out.println("Error in testWSConnection()===="+mue);
			
		} catch (IOException ioe) {
			
			System.out.println("Web Service not Found.");
			System.out.println("Error in testWSConnection()===="+ioe);	
		} finally {
		    try {
		        is.close();
		    } catch (Exception ioe) {
		    	System.out.println("Web Service not Found.");
				System.out.println("Error in testWSConnection()===="+ioe);
		    }
		}
		return status;
	}
	
	//CREATED BY MANOJ CHAND ON 05 FEB 2013, METHOD TO PUSH SITE DATA TO SITE WEB SERVICE.
	public String pushSiteDetailToMATAERP(String endpoint,String xmlstring,String methodname,String strsiteId){
		java.lang.String reply="";
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", xmlstring);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			TicketingServiceSoapProxy obj=new TicketingServiceSoapProxy();
			obj.setEndpoint(endpoint);
			reply = obj.sendSiteDetailToERP (xmlstring);
			responseObject.setStrErrorMessage(reply);
			//logging
			JSONObject jRespObj = new JSONObject();
			jRespObj.put("ResponseObject", responseObject.toString());
			responseBeanResponse=jRespObj.toString();
			if(reply!=null && !reply.substring(0, reply.indexOf("|")).equalsIgnoreCase("True")){
				WSerrormail objerrormail=new WSerrormail();
				objerrormail.sendErrorMail(endpoint,reply,methodname,strsiteId,"",strsiteId);
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "sendSiteDetailToERP", "Failed",strsiteId);
			}else{
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "sendSiteDetailToERP", "Success",strsiteId);
			}
		} catch(Exception ex){
			System.out.println("*********Error occurred in pushSiteDetailToMATAERP() method of MATA in WSClient.java********");
			WSerrormail objerrormail=new WSerrormail();
			objerrormail.sendErrorMail(endpoint,ex.getMessage(),methodname,strsiteId,"",strsiteId);
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "sendSiteDetailToERP", "Failed",strsiteId);
		}
		return reply;
	}
	
	//Method added by manoj chand on 01 Mar 2013 to push data to ERP when request is submit to workflow.
	//this method is to send information on request is received by last approver i.e MATA
	public String pushStarsReqDetailsToERP(String company,String endpoint,String methodname,String strXML,String strTravelId,String strSiteId,String strXMLParam){
		java.lang.String reply="";
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", strXML);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			
			//if block added by manoj chand on 04 oct 2013 to call different webservice
			//if(company.equalsIgnoreCase("MATE")){
			//	wsclient.erpwebservice.mate.ServiceSoapProxy obj = new wsclient.erpwebservice.mate.ServiceSoapProxy();
			//	obj.setEndpoint(endpoint);
			//	reply = obj.sendStarsReqDetailToERP(strXML,strXMLParam);
			//}
			//if(company.equalsIgnoreCase("MIND")){
			//	wsclient.erpwebservice.mind.ServiceSoapProxy obj = new wsclient.erpwebservice.mind.ServiceSoapProxy();
			//	obj.setEndpoint(endpoint);
			//	reply = obj.sendStarsReqDetailToERP(strXML,strXMLParam);
			//}
					
			//responseObject.setStrErrorMessage(reply);
			//logging
			//JSONObject jRespObj = new JSONObject();
			//jRespObj.put("ResponseObject", responseObject.toString());
			//responseBeanResponse=jRespObj.toString();
			
			//if(reply!=null && !reply.substring(0, reply.indexOf("¤")).equalsIgnoreCase("Y")){
			//	WSerrormail objerrormail=new WSerrormail();
			//	objerrormail.sendErrorMail(endpoint,reply,methodname,strTravelId,"",strSiteId);
			//	WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendStarsReqDetailToERP", "Failed",strSiteId);
			//}else{
			//	WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendStarsReqDetailToERP", "Success",strSiteId);
			//}
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendStarsReqDetailToERP", "Failed",strSiteId);
		} catch(Exception ex){
			System.out.println("*********Error occurred in pushStarsReqDetailsToERP() method of eMPro in WSClient.java********");
			if(endpoint!=null && !endpoint.equals("temp")){
				WSerrormail objerrormail=new WSerrormail();
				objerrormail.sendErrorMail(endpoint,ex.getMessage(),methodname,strTravelId,"",strSiteId);
			}
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendStarsReqDetailToERP", "Failed",strSiteId);
		}
		return reply;
	}
	
	
	//CREATED BY MANOJ CHAND ON 05 FEB 2013, METHOD TO PUSH SITE DATA TO SITE WEB SERVICE.
	public String pushSiteDetailToEMPROERP(String company,String endpoint,String methodname,int intSiteID,String strXML,String strXMLParam){
		java.lang.String reply="";
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", strXML);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			
			//if block added by manoj chand on 04 oct 2013 to call different webservice
			if(company.equalsIgnoreCase("MATE")){
				wsclient.erpwebservice.mate.ServiceSoapProxy obj = new wsclient.erpwebservice.mate.ServiceSoapProxy();
				obj.setEndpoint(endpoint);
				reply = obj.sendSiteDetailToERP(strXML,strXMLParam);
			}
			if(company.equalsIgnoreCase("MIND")){
				wsclient.erpwebservice.mind.ServiceSoapProxy obj = new wsclient.erpwebservice.mind.ServiceSoapProxy();
				obj.setEndpoint(endpoint);
				reply = obj.sendSiteDetailToERP(strXML,strXMLParam);
			}
			
			responseObject.setStrErrorMessage(reply);
			//logging
			JSONObject jRespObj = new JSONObject();
			jRespObj.put("ResponseObject", responseObject.toString());
			responseBeanResponse=jRespObj.toString();
			
			if(reply!=null && reply.substring(0, reply.indexOf("¤")).equalsIgnoreCase("Y") && reply.substring(reply.indexOf("¤")+1,reply.length()).equalsIgnoreCase("SAVED")){
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendSiteDetailToERP", "Success",intSiteID+"");
			}
			else if(reply!=null && reply.substring(0, reply.indexOf("¤")).equalsIgnoreCase("N") && reply.substring(reply.indexOf("¤")+1,reply.length()).equalsIgnoreCase("Already Saved")){
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendSiteDetailToERP", "Success",intSiteID+"");
			}
			else if(reply!=null && reply.substring(0, reply.indexOf("¤")).equalsIgnoreCase("N") && !reply.substring(reply.indexOf("¤")+1,reply.length()).equalsIgnoreCase("Already Saved")){
				WSerrormail objerrormail=new WSerrormail();
				objerrormail.sendErrorMail(endpoint,reply,methodname,intSiteID+"","",intSiteID+"");
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendSiteDetailToERP", "Failed",intSiteID+"");
			}	
		} catch(Exception ex){
			System.out.println("*********Error occurred in pushSiteDetailToEMPROERP() method of eMPro in WSClient.java********");
			WSerrormail objerrormail=new WSerrormail();
			objerrormail.sendErrorMail(endpoint,ex.getMessage(),methodname,intSiteID+"","",intSiteID+"");
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "sendSiteDetailToERP", "Failed",intSiteID+"");
		}
		return reply;
	}
	
	//Method added by manoj chand on 03 oct 2013 to call cancancelrequest method of web service
	public String[] canCancelRequestMATA(String endpoint,String TravelId,int intSiteID,String strXML,String strXMLParam)
	{
		java.lang.String reply="",strcancelflag="",strreason="";
		String strOutput[] = null;
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", strXML);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			
			TicketingServiceSoapProxy obj=new TicketingServiceSoapProxy();
			obj.setEndpoint(endpoint);
			reply = obj.canCancelRequest(strXML,strXMLParam);
			responseObject.setStrErrorMessage(reply);
			//logging
			JSONObject jRespObj = new JSONObject();
			jRespObj.put("ResponseObject", responseObject.toString());
			responseBeanResponse=jRespObj.toString();
			
			Parser objparse = new Parser();
			strOutput = objparse.parsexmlstring(reply);
			strcancelflag = strOutput[0];
			strreason = strOutput[1];
			
			if(strcancelflag!=null && !strcancelflag.equals("") && (strcancelflag.equalsIgnoreCase("YES") || strcancelflag.equalsIgnoreCase("NO"))){
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "canCancelRequest", "Success",intSiteID+"");
			}else{
				WSerrormail objerrormail=new WSerrormail();
				//objerrormail.sendErrorMail(endpoint,"Wrong XML output string: "+reply,"canCancelRequest",TravelId,"",intSiteID+"");
				strOutput[0]="NO";
				strOutput[1]="Wrong XML output string";
			}
		} catch(Exception ex){
			System.out.println("*********Error occurred in canCancelRequestMATA() method of MATA in WSClient.java********");
			WSerrormail objerrormail=new WSerrormail();
			objerrormail.sendErrorMail(endpoint,ex.getMessage(),"canCancelRequest",TravelId,"",intSiteID+"");
			strOutput[0]="NO";
			strOutput[1]="Error occured while calling web service.";
		}
		return strOutput;
	}
	
	//Method added by manoj chand on 03 oct 2013 to call cancancelrequest method of web service
	public String[] canCancelRequestERP(String company,String endpoint,String TravelId,int intSiteID,String strXML,String strXMLParam)
	{
		java.lang.String reply="",strcancelflag="",strreason="";
		String strOutput[] = null;
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", strXML);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			
			if(company.equalsIgnoreCase("MATE")){
				wsclient.erpwebservice.mate.ServiceSoapProxy obj = new wsclient.erpwebservice.mate.ServiceSoapProxy();
				obj.setEndpoint(endpoint);
				reply = obj.canCancelRequest(strXML,strXMLParam);
			}
			if(company.equalsIgnoreCase("MIND")){
				wsclient.erpwebservice.mind.ServiceSoapProxy obj = new wsclient.erpwebservice.mind.ServiceSoapProxy();
				obj.setEndpoint(endpoint);
				//reply = obj.canCancelRequest(strXML,strXMLParam);
			}
			
			responseObject.setStrErrorMessage(reply);
			//logging
			JSONObject jRespObj = new JSONObject();
			jRespObj.put("ResponseObject", responseObject.toString());
			responseBeanResponse=jRespObj.toString();
			
			Parser objparse = new Parser();
			strOutput = objparse.parsexmlstring(reply);
			strcancelflag = strOutput[0];
			strreason = strOutput[1];
			
			if(!strcancelflag.equals("") && (strcancelflag.equalsIgnoreCase("YES") || strcancelflag.equalsIgnoreCase("NO"))){
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "canCancelRequest", "Success",intSiteID+"");
			}
			/*else{
				WSerrormail objerrormail=new WSerrormail();
				objerrormail.sendErrorMail(endpoint,reply,"canCancelRequest",TravelId,"",intSiteID+"");
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "canCancelRequest", "Failed",intSiteID+"");
			}	*/
		} catch(Exception ex){
			System.out.println("*********Error occurred in canCancelRequestERP() method of eMPro in WSClient.java********");
			WSerrormail objerrormail=new WSerrormail();
			objerrormail.sendErrorMail(endpoint,ex.getMessage(),"canCancelRequest",TravelId,"",intSiteID+"");
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "canCancelRequest", "Failed",intSiteID+"");
		}
		return strOutput;
	}
	
	//Method added by manoj chand on 03 oct 2013 to call cancancelrequest method of web service
	public String[] CancelRequestMATA(String endpoint,String TravelId,int intSiteID,String strXML,String strXMLParam,String strTravelType)
	{
		java.lang.String reply="",strcancelflag="",strreason="";
		String strOutput[] = null;
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", strXML);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			
			TicketingServiceSoapProxy obj=new TicketingServiceSoapProxy();
			obj.setEndpoint(endpoint);
			reply = obj.cancelRequest(strXML,strXMLParam);
			
			responseObject.setStrErrorMessage(reply);
			//logging
			JSONObject jRespObj = new JSONObject();
			jRespObj.put("ResponseObject", responseObject.toString());
			responseBeanResponse=jRespObj.toString();
			
			Parser objparse = new Parser();
			strOutput = objparse.parsexmlstring(reply);
			strcancelflag = strOutput[0];
			strreason = strOutput[1];
			
			if(strcancelflag!=null && !strcancelflag.equals("") && (strcancelflag.equalsIgnoreCase("YES") || strcancelflag.equalsIgnoreCase("NO"))){
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "MATA", "CancelRequest", "Success",intSiteID+"");
				if(strcancelflag.equalsIgnoreCase("NO")){
					updatereqstatus(TravelId,strTravelType);
				}
			}
			else{
				WSerrormail objerrormail=new WSerrormail();
				//objerrormail.sendErrorMail(endpoint,"Wrong XML output string: "+reply,"CancelRequest",TravelId,"",intSiteID+"");
				strOutput[0]="NO";
				strOutput[1]="Wrong XML output string";
				updatereqstatus(TravelId,strTravelType);
			}	
		} catch(Exception ex){
			System.out.println("*********Error occurred in CancelRequestMATA() method of MATA in WSClient.java********");
			WSerrormail objerrormail=new WSerrormail();
			objerrormail.sendErrorMail(endpoint,ex.getMessage(),"CancelRequest",TravelId,"",intSiteID+"");
			strOutput[0]="NO";
			strOutput[1]="Error occured while calling web service.";
			updatereqstatus(TravelId,strTravelType);
		}
		return strOutput;
	}
	
	//Method added by manoj chand on 03 oct 2013 to call cancancelrequest method of web service
	public String[] CancelRequestERP(String company,String endpoint,String TravelId,int intSiteID,String strXML,String strXMLParam)
	{
		java.lang.String reply="",strcancelflag="",strreason="";
		String strOutput[] = null;
		JSONObject jObj = new JSONObject();
		try {
			jObj.put("xmlstring", strXML);
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		String requestBeanResponse=jObj.toString();
		ResponseObject responseObject = new ResponseObject();
		String responseBeanResponse="";
		try {
			
			if(company.equalsIgnoreCase("MATE")){
				wsclient.erpwebservice.mate.ServiceSoapProxy obj = new wsclient.erpwebservice.mate.ServiceSoapProxy();
				obj.setEndpoint(endpoint);
				reply = obj.cancelRequest(strXML,strXMLParam);
			}
			if(company.equalsIgnoreCase("MIND")){
				wsclient.erpwebservice.mind.ServiceSoapProxy obj = new wsclient.erpwebservice.mind.ServiceSoapProxy();
				obj.setEndpoint(endpoint);
				//reply = obj.cancelRequest(strXML,strXMLParam);
			}
			
			responseObject.setStrErrorMessage(reply);
			//logging
			JSONObject jRespObj = new JSONObject();
			jRespObj.put("ResponseObject", responseObject.toString());
			responseBeanResponse=jRespObj.toString();
			
			Parser objparse = new Parser();
			strOutput = objparse.parsexmlstring(reply);
			strcancelflag = strOutput[0];
			strreason = strOutput[1];
			
			if(strcancelflag!=null && !strcancelflag.equals("") && (strcancelflag.equalsIgnoreCase("YES") || strcancelflag.equalsIgnoreCase("NO"))){
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "CancelRequest", "Success",intSiteID+"");
			}
			else{
				WSerrormail objerrormail=new WSerrormail();
				objerrormail.sendErrorMail(endpoint,reply,"CancelRequest",TravelId,"",intSiteID+"");
				WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "CancelRequest", "Failed",intSiteID+"");
			}	
		} catch(Exception ex){
			System.out.println("*********Error occurred in CancelRequestERP() method of eMPro in WSClient.java********");
			WSerrormail objerrormail=new WSerrormail();
			objerrormail.sendErrorMail(endpoint,ex.getMessage(),"CancelRequest",TravelId,"",intSiteID+"");
			WSLoggingUtility.logRequestResponse(requestBeanResponse, responseBeanResponse, "eMPro", "CancelRequest", "Failed",intSiteID+"");
		}
		return strOutput;
	}
	
	public void updatereqstatus(String travelid,String traveltype){
		String strSql = "UPDATE dbo.T_TRAVEL_STATUS set TRAVEL_STATUS_ID = '10' WHERE TRAVEL_TYPE='"+traveltype+"' AND TRAVEL_ID="+travelid;
		DbConnectionBean objCon = new DbConnectionBean();
		int x  = objCon.executeUpdate(strSql);
	}
}
