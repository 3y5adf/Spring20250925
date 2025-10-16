package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.BbsService;
import com.google.gson.Gson;

@Controller
public class BbsController {
	@Autowired
	BbsService bbsService;
	
	
	@RequestMapping("/bbs/list.do") 
    public String bbsList(Model model) throws Exception{
		//글 목록
		return "/bbs/list";
	      
	}
	
	@RequestMapping("/bbs/add.do") 
    public String bbsAdd(Model model) throws Exception{
		//글 쓰기
		return "/bbs/add";
	      
	}
	
	@RequestMapping("/bbs/view.do") 
    public String bbsView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		//글 보기
		request.setAttribute("bbsNum", map.get("bbsNum"));
		return "/bbs/view";
	}
	
	@RequestMapping("/bbs/edit.do") 
    public String bbsEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		//글 보기
//		request.setAttribute("bbsNum", map.get("bbsNum"));
		return "/bbs/edit";
	}
	
	@RequestMapping(value = "/bbs/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String selectBbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.bbsList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.addBbs(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.removeBbs(map);
//		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsGet(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.getBbs(map);
//		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/imgView.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String imgBbsGet(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.getImgBbs(map);
//		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = bbsService.updateBbs(map);
//		System.out.println(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/bbs/fileUpload.dox")
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("bbsNum") int bbsNum, HttpServletRequest request,HttpServletResponse response, Model model)
//	기존 방식처럼 map으로 받는 것도 가능
	{
		String url = null;
		String path="c:\\img";
		try {

			//String uploadpath = request.getServletContext().getRealPath(path);
			String uploadpath = path;
			String originFilename = multi.getOriginalFilename();
//				업로드 할 당시의 이름
			String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
//				lastIndexOf(".") => 마지막 점의 위치로부터, length인 마지막까지를 substring=> 잘라내겠다.
//				=> 확장자만 extName으로 때어내겠다
			long size = multi.getSize();
			String saveFileName = genSaveFileName(extName);
			
			
//			System.out.println("uploadpath : " + uploadpath);
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
//				단위는 kb
			System.out.println("saveFileName : " + saveFileName);
			String path2 = System.getProperty("user.dir");
			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
			if(!multi.isEmpty())
			{
				File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
//					파일 저장 경로
				multi.transferTo(file);
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("fileName", saveFileName);
				map.put("path", "/img/" + saveFileName);
				map.put("bbsNum", bbsNum);
				map.put("orgName", originFilename);
				map.put("size", size);
				map.put("ext", extName);
				
				// insert 쿼리 실행
			    bbsService.addBbsImg(map);
				
				model.addAttribute("filename", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());
				
				return "redirect:list.do";
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:list.do";
	}
	    
	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
//			업로드 당시의 시간(ms까지)저장하는 이름으로 하여, 위에서 잘라낸 extName(확장자)와 결합
		fileName += extName;
		
		return fileName;
	}
}
