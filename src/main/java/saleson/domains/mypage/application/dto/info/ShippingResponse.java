package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.order.application.dto.BuyItemResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ShippingResponse {
    private int userDeliveryId;
    private long userId;
    private String title;
    private String userName;
    private String phone;
    private String mobile;

    private String zipcode;

    private String address;
    private String addressDetail;
    private String createdDate;

    private long sellerId;
    private String shippingGroupCode;
    private int payShipping;
    private boolean isSingleShipping;
    private String shippingPaymentType;
    private String content;
    private String shipmentGroupCode;

    private String shippingType;
    private BuyItemResponse buyItem;
    private List<BuyItemResponse> buyItems;
    private int shippingSequence;
    private int discountShipping;
    private int shipping;
    private int shippingExtraCharge1;
    private int shippingExtraCharge2;
    private int shippingReturn;
    private int shippingFreeAmount;
    private int shippingItemCount;
    private int realShipping;
    private int addDeliveryCharge;
    private int remittanceAmount;

    private String shippingTypeLabel;

    private String shippingTypeMessage;

}
