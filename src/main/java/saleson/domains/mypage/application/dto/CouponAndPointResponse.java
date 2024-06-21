package saleson.domains.mypage.application.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CouponAndPointResponse {

    private int point;

    private int couponCount;

    private int shippingCouponCount;

}
