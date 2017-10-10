package src.beans;

public class Fare extends BaseBean{
	
	private static final long serialVersionUID = 1L;
	private boolean changeableAgainstFee;
	private boolean refundableAgainstFee;
	private int checkedBaggageCount;
	private String bahnCardNo;
	private String discount;
	private String fareClass;
	private String validityDate;
	private boolean isOnlineTicket;	
	
	public Fare(){
		super();
	}

	public boolean isChangeableAgainstFee() {
		return changeableAgainstFee;
	}

	public void setChangeableAgainstFee(boolean changeableAgainstFee) {
		this.changeableAgainstFee = changeableAgainstFee;
	}

	public boolean isRefundableAgainstFee() {
		return refundableAgainstFee;
	}

	public void setRefundableAgainstFee(boolean refundableAgainstFee) {
		this.refundableAgainstFee = refundableAgainstFee;
	}

	public int getCheckedBaggageCount() {
		return checkedBaggageCount;
	}

	public void setCheckedBaggageCount(int checkedBaggageCount) {
		this.checkedBaggageCount = checkedBaggageCount;
	}

	public String getBahnCardNo() {
		return bahnCardNo;
	}

	public void setBahnCardNo(String bahnCardNo) {
		this.bahnCardNo = bahnCardNo;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getFareClass() {
		return fareClass;
	}

	public void setFareClass(String fareClass) {
		this.fareClass = fareClass;
	}

	public String getValidityDate() {
		return validityDate;
	}

	public void setValidityDate(String validityDate) {
		this.validityDate = validityDate;
	}

	public boolean isOnlineTicket() {
		return isOnlineTicket;
	}

	public void setOnlineTicket(boolean isOnlineTicket) {
		this.isOnlineTicket = isOnlineTicket;
	}
}
