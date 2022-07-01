package com.webboard.boardstudy.DTO;

public class Criteria {

    private int page; //현재 페이지 번호
    private int perPageNum; //한 페이지당 보여줄 게시글의 갯수


    public int getPageStart() { //특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
        //현재 페이지의 게시글 시작 번호 = (현재 페이지 번호 - 1) * 페이지당 보여줄 게시글 갯수
        return (this.page-1)*perPageNum;
    }

    public Criteria() {
        //처음 게시판에 들어왔을 때 기본 생성자를 통해 기본 값 세팅
        this.page = 1;
        this.perPageNum = 10;
    }

    public int getPage() {
        return page;
    }
    //페이지가 음수값이 되지 않게 설정, 음수가 되면 1 페이지를 나타냄.
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    public int getPerPageNum() {
      return perPageNum;
    }
    //페이지당 보여줄 게시글 수가 변하지 않게 설정
    public void setPerPageNum(int pageCount) {
        int cnt = this.perPageNum;
        if(pageCount != cnt) {
            this.perPageNum = cnt;
        } else {
            this.perPageNum = pageCount ;
        }
    }

}
