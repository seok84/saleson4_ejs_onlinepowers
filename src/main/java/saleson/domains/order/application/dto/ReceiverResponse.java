package saleson.domains.order.application.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReceiverResponse {

    private String receiveName;

    private String receivePhone;

    private String receiveMobile;

    private String receiveZipcode;

    private String receiveNewZipcode;

    private String receiveAddress;

    private String receiveAddressDetail;

    private String receiveSido;

    private String receiveSigungu;

    private String receiveEupmyeondong;

    private List<SellerShippingResponse> sellerShipping;

    private List<BuyItemResponse> buyItems;

    private long totalShippingCount;

    private String content;

    private List<BuyQuantityResponse> buyQuantitys;

    private int shippingIndex;
}
