package saleson.domains.order.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserLevelResponse {
    private int levelId;
    private String groupCode;
    private int depth;
    private String levelName;
    private String fileSrc;
    private int priceStart;
    private int priceEnd;

    private float discountRate;
    private float pointRate;
    private int shippingCouponCount;

    private int retentionPeriod;
    private int referencePeriod;
}