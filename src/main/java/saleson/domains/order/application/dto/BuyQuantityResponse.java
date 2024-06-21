package saleson.domains.order.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BuyQuantityResponse {
    private int shippingIndex;
    private int itemSequence;
    private int quantity;
}
