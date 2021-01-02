<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="grid-container text-center">
    <hr>
    <section class="languages grid-x">
        <label for="languages"><spring:message code="animedb.languages" /></label>
        <select id="languages">
            <option value="ja_JP"<c:if test="${locale eq 'ja_JP'}"> selected disabled hidden</c:if>>日本語</option>
            <option value="ko_KR"<c:if test="${locale eq 'ko_KR'}"> selected disabled hidden</c:if>>한국어</option>
            <option value="en_US"<c:if test="${locale eq 'en_US'}"> selected disabled hidden</c:if>>English</option>
        </select>
    </section>
    <br>
    <p><spring:message code="animedb.contactUs" /><a href="mailTo:breezeisland8@gmail.com">breezeisland8@gmail.com</a></p>
    <p class="btm_txt">© COPYRIGHT 2020 animeDB All RIGHTS RESERVED</p>
</footer>
<script>
    $(function (){
        $("#languages").on('change', function (){
            location.href = "?locale=" + this.value;
        })
    })
</script>