package saleson.domains.mypage.application.dto.benefit;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CouponInfoResponse {

    private CouponPageResponse couponPageResponse;
    private int completedUserCouponCount;
    private int availableCount;
    private int downloadAvailableCount;
}
