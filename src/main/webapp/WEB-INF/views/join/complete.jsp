<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <nav aria-label="breadCrumb" role="navigation">
            <ul class="breadcrumbs">
                <li class="breadcrumb-item active">
                    <span>利用規約に同意</span>
                </li>
                <li class="breadcrumb-item">
                    <span>新規情報入力</span>
                </li>
                <li class="breadcrumb-item">
                    <span class="active">新規登録完了</span>
                </li>
            </ul>
        </nav>
        <hr style="margin-top: 3%">
        <div class="joinComplete text-center">
            <h3>アニメDBでの会員登録が完了されました。</h3>
            <p>アニメDBは皆様の為に最善を尽くします。<br><br>

                コミュニティ、ショッピングなどのサービスはログインのあとにご利用でき、<br>
                ログインはメールアドレスでの認証のあとご利用できます。<br><br>

                会員登録の時にご入力になられたメールアドレスをご確認し、認証を進めてください。<br>
                ありがとうございます。
            </p>
        </div>
        <div class="text-center">
            <button type="button" class="button primary" onclick="location.href='../../..'"><i class="fi-check"></i> ホームへ</button>
        </div>
    </div>
</div>

<%@include file="../inc/footer.jsp"%>
</body>
