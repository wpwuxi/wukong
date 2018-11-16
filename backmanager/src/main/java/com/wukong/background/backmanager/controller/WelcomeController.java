package com.wukong.background.backmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WelcomeController {
	/**
	 * 返回页面，带参数
	 * @return
	 */
	@RequestMapping(value = "/", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView product(){
        ModelAndView mav = new ModelAndView("redirect:/user/");
        return mav;  
	}
	
	@RequestMapping(value = "/someaction", method = { RequestMethod.POST, RequestMethod.GET })
	public String someaction(){
		
        return "hello world";  
	}
	
}
