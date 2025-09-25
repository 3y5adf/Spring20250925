package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface StuMapper {
	Student stuInfo(HashMap<String, Object> map);
}
