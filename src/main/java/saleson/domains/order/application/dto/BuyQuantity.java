package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BuyQuantity {
    private int shippingIndex;
    private int itemSequence;
    private int quantity;
}
