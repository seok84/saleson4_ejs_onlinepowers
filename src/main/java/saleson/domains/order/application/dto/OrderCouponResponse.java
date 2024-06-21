package saleson.domains.order.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderCouponResponse {

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

    private int couponDiscountLimitPrice;

    private String couponTargetItemType;

    private String dataStatusCode;
}
