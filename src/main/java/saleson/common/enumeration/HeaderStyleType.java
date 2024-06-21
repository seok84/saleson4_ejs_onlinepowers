package saleson.common.enumeration;

public enum HeaderStyleType {

    /**
     * 브랜드 + 검색 + 장바구니 + Quick Link, eg) 메인, 상품리스트
     */
    DEFAULT,

    /**
     * 뒤로가기 + 브랜드 + 검색 + 장바구니, eg) 검색결과
     */
    SEARCH,

    /**
     * 뒤로가기 + 타이틀 + 장바구니, eg) 장바구니, 주문/결제, 마이페이지, 고객센터, 회원가입, 로그인
     */
    DETAIL,

    /**
     * 뒤로가기 + 브랜드 + 검색 + 장바구니, GNB(X) eg) 상품상세
     */
    ITEM_DETAIL
}
