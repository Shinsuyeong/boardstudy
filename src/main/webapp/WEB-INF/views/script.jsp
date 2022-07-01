
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">

    function boardform_check() {

        var name = document.getElementById("name");
        var title = document.getElementById("title");
        var content = document.getElementById("content");

        if(name.value == "") {
            alert("작성자를 입력하세요.");
            name.focus();
            return false;
        } else if(title.value == "") {
            alert("제목을 입력하세요.");
            title.focus();
            return false;
        } else if(content.value == "") {
            alert("내용을 입력하세요.")
            content.focus();
            return false;
        }

        alert("글쓰기 완료 !!")

        document.boardForm.submit();
    }

    function fn_DeleteFile(){
        var form = document.contentForm;
        var filedown = document.getElementById("filedown");

        if(confirm("삭제 하시겠습니까?")) {
            filedown.val(null);
            return false;
        }
        form.action = "<c:url value='contentForm.jsp'/>";
        form.method = "POST";
        form.submit();

    }
</script>
