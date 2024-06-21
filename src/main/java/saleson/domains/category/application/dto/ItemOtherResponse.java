package saleson.domains.category.application.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.item.application.dto.ItemResponse;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class ItemOtherResponse {
    private int itemOtherId;
    private int itemId;
    private int otherItemId;
    private int counting;

    // 같이 주문한 상품정보
    private ItemResponse item;
}
