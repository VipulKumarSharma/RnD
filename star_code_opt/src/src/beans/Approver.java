package src.beans;

public class Approver extends BaseBean {

	private static final long serialVersionUID = 1L;
	private Integer approverId;
	private String name;
	private String approverLevel;
	private String approverRole;
	private String designationName;
	private String unitName;
	private String approveStatus;
	private String approveDate;
	private String originalApprover;
	private String approveTime;
	
	public Approver(){
		super();
	}
	
	public Integer getApproverId() {
		return approverId;
	}
	public void setApproverId(Integer approverId) {
		this.approverId = approverId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getApproverLevel() {
		return approverLevel;
	}
	public void setApproverLevel(String approverLevel) {
		this.approverLevel = approverLevel;
	}
	public String getApproverRole() {
		return approverRole;
	}
	public void setApproverRole(String approverRole) {
		this.approverRole = approverRole;
	}
	public String getDesignationName() {
		return designationName;
	}
	public void setDesignationName(String designationName) {
		this.designationName = designationName;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getApproveStatus() {
		return approveStatus;
	}

	public void setApproveStatus(String approveStatus) {
		this.approveStatus = approveStatus;
	}

	public String getApproveDate() {
		return approveDate;
	}

	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}

	public String getOriginalApprover() {
		return originalApprover;
	}

	public void setOriginalApprover(String originalApprover) {
		this.originalApprover = originalApprover;
	}
	
	
	public String getApproveTime() {
		return approveTime;
	}

	public void setApproveTime(String approveTime) {
		this.approveTime = approveTime;
	}

	@Override
	public boolean equals(Object obj) {
		if(obj != null && obj instanceof Approver){
			return this.getApproverId().equals(((Approver)obj).getApproverId());
		}
		return false;
	}
	
	@Override
	public int hashCode() {
		return this.getApproverId();
	}
}
