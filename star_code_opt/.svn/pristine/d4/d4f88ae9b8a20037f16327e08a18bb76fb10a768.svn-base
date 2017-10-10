
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import src.connection.DbConnectionBean;

public class AutoCompleteNames extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AutoCompleteNames() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Statement stmt			=	null;
		ResultSet rs			=	null;
		DbConnectionBean objCon	=	new DbConnectionBean();
		Connection con			=	objCon.getConnection();
		JSONObject json 		= 	null;
		String nameType			= 	request.getParameter("type");		
		String term 			= 	request.getParameter("term");
		int i 					= 	0;
		
		if (nameType.equalsIgnoreCase("city"))
		{	Set<JSONObject> cityList = new LinkedHashSet<JSONObject>();		
	        Map<Integer, List<Map<String, String>>> cityNameMap = new HashMap<Integer, List<Map<String, String>>>();
			try 
			{	String sSqlStr	= "select CITY_NAME as citycode from M_CITY where Status_ID=10 and (CITY_NAME  like '"+term+"%' or CITY_CODE like '"+term+"%') order by CITY_NAME";

				stmt		= con.createStatement(); 
				rs			= stmt.executeQuery(sSqlStr);
				while(rs.next())
				{	if(!cityNameMap.containsKey(i)) 
					{	cityNameMap.put(i, new ArrayList<Map<String, String>>());
					}
					Map<String, String> dataMap = new HashMap<String, String>();
					dataMap.put("CITYCODE", rs.getString("citycode"));	
					cityNameMap.get(i).add(dataMap);
					
					i++;
				}
				Set<Entry<Integer, List<Map<String,String>>>> entrySet =  cityNameMap.entrySet();
				Iterator<Entry<Integer, List<Map<String,String>>>> it = entrySet.iterator();
				
				while(it.hasNext()){
					Entry<Integer, List<Map<String,String>>> entry = it.next();
					for(int j=0; j<entry.getValue().size(); j++) {
						json = new JSONObject();					
							json.put("label", entry.getValue().get(j).get("CITYCODE"));
							cityList.add(json);
					}
				}
				JSONArray jsArray = new JSONArray(cityList);	 
				response.getWriter().print(jsArray);

			} catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(nameType.equalsIgnoreCase("airline"))
		{	Set<JSONObject> airlineList = new LinkedHashSet<JSONObject>();		
	        Map<Integer, List<Map<String, String>>> airlineNameMap = new HashMap<Integer, List<Map<String, String>>>();
			try 
			{	String sSqlStr	= "select AIRLINE_CODE+' - '+AIRLINE_NAME as airlinename from M_AIRLINE_COMPANIES where Status_ID=10 and (AIRLINE_NAME  like '"+term+"%' or AIRLINE_CODE like '"+term+"%') order by AIRLINE_CODE;";

				stmt		= con.createStatement(); 
				rs			= stmt.executeQuery(sSqlStr);
				while(rs.next())
				{	if(!airlineNameMap.containsKey(i)) 
					{	airlineNameMap.put(i, new ArrayList<Map<String, String>>());
					}
					Map<String, String> dataMap = new HashMap<String, String>();
					dataMap.put("AIRLINENAME", rs.getString("airlinename"));	
					airlineNameMap.get(i).add(dataMap);
					
					i++;
				}
				Set<Entry<Integer, List<Map<String,String>>>> entrySet =  airlineNameMap.entrySet();
				Iterator<Entry<Integer, List<Map<String,String>>>> it = entrySet.iterator();
				
				while(it.hasNext()){
					Entry<Integer, List<Map<String,String>>> entry = it.next();
					for(int j=0; j<entry.getValue().size(); j++) {
						json = new JSONObject();					
							json.put("label", entry.getValue().get(j).get("AIRLINENAME"));
							airlineList.add(json);
					}
				}
				JSONArray jsArray = new JSONArray(airlineList);	 
				response.getWriter().print(jsArray);

			} catch(Exception e){
				e.printStackTrace();
			}
		}
		else if (nameType.equalsIgnoreCase("country"))
		{	Set<JSONObject> countryList = new LinkedHashSet<JSONObject>();		
	        Map<Integer, List<Map<String, String>>> countryNameMap = new HashMap<Integer, List<Map<String, String>>>();
			try 
			{	String sSqlStr	= "select COUNTRY_NAME from M_COUNTRY where COUNTRY_NAME like '"+term+"%' order by COUNTRY_NAME";
	
				stmt		= con.createStatement(); 
				rs			= stmt.executeQuery(sSqlStr);
				while(rs.next())
				{	if(!countryNameMap.containsKey(i)) 
					{	countryNameMap.put(i, new ArrayList<Map<String, String>>());
					}
					Map<String, String> dataMap = new HashMap<String, String>();
					dataMap.put("COUNTRYNAME", rs.getString("COUNTRY_NAME"));	
					countryNameMap.get(i).add(dataMap);
					
					i++;
				}
				Set<Entry<Integer, List<Map<String,String>>>> entrySet =  countryNameMap.entrySet();
				Iterator<Entry<Integer, List<Map<String,String>>>> it = entrySet.iterator();
				
				while(it.hasNext()){
					Entry<Integer, List<Map<String,String>>> entry = it.next();
					for(int j=0; j<entry.getValue().size(); j++) {
						json = new JSONObject();					
							json.put("label", entry.getValue().get(j).get("COUNTRYNAME"));
							countryList.add(json);
					}
				}
				JSONArray jsArray = new JSONArray(countryList);	 
				response.getWriter().print(jsArray);
	
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		else
		{	}
	}
}
