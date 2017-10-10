package src.beans;

import java.util.List;

public class TravelRequest extends BaseBean{
	
	private static final long serialVersionUID = 1L;
	
	private String requisitionNo;
	private User originator;
	private User traveller; // Individual Traveler Object
	private List<User> travelerList; // Group/Guest Traveler list
	private List<RewardCard> rewardCardList;
	private List<Flight> flightDetailList;
	private List<Train> trainDetailList;
	private List<Car> carDetailList;
	private List<Accommodation> accommodationList;
	private List<Approver> approvers;
	private List<Approver> approverLevels;
	private Approver billingApprover;
	private BudgetActual budgetActual;
	private TravelFare travelFare;
	private List<Comment> approverCommentsList;
	private List<Comment> cancellationCommentsList;
	private List<Visa> visaDetailList;
	private boolean isFlightDetailExist;
	private boolean isTrainDetailExist;
	private boolean isRentA_CarDetailExist;
	private boolean isAccomodationDetailExist;
	private boolean isAdvanceDetailExist;
	private boolean isBudgetActualDetailExist;
	private boolean isTravelFareDetailExist;
	private boolean isGroupTravelExist;
	private boolean isVisaDetailExist;
	private String divisionName;
	private String creationDate;
	private String updationDate;
	private int statusId;
	private String projectNo;
	private String reasonForTravel;
	private String reasonOfSkipApprover;
	private String travelAgencyTypeId;
	private List<AdvanceForex> advanceForexList;
	private String linkedTravelRequest;
	private String advanceForex;
	private String returnStatus;
	
	public String getLinkedTravelRequest() {
		return linkedTravelRequest;
	}

	public void setLinkedTravelRequest(String linkedTravelRequest) {
		this.linkedTravelRequest = linkedTravelRequest;
	}

	public TravelRequest(){
		super();
	}

	public String getRequisitionNo() {
		return requisitionNo;
	}

	public void setRequisitionNo(String requisitionNo) {
		this.requisitionNo = requisitionNo;
	}

	public User getOriginator() {
		return originator;
	}

	public void setOriginator(User originator) {
		this.originator = originator;
	}

	public User getTraveller() {
		return traveller;
	}

	public void setTraveller(User traveller) {
		this.traveller = traveller;
	}

	public List<User> getTravelerList() {
		return travelerList;
	}

	public void setTravelerList(List<User> travelerList) {
		this.travelerList = travelerList;
	}

	public List<RewardCard> getRewardCardList() {
		return rewardCardList;
	}

	public void setRewardCardList(List<RewardCard> rewardCardList) {
		this.rewardCardList = rewardCardList;
	}

	public List<Flight> getFlightDetailList() {
		return flightDetailList;
	}

	public void setFlightDetailList(List<Flight> flightDetailList) {
		this.flightDetailList = flightDetailList;
	}

	public List<Train> getTrainDetailList() {
		return trainDetailList;
	}

	public void setTrainDetailList(List<Train> trainDetailList) {
		this.trainDetailList = trainDetailList;
	}

	public List<Car> getCarDetailList() {
		return carDetailList;
	}

	public void setCarDetailList(List<Car> carDetailList) {
		this.carDetailList = carDetailList;
	}

	public List<Accommodation> getAccommodationList() {
		return accommodationList;
	}

	public void setAccommodationList(List<Accommodation> accommodationList) {
		this.accommodationList = accommodationList;
	}

	public List<Approver> getApprovers() {
		return approvers;
	}

	public void setApprovers(List<Approver> approvers) {
		this.approvers = approvers;
	}

	public Approver getBillingApprover() {
		return billingApprover;
	}

	public void setBillingApprover(Approver billingApprover) {
		this.billingApprover = billingApprover;
	}
	
	public BudgetActual getBudgetActual() {
		return budgetActual;
	}

	public void setBudgetActual(BudgetActual budgetActual) {
		this.budgetActual = budgetActual;
	}
	
	public TravelFare getTravelFare() {
		return travelFare;
	}

	public void setTravelFare(TravelFare travelFare) {
		this.travelFare = travelFare;
	}

	public List<Comment> getApproverCommentsList() {
		return approverCommentsList;
	}

	public void setApproverCommentsList(List<Comment> approverCommentsList) {
		this.approverCommentsList = approverCommentsList;
	}

