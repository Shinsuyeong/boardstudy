package com.webboard.boardstudy.mapper;

import com.webboard.boardstudy.DTO.BoardDTO;
import com.webboard.boardstudy.DTO.SearchCriteria;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

//@Mapper : Mybatis와 인터페이스 함수를 연결함.
@Mapper
public interface BoardMapper {


    //조회
    List<Map<String, Object>> selectBoardList(SearchCriteria cri) throws Exception;
    //등록
    void insertwrite(BoardDTO boardDTO) throws Exception;
    //조회수
    void hit(BoardDTO boardDTO) throws Exception;
    //상세보기
    BoardDTO viewBoard(BoardDTO boardDTO) throws Exception;
    //수정
    void updateBoard(BoardDTO boardDTO) throws Exception;
    //삭제
    void deleteBoard(String id) throws Exception;

    int countBoardList(SearchCriteria cri) throws Exception;

}
