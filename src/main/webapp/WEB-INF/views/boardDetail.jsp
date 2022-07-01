
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>


<html>
<head>
    <title>글 내용</title>
    <style>
        * {
            /*기본초기화*/
            margin: 0 auto; /*가운데 정렬*/
            padding: 0 auto; /*가운데 정렬*/
            overflow: hidden; /*자기 외에 안보이게 하기*/
        }
        h2 {
            text-align:center;
        }


    </style>
</head>
<body>
<h2>글 내용</h2>

    <form action='<c:url value='/contentForm${pageMaker.makeQueryPage(page)}'/>' method="post">
    <table width="500" cellpadding="0" cellspacing="0" border="1">
        <input type="hidden" name="id" value="${result.id}" />
        <input type="hidden" name="hit" value="${result.hit}" />
        <input type="hidden" name="name" value="${result.name}" />
        <%--<input type="hidden" name="boardDate" value="${result.boardDate}" />--%>
        <%--<input type="hidden" name="title" value="${result.title}" />
        <input type="hidden" name="content" value="${result.content}" />
        <input type="hidden" name="filepath" value="${result.filepath}" />
        <input type="hidden" name="filename" value="${result.filename}" />--%>
        <%--
        <input type="hidden" name="boardDate" value="${result.boardDate}" />
        <input type="hidden" name="title" value="${result.title}" />
        <input type="hidden" name="content" value="${result.content}" />
        <input type="hidden" name="filepath" value="${result.filepath}" />
        <input type="hidden" name="filename" value="${result.filename}" />
--%>
        <tr>
            <td style="text-align: center">조회수</td>
            <td>${result.hit}</td>
        </tr>
        <tr>
            <td style="text-align: center">작성자</td>
            <td>${result.name}</td>
        </tr>
        <tr>
            <td style="text-align: center">등록일</td>
            <td>
                <c:set var="dateVar" value="${result.boardDate}" />
                <fmt:formatDate value="${dateVar}" pattern="yyyy-MM-dd" />
            </td>
        </tr>
        <tr>
            <td style="text-align: center">제목</td>
            <td>${result.title}</td>
        </tr>
        <tr>
            <td style="text-align: center">내용</td>
            <td>${result.content}</td>
        </tr>
        <tr>
            <c:if test="${result.filepath ne null}">
                <tr>
                    <td style="text-align: center">다운로드</td>
                    <td>
                        <a href="fileDownload.do?filename=${result.filepath}">
                            <input type="text" id="filedown" value="${result.filename}"
                                   name="filename" class="form-control" readonly />
                        </a>
                </tr>
        </c:if>
        </tr>
        <tr>
            <c:if test="${result.filepath ne null}">
                <tr>
                    <td style="text-align: center">첨부파일</td>
                    <td>${result.filename}</td>
                </tr>
            </c:if>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center" >
                <a href='<c:url value='/contentForm${pageMaker.makeQueryPage(BoardDTO.id, pageMaker.cri.page)}'/>'><input type="submit" value="수정하기"></a>
                <%--<a href="boardList"><input type="button" value="목록보기"></a>&nbsp;&nbsp;--%>
                <a href='<c:url value='/boardList${pageMaker.makeQueryPage(page)}'/>'><input type="button" value="목록보기"></a>
            </td>
        </tr>


    </table>
</form>
</body>

<script type="text/javascript">
    /*수정 메시지*/
    function boardDetail_check(obj) {
        /*var filedown = document.getElementById("filedown");*/
        var actionType = $(obj).data("type");

        if(actionType == "Update") {
            alert("게시글을 수정하시겠습니까?")
            return false;
        }

        document.boardDetail.submit();
    }
</script>
</html>