	public List<Comment> getCancellationCommentsList() {
		return cancellationCommentsList;
	}

	public void setCancellationCommentsList(List<Comment> cancellationCommentsList) {
		this.cancellationCommentsList = cancellationCommentsList;
	}

	public List<Visa> getVisaDetailList() {
		return visaDetailList;
	}

	public void setVisaDetailList(List<Visa> visaDetailList) {
		this.visaDetailList = visaDetailList;
	}

	public boolean isFlightDetailExist() {
		return isFlightDetailExist;
	}

	public void setFlightDetailExist(boolean isFlightDetailExist) {
		this.isFlightDetailExist = isFlightDetailExist;
	}

	public boolean isTrainDetailExist() {
		return isTrainDetailExist;
	}

	public void setTrainDetailExist(boolean isTrainDetailExist) {
		this.isTrainDetailExist = isTrainDetailExist;
	}

	public boolean isRentA_CarDetailExist() {
		return isRentA_CarDetailExist;
	}

	public void setRentA_CarDetailExist(boolean isRentA_CarDetailExist) {
		this.isRentA_CarDetailExist = isRentA_CarDetailExist;
	}

	public boolean isAccomodationDetailExist() {
		return isAccomodationDetailExist;
	}

	public void setAccomodationDetailExist(boolean isAccomodationDetailExist) {
		this.isAccomodationDetailExist = isAccomodationDetailExist;
	}
	
	public boolean isAdvanceDetailExist() {
		return isAdvanceDetailExist;
	}

	public void setAdvanceDetailExist(boolean isAdvanceDetailExist) {
		this.isAdvanceDetailExist = isAdvanceDetailExist;
	}

	public boolean isBudgetActualDetailExist() {
		return isBudgetActualDetailExist;
	}

	public void setBudgetActualDetailExist(boolean isBudgetActualDetailExist) {
		this.isBudgetActualDetailExist = isBudgetActualDetailExist;
	}

	public boolean isTravelFareDetailExist() {
		return isTravelFareDetailExist;
	}

	public void setTravelFareDetailExist(boolean isTravelFareDetailExist) {
		this.isTravelFareDetailExist = isTravelFareDetailExist;
	}

	public boolean isGroupTravelExist() {
		return isGroupTravelExist;
	}

	public void setGroupTravelExist(boolean isGroupTravelExist) {
		this.isGroupTravelExist = isGroupTravelExist;
	}
	
	public boolean isVisaDetailExist() {
		return isVisaDetailExist;
	}

	public void setVisaDetailExist(boolean isVisaDetailExist) {
		this.isVisaDetailExist = isVisaDetailExist;
	}

	public String getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	public String getUpdationDate() {
		return updationDate;
	}

	public void setUpdationDate(String updationDate) {
		this.updationDate = updationDate;
	}

	public int getStatusId() {
		return statusId;
	}

	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}

	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public String getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(String projectNo) {
		this.projectNo = projectNo;
	}

	public String getReasonForTravel() {
		return reasonForTravel;
	}

	public void setReasonForTravel(String reasonForTravel) {
		this.reasonForTravel = reasonForTravel;
	}

	public String getReasonOfSkipApprover() {
		return reasonOfSkipApprover;
	}

	public void setReasonOfSkipApprover(String reasonOfSkipApprover) {
		this.reasonOfSkipApprover = reasonOfSkipApprover;
	}

	public List<Approver> getApproverLevels() {
		return approverLevels;
	}

	public void setApproverLevels(List<Approver> approverLevels) {
		this.approverLevels = approverLevels;
	}

	public String getTravelAgencyTypeId() {
		return travelAgencyTypeId;
	}

	public void setTravelAgencyTypeId(String travelAgencyTypeId) {
		this.travelAgencyTypeId = travelAgencyTypeId;
	}
	
	public List<AdvanceForex> getAdvanceForexList() {
		return advanceForexList;
	}

	public void setAdvanceForexList(List<AdvanceForex> advanceForexList) {
		this.advanceForexList = advanceForexList;
	}

	public String getAdvanceForex() {
		return advanceForex;
	}

	public void setAdvanceForex(String advanceForex) {
		this.advanceForex = advanceForex;
	}

	public String getReturnStatus() {
		return returnStatus;
	}

	public void setReturnStatus(String returnStatus) {
		this.returnStatus = returnStatus;
	}

}
