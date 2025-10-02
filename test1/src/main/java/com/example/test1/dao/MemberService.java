package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	@Autowired//객체 재사용
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	//세션 관리는 이걸 필수로 써야 함
	
	//타입을 리스트나 해시맵으로 하면 값을 여러개 가져갈 수 있음
	public HashMap<String, Object> login(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper .memberLogin(map);
		String message = member != null ? "로그인 성공!" : "로그인 실패!";
		String result = member != null ? "success" : "fail";
		
		if(member != null) {
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	public HashMap<String, Object> idCheck(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper .memberIdCheck(map);
//		String message = member != null ? "이미 사용중인 아이디 입니다." : "사용 가능한 아이디 입니다.";
		String result = member != null ? "true" : "false";
		
//		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}

	public HashMap<String, Object> logout(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// 세션 정보 삭제하는 방법은
		// 1개씩 키값을 이용해 삭제하거나, 전체를 한번에 삭제
		
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다.";
		resultMap.put("msg", message);
		
//		session.removeAttribute("sessionId"); //1개씩 삭제
		session.invalidate();//세션정보 전체 삭제
		
		return resultMap;
	}

	public HashMap<String, Object> join(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		return resultMap;
	}
	
	public HashMap<String, Object> memberInsert(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = memberMapper .memberAdd(map);
		List<Member> profileList = memberMapper.memberProfileList(map);
		
		if(cnt<1) {
			resultMap.put("result", "fail");
		} else {
			resultMap.put("result", "success");
			resultMap.put("profileList", profileList);
		}
		
		return resultMap;
	}
	
	
}
