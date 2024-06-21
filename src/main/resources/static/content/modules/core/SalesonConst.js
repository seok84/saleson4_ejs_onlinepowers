export default {
    pages: {
        INDEX: "/",
        LOGIN: "/user/login",
        FIND_ID_PW: "/user/find-idpw",
        JOIN: "/user/join",
        JOIN_COMPLETE: "/user/join-complete",
        SLEEP_USER: "/user/sleep-user",
        EXPIRED_PASSWORD: "/user/expired-password",
        TEMP_PASSWORD: "/user/change-password",
        MYPAGE_ORDER: "/mypage/order",
    },

    config: {
        noImage: '/static/content/image/common/no_content.png',
        loadingImage: '/static/images/loadingpage.gif'
    },
    const: {
        SALESON_ID: 'salesonId',
        TOKEN: 'token',
        TOKEN_STATUS: 'tokenStatus',
        TOKEN_TYPE: 'tokenType',
        CATEGORY: 'category',
        CATEGORY_UPDATED_DATE: 'categoryUpdatedDate',
        SAVED_LOGIN_ID: 'savedLoginId',
        CAMPAIGN_CODE: 'campaignCode',
        VISIT: 'visit',
        VISIT_EXPIRE_DATE: 'visitExpireDate',
        LATELY_ITEM: 'latelyItem',
        LATELY_SEARCH: 'latelySearch',
        BUY_ORDER: 'buyOrder',
        KAKAO_SHARE_INIT_FLAG: 'kakaoShareInitFlag',
        GNB_MENU_TARGET: 'gnbMenuTarget',
        SNS_PAGE_TYPE: 'snsPageType'
    },
    cookie: {
        TOKEN:'saleson.token',
        SALESON_ID:'saleson.salesonId',
        LOGGED_IN:'saleson.loggedIn',
        API:'saleson.api',
    },
    message: {
        LOGIN_MESSAGE:'로그인 하셔야 본 서비스를\n이용하실 수 있습니다.\n로그인 페이지로 이동하시겠습니까?',
        ADD_TO_WISHLIST_MESSAGE:'해당상품이 관심상품에 저장되었습니다.',
        REMOVE_TO_WISHLIST_MESSAGE:'해당상품이 관심상품에서 삭제되었습니다.',
    }
}