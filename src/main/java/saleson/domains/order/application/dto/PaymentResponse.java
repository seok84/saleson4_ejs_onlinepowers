package saleson.domains.order.application.dto;

import java.util.List;
import java.util.Map;
import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.CodeResponse;
import saleson.domains.mypage.application.dto.info.UserDeliveryResponse;

@Getter
@Setter
public class PaymentResponse {

    private BuyResponse buy;

    private boolean useCoupon;

    private String userData;

    private Map<String, Object> config;

    private List<CodeResponse> cashbillTypes;

    private List<UserDeliveryResponse> userDeliveryList;

    private OrderPaymentResponse recentOrderPayment;

    private ConfigPgResponse configPg;
}
