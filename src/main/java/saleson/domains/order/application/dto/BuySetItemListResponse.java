package saleson.domains.order.application.dto;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BuySetItemListResponse {
    List<BuyItemResponse> buyItems;
}
