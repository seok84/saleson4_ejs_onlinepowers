package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShippingCoupon {

    private String orderCode;
    private long userId;
    private String shippingGroupCode;
    private int useCouponCount;
    private int discountAmount;
    private String useFlag;

}
