package src.beans;

import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)

@XmlRootElement


public class CancellationBean 
{
	@XmlElement(name = "Travel_Cancel_ID")
	String travelCnclId = "";
	
	@XmlElement(name = "Flag")
	String chkbox = "";
	
	@XmlElement(name = "Ticket_Issue_Date")
	String tktIssuDt = "";
	
	@XmlElement(name = "Sector_From")
	String secFrom2 = "";
	
	@XmlElement(name = "Sector_To")
	String secTo2 = "";
	
	@XmlElement(name = "Cancelled_Date")
	String tktCnclDt = "";
	
	@XmlElement(name = "PNR")
	String pnr1 = "";
	
	@XmlElement(name = "E_Ticket_No")
	String eTktNo1 = "";
	
	@XmlElement(name = "Amount")
	String cnclCharges = "";
	
	@XmlElement(name = "Cancel_Reason")
	String cnclReason = "";
	
	@XmlElement(name = "Remark")
	String refundRemarks = "";
	
	@XmlElement(name = "Mail_Sent_Flag")
	String mailSentFlag = "";
	
	@XmlElement(name = "Group_User_ID")
	String grpUserId = "";
	
	public String getTravelCnclId() {
		return travelCnclId;
	}
	public void setTravelCnclId(String travelCnclId) {
		this.travelCnclId = travelCnclId;
	}
	public String getChkbox() {
		return chkbox;
	}
	public void setChkbox(String chkbox) {
		this.chkbox = chkbox;
	}
	public String getTktIssuDt() {
		return tktIssuDt;
	}
	public void setTktIssuDt(String tktIssuDt) {
		this.tktIssuDt = tktIssuDt;
	}
	public String getSecFrom2() {
		return secFrom2;
	}
	public void setSecFrom2(String secFrom2) {
		this.secFrom2 = secFrom2;
	}
	public String getSecTo2() {
		return secTo2;
	}
	public void setSecTo2(String secTo2) {
		this.secTo2 = secTo2;
	}
	public String getTktCnclDt() {
		return tktCnclDt;
	}
	public void setTktCnclDt(String tktCnclDt) {
		this.tktCnclDt = tktCnclDt;
	}
	public String getPnr1() {
		return pnr1;
	}
	public void setPnr1(String pnr1) {
		this.pnr1 = pnr1;
	}
	public String geteTktNo1() {
		return eTktNo1;
	}
	public void seteTktNo1(String eTktNo1) {
		this.eTktNo1 = eTktNo1;
	}
	public String getCnclCharges() {
		return cnclCharges;
	}
	public void setCnclCharges(String cnclCharges) {
		this.cnclCharges = cnclCharges;
	}
	public String getCnclReason() {
		return cnclReason;
	}
	public void setCnclReason(String cnclReason) {
		this.cnclReason = cnclReason;
	}
	public String getRefundRemarks() {
		return refundRemarks;
	}
	public void setRefundRemarks(String refundRemarks) {
		this.refundRemarks = refundRemarks;
	}
	public String getMailSentFlag() {
		return mailSentFlag;
	}
	public void setMailSentFlag(String mailSentFlag) {
		this.mailSentFlag = mailSentFlag;
	}
	public String getGrpUserId() {
		return grpUserId;
	}
	public void setGrpUserId(String grpUserId) {
		this.grpUserId = grpUserId;
	} 
}
