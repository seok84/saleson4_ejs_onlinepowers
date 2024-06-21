package saleson.domains.order.application;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContext;
import saleson.domains.cart.application.dto.CartListResponse;
import saleson.domains.common.api.dto.StatusResponse;
import saleson.domains.mypage.application.dto.info.ShippingItemPageResponse;
import saleson.domains.order.application.dto.BuyPaymentResponse;
import saleson.domains.order.application.dto.BuyRequest;
import saleson.domains.order.application.dto.BuyResponse;
import saleson.domains.order.application.dto.BuySetItemListResponse;
import saleson.domains.order.application.dto.PaymentResponse;
import saleson.domains.order.application.dto.ReceiverRequest;
import saleson.domains.order.application.dto.SaveResponse;
import saleson.domains.order.application.dto.UserDeliveryCriteria;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final SalesonApi salesonApi;

    public PaymentResponse getPaymentResponse(SalesonContext salesonContext){

        return salesonApi.post(salesonContext, "/api/order/payment-step", PaymentResponse.class);
    }

    public BuyResponse getCoupons (SalesonContext salesonContext) {
        return salesonApi.get(salesonContext, "/api/order/coupon/list", BuyResponse.class);
    }

    public BuySetItemListResponse getSetItemInfos (SalesonContext salesonContext, int itemId) {
        return salesonApi.get(salesonContext, "/api/order/set-item-info/" + itemId, BuySetItemListResponse.class);
    }


}
