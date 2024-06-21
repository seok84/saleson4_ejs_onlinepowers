<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<footer id="footer">

</footer>

<page:javascript>
    <script type="application/javascript">
        $(function () {
            $.ajax({
                type :"GET",
                async : true,
                url : '/footer',
                dataType : 'html',
                success: function(response, status, request) {
                    $('#footer').empty().append(response);
                }
            });
        });
    </script>
</page:javascript>