package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.item.application.dto.ItemResponse;

@Getter
@Setter
@NoArgsConstructor
public class LatelyItemListResponse {

    List<ItemResponse> list;

    @Builder
    public LatelyItemListResponse(List<ItemResponse> list) {
        this.list = list;
    }
}
