package saleson.domains.mypage.application.dto.info;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReviewRequest {

	private String orderCode;

	private int orderSequence;

	private int itemSequence;

	private String itemUserCode;

}
