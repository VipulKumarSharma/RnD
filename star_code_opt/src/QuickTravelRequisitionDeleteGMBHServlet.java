

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import src.connection.DbConnectionBean;

/**
 * Servlet implementation class QuickTravelRequisitionDeleteGMBHServlet
 */
public class QuickTravelRequisitionDeleteGMBHServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private  Connection objCon;
	private  DbConnectionBean dbConBean;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuickTravelRequisitionDeleteGMBHServlet() {
        super();        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		
		String[] strTravelCarIdTemp 	= null;
		String[] strAccomIdTemp 	    = null;
		
		String strActionBtnType 		= 	(request.getParameter("actionBtn") == null) ? "":request.getParameter("actionBtn");
		String strSuserId				= 	(request.getParameter("suserId") == null) ? "":request.getParameter("suserId");
		String strTravelId				= 	(request.getParameter("travelId") == null) ? "":request.getParameter("travelId");
		String strTravelReqId			= 	(request.getParameter("travelReqId") == null) ? "":request.getParameter("travelReqId");
		String strTravelType 			= 	(request.getParameter("travelType") == null) ? "":request.getParameter("travelType");		
		String strTravelMode			= 	(request.getParameter("travelMode") == null) ? "":request.getParameter("travelMode");
		String strTravelCarId			= 	(request.getParameter("travelCarId") == null) ? "":request.getParameter("travelCarId");
		String strTravelCarIdArr		= 	(request.getParameter("travelCarIdArr") == null) ? "":request.getParameter("travelCarIdArr");
		String strRowCountRentCar		= 	(request.getParameter("rowCountRentCar") == null) ? "":request.getParameter("rowCountRentCar");
		String strAccomId				= 	(request.getParameter("accomId") == null) ? "":request.getParameter("accomId");		
		String strAccomIdArr			= 	(request.getParameter("accomIdArr") == null) ? "":request.getParameter("accomIdArr");
		String strRowCountAccom  		= 	(request.getParameter("rowCountAccom") == null) ? "":request.getParameter("rowCountAccom");
		String strGrpTravellerId		= 	(request.getParameter("grpTravellerId") == null) ? "":request.getParameter("grpTravellerId");	
		String strRowCountGroupGuest	= 	(request.getParameter("rowCountGroupGuest") == null) ? "":request.getParameter("rowCountGroupGuest");
		
		
		String delimiter = ",";		
		strTravelCarIdTemp = strTravelCarIdArr.split(delimiter);
		ArrayList<String> travelCarIdValuesList = new ArrayList<String>();
		for (int l = 0; l < strTravelCarIdTemp.length; l++) {
			travelCarIdValuesList.add(strTravelCarIdTemp[l]);
	    }
		
		strAccomIdTemp = strAccomIdArr.split(delimiter);
		ArrayList<String> accomIdValuesList = new ArrayList<String>();
		for (int k = 0; k < strAccomIdTemp.length; k++) {
			accomIdValuesList.add(strAccomIdTemp[k]);
	    }		
		
		
		
		dbConBean  = new DbConnectionBean();
		objCon  = dbConBean.getConnection(); 
	 	CallableStatement objCstmt = null;
		int intSuccess =  0;
			
		if(strActionBtnType.equals("flightNoBtn") || strActionBtnType.equals("trainNoBtn")) {
			try {			
				objCstmt = objCon.prepareCall("{?=call PROC_DELETE_T_JOURNEY_DETAILS(?,?,?,?,?)}");
			    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			    objCstmt.setString(2, strTravelId);
			    objCstmt.setString(3, strTravelType);
			    objCstmt.setString(4, strTravelMode);
			    objCstmt.setString(5, strSuserId);	
			    objCstmt.setInt(6, 0); 
			    intSuccess   =  objCstmt.executeUpdate();
				objCstmt.close();							
			} catch (SQLException e) {
		        e.printStackTrace();
		    } catch(Exception e) {
		    	e.printStackTrace();
		    }
		} else if(strActionBtnType.equals("rentCarNoBtn")) {
			for (int i =0; i < travelCarIdValuesList.size() ; i++) {	
				 if(!travelCarIdValuesList.get(i).equals("")) {
					try {			
						  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_CAR_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  	          objCstmt.setString(2, travelCarIdValuesList.get(i));
			  	          objCstmt.setString(3, strTravelId);
			  	          objCstmt.setString(4, strTravelType);
			  	          objCstmt.setString(5, ""); 
			  	          objCstmt.setString(6, "");
			  			  objCstmt.setString(7, "");
			  			  objCstmt.setString(8, "");
			  			  objCstmt.setString(9, "");
			  		      objCstmt.setString(10, "");
			  			  objCstmt.setString(11, ""); 
			  			  objCstmt.setString(12, ""); 	
			  			  objCstmt.setString(13, ""); 
			  			  objCstmt.setString(14, "");
			  			  objCstmt.setString(15, ""); 
			  			  objCstmt.setString(16, "");
			  			  objCstmt.setString(17, "");
			  			  objCstmt.setString(18, "");
			  			  objCstmt.setString(19, "");
			  			  objCstmt.setString(20, "");
			  			  objCstmt.setString(21, "");
			  			  objCstmt.setString(22, strSuserId); 
			  			  objCstmt.setString(23, "DELETE"); 
			  			  objCstmt.setString(24, request.getRemoteAddr());
			  			  objCstmt.setInt(25, 0);
			  			  intSuccess   =  objCstmt.executeUpdate();
			  			  objCstmt.close();	
					} catch (SQLException e) {
				        e.printStackTrace();
				    } catch(Exception e) {
				    	e.printStackTrace();
				    }
				 }
			}
			
			try {  
	  			  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_T_JOURNEY_DETAILS(?,?,?,?,?)}");
			      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			      objCstmt.setString(2, strTravelId);
			      objCstmt.setString(3, strTravelType);
			      objCstmt.setString(4, "5");
			      objCstmt.setString(5, strSuserId);	
			      objCstmt.setInt(6, 0); 
			      intSuccess   =  objCstmt.executeUpdate();
				  objCstmt.close();		
				  
			} catch (SQLException e) {
		        e.printStackTrace();
		    } catch(Exception e) {
		    	e.printStackTrace();
		    }
		} else if(strActionBtnType.equals("rentCarDelBtn")) {
			if(!strTravelCarId.equals("")) {
				try {			
					  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_CAR_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		  	          objCstmt.setString(2, strTravelCarId);
		  	          objCstmt.setString(3, strTravelId);
		  	          objCstmt.setString(4, strTravelType);
		  	          objCstmt.setString(5, ""); 
		  	          objCstmt.setString(6, "");
		  			  objCstmt.setString(7, "");
		  			  objCstmt.setString(8, "");
		  			  objCstmt.setString(9, "");
		  		      objCstmt.setString(10, "");
		  			  objCstmt.setString(11, ""); 
		  			  objCstmt.setString(12, ""); 	
		  			  objCstmt.setString(13, ""); 
		  			  objCstmt.setString(14, "");
		  			  objCstmt.setString(15, ""); 
		  			  objCstmt.setString(16, "");
		  			  objCstmt.setString(17, "");
		  			  objCstmt.setString(18, "");
		  			  objCstmt.setString(19, "");
		  			  objCstmt.setString(20, "");
		  			  objCstmt.setString(21, "");
		  			  objCstmt.setString(22, strSuserId); 
		  			  objCstmt.setString(23, "DELETE"); 
		  			  objCstmt.setString(24, request.getRemoteAddr());
		  			  objCstmt.setInt(25, 0);
		  			  intSuccess   =  objCstmt.executeUpdate();
		  			  objCstmt.close();					  
				} catch (SQLException e) {
			        e.printStackTrace();
			    } catch(Exception e) {
			    	e.printStackTrace();
			    }
			}
			
			if(strRowCountRentCar.equals("1")) {
				try {  
		  			  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_T_JOURNEY_DETAILS(?,?,?,?,?)}");
				      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				      objCstmt.setString(2, strTravelId);
				      objCstmt.setString(3, strTravelType);
				      objCstmt.setString(4, "5");
				      objCstmt.setString(5, strSuserId);	
				      objCstmt.setInt(6, 0); 
				      intSuccess   =  objCstmt.executeUpdate();
					  objCstmt.close();		
					  
				} catch (SQLException e) {
			        e.printStackTrace();
			    } catch(Exception e) {
			    	e.printStackTrace();
			    }
			}
		} else if(strActionBtnType.equals("AccomNoBtn")) {
			for (int i =0; i < accomIdValuesList.size() ; i++) {	
				 if(!accomIdValuesList.get(i).equals("")) {
					 try {
						  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_ACCOMMODATION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			  	          objCstmt.setString(2, accomIdValuesList.get(i));
			  	          objCstmt.setString(3, strTravelReqId);
			  	          objCstmt.setString(4, strTravelId);
			  	          objCstmt.setString(5, strTravelType); 
			  	          objCstmt.setString(6, "");
			  			  objCstmt.setString(7, "");
			  			  objCstmt.setDouble(8, Double.parseDouble("0"));		  			 
			  			  objCstmt.setString(9, "");
			  		      objCstmt.setString(10, "");
			  			  objCstmt.setString(11, ""); 			  			  
			  			  objCstmt.setString(12, strSuserId); 
			  			  objCstmt.setString(13, "DELETE"); 
			  			  objCstmt.setString(14, request.getRemoteAddr()); 
			  			  objCstmt.setInt(15, 0); 
			  			  intSuccess   =  objCstmt.executeUpdate();
			  			  objCstmt.close();
					 } catch (SQLException e) {
					        e.printStackTrace();
				     } catch(Exception e) {
				    	e.printStackTrace();
				     }
				 }
			  }
			
			 try {
				  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_T_JOURNEY_DETAILS(?,?,?,?,?)}");
			      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			      objCstmt.setString(2, strTravelId);
			      objCstmt.setString(3, strTravelType);
			      objCstmt.setString(4, "7");
			      objCstmt.setString(5, strSuserId);	
			      objCstmt.setInt(6, 0); 
			      intSuccess   =  objCstmt.executeUpdate();
				  objCstmt.close();	
			 } catch (SQLException e) {
			        e.printStackTrace();
		     } catch(Exception e) {
		    	e.printStackTrace();
		     }
		} else if(strActionBtnType.equals("AccomDelBtn")) {
			if(!strAccomId.equals("")) {
				 try {
					  objCstmt = objCon.prepareCall("{?=call PROC_T_TRAVEL_ACCOMMODATION(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		  			  objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
		  	          objCstmt.setString(2, strAccomId);
		  	          objCstmt.setString(3, strTravelReqId);
		  	          objCstmt.setString(4, strTravelId);
		  	          objCstmt.setString(5, strTravelType); 
		  	          objCstmt.setString(6, "");
		  			  objCstmt.setString(7, "");
		  			  objCstmt.setDouble(8, Double.parseDouble("0"));		  			 
		  			  objCstmt.setString(9, "");
		  		      objCstmt.setString(10, "");
		  			  objCstmt.setString(11, ""); 		  			  
		  			  objCstmt.setString(12, strSuserId); 
		  			  objCstmt.setString(13, "DELETE"); 
		  			  objCstmt.setString(14, request.getRemoteAddr()); 
		  			  objCstmt.setInt(15, 0); 
		  			  intSuccess   =  objCstmt.executeUpdate();
		  			  objCstmt.close();
				 } catch (SQLException e) {
				        e.printStackTrace();
			     } catch(Exception e) {
			    	e.printStackTrace();
			     }
			 }
			
			if(strRowCountAccom.equals("1")){
				try {
					  objCstmt = objCon.prepareCall("{?=call PROC_DELETE_T_JOURNEY_DETAILS(?,?,?,?,?)}");
				      objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
				      objCstmt.setString(2, strTravelId);
				      objCstmt.setString(3, strTravelType);
				      objCstmt.setString(4, "7");
				      objCstmt.setString(5, strSuserId);	
				      objCstmt.setInt(6, 0); 
				      intSuccess   =  objCstmt.executeUpdate();
					  objCstmt.close();	
				 } catch (SQLException e) {
				        e.printStackTrace();
			     } catch(Exception e) {
			    	e.printStackTrace();
			     }
			}
		} else if(strActionBtnType.equals("groupGuestDelBtn")) {
			if(!strGrpTravellerId.equals("")) {
				try {			
					objCstmt=objCon.prepareCall("{?=call PROC_T_GROUP_USERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				    objCstmt.registerOutParameter(1,java.sql.Types.INTEGER);
			        objCstmt.setString(2,strGrpTravellerId);
				    objCstmt.setString(3,strTravelId);
				    objCstmt.setString(4, "");
				    objCstmt.setString(5, "");
				    objCstmt.setString(6, "");
				    objCstmt.setString(7, "");
				    objCstmt.setString(8, "");
				    objCstmt.setString(9, "50");
				    objCstmt.setString(10, "");
				    objCstmt.setString(11, "");
				    objCstmt.setString(12, "");
				    objCstmt.setString(13, "");
				    objCstmt.setString(14, "");
				    objCstmt.setString(15, "");
				    objCstmt.setString(16, "");
				    objCstmt.setString(17, "");
				    objCstmt.setString(18, "");
				    objCstmt.setString(19, "");
				    objCstmt.setString(20, "");
				    objCstmt.setString(21, "");
				    objCstmt.setString(22, "");
			        objCstmt.setString(23, "");
			        objCstmt.setString(24, ""); 
				    objCstmt.setString(25, strSuserId);
				    objCstmt.setString(26, "DELETE");
		  	        objCstmt.setString(27, "");
		  	        objCstmt.setString(28, "");
		  	        objCstmt.setString(29, "");
		  	        objCstmt.setString(30, "");
		  	        objCstmt.setString(31, "");
		  	        objCstmt.setString(32, "");
		            objCstmt.registerOutParameter(33,java.sql.Types.INTEGER);
		  			intSuccess   =  objCstmt.executeUpdate();
		  			objCstmt.close();					  
				} catch (SQLException e) {
			        e.printStackTrace();
			    } catch(Exception e) {
			    	e.printStackTrace();
			    }
			}		
		}	
	}
}
