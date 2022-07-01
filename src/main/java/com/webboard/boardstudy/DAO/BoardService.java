package com.webboard.boardstudy.DAO;

import com.webboard.boardstudy.DTO.BoardDTO;
import com.webboard.boardstudy.DTO.SearchCriteria;

import java.util.List;
import java.util.Map;

public interface BoardService {

    /*게시글 조회*/
    List<Map<String, Object>> selectBoardlist(SearchCriteria cri) throws Exception;

    /*게시글 등록*/
    void insertwrite(BoardDTO boardDTO) throws Exception;

    /*게시글 상세조회 (수정 시)*/
    BoardDTO viewBoard(BoardDTO boardDTO) throws Exception;

    /*게시글 수정*/
    void updateBoard(BoardDTO boardDTO) throws Exception;

    /*게시글 삭제*/
    void deleteBoard(String id) throws Exception;

    /*총 게시글 갯수*/
    int countBoardList(SearchCriteria cri) throws Exception;


    /*BoardDTO detailBoard(BoardDTO boardDTO) throws Exception;*/
}
