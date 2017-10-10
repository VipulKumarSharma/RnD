import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class MainClass {

	public static void main(String[] args) throws IOException {
		String input = "I am proficient in C, proficient in Java";
		
		List<Keyword> myList= new ArrayList<Keyword>();
		myList = TextUtility.guessFromString(input);
		
		for (Keyword k: myList) {
			//if (k.getTerms().toString().equalsIgnoreCase("[proficient]")) {
				System.out.println(k.getStem()+"-----"+k.getFrequency()+"-----"+k.getTerms());
			//}
		}
		
	}

}
