package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.order.application.dto.OrderPriceResponse;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailResponse {

    private String orderCode;
    private int orderSequence;
    private String createdDate;

    private String userName;

    private String mobile;
    private String email;

    private int totalItemAmount;

    private int totalShippingAmount;

    private int totalDiscountAmount;
    private int totalItemDiscountAmount;

    private int totalSetDiscountAmount;

    private int totalCouponDiscountAmount;

    private int totalUserLevelDiscountAmount;

    private int totalOrderAmount;

    private int retentionPoint;
    private int orderUsePoint;

    private OrderPriceResponse orderPrice;

    private ShippingInfo shippingInfo;

    private List<OrderItemResponse> item;

    private PaymentInfo paymentInfo;

    private List<PaymentInfo> paymentList;

    private String nicepayReceipt;
}
