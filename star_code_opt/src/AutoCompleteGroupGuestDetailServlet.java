

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import src.connection.DbConnectionBean;

/**
 * Servlet implementation class AutoCompleteGroupGuestDetailServlet
 */
public class AutoCompleteGroupGuestDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AutoCompleteGroupGuestDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		String cUserId = request.getParameter("cUserId");
		String siteId = request.getParameter("siteId");
		String travelType = request.getParameter("travelType");
		String fName = request.getParameter("fName");
		String lName = request.getParameter("lName");
		String gUserId = request.getParameter("gUserId");
		String flag = request.getParameter("flag");		
		
		HashMap<String,String> dataMap = new HashMap<String,String>();	
		ArrayList<HashMap<String, String>> guestList = new ArrayList<HashMap<String, String>>();
		
		try {
			Statement stmt=null;
			ResultSet rs=null;
			String sSqlStr = "";
			DbConnectionBean objCon=new DbConnectionBean();
			Connection con=objCon.getConnection();
			
			if(flag != null && !flag.equals("") && flag.equals("getGuestList")) {
			
				if(travelType != null && !travelType.equals("") && travelType.equals("D")) {
					sSqlStr		= " SELECT DISTINCT MAX(TGU.G_USERID) AS G_USERID, " + 
							  " '<font color=f80009>'+TGU.FIRST_NAME+' '+ISNULL(TGU.LAST_NAME,'')+'</font><br><font color=004000><b>Date of Birth</b></font>-'+CONVERT(VARCHAR(10),TGU.DOB,103)+'<br><font color=004000><b>Identity Name</b></font>-'+MIP.IDENTITY_NAME+'<br><font color=004000><b>Identity Number</b></font>-'+TGU.IDENTITY_NO+'<br><font color=004000><b>Unit</b></font>-'+LTRIM(RTRIM(DBO.SITENAME(TGU.SITE_ID))) AS TRAVELLER " + 
							  " FROM DBO.T_GROUP_USERINFO TGU, DBO.M_IDENTITY_PROOF MIP WHERE TGU.IDENTITY_ID = MIP.IDENTITY_ID AND TGU.FIRST_NAME LIKE '%"+fName+"%' AND TGU.SITE_ID = "+siteId+" AND TGU.C_USER_ID = "+cUserId+" AND TGU.TRAVEL_TYPE = '"+travelType+"' AND TGU.STATUS_ID = 10 AND MIP.STATUS_ID = 10 AND TGU.APPLICATION_ID = 1 GROUP BY " +
							  " '<font color=f80009>'+TGU.FIRST_NAME+' '+ISNULL(TGU.LAST_NAME,'')+'</font><br><font color=004000><b>Date of Birth</b></font>-'+CONVERT(VARCHAR(10),TGU.DOB,103)+'<br><font color=004000><b>Identity Name</b></font>-'+MIP.IDENTITY_NAME+'<br><font color=004000><b>Identity Number</b></font>-'+TGU.IDENTITY_NO+'<br><font color=004000><b>Unit</b></font>-'+LTRIM(RTRIM(DBO.SITENAME(TGU.SITE_ID))) ";
				} else if(travelType != null && !travelType.equals("") && travelType.equals("I")) {
					sSqlStr		= " SELECT DISTINCT MAX(TGU.G_USERID) AS G_USERID, " + 
							  " '<font color=f80009>'+TGU.FIRST_NAME+' '+ISNULL(TGU.LAST_NAME,'')+'</font><br><font color=004000><b>Date of Birth</b></font>-'+CONVERT(VARCHAR(10),TGU.DOB,103)+'<br><font color=004000><b>Passport Number</b></font>-'+TGU.PASSPORT_NO+'<br><font color=004000><b>Unit</b></font>-'+LTRIM(RTRIM(DBO.SITENAME(TGU.SITE_ID))) AS TRAVELLER " + 
							  " FROM DBO.T_GROUP_USERINFO TGU WHERE TGU.FIRST_NAME LIKE '%"+fName+"%' AND TGU.SITE_ID = "+siteId+" AND TGU.C_USER_ID = "+cUserId+" AND TGU.TRAVEL_TYPE = '"+travelType+"' AND TGU.STATUS_ID = 10 AND TGU.APPLICATION_ID = 1 GROUP BY " +
							  " '<font color=f80009>'+TGU.FIRST_NAME+' '+ISNULL(TGU.LAST_NAME,'')+'</font><br><font color=004000><b>Date of Birth</b></font>-'+CONVERT(VARCHAR(10),TGU.DOB,103)+'<br><font color=004000><b>Passport Number</b></font>-'+TGU.PASSPORT_NO+'<br><font color=004000><b>Unit</b></font>-'+LTRIM(RTRIM(DBO.SITENAME(TGU.SITE_ID))) ";
				}
								
				stmt		= con.createStatement(); 
				rs			= stmt.executeQuery(sSqlStr);
				dataMap = new HashMap<String,String>();
				while(rs.next()){	
					dataMap = new HashMap<String,String>();					
					dataMap.put("TRAVELLER", rs.getString("TRAVELLER"));
					dataMap.put("GUSERID", rs.getString("G_USERID"));
					guestList.add(dataMap);
				}
				rs.close();				
				
				JSONArray jsArray = new JSONArray(guestList);	 
				response.getWriter().print(jsArray);
				
			} else if(flag != null && !flag.equals("") && flag.equals("getGuestDetail")) {
				
				String FIRSTNAME			=  "";
				String LASTNAME				=  "";
				String DESIGNATION			=  "";
				String DOB					=  "";
				String GENDER				=  "";
				String MEALPREF				=  "";
				String PASSPORTNO			=  "";
				String NATIONALITY			=  "";
				String PLACEISSUE			=  "";	
				String DATEISSUE			=  "";		
				String EXPIRYDATE			=  "";	
				String IDENTITYPROOF		=  "";
				String IDENTITYPROOFNO		=  "";				
				String MOBILENO      		=  "";				
				String ECNR					=  "";
				String VISA					=  "";
				
				String EMP_ID				=  "";
				String EMAIL_ADDR			=  "";
								
				sSqlStr		= " SELECT DISTINCT SITE_ID, G_EMP_CODE, G_EMAIL, FIRST_NAME, LAST_NAME, DESIG_ID, CONVERT(VARCHAR(10),DOB,103) AS DOB, GENDER, MAEL_ID, PASSPORT_NO, ISNULL(NATIONALITY ,'') AS NATIONALITY, CONVERT(VARCHAR(10),DATE_OF_ISSUE,103) AS DATE_OF_ISSUE, CONVERT(VARCHAR(10),EXPIRY_DATE,103) AS EXPIRY_DATE, PLACE_OF_ISSUE, VISA_REQUIRED, ECNR, IDENTITY_ID, IDENTITY_NO, MOBILE_NO" + 
						    " FROM DBO.T_GROUP_USERINFO WHERE G_USERID = "+gUserId+" AND SITE_ID = "+siteId+" AND C_USER_ID = "+cUserId+" AND TRAVEL_TYPE = '"+travelType+"' AND STATUS_ID = 10 AND APPLICATION_ID = 1";
				
				stmt		= con.createStatement(); 
				rs			= stmt.executeQuery(sSqlStr);
				if(rs.next()) {
					FIRSTNAME 		= rs.getString("FIRST_NAME");
					LASTNAME 		= rs.getString("LAST_NAME");
					DESIGNATION 	= rs.getString("DESIG_ID");
					DOB 			= rs.getString("DOB");
					GENDER 			= rs.getString("GENDER");
					MEALPREF 		= rs.getString("MAEL_ID");
					PASSPORTNO 		= rs.getString("PASSPORT_NO");
					NATIONALITY		= rs.getString("NATIONALITY");
					PLACEISSUE 		= rs.getString("PLACE_OF_ISSUE");
					DATEISSUE 		= rs.getString("DATE_OF_ISSUE");
					EXPIRYDATE 		= rs.getString("EXPIRY_DATE");
					IDENTITYPROOF 	= rs.getString("IDENTITY_ID");
					IDENTITYPROOFNO = rs.getString("IDENTITY_NO");
					MOBILENO 		= rs.getString("MOBILE_NO");					
					ECNR 			= rs.getString("ECNR");
					VISA 			= rs.getString("VISA_REQUIRED");
					
					EMP_ID			= rs.getString("G_EMP_CODE")==null?"":rs.getString("G_EMP_CODE").trim();
					EMAIL_ADDR		= rs.getString("G_EMAIL")==null?"":rs.getString("G_EMAIL").trim();
				}
				rs.close();
				
				dataMap.put("FIRSTNAME", FIRSTNAME);
				dataMap.put("LASTNAME", LASTNAME);
				dataMap.put("DESIGNATION", DESIGNATION);
				dataMap.put("DOB", DOB);
				dataMap.put("GENDER", GENDER);
				dataMap.put("MEALPREF", MEALPREF);
				dataMap.put("PASSPORTNO", PASSPORTNO);
				dataMap.put("NATIONALITY", NATIONALITY);
				dataMap.put("PLACEISSUE", PLACEISSUE);
				dataMap.put("DATEISSUE", DATEISSUE);
				dataMap.put("EXPIRYDATE", EXPIRYDATE);
				dataMap.put("IDENTITYPROOF", IDENTITYPROOF);
				dataMap.put("IDENTITYPROOFNO", IDENTITYPROOFNO);
				dataMap.put("MOBILENO", MOBILENO);
				dataMap.put("ECNR", ECNR);
				dataMap.put("VISA", VISA);		
				
				dataMap.put("EMP_ID", EMP_ID);
				dataMap.put("EMAIL_ADDR", EMAIL_ADDR);
				
				JSONObject jsObj = new JSONObject(dataMap);		
				response.getWriter().print(jsObj);
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}
	}
}
