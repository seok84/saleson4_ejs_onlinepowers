package saleson.domains.order.application.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.mypage.application.dto.info.ShippingResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SellerShippingResponse {

    private Long sellerId;

    private List<ShippingResponse> shippings;

    private String sellerName;

    private int itemQuantity;

    private List<TotalPriceResponse> totalPrice;

}
