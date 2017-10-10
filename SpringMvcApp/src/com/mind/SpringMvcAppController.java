package com.mind;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("springmvc")
public class SpringMvcAppController {

	@RequestMapping(method = RequestMethod.GET)
	public String printSpring(ModelMap model) {
		model.addAttribute("message", "Spring Framework!");
		String viewName = "springmvc";
		
		return viewName;
	}
	
	@RequestMapping(value="/world", method = RequestMethod.GET)
	public String printSpringWorld(ModelMap model) {
		model.addAttribute("message", "Spring MVC World!");
		String viewName = "springmvc";
		
		return viewName;
	}
}
