package saleson.domains.order.application.dto;

import java.util.HashMap;
import java.util.List;
import lombok.Getter;
import lombok.Setter;
import saleson.domains.mypage.application.dto.info.UserDeliveryResponse;

@Getter
@Setter
public class BuyResponse {

    private String orderCode;

    private long userId;

    private UserDeliveryResponse defaultUserDelivery;

    private List<ReceiverResponse> receivers;

    private HashMap<String, ShippingCoupon> useShippingCoupon;

    private int retentionPoint;

    private int shippingCoupon;

    private int orderPaymenAmount;

    private String[] notMixPayType = new String[]{"card", "vbank", "realtimebank", "payco", "bank", "escrow", "kakaopay", "naverpay"};

    private OrderPriceResponse orderPrice;

    private HashMap<String, BuyPaymentResponse> buyPayments;

    private String defaultPaymentType;

    private String sellerName;

    private BuyerResponse buyer;

    private Cashbill cashbill;

    private List<String> makeUseCouponKeys;

    private String deviceType;

    private int userTotalPoint;
}
