package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.CodeResponse;

@Getter
@Setter
@Builder
@AllArgsConstructor
public class ExchangeApplyInfoResponse {

	private List<DeliveryCompany> deliveryCompanyList;
	private List<CodeResponse> claimReasons;
	private ExchangeApplyResponse exchangeApply;
	
}
