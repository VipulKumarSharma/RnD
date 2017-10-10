package wsclient;

import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import src.connection.DbConnectionBean;
import wsclient.mrswebservice.MRSServiceSoapProxy;

public class MRSWSClient {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		MRSWSClient obj=new MRSWSClient();
		obj.getTravelHotelDetails("http://172.29.55.243/MRSWebService/MRSService.asmx");
	}
	
	public void getTravelHotelDetails(String endpoint) {
		
		String xmlData = "";
		MRSServiceSoapProxy mrsService = new MRSServiceSoapProxy();
		mrsService.setEndpoint(endpoint);
		
		DbConnectionBean dbConBean			=	null;
		Connection objCon					=	null;
		CallableStatement cstmt				=	null;
		
		try {
				xmlData = mrsService.THDtlService(); //service called
				//System.out.println("xmlData--> " + xmlData);
				
				if(xmlData != null && !xmlData.equals("")) {
					
					dbConBean = new DbConnectionBean();
					objCon = dbConBean.getConnection();
					
					cstmt=objCon.prepareCall("{?=call PROC_MRS_ACCOMMODATION(?)}");
					cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
					cstmt.setString(2, xmlData);
					cstmt.execute();
					cstmt.close();
					objCon.close();
					
				}
				
		} catch(RemoteException re) {
			System.out.println("Error in getTravelHotelDetails.........RemoteException" + re);
			re.printStackTrace();
		} catch(SQLException se) {
			System.out.println("Error in getTravelHotelDetails.........SQLException" + se);
			se.printStackTrace();
		} catch(Exception e) {
			System.out.println("Error in getTravelHotelDetails.........Exception" + e);
			e.printStackTrace();
		} finally {
			try {
				if(dbConBean!=null) {
					dbConBean.close(); 
				}
			} catch(SQLException se) {
				System.out.println("Error in getTravelHotelDetails while closing the resource.........SQLException" + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("Error in getTravelHotelDetails while closing the resource.........Exception" + e);
				e.printStackTrace();
			}
		}
	}

}
