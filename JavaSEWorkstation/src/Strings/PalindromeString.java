package Strings;

import java.util.Scanner;

public class PalindromeString {
	
	public boolean isPalindrome(String string) {
		boolean isPalindrome = true;
		
		if(string == null || string.isEmpty()) {
			return false;
		}
		
		for(int i=0; i<string.length() ; ++i) {
			if (string.charAt(i) != string.charAt((string.length()-1) - i)) {
				return false;
			}
		}
		return isPalindrome;
	}
	
	public boolean isPalindrome(int number) {
        int tempNum 	= number;
        int reverseNum 	= 0;

        while (tempNum != 0) {
            int tempNumRem 	= tempNum % 10;
            tempNum 		= tempNum / 10;
            reverseNum 		= reverseNum * 10 + tempNumRem;
        }

        if (number == reverseNum) {
            return true;
        }
        return false;
    }
	 
	public static void main(String[] args) {
		System.out.print("Enter a number to check for palindrome : ");
		
		PalindromeString ps = new PalindromeString();
		Scanner scanner 	= new Scanner(System.in);
		int inputNumber		= scanner.nextInt();
		
		System.out.println("\nInput number  : "+ Long.toString(inputNumber));
		System.out.println("is Palindrome : "+ ps.isPalindrome(inputNumber));
		
		String inputString  = "ABCDEFGGFEDCBA";
		
		System.out.println("\nInput String  : "+ inputString);
		System.out.println("is Palindrome : "+ ps.isPalindrome(inputString));
		
		scanner.close();
	}
}
