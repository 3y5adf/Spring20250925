package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.User;

@Mapper
public interface UserMapper {
	
	User userLogin(HashMap<String, Object> map);
//	자바가 아니라 XML파일에서 찾음
//	XML과 MAPPER는 1대1 매칭이 되어야 함
	
	
}
