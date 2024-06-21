package saleson.domains.mypage.application.dto.info;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemResponse {

    private Integer itemId;

    private String itemUserCode;

    private String imageSrc;

    private String itemName;

    private String options;

    private int optionId;

    private int quantity;

    private int claimQuantity;

    private int itemAmount;

    private int salePrice;

    private String orderStatus;

    private String orderStatusLabel;

    private String claimApplyFlag;

    private String claimApplyItemKey;

    private int claimApplyQuantity;

    private String claimRefusalReasonText;

    private String deliveryCompanyName;

    private int deliveryCompanyId;

    private String deliveryCompanyUrl;

    private String deliveryNumber;

    private String brand;

    private String confirmDate;

    private int orderSequence;

    private int itemSequence;

    private int shippingSequence;

    private int realShipping;

    private int shipping;

    private boolean singleShipping;

    private int shippingExtraCharge1;

    private int shippingExtraCharge2;

    private String shippingType;

    private int shippingFreeAmount;

    private String itemReturnFlag;

    private String setItemFlag = "N";

    private String setDiscountType;

    private int setDiscountAmount;
    private boolean writeReviewFlag;

}
