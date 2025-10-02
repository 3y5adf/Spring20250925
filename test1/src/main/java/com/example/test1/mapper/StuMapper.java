package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;



@Mapper
public interface StuMapper {
	Student stuInfo(HashMap<String, Object> map);
	List<Student> stuList(HashMap<String, Object> map);
//	2개이상의 값을 리턴받을 때는, list로 묶어주어야 작동
	//학생 삭제
	int stuDelete(HashMap<String, Object> map);
	//학생 정보 조회
	Student stuView(HashMap<String, Object> map);
	//학생 여러명 삭제
	int stuDeleteList(HashMap<String, Object> map);
	
//	List<Student> stuNoAll(HashMap<String, Object> map);
}
