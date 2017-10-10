package com.mind;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.ModelMap;

@Controller
public class HelloController {
 
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String printWelcome(ModelMap model) {
		model.addAttribute("message", "Welcome!");
		String viewName = "hello";
		
		return viewName;
	}
	
	@RequestMapping(value="/hello", method = RequestMethod.GET)
	public String printHello(ModelMap model) {
		model.addAttribute("message", "Hello World!");
		String viewName = "hello";
		
		return viewName;
	}
	
	@RequestMapping(value="/helloweb", method = RequestMethod.GET)
	public String printHelloWeb(ModelMap model) {
		model.addAttribute("message", "Hello Web!");
		String viewName = "helloweb";
		
		return viewName;
	}
}
