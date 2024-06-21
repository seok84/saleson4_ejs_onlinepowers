package saleson.domains.order.application.dto;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BuyItemRequest {

    private long userId;

    private long sellerId;

    private String sellerName;

    private int itemSequence;

    private String itemCode;

    private List<OrderCouponRequest> itemCoupons;

    private int itemId;

    private String itemUserCode;

    private String itemName;

    private String brand;

    private String deliveryType;

    private int deliveryCompanyId;

    private String additionItemFlag;

    private String availableForSaleFlag= "Y";

    private String options;

    private PointPolicyRequest pointPolicy;

    private String setItemFlag = "N";

    private String shippingPaymentType = "1";

}
