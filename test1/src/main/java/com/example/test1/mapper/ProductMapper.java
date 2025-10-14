package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {
	// 제품 목록
	List<Product> selectProductList(HashMap<String, Object> map);
	// 메뉴 목록
	List<Menu> selectMenuList(HashMap<String, Object> map);
	// 메뉴 추가용 종류 목록
	List<Menu>selectMenuAddList(HashMap<String, Object> map);
	// 제품 등록
	int insertFood(HashMap<String, Object> map);
	//첨부파일(이미지) 업로드
	int insertFoodImg(HashMap<String, Object> map);
	// 제품 상세
	Product selectFoodInfo(HashMap<String, Object> map);
	
//	List<Product> selectProductSrch(HashMap<String, Object> map);
}
