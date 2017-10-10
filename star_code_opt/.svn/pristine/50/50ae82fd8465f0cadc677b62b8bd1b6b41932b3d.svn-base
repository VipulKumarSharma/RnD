package src.connection;


public class LabelRepository {
	LabelValuesGenerator lvGenerator = null;

	public LabelRepository() {
		lvGenerator = LabelValuesGenerator.getInstance();
	}

	public String getLabel(String labelKey, String langKey) {
		return lvGenerator.getLabel(labelKey, langKey);
	}

	public void getUpdatedLabels() {
		lvGenerator = LabelValuesGenerator.getUpdatedLabels();
	}

}
// end of class

