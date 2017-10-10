package com.mind.nameInitials;

public class nameInitials {

	public static void main(String[] args) {
		String str 		= "Mera Naam h Vipul Kumar Sharma";
		String initials = "";
		String parts[] 	= str.split(" ");
		
		for(int i=0; i<parts.length;i++) {
			if(i == parts.length-1)
				initials = initials + parts[i].substring(0,1);
			else
				initials = initials + parts[i].substring(0,1) + ".";
		}
		System.out.println(initials);
	}

}
