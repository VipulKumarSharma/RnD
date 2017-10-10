package src.beans;

public class User extends BaseBean{
	
	private static final long serialVersionUID = 1L;
	private Integer userId;
	private String userName;
	private String empCode;
	private String fullName;
	private String unitName;
	private String divisionName;
	private String firstName;
	private String lastName;
	private String designationName;
	private String departmentName;
	private String costCenterName;
	private String projectNumber;
	private Passport passport;
	private String gender;
	private String contactNo;
	private String dateOfBirth;
	private String mealPreferrence;
	private String frequentFlyer;
	private boolean returnJournyFlag;
	private String permanentAddress = "-";
	private String currentAddress = "-";
	private String email = "-";
	private String proofIdentityName = "-";
	private String proofIdentityNumber = "-";
	private String amountRequired = "-";

	public User(){
		super();
	}
	
	public Integer getUserId() {
		return userId;
	}


	public void setUserId(Integer userId) {
		this.userId = userId;
	}


	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getDesignationName() {
		return designationName;
	}

	public void setDesignationName(String designationName) {
		this.designationName = designationName;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getCostCenterName() {
		return costCenterName;
	}

	public void setCostCenterName(String costCenterName) {
		this.costCenterName = costCenterName;
	}

	public String getProjectNumber() {
		return projectNumber;
	}

	public void setProjectNumber(String projectNumber) {
		this.projectNumber = projectNumber;
	}

	public Passport getPassport() {
		return passport;
	}

	public void setPassport(Passport passport) {
		this.passport = passport;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getMealPreferrence() {
		return mealPreferrence;
	}

	public void setMealPreferrence(String mealPreferrence) {
		this.mealPreferrence = mealPreferrence;
	}

	public String getFrequentFlyer() {
		return frequentFlyer;
	}

	public void setFrequentFlyer(String frequentFlyer) {
		this.frequentFlyer = frequentFlyer;
	}

	public boolean isReturnJournyFlag() {
		return returnJournyFlag;
	}

	public void setReturnJournyFlag(boolean returnJournyFlag) {
		this.returnJournyFlag = returnJournyFlag;
	}

	public String getPermanentAddress() {
		return permanentAddress;
	}

	public void setPermanentAddress(String permanentAddress) {
		this.permanentAddress = permanentAddress;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProofIdentityName() {
		return proofIdentityName;
	}

	public void setProofIdentityName(String proofIdentityName) {
		this.proofIdentityName = proofIdentityName;
	}

	public String getProofIdentityNumber() {
		return proofIdentityNumber;
	}

	public void setProofIdentityNumber(String proofIdentityNumber) {
		this.proofIdentityNumber = proofIdentityNumber;
	}

	public String getAmountRequired() {
		return amountRequired;
	}

	public void setAmountRequired(String amountRequired) {
		this.amountRequired = amountRequired;
	}

	@Override
	public boolean equals(Object obj) {
		if(obj != null && obj instanceof User){
			User user = (User) obj;
			if(this.getUnitName().equals(user.getUnitName())){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public int hashCode() {
		return this.userId;
	}
	
}
