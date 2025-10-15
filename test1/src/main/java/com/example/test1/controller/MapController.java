package com.example.test1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {
	@RequestMapping("/map.do") 
    public String map1(Model model) throws Exception{

    return "/map/map1";
	      
	}
	
	@RequestMapping("/map2.do") 
    public String map2(Model model) throws Exception{

    return "/map/map2";
	      
	}
	
	@RequestMapping("/map3.do") 
    public String map3(Model model) throws Exception{

    return "/map/map3";
	      
	}
}
