<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div>
    <form id="searchFilterForm">
        <div class="period-container">
            <label class="date"><input type="date"
                                       class="form-basic searchStartDate" name="searchStartDate"
                                       value="${criteria.viewStartDate}"><i></i></label>
            <span class="divider">~</span>
            <label class="date"><input type="date" name="searchEndDate"
                                       class="form-basic searchEndDate"
                                       value="${criteria.viewEndDate}"><i></i></label>
            <div class="form-line box">
                <div class="flex">
                    <div class="select-wrap">
                        <select class="input-select" id="searchDate">
                            <option value="">조회기간</option>
                            <option value="week-1">1주일</option>
                            <option value="month-1">1개월</option>
                            <option value="month-3">3개월</option>
                            <option value="month-6">6개월</option>
                        </select>
                    </div>
                    <button type="submit" id="PeriodSearch" class="btn btn-black">조회</button>
                </div>
            </div>
        </div>
    </form>
</div>