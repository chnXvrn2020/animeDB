<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${empty returnUrl}">
        <script>
            alert('${msg}');
            history.back();
        </script>
    </c:when>
    <c:otherwise>
        <script>
            alert('${msg}');
            location.replace('${returnUrl}');
        </script>
    </c:otherwise>
</c:choose>