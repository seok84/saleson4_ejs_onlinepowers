package saleson.domains.order.application.dto;

import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TotalPriceResponse {
    private BigDecimal groupTotalItemSalePrice;

    private BigDecimal groupTotalShippingPrice;

    private BigDecimal groupTotalPrice;
}
