package src.enumTypes;

public class TravelRequestEnums {

	public static enum PreferredTimeTypes {

		DEPARTURE("1", "Departure not Before", ""),
		ARRIVAL("2", "Arrival Until", "");

		private String id;
		private String name;
		private String displayKey;

		PreferredTimeTypes(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}
		
		public static PreferredTimeTypes fromId(String id){
			for(PreferredTimeTypes type : PreferredTimeTypes.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}

	public static enum Locations{

		AIRPORT("1", "Airport", ""),
		TRAIN_STATION("2", "Train Station", ""),
		CITY("3", "City", ""),
		OFFICE("4", "Office", "");

		private String id;
		private String name;
		private String displayKey;

		Locations(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}

		public static Locations fromId(String id){
			for(Locations type : Locations.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}
		
		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}
	
	public static enum LocationsMataIndia{

		TRANSIT_HOUSE("1", "Transit House", ""),
		AIRPORT("2", "Airport", ""),
		HOTEL("3", "Hotel", ""),
		RAILWAY_STATION("4", "Railway Station", ""),
		OFFICE("5", "Office", "");

		private String id;
		private String name;
		private String displayKey;

		LocationsMataIndia(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}

		public static LocationsMataIndia fromId(String id){
			for(LocationsMataIndia type : LocationsMataIndia.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}
		
		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}

	public static enum CarCategories{

		ECONOMY("1", "Economy (i.e. VW Polo)", ""),
		COMPACT("2", "Compact (i.e. VW Golf)", ""),
		COMPACT_STATION_WAGON("3", "Compact Station Wagon(i.e. Ford Focus Turnier)", ""),
		INTERMEDIATE("4", "Intermediate (i.e. VW Passat)", ""),
		INTERMEDIATE_STATION_WAGON ("5", "Intermediate Station Wagon (i.e. VW Passat Variant)", "");

		private String id;
		private String name;
		private String displayKey;

		CarCategories(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}
		
		public static CarCategories fromId(String id){
			for(CarCategories type : CarCategories.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}

	public static enum AccomodationStayTypes{

		HOTEL("1", "Hotel", ""),
		GUEST_HOUSE("2", "Guest House", "");

		private String id;
		private String name;
		private String displayKey;

		AccomodationStayTypes(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}
		
		public static AccomodationStayTypes fromId(String id){
			for(AccomodationStayTypes type : AccomodationStayTypes.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}
	
	public static enum TrainSeatPreferredTypes{

		WINDOW_GROSSRAUM_WITH_TABLE("22", "Window-Grossraum-With Table", ""),
		AISLE_GROSSRAUM_WITH_TABLE("23", "Aisle-Grossraum-With Table", ""),
		WINDOW_GROSSRAUM_WITHOUT_TABLE("24", "Window-Grossraum-Without Table", ""),
		AISLE_GROSSRAUM_WITHOUT_TABLE("25", "Aisle-Grossraum-Without Table", ""),
		WINDOW_ABTEIL_WITH_TABLE("26", "Window-Abteil-With Table", ""),
		AISLE_ABTEIL_WITH_TABLE("27", "Aisle-Abteil-With Table", ""),
		WINDOW_ABTEIL_WITHOUT_TABLE("28", "Window-Abteil-Without Table", ""),
		AISLE_ABTEIL_WITHOUT_TABLE("29", "Aisle-Abteil-Without Table", "");

		private String id;
		private String name;
		private String displayKey;

		TrainSeatPreferredTypes(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}
		
		public static TrainSeatPreferredTypes fromName(String name){
			for(TrainSeatPreferredTypes type : TrainSeatPreferredTypes.values()){
				if(name.equals(type.getName())){
					return type;
				}
			}
			return null;
		}
		
		public static TrainSeatPreferredTypes fromId(String id){
			for(TrainSeatPreferredTypes type : TrainSeatPreferredTypes.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}
	
	public static enum JournyType{

		FORWARD("1", "FORWARD", ""),
		INTERMEDIATE("2", "INTERMEDIATE", ""),
		RETURNED("3", "RETURNED", "");

		private String id;
		private String name;
		private String displayKey;

		JournyType(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}
		
		public static JournyType fromId(String id){
			for(JournyType type : JournyType.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}
	
	public static enum ApproverCommentType{

		APPROVE("1", "APPROVE", ""),
		CANCEL("2", "CANCEL", "");

		private String id;
		private String name;
		private String displayKey;

		ApproverCommentType(String id, String name, String displayKey){
			this.id = id;
			this.name = name;
			this.displayKey = displayKey;
		}
		
		public static ApproverCommentType fromId(String id){
			for(ApproverCommentType type : ApproverCommentType.values()){
				if(id.equals(type.getId())){
					return type;
				}
			}
			return null;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDisplayKey() {
			return displayKey;
		}

		public void setDisplayKey(String displayKey) {
			this.displayKey = displayKey;
		}
	}
	
}
