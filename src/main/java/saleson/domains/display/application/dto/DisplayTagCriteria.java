package saleson.domains.display.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DisplayTagCriteria extends Criteria {
    private String tag;

    private String dataStatusCode;
}
