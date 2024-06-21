package saleson.domains.qna.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QnaAnswerResponse {
	private String answer;
	private String title;
	private String date;
}
