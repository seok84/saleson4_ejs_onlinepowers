package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderPriceRequest {
    private int totalItemPrice;

    private int totalItemDiscountAmount;

    private int totalSetDiscountAmount;

    private int totalItemSaleAmount;

    private int totalItemAmountBeforeDiscounts;

    private int totalItemPayAmount;

    private int totalShippingAmount;

    private int orderPayAmount;

    private int taxFreeAmount;

    private int totalDiscountAmount;

    private int totalEarnPoint;

    private int payAmount;

    private int orderPayAmountTotal;

    private int totalUserLevelDiscountAmount;

    private int totalShippingCouponDiscountAmount;


    private int totalItemCouponDiscountAmount;

    private int totalCartCouponDiscountAmount;

    private int totalPointDiscountAmount;

    private int totalShippingCouponUseCount;

}
