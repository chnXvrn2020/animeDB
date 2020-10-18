<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:set value="${sessionScope.member}" var="member" />
<c:if test="${empty member}">
    <script>
        location.href = '${contextPath}/';
    </script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <div class="memberProfile">
            <div class="grid-x grid-padding-y">
                <div class="small-8 cell">
                    <div class="grid-x memberImage">
                        <img src="${contextPath}/assets/images/img/profile_image.png">
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">ID</span>
                        <span class="small-4">${member.userId}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">ニックネーム</span>
                        <span class="small-4">${member.nickname}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">お名前</span>
                        <div class="small-4">
                            <div class="grid-x">
                                <div class="small-3">
                                    <span style="font-size: 12px">${member.furiFirst}</span><br>
                                    <span>${member.firstName}</span><br>
                                </div>
                                <span class="small-1">　</span>
                                <div class="small-3">
                                    <span style="font-size: 12px">${member.furiLast}</span><br>
                                    <span>${member.lastName}</span><br>
                                </div>
                            </div>

                        </div>

                    </div>
                    <div class="grid-x info">
                        <span class="small-3">性別</span>
                        <span class="small-4">${member.gender}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">生年月日</span>
                        <span class="small-4"><fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">メールアドレス</span>
                        <span class="small-4">${member.email}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">郵便番号</span>
                        <span class="small-4">${member.addr1}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">住所</span>
                        <span class="small-4">${member.addr2}<br>${member.addr3}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">携帯番号</span>
                        <span class="small-4">${member.phone}</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="memberProfileBtn">
            <button class="button primary" type="button" onclick="location.href = '${contextPath}modify'">会員情報変更</button>
            <button class="button alert" type="button">パスワード変更</button>
            <button class="button secondary" type="button" onclick="location.href = '${contextPath}leaveId'">会員解除</button>
        </div>
    </div>
</div>

<%@include file="../inc/footer.jsp"%>
</body>

