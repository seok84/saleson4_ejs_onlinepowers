const ReportHandler = {
    modal: {
        alert: '#report-modal-alert',
        detail: '#report-modal-detail',
        form: '#report-modal-form',
        formId: 'report-modal-form',
    },
    init: async () => {

        const $detail = $(ReportHandler.modal.detail);
        const $alert = $(ReportHandler.modal.alert);

        try {

            if ($alert.length > 0 && $detail.length > 0) {
                const $form = $detail.find(ReportHandler.modal.form);
                const response = await $saleson.api.get('/api/common/report/init');
                const $reasonWarp = $form.find('.radio-wrap');

                $reasonWarp.empty();
                let index = 0;
                for (const type of response.data.reasonTypes) {
                    const id = 'report-reason-' + index;
                    const html = `<label class="input-radio" for="${id}">
<input id="${id}" type="radio" name="reportReasonType" class="required" title="신고사유" value="${type.code}">
<i></i>${type.title}
</label>`;

                    $reasonWarp.append(html);

                    index++;
                }

                $detail.on('click', '.modal-close', function (e) {
                    e.preventDefault();
                    salesOnUI.modal().dismiss(ReportHandler.modal.detail);
                    resetForm($form);
                });
                $detail.on('click', '.close-report', function (e) {
                    e.preventDefault();
                    salesOnUI.modal().dismiss(ReportHandler.modal.detail);
                    resetForm($form);
                })

                $alert.on('click', '.modal-close', function (e) {
                    e.preventDefault();
                    salesOnUI.modal().dismiss(ReportHandler.modal.alert);
                    resetForm($form);
                })

                $alert.on('click', '.open-detail', function (e) {
                    e.preventDefault();
                    salesOnUI.modal().show(ReportHandler.modal.detail);
                    resetForm($form);
                });

                $form.validator(function () {
                    submitReport($saleson.core.formToJson(ReportHandler.modal.formId));
                    return false;
                });

                $alert.on('click', '.user-block.block', function (e) {

                    const param = {
                        reportContentType: $(this).data('type'),
                        contentId: $(this).data('id')
                    }
                    //현재창 닫기
                    $(this).closest(".alert-modal").removeClass("show");
                    $saleson.core.confirm(
                        '이 회원을 차단할까요?\n차단 후 이 회원이 작성한 모든 댓글이\n고객님에게 보이지 않으며,\n이후 해제할 수 있습니다',
                        () => {
                            block(param);
                        }
                    );

                });

                $alert.on('click', '.user-block.unblock', function (e) {
                    const param = {
                        reportContentType: $(this).data('type'),
                        contentId: $(this).data('id')
                    }

                    unblock(param);
                });

            }
        } catch (e) {
            console.error(e)
        }

        async function block(param) {
            try {
                const response = await $saleson.api.post('/api/common/block', param);
                location.reload();
            } catch (e) {
                $saleson.core.alert($saleson.api.getErrorMessage(e));
            }
        }

        async function unblock(param) {
            try {
                const response = await $saleson.api.post('/api/common/unblock', param);
                location.reload();
            } catch (e) {
                $saleson.core.alert($saleson.api.getErrorMessage(e));
            }
        }

        async function submitReport(param) {
            try {
                const response = await $saleson.api.post('/api/common/report', param);
                if (response.data.status === 200) {
                    $saleson.core.alert('등록되었습니다', () => {
                        $detail.find('.close-report').trigger('click');
                    });
                }
            } catch (e) {
                $saleson.core.alert($saleson.api.getErrorMessage(e));
            }

        }

        function resetForm($form) {
            $form.find('input[name=reportReasonType]').attr('checked', false);
            $form.find('textarea[name=content]').val('');

        }

    },
    report: (contentType = '', id = 0, blockFlag = false) => {
        if (!['QNA', 'FEATURED', 'REVIEW'].includes(contentType)) {
            return false;
        }

        if (!$saleson.auth.loggedIn()) {
            $saleson.core.confirm($saleson.const.message.LOGIN_MESSAGE, () => {
                const target = $saleson.core.requestContext.requestUri;
                $saleson.core.redirect($saleson.const.pages.LOGIN + '?target=' + target);
            })
            return false;
        }

        const $detail = $(ReportHandler.modal.detail);
        const $alert = $(ReportHandler.modal.alert);
        const $form = $detail.find(ReportHandler.modal.form);
        let blockClass = 'block';

        if (blockFlag) {
            blockClass = 'unblock';
        }

        $alert.find('.open-detail')
            .text(getReportLabel(contentType));

        $alert.find('.user-block')
            .text(getBlockLabel(blockFlag))
            .removeClass('block')
            .removeClass('unblock')
            .addClass(blockClass)
            .data('id', id)
            .data('type', contentType);

        $detail.find('.modal-header').text(getReportLabel(contentType));

        $form.find('input[name=reportContentType]').val(contentType);
        $form.find('input[name=contentId]').val(id);

        salesOnUI.modal().show(ReportHandler.modal.alert);

        function getReportLabel(contentType = '') {

            switch (contentType) {
                case 'REVIEW':
                    return '후기 신고';
                case 'QNA':
                    return '문의 신고';
                default:
                    return '댓글 신고';
            }
        }

        function getBlockLabel(blockFlag = false) {
            return blockFlag ? '회원 차단 해제' : '회원 차단';
        }

    },
    inquiry: (id = 0, blockFlag = false) => {
        ReportHandler.report('QNA', id, blockFlag);
    },
    featured: (id = 0, blockFlag = false) => {
        ReportHandler.report('FEATURED', id, blockFlag);
    },
    review: (id = 0, blockFlag = false) => {
        ReportHandler.report('REVIEW', id, blockFlag);
    },
}

$(() => {
    ReportHandler.init();
});