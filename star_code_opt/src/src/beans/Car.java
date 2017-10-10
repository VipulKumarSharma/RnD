package src.beans;

public class Car extends BaseBean{

	private static final long serialVersionUID = 1L;
	
	private String startDate;
	private String endDate;
	private String startTime;
	private String endTime;
	private String startCity;
	private String endCity;
	private String startLocation;
	private String endLocation;
	private String startMobileNo;
	private String endMobileNo;
	private String startRouting;
	private String endRouting;
	private String carClass;
	private String carClassId;
	private boolean isNeed_GPS;
	private String category;
	private String remarks;
	
	private String journyType;
	private String timing;
	private String preferredTimeType;
	private String seatPreferrence;
	private String prefCar;
	
	
	public Car(){
		super();
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public String getTiming() {
		return timing;
	}

	public void setTiming(String timing) {
		this.timing = timing;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStartCity() {
		return startCity;
	}

	public void setStartCity(String startCity) {
		this.startCity = startCity;
	}

	public String getEndCity() {
		return endCity;
	}

	public void setEndCity(String endCity) {
		this.endCity = endCity;
	}

	public String getStartLocation() {
		return startLocation;
	}

	public void setStartLocation(String startLocation) {
		this.startLocation = startLocation;
	}

	public String getEndLocation() {
		return endLocation;
	}

	public void setEndLocation(String endLocation) {
		this.endLocation = endLocation;
	}

	public String getStartMobileNo() {
		return startMobileNo;
	}

	public void setStartMobileNo(String startMobileNo) {
		this.startMobileNo = startMobileNo;
	}

	public String getEndMobileNo() {
		return endMobileNo;
	}

	public void setEndMobileNo(String endMobileNo) {
		this.endMobileNo = endMobileNo;
	}
	
	public String getStartRouting() {
		return startRouting;
	}

	public void setStartRouting(String startRouting) {
		this.startRouting = startRouting;
	}

	public String getEndRouting() {
		return endRouting;
	}

	public void setEndRouting(String endRouting) {
		this.endRouting = endRouting;
	}

	public String getCarClass() {
		return carClass;
	}

	public void setCarClass(String carClass) {
		this.carClass = carClass;
	}

	public String getCarClassId() {
		return carClassId;
	}

	public void setCarClassId(String carClassId) {
		this.carClassId = carClassId;
	}

	public boolean isNeed_GPS() {
		return isNeed_GPS;
	}

	public void setNeed_GPS(boolean isNeed_GPS) {
		this.isNeed_GPS = isNeed_GPS;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getJournyType() {
		return journyType;
	}

	public void setJournyType(String journyType) {
		this.journyType = journyType;
	}

	public String getPreferredTimeType() {
		return preferredTimeType;
	}

	public void setPreferredTimeType(String preferredTimeType) {
		this.preferredTimeType = preferredTimeType;
	}

	public String getSeatPreferrence() {
		return seatPreferrence;
	}

	public void setSeatPreferrence(String seatPreferrence) {
		this.seatPreferrence = seatPreferrence;
	}

	public String getPrefCar() {
		return prefCar;
	}

	public void setPrefCar(String prefCar) {
		this.prefCar = prefCar;
	}
}
