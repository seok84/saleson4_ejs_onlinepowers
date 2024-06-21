<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>
    <section class="customer customer-inquiry">
        <div class="title-h1">고객센터</div>

        <c:set var="activeType" value="inquiry" scope="request"/>
        <jsp:include page="include/tab.jsp"/>

        <div class="container">
            <div class="sort-wrap">
                <span class="all-items">
                    전체 <strong><fmt:formatNumber value="${pageContent.pagination.totalElements}"
                                                pattern="#,###"/></strong>개
                </span>
                <button type="button" class="switch-details">1:1문의</button>
            </div>
            <!-- 1:1 문의 form -->
            <div class="inquiry-form hidden">
                <form id="inquiryForm">
                    <div class="select-wrap">
                        <select class="input-select" name="qnaGroup" title="문의 유형">
                            <option value="">문의 유형을 선택하세요</option>
                            <c:forEach var="type" items="${pageContent.qnaGroups}">
                                <option value="${type.id}">${type.label}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-line">
                        <input type="text" class="form-basic required _filter" name="subject" placeholder="제목을 입력해주세요"
                               title="제목"/>
                        <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                    </div>

                    <div class="form-line">
                        <textarea cols="30" rows="10" class="form-basic text-area required _filter" name="question"
                                  placeholder="내용을 입력해주세요" title="내용"></textarea>
                        <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                    </div>

                    <div class="form-line">
                        <div class="upload-wrap">
                            <label for="upload-file" class="btn btn-default-line">
                                <input type="file" name="upload-file" id="upload-file" accept=".gif,.png,.jpg,.jpeg"
                                       multiple>
                                <span>파일선택</span>
                            </label>
                            <p class="file-placeholder">선택된 파일 없음</p>
                            <div class="upload-preview hide"></div>
                        </div>
                        <ul class="dot-list large-dot">
                            <li>5MB 이내의 jpg, gif, png 파일만 업로드 가능합니다.</li>
                            <li>5MB 이하의 사진 4장까지 첨부 가능</li>
                        </ul>
                    </div>
                    <ul class="photo-list" id="upload-file-area">
                    </ul>
                    <div class="link-wrap gap">
                        <button type="submit" class="btn btn-primary link-item w-half">등록</button>
                        <button type="button" class="btn btn-default link-item w-half cancel-inquiry">취소</button>
                    </div>
                </form>
            </div>
            <!-- 문의 목록 -->
            <c:choose>
                <c:when test="${not empty pageContent.content}">
                    <ul class="inquiry-content">
                        <c:forEach var="inquiry" items="${pageContent.content}">
                            <c:set var="inquiry" value="${inquiry}" scope="request"/>
                            <c:set var="displayDeliveryUtilFlag" value="true" scope="request"/>
                            <li>
                                <jsp:include page="/WEB-INF/views/include/inquiry/inquiry.jsp"/>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <div class="no-contents">
                        <img src="/static/content/image/common/img_noQna.png" alt="게시글 없음">
                        <p>1:1문의가 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <page:pagination/>
        </div>
    </section>

    <page:javascript>
        <script src="/static/content/modules/ui/modal/image-view.js"></script>
        <script>
            $(function () {

                let IMAGE_FILES = [];
                const FILE_LIMIT = 4;

                $('.switch-details').on('click', function (e) {
                    e.preventDefault();
                    resetForm();
                    $('.inquiry-form').toggleClass('hidden');
                })

                $('.photo-list').on('click', '.photo-item', function (e) {
                    e.preventDefault();
                    const $list = $(this).closest('.photo-list');
                    const $imgs = $list.find('img');
                    const files = [];

                    $imgs.each(function (idx) {
                        files.push($imgs.eq(idx).attr('src'));
                    });

                    ImageViewHandler.open(files, $(this).index())
                });

                const $form = $('#inquiryForm');

                async function submitAction() {
                    try {
                        const formData = new FormData($form[0]);
                        const files = IMAGE_FILES;

                        if (files.length > 0) {
                            for (const file of files) {
                                formData.append('files', file);
                            }
                        }


                        await $saleson.api.post('/api/qna/inquiry', formData);

                        $saleson.core.alert('등록되었습니다.', () => {
                            location.reload();
                        });

                    } catch (e) {
                        $saleson.core.alert('1:1문의 등록시 오류가 발생했습니다.');
                    }
                }

                $form.validator(function () {
                    $saleson.core.confirm('1:1문의를 등록하시겠습니까?', () => {
                        submitAction();
                    });

                    return false;
                });

                $form.on('click', '.cancel-inquiry', function (e) {
                    e.preventDefault();
                    resetForm();
                    $('.inquiry-form').addClass('hidden');
                });

                $form.on('change', 'input[name=upload-file]', function (e) {
                    const files = e.target.files;

                    if ($saleson.handler.validFiles(files, ['gif', 'png', 'jpg', 'jpeg'], 5)) {
                        if ((IMAGE_FILES.length + files.length) > FILE_LIMIT) {
                            $saleson.core.alert(FILE_LIMIT + '개 파일만 첨부가 됩니다.');
                            return false;
                        }

                        for (const file of files) {

                            try {
                                let reader = new FileReader();
                                const template = $('#upload-file-template').html();

                                reader.onload = function (ie) {
                                    $('#upload-file-area').append(template.replace('{{src}}', ie.target.result));
                                };

                                IMAGE_FILES.push(file);
                                reader.readAsDataURL(file);
                            } catch (e) {

                            }


                        }
                    }
                });

                $('#upload-file-area').on('click', '.btn-delete', function () {
                    const $photo = $(this).closest('.photo-item');
                    const index = $photo.index();

                    IMAGE_FILES.splice(index, 1);
                    $photo.remove();

                });

                function resetForm() {
                    $form.find('input').val('');
                    $form.find('select').val('');
                    $form.find('textarea').val('');
                    IMAGE_FILES = [];
                }

                $('.delete-inquiry').on('click', function (e) {
                    e.preventDefault();
                    const id = $(this).data('id');

                    $saleson.core.confirm('1:1문의를 삭제 하시겠습니까?', function () {
                        $saleson.api.post('/api/qna/delete-inquiry/' + id)
                            .then(function (response) {
                                if (response.status === 200) {
                                    $saleson.core.alert("삭제 되었습니다.", function () {
                                        location.reload();
                                    });
                                }
                            })
                            .catch(function (error) {
                                $saleson.core.api.handleApiExeption(error);
                            });
                    });
                });
            });

        </script>
        <script id="upload-file-template" type="text/html">
            <li class="photo-item">
                <img src="{{src}}" alt="fileName" class="thumbnail" onerror="errorImage(this)">
                <button type="button" class="btn-delete"></button>
            </li>
        </script>

    </page:javascript>

    <page:model>
        <jsp:include page="/WEB-INF/views/include/modal/image-view.jsp"/>
    </page:model>
</layout:default>
