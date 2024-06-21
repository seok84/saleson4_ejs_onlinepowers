package saleson.domains.brand.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BrandCriteria extends Criteria {
    private int brandId;
}
