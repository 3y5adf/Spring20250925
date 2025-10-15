package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.MemberService;
import com.google.gson.Gson;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
//	PasswordEncoder passwordEncoder;
	
		//controller에서 주소를 만들어주는(할당해주는) 어노테이션
	@RequestMapping("/member/login.do") 
//	주소 만들기
    public String login(Model model) throws Exception{

    return "/member/member-login";
	      
	}
	
	@RequestMapping("/member/join.do") 
    public String join(Model model) throws Exception{

    return "/member/member-join";
	      
	}
	
	@RequestMapping("/member/addr.do") 
    public String addr(Model model) throws Exception{

    return "/jusoPopup";
	      
	}
	
	@RequestMapping("/mgr/member/list.do") 
    public String mgr(Model model) throws Exception{

    return "/mgr/member-list";
	      
	}
	
	@RequestMapping("/mgr/member/view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("userId", map.get("userId"));
		return "/mgr/member-view";
	      
	}
	
	@RequestMapping("/member/pwd.do") 
    public String pwd(Model model) throws Exception{

    return "/member/pwd";
	      
	}
	
	@RequestMapping(value = "/mgr/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberMgrList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.mgrMemberList(map);
		
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberLogin(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.login(map);
//		System.out.println(map);
//		String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
//		System.out.println(hashPwd);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/logout.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberLogout(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.logout(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberIdCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.idCheck(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberInsert(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/mgr/member/release.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberClear(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberRelease(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/pwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String authMember(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberAuth(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/pwdChange.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pwdChange(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.changePwd(map);
		
		return new Gson().toJson(resultMap);
	}
	
	//잘 안됐음.
//	@RequestMapping("/fileUpload.dox")
//	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("idx") int idx, HttpServletRequest request,HttpServletResponse response, Model model)
//	{
//		String url = null;
//		String path="c:\\profile";
//		try {
//
//			//String uploadpath = request.getServletContext().getRealPath(path);
//			String uploadpath = path;
//			String originFilename = multi.getOriginalFilename();
//			String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
//			long size = multi.getSize();
//			String saveFileName = genSaveFileName(extName);
//			
////			System.out.println("uploadpath : " + uploadpath);
//			System.out.println("originFilename : " + originFilename);
//			System.out.println("extensionName : " + extName);
//			System.out.println("size : " + size);
//			System.out.println("saveFileName : " + saveFileName);
//			String path2 = System.getProperty("user.dir");
//			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\profile");
//			if(!multi.isEmpty())
//			{
//				File file = new File(path2 + "\\src\\main\\webapp\\profile", saveFileName);
//				multi.transferTo(file);
//				
//				HashMap<String, Object> map = new HashMap<String, Object>();
//				map.put("filename", saveFileName);
//				map.put("path", "/profile/" + saveFileName);
//				map.put("userId", userId);
//				map.put("orgName", originFilename);
//				map.put("size", size);
//				map.put("ext", extName);
//				
//				// insert 쿼리 실행
//			   // testService.addBoardImg(map);
//				
//				model.addAttribute("filename", multi.getOriginalFilename());
//				model.addAttribute("uploadPath", file.getAbsolutePath());
//				
//				return "redirect:list.do";
//			}
//		}catch(Exception e) {
//			System.out.println(e);
//		}
//		return "redirect:list.do";
//	}
//	    
//	// 현재 시간을 기준으로 파일 이름 생성
//	private String genSaveFileName(String extName) {
//		String fileName = "";
//		
//		Calendar calendar = Calendar.getInstance();
//		fileName += calendar.get(Calendar.YEAR);
//		fileName += calendar.get(Calendar.MONTH);
//		fileName += calendar.get(Calendar.DATE);
//		fileName += calendar.get(Calendar.HOUR);
//		fileName += calendar.get(Calendar.MINUTE);
//		fileName += calendar.get(Calendar.SECOND);
//		fileName += calendar.get(Calendar.MILLISECOND);
//		fileName += extName;
//		
//		return fileName;
//	}
		
}
