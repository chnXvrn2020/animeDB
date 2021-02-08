<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <%--人気の書き込み、アニメ情報、ショッピング情報を出力、修正必要--%>
        <div class="grid-x grid-padding-y">
            <div id="mainIndex" class="cell">
                <section class="indexList">
                    <div class="grid-x">
                        <%--人気の書き込み出力、修正必要--%>
                        <div id="indexPopular" class="cell">
                            <h3><a><spring:message code="community.popular" /></a></h3>
                            <hr>
                            <ul>
                                <li>
                                    <a>人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１</a>
                                </li>
                                <li>
                                    <a>人気の書き込み２</a>
                                </li>
                                <li>
                                    <a>人気の書き込み３</a>
                                </li>
                                <li>
                                    <a>人気の書き込み４</a>
                                </li>
                                <li>
                                    <a>人気の書き込み５</a>
                                </li>
                                <li>
                                    <a>人気の書き込み６</a>
                                </li>
                                <li>
                                    <a>人気の書き込み７</a>
                                </li>
                                <li>
                                    <a>人気の書き込み８</a>
                                </li>
                                <li>
                                    <a>人気の書き込み９</a>
                                </li>
                                <li>
                                    <a>人気の書き込み１０</a>
                                </li>
                            </ul>
                        </div>
                        <%--アニメ情報出力、修正必要--%>
                        <div id="indexAnimeInfo" class="cell">
                            <h3><a><spring:message code="animedb.animeNews" /></a></h3>
                            <hr>
                            <ul>
                                <li>
                                    <a>アニメ情報１アニメ情報１アニメ情報１アニメ情報１アニメ情報１アニメ情報１</a>
                                </li>
                                <li>
                                    <a>アニメ情報２</a>
                                </li>
                                <li>
                                    <a>アニメ情報３</a>
                                </li>
                                <li>
                                    <a>アニメ情報４</a>
                                </li>
                                <li>
                                    <a>アニメ情報５</a>
                                </li>
                                <li>
                                    <a>アニメ情報６</a>
                                </li>
                                <li>
                                    <a>アニメ情報７</a>
                                </li>
                                <li>
                                    <a>アニメ情報８</a>
                                </li>
                                <li>
                                    <a>アニメ情報９</a>
                                </li>
                                <li>
                                    <a>アニメ情報１０</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </section>
            </div>
            <%@include file="../inc/rightSection.jsp"%>
        </div>
    </div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>

