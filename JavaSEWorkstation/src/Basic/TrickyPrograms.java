package Basic;

import java.util.Arrays;
import java.util.List;

public class TrickyPrograms {

	public static void main(String[] trickyArgs) {
		
		try {
			//TrickyPrograms.divideByZero();
		
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error occurred in divideByZero()");
		}
		
		//TrickyPrograms.incDec();
		//asListBehaviour();
		System.out.println(tryCatchFinallyReturn());
	}
	
	static public String tryCatchFinallyReturn() {
		System.out.println("before try block");
		try {
			System.out.println("try block");
			return "try returned";
			
		} catch (Exception ex) {
			System.out.println("catch block");
			return "catch returned";
		
		} finally {
			System.out.println("finally block");
			return "finally returned";
		}
	}
	
	public static void asListBehaviour() {
		String[] strArr = {"KJH","FDT","YTR"};
		List<String> list = Arrays.asList(strArr);			// return Array as LIST view
		
		System.out.println(list);
		
		strArr[1] = "DELHI";
		System.out.println("After change in Array, List will become : "+list);
		
		list.set(2, "New York");
		System.out.println("After change in List, List will become  : "+list);
		System.out.println("After change in List, Array element[2] will become : "+strArr[2]);
		
		System.out.println("list instanceof Arrays : "+ (list instanceof Arrays));
		System.out.println("list instanceof List   : "+ (list instanceof List));
	}
	
	public static void divideByZero() {
		byte b = 5;
		Byte B = new Byte(b);
		System.out.println(b / 0);
		System.out.println(B / 0);
		
		short s = 54;
		Short S = new Short(s);
		System.out.println(s / 0);
		System.out.println(S / 0);
		
		int i = 54;
		Integer I = new Integer(i);
		System.out.println(i / 0);
		System.out.println(I / 0);
		
		float f = 5;
		Float F = new Float(f);
		System.out.println(f / 0);
		System.out.println(F / 0);
		
		float d = 5;
		Double D = new Double(d);
		System.out.println(d / 0);
		System.out.println(D / 0);
		
		System.out.println(10 / 0);
		System.out.println(10.0 / 0);
		System.out.println(10 / 0.0);
		System.out.println(10.0 / -0.0);
		
		// f and F are same - F is neater
		System.out.println(10F / 0);
		System.out.println(10.0F / 0);
		System.out.println(10 / 0.0F);
		System.out.println(10.0F / -0.0F);
		
		// d and D are same - D is neater
		System.out.println(10D / 0);
		System.out.println(10.0D / 0);
		System.out.println(10 / 0.0D);
		System.out.println(10.0D / -0.0D);
	}
	
	static public void incDec() {
		int i = 0;
		int j = ++i + ++i + ++i;
		System.out.println("i="+i+"	j=="+j);
		
		i=0;
		int k = i++ + i++ + i++;
		System.out.println("i="+i+"	k=="+k);
		
		i=10;
		int l = --i + --i + --i;
		System.out.println("i="+i+"	l=="+l);
		
		i=10;
		int m = i-- + i-- + i--;
		System.out.println("i="+i+"	m=="+m);
	}
}
