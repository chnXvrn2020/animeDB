<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
    <script src="https://www.animedb.site/ckeditor/ckeditor.js"></script>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <div class="grid-x grid-padding-y cell">
            <section class="community-write">
                <form:form modelAttribute="postVO" onsubmit="return validate(this);">
                    <spring:message code="community.inputTitle" var="inputTitle" />
                    <form:input path="title" cssClass="input-group-field" placeholder="${inputTitle}" />
                    <form:textarea path="content" />
                    <div class="community-write-btn">
                        <button type="submit" class="button"><spring:message code="community.write" /></button>
                        <button type="button" class="button alert"><spring:message code="animedb.back" /></button>
                    </div>
                    <form:hidden path="idx" />
                    <form:hidden path="listIdx" />
                </form:form>
            </section>
        </div>
    </div>
</div>
<script>
    CKEDITOR.replace('content', {height:500,
                                filebrowserImageUploadUrl : '${contextPath}/uploadImg'});

    function validate(frm) {
        if (formInput(frm.title, '<spring:message code="community.inputTitle" />')) return false;
        if (CKEDITOR.instances.content.getData().replace(/(\<\/?p\>)|(\<br\s?\/?\>)|(&nbsp;)/g, '') === '') {
            alert('<spring:message code="community.inputContent" />');
            CKEDITOR.instances.content.focus();
            return false;
        }

        return true;
    }
</script>
<%@include file="../inc/footer.jsp"%>
</body>