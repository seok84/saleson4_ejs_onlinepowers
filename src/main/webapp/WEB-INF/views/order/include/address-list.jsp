<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<ul class="address-container">
  <c:forEach items="${pageContent.content}" var="list" varStatus="index">
    <li class="address-list ${index.first ? 'active' : ''}">
      <div class="radio-wrap">
        <c:set var="checked" value="${list.defaultFlag eq 'Y' ? 'checked' : ''}" />
        <label class="input-radio">
          <input type="radio" name="userAddress" class="default-address" ${checked} data-delivery-id="${list.userDeliveryId}"><i></i>
        </label>
      </div>
      <div class="address-content"
           data-user-name="${list.userName}"
           data-zipcode="${list.zipcode}"
           data-address="${list.address}"
           data-address-detail="${list.addressDetail}"
           data-mobile="${list.mobile}"
           data-new-zipcode="${list.newZipcode}"
           data-sido="${list.sido}"
           data-sigungu="${list.sigungu}"
           data-eupmyeondong="${list.eupmyeondong}">
        <div class="title"><strong>[${list.title}] ${list.userName}</strong>
          <c:if test="${list.defaultFlag eq 'Y'}" >
            <span class="default">기본배송지</span>
          </c:if>
        </div>
        <div>
          <p>[${list.zipcode}] ${list.address} ${list.addressDetail}</p>
          <p>${list.mobile}</p>
        </div>
    </li>
  </c:forEach>
  <page:pagination/>
</ul>

<script>
  $(function () {
    const $addressList = $('.address-list');
    $addressList.on('click', (event) => {
      $addressList.removeClass('active');

      let target = event.currentTarget;
      $(target).addClass('active');
    });
  })
</script>