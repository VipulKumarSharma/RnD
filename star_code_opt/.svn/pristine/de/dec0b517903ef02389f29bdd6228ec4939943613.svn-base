package src.beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TravelDetails implements Comparable<TravelDetails>
{
	private String journeyType;
	private String departureCity;
	private String arrivalCity;
	private String departureDate;
	private String preferredTimeType;
	private String preferredTime;
	private String travelMode;
	private String preferredClass;
	private String preferredCompany;
	private String preferredSeat;
	private String otherInfo;
	public String getJourneyType() {
		return journeyType;
	}
	public void setJourneyType(String journeyType) {
		this.journeyType = journeyType;
	}
	public String getDepartureCity() {
		return departureCity;
	}
	public void setDepartureCity(String departureCity) {
		this.departureCity = departureCity;
	}
	public String getArrivalCity() {
		return arrivalCity;
	}
	public void setArrivalCity(String arrivalCity) {
		this.arrivalCity = arrivalCity;
	}
	public String getDepartureDate() {
		return departureDate;
	}
	public void setDepartureDate(String departureDate) {
		this.departureDate = departureDate;
	}
	public String getPreferredTimeType() {
		return preferredTimeType;
	}
	public void setPreferredTimeType(String preferredTimeType) {
		this.preferredTimeType = preferredTimeType;
	}
	public String getPreferredTime() {
		return preferredTime;
	}
	public void setPreferredTime(String preferredTime) {
		this.preferredTime = preferredTime;
	}
	public String getTravelMode() {
		return travelMode;
	}
	public void setTravelMode(String travelMode) {
		this.travelMode = travelMode;
	}
	public String getPreferredClass() {
		return preferredClass;
	}
	public void setPreferredClass(String preferredClass) {
		this.preferredClass = preferredClass;
	}
	public String getPreferredCompany() {
		return preferredCompany;
	}
	public void setPreferredCompany(String preferredCompany) {
		this.preferredCompany = preferredCompany;
	}
	public String getPreferredSeat() {
		return preferredSeat;
	}
	public void setPreferredSeat(String preferredSeat) {
		this.preferredSeat = preferredSeat;
	}
	public String getOtherInfo() {
		return otherInfo;
	}
	public void setOtherInfo(String otherInfo) {
		this.otherInfo = otherInfo;
	}
	
	@Override
	public int compareTo(TravelDetails o) {
		// TODO Auto-generated method stub
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		try 
		{
			Date thisDate = dateFormat.parse(this.getDepartureDate());
			Date otherDate = dateFormat.parse(o.getDepartureDate());
			
			if(thisDate.compareTo(otherDate) == 0)
			{
				if(this.getPreferredTime().compareTo(o.getPreferredTime()) > 0)
					return 1;
				else if(this.getPreferredTime().compareTo(o.getPreferredTime()) == 0)
					return 0;
				else
					return -1;
			}
			else 
			{	
				if(thisDate.compareTo(otherDate) > 0)
					return 1;
				else
					return -1;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;		
	}
	
}
