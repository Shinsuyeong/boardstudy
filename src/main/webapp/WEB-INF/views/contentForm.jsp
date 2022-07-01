
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


<form action="updateAction" method="post" enctype="multipart/form-data">
    <%--<form action='<c:url value='/updateAction${pageMaker.makeQueryPage(page)}'/>' method="post" enctype="multipart/form-data">--%>
    <table width="500" cellpadding="0" cellspacing="0" border="1">
        <input type="hidden" name="id" value="${result.id}" />
        <input type="hidden" name="hit" value="${result.hit}" />
        <input type="hidden" name="name" value="${result.name}" />

        <%--<tr>
            <td>번호</td>
            <td>${result.id}</td> &lt;%&ndash;번호랑 조회수 데이터도 물고 가져가줘야하니까 input을 새로 만들게 아니라 hidden태그를 만들어주면 됌.&ndash;%&gt;
        </tr>--%>
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
            <td><input type="text" name="title" value="${result.title}" size="50"></td>
        </tr>
        <tr>
            <td style="text-align: center">내용</td>
            <td>
                <textarea rows="10" cols="50" name="content">${result.content}</textarea>
            </td>
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
                <%--<button id="filedelete" type="button" class="btn_previous">파일지우기</button>--%>
                <button type="button" onclick="javascript:contentform_check(this);" data-type="fileDelete">파일지우기</button>
                    <%--<button type="button" onclick="javascript:fn_DeleteFile();"><span>삭제</span></button>--%>
        </tr>
        </c:if>
        </tr>
        <tr>
            <td style="text-align: center">첨부파일</td>
            <td>
                <input type="file" name="uploadFile" value="${result.filename}" size="50">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center" >
                <%--<input type="submit" value="수정하기">--%>
                <a href='<c:url value='/updateAction${pageMaker.makeQueryPage(result.id, page)}'/>'><input type="submit" value="수정하기"></a>
                <%--<a href="boardList"><input type="button" value="목록보기"></a>&nbsp;&nbsp;--%>
                <a href='<c:url value='/boardList${pageMaker.makeQueryPage(page)}'/>'><input type="button" value="목록보기"></a>
                <%--<a href="deleteAction?id=${result.id}"><input type="button" value="삭제하기">--%>
                <a href='<c:url value='/deleteAction${pageMaker.makeQueryPage(result.id, page)}'/>'><button type="button" onclick="javascript:contentform_check(this);" data-type="Delete">삭제하기</button></a>
                <%--<a href='<c:url value='/deleteAction${pageMaker.makeQueryPage(result.id, page)}'/>'><input type="button" value="삭제하기"></a>--%>
            </td>
        </tr>


    </table>

</form>
</body>

<script type="text/javascript">
    /*$("#btn_previous").click(function javascript_onclikc() {

        $(location).attr('href', '/boardList');

    });*/

   /* $("#filedelete").click(function javascript_onclikc() {
        $('#filedown').val(null);
    });*/


    /*삭제 메시지*/
    function contentform_check(obj) {
        /*var filedown = document.getElementById("filedown");*/
        var actionType = $(obj).data("type");

        if(actionType == "Delete") {
            alert("게시글을 삭제하시겠습니까?")
            return false;
        } else if(actionType == "fileDelete") {
            alert("파일을 삭제하시겠습니까?")
            $('#filedown').val(null);
            return false;
        }

        document.contentForm.submit();
    }
</script>
</html>
