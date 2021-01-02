<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:if test="${not empty member}">
    <script>
        location.href = '${animedbUrl}';
    </script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <nav aria-label="breadCrumb" role="navigation">
            <ul class="breadcrumbs">
                <li class="breadcrumb-item active">
                    <span class="active"><spring:message code="signup.accept" /></span>
                </li>
                <li class="breadcrumb-item">
                    <span><spring:message code="signup.newInfo" /></span>
                </li>
                <li class="breadcrumb-item">
                    <span><spring:message code="signup.completed" /></span>
                </li>
            </ul>
        </nav>
        <hr style="margin-top: 3%">
        <div class="joinAgree">
            <b><spring:message code="signup.service" /></b>
            <textarea wrap="hard" rows="10" class="control-box" readonly>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ex eros, ultricies sed sodales nec, sodales sit amet diam. Aliquam aliquet quis massa ut imperdiet. Morbi feugiat non risus nec auctor. Ut ut est rhoncus, mattis urna ac, condimentum lorem. Nam aliquam arcu quis porta sodales. In id iaculis tellus. Fusce efficitur aliquet urna, vitae varius purus tincidunt sit amet. Aliquam pulvinar arcu et eros posuere luctus. Etiam in ex risus. Nulla ac massa lorem. Nunc elit elit, malesuada eget cursus non, dignissim ac quam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vivamus iaculis aliquet risus, eget auctor ex pharetra a. Fusce a justo eu lorem sollicitudin molestie. Donec aliquet ut ligula a dapibus. Morbi massa sapien, porttitor sed sem ac, porttitor tincidunt felis.

Vivamus pretium nec magna et laoreet. Sed dictum fermentum gravida. Aliquam nec posuere diam, at gravida enim. Vestibulum ex augue, efficitur at tristique non, aliquet at justo. Integer blandit sem sit amet consectetur feugiat. Pellentesque neque mauris, porttitor quis consectetur quis, interdum at diam. Nam commodo cursus ante id feugiat. Aenean fermentum pharetra tincidunt. Duis iaculis dolor sed massa fringilla, sed scelerisque justo porttitor. Sed hendrerit tincidunt orci non tempus.

In at vestibulum dui. Nunc id pretium massa, ut tempor turpis. Praesent consectetur, odio eu imperdiet pretium, arcu risus cursus metus, a commodo augue erat non ipsum. Integer lobortis iaculis consectetur. Vestibulum a arcu ultrices, feugiat ante vitae, pulvinar mi. Maecenas volutpat tempus eros. Nunc porttitor feugiat vestibulum. Etiam porta lobortis magna eu vestibulum. Nam eget leo tortor. Praesent et dictum neque. Aliquam nec fringilla ipsum. Integer et leo aliquet, tempor mauris non, accumsan tortor. Phasellus ac ultricies lectus. Cras interdum nibh libero.

Proin tincidunt metus non blandit luctus. Duis ligula turpis, faucibus luctus tortor eget, elementum pharetra enim. Aenean libero ante, ullamcorper eu dui quis, bibendum rutrum elit. Morbi posuere condimentum metus eu egestas. Fusce suscipit augue non elit lobortis scelerisque. Integer finibus sapien id arcu consequat, ac pellentesque mauris accumsan. Mauris vel enim lacus. Nunc sit amet dictum dolor. Maecenas eget purus ut risus molestie rutrum sit amet sit amet enim.

