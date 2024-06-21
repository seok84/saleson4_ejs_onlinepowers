package saleson.domains.mypage.application.dto.benefit;

import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
public class CouponCriteria extends Criteria {

    private boolean complete;
}
