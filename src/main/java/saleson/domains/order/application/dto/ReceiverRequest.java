package saleson.domains.order.application.dto;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReceiverRequest {

    private List<BuyQuantity> buyQuantitys;

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

    private String content;

    List<SellerShippingRequest> shippingRequest;

    List<BuyItemRequest> items;



}
