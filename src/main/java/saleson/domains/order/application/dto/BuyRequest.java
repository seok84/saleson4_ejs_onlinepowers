package saleson.domains.order.application.dto;

import java.util.HashMap;
import java.util.List;
import lombok.Getter;
import lombok.Setter;
import saleson.domains.mypage.application.dto.info.UserDeliveryResponse;

@Getter
@Setter
public class BuyRequest {

    HashMap<String, BuyPaymentRequest> buyPayments;

    private BuyerRequest buyer;

    private UserDeliveryRequest defaultUserDelivery;

    private String deviceType = "WEB";

    private String failUrl = "http://";

    private List<ReceiverRequest> receivers;

    private long userId;

    private int retentionPoint;

    private int shippingCoupon;

    private OrderPriceRequest orderPrice;

    private CashbillRequest cashbill;;

    private String defaultPaymentType;

    private List<String> useCouponKeys;

}
