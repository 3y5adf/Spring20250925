package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;

@Mapper
public interface BbsMapper {
	
	//목록
	List<Bbs> selectBbsList(HashMap<String, Object> map);
	//게시글 전체 개수
	int selectBbsListCnt(HashMap<String, Object> map);
	//이미지 업로드
	int insertBbsImg(HashMap<String, Object> map);
	//게시글 작성
	int insertBbs(HashMap<String, Object> map);
	//게시글 삭제
	int deleteBbs(HashMap<String, Object> map);
	//게시글 보기
	Bbs getBbs(HashMap<String, Object> map);
	//게시글에 연결된 IMG 가져오기
	List<Bbs> getBbsImg(HashMap<String, Object> map);
	//게시글 수정
	int updateBbs(HashMap<String, Object> map);
}
