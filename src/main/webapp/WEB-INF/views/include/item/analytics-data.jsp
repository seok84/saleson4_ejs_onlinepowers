<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="item-analytics-data" style="display: none"
     data-item-user-code="${item.itemUserCode}"
     data-item-name="${item.itemName}"
     data-brand="${item.brand}"
     data-present-price="${item.presentPrice}"
     data-discount-amount="${item.totalDiscountAmount + item.userLevelDiscountAmount}"
></div>