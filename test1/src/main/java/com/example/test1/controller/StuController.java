package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.StuService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class StuController {

	@Autowired
	StuService stuService;
	
	@RequestMapping("/stu-list.do") 
//	주소 만들기
    public String login(Model model) throws Exception{

        return "/stu-list";
//      
    }
	
	@RequestMapping(value = "/stu-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = stuService.stuInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.getStuList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.removeStu(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/stu-view.do")
	//stu-view.do를 호출하면서 map을 parameter로 받음
	//request에 map에서 stuNo를 꺼내서 집어넣음 
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		request 객체 안에 필요한걸 담아서 jsp로 넘김
		System.out.println(map.get("stuNo"));
//		request.setAttribute("test", "1234");
		request.setAttribute("stuNo", map.get("stuNo"));
        return "/stu-view";
    }
	
	@RequestMapping(value = "/stu-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.getStu(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu/deleteList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectItem").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		
		System.out.println(map);
//			syso 할때 이상한거 만들면 그것의 생성자가 만들어지므로 주의
		
		resultMap = stuService.removeListStu(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
