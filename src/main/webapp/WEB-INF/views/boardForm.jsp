
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>글쓰기</title>
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
    <h2>글쓰기</h2>


    <form:form id="BoardDTO" name="boardForm" action="writeAction" method="post" enctype="multipart/form-data">
        <table width="500" cellpadding="0" cellspacing="0" border="1">
            <tr>
                <td>작성자</td>
                <td><input type="text" name="name" id="name" value="" size="50"></td>
            </tr>
            <tr>
                <td>제목</td>
                <td><input type="text" name="title" id="title" value="" size="50"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td>
                    <textarea rows="10" cols="50" name="content" id="content"></textarea>
                </td>
            </tr>
            <tr>
                <td>첨부파일</td>
                <td>
                    <input type="file" name="uploadFile" value="" size="50" >
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center" >
                    &nbsp;&nbsp;<button type="button" onclick="javascript:boardform_check(this);">글쓰기</button>
                    <a href="boardList"><input type="button" value="목록보기"></a>
                </td>
            </tr>
        </table>
    </form:form>

</body>

<%@include file="script.jsp"%>
</html>
