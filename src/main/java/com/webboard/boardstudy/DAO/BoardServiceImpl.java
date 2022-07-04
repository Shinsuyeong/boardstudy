package com.webboard.boardstudy.DAO;

import com.webboard.boardstudy.DTO.BoardDTO;
import com.webboard.boardstudy.DTO.SearchCriteria;
import com.webboard.boardstudy.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

    @Autowired
    private BoardMapper boardMapper;

    /*게시글 조회*/
    @Override
    public List<Map<String, Object>> selectBoardlist(SearchCriteria cri) throws Exception {
        return boardMapper.selectBoardList(cri);
    }
    /*게시글 등록*/
    @Override
    public void insertwrite(BoardDTO boardDTO) throws Exception {
        boardMapper.insertwrite(boardDTO);

    }
    /*게시글 상세조회(수정 시)*/
    @Override
    public BoardDTO viewBoard(BoardDTO boardDTO) throws Exception {
        boardMapper.hit(boardDTO);
        return boardMapper.viewBoard(boardDTO);
    }
    /*게시글 수정*/
    @Override
    public void updateBoard(BoardDTO boardDTO) throws Exception {
        boardMapper.updateBoard(boardDTO);
    }
    /*게시글 삭제*/
    @Override
    public void deleteBoard(String id) throws Exception {
        boardMapper.deleteBoard(id);
    }
    /*총 게시글 갯수*/
    @Override
    public int countBoardList(SearchCriteria cri) throws Exception {
        return boardMapper.countBoardList(cri);
    }

}
