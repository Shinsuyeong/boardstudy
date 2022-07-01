package com.webboard.boardstudy.DTO;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class PageMaker {

    private Criteria cri;
    private int totalCount; //총 게시글 수
    private int startPage; //화면에 보여질 첫번째 페이지 번호, 시작 페이지 번호
    private int endPage; //화면에 보여질 마지막 페이지 번호, 끝 페이지 번호
    private boolean prev; //이전 버튼 생성 여부
    private boolean next; //다음 버튼 생성 여부
    private int displayPageNum = 5; //화면 하단에 보여지는 페이지 버튼의 수

    public Criteria getCri() {
        return cri;
    }
    public void setCri(Criteria cri) {
        this.cri = cri;
    }
    public int getTotalCount() {
        return totalCount;
    }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData(); //총 게시글 수를 셋팅할때 calcData() 메서드를 호출하여 페이징 관련 버튼 계산을 한다.

    }

    //페이징의 버튼들을 생성하는 계산식. 끝 페이지 번호, 시작 페이지 번호, 이전, 다음 버튼들을 구한다.
    private void calcData() {

        //cri.getPage() : 현재 페이지 번호
        //끝 페이지 번호 = (현재 페이지 번호 / 화면에 보여질 페이지 번호의 갯수) * 화면에 보여질 페이지 번호의 갯수
        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);

        //시작 페이지 번호 = (끝 페이지 번호 - 화면에 보여질 페이지 번호의 갯수) + 1
        startPage = (endPage - displayPageNum) + 1;
        //시작 페이지 번호가 0보다 작으면 (음수) 시작 페이지를 1로 설정.
        if(startPage <= 0) startPage = 1;

        //cri.getPerPageNum() : 한페이지당 보여줄 게시글 갯수
        //마지막 페이지 번호 = 총 게시글 수 / 한 페이지당 보여줄 게시글의 갯수
        int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
        //마지막 페이지 번호를 구한 뒤, 끝 페이지 번호보다 작은 경우에 마지막 페이지의 번호를 끝 페이지 번호로 저장.
        //화면에 보여질 끝 페이지 번호는 마지막 페이지의 번호보다 클 수 없다.
        if(endPage > tempEndPage) {
            endPage = tempEndPage;
        }
        //이전 버튼은 시작 페이지 번호가 1이 아니면 생기기.
        prev = startPage == 1 ? false : true;
        //끝 페이지 번호 * 한 페이지당 보여줄 게시글 갯수 < 총 게시글의 수
        next = endPage * cri.getPerPageNum() < totalCount ? true : false;

    }

    //페이징처리2 (페이징 유지)
    public String makeQueryPage(int page) {
        UriComponents uri = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .build();
        return uri.toUriString();
    }

    public String makeQueryPage(int id, int page) {
        UriComponents uri = UriComponentsBuilder.newInstance()
                .queryParam("id", id)
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .build();
        return uri.toUriString();
    }

    //검색 (page, perPageNu, searchType, keyword를 url로 사용하기 위해 만듬)
    public String makeSearch(int page) {

        UriComponents uriComponents = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
                .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
                .build();
        return uriComponents.toUriString();
    }

    private String encoding(String keyword) {
        if (keyword == null || keyword.trim().length() == 0){
            return "";
        }

        try{
            return URLEncoder.encode(keyword, "UTF-8");
        }catch (UnsupportedEncodingException e) {
            return "";
        }
    }


    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isPrev() {
        return prev;
    }

    public void setPrev(boolean prev) {
        this.prev = prev;
    }

    public boolean isNext() {
        return next;
    }

    public void setNext(boolean next) {
        this.next = next;
    }

    public int getDisplayPageNum() {
        return displayPageNum;
    }

    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }
}
