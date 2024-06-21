package saleson.domains.mypage.application.dto.benefit;

import lombok.*;
import saleson.domains.item.application.dto.ItemPageResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CouponItemListResponse {

    private int couponId;

    private String couponName;

    private int totalCount;

    private ItemPageResponse pageContent;

}
