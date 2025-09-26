package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BoardService;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.google.gson.Gson;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/board-list.do")
	public String login(Model model) throws Exception{

        return "/board-list";
//      application properties에서 미리 jsp로 지정을 해놨기 때문에 .jsp를 붙이지 않아도 괜찮음
    }
	
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.removeBoard(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/board-add.do")
	public String add(Model model) throws Exception{

        return "/board-add";
    }
	
	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardInsert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addBoard(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/board-view.do")
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		request 객체 안에 필요한걸 담아서 jsp로 넘김
//		System.out.println(map.get("boardNo"));
//		request.setAttribute("test", "1234");
		request.setAttribute("boardNo", map.get("boardNo"));
        return "/board-view";
    }
	
	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoard(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/board-edit.do")
	public String edit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		request 객체 안에 필요한걸 담아서 jsp로 넘김
//		System.out.println(map.get("boardNo"));
//		request.setAttribute("test", "1234");
		request.setAttribute("boardNo", map.get("boardNo"));
        return "/board-edit";
    }
	
	@RequestMapping(value = "/board-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.editBoard(map);
		
		return new Gson().toJson(resultMap);
	}

}
