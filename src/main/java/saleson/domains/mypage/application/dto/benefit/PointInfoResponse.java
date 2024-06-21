package saleson.domains.mypage.application.dto.benefit;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PointInfoResponse {

    private PointPageResponse pointPageResponse;
    private int userPoint;
    private int userShippingCount;
    private int expirationPointAmount;
    private int expirationShippingCouponCount;

    public PointInfoResponse getContent(){
        return PointInfoResponse.builder()
            .userPoint(getUserPoint())
            .userShippingCount(getUserShippingCount())
            .expirationPointAmount(getExpirationPointAmount())
            .expirationShippingCouponCount(getExpirationShippingCouponCount())
            .build();
    }
}
