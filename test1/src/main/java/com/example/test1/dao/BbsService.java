package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;

import javax.servlet.http.HttpSession;

@Service
public class BbsService {
	@Autowired
	BbsMapper bbsMapper;
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> bbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Bbs> list = bbsMapper.selectBbsList(map);
			
			int cnt = bbsMapper.selectBbsListCnt(map);
			
			resultMap.put("cnt", cnt);
			resultMap.put("list", list);
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		try {
			int cnt = bbsMapper.insertBbs(map);
			System.out.println(map);
			resultMap.put("bbsNum", map.get("bbsNum"));
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	public void addBbsImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = bbsMapper.insertBbsImg(map);
	}
	
	public HashMap<String, Object> removeBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = bbsMapper.deleteBbs(map);

			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	
	public HashMap<String, Object> getBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Bbs bbs = bbsMapper.getBbs(map);
		
		try {
			session.setAttribute("sessionBbsNum", bbs.getBbsNum());
			resultMap.put("info", bbs);
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getImgBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Bbs> bbsImg = bbsMapper.getBbsImg(map);
		
		try {

			resultMap.put("list", bbsImg);
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> updateBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = bbsMapper.updateBbs(map);

			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
}
