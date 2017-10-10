package src.beans;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement

public class AccomodationBean 
{
	@XmlElement(name = "Acc_Book_ID")
	String accBookId = "";
	
	@XmlElement(name = "Acc_Type")
	String stayType = "";
	
	@XmlElement(name = "Location")
	String locn = "";
	
	@XmlElement(name = "Check_In_Date")
	String chkInDt = "";
	
	@XmlElement(name = "Check_Out_Date")
	String chkOutDt = "";
	
	@XmlElement(name = "Amount")
	String stayCharges = "";
	
	@XmlElement(name = "Remark")
	String stayRemarks = "";
	
	public String getAccBookId() {
		return accBookId;
	}
	public void setAccBookId(String accBookId) {
		this.accBookId = accBookId;
	}
	public String getStayType() {
		return stayType;
	}
	public void setStayType(String stayType) {
		this.stayType = stayType;
	}
	public String getLocn() {
		return locn;
	}
	public void setLocn(String locn) {
		this.locn = locn;
	}
	public String getChkInDt() {
		return chkInDt;
	}
	public void setChkInDt(String chkInDt) {
		this.chkInDt = chkInDt;
	}
	public String getChkOutDt() {
		return chkOutDt;
	}
	public void setChkOutDt(String chkOutDt) {
		this.chkOutDt = chkOutDt;
	}
	public String getStayCharges() {
		return stayCharges;
	}
	public void setStayCharges(String stayCharges) {
		this.stayCharges = stayCharges;
	}
	public String getStayRemarks() {
		return stayRemarks;
	}
	public void setStayRemarks(String stayRemarks) {
		this.stayRemarks = stayRemarks;
	}
}
