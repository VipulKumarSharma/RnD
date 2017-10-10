package com.mind.JavaBasedConfiguration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mind.SpellChecker;
import com.mind.TextEditor;

@Configuration
public class TextEditorConfig {

	@Bean
	public TextEditor textEditor(){
		return new TextEditor( spellChecker() );
	}

	@Bean 
	public SpellChecker spellChecker(){
		return new SpellChecker( );
	}
}
