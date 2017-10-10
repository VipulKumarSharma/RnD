/***************************************************
*Copyright (C) 2000 MIND
*All rights reserved.
*The information contained here in is confidential and proprietary to MIND and forms the part of the MIND 
*Created BY			:	Manoj Chand
*Date				:	18 Sept 2013
*Description		:	Servlet to call web service.
*Project			:	STARS
**********************************************************/ 


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import src.connection.DbConnectionBean;
import src.connection.PropertiesLoader;
import wsclient.Parser;
import wsclient.WSClient;
/**
 * Servlet implementation class CancelTrip
 */
public class CancelTrip extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancelTrip() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	String strActionFlag = request.getParameter("actionflag");
	Connection con	= null;
	ResultSet rs = null;
	Statement stmt = null;
	String strSql = null,strERPOptionXML="",strCompany="";
	DbConnectionBean objCon = new DbConnectionBean();
	String strResult = "";
	
	if(strActionFlag.equals("cancancelrequest")){
		
		String strERPURL = request.getParameter("erpurl");
		String strMATAURL = request.getParameter("mataurl");
		String strCID = request.getParameter("cid");
		String strReqNo = request.getParameter("requestnumber").trim();
		String strTravelID = request.getParameter("travel_id");
		String strSiteID = request.getParameter("site_id")==null?"0":request.getParameter("site_id");
		int intSiteID = Integer.parseInt(strSiteID); 
		String strinputString = "<root><UnitCode>"+strSiteID.trim()+"</UnitCode><star_id>"+strReqNo+"</star_id></root>";
		response.setContentType("text/html; charset=UTF-8");
		String[] result1=null,result2=null;
		//strSql = "SELECT mc.COMPANY_NAME,mc.ERP_XML from dbo.M_COMPANY mc WHERE mc.CID="+strCID;
		try {
			if(strMATAURL!=null && !strMATAURL.equals("")){
				WSClient objClient = new WSClient();
				result1 = objClient.canCancelRequestMATA(strMATAURL, strTravelID, intSiteID, strinputString, PropertiesLoader.config.getProperty("mataxmloption"));
				
				if(result1!=null && result1[0]!=null && result1[0].equalsIgnoreCase("YES")){
						strResult = "yes";
				}else{
					strResult = "This journey can not be cancelled as:\n "+result1[1];
				}
			}
			//strResult = "yes";
		} catch (Exception e) {
			System.out.println("error occured in cancancelrequest block in cancedtrip file --->"+e.getMessage());
		}
		response.getWriter().write(strResult);
	}
	
	if(strActionFlag.equals("cancelrequest")){
		
		String strERPURL = request.getParameter("erpurl");
		String strMATAURL = request.getParameter("mataurl");
		String strCID = request.getParameter("cid");
		String strReqNo = request.getParameter("requestnumber").trim();
		String strTravelID = request.getParameter("travel_id");
		String strSiteID = request.getParameter("site_id")==null?"0":request.getParameter("site_id");
		String strTravelType = request.getParameter("travel_type");
		int intSiteID = Integer.parseInt(strSiteID); 
		String strinputString = "<root><UnitCode>"+strSiteID.trim()+"</UnitCode><star_id>"+strReqNo+"</star_id></root>";
		response.setContentType("text/html; charset=UTF-8");
		String[] result1=null;
		strSql = "UPDATE dbo.T_TRAVEL_STATUS set TRAVEL_STATUS_ID = '6' WHERE TRAVEL_TYPE='"+strTravelType+"' AND TRAVEL_ID="+strTravelID;
		int x  = objCon.executeUpdate(strSql);
		//strSql = "SELECT mc.COMPANY_NAME,mc.ERP_XML from dbo.M_COMPANY mc WHERE mc.CID="+strCID;
		try {
			if(strMATAURL!=null && !strMATAURL.equals("")){
				WSClient objClient = new WSClient();
				result1 = objClient.CancelRequestMATA(strMATAURL, strTravelID, intSiteID, strinputString, PropertiesLoader.config.getProperty("mataxmloption"),strTravelType);
				if(result1!=null && result1[0]!=null && result1[0].equalsIgnoreCase("YES")){
					strResult = "TT";
				}else if(result1!=null && result1[0]!=null && result1[0].equalsIgnoreCase("NO")){
					strResult = "Not cancelled due to the reason of: "+result1[1];
				}
				else{
					strResult = "Error";
				}
			}
			//strResult = "TT";
		} catch (Exception e) {
			System.out.println("error occured in cancelrequest block in cancedtrip file --->"+e.getMessage());
		}
		response.getWriter().write(strResult);
	}
	try {
		if(con!=null)
			con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	}
}
