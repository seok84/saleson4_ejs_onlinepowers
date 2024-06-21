package saleson.domains.order.application.dto;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShippingRequest {

    private long sellerId;

    private String shippingGroupCode;

    private String shippingPaymentType;

    private String shipmentGroupCode;

    private String shippingType;

    private BuyItemRequest buyItemResponse;

    private List<BuyItemRequest> buyItemsResponse;

    private int shippingSequence;

    private int shipping;

    private int shippingExtraCharge1;

    private int shippingExtraCharge2;

    private int shippingReturn;

    private int shippingFreeAmount;

    private int shippingItemCount;

    private int addDeliveryCharge;

}
