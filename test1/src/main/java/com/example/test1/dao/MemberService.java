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
		String message = ""; // 로그인 성공 실패 여부 메세지
		String result = "";//로그인 성공 실패 여부
		
//		내가 해본거
//		Member memberId = memberMapper .memberLogin(map);
//		Member memberPwd = memberMapper .memberLoginPwd(map);
//		
//		if(memberId != null) {
//			
//		} else {
//			String message = 
//		}
		
//		System.out.println(map);
//		System.out.println(member);
		
		
//		String message = member != null ? "로그인 성공!" : "로그인 실패!";
//		String result = member != null ? "success" : "fail";
		
		if(member != null) { //아이디&비밀번호 맞을 경우
//			System.out.println(member.getCnt());
			
			if(member.getCnt()>=5) {
				message = "로그인 불가(비밀번호를 5회 이상 잘못 입력하셨습니다.)";
				result = "fail";
			} else {
				// 로그인 성공 시, cnt 값 0으로 초기화
				int cntReset = memberMapper.loginCntReset(map);
				message= "로그인 성공!";
				result = "success";
				session.setAttribute("sessionId", member.getUserId());
				session.setAttribute("sessionName", member.getName());
				session.setAttribute("sessionStatus", member.getStatus());
				if(member.getStatus().equals("A")) {
					resultMap.put("url", "/mgr/member/list.do");
				} else {
					resultMap.put("url", "/main.do");
				}
			}
			
			
		} else { //아이디&비밀번호 틀릴 경우
			Member loginIdCheck = memberMapper .memberIdCheck(map);
			if(loginIdCheck != null) { //아이디는 맞을 경우
				//로그인 실패 시, cnt값 증가
				int cntUp = memberMapper.loginCntUp(map);
//				System.out.println(loginIdCheck.getCnt());
				result = "fail";
				if(loginIdCheck.getCnt()>=5) {
					message = "비밀번호를 5회 이상 잘못 입력하셨습니다. \n로그인이 차단됩니다.\n관리자에게 문의해주세요.";
					result = "fail";
				} else {
					message = "비밀번호를 확인해주세요.";
					result = "fail";
				}
				
			} else { //아이디가 틀릴 경우
				message = "아이디가 존재하지 않습니다.";
				result = "fail";
			}
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
	
	public HashMap<String, Object> mgrMemberList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Member> mgrList = memberMapper .mgrMemberList(map);
			resultMap.put("list", mgrList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage()); // e에 어떤 오류인지 담겨져 있음 -> 개발자가 오류를 확인하기 위해 사용하는 코드
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> memberRelease(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int releaseList = memberMapper .loginCntReset(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage()); // e에 어떤 오류인지 담겨져 있음 -> 개발자가 오류를 확인하기 위해 사용하는 코드
		}
		
		return resultMap;
	}
	
	
}
