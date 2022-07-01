package com.webboard.boardstudy.DTO;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

//@Data : lombok 연결

@Data
public class BoardDTO {

    /*번호*/
    private int id;
    /*제목*/
    /*@NotBlank
    @Max(value = 10)*/
    private String title;
    /*내용*/
    /*@NotBlank*/
    private String content;
    /*파일이름*/
    private String filename;
    /*파일*/
    private MultipartFile uploadFile;
    /*파일주소*/
    private String filepath;
    /*작성자*/
    /*@NotBlank
    @Max(value = 50)*/
    private String name;
    /*날짜*/
    private Date boardDate;
    /*조회수*/
    private int hit;


    /*기본생성자*/
    public BoardDTO () {

    }


}
