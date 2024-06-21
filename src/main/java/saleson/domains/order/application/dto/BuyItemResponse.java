package saleson.domains.order.application.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.item.application.dto.GiftItemInfoResponse;
import saleson.domains.item.application.dto.ItemDetailResponse;
import saleson.domains.item.application.dto.ItemOptionResponse;
import saleson.domains.item.application.dto.ItemResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BuyItemResponse {

    private long sellerId;

    private String sellerName;

    private int itemSequence;

    private int itemId;

    private String itemCode;

    private String itemUserCode;


    private String itemName;

    private String brand;

    private String options;

    private ItemPriceResponse itemPrice;

    private String freeGiftName;

    private String freeGiftItemText;

    private List<GiftItemInfoResponse> freeGiftItemList;

    private PointPolicyResponse pointPolicy;

    private String deliveryType;

    private int deliveryCompanyId;

    private String deliveryCompanyName;

    private String deliveryNumber;

    private String islandType;

    private String setItemFlag = "N";

    private int parentItemId;

    private int parentItemSequence;

    private int setItemSequence;

    private List<OrderCouponResponse> itemCoupons;

    private List<OrderCouponResponse> addItemCoupons;

    private UserLevelResponse userLevelResponse;

    private ItemDetailResponse itemDetailResponse;

    private OrderQuantity orderQuantity;

    private List<BuyItemResponse> itemSetResponses;

    private int cartId;
}
