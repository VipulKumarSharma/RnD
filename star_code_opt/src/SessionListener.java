import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.axis.utils.StringUtils;

import src.dao.starDaoImpl;

public class SessionListener  implements HttpSessionListener{
	
	private static Map<String, Map<String, Object>> userSessionDataMap = new HashMap<String, Map<String,Object>>();
	public static final String BOOKING_REQUEST_ID_KEY_VALUE = "lockBookingRequestIds";

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		userSessionDataMap.put(event.getSession().getId(), new HashMap<String, Object>());
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		String user_Id 		= (String) event.getSession().getValue("user_id");
		String ipAddress 	= (String) event.getSession().getValue("ipAddr");
		
		starDaoImpl sdi	= new starDaoImpl();
		sdi.updateLogoutInfoOnSessionTimeOut(user_Id, ipAddress);	// Method to update logout info in DB on Session Timeout
	  	
		String bookingRequestIds = userSessionDataMap.get(event.getSession().getId()) != null 
				? (String)userSessionDataMap.get(event.getSession().getId()).get(BOOKING_REQUEST_ID_KEY_VALUE) 
						: null;
				if(bookingRequestIds != null && !StringUtils.isEmpty(bookingRequestIds)){
					boolean isUpdated = BookingStatusServlet.updateBookingRequestLockFlag(bookingRequestIds);
				}
				userSessionDataMap.remove(event.getSession().getId());
	}
	
	public static Map<String, Object> getUserSessionData(String sessionId){
		return userSessionDataMap.get(sessionId);
	}
	
	public static void setUserSessionData(String sessionId, Map<String, Object> data){
		userSessionDataMap.put(sessionId, data);
	}
	
	public static Map<String, Map<String, Object>> getAllUserSessionData(){
		return userSessionDataMap;
	}

}
