package saleson.domains.featured.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FeaturedRepliesCriteria extends Criteria {
	private int featuredId;
}
