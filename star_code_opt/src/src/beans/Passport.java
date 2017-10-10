package src.beans;

public class Passport extends BaseBean{

	private static final long serialVersionUID = 1L;
	
	private String firstName;
	private String middleName;
	private String lastName;
	private String passportNo;
	private String dateOfBirth;
	private String placeOfIssue;
	private String dateOfIssue;
	private String dateOfExpiry;
	private String nationality;
	private boolean visaExists;
	private String ecr;
	private String visaComments;
	private String visaCountry;
	private boolean insuranceReq;
	private String insuranceRemarks;
	private String insuranceNominee;
	private String insuranceRelation;
	private String visaValidFrom;
	private String visaValidTo;
	private String visaStayDuration;
	
	public String getVisaComments() {
		return visaComments;
	}

	public void setVisaComments(String visaComments) {
		this.visaComments = visaComments;
	}

	public String getVisaCountry() {
		return visaCountry;
	}

	public void setVisaCountry(String visaCountry) {
		this.visaCountry = visaCountry;
	}

	public boolean isInsuranceReq() {
		return insuranceReq;
	}

	public void setInsuranceReq(boolean insuranceReq) {
		this.insuranceReq = insuranceReq;
	}

	public String getInsuranceRemarks() {
		return insuranceRemarks;
	}

	public void setInsuranceRemarks(String insuranceRemarks) {
		this.insuranceRemarks = insuranceRemarks;
	}

	public String getInsuranceNominee() {
		return insuranceNominee;
	}

	public void setInsuranceNominee(String insuranceNominee) {
		this.insuranceNominee = insuranceNominee;
	}

	public String getInsuranceRelation() {
		return insuranceRelation;
	}

	public void setInsuranceRelation(String insuranceRelation) {
		this.insuranceRelation = insuranceRelation;
	}

	public Passport(){
		super();
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassportNo() {
		return passportNo;
	}

	public void setPassportNo(String passportNo) {
		this.passportNo = passportNo;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getPlaceOfIssue() {
		return placeOfIssue;
	}

	public void setPlaceOfIssue(String placeOfIssue) {
		this.placeOfIssue = placeOfIssue;
	}

	public String getDateOfIssue() {
		return dateOfIssue;
	}

	public void setDateOfIssue(String dateOfIssue) {
		this.dateOfIssue = dateOfIssue;
	}

	public String getDateOfExpiry() {
		return dateOfExpiry;
	}

	public void setDateOfExpiry(String dateOfExpiry) {
		this.dateOfExpiry = dateOfExpiry;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public boolean isVisaExists() {
		return visaExists;
	}

	public void setVisaExists(boolean visaExists) {
		this.visaExists = visaExists;
	}

	public String getEcr() {
		return ecr;
	}

	public void setEcr(String ecr) {
		this.ecr = ecr;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getVisaValidFrom() {
		return visaValidFrom;
	}

	public void setVisaValidFrom(String visaValidFrom) {
		this.visaValidFrom = visaValidFrom;
	}

	public String getVisaValidTo() {
		return visaValidTo;
	}

	public void setVisaValidTo(String visaValidTo) {
		this.visaValidTo = visaValidTo;
	}

	public String getVisaStayDuration() {
		return visaStayDuration;
	}

	public void setVisaStayDuration(String visaStayDuration) {
		this.visaStayDuration = visaStayDuration;
	}
}
