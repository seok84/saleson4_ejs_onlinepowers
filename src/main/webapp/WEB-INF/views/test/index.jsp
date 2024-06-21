<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>

<layout:default>
    //JSP내용 ${title}

    <button onclick="windowTest()">윈도우</button>

    <script>
        const windowTest = ()=>{
            $saleson.core.alert('윈도우');
            return false;
        }
    </script>
</layout:default>
