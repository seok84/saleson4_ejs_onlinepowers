package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderCouponRequest {

    private int discountPrice;

    private int discountAmount;

    private int couponUserId;

    private long userId;

    private String couponName;

    private String couponComment;

    private int couponPayRestriction;

    private String couponConcurrently;

    private String couponPayType;

    private int couponPay;

    private String dataStatusCode;
}
