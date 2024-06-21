<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>

    <div class="featured featured-pages">
        <h1 class="title-h1">이벤트</h1>
        <section class="container event-wrap">
            <!-- 타이틀 -->
            <div class="title-wrap">
                <p>
                    <c:if test="${not empty featured.dateText}">
                        <span class="date">[ ${featured.dateText} ]</span>
                    </c:if>

                    <strong class="title">${featured.title}</strong>
                </p>
                <button type="button" class="link-copy"></button>
            </div>
            <!-- 에디터 영역 -->
            <div class="content">
                    ${featured.content}
            </div>
            <!-- 내부 분류 셀렉트 -->
            <c:if test="${not empty featured.itemLists}">

                <c:forEach var="itemList" items="${featured.itemLists}">
                    <c:if test="${featured.prodState == '3'}">
                        <p class="event-category-title" id="list-${itemList.key}">${itemList.name}</p>
                    </c:if>
                    <c:set var="itemList" value="${itemList.items}" scope="request"/>

                    <c:set var="itemListName" value="${featured.title}" scope="request"/>
                    <c:set var="itemListId" value="${featured.title}" scope="request"/>
                    <c:set var="itemListAnalyticsFlag" value="true" scope="request"/>


                    <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>
                </c:forEach>

            </c:if>

        </section>
        <c:if test="${featured.replyUsedFlag}">
            <div class="reply-writing">
                <div class="container">
                    <form id="reply-form">
                        <h3 class="form-title">이벤트 참여 댓글쓰기</h3>
                        <div class="form-line">
                            <textarea name="content" id="" cols="30" rows="10" class="form-basic text-area"
                                      placeholder="내용을 입력해주세요" title="내용"></textarea>
                        </div>
                        <div class="link-wrap">
                            <button type="submit" class="btn btn-primary link-item w-half">등록</button>
                            <button type="reset" class="btn btn-default link-item w-half">취소</button>
                        </div>
                    </form>
                </div>
            </div>
            <section id="replay-area" class="container reply-wrap">

            </section>
        </c:if>
    </div>

    <page:model>
        <c:if test="${featured.replyUsedFlag}">
            <jsp:include page="/WEB-INF/views/include/modal/report.jsp"/>
        </c:if>
    </page:model>

    <page:javascript>

        <script src="/static/content/modules/ui/item/list.js"></script>
        <script>
            $(function () {
                salesOnUI.selectBox();
                $('.link-copy').on('click', function (e) {

                    const eventView = '${featured.eventViewUrl}';

                    if (eventView != '') {
                        $saleson.handler.copyText(eventView);
                    } else {
                        $saleson.handler.copyText($saleson.core.requestContext.href);
                    }
                });
            });

            $(() => {
                try {
                    $saleson.analytics.view('${featured.title}');
                } catch (e) {}

                try {

                    const itemUserCodes = [];
                    <c:if test="${not empty featured.itemLists}">
                        <c:forEach var="itemList" items="${featured.itemLists}">
                            <c:forEach var="item" items="${itemList.items}" varStatus="i">
                                itemUserCodes.push('${item.itemUserCode}');
                            </c:forEach>
                        </c:forEach>
                    </c:if>

                    if (itemUserCodes.length > 0) {
                        $saleson.ev.log.featured(itemUserCodes);
                    }

                } catch (e) {}
            });


        </script>
        <c:if test="${featured.replyUsedFlag}">
            <script src="/static/content/modules/ui/modal/report.js"></script>
            <script>

                const FEATURED_ID = Number('${featured.id}');
                const $replyForm = $('#reply-form');
                const $replayArea = $('#replay-area');

                function paginationFeaturedReply(page) {

                    const param = {
                        page: page,
                        size: 10,
                        featuredId: FEATURED_ID
                    }

                    $replayArea.empty();

                    $.get('/featured/replies', param, function (response) {
                        $replayArea.append(response);
                    }, 'html');
                }

                async function saveReply(content) {

                    try {

                        if (!$saleson.auth.loggedIn()) {
                            $saleson.core.confirm($saleson.const.message.LOGIN_MESSAGE, () => {
                                const target = $saleson.core.requestContext.requestUri;
                                $saleson.core.redirect($saleson.const.pages.LOGIN + '?target=' + target);
                            })
                            return false;
                        }

                        const params = {
                            featuredId: FEATURED_ID,
                            replyContent: content
                        }

                        await $saleson.api.post('/api/event/reply', params);
                        $replyForm.find('textarea[name=content]').val('');

                        paginationFeaturedReply(1);


                    } catch (e) {
                        $saleson.core.alert('댓글 등록시 오류가 발생했습니다.')
                    }
                }

                $(function () {
                    paginationFeaturedReply(1);

                    $replyForm.validator(function () {
                        const content = $replyForm.find('textarea[name=content]').val();

                        if (content == '') {
                            $saleson.core.alert('내용을 입력해주세요');
                            return false;
                        }

                        if (!$saleson.auth.loggedIn()) {
                            $saleson.core.confirm($saleson.const.message.LOGIN_MESSAGE, () => {
                                const target = $saleson.core.requestContext.requestUri;
                                $saleson.core.redirect($saleson.const.pages.LOGIN + '?target=' + target);
                            })
                            return false;
                        }

                        $saleson.core.confirm('댓글을 등록 하겠습니까?', () => {
                            saveReply(content);
                        });

                        return false;
                    });

                    $replayArea.on('click', '.reply-report-btn', function () {
                        const data = $(this).data();
                        ReportHandler.featured(data.id, data.blockFlag);
                    });
                });


            </script>
        </c:if>

    </page:javascript>
</layout:default>