package src.beans;

public class AdvanceForex extends BaseBean {

	private static final long serialVersionUID = 1L;
	
	private String travellerName;
	private String advCurrency;
	private String expensePerDay1;
	private String numOfDays1;
	private String totalExpense1;
	
	private String expensePerDay2;
	private String numOfDays2;
	private String totalExpense2;
	
	private String contingencyExpense;
	private String otherExpense;
	
	private String totalExpenditure;
	private String exchangeRateINR;
	private String totalAdvanceINR;
	private String advRemarks;
	private String cashBrkupRemarks;
	
	public AdvanceForex()
	{
		super();
	}

	public String getTravellerName() {
		return travellerName;
	}

	public void setTravellerName(String travellerName) {
		this.travellerName = travellerName;
	}

	public String getAdvCurrency() {
		return advCurrency;
	}

	public void setAdvCurrency(String advCurrency) {
		this.advCurrency = advCurrency;
	}

	public String getExpensePerDay1() {
		return expensePerDay1;
	}

	public void setExpensePerDay1(String expensePerDay1) {
		this.expensePerDay1 = expensePerDay1;
	}

	public String getNumOfDays1() {
		return numOfDays1;
	}

	public void setNumOfDays1(String numOfDays1) {
		this.numOfDays1 = numOfDays1;
	}

	public String getTotalExpense1() {
		return totalExpense1;
	}

	public void setTotalExpense1(String totalExpense1) {
		this.totalExpense1 = totalExpense1;
	}

	public String getExpensePerDay2() {
		return expensePerDay2;
	}

	public void setExpensePerDay2(String expensePerDay2) {
		this.expensePerDay2 = expensePerDay2;
	}

	public String getNumOfDays2() {
		return numOfDays2;
	}

	public void setNumOfDays2(String numOfDays2) {
		this.numOfDays2 = numOfDays2;
	}

	public String getTotalExpense2() {
		return totalExpense2;
	}

	public void setTotalExpense2(String totalExpense2) {
		this.totalExpense2 = totalExpense2;
	}

	public String getContingencyExpense() {
		return contingencyExpense;
	}

	public void setContingencyExpense(String contingencyExpense) {
		this.contingencyExpense = contingencyExpense;
	}

	public String getOtherExpense() {
		return otherExpense;
	}

	public void setOtherExpense(String otherExpense) {
		this.otherExpense = otherExpense;
	}

	public String getTotalExpenditure() {
		return totalExpenditure;
	}

	public void setTotalExpenditure(String totalExpenditure) {
		this.totalExpenditure = totalExpenditure;
	}

	public String getExchangeRateINR() {
		return exchangeRateINR;
	}

	public void setExchangeRateINR(String exchangeRateINR) {
		this.exchangeRateINR = exchangeRateINR;
	}

	public String getTotalAdvanceINR() {
		return totalAdvanceINR;
	}

	public void setTotalAdvanceINR(String totalAdvanceINR) {
		this.totalAdvanceINR = totalAdvanceINR;
	}

	public String getAdvRemarks() {
		return advRemarks;
	}

	public void setAdvRemarks(String advRemarks) {
		this.advRemarks = advRemarks;
	}

	public String getCashBrkupRemarks() {
		return cashBrkupRemarks;
	}

	public void setCashBrkupRemarks(String cashBrkupRemarks) {
		this.cashBrkupRemarks = cashBrkupRemarks;
	}
}
