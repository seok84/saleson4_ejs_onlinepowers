package saleson.domains.order.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderQuantity {

    private int itemId;

    private int maxQuantity;

    private int minQuantity;

    private boolean isSoldOutFlag;
}



