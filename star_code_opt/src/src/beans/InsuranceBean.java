package src.beans;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement

public class InsuranceBean 
{
	@XmlElement(name = "Insurance_Book_Id")
	String insuBookId = "";
	
	@XmlElement(name = "Insurance_Status")
	String insuStatus = "";
	
	@XmlElement(name = "Policy_No")
	String insuPolNo = "";
	
	@XmlElement(name = "Start_Date")
	String insuStDt = "";
	
	@XmlElement(name = "End_Date")
	String insuEndDt = "";
	
	@XmlElement(name = "Insurance_Type")
	String insuType = "";
	
	@XmlElement(name = "Nominee")
	String nominee = "";
	
	@XmlElement(name = "Relation")
	String relation = "";
	
	@XmlElement(name = "Amount")
	String insuCharges = "";
	
	@XmlElement(name = "Remark")
	String insuRemarks = "";
	
	public String getInsuBookId() {
		return insuBookId;
	}
	public void setInsuBookId(String insuBookId) {
		this.insuBookId = insuBookId;
	}
	public String getInsuStatus() {
		return insuStatus;
	}
	public void setInsuStatus(String insuStatus) {
		this.insuStatus = insuStatus;
	}
	public String getInsuPolNo() {
		return insuPolNo;
	}
	public void setInsuPolNo(String insuPolNo) {
		this.insuPolNo = insuPolNo;
	}
	public String getInsuStDt() {
		return insuStDt;
	}
	public void setInsuStDt(String insuStDt) {
		this.insuStDt = insuStDt;
	}
	public String getInsuEndDt() {
		return insuEndDt;
	}
	public void setInsuEndDt(String insuEndDt) {
		this.insuEndDt = insuEndDt;
	}
	public String getInsuType() {
		return insuType;
	}
	public void setInsuType(String insuType) {
		this.insuType = insuType;
	}
	public String getNominee() {
		return nominee;
	}
	public void setNominee(String nominee) {
		this.nominee = nominee;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public String getInsuCharges() {
		return insuCharges;
	}
	public void setInsuCharges(String insuCharges) {
		this.insuCharges = insuCharges;
	}
	public String getInsuRemarks() {
		return insuRemarks;
	}
	public void setInsuRemarks(String insuRemarks) {
		this.insuRemarks = insuRemarks;
	}
	
}
