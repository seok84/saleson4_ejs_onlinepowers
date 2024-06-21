<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="terms-lnb">
    <a href="/policy/agreement" class="link ${activeType eq 'agreement' ? 'active' :''}"><span>이용약관</span></a>
    <a href="/policy/protect" class="link en ${activeType eq 'protect' ? 'active' :''}"><span>개인정보<br class="mobile">처리방침</span></a>
    <a href="/policy/refuse-email" class="link ${activeType eq 'refuse-email' ? 'active' :''}"><span>이메일<br class="mobile">수신거부</span></a>
    <a href="/policy/marketing" class="link ${activeType eq 'marketing' ? 'active' :''}"><span>마케팅<br class="mobile">수신동의</span></a>
</div>