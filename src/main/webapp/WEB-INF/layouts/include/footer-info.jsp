<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cs-center">
    <div class="cs-tel">
        고객센터
        <a class="tel" href="tel:${aboutUs.counselTelNumber}">${aboutUs.counselTelNumber}</a>
    </div>
    <p class="cs-time">
        평일 AM 09:00 ~ PM 06:00 (점심 PM 12:00 ~ PM 01:00)<br>
        주말 및 공휴일은 휴무입니다.
    </p>
</div>

<div class="info">
    <p class="company">${aboutUs.companyName} 사업자정보</p>
    <p class="business-info">
        <span class="owner">대표이사 : ${aboutUs.bossName}</span>
        <span class="business-number">사업자등록번호 : ${aboutUs.companyNumber}</span>
        <span class="business-type">통신판매신고번호 : ${aboutUs.mailOrderNumber}</span>
        <a onclick="window.open('https://www.ftc.go.kr/bizCommPop.do?wrkr_no=${aboutUs.companyNumber}', '_blank', 'width=800, height=600'); return false;">사업자정보 확인</a>
    </p>
    <p class="company-info">
        <span class="address">
            주소 : ${aboutUs.address} ${aboutUs.addressDetail}
        </span>
        <span class="security">
            개인정보보호 관리자 : ${aboutUs.adminName}
            <a href="mailto:${aboutUs.adminEmail}">E-mail : ${aboutUs.adminEmail}</a>
        </span>
    </p>
    <p class="copyright">${copyright}</p> 
</div>