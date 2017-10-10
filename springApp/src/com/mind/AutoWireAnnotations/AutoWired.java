package com.mind.AutoWireAnnotations;

import org.springframework.beans.factory.annotation.Autowired;

import com.mind.SpellChecker;

public class AutoWired {
	//@Autowired
	private SpellChecker spellChecker;

	@Autowired
	public AutoWired(SpellChecker spellChecker) {
		System.out.println("Inside AutoWired constructor." );
		this.spellChecker = spellChecker;
	}
	
	/*@Autowired
	public void setSpellChecker(SpellChecker spellChecker){
		this.spellChecker = spellChecker;
	}
	public SpellChecker getSpellChecker( ) {
		return spellChecker;
	}*/
   
	public void spellCheck() {
		spellChecker.checkSpelling();
	}

}
