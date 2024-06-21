package saleson.domains.item.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ItemListCriteria extends Criteria {
    private String categoryCode;
}
