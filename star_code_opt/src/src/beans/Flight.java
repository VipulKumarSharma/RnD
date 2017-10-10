package src.beans;

public class Flight extends BaseBean{
	
	private static final long serialVersionUID = 1L;
	private String journyType;
	private String departureCity;
	private String arrivalCity;
	private String departureDate;
	private String preferredTimeType;
	private String timing;
	private String travelClass;
	private String windowSeatPreferrence;
	private String remarks;
	private Fare fareDetail;
	private String prefAirline;
	private boolean isRefundable;
	
	public Flight(){
		super();
	}

	public String getJournyType() {
		return journyType;
	}

	public void setJournyType(String journyType) {
		this.journyType = journyType;
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

	public String getTiming() {
		return timing;
	}

	public void setTiming(String timing) {
		this.timing = timing;
	}

	public String getTravelClass() {
		return travelClass;
	}

	public void setTravelClass(String travelClass) {
		this.travelClass = travelClass;
	}

	public String getWindowSeatPreferrence() {
		return windowSeatPreferrence;
	}

	public void setWindowSeatPreferrence(String windowSeatPreferrence) {
		this.windowSeatPreferrence = windowSeatPreferrence;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Fare getFareDetail() {
		return fareDetail;
	}

	public void setFareDetail(Fare fareDetail) {
		this.fareDetail = fareDetail;
	}

	public String getPreferredTimeType() {
		return preferredTimeType;
	}

	public void setPreferredTimeType(String preferredTimeType) {
		this.preferredTimeType = preferredTimeType;
	}

	public String getPrefAirline() {
		return prefAirline;
	}

	public void setPrefAirline(String prefAirline) {
		this.prefAirline = prefAirline;
	}

	public boolean isRefundable() {
		return isRefundable;
	}

	public void setRefundable(boolean isRefundable) {
		this.isRefundable = isRefundable;
	}
}
