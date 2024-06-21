package saleson.domains.mypage.application.dto.benefit;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter @AllArgsConstructor @NoArgsConstructor
public class CouponResponse {

    private int couponId;

    private String couponType;

    private String couponTargetTimeType = "1";

    private String couponName;

    private String couponComment;

    private int couponPayRestriction = -1;

    private String couponPayType;

    private int couponPay;

    private String couponIssueType = "0";

    private String couponIssueStartDate;

    private String couponIssueEndDate;

    private String couponApplyType;

    private String couponApplyStartDate;

    private String couponApplyEndDate;

    private String couponUseDate;

    private String couponTargetItemType;
}
