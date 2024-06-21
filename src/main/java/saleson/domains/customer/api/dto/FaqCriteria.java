package saleson.domains.customer.api.dto;

import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
public class FaqCriteria extends Criteria {

    private String faqType;
}