Sed a enim viverra, malesuada sapien vitae, faucibus magna. Nunc scelerisque egestas massa, a mattis tortor feugiat ut. Aliquam ut sodales elit, eu aliquam tellus. Sed quis velit ut dolor tristique tristique non vitae ex. Sed vitae posuere ante, in congue nisl. Donec mi lectus, venenatis ac pellentesque et, rhoncus vel nibh. Cras volutpat nulla in feugiat vehicula. Donec quis efficitur tortor, sit amet scelerisque leo. Aenean arcu dui, tristique vel ex in, egestas tempus tellus. Sed porttitor neque id efficitur luctus. Phasellus nec molestie erat, et pretium sapien.
            </textarea>
            <div class="text-right">
                <input type="checkbox" id="agree1" class="check-box">
                <label for="agree1"><spring:message code="signup.agreeService" /></label>
            </div>
            <hr>
            <b><spring:message code="signup.personal" /></b>
            <textarea wrap="hard" rows="10" class="control-box" readonly>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ex eros, ultricies sed sodales nec, sodales sit amet diam. Aliquam aliquet quis massa ut imperdiet. Morbi feugiat non risus nec auctor. Ut ut est rhoncus, mattis urna ac, condimentum lorem. Nam aliquam arcu quis porta sodales. In id iaculis tellus. Fusce efficitur aliquet urna, vitae varius purus tincidunt sit amet. Aliquam pulvinar arcu et eros posuere luctus. Etiam in ex risus. Nulla ac massa lorem. Nunc elit elit, malesuada eget cursus non, dignissim ac quam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vivamus iaculis aliquet risus, eget auctor ex pharetra a. Fusce a justo eu lorem sollicitudin molestie. Donec aliquet ut ligula a dapibus. Morbi massa sapien, porttitor sed sem ac, porttitor tincidunt felis.

Vivamus pretium nec magna et laoreet. Sed dictum fermentum gravida. Aliquam nec posuere diam, at gravida enim. Vestibulum ex augue, efficitur at tristique non, aliquet at justo. Integer blandit sem sit amet consectetur feugiat. Pellentesque neque mauris, porttitor quis consectetur quis, interdum at diam. Nam commodo cursus ante id feugiat. Aenean fermentum pharetra tincidunt. Duis iaculis dolor sed massa fringilla, sed scelerisque justo porttitor. Sed hendrerit tincidunt orci non tempus.

In at vestibulum dui. Nunc id pretium massa, ut tempor turpis. Praesent consectetur, odio eu imperdiet pretium, arcu risus cursus metus, a commodo augue erat non ipsum. Integer lobortis iaculis consectetur. Vestibulum a arcu ultrices, feugiat ante vitae, pulvinar mi. Maecenas volutpat tempus eros. Nunc porttitor feugiat vestibulum. Etiam porta lobortis magna eu vestibulum. Nam eget leo tortor. Praesent et dictum neque. Aliquam nec fringilla ipsum. Integer et leo aliquet, tempor mauris non, accumsan tortor. Phasellus ac ultricies lectus. Cras interdum nibh libero.

Proin tincidunt metus non blandit luctus. Duis ligula turpis, faucibus luctus tortor eget, elementum pharetra enim. Aenean libero ante, ullamcorper eu dui quis, bibendum rutrum elit. Morbi posuere condimentum metus eu egestas. Fusce suscipit augue non elit lobortis scelerisque. Integer finibus sapien id arcu consequat, ac pellentesque mauris accumsan. Mauris vel enim lacus. Nunc sit amet dictum dolor. Maecenas eget purus ut risus molestie rutrum sit amet sit amet enim.

Sed a enim viverra, malesuada sapien vitae, faucibus magna. Nunc scelerisque egestas massa, a mattis tortor feugiat ut. Aliquam ut sodales elit, eu aliquam tellus. Sed quis velit ut dolor tristique tristique non vitae ex. Sed vitae posuere ante, in congue nisl. Donec mi lectus, venenatis ac pellentesque et, rhoncus vel nibh. Cras volutpat nulla in feugiat vehicula. Donec quis efficitur tortor, sit amet scelerisque leo. Aenean arcu dui, tristique vel ex in, egestas tempus tellus. Sed porttitor neque id efficitur luctus. Phasellus nec molestie erat, et pretium sapien.
            </textarea>
            <div class="text-right">
                <input type="checkbox" id="agree2" class="check-box">
                <label for="agree2"><spring:message code="signup.agreePersonal" /></label>
            </div>
            <hr>
            <div class="text-center">
                <button type="button" class="button alert" onclick="history.go(-1)"><i class="fi-x"></i> <spring:message code="animedb.back" /></button>
                <button type="button" class="button primary" id="agreeBtn"><i class="fi-check"></i> <spring:message code="signup.next" /></button>
            </div>
        </div>
    </div>
</div>
<script>
    $('#agreeBtn').click(function (){
        if ($('#agree1').is(":checked") === false || $('#agree2').is(":checked") === false) {
            alert('<spring:message code="alert.allAgree" />');
            return false;
        }
        location.href = "${animedbUrl}/signup/confirm";
    })
</script>
<%@include file="../inc/footer.jsp"%>
</body>