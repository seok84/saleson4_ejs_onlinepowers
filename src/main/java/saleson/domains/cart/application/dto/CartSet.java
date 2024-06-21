package saleson.domains.cart.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartSet {

    private int itemId;

    private int quantity;

    private String[] arrayItemSets;
}
