package saleson.domains.qna.application.dto;

import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
public class QnaCriteria extends Criteria {
	private String searchStartDate;
	private String searchEndDate;
	private String qnaGroup;
}
