package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Service
public class ProductService {
	
	@Autowired
	ProductMapper productMapper;
	
	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Product> list = productMapper.selectProductList(map);
			List<Menu> menuList = productMapper.selectMenuList(map);
			
			resultMap.put("list", list);
			resultMap.put("menuList", menuList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public HashMap<String, Object> getMenuList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Menu> addMenuList = productMapper.selectMenuAddList(map);
			resultMap.put("list", addMenuList);
			
			List<Menu> menuList = productMapper.selectMenuList(map);
			resultMap.put("menuList", menuList);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public HashMap<String, Object> addFood(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = productMapper.insertFood(map);
			resultMap.put("foodNo", map.get("foodNo"));
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public void addFoodImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = productMapper.insertFoodImg(map);
		
	}
	
	public HashMap<String, Object> infoFood(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Product foodInfo = productMapper.selectFoodInfo(map);
			resultMap.put("info", foodInfo);
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public HashMap<String, Object> addPayHistory(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productMapper.insertPayHistory(map);
				//오류 나면 catch로 가니 int cnt = 를 생략
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
//	public HashMap<String, Object> productSrch(HashMap<String, Object> map) {
//		// TODO Auto-generated method stub
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		
//		try {
//			List<Product> list = productMapper.selectProductSrch(map);
//			
//			resultMap.put("list", list);
//			resultMap.put("result", "success");
//		} catch (Exception e) {
//			// TODO: handle exception
//			resultMap.put("result", "fail");
//			System.out.println(e.getMessage());
//		}
//		return resultMap;
//	}

}
