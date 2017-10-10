package src.beans;

public class TravelFare extends BaseBean{
	
	private static final long serialVersionUID = 1L;
	
	private String fareCurrency;
	private String fareAmount;
	
	public TravelFare(){
		super();
	}

	public String getFareCurrency() {
		return fareCurrency;
	}

	public void setFareCurrency(String fareCurrency) {
		this.fareCurrency = fareCurrency;
	}

	public String getFareAmount() {
		return fareAmount;
	}

	public void setFareAmount(String fareAmount) {
		this.fareAmount = fareAmount;
	}
	
	

}
