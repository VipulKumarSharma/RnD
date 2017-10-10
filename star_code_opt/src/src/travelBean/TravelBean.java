package src.travelBean;
import java.util.*;
public class TravelBean 
{
	String strTravelId             =  "";
    String strTravelMode1          =  "";
    String strTravelClass1         =  "";
    String strDepCity              =  "";                              
    String strDepDate              =  "";                              
    String strArrCity              =  "";
    String strNameOfAirline1       =  "";


	public void setTravelId(String strTravelId)
	{
		this.strTravelId = strTravelId;
	}
	public String getTravelId()
	{
		return this.strTravelId;
	}

	public void setDepCity(String strDepCity)
	{
		this.strDepCity = strDepCity;
	}
	public String getDepCity()
	{
		return this.strDepCity;
	}

	public void setDepDate(String strDepDate)
	{
		this.strDepDate = strDepDate;
	}
	public String getDepDate()
	{
		return this.strDepDate;
	}

	public void setArrCity(String strArrCity)
	{
		this.strArrCity = strArrCity;
	}
	public String getArrCity()
	{
		return this.strArrCity;
	}

	public void setTravelMode1(String strTravelMode1)
	{
		this.strTravelMode1 = strTravelMode1;
	}
	public String getTravelMode1()
	{
		return this.strTravelMode1;
	}

	public void setTravelClass1(String strTravelClass1)
	{
		this.strTravelClass1 = strTravelClass1;
	}
	public String getTravelClass1()
	{
		return this.strTravelClass1;
	}

	public void setNameOfAirline1(String strNameOfAirline1)
	{
		this.strNameOfAirline1 = strNameOfAirline1;
	}
	public String getNameOfAirline1()
	{
		return this.strNameOfAirline1;
	}
}
