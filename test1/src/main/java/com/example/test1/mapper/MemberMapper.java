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
	//id체크
	Member memberIdCheck(HashMap<String, Object> map);
	//가입
	int memberAdd(HashMap<String, Object> map);
	//프로필 이미지 업로드
	List<Member>memberProfileList(HashMap<String, Object> map);
}
