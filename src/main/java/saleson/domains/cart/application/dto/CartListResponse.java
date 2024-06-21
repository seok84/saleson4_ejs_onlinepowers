package saleson.domains.cart.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.order.application.dto.OrderPriceResponse;
import saleson.domains.order.application.dto.ReceiverResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartListResponse {

    private ReceiverResponse receivers;

    private OrderPriceResponse orderPrice;

    private boolean isDisplayNaverPayFlag;

}
