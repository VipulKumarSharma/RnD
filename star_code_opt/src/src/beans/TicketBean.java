package src.beans;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement

public class TicketBean 
{
	@XmlElement(name = "Ticket_Book_Id")
	String tktBookId = "";

	@XmlElement(name = "Sector_From")
	String secFrom1 = "";
	
	@XmlElement(name = "Sector_To")
	String secTo1 = "";
	
	@XmlElement(name = "Class")
	String cls = "";
	
	@XmlElement(name = "Departure_Date")
	String deptrDate = "";
	
	@XmlElement(name = "Departure_Time")
	String deptrTime = "";
	
	@XmlElement(name = "Arrival_Date")
	String arrDate = "";
	
	@XmlElement(name = "Arrival_Time")
	String arrTime = "";
	
	@XmlElement(name = "AirLine_Name")
	String airline = "";
	
	@XmlElement(name = "PNR")
	String pnr = ""; 
	
	@XmlElement(name = "E_Ticket_No")
	String eTktNo = "";
	
	@XmlElement(name = "Basic_Fare")
	String basicFare = "";
	
	@XmlElement(name = "Taxes")
	String taxes = "";
	
	@XmlElement(name = "Total_Fare")
	String totFare = "";
	
	@XmlElement(name = "Booking_Status_ID")
	String tktStatus = "";
	
	@XmlElement(name = "Remark")
	String tktRemarks = "";
	
	@XmlElement(name = "Group_User_ID")
	String grpUserId = "";
	
	public String getTktBookId() {
		return tktBookId;
	}
	public void setTktBookId(String tktBookId) {
		this.tktBookId = tktBookId;
	}
	public String getSecFrom1() {
		return secFrom1;
	}
	public void setSecFrom1(String secFrom1) {
		this.secFrom1 = secFrom1;
	}
	public String getSecTo1() {
		return secTo1;
	}
	public void setSecTo1(String secTo1) {
		this.secTo1 = secTo1;
	}
	public String getCls() {
		return cls;
	}
	public void setCls(String cls) {
		this.cls = cls;
	}
	public String getDeptrDate() {
		return deptrDate;
	}
	public void setDeptrDate(String deptrDate) {
		this.deptrDate = deptrDate;
	}
	public String getDeptrTime() {
		return deptrTime;
	}
	public void setDeptrTime(String deptrTime) {
		this.deptrTime = deptrTime;
	}
	public String getArrDate() {
		return arrDate;
	}
	public void setArrDate(String arrDate) {
		this.arrDate = arrDate;
	}
	public String getArrTime() {
		return arrTime;
	}
	public void setArrTime(String arrTime) {
		this.arrTime = arrTime;
	}
	public String getAirline() {
		return airline;
	}
	public void setAirline(String airline) {
		this.airline = airline;
	}
	public String getPnr() {
		return pnr;
	}
	public void setPnr(String pnr) {
		this.pnr = pnr;
	}
	public String geteTktNo() {
		return eTktNo;
	}
	public void seteTktNo(String eTktNo) {
		this.eTktNo = eTktNo;
	}
	public String getBasicFare() {
		return basicFare;
	}
	public void setBasicFare(String basicFare) {
		this.basicFare = basicFare;
	}
	public String getTaxes() {
		return taxes;
	}
	public void setTaxes(String taxes) {
		this.taxes = taxes;
	}
	public String getTotFare() {
		return totFare;
	}
	public void setTotFare(String totFare) {
		this.totFare = totFare;
	}
	public String getTktStatus() {
		return tktStatus;
	}
	public void setTktStatus(String tktStatus) {
		this.tktStatus = tktStatus;
	}
	public String getTktRemarks() {
		return tktRemarks;
	}
	public void setTktRemarks(String tktRemarks) {
		this.tktRemarks = tktRemarks;
	}
	public String getGrpUserId() {
		return grpUserId;
	}
	public void setGrpUserId(String grpUserId) {
		this.grpUserId = grpUserId;
	}
}
