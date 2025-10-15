package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
//	xml에 있는 함수와 이름이 같아야 함
	//로그인
	Member memberLogin(HashMap<String, Object> map);
//	Member memberLoginPwd(HashMap<String, Object> map);
	//id체크
	Member memberIdCheck(HashMap<String, Object> map);
	//가입
	int memberAdd(HashMap<String, Object> map);
	//프로필 이미지 업로드
	List<Member>memberProfileList(HashMap<String, Object> map);
	//회원 관리용 리스트 호출
	List<Member>mgrMemberList(HashMap<String, Object> map);
	//로그인 실패 카운트 상승
	int loginCntUp(HashMap<String, Object> map);
	//로그인 실패 카운트 초기화
	int loginCntReset(HashMap<String, Object> map);
	//비밀번호 찾기용 회원 조회
	Member selectPwdFind(HashMap<String, Object> map);
	int selectPwdFind2(HashMap<String, Object> map);
	//비밀번호 변경
	int memberPwdChange(HashMap<String, Object> map);
}
