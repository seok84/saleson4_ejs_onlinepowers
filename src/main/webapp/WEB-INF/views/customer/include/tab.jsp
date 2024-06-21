<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="customer-tab">
    <a href="/customer/notice" class="link ${activeType eq 'notice' ? 'active' :''}"><span>공지사항</span></a>
    <a href="/customer/faq" class="link en ${activeType eq 'faq' ? 'active' :''}"><span>FAQ</span></a>
    <a href="/customer/inquiry" class="link ${activeType eq 'inquiry' ? 'active' :''}"><span>1:1문의</span></a>
    <a href="/customer/store-inquiry" class="link ${activeType eq 'store-inquiry' ? 'active' :''}"><span>제휴/입점문의</span></a>
</div>
