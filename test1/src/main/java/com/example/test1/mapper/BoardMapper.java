package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {
	//게시글 목록 호출
	List<Board> boardList(HashMap<String, Object> map);
	//게시글 전체 개수
	int boardCnt(HashMap<String, Object> map);
	//게시글 삭제
	int deleteBoard(HashMap<String, Object> map);
	//게시글 여러개 한번에 삭제
	int deleteBoardList(HashMap<String, Object> map);
	//게시글 추가
	int insertBoard(HashMap<String, Object> map);
	//게시글 상세보기
	Board selectBoard(HashMap<String, Object> map);
	//게시글 수정
	int updateBoard(HashMap<String, Object> map);
	//댓글 목록 호출
	List<Comment> selectCommentList(HashMap<String, Object> map);
	//댓글 등록
	int insertComment(HashMap<String, Object> map);
	//조회수 증가
	int updateCnt(HashMap<String, Object> map);
	//댓글 삭제
	int deleteComment(HashMap<String, Object> map);
	//첨부파일(이미지) 업로드
	int insertBoardImg(HashMap<String, Object> map);
	//첨부 파일 목록
	List<Board> selectFileList(HashMap<String, Object> map);
}
