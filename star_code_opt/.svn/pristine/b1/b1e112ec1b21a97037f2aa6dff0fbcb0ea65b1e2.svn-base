
import java.io.IOException;
import java.io.StringWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import src.beans.AccomodationBean;
import src.beans.AccomodationBeanList;
import src.beans.CancellationBean;
import src.beans.CancellationBeanList;
import src.beans.InsuranceBean;
import src.beans.InsuranceBeanList;
import src.beans.TicketBean;
import src.beans.TicketBeanList;
import src.beans.VisaBean;
import src.beans.VisaBeanList;
import src.connection.DbConnectionBean;

public class Single_PersonnelBookingServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	public static final String BOOKING_REQUEST_ID_KEY_VALUE = "lockBookingRequestIds";
	static Logger logger = Logger.getLogger(Single_PersonnelBookingServlet.class.getName());
	
	BookingStatusServlet bookingStatusServlet = new BookingStatusServlet();

    public Single_PersonnelBookingServlet() 
    {   super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{}
	
	public String[] dbDateFormat(String[] str)
	{
		String[] newStr		= new String[str.length];
		for (int i=0;i<str.length;i++)
		{	if(str[i] != "")
			{	String[] parts	= (str[i].trim()).split("/");
				newStr[i] 		= parts[2]+"-"+parts[1]+"-"+parts[0];
				//System.err.println("ConvertedDate="+newStr[i]);
			}else 
			{	newStr[i]			= "";
				//System.err.println("ConvertedDate="+newStr[i]);
			}
		}
		return newStr;
	}
	public String dbDateFormat(String str)
	{	if(str != "")
		{	String[] parts	= (str.trim()).split("/");
			str 			= parts[2]+"-"+parts[1]+"-"+parts[0];
			//System.err.println("ConvertedDate="+str);
		}else 
		{	str			= "";
			//System.err.println("ConvertedDate="+str);
		}
		return str;
	}
	public String[] getCityCode(String[] str)
	{	for (int i=0;i<str.length;i++)
		{	if(str[i].indexOf("-") != -1)
			{	String[] parts	= (str[i]).split("-");
				str[i]			= parts[1].trim();	
			}
		}
		return str;
	}
	public String[] getAirlineCode(String[] str)
	{	for (int i=0;i<str.length;i++)
		{	if(str[i].indexOf("-") != -1)
			{	String[] parts	= (str[i]).split("-");
				str[i]			= parts[0].trim();
			}
		}
		return str;
	}
	
	public String getSectorCode(String sector) throws SQLException {
		
		DbConnectionBean objCon	= new DbConnectionBean();
		Connection con			= objCon.getConnection();
		Statement stmt 			= con.createStatement();
		ResultSet rs 			= stmt.executeQuery("select dbo.fn_getairportcode('"+sector.trim()+"','C') AS SECTOR_CODE");
		if (rs.next()) {
			sector = rs.getString("SECTOR_CODE")==null?"":rs.getString("SECTOR_CODE").trim();
		}
		rs.close();
		stmt.close();
		con.close();
		
		return sector;
	}
	
	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		logger.setLevel(Level.ALL);
		logger.info("[Single_PersonnelBookingServlet] doPost block start ---->");
		
		HttpSession hs 			= request.getSession();
		String tBookId			= (String) request.getParameter("hidTravelBookingId")==null? "0" :request.getParameter("hidTravelBookingId") ;
		String travelerName		= "";
		String travelType		= "";
		String mobNo			= "";
		String dob				= "";
		String frxDetail		= "";
		String bookedBy			= "";
		String userId 			= "";
		
		String siteId			= "";
		String siteName			= "";
		String travelId			= "";
		String travellerID		= "";
		String grpTrFlag		= "";
		String trvlStusId		= "";
		String tReqNo			= "";
		String remarks			= "";
		String lstUpdDt			= "";
		
		String   sector 		=   "";
		String[] tktBookId		= null;
		String[] secFrom 		= null;
		String[] secTo 			= null;
		String[] classType 		= null;
		String[] deptrDate 		= null;
		String[] deptrTime 		= null;
		String[] arrDate 		= null;
		String[] arrTime 		= null;
		String[] airlineType	= null;
		String[] pnr 			= null;
		String[] ticketNo 		= null;
		String[] bscFare 		= null;
		String[] taxes 			= null;
		String[] ttlFare 		= null;
		String[] tktStatus 		= null;
		String[] tktRemarks 	= null;
		
		String[] visaStatusId	= null;
		String[] hidVisaBookId	= null;
		String[] pprtNo 		= null;
		String[] ppExpDate 		= null;
		String[] visaType 		= null;
		String[] country 		= null;
		String[] docRecDate 	= null;
		String[] visaIssuDate	= null;
		String[] visaValFrom	= null;
		String[] visaValTo 		= null;
		String[] durOfStay 		= null;
		String[] entryType 		= null;
		String[] visaCharges	= null;
		String[] visaRem 		= null;
		
		String[] insuStatus		= null; 
		String[] hidInsuBookId	= null;
		String[] insuPolNo 		= null;
		String[] insuStDate 	= null;
		String[] insuEndDate 	= null;
		String[] insuType 		= null;
		String[] nominee 		= null;
		String[] relation 		= null;
		String[] insuCharges 	= null;
		String[] insuRemarks 	= null;
		
		String[] hidAccBookId	= null;
		String[] stayType 		= null;
		String[] location 		= null;
		String[] chkInDate 		= null;
		String[] chkOutDate 	= null;
		String[] stayCharges 	= null;
		String[] stayRemarks 	= null;
		
		String   cnclMailFlag   = "false";
		String   chkbox			= "N";
		String[] hidTrvlCnclId	= null;
		String[] tktIssuDate 	= null;
		String[] cnclSecFrom 	= null;
		String[] cnclSecTo 		= null;
		String[] tktCnclDate 	= null;
		String[] pnrNo 			= null;
		String[] tktNo 			= null;
		String[] cnclCharges 	= null;
		String[] cnclReason 	= null;
		String[] refundRemarks 	= null;
		String[] mailSentFlag   = null;
		
		String hTktJson 		=	"";
		String hVisaJson 		=	"";
		String hInsuJson 		=	"";
		String hAccJson 		=	"";
		String hCnclJson 		=	"";
		
		String ticketXML		=	"";
		String visaXML			=	"";
		String insuXML			=	"";
		String accXML			=	"";
		String cnclXML			=	"";
		
		Boolean editMode		= Boolean.parseBoolean((String) (request.getParameter("hidEditMode") == null? false:request.getParameter("hidEditMode")));
		Boolean tktDataFlag		= Boolean.parseBoolean((String) (request.getParameter("hidTicketDataFlag") == null? false:request.getParameter("hidTicketDataFlag")));
		Boolean visaDataFlag	= Boolean.parseBoolean((String) (request.getParameter("hidVisaDataFlag") == null? false:request.getParameter("hidVisaDataFlag")));
		Boolean insuDataFlag	= Boolean.parseBoolean((String) (request.getParameter("hidInsuDataFlag") == null? false:request.getParameter("hidInsuDataFlag")));
		Boolean accDataFlag		= Boolean.parseBoolean((String) (request.getParameter("hidAccDataFlag") == null? false:request.getParameter("hidAccDataFlag")));
		Boolean cnclDataFlag	= Boolean.parseBoolean((String) (request.getParameter("hidCnclDataFlag") == null? false:request.getParameter("hidCnclDataFlag")));
		Boolean closeFlag		= Boolean.parseBoolean((String) (request.getParameter("hidCloseFlag") == null? false:request.getParameter("hidCloseFlag")));
		
		//System.out.println("editMode="+editMode+"  tktDataFlag="+tktDataFlag+"  visaDataFlag="+visaDataFlag+"  insuDataFlag="+insuDataFlag+"  accDataFlag="+accDataFlag+"  cnclDataFlag="+cnclDataFlag);
		
		travelType	=	(String) request.getParameter("travelType")==null? "" 		:request.getParameter("travelType") ;
		grpTrFlag	=	(String) request.getParameter("hidgrpTravelFlag")==null? "N":request.getParameter("hidgrpTravelFlag") ;
		
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Date[] arr 			= null;
		Date min 			= null;
		Date date 			= new Date();
		String currentDate	= new SimpleDateFormat("yyyy-MM-dd").format(date);
		String travelDate	= "";
		
		try
		{
			logger.info("[Single_PersonnelBookingServlet] TKT JSON building block start ---->");
			if (tktDataFlag)
			{	
				tktBookId		= request.getParameterValues("hidTktBookId");
				secFrom 		= (String[]) (request.getParameterValues("secFrom"));
				secTo 			= (String[]) (request.getParameterValues("secTo"));
				classType 		= request.getParameterValues("hidclassType");
				deptrDate 		= (String[]) dbDateFormat(request.getParameterValues("deptrDate"));
				deptrTime 		= request.getParameterValues("deptrTime");
				arrDate 		= (String[]) dbDateFormat(request.getParameterValues("arrDate"));
				arrTime 		= request.getParameterValues("arrTime");
				airlineType		= (String[]) getAirlineCode(request.getParameterValues("airlineType"));
				pnr 			= request.getParameterValues("pnr");
				ticketNo 		= request.getParameterValues("ticketNo");
				/*bscFare 		= request.getParameterValues("bscFare");
				taxes 			= request.getParameterValues("taxes");*/
				ttlFare 		= request.getParameterValues("ttlFare");
				tktStatus 		= request.getParameterValues("hidtktStatus");
				tktRemarks 		= request.getParameterValues("tktRemarks");
			
				hTktJson 		= "[";
				//System.err.println("secFrom.length="+secFrom.length);
				for(int i=0;i< secFrom.length;i++)
				{	if(i == (secFrom.length)-1)
					{	hTktJson = hTktJson + "{'tktBookId' : '"+tktBookId[i]+"','secFrom' : '"+secFrom[i]+"', 'secTo' :'"+secTo[i]+"', 'classType' : '"+classType[i]+"', 'deptrDate' : '"+deptrDate[i]+"', 'deptrTime' :'"+deptrTime[i]+"', 'arrDate' :'"+arrDate[i]+"', 'arrTime' : '"+arrTime[i]+"', 'airlineType' :'"+airlineType[i]+"', 'pnr' : '"+pnr[i]+"', 'ticketNo' : '"+ticketNo[i]+"', 'bscFare' :'', 'taxes' : '', 'ttlFare' : '"+ttlFare[i]+"', 'tktStatus' :'"+tktStatus[i]+"', 'tktRemarks' :'"+tktRemarks[i]+"', 'grpUserIds' :''}";	
					}
					else
					{	hTktJson = hTktJson + "{'tktBookId' : '"+tktBookId[i]+"','secFrom' : '"+secFrom[i]+"', 'secTo' :'"+secTo[i]+"', 'classType' : '"+classType[i]+"', 'deptrDate' : '"+deptrDate[i]+"', 'deptrTime' :'"+deptrTime[i]+"', 'arrDate' :'"+arrDate[i]+"', 'arrTime' : '"+arrTime[i]+"', 'airlineType' :'"+airlineType[i]+"', 'pnr' : '"+pnr[i]+"', 'ticketNo' : '"+ticketNo[i]+"', 'bscFare' :'', 'taxes' : '', 'ttlFare' : '"+ttlFare[i]+"', 'tktStatus' :'"+tktStatus[i]+"', 'tktRemarks' :'"+tktRemarks[i]+"', 'grpUserIds' :''},";
					}
				}
				hTktJson = hTktJson + "]";
				
				sector 	= getSectorCode(secFrom[0]);
				for(int i=0;i<secTo.length;i++)
				{	sector	=	sector+"-"+getSectorCode(secTo[i]); 
				}
				//System.err.println("sector= "+sector);
				//System.out.println("\nhTktJson= "+hTktJson);
				
				try 
				{	arr = new Date[deptrDate.length];
					if (deptrDate.length > 0) 
		               {     for (int i = 0; i < deptrDate.length; i++) 
		                     { 	if((deptrDate[i]).equals(""))
		                     	{	arr[i] = new Date();
		                     	}
		                     	else	
		                     		arr[i] = sdf.parse(deptrDate[i]);
		                     }
		               		 min	= arr[0];
		                     for (int i = 0; i < (arr.length); i++) 
		                     {  
		                    	if (min.compareTo(arr[i]) > 0) 
		                 		{      min = arr[i];
		                 		} 
		                     }
		                     travelDate = (min.getYear()+1900) + "-"+ (min.getMonth()+1) + "-" + min.getDate();
		               }else 
		               {     travelDate = currentDate.trim();
		               }
		        }catch (ParseException ex) 
		        {   //System.out.println("Min. Deptr Date NOT Found");
		        	ex.printStackTrace();
		        }
			}if ((tBookId.equals("0") || editMode) && !tktDataFlag)
			{	hTktJson = "[{'tktBookId' : '','secFrom' : '', 'secTo' :'', 'classType' : '', 'deptrDate' : '', 'deptrTime' :'', 'arrDate' :'', 'arrTime' : '', 'airlineType' :'', 'pnr' : '', 'ticketNo' : '', 'bscFare' :'', 'taxes' : '', 'ttlFare' : '', 'tktStatus' :'', 'tktRemarks' :'', 'grpUserIds' :''}]";
				travelDate = currentDate.trim();
				//System.out.println("\nhTktJson= "+hTktJson);
			}
			logger.info("[Single_PersonnelBookingServlet] TKT JSON building block end.");
			
		}catch(Exception e)
		{	logger.info("[Single_PersonnelBookingServlet] TKT JSON building failed !");
			e.printStackTrace();
		}
		
		String[] parts = travelDate.split("-");
        if(Integer.parseInt(parts[1]) < 10)
        {   parts[1] = "0"+parts[1];
        }
        if(Integer.parseInt(parts[2]) < 10)
        {   parts[2] = "0"+parts[2];
        }
        travelDate = parts[0]+"-"+parts[1]+"-"+parts[2];
        //System.out.println("Min. DEPTR. Date::::"+travelDate);
       
        try
        {	
        	logger.info("[Single_PersonnelBookingServlet] VISA JSON building block start ---->");
        	if(travelType.equalsIgnoreCase("I")) 
        	{	if (visaDataFlag)
				{	
					hidVisaBookId	= request.getParameterValues("hidVisaBookId");
					visaStatusId	= request.getParameterValues("visaStatus");
					pprtNo 			= request.getParameterValues("pprtNo");
					ppExpDate 		= (String[]) dbDateFormat(request.getParameterValues("ppExpDate"));
					visaType 		= request.getParameterValues("hidvisaType");
					country 		= request.getParameterValues("country");
					/*docRecDate 		= (String[]) dbDateFormat(request.getParameterValues("docRecDate"));
					visaIssuDate	= (String[]) dbDateFormat(request.getParameterValues("visaIssuDate"));*/
					visaValFrom		= (String[]) dbDateFormat(request.getParameterValues("visaValFrom"));
					visaValTo 		= (String[]) dbDateFormat(request.getParameterValues("visaValTo"));
					durOfStay 		= request.getParameterValues("durOfStay");
					entryType 		= request.getParameterValues("hidentryType");
					visaCharges		= request.getParameterValues("visaCharges");
					visaRem 		= request.getParameterValues("visaRem");
					
					hVisaJson 		= "[";
					//System.err.println("pprtNo.length="+pprtNo.length);
					for(int i=0;i< pprtNo.length;i++)
					{	if(i == (pprtNo.length)-1)
						{	hVisaJson = hVisaJson + "{'visaBookId' : '"+hidVisaBookId[i]+"','visaStatusId' : '"+visaStatusId[i]+"','pprtNo' : '"+pprtNo[i]+"', 'ppExpDate' :'"+ppExpDate[i]+"', 'visaType' : '"+visaType[i]+"', 'country' : '"+country[i]+"', 'docRecDate' :'', 'visaIssuDate' :'', 'visaValFrom' : '"+visaValFrom[i]+"', 'visaValTo' :'"+visaValTo[i]+"', 'durOfStay' : '"+durOfStay[i]+"', 'entryType' : '"+entryType[i]+"', 'visaCharges' :'"+visaCharges[i]+"', 'visaRem' : '"+visaRem[i]+"'}";	
						}
						else
						{	hVisaJson = hVisaJson + "{'visaBookId' : '"+hidVisaBookId[i]+"','visaStatusId' : '"+visaStatusId[i]+"','pprtNo' : '"+pprtNo[i]+"', 'ppExpDate' :'"+ppExpDate[i]+"', 'visaType' : '"+visaType[i]+"', 'country' : '"+country[i]+"', 'docRecDate' :'', 'visaIssuDate' :'', 'visaValFrom' : '"+visaValFrom[i]+"', 'visaValTo' :'"+visaValTo[i]+"', 'durOfStay' : '"+durOfStay[i]+"', 'entryType' : '"+entryType[i]+"', 'visaCharges' :'"+visaCharges[i]+"', 'visaRem' : '"+visaRem[i]+"'},";
						}
					}
					hVisaJson = hVisaJson + "]";
					
				} if ((tBookId.equals("0") || editMode) && !visaDataFlag) {
					hVisaJson = "[{'visaBookId' : '','visaStatusId' : '','pprtNo' : '', 'ppExpDate' :'', 'visaType' : '', 'country' : '', 'docRecDate' :'', 'visaIssuDate' :'', 'visaValFrom' : '', 'visaValTo' :'', 'durOfStay' : '', 'entryType' : '', 'visaCharges' :'', 'visaRem' : ''}]";
					
				}
        	} else {
        		hVisaJson = "[{'visaBookId' : '','visaStatusId' : '','pprtNo' : '', 'ppExpDate' :'', 'visaType' : '', 'country' : '', 'docRecDate' :'', 'visaIssuDate' :'', 'visaValFrom' : '', 'visaValTo' :'', 'durOfStay' : '', 'entryType' : '', 'visaCharges' :'', 'visaRem' : ''}]";
        	}
        	//System.out.println("hVisaJson= "+hVisaJson);
        	logger.info("[Single_PersonnelBookingServlet] VISA JSON building block end.");
        	
		}catch(Exception e)
		{	logger.info("[Single_PersonnelBookingServlet] VISA JSON building failed !");
			e.printStackTrace();
		}
        
		try
	    {	
			logger.info("[Single_PersonnelBookingServlet] INSU JSON building block start ---->");
			if(travelType.equalsIgnoreCase("I")) 
        	{	if (insuDataFlag)
				{	
					hidInsuBookId	= request.getParameterValues("hidInsuBookId");
					insuStatus		= request.getParameterValues("hidInsuStatus"); 
					insuPolNo 		= request.getParameterValues("insuPolNo");
					insuStDate 		= (String[]) dbDateFormat(request.getParameterValues("insuStDate"));
					insuEndDate 	= (String[]) dbDateFormat(request.getParameterValues("insuEndDate"));
					insuType 		= request.getParameterValues("hidinsuType");
					nominee 		= request.getParameterValues("nominee");
					relation 		= request.getParameterValues("relation");
					insuCharges 	= request.getParameterValues("insuCharges");
					insuRemarks 	= request.getParameterValues("insuRemarks");
					
					hInsuJson 		= "[";
					//System.err.println("insuPolNo.length="+insuPolNo.length);
					for(int i=0;i< insuPolNo.length;i++) {	
						if(i == (insuPolNo.length)-1)
						{	hInsuJson = hInsuJson + "{'insuBookId' : '"+hidInsuBookId[i]+"','insuStatus' : '"+insuStatus[i]+"','insuPolNo' : '"+insuPolNo[i]+"', 'insuStDate' :'"+insuStDate[i]+"', 'insuEndDate' : '"+insuEndDate[i]+"', 'insuType' : '"+insuType[i]+"', 'nominee' :'"+nominee[i]+"', 'relation' :'"+relation[i]+"', 'insuCharges' : '"+insuCharges[i]+"', 'insuRemarks' :'"+insuRemarks[i]+"'}";	
						}
						else
						{	hInsuJson = hInsuJson + "{'insuBookId' : '"+hidInsuBookId[i]+"','insuStatus' : '"+insuStatus[i]+"','insuPolNo' : '"+insuPolNo[i]+"', 'insuStDate' :'"+insuStDate[i]+"', 'insuEndDate' : '"+insuEndDate[i]+"', 'insuType' : '"+insuType[i]+"', 'nominee' :'"+nominee[i]+"', 'relation' :'"+relation[i]+"', 'insuCharges' : '"+insuCharges[i]+"', 'insuRemarks' :'"+insuRemarks[i]+"'},";
						}
					}
					hInsuJson = hInsuJson + "]";
					
				} if ((tBookId.equals("0") || editMode) && !insuDataFlag) {
					hInsuJson = "[{'insuBookId' : '', 'insuStatus' :'', 'insuPolNo' : '', 'insuStDate' :'', 'insuEndDate' : '', 'insuType' : '', 'nominee' :'', 'relation' :'', 'insuCharges' : '', 'insuRemarks' :''}]";
				}
        	} else {
        		hInsuJson = "[{'insuBookId' : '', 'insuStatus' :'', 'insuPolNo' : '', 'insuStDate' :'', 'insuEndDate' : '', 'insuType' : '', 'nominee' :'', 'relation' :'', 'insuCharges' : '', 'insuRemarks' :''}]";
        	}
			//System.out.println("hInsuJson= "+hInsuJson);
			logger.info("[Single_PersonnelBookingServlet] INSU JSON building block end.");
			
		}catch(Exception e)
		{	logger.info("[Single_PersonnelBookingServlet] INSU JSON building failed !");
			e.printStackTrace();
		}
		
		try
		{	
			logger.info("[Single_PersonnelBookingServlet] ACC JSON building block start ---->");
			if (accDataFlag)
			{	
				hidAccBookId	= request.getParameterValues("hidAccBookId");
				stayType 		= request.getParameterValues("hidstayType");
				location 		= request.getParameterValues("location");
				chkInDate 		= (String[]) dbDateFormat(request.getParameterValues("chkInDate"));
				chkOutDate 		= (String[]) dbDateFormat(request.getParameterValues("chkOutDate"));
				stayCharges 	= request.getParameterValues("stayCharges");
				stayRemarks 	= request.getParameterValues("stayRemarks");
				
				for(int i=0;i< stayCharges.length;i++) {
					if (stayCharges[i].equals("")) {
						stayCharges[i]="-1";
					}
				}
				
				hAccJson 		= "[";
				//System.err.println("stayCharges.length="+stayCharges.length);
				for(int i=0;i< stayCharges.length;i++)
				{	if(i == (stayCharges.length)-1)
					{	hAccJson = hAccJson + "{'accBookId' : '"+hidAccBookId[i]+"','stayType' : '"+stayType[i]+"', 'location' :'"+location[i]+"', 'chkInDate' : '"+chkInDate[i]+"', 'chkOutDate' : '"+chkOutDate[i]+"', 'stayCharges' :'"+stayCharges[i]+"', 'stayRemarks' :'"+stayRemarks[i]+"'}";	
					}
					else
					{	hAccJson = hAccJson + "{'accBookId' : '"+hidAccBookId[i]+"','stayType' : '"+stayType[i]+"', 'location' :'"+location[i]+"', 'chkInDate' : '"+chkInDate[i]+"', 'chkOutDate' : '"+chkOutDate[i]+"', 'stayCharges' :'"+stayCharges[i]+"', 'stayRemarks' :'"+stayRemarks[i]+"'},";
					}
				}
				hAccJson = hAccJson + "]";
			
			} if ((tBookId.equals("0") || editMode) && !accDataFlag) {	
				hAccJson = "[{'accBookId' : '','stayType' : '', 'location' :'', 'chkInDate' : '', 'chkOutDate' : '', 'stayCharges' :'', 'stayRemarks' :''}]";
			}
			//System.out.println("hAccJson= "+hAccJson);
			logger.info("[Single_PersonnelBookingServlet] ACC JSON building block end.");
			
		}catch(Exception e)
		{	logger.info("[Single_PersonnelBookingServlet] ACC JSON building failed !");
			e.printStackTrace();
		}
		
		int icount 		= Integer.parseInt(request.getParameter("flagIndex"));
		//System.out.println("icount-->"+icount);
		for (int i =0 ; i < icount ; i++) {
			String index = new Integer(i).toString();
			chkbox = request.getParameter("chkbox"+index) == null ? "N" :request.getParameter("chkbox"+index);
			//System.out.println("chkbox="+chkbox);
		}
		
		try
		{	
			logger.info("[Single_PersonnelBookingServlet] CNCL TKT JSON building block start ---->");
			tktBookId		= request.getParameterValues("hidTktBookId");
			secFrom 		= (String[]) (request.getParameterValues("secFrom"));
			secTo 			= (String[]) (request.getParameterValues("secTo"));
			pnr 			= request.getParameterValues("pnr");
			ticketNo 		= request.getParameterValues("ticketNo");
			
			if (!tBookId.equals("0") && cnclDataFlag && tktDataFlag)
			{	
				hidTrvlCnclId	= request.getParameterValues("hidTrvlCnclId");
				tktIssuDate 	= (String[]) dbDateFormat(request.getParameterValues("tktIssuDate"));
				cnclSecFrom 	= (String[]) (request.getParameterValues("cnclSecFrom"));
				cnclSecTo 		= (String[]) (request.getParameterValues("cnclSecTo"));
				tktCnclDate 	= (String[]) dbDateFormat(request.getParameterValues("tktCnclDate"));
				pnrNo 			= request.getParameterValues("pnrNo");
				tktNo 			= request.getParameterValues("tktNo");
				cnclCharges 	= request.getParameterValues("cnclCharges");
				cnclReason 		= request.getParameterValues("cnclReason");
				refundRemarks 	= request.getParameterValues("refundRemarks");
				mailSentFlag    = request.getParameterValues("hidmailSentFlag");
								
				for(int i=0; i<mailSentFlag.length;i++) {
					if(mailSentFlag[i].equalsIgnoreCase("Y")) {
						cnclMailFlag = "true";
						break;
					}
				}
				
				
				hCnclJson 		= "[";
				//System.err.println("tktBookId.length="+tktBookId.length);
				
				for(int i=0;i< tktBookId.length;i++) {
					
					String index = new Integer(i).toString();
					chkbox = request.getParameter("chkbox"+index) == null ? "N" :request.getParameter("chkbox"+index);
					
					if(tktBookId[i] != null && !"0".equals(tktBookId[i])) {
						if(i == (tktBookId.length)-1) {	
							hCnclJson = hCnclJson + "{'travelCnclId' : '"+hidTrvlCnclId[i]+"', 'chkbox' : '"+chkbox+"', 'tktIssuDate' : '"+tktIssuDate[i]+"', 'cnclSecFrom' :'"+secFrom[i]+"', 'cnclSecTo' : '"+secTo[i]+"', 'tktCnclDate' : '"+tktCnclDate[i]+"', 'pnrNo' :'"+pnr[i]+"', 'tktNo' :'"+ticketNo[i]+"', 'cnclCharges' : '"+cnclCharges[i]+"', 'cnclReason' :'"+cnclReason[i]+"', 'refundRemarks' : '"+refundRemarks[i]+"', 'mailSentFlag' :'"+mailSentFlag[i]+"', 'grpUserIds' :''}";	
						} else {	
							hCnclJson = hCnclJson + "{'travelCnclId' : '"+hidTrvlCnclId[i]+"', 'chkbox' : '"+chkbox+"', 'tktIssuDate' : '"+tktIssuDate[i]+"', 'cnclSecFrom' :'"+secFrom[i]+"', 'cnclSecTo' : '"+secTo[i]+"', 'tktCnclDate' : '"+tktCnclDate[i]+"', 'pnrNo' :'"+pnr[i]+"', 'tktNo' :'"+ticketNo[i]+"', 'cnclCharges' : '"+cnclCharges[i]+"', 'cnclReason' :'"+cnclReason[i]+"', 'refundRemarks' : '"+refundRemarks[i]+"', 'mailSentFlag' :'"+mailSentFlag[i]+"', 'grpUserIds' :''},";
						}
					}
					else {
						if(i == (tktBookId.length)-1) {	
							hCnclJson = hCnclJson + "{'travelCnclId' : '0', 'chkbox' : 'N', 'tktIssuDate' : '"+currentDate.trim()+"', 'cnclSecFrom' :'"+secFrom[i]+"', 'cnclSecTo' : '"+secTo[i]+"', 'tktCnclDate' : '', 'pnrNo' :'"+pnr[i]+"', 'tktNo' :'"+ticketNo[i]+"', 'cnclCharges' : '', 'cnclReason' :'', 'refundRemarks' : '', 'mailSentFlag' :'N', 'grpUserIds' :''}";	
						} else {	
							hCnclJson = hCnclJson + "{'travelCnclId' : '0', 'chkbox' : 'N', 'tktIssuDate' : '"+currentDate.trim()+"', 'cnclSecFrom' :'"+secFrom[i]+"', 'cnclSecTo' : '"+secTo[i]+"', 'tktCnclDate' : '', 'pnrNo' :'"+pnr[i]+"', 'tktNo' :'"+ticketNo[i]+"', 'cnclCharges' : '', 'cnclReason' :'', 'refundRemarks' : '', 'mailSentFlag' :'N', 'grpUserIds' :''},";
						}
					}
				}
				hCnclJson = hCnclJson + "]";
				
			}if ((tBookId.equals("0") && tktDataFlag) || (editMode && !cnclDataFlag && tktDataFlag)) {	
				
				hCnclJson 		= "[";
				for(int i=0;i< secFrom.length;i++)
				{	if(i == (secFrom.length)-1) {
						hCnclJson = hCnclJson + "{'travelCnclId' : '0', 'chkbox' : 'N', 'tktIssuDate' : '"+currentDate.trim()+"', 'cnclSecFrom' :'"+secFrom[i]+"', 'cnclSecTo' : '"+secTo[i]+"', 'tktCnclDate' : '', 'pnrNo' :'"+pnr[i]+"', 'tktNo' :'"+ticketNo[i]+"', 'cnclCharges' : '', 'cnclReason' :'', 'refundRemarks' : '', 'mailSentFlag' :'N', 'grpUserIds' :''}";	
					} else {	
						hCnclJson = hCnclJson + "{'travelCnclId' : '0', 'chkbox' : 'N', 'tktIssuDate' : '"+currentDate.trim()+"', 'cnclSecFrom' :'"+secFrom[i]+"', 'cnclSecTo' : '"+secTo[i]+"', 'tktCnclDate' : '', 'pnrNo' :'"+pnr[i]+"', 'tktNo' :'"+ticketNo[i]+"', 'cnclCharges' : '', 'cnclReason' :'', 'refundRemarks' : '', 'mailSentFlag' :'N', 'grpUserIds' :''},";
					}
				}
				hCnclJson = hCnclJson + "]";
				
			}if ((tBookId.equals("0") || editMode) && !tktDataFlag) {
				hCnclJson = "[{'travelCnclId' : '', 'chkbox' : '', 'tktIssuDate' : '', 'cnclSecFrom' :'', 'cnclSecTo' : '', 'tktCnclDate' : '', 'pnrNo' :'', 'tktNo' :'', 'cnclCharges' : '', 'cnclReason' :'', 'refundRemarks' : '', 'mailSentFlag' :'', 'grpUserIds' :''}]";
			}
			//System.out.println("hCnclJson= "+hCnclJson);
			logger.info("[Single_PersonnelBookingServlet] CNCL TKT JSON building block end.");
			
		}catch(Exception e)
		{	logger.info("[Single_PersonnelBookingServlet] CNCL TKT JSON building failed !");
			e.printStackTrace();
		}
		
		if(!hTktJson.equals("[]"))
		{	
			logger.info("[Single_PersonnelBookingServlet] TKT XML building block start ---->");
			TicketBean ticketBean=null;
			TicketBeanList<TicketBean> ticketList=new TicketBeanList<TicketBean>();
			
			ticketList.setTicketBean(new ArrayList <TicketBean>());
			JSONArray jsonArr;
			try 
			{	jsonArr = new JSONArray(hTktJson);
				for(int i=0;i<jsonArr.length();i++)
				{
					JSONObject jsonObject=jsonArr.getJSONObject(i);
					ticketBean=new TicketBean();
					
					ticketBean.setTktBookId(jsonObject.getString("tktBookId"));
					ticketBean.setAirline(jsonObject.getString("airlineType"));
					ticketBean.setArrDate(jsonObject.getString("arrDate"));
					ticketBean.setArrTime(jsonObject.getString("arrTime"));
					ticketBean.setBasicFare(jsonObject.getString("bscFare"));
					ticketBean.setCls(jsonObject.getString("classType"));
					ticketBean.setDeptrDate(jsonObject.getString("deptrDate"));
					ticketBean.setDeptrTime(jsonObject.getString("deptrTime"));
					ticketBean.seteTktNo(jsonObject.getString("ticketNo"));
					ticketBean.setPnr(jsonObject.getString("pnr"));
					ticketBean.setSecFrom1(jsonObject.getString("secFrom"));
					ticketBean.setSecTo1(jsonObject.getString("secTo"));
					ticketBean.setTaxes(jsonObject.getString("taxes"));
					ticketBean.setTktRemarks(jsonObject.getString("tktRemarks"));
					ticketBean.setTktStatus(jsonObject.getString("tktStatus"));
					ticketBean.setTotFare(jsonObject.getString("ttlFare"));
					ticketBean.setGrpUserId(jsonObject.getString("grpUserIds"));
					
					ticketList.getTicketBean().add(ticketBean);
				}
				
				JAXBContext jaxbContext = JAXBContext.newInstance(TicketBeanList.class);
		        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
		        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		        StringWriter journeyWriter = new StringWriter();
		        jaxbMarshaller.marshal(ticketList, journeyWriter);
		        ticketXML=journeyWriter.toString();
		        ticketXML=ticketXML.substring(56);

				//System.out.println(ticketXML);	
			} catch (JSONException e) {
				logger.info("[Single_PersonnelBookingServlet] TKT XML building block failed !");
				e.printStackTrace();
			} catch (JAXBException e) {
				logger.info("[Single_PersonnelBookingServlet] TKT XML building block failed !");
				e.printStackTrace();
			}
			logger.info("[Single_PersonnelBookingServlet] TKT XML building block end.");
		}
		if(!hVisaJson.equals("[]"))
		{
			logger.info("[Single_PersonnelBookingServlet] VISA XML building block start ---->");
			VisaBean visaBean=null;
			VisaBeanList<VisaBean> visaList=new VisaBeanList<VisaBean>();
			
			visaList.setVisaBean(new ArrayList <VisaBean>());
			JSONArray jsonArr;
			try 
			{	jsonArr = new JSONArray(hVisaJson);
				for(int i=0;i<jsonArr.length();i++)
				{
					JSONObject jsonObject=jsonArr.getJSONObject(i);
					visaBean=new VisaBean();
					
					visaBean.setVisaBookId(jsonObject.getString("visaBookId"));
					visaBean.setVisaStatusId(jsonObject.getString("visaStatusId"));
					visaBean.setCountry1(jsonObject.getString("country"));
					visaBean.setDocRecDt(jsonObject.getString("docRecDate"));
					visaBean.setDurOfStay(jsonObject.getString("durOfStay"));
					visaBean.setEntryType(jsonObject.getString("entryType"));
					visaBean.setPptExpDt(jsonObject.getString("ppExpDate"));
					visaBean.setPptNo(jsonObject.getString("pprtNo"));
					visaBean.setVisaCharges(jsonObject.getString("visaCharges"));
					visaBean.setVisaIssDt(jsonObject.getString("visaIssuDate"));
					visaBean.setVisaRemarks(jsonObject.getString("visaRem"));
					visaBean.setVisaType(jsonObject.getString("visaType"));
					visaBean.setVisaValFrom(jsonObject.getString("visaValFrom"));
					visaBean.setVisaValTo(jsonObject.getString("visaValTo"));
					visaList.getVisaBean().add(visaBean);
				}
				JAXBContext jaxbContext = JAXBContext.newInstance(VisaBeanList.class);
		        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
		        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		        StringWriter journeyWriter = new StringWriter();
		        jaxbMarshaller.marshal(visaList, journeyWriter);
		        visaXML=journeyWriter.toString();
		        visaXML=visaXML.substring(56);

		        //System.out.println(visaXML);	
			} catch (JSONException e) {
				logger.info("[Single_PersonnelBookingServlet] VISA XML building failed !");
				e.printStackTrace();
			} catch (JAXBException e) {
				logger.info("[Single_PersonnelBookingServlet] VISA XML building failed !");
				e.printStackTrace();
			} 
			logger.info("[Single_PersonnelBookingServlet] VISA XML building block end.");
		}
		
		if(!hInsuJson.equals("[]"))
		{
			logger.info("[Single_PersonnelBookingServlet] INSU XML building block start ---->");
			InsuranceBean insuBean=null;
			InsuranceBeanList<InsuranceBean> insuList=new InsuranceBeanList<InsuranceBean>();
			
			insuList.setInsuranceBean(new ArrayList <InsuranceBean>());
			JSONArray jsonArr;
			try 
			{	jsonArr = new JSONArray(hInsuJson);
				for(int i=0;i<jsonArr.length();i++)
				{
					JSONObject jsonObject=jsonArr.getJSONObject(i);
					insuBean=new InsuranceBean();
					
					insuBean.setInsuBookId(jsonObject.getString("insuBookId"));
					insuBean.setInsuStatus(jsonObject.getString("insuStatus"));
					insuBean.setInsuCharges(jsonObject.getString("insuCharges"));
					insuBean.setInsuEndDt(jsonObject.getString("insuEndDate"));
					insuBean.setInsuPolNo(jsonObject.getString("insuPolNo"));
					insuBean.setInsuRemarks(jsonObject.getString("insuRemarks"));
					insuBean.setInsuStDt(jsonObject.getString("insuStDate"));
					insuBean.setInsuType(jsonObject.getString("insuType"));
					insuBean.setNominee(jsonObject.getString("nominee"));
					insuBean.setRelation(jsonObject.getString("relation"));
					insuList.getInsuranceBean().add(insuBean);
				}
				
				JAXBContext jaxbContext = JAXBContext.newInstance(InsuranceBeanList.class);
		        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
		        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		        StringWriter journeyWriter = new StringWriter();
		        jaxbMarshaller.marshal(insuList, journeyWriter);
		        insuXML=journeyWriter.toString();
		        insuXML=insuXML.substring(56);

				//System.out.println(insuXML);	
			} catch (JSONException e) {
				logger.info("[Single_PersonnelBookingServlet] INSU XML building failed !");
				e.printStackTrace();
			} catch (JAXBException e) {
				logger.info("[Single_PersonnelBookingServlet] INSU XML building failed !");
				e.printStackTrace();
			} 
			logger.info("[Single_PersonnelBookingServlet] INSU XML building block end.");
		}
		if(!hAccJson.equals("[]"))
		{
			logger.info("[Single_PersonnelBookingServlet] ACC XML building block start ---->");
			AccomodationBean accBean=null;
			AccomodationBeanList<AccomodationBean> accList=new AccomodationBeanList<AccomodationBean>();
			
			accList.setAccomodationBean(new ArrayList <AccomodationBean>());
			JSONArray jsonArr;
			try 
			{	jsonArr = new JSONArray(hAccJson);
				for(int i=0;i<jsonArr.length();i++)
				{
					JSONObject jsonObject=jsonArr.getJSONObject(i);
					accBean=new AccomodationBean();
					
					accBean.setAccBookId(jsonObject.getString("accBookId"));
					accBean.setChkInDt(jsonObject.getString("chkInDate"));
					accBean.setChkOutDt(jsonObject.getString("chkOutDate"));
					accBean.setLocn(jsonObject.getString("location"));
					accBean.setStayCharges(jsonObject.getString("stayCharges"));
					accBean.setStayRemarks(jsonObject.getString("stayRemarks"));
					accBean.setStayType(jsonObject.getString("stayType"));
					accList.getAccomodationBean().add(accBean);
				}
				
				JAXBContext jaxbContext = JAXBContext.newInstance(AccomodationBeanList.class);
		        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
		        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		        StringWriter journeyWriter = new StringWriter();
		        jaxbMarshaller.marshal(accList, journeyWriter);
		        accXML=journeyWriter.toString();
		        accXML=accXML.substring(56);

				//System.out.println(accXML);	
			} catch (JSONException e) {
				logger.info("[Single_PersonnelBookingServlet] ACC XML building failed !");
				e.printStackTrace();
			} catch (JAXBException e) {
				logger.info("[Single_PersonnelBookingServlet] ACC XML building failed !");
				e.printStackTrace();
			}
			logger.info("[Single_PersonnelBookingServlet] ACC XML building block end.");
		}
		
		if(!hCnclJson.equals("[]"))
		{
			logger.info("[Single_PersonnelBookingServlet] CNCL TKT XML building block start ---->");
			CancellationBean cnclBean=null;
			CancellationBeanList<CancellationBean> cnclList=new CancellationBeanList<CancellationBean>();
			
			cnclList.setCancelBean(new ArrayList <CancellationBean>());
			JSONArray jsonArr;
			try 
			{	jsonArr = new JSONArray(hCnclJson);
				for(int i=0;i<jsonArr.length();i++)
				{
					JSONObject jsonObject=jsonArr.getJSONObject(i);
					cnclBean=new CancellationBean();
					
					cnclBean.setTravelCnclId(jsonObject.getString("travelCnclId"));
					cnclBean.setChkbox(jsonObject.getString("chkbox"));
					cnclBean.setCnclCharges(jsonObject.getString("cnclCharges"));
					cnclBean.setCnclReason(jsonObject.getString("cnclReason"));
					cnclBean.seteTktNo1(jsonObject.getString("tktNo"));
					cnclBean.setPnr1(jsonObject.getString("pnrNo"));
					cnclBean.setRefundRemarks(jsonObject.getString("refundRemarks"));
					cnclBean.setSecFrom2(jsonObject.getString("cnclSecFrom"));
					cnclBean.setSecTo2(jsonObject.getString("cnclSecTo"));
					cnclBean.setTktCnclDt(jsonObject.getString("tktCnclDate"));
					cnclBean.setTktIssuDt(jsonObject.getString("tktIssuDate"));
					cnclBean.setMailSentFlag(jsonObject.getString("mailSentFlag"));
					cnclBean.setGrpUserId(jsonObject.getString("grpUserIds"));
					
					cnclList.getCancelBean().add(cnclBean);
				}
				JAXBContext jaxbContext = JAXBContext.newInstance(CancellationBeanList.class);
		        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
		        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		        StringWriter journeyWriter = new StringWriter();
		        jaxbMarshaller.marshal(cnclList, journeyWriter);
		        cnclXML=journeyWriter.toString();
		        cnclXML=cnclXML.substring(56);

				//System.out.println(cnclXML);	
			} catch (JSONException e) {
				logger.info("[Single_PersonnelBookingServlet] CNCL TKT XML building failed !");
				e.printStackTrace();
			} catch (JAXBException e) {
				logger.info("[Single_PersonnelBookingServlet] CNCL TKT XML building failed !");
				e.printStackTrace();
			} 
			logger.info("[Single_PersonnelBookingServlet] CNCL TKT XML building block end.");
		}
		
		siteId		=	(String) request.getParameter("selectUnit")==null? "0" :request.getParameter("selectUnit") ;
		siteName	=	(String) request.getParameter("hidsiteName")==null? "Personal" :request.getParameter("hidsiteName") ;
		travelId	=	(String) request.getParameter("hidtravelID")==null? "-1" :request.getParameter("hidtravelID") ;
		travellerID	=	(String) request.getParameter("hidtravellerId")==null? "-1" :request.getParameter("hidtravellerId") ;
		trvlStusId	=	(String) request.getParameter("hidtravelStsId")==null? "2" :request.getParameter("hidtravelStsId") ;
		tReqNo		=	(String) request.getParameter("hidtravelReqNo")==null? "PERSONAL" :request.getParameter("hidtravelReqNo") ;
		remarks		=	(String) request.getParameter("hidtrRemark")==null? "" :request.getParameter("hidtrRemark") ;
		lstUpdDt	=	(String) request.getParameter("hidLstModDt")==null? currentDate.trim() :request.getParameter("hidLstModDt") ;			// modified date
		
		if(siteId.equals("-2")) {
			tReqNo = "MISCELLANEOUS";
		} else if (siteId.equals("0")) {
			tReqNo = "PERSONAL";
		} else if (tBookId.equals("0") && !siteId.equals("-2") && !siteId.equals("0")){
			tReqNo = siteName.trim()+"/PERSONAL";
		}

		//System.out.println("siteId="+siteId+"  siteName="+siteName+"  travelId="+travelId+"  grpTrFlag="+grpTrFlag+"  trvlStusId="+trvlStusId+"  tReqNo="+tReqNo+"  remarks="+remarks+" lstUpdDt="+lstUpdDt);
		
		String actn			=	"";
		
		if(closeFlag)
		{	actn			=	"UNLOCK";
		} else {	
			if(tBookId.equals("0"))
			{	actn		=	"INSERT";
			}else
			{	actn		=	"UPDATE";
			}
		}
		
		travelerName=	(String) request.getParameter("paxName")==null? "0" :request.getParameter("paxName") ;
		mobNo		=	(String) request.getParameter("mobileNo")==null? "" :request.getParameter("mobileNo") ;
		dob			=	(String) (request.getParameter("dob")==null? "" :dbDateFormat(request.getParameter("dob"))) ;
		frxDetail	=	(String) request.getParameter("forex")==null? "" :request.getParameter("forex") ;
		bookedBy	=	hs.getValue("user_id") == null ? "" : (String)hs.getValue("user_id");
		userId 		= 	bookedBy;
		
		//System.err.println("actn="+actn+"  travelerName="+travelerName+"  travelType="+travelType+"  mobNo="+mobNo+"  dob="+dob+"  frxDetail="+frxDetail+"  bookedBy="+bookedBy+" userId="+userId);
		String ipAddr		=	request.getRemoteAddr();
		int otktStatus		= 	-1;
		
		logger.info("[Single_PersonnelBookingServlet] PROC_UPDATE_T_TRAVEL_BOOKING_DETAIL calling started ---->");
		
		String dataSavingMsg	= "";
		DbConnectionBean objCon	= new DbConnectionBean();
		Connection con			= objCon.getConnection();
		CallableStatement cStmt = null;
		
		try 
		{	cStmt 	= con.prepareCall("{call PROC_UPDATE_T_TRAVEL_BOOKING_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");			
			
			cStmt.setString(1, tBookId);			
			cStmt.setString(2, siteId);
			cStmt.setString(3, travelId);			
			cStmt.setString(4, travelType);
			cStmt.setString(5, tReqNo);			
			cStmt.setString(6, grpTrFlag);
			cStmt.setString(7, travellerID);
			cStmt.setString(8, travelerName);	
			cStmt.setString(9, travelDate);			// min dept date
			cStmt.setString(10, mobNo);
			cStmt.setString(11, dob);
			cStmt.setString(12, sector);			
			cStmt.setString(13, frxDetail);
			cStmt.setString(14, trvlStusId);			
			cStmt.setString(15, remarks);
			cStmt.setString(16, ticketXML);			
			cStmt.setString(17, visaXML);
			cStmt.setString(18, insuXML);			
			cStmt.setString(19, accXML);
			cStmt.setString(20, cnclXML);			
			cStmt.setString(21, bookedBy);
			cStmt.setString(22, lstUpdDt);	
			cStmt.setString(23, "");	
			cStmt.setString(24, actn);
			cStmt.setString(25, userId);			
			cStmt.setString(26, ipAddr);
			cStmt.registerOutParameter(27,java.sql.Types.INTEGER);
			
			cStmt.executeUpdate();
			otktStatus = cStmt.getInt(27);
			request.setAttribute("otktStatus", otktStatus);
			cStmt.close();
			con.close();
			//System.out.println("otktStatus= "+otktStatus);
			if(otktStatus == 0)
			{	String delimiter = ",";		
				String sessionBookingRequestIds 			= null;
			    String[] strsessionBookingRequestIdsTemp 	= null;
			    
			    ArrayList<String> sessionBookingRequestIdList = new ArrayList<String>();
				//Map<String, Object> sessionData = SessionListener.getUserSessionData(hs.getId());
				Map<String, Map<String, Object>> sessionDataMap = SessionListener.getAllUserSessionData();
				Set<String> keySet = sessionDataMap.keySet();
				
				for(String userSessionID :  keySet)
				{	Map<String, Object> sessionData = sessionDataMap.get(userSessionID);
				
					if(sessionData != null && sessionData.containsKey(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE)) 
					{	sessionBookingRequestIds = (String) sessionData.get(SessionListener.BOOKING_REQUEST_ID_KEY_VALUE);
						strsessionBookingRequestIdsTemp = sessionBookingRequestIds.split(delimiter);
						
						for (int l = 0; l < strsessionBookingRequestIdsTemp.length; l++) 
						{	sessionBookingRequestIdList.add(strsessionBookingRequestIdsTemp[l]);
					    }
						
						if(sessionBookingRequestIdList.size() > 0) 
						{	for(int m = 0; m < sessionBookingRequestIdList.size(); m++) 
							{	if(sessionBookingRequestIdList.get(m).equals(tBookId))
								{	sessionBookingRequestIdList.remove(m);
								}
							}
						}
						sessionBookingRequestIds  = StringUtils.join(sessionBookingRequestIdList, ',');
						bookingStatusServlet.putLockBookingDataInSession(userSessionID, SessionListener.BOOKING_REQUEST_ID_KEY_VALUE,sessionBookingRequestIds);
					}
				}
				logger.info("[Single_PersonnelBookingServlet] Data Saved Successfully [TravelBookId = "+tBookId+"] [ReqNo = "+tReqNo+"]\n");
				
				System.out.println("*******************************************************************************************\n"
						+ "Data Saved Successfully [TravelBookId = "+tBookId+"] [ReqNo = "+tReqNo+"]\n"
						+ "*******************************************************************************************\n");
				
				dataSavingMsg = "Requisition data saved successfully";
				if(closeFlag) {
					dataSavingMsg = "Requisition unlocked successfully";
				}
			}
			else
			{	logger.info("[Single_PersonnelBookingServlet] Error"+otktStatus+": Data Saving Failed [TravelBookId = "+tBookId+"] [ReqNo = "+tReqNo+"]\n");
			
				System.out.println("*******************************************************************************************\n"
					+ "Error"+otktStatus+": Data Saving Failed [TravelBookId = "+tBookId+"] [ReqNo = "+tReqNo+"]\n"
					+ "*******************************************************************************************\n");
				
				dataSavingMsg = "Requisition data saving failed !";
				if(closeFlag) {
					if(!tBookId.equals("0")) {
						dataSavingMsg = "Requisition unlocked successfully";
					} else {
						dataSavingMsg = "";
					}
				}
			}
		} 
		catch (SQLException e) 
		{	
			logger.info("[Single_PersonnelBookingServlet] Data Saving Failed [TravelBookId = "+tBookId+"] [ReqNo = "+tReqNo+"]\n");
			
			System.out.println("*******************************************************************************************\n"
				+ "Data Saving Failed [TravelBookId = "+tBookId+"] [ReqNo = "+tReqNo+"]\n"
				+ "*******************************************************************************************\n");
			
			dataSavingMsg = "Requisition data saving failed !";
			if(closeFlag) {
				if(!tBookId.equals("0")) {
					dataSavingMsg = "Requisition unlocking failed !";
				} else {
					dataSavingMsg = "";
				}
			}
			e.printStackTrace();
		}
		logger.info("[Single_PersonnelBookingServlet] PROC_UPDATE_T_TRAVEL_BOOKING_DETAIL calling ended.");
		
		String currDate				= new SimpleDateFormat("dd/MM/yyyy").format(date);
		String bs_siteId 			= request.getParameter("hid_bs_siteId") == null ? "0" : request.getParameter("hid_bs_siteId");
		String bs_reqNo 			= request.getParameter("hid_bs_reqNo") == null ? "" : request.getParameter("hid_bs_reqNo");
		String bs_travelDateStr 	= request.getParameter("hid_bs_travelDateStr") == null  ? currDate : request.getParameter("hid_bs_travelDateStr") ;
		String bs_travelType 		= request.getParameter("hid_bs_travelType") == null ? "A" : request.getParameter("hid_bs_travelType");
		String bs_travellerId 		= request.getParameter("hid_bs_travellerId") == null ? "0" : request.getParameter("hid_bs_travellerId");
		String bs_bookingStatus 	= (request.getParameter("hid_bs_bookingStatus") == null || "".equals(request.getParameter("hid_bs_bookingStatus"))) ? "0" : request.getParameter("hid_bs_bookingStatus");
		String bs_bookedBy 			= (request.getParameter("hid_bs_bookedBy") == null || "".equals(request.getParameter("hid_bs_bookedBy"))) ? "0" : request.getParameter("hid_bs_bookedBy");
		String bs_reportType 		= (request.getParameter("hid_bs_reportType") == null || "".equals(request.getParameter("hid_bs_reportType"))) ? "0" : request.getParameter("hid_bs_reportType");
		String bs_travelStatus 		= (request.getParameter("hid_bs_travelStatus") == null || "".equals(request.getParameter("hid_bs_travelStatus"))) ? "10" : request.getParameter("hid_bs_travelStatus");
		
		logger.info("[Single_PersonnelBookingServlet] doPost block end.");
		
		response.sendRedirect("BookingStatusReport.jsp?trvlBookId="+tBookId+"&flag="+otktStatus+"&travelType="+travelType+"&cnclMailFlag="+cnclMailFlag+"&tReqNo="+tReqNo+"&siteName="+siteName+"&action="+actn+"&travelerName="+travelerName+"&etx_date="+bs_travelDateStr+"&etx_siteId="+bs_siteId+"&etx_travellerId="+bs_travellerId+"&etx_travelType="+bs_travelType+"&etx_reqNo="+bs_reqNo+"&etx_status="+bs_bookingStatus+"&etx_bookedBy="+bs_bookedBy+"&etx_reportType="+bs_reportType+"&etx_travelStatus="+bs_travelStatus+"&strMsg="+dataSavingMsg);
	}
}
