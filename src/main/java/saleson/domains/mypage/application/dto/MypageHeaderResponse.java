package saleson.domains.mypage.application.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class MypageHeaderResponse {

    // 이름
    private String userName;

    // 등급
    private String levelName;

    // 포인트
    private int point;

    // 쿠폰
    private int couponCount;

    // 관심상품

}
