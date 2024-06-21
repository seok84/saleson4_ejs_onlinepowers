<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty firebaseConfig and firebaseConfig.enabled}">
    <script type="module">

        import FirebaseEventHandler from "/static/content/modules/analytics/FirebaseEventHandler.js";

        window.$firebase = new FirebaseEventHandler({
            apiKey: '${firebaseConfig.config.apiKey}',
            authDomain: '${firebaseConfig.config.authDomain}',
            projectId: '${firebaseConfig.config.projectId}',
            storageBucket: '${firebaseConfig.config.storageBucket}',
            messagingSenderId: '${firebaseConfig.config.messagingSenderId}',
            appId: '${firebaseConfig.config.appId}',
            measurementId: '${firebaseConfig.config.measurementId}'
        });
        $firebase.init();
        <%--<c:if test="${salesonContext.userId > 0}">
            $firebase.setUserId('${salesonContext.userId}');
            </c:if>--%>

    </script>
</c:if>