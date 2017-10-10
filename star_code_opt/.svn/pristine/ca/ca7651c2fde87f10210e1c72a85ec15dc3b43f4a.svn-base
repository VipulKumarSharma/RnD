
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import src.connection.DbConnectionBean;

public class AutoCompletePassengerDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		String siteId 	= request.getParameter("siteId");
		String fName 	= request.getParameter("fName");
		String userId 	= request.getParameter("userId");
		String flag 	= request.getParameter("flag");		
		
		HashMap<String,String> dataMap = new HashMap<String,String>();	
		ArrayList<HashMap<String, String>> guestList = new ArrayList<HashMap<String, String>>();
		
		try {
			Statement stmt			= null;
			ResultSet rs			= null;
			String sSqlStr 			= "";
			DbConnectionBean objCon = new DbConnectionBean();
			Connection con			= objCon.getConnection();
			
			if(flag != null && !flag.equals("") && flag.equals("getPaxList")) {
			
				sSqlStr	= " SELECT DISTINCT USERID, '<font color=f80009>'+FIRSTNAME+' '+ISNULL(LASTNAME,'') +'</font><br> <font color=004000><b>DOB</b></font>-'+CONVERT(VARCHAR(10),DOB,103) +'<br> <font color=004000><b>Unit</b></font>-'+LTRIM(RTRIM(DBO.SITENAME(SITE_ID)))+'<br> <font color=004000><b>Email</b></font>-'+ EMAIL AS TRAVELLER FROM M_USERINFO WHERE FIRSTNAME LIKE '%"+fName+"%' AND SITE_ID = "+siteId+" AND STATUS_ID = 10 AND APPLICATION_ID = 1 ";
				
				stmt	= con.createStatement(); 
				rs		= stmt.executeQuery(sSqlStr);
				dataMap = new HashMap<String,String>();
				
				while(rs.next()){	
					dataMap = new HashMap<String,String>();					
					dataMap.put("TRAVELLER", rs.getString("TRAVELLER"));
					dataMap.put("USERID", rs.getString("USERID"));
					guestList.add(dataMap);
				}
				rs.close();				
				stmt.close();
				con.close();
				
				JSONArray jsArray = new JSONArray(guestList);	 
				response.getWriter().print(jsArray);
				
			} else if(flag != null && !flag.equals("") && flag.equals("getPaxDetail")) {
				
				String PAXNAME				=  "";
				String DOB					=  "";
				String CONTACTNO      		=  "";
				String PASSPORT_NO			=  "";
				String PP_EXPIRY_DATE		=  "";
								
				sSqlStr		= " SELECT DISTINCT DBO.SITENAME(SITE_ID) AS SITENAME, LTRIM(RTRIM(ISNULL(FIRSTNAME,'')))+' '+ LTRIM(RTRIM(ISNULL(LASTNAME,''))) AS PAXNAME, CONVERT(VARCHAR(10),DOB,103) AS DOB, CONTACT_NUMBER, EMAIL, PASSPORT_NO, CONVERT(VARCHAR(10),EXPIRY_DATE,103) AS EXPIRY_DATE FROM M_USERINFO " + 
						      " WHERE USERID = "+userId+" AND STATUS_ID = 10 AND APPLICATION_ID = 1";
				
				stmt		= con.createStatement(); 
				rs			= stmt.executeQuery(sSqlStr);
				if(rs.next()) {
					
					PAXNAME 		= rs.getString("PAXNAME")		==null ? "" 	: rs.getString("PAXNAME").trim();
					DOB 			= rs.getString("DOB")			==null ? "" 	: rs.getString("DOB").trim();
					CONTACTNO 		= rs.getString("CONTACT_NUMBER")==null ? "-" 	: rs.getString("CONTACT_NUMBER").trim();
					PASSPORT_NO		= rs.getString("PASSPORT_NO")	==null ? "-" 	: rs.getString("PASSPORT_NO").trim();
					PP_EXPIRY_DATE  = rs.getString("EXPIRY_DATE")	==null ? "" 	: rs.getString("EXPIRY_DATE").trim();
				}
				rs.close();
				stmt.close();
				con.close();
				
				dataMap.put("PAXNAME"		, PAXNAME);
				dataMap.put("DOB"			, DOB);
				dataMap.put("CONTACTNO"		, CONTACTNO);
				dataMap.put("PASSPORTNO"	, PASSPORT_NO);
				dataMap.put("PPEXPIRYDATE"	, PP_EXPIRY_DATE);
				
				JSONObject jsObj = new JSONObject(dataMap);		
				response.getWriter().print(jsObj);
			
			} else if(flag != null && !flag.equals("") && flag.equals("getVisaDetails")) {
				
				String country 	= request.getParameter("country") == null ? "0" : request.getParameter("country").trim();
				
				String VISA_VALID_FROM		=  "";
				String VISA_VALID_TO		=  "";
				String VISA_STAY_DURATION 	=  "0 Day(s)";
				String STAY_DURATION_VAL	=  "0";
				String STAY_DURATION_TYPE	=  "Day(s)";
				String VISA_EXPIRY_FLAG		=  "false";
								
				sSqlStr	= "SELECT isnull((select COUNTRY_NAME from M_COUNTRY where COUNTRY_ID=M_USERVISA.VISA_COUNTRY),'-') AS COUNTRY_NAME, M_USERVISA.VISA_COUNTRY, "
							+ " dbo.CONVERTDATEDMY1(VISA_ISSUANCE_DATE) AS VISA_ISSUANCE_DATE, dbo.CONVERTDATEDMY1(VISA_VALID_FROM) AS VISA_VALID_FROM, "
							+ " dbo.CONVERTDATEDMY1(VISA_VALID_TO) AS VISA_VALID_TO, isnull(VISA_STAY_DURATION,'0 Day(s)') AS VISA_STAY_DURATION "
							+ " FROM M_USERVISA WHERE USERID="+userId+" AND VISA_COUNTRY="+country;
				
				stmt	= con.createStatement(); 
				rs		= stmt.executeQuery(sSqlStr);
				
				if(rs.next()) {
					
					VISA_VALID_FROM 		= rs.getString("VISA_VALID_FROM")	== null ? "" 		: rs.getString("VISA_VALID_FROM").trim();
					VISA_VALID_TO 			= rs.getString("VISA_VALID_TO")		== null ? "" 		: rs.getString("VISA_VALID_TO").trim();
					VISA_STAY_DURATION 		= rs.getString("VISA_STAY_DURATION")== null ? "0 Day(s)": rs.getString("VISA_STAY_DURATION").trim();
					
					STAY_DURATION_VAL		= VISA_STAY_DURATION.split(" ")[0];
					STAY_DURATION_TYPE		= VISA_STAY_DURATION.split(" ")[1];
					
					if(!"".equals(VISA_VALID_TO)) {
						
						Date date 				= new Date();
						SimpleDateFormat sdf 	= new SimpleDateFormat("dd/MM/yyyy");
			        	String strTodayDate		= sdf.format(date);
			        	
			        	Date todayDate 			= sdf.parse(strTodayDate);
			        	Date visaExpiryDate 	= sdf.parse(VISA_VALID_TO);
			        	
			        	if(todayDate.compareTo(visaExpiryDate) > 0) {
			        		VISA_EXPIRY_FLAG	= "true";
			        		VISA_VALID_FROM		= "";
			        		VISA_VALID_TO		= "";
			        		VISA_STAY_DURATION	= "0 Day(s)";
			        		STAY_DURATION_VAL	= "0";
			        		STAY_DURATION_TYPE	= "Day(s)";
			        	
			        	} else {
			        		VISA_EXPIRY_FLAG = "false";
			        	}
					}
				}
				rs.close();
				stmt.close();
				con.close();
				
				dataMap.put("VISA_VALID_FROM"		, VISA_VALID_FROM);
				dataMap.put("VISA_VALID_TO"			, VISA_VALID_TO);
				dataMap.put("VISA_STAY_DURATION"	, VISA_STAY_DURATION);
				dataMap.put("STAY_DURATION_VAL"		, STAY_DURATION_VAL);
				dataMap.put("STAY_DURATION_TYPE"	, STAY_DURATION_TYPE);
				dataMap.put("VISA_EXPIRY_FLAG"		, VISA_EXPIRY_FLAG);
				
				JSONObject jsObj = new JSONObject(dataMap);		
				response.getWriter().print(jsObj);
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}
	}
}
