<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="detail-inquire-contents tabs-content">
    <!-- 필터 탭 -->
    <div class="filter-wrap">
        <p>총 <b id="item-inquiry-list-count">0</b>개</p>
        <span class="btn-edit-qna">Q&A 쓰기</span>
    </div>
    <!-- q&a작성 -->
    <form class="edit-qna-wrap hidden" id="item-inquiry-form">
        <div class="qna-option">
            <div class="select-wrap">
                <select class="input-select required" name="qnaGroup" title="문의 유형">
                    <option value="">문의 유형을 선택하세요</option>
                    <c:forEach var="type" items="${qnaGroups.list}">
                        <option value="${type.id}">${type.label}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="check-wrap">
                <label for="item-inquiry-secret-flag" class="circle-input-checkbox">
                    <input id="item-inquiry-secret-flag" type="checkbox" name="secretFlag" value="Y"><i></i>비밀글
                </label>
            </div>
        </div>
        <div class="form-line">
            <input type="text" class="form-basic required _filter" name="subject" placeholder="제목을 입력해 주세요" title="문의제목"/>
            <span class="feedback invalid" style="display: none;">유효성 메시지</span>
        </div>
        <div class="form-line">
            <textarea cols="30" rows="10" class="form-basic text-area required _filter" name="question"
                      placeholder="내용을 입력해주세요" title="내용"></textarea>
            <span class="feedback invalid" style="display: none;">유효성 메시지</span>
        </div>

        <div class="btn-wrap gap">
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="button" class="btn btn-default close-inquiry">취소</button>
        </div>
    </form>
    <div id="item-inquiry-list">

    </div>
</section>
