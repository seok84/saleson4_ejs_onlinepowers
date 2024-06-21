<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>

    <section class="terms">
        <div class="title-h1">${title}</div>
        <c:set var="activeType" value="${activeType}" scope="request"/>
        <jsp:include page="./include/tab.jsp"/>
        <div class="container">
            <div class="select-wrap">
                <select class="input-select" id="policy-select">
                    <option value="">선택</option>
                    <c:forEach var="p" items="${policies.policies}">
                        <option value="${p.policyId}">${p.title}</option>
                    </c:forEach>
                </select>
            </div>
            <div id="policy-content">
                ${policy.content}
            </div>
        </div>
    </section>

    <page:javascript>
        <script>
            $(function () {
                $('#policy-select').on('change', function (){
                    const id = $(this).val();

                    if (id != '') {
                        $saleson.api.get('/api/policy/${policyType}/' + id)
                            .then((response) =>{
                                const data = response.data;

                                $('#policy-content').html(data.content);
                            })
                            .catch((error)=>{
                                $saleson.core.api.handleApiExeption(error);
                            });
                    }
                });
            });
        </script>
    </page:javascript>
</layout:default>