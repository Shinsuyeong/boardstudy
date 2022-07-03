package com.webboard.boardstudy.web;

import com.webboard.boardstudy.DAO.BoardService;
import com.webboard.boardstudy.DTO.BoardDTO;
import com.webboard.boardstudy.DTO.PageMaker;
import com.webboard.boardstudy.DTO.SearchCriteria;
import org.apache.commons.io.FilenameUtils;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;



@Controller
public class BoardController {

    /*자동으로 bean생성*/
    @Autowired
    BoardService boardService;

    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

    @RequestMapping("/")
    public String index() {

        return "redirect:boardList";  //boardList로 주소 바뀜
    }

    //게시글 조회
    @RequestMapping("/boardList")
    public String boardList(Model model, SearchCriteria cri) throws Exception {

        //PageMaker() 객체 생성
        PageMaker pageMaker = new PageMaker();
        //page와 perPageNum 셋팅
        pageMaker.setCri(cri);
        //총 게시글 수 세팅
        pageMaker.setTotalCount(boardService.countBoardList(cri));

        List<Map<String,Object>> list = boardService.selectBoardlist(cri);
        model.addAttribute("list", list);
        //셋팅된 pageMaker에는 페이징을 위한 버튼의 값들이 들어있고 boardList 이용해 jsp에 넘겨준다
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("page", cri.getPage());

        return "boardList"; //"boardList.jsp" 디스패치 해줌.
    }

    //게시글 작성 폼
    @RequestMapping("/boardForm")
    public String boardForm() {

        return "boardForm"; //"boardForm.jsp" 디스패치 해줌.
    }

    //게시글 작성 액션
    @RequestMapping("/writeAction")
    public String boardAction(@ModelAttribute("BoardDTO") BoardDTO boardDTO) throws Exception {

        // 파일 업로드 처리
        MultipartFile uploadFile = boardDTO.getUploadFile();
        if (!uploadFile.isEmpty()) {
            String originalFileName = uploadFile.getOriginalFilename();
            String ext = FilenameUtils.getExtension(originalFileName); // 확장자 구하기
            UUID uuid = UUID.randomUUID(); // UUID 구하기
            String fileName = uuid + "." + ext;
            uploadFile.transferTo(new File("C:\\upload\\" + fileName));
            boardDTO.setFilepath(fileName);
            boardDTO.setFilename(originalFileName);
        }

        //list 얻어왓듯이 서비스 통해 write
        boardService.insertwrite(boardDTO);

        System.out.println("글쓰기 성공!");
        return "redirect:boardList";

    }

    //게시글 상세보기
    @RequestMapping("/boardDetail")
    public String boardDetail(@ModelAttribute("boardDTO") BoardDTO boardDTO, HttpServletRequest request,
                              Model model, SearchCriteria cri) throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        boardDTO.setId(id);

        BoardDTO dto = boardService.viewBoard(boardDTO);
        model.addAttribute("result", dto);

        //페이징 유지
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        model.addAttribute("page", cri.getPage());
        model.addAttribute("pageMaker", pageMaker);

        return "boardDetail";

    }

    //게시글 수정
    @RequestMapping("/contentForm")
    public String contentForm( @ModelAttribute("boardDTO") BoardDTO boardDTO,
                               HttpServletRequest request, Model model, SearchCriteria cri) throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        boardDTO.setId(id);

        BoardDTO dto = boardService.viewBoard(boardDTO);
        model.addAttribute("result", dto);

        //페이징 유지
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        model.addAttribute("page", cri.getPage());
        model.addAttribute("pageMaker", pageMaker);

        return "contentForm"; //contentForm.jsp로 리다이렉트 됨.
    }

    //게시글 수정 액션
    @RequestMapping("/updateAction")
    public String updateAction(@ModelAttribute("boardDTO") BoardDTO boardDTO,
                               SearchCriteria cri, RedirectAttributes redAttr, Model model) throws Exception {

        // 파일 업로드 처리
        MultipartFile uploadFile = boardDTO.getUploadFile();
        if (!uploadFile.isEmpty()) {
            String originalFileName = uploadFile.getOriginalFilename();
            String ext = FilenameUtils.getExtension(originalFileName); // 확장자 구하기
            UUID uuid = UUID.randomUUID(); // UUID 구하기
            String fileName = uuid + "." + ext;
            uploadFile.transferTo(new File("C:\\upload\\" + fileName));
            boardDTO.setFilepath(fileName);
            boardDTO.setFilename(originalFileName);
        }

        boardService.updateBoard(boardDTO);

        //페이징 정보를 리다이렉트 해준다.
        redAttr.addAttribute("page", cri.getPage());
        redAttr.addAttribute("perPagNum", cri.getPerPageNum());

        System.out.println("글 수정 성공!");


        BoardDTO dto = boardService.viewBoard(boardDTO);
        model.addAttribute("result", dto);

        return "boardDetail";


    }

    //게시글 삭제 액션
    @RequestMapping("/deleteAction")
    public String deleteAction(@RequestParam("id") String id) throws Exception{

        boardService.deleteBoard(id);

        System.out.println("글 삭제 성공!");
        return "redirect:boardList"; //boardList.jsp로 리다이렉트 됨.

    }


}
