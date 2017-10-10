package com.mind.AutoWireAnnotations;

import javax.annotation.Resource;

import com.mind.SpellChecker;

public class AutoWiredResource {
	
	private SpellChecker spellChecker;

	@Resource(name= "spellChecker")
	public void setSpellChecker( SpellChecker spellChecker ){
		this.spellChecker = spellChecker;
	}
	
	public SpellChecker getSpellChecker(){
		return spellChecker;
   	}
	
   	public void spellCheck(){
	   spellChecker.checkSpelling();
   	}
}
