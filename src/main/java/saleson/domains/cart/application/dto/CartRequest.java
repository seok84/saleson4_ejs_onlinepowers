package saleson.domains.cart.application.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartRequest {

    private int cartId;

    private long userId;

    private int itemId;

    private int quantity;

    private String[] arrayRequiredItems;

    private String[] arrayAdditionItems;

    private String shippingPaymentType;

    private List<Integer> itemIds;

    private String[] id;
}

