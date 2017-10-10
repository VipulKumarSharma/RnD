package Strings;

public class ReverseString {
	private String string = "";
	
	ReverseString (String string) {
		this.string = string;
	}

	public String reverseString() {
		String reverseString = "";
		
		if(string == null || string.isEmpty()) {
			return string;
		}
		
		for(int i=string.length()-1; i>=0 ; --i) {
			reverseString += string.charAt(i);
		}
		return reverseString;
	}
	
	public static void main(String[] args) {
		String inputString = "PALINDROME";
		ReverseString rs = new ReverseString(inputString);
		
		System.out.println("Input String    : "+ inputString);
		System.out.println("Reversed String : "+ rs.reverseString());
	}
}
