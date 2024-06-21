package saleson.domains.mypage.application;

import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.context.SalesonContext;
import saleson.domains.common.api.dto.BankInfoListResponse;
import saleson.domains.mypage.application.dto.info.ClaimApplyInfoResponse;
import saleson.domains.mypage.application.dto.info.ExchangeApplyInfoResponse;
import saleson.domains.mypage.application.dto.info.LatelyItemCriteria;
import saleson.domains.mypage.application.dto.info.LatelyItemListResponse;
import saleson.domains.mypage.application.dto.info.OrderCriteria;
import saleson.domains.mypage.application.dto.info.OrderDetailResponse;
import saleson.domains.mypage.application.dto.info.OrderPageResponse;
import saleson.domains.mypage.application.dto.info.OrderRequest;
import saleson.domains.mypage.application.dto.info.ReturnApplyInfoResponse;
import saleson.domains.mypage.application.dto.info.ShippingItemPageResponse;
import saleson.domains.mypage.application.dto.info.WishListPageResponse;

@Service
@RequiredArgsConstructor
@Slf4j
public class MypageInfoService {

    private final SalesonApi salesonApi;
    private final AsyncDataService asyncDataService;

    // 주문/배송조회
    public OrderPageResponse getOrder(SalesonContext salesonContext, OrderCriteria orderCriteria) throws Exception {

        OrderPageResponse orderPageResponse = salesonApi.get(salesonContext, "/api/order", salesonApi.convert(orderCriteria), OrderPageResponse.class);
        return orderPageResponse;

    }

    // 주문상세 조회
    public OrderDetailResponse getOrderDetail(SalesonContext salesonContext, String orderCode) throws Exception {

        Map<String, String> params = new HashMap<>();
        params.put("orderCode", orderCode);

        OrderDetailResponse orderDetailResponse = salesonApi.get(salesonContext, "/api/order/detail", params, OrderDetailResponse.class);
        return orderDetailResponse;

    }

    // 취소/교환/반품 목록조회
    public String getClaim(SalesonContext salesonContext) throws Exception {
        return "";
    }

    // 관심상품
    public WishListPageResponse getWishlist(SalesonContext salesonContext, Criteria criteria) throws Exception {
        WishListPageResponse wishListPageResponse = salesonApi.get(salesonContext, "/api/wishlist", salesonApi.convert(criteria), WishListPageResponse.class);
        return wishListPageResponse;
    }

    // 최근 본 상품
    public LatelyItemListResponse getRecentItem(SalesonContext salesonContext, LatelyItemCriteria latelyItemCriteria) throws Exception {
        LatelyItemListResponse latelyItemListResponse = salesonApi.get(salesonContext, "/api/display/lately", salesonApi.convert(latelyItemCriteria), LatelyItemListResponse.class);
        return latelyItemListResponse;
    }

    // 배송주소록 관리
    public ShippingItemPageResponse getDelivery(SalesonContext salesonContext) throws Exception {

        ShippingItemPageResponse shippingItemPageResponse = salesonApi.get(salesonContext, "/api/shipping", ShippingItemPageResponse.class);
        return shippingItemPageResponse;

    }

    // 교환신청 팝업정보
    public ExchangeApplyInfoResponse getExchangePopup(SalesonContext salesonContext, OrderRequest orderRequest) throws Exception {
        ExchangeApplyInfoResponse exchangeApplyInfoResponse = salesonApi.get(salesonContext, "/api/order/exchange-apply", getClaimParam(orderRequest), ExchangeApplyInfoResponse.class);
        return exchangeApplyInfoResponse;
    }

    // 반품신청 팝업정보
    public void getReturnPopup(HttpServletRequest request, Model model, OrderRequest orderRequest) throws Exception {
        asyncDataService.setModelBy(request, model,
            new AsyncDataRequest<>("content", "/api/order/return-apply", HttpMethod.GET, ReturnApplyInfoResponse.class, getClaimParam(orderRequest)),
            new AsyncDataRequest<>("banks", "/api/common/bank-info", HttpMethod.GET, BankInfoListResponse.class, null)
        );
    }

    // 취소신청 팝업정보
    public ClaimApplyInfoResponse getCancelPopup(SalesonContext salesonContext, OrderRequest orderRequest) throws Exception {
        ClaimApplyInfoResponse claimApplyInfoResponse = salesonApi.get(salesonContext, "/api/order/cancel-apply", getClaimParam(orderRequest), ClaimApplyInfoResponse.class);
        return claimApplyInfoResponse;
    }

    public void getCancelPopup(HttpServletRequest request, Model model, OrderRequest orderRequest) throws Exception {
        asyncDataService.setModelBy(request, model,
            new AsyncDataRequest<>("content", "/api/order/cancel-apply", HttpMethod.GET, ClaimApplyInfoResponse.class, getClaimParam(orderRequest)),
            new AsyncDataRequest<>("banks", "/api/common/bank-info", HttpMethod.GET, BankInfoListResponse.class, null)
        );
    }

    private Map<String, Object> getClaimParam(OrderRequest orderRequest){
        Map<String, Object> map = new HashMap<>();
        map.putAll(Map.of("orderCode", orderRequest.getOrderCode(), "orderSequence", orderRequest.getOrderSequence(), "itemSequence", orderRequest.getItemSequence()));
        return map;
    }
}
