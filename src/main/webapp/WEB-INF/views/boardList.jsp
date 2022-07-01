
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>게시판 목록보기</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        * {
            /*기본초기화*/
            margin: 0 auto; /*가운데 정렬*/
            padding: 0 auto; /*가운데 정렬*/
            overflow: hidden; /*자기 외에 안보이게 하기*/
        }
        td, h2 {
            text-align:center;
        }

        ul {
            list-style: none;
            width : 95%;
            display: inline-block;
            text-align: center;
        }

        li {
            margin-left : 5px;
            display: inline-block;
        }


    </style>

</head>

<body>
    <h2>게시판 글목록</h2>
    <form role="form" method="get">

        <table width="500" cellpadding="0" cellspacing="0" border="1">
            <tr>
                <td colspan="5">
                    <select name="searchType">
                        <%--삼항연산자--%>
                        <option value="0" ${cri.searchType == 0 ? 'selected' : ''}>전체</option>
                        <option value="1" ${cri.searchType == 1 ? 'selected' : ''}>제목</option>
                        <option value="2" ${cri.searchType == 2 ? 'selected' : ''}>작성자</option>
                    </select>
                    <input id="keywordInput" name="keyword" type="text" value="${pageMaker.cri.keyword}">
                    <input id="searchBtn" type="submit">
                </td>
            </tr>
            <tr>
                <th>번호</th>
                <th>작성자</th>
                <th>제목</th>
                <th>등록일</th>
                <th>조회수</th>
            </tr>


            <c:forEach var="BoardDTO" items="${list}" varStatus="status">
                <tr>
                    <td>
                        <%--${BoardDTO.id}--%>
                        <c:out value="${pageMaker.totalCount-(((pageMaker.cri.page-1) * pageMaker.cri.perPageNum) + status.index)}" />
                    </td>
                    <td>${BoardDTO.name}</td>
                    <td>
                        <!--변경-->
                        <a href='<c:url value='/contentForm${pageMaker.makeQueryPage(BoardDTO.id, pageMaker.cri.page)}'/>'>${BoardDTO.title}</a>
                    </td>
                    <td>
                        <c:set var="dateVar" value="${BoardDTO.boardDate}" />
                        <fmt:formatDate value="${dateVar}" pattern="yyyy-MM-dd" />
                    </td>
                    <td>${BoardDTO.hit}</td>
                </tr>
            </c:forEach>

            <tr>
                <td colspan="5">
                    <a href="boardForm"><input type="button" value="글작성"></a>
                    <a href="boardList"><input type="button" value="목록보기"></a>&nbsp;&nbsp
                </td>
            </tr>
        </table>

        <ul class="btn-group pagination">
            <%--이전 버튼 생성여부 확인하여 버튼 보여줄 것.--%>
            <c:if test="${pageMaker.prev}">
                <li>
                    <!--변경-->
                    <%--<a href="boardList?page=${pageMaker.startPage-1}"><i class = "fa fa-chevron-left"></i></a>--%>
                    <a href='<c:url value='/boardList${pageMaker.makeQueryPage(pageMaker.startPage-1)}'/>'><i class = "fa fa-chevron-left"></i></a>
                </li>
            </c:if>
            <%--현재 페이지가 어딘 지 알 기 위해 추가.--%>
            <%--페이지의 시작번호와 끝 번호를 이용해 페이지 버튼들을 뿌려줄 것.--%>
            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
                <li>
                    <!--변경-->
                    <%--<a href="boardList?page=${pageNum}"><i class = "fa">${pageNum}</i></a>--%>
                    <a href='<c:url value="/boardList${pageMaker.makeQueryPage(pageNum)}"/>'>${pageNum}</a>
                </li>
            </c:forEach>
            <%--다음 버튼의 생성 여부를 확인하여 버튼 보여줄 것--%>
            <c:if test ="${pageMaker.next && pageMaker.endPage > 0}">
                <li>
                    <!--변경-->
                    <%--<a href="boardList?page=${pageMaker.endPage+1}"><i class = "fa fa-chevron-right"></i></a>--%>
                    <a href='<c:url value="/boardList${pageMaker.makeQueryPage(pageMaker.endPage+1)}"/>'><i class="fa fa-chevron-right"></i></a>
                </li>
            </c:if>
        </ul>
    </form>



    <script>
        /*웹브라우저 back키 누를 때, 페이지 재로딩*/
        window.onpageshow = function (event) {
            if (event.persisted) {
                document.location.reload();
            }
        }

        $(function () {
           $('#searchBtn').click(function () {
               var url = 'http://localhost:8070/boardList';
               url=url + "?searchType="+$("#searchBtn").val();
               url=url + "&keyword="+$("#keywordInput").val();
               location.href = url;
           });
        });
    </script>
</body>

<%@include file="script.jsp"%>
</html>

